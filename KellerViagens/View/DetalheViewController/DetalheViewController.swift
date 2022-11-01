//
//  DetalheViewController.swift
//  KellerViagens
//
//  Created by Livia Carvalho Keller on 31/10/22.
//

import UIKit

class DetalheViewController: UIViewController {

    @IBOutlet weak var tituloViagemLabel: UILabel!
    @IBOutlet weak var viagemImage: UIImageView!
    @IBOutlet weak var subtituloViagemLabel: UILabel!
    @IBOutlet weak var diariaViagemLabel: UILabel!
    @IBOutlet weak var precoSemDescontoLabel: UILabel!
    @IBOutlet weak var precoViagemLabel: UILabel!
    @IBOutlet weak var numeroCartaoTextField: UITextField!
    @IBOutlet weak var nomeCartaoTextField: UITextField!
    @IBOutlet weak var dataCartaoTextField: UITextField!
    @IBOutlet weak var senhaCartaoTextField: UITextField!
    
    var viagem: Viagem?
    
    class func instanciar(_ viagem: Viagem) -> DetalheViewController {
        let detalhesViewController = DetalheViewController(nibName: String(describing: self), bundle: nil)
        detalhesViewController.viagem = viagem
        
        return detalhesViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView() {
        viagemImage.image = UIImage(named: viagem?.asset ?? "")
        tituloViagemLabel.text = viagem?.titulo
        subtituloViagemLabel.text = viagem?.subtitulo
        precoViagemLabel.text = "R$ \(viagem?.preco ?? 0)"
        
        let atributoString: NSMutableAttributedString = NSMutableAttributedString(string: "R$ \(viagem?.preco ?? 0)")
        atributoString.addAttribute(NSMutableAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, atributoString.length))
        precoSemDescontoLabel.attributedText = atributoString
        
        if let numeroDeDias = viagem?.diaria, let numeroDeHospedes = viagem?.hospedes {
            let diarias = numeroDeDias == 1 ? "Diária" : "Diárias"
            let hospedes = numeroDeHospedes == 1 ? "Pessoa" : "Pessoas"
            
            diariaViagemLabel.text = "\(numeroDeDias) \(diarias) - \(numeroDeHospedes) \(hospedes)"
        }
    }
    
    func pulsar(_ button: UIButton) {
        let pulsar = CASpringAnimation(keyPath: "transform.scale")
        
        pulsar.duration = 0.5
        pulsar.repeatCount = 1
        pulsar.autoreverses = true
        
        pulsar.fromValue = 0.95
        pulsar.toValue = 1.0
        
        pulsar.initialVelocity = 0.5
        pulsar.damping = 1.0
        
        button.layer.add(pulsar, forKey: nil)
        
    }
    
    @IBAction func botaoVoltar(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func botaoContinuar(_ sender: UIButton) {
        let textFields = [numeroCartaoTextField, nomeCartaoTextField, dataCartaoTextField, senhaCartaoTextField]
        if Validator().validaTextFields(textFields) {
            pulsar(sender)
            navigationController?.popViewController(animated: true)
        }
    }
}
