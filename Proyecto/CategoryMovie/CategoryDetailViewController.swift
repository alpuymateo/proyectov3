//
//  CategoryDetailViewController.swift
//  Proyecto
//
//  Created by MATEO  ALPUY on 29/7/21.
//

import UIKit
import Kingfisher

class CategoryDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var CategoryTableView: UITableView!
    var genre = Int()
    var movies = [Movie]()
    var fetchMore = Bool()
    var pageNumber = 1
    var newmovies = [Movie]();
    var tappedCell = CategoryMovieTableViewCell()
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if(offsetY > contentHeight - scrollView.frame.height){
            if !fetchMore {
                self.beginFetch()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return self.movies.count
        } else if section == 1 && fetchMore{
            return 1
        }
        return 0
    }
    func beginFetch(){
        fetchMore = true
        CategoryTableView.reloadSections(IndexSet(integer: 1), with: .none)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute:{
            self.LoadGroup(genre: self.genre, page: self.pageNumber + 1)
            self.movies.append(contentsOf:  self.newmovies)
            self.fetchMore = false
            self.CategoryTableView.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryMovieTableViewCell", for: indexPath) as! CategoryMovieTableViewCell
            cell.configure(name: self.movies[indexPath.row].title)
            cell.RatingView.rating =  (self.movies[indexPath.row].vote_average)/2
            let path = self.movies[indexPath.row].poster_path
            let url = "https://image.tmdb.org/t/p/w500"
            let url2 = URL(string: url + path!)
            cell.MovieImage.kf.setImage(with: url2)
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingTableViewCell", for: indexPath) as! LoadingTableViewCell
            cell.LoadingIndicator.startAnimating()
            return cell
        }
        return UITableViewCell.init()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func LoadGroup(genre:Int, page: Int){
        APIClient.shared.requestItems(request: Router.getGenreWithPage(genreId: genre, page: page), responseKey: "results", onCompletion:{(result:Result<[Movie],Error>)
            in
            switch (result){
            case .success(let movie): self.newmovies = movie ;
            case .failure(let error ): print(error)
            }
        })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CategoryTableView.dataSource = self
        CategoryTableView.delegate = self
        let nib2: UINib = UINib(nibName: "LoadingTableViewCell", bundle: nil)
        let nib: UINib = UINib(nibName: "CategoryMovieTableViewCell", bundle: nil)
        CategoryTableView.register(nib, forCellReuseIdentifier: "CategoryMovieTableViewCell")
        CategoryTableView.register(nib2, forCellReuseIdentifier: "LoadingTableViewCell")
        DispatchQueue.main.asyncAfter(deadline: .now() , execute:{
            self.LoadGroup2(genre: self.genre)
        })
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsviewcontrollerseg2" {
            let DestViewController = segue.destination as! DetailedViewController
            DestViewController.movie = self.tappedCell.movie
        }
    }
    func LoadGroup2(genre:Int){
        APIClient.shared.requestItems(request: Router.getMoviesByGenre(genreId: genre), responseKey: "results", onCompletion:{(result:Result<[Movie],Error>)
            in
            switch (result){
            case .success(let movie): self.movies = movie ;
            case .failure(let error ): print(error)
            }
            self.CategoryTableView.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tappedCell.movie = self.movies[indexPath.row]
        performSegue(withIdentifier:"detailsviewcontrollerseg2", sender: nil)
        
    }
}

