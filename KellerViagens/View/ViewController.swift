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
    var ofertaTableViewCell = "OfertaTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    func configureTableView() {
        viagensTableView.register(UINib(nibName: viagemTableViewCell, bundle: nil), forCellReuseIdentifier: viagemTableViewCell)
        viagensTableView.register(UINib(nibName: ofertaTableViewCell, bundle: nil), forCellReuseIdentifier: ofertaTableViewCell)
        viagensTableView.dataSource = self
        viagensTableView.delegate = self
    }
    
    func irParaDestalhes(_ viagem: Viagem?) {
        if let viagemSelecionada = viagem {
            let detalheController = DetalheViewController.instanciar(viagemSelecionada)
            navigationController?.pushViewController(detalheController, animated: true)
        }
    }
}

//MARK: - DataSource

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return secaoDeViagens?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return secaoDeViagens?[section].numeroDeLinhas ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let viewModel = secaoDeViagens?[indexPath.section]
        switch viewModel?.tipo {
        case .destaques:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ViagemTableViewCell") as? ViagemTableViewCell else {
                fatalError("Erro ao criar ViagemTableViewCell")
            }
            cell.configureCell(viewModel?.viagens[indexPath.row])
            return cell
            
        case .ofertas:
            guard let cellOferta = tableView.dequeueReusableCell(withIdentifier: "OfertaTableViewCell") as? OfertaTableViewCell else {
                fatalError("Erro ao criar OfertaTableViewCell")
            }
            
            cellOferta.delegate = self
            cellOferta.configuraCelula(viewModel?.viagens)
            
            return cellOferta
            
        default:
            return UITableViewCell()
        }
    }
}

//MARK: - Delegate

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = secaoDeViagens?[indexPath.section]
        
        switch viewModel?.tipo {
        case .destaques, .internacionais:
            let viagemSelecionada = viewModel?.viagens[indexPath.row]
            irParaDestalhes(viagemSelecionada)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let home: String = "HomeTableViewHeader"
            let headerView = Bundle.main.loadNibNamed(home, owner: self, options: nil)?.first as? HomeTableViewHeader
            headerView?.configureView()
            
            return headerView
        }
        return nil
    }
    
    // retornar o tamanho do header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 300
        }
        return 0
    }
    
    // retornar o tamanho da celula na table view
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone ? 400 : 480
    }
}

//MARK: - Oferta Delegate

extension ViewController: OfertaTableViewCellDelegate {
    func didSelectedView(_ viagem: Viagem?) {
        irParaDestalhes(viagem)
    }
}
