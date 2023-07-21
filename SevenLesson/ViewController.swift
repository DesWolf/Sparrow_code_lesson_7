//
//  ViewController.swift
//  SevenLesson
//
//  Created by Максим Окунеев on 21.07.2023.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(tableView)
       
        tableView.frame = view.bounds
        
        let header = HeaderView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: view.frame.size.width,
                                              height: 270))
        tableView.tableHeaderView = header
        tableView.scrollIndicatorInsets = UIEdgeInsets(top: view.frame.size.width, left: 0, bottom: 0, right: 0)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        return cell
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let header = tableView.tableHeaderView as? HeaderView else {
            return
        }
        header.scrollViewDidScroll(scrollView: scrollView)
                
        let offsetY = -(scrollView.contentOffset.y + view.safeAreaInsets.top)
        let height = header.bounds.height + offsetY
        
        tableView.scrollIndicatorInsets = UIEdgeInsets(top: height, left: 0, bottom: 0, right: 0)
    }
}

