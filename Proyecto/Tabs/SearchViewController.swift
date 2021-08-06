//
//  SearchViewController.swift
//  Proyecto
//
//  Created by MATEO  ALPUY on 30/7/21.
//

import UIKit

class SearchViewController: UIViewController,UISearchBarDelegate,  UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var SearchTab: UISearchBar!
    @IBOutlet weak var TableView: UITableView!
    var timer = Timer()
    var resultSearchController = UISearchController()
    var movies2 = [Movie]()
    var movies = [Movie]()
    var filtered = [Movie]()
    var searchtypingtext = String()
    var tappedCell = CategoryMovieTableViewCell()
    override func viewDidLoad() {
        super.viewDidLoad()
        SearchTab.delegate = self
        TableView.dataSource = self
        TableView.delegate = self
        navigationItem.searchController = self.resultSearchController
        let nib: UINib = UINib(nibName: "CategoryMovieTableViewCell", bundle: nil)
        TableView.register(nib, forCellReuseIdentifier: "CategoryMovieTableViewCell")
        LoadAll()
    }
    func LoadAll(){
        DispatchQueue.main.asyncAfter(deadline: .now() , execute:{
            for i in 1...20 {
                self.LoadLetter(page: i)
            }
        })
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchdetailsegue" {
            let DestViewController = segue.destination as! DetailedViewController
            DestViewController.movie = self.tappedCell.movie
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.filtered.removeAll()
        self.filtered.append(contentsOf: self.movies)
        self.TableView.reloadData()
        
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.filtered.removeAll()
        self.filtered.append(contentsOf: self.movies)
        self.TableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tappedCell.movie = self.filtered[indexPath.row]
        performSegue(withIdentifier:"searchdetailsegue", sender: nil)
    }
    @objc func timerAction() {
        self.filtered.removeAll()
        DispatchQueue.main.asyncAfter(deadline: .now() , execute:{
            APIClient.shared.requestItems(request: Router.getByLetter(letters: self.searchtypingtext),responseKey: "results", onCompletion: {(result:Result<[Movie],Error>)
                in
                switch (result){
                case .success(let movie):  self.filtered = movie;
                    self.TableView.reloadData();
                case .failure(let error ): print(error)
                }
            })
        })
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchtypingtext = searchText
        if(searchText != ""){
            timer.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: false)
        }
        if(searchText == ""){
            self.filtered.removeAll()
            self.filtered.append(contentsOf: self.movies)
            self.TableView.reloadData()
        }
    }
    func LoadLetter(page: Int){
        APIClient.shared.requestItems(request: Router.getMovies(page: page),responseKey: "results", onCompletion: {(result:Result<[Movie],Error>)
            in
            switch (result){
            case .success(let movie): self.movies2 = movie
            case .failure(let error ): print(error)
            }
            self.movies.append(contentsOf: self.movies2)
            self.filtered.append(contentsOf: self.movies2)
            self.TableView.reloadData()
        })
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.filtered.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryMovieTableViewCell", for: indexPath) as! CategoryMovieTableViewCell
        if let path = self.filtered[indexPath.row].poster_path {
            let url2 = URL(string: "https://image.tmdb.org/t/p/w500" + path)
            cell.configure2(name: self.filtered[indexPath.row].title,url: url2!,ranking:       self.filtered[indexPath.row].vote_average)
        }
        return cell
    }
}
