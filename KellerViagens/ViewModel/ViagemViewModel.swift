//
//  ViagemViewModel.swift
//  KellerViagens
//
//  Created by Livia Carvalho Keller on 28/10/22.
//

import UIKit

enum ViagemViewModelType: String {
    case destaques
    case ofertas
    case internacionais
}

protocol ViagemViewModel {
    var tituloSessao: String { get }
    var tipo: ViagemViewModelType { get }
    var viagens: [Viagem] { get set }
    var numeroDeLinhas: Int { get }
}
