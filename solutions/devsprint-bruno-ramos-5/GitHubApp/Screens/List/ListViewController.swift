//
//  ViewController.swift
//  GitHubApp
//
//  Created by Rodrigo Borges on 29/09/21.
//

import UIKit

protocol ListViewControllerProtocol: AnyObject {
    func navigationToDetail(listItem: String)
}

final class ListViewController: UIViewController {

    private let listView: ListView = {

        let listView = ListView()
        return listView
    }()

    private let service = Service()

    init() {
        super.init(nibName: nil, bundle: nil)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Repositories"
    }

    override func viewDidAppear(_ animated: Bool) {

        service.fetchList { repositories in

            DispatchQueue.main.async {

                self.listView.updateView(with: repositories)
            }
        }
    }

    override func loadView() {
        self.view = listView
        listView.delegate = self
    }
}

extension ListViewController: ListViewControllerProtocol {
    func navigationToDetail(listItem: String) {
        let detailVC = DetailViewController()
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
