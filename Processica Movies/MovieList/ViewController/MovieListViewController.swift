//
//  ViewController.swift
//  Processica Movies
//
//  Created by Lasha Maruashvili on 29.11.21.
//

import UIKit
import ProgressHUD
import Core

class MovieListViewController: PViewController {
    
    @IBOutlet weak var moviesTableView: UITableView!
    
    var viewModel: MovieListViewModel!
    var movies: [MovieEntity] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.moviesTableView.reloadData()
            }
        }
    }
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
        ProgressHUD.show()
        viewModel.start()
    }
    
    private func setupUI() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        moviesTableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        ProgressHUD.show()
        viewModel.start()
    }
    
    private func bind() {
        // Error
        viewModel.errorPublisher.bind { error in
            guard let error = error else {return}
            guard error.errorType == .toBeShown else {
                print(error)
                return
            }
            ProgressHUD.showError(error.errorMessage)
        }
        // Data
        viewModel.moviesPublisher.bind { [weak self] movies in
            ProgressHUD.dismiss()
            self?.refreshControl.endRefreshing()
            self?.movies = movies
        }
    }
}

extension MovieListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCell", for: indexPath) as? MoviesTableViewCell else {
            fatalError("Cell Not found")
        }
        cell.configure(with: movies[indexPath.row])
        if indexPath.row == self.movies.count - 3 {
            ProgressHUD.show()
            viewModel.loadMore()
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = Controller.getMovieDetailsViewController()
        vc.movie = movies[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
