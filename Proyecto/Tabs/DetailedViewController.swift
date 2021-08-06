//
//  DetailedViewController.swift
//  Proyecto
//
//  Created by MATEO  ALPUY on 28/7/21.
//

import UIKit
import Kingfisher
import Cosmos

class DetailedViewController: UIViewController,UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var Favorite2Label: UILabel!
    @IBOutlet weak var SimilarTableView: UITableView!
    @IBOutlet weak var RankingTab: CosmosView!
    @IBOutlet weak var FavoriteSwitch: UISwitch!
    @IBOutlet weak var OverviewText: UITextView!
    @IBOutlet weak var MovieImage: UIImageView!
    @IBOutlet weak var MovieTitleLabel: UILabel!
    var tappedCell = CategoryMovieTableViewCell()
    var movie :Movie!
    var movies = [Movie]()
    var favorites = [Movie]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.starImage.image =  UIImage(named:"star.png")
        if(self.favorites.count == 0 ){
            DispatchQueue.main.async {
                self.LoadGroup2()
                self.LoadGroup(movie_id: self.movie.id)
            }
            self.SimilarTableView.reloadData()
        }
        SimilarTableView.dataSource = self
        SimilarTableView.delegate = self
        self.starImage.isHidden = true
        self.FavoriteSwitch.isOn = false
        self.Favorite2Label.isHidden = false
        self.FavoriteSwitch.isHidden = false
        self.MovieTitleLabel.text = movie.title
        let path = self.movie.poster_path
        let url = "https://image.tmdb.org/t/p/w500"
        let url2 = URL(string: url + path!)
        self.MovieImage.kf.setImage(with: url2)
        self.releaseDate.text = self.movie.release_date
        self.RankingTab.rating = (self.movie.vote_average)/2
        let nib: UINib = UINib(nibName: "CategoryMovieTableViewCell", bundle: nil)
        SimilarTableView.register(nib, forCellReuseIdentifier: "CategoryMovieTableViewCell")
        self.OverviewText.text = self.movie.overview
        SetFavorites()
    }
    func SetFavorites(){
        for item2 in self.favorites {
            if (item2.id == self.movie.id){
                self.FavoriteSwitch.isOn = true
                self.FavoriteSwitch.isHidden = true
                self.starImage.isHidden = false
                self.Favorite2Label.isHidden = true
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryMovieTableViewCell", for: indexPath) as! CategoryMovieTableViewCell
        if let url2 = URL(string: "https://image.tmdb.org/t/p/w500" + self.movies[indexPath.row].poster_path) {
            cell.configure2(name: self.movies[indexPath.row].title,url: url2,ranking: self.movies[indexPath.row].vote_average)
        }
        return cell
    }
    
    @IBAction func valueChange(_ sender: UISwitch) {
        if(sender.isOn){
            LoadGroup3()
        }
    }
    
    func LoadGroup3(){
        APIClient.shared.requestItem(request: Router.setFavorite( movie_id: self.movie.id), responseKey: "", onCompletion:{(result:Result<SuccessPostModel,Error>)
            in
            switch (result){
            case .success(_):
                self.performSegue(withIdentifier: "favoritesegue", sender: self)
            case .failure(let error ): print(error)
            }
        })
    }
    
    func LoadGroup2(){
        APIClient.shared.requestItems(request: Router.getFavorites, responseKey: "results", onCompletion:{(result:Result<[Movie],Error>)
            in
            switch (result){
            case .success(let movie): self.favorites = movie ;
            case .failure(let error ): print(error)
            }
            self.viewDidLoad()
        })
    }
    
    func LoadGroup(movie_id:Int){
        APIClient.shared.requestItems(request: Router.getSimilars(movie_id: movie_id), responseKey: "results", onCompletion:{(result:Result<[Movie],Error>)
            in
            switch (result){
            case .success(let movie): self.movies = movie ;
            case .failure(let error ): print(error)
            }
            self.SimilarTableView.reloadData()
        })
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.movie = self.movies[indexPath.row]
        self.LoadGroup(movie_id: self.movie.id)
        self.viewDidLoad()
        self.SimilarTableView.reloadData()
    }
}

