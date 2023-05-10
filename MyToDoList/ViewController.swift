//
//  ViewController.swift
//  MyToDoList
//
//  Created by Михаил Чертов on 10.05.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tasks = [String]()
    
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTask))
        title = "My Tasks"
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        //createAlert()
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func createAlert() {
        let alertController = UIAlertController(title: "New Task",
                                                message: "write & add new Task",
                                                preferredStyle: .alert)
        alertController.addTextField()
        //MARK:- Create Button
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        let doneButton = UIAlertAction(title: "Done", style: .default) { [weak self] _ in
            
            guard let taskText = alertController.textFields?.first else { return }
            guard let textField = taskText.text else { return }
            
            if !(self?.tasks.contains(textField) ?? false) {
                self?.tasks.append(textField)
                self?.tableView.reloadData()
            }
        }
        
        alertController.addAction(doneButton)
        alertController.addAction(cancelButton)
        
        present(alertController, animated: true)
    }
    
    
    @objc func addTask() {
        createAlert()
    }
    
    // MARK: - TableView DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = tasks[indexPath.row]
        cell.contentConfiguration = content
        return cell
    }
    
    
    // MARK: - TableView Delegate
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let actionDelete = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            self.tasks.remove(at: indexPath.row)
            tableView.reloadData()
        }
        
        let actions = UISwipeActionsConfiguration(actions: [actionDelete])
        
        return actions
    }
}

