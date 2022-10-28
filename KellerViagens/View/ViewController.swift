//
//  ViewController.swift
//  KellerViagens
//
//  Created by Livia Carvalho Keller on 28/10/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var viagensTableView: UITableView!
    var viagemTableViewCell = "ViagemTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    func configureTableView() {
        viagensTableView.register(UINib(nibName: viagemTableViewCell, bundle: nil), forCellReuseIdentifier: viagemTableViewCell)
        viagensTableView.dataSource = self
        viagensTableView.delegate = self
    }
}

//MARK: - DataSource

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessaoDeViagens?[section].numeroDeLinhas ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ViagemTableViewCell") as? ViagemTableViewCell else {
            fatalError("Erro ao criar ViagemTableViewCell")
        }
        
        let viewModel = sessaoDeViagens?[indexPath.section]
        switch viewModel?.tipo {
        case .destaques:
            cell.configureCell(viewModel?.viagens[indexPath.row])
            return cell
        default:
            return UITableViewCell()
        }
    }
}

//MARK: - Delegate

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let home: String = "HomeTableViewHeader"
        let headerView = Bundle.main.loadNibNamed(home, owner: self, options: nil)?.first as? HomeTableViewHeader
        headerView?.configureView()
        
        return headerView
    }
    
    // retornar o tamanho do header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 300
    }
    
    // retornar o tamanho da celula na table view
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
}
