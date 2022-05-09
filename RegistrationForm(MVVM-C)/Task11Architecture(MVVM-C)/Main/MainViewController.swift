//
//  MainViewController.swift
//  Task11Architecture(MVVM-C)
//
//  Created by Tymofii (Work) on 26.10.2021.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - Configuration
    
    private enum Configuration {
        static let cellIdentifier = "Cell"
    }
    
    // MARK: - Variable
    
    var viewModel: MainViewModelInterface?
    
    // MARK: - UI element
    
    private lazy var tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    private lazy var addBarButton: UIBarButtonItem = {
        let addButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(wasAddButtonTapped(_:)))
        return addButtonItem
    }()
    
    private lazy var exitBarButton: UIBarButtonItem = {
        let exitButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(wasExitButtonTapped(_:)))
        return exitButtonItem
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "To do list"
        view.backgroundColor = .white
        setupSubview()
        setupConstraint()
        setupTableView()
    }
    
    // MARK: - Setting up the subview
    
    private func setupSubview() {
        view.addSubview(tableView)
    }
    
    // MARK: - Setting up the constraint
    
    private func setupConstraint() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    // MARK: - Setting up the tableView
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Configuration.cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        navigationItem.rightBarButtonItem = exitBarButton
        navigationItem.leftBarButtonItem = addBarButton
    }
    
    // MARK: - UIAction
    
    @objc private func wasAddButtonTapped(_ sender: UITabBarItem) {
        let alert = UIAlertController(title: "To do list", message: "Аdd a note", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Enter a note"
        }
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak self] _ in
            guard let self = self, let text = alert.textFields?.first?.text else { return }
            self.viewModel?.addString(string: text)
            self.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func wasExitButtonTapped(_ sender: UITabBarItem) {
        viewModel?.handleSignOutButton()
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.numberOfRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configuration.cellIdentifier, for: indexPath)
        cell.textLabel?.text = viewModel?.getObject(at: indexPath)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.handleDetailedAction(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
