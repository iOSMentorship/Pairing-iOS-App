//
//  secondVC.swift
//  Pairing
//
//  Created by Sagaya Abdulhafeez on 08/03/2017.
//  Copyright © 2017 Sagaya Abdulhafeez. All rights reserved.
//

import UIKit

class secondVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var allGroups =  [[String]]()
    
    let tableView: UITableView = {
       let table = UITableView()
        
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableCell.self, forCellReuseIdentifier: "tablecell")
        view.addSubview(tableView)
        
        view.addConstraintsWithFormat("H:|[v0]|", views: tableView)
        view.addConstraintsWithFormat("V:|[v0]|", views: tableView)
        tableView.tableFooterView = UIView()
        self.navigationController?.navigationBar.backItem?.title = ""
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print("Groups are \(allGroups.count)")
        print(allGroups[0].count)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return allGroups.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allGroups[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tablecell") as! TableCell
        cell.textLabel?.text = allGroups[indexPath.section][indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Group \(section + 1)"
    }
    
}

class TableCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
