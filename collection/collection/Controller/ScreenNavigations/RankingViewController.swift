//
//  RankingViewController.swift
//  collection
//
//  Created by Larissa Lanes on 09/10/23.
//

import UIKit

struct User {
    var image: String
    var name : String
    var email: String
    var porcent: Int
}

class RankingViewController: UIViewController {
    
    let tableView = UITableView()
    
    let usuarios = [
        User(image: "bbb1", name: "lari", email: "lari@gmail", porcent: 67),
        User(image: "bbb1", name: "stella", email: "lari@gmail", porcent: 10),
        User(image: "bbb1", name: "pam", email: "lari@gmail", porcent: 78),
        User(image: "bbb1", name: "larilari", email: "lari@gmail", porcent: 90),
        User(image: "bbb1", name: "ju", email: "lari@gmail", porcent: 34),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .backgroundPage
        
        view.addSubview(tableView)
        tableView.frame = view.bounds
        
        tableView.register(UINib(nibName: "RankingTableViewCell", bundle: nil), forCellReuseIdentifier: "RankingTableViewCell");        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension RankingViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usuarios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RankingTableViewCell", for: indexPath) as! RankingTableViewCell
        
        cell.configure(with: usuarios[indexPath.row])
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        140
    }
}

