//
//  ViewController.swift
//  Hw 8 m 3
//
//  Created by Рауль on 13/3/23.
//

import UIKit
import SnapKit

struct Friend {
    var image: UIImage
    var name, description: String
}

class ViewController: UIViewController {
    
    private let friends: [Friend] =  [
        .init(image: UIImage(named: "person")!, name: "Andrei", description: "ivanov"),
        .init(image: UIImage(named: "1")!, name: "Nurs", description: "ivanov"),
        .init(image: UIImage(named: "2")!, name: "Ivan", description: "ivanov"),
        .init(image: UIImage(named: "3")!, name: "KKK", description: "ivanov"),
        .init(image: UIImage(named: "4")!, name: "Aidar", description: "ivanov"),
    ]
    
    private var filteredFriends: [Friend] = []
    
    private var isFiltered = false
    
    private var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Avenir Next Bold", size: 30)
        view.text = "Find New Friends"
        view.textColor = .black
        return view
    }()
    
    private var searchFriendSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchTextField.placeholder = "Найди себе друзей"
        return searchBar
    }()
        
    private var friendsTableView = UITableView()
    
    private func configTableView() {
        friendsTableView.delegate = self
        friendsTableView.dataSource = self
        friendsTableView.register(CustomCell.self, forCellReuseIdentifier: "friend_cell")
    }
    
    private func setupSubviews () {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        view.addSubview(searchFriendSearchBar)
        searchFriendSearchBar.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        view.addSubview(friendsTableView)
        friendsTableView.snp.makeConstraints { make in
            make.top.equalTo(searchFriendSearchBar.snp.bottom).offset(50)
            make.left.right.bottom.equalToSuperview()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        setupSubviews()
        searchFriendSearchBar.delegate = self
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltered ? filteredFriends.count : friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = friendsTableView.dequeueReusableCell(withIdentifier: "friend_cell", for: indexPath) as! CustomCell
        let friend = isFiltered ? filteredFriends[indexPath.row] : friends[indexPath.row]
        cell.displayCell(with: friend)
        return cell
    }
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isFiltered = false
        } else {
            isFiltered = true
            filteredFriends = friends.filter { friend in
                friend.name.contains(searchText)
            }
        }
        
        friendsTableView.reloadData()
    }
}
