//
//  Ficha.swift
//  Domino
//
//  Created by Marco on 5/8/18.
//  Copyright © 2018 Marco. All rights reserved.
//

import Foundation

// Esta tupla guarda los valores de los dos lados de las fichas
typealias ParejaPuntos = (izq: Int, der: Int)

// Representa una ficha de dominó
struct Ficha: CustomStringConvertible, Equatable {
    // Los puntos que definen la ficha
    let puntos: ParejaPuntos
    
    // Es la ficha un doble 6?
    var esDobleSeis: Bool {
        
    }
    
    // Es una ficha doble? (con la misma puntuación en los dos lados)
    var esDoble: Bool {
        
    }
    
    // Inicialización
    init(puntos: ParejaPuntos) {
        
    }
    
    // Devuelve la ficha actual girada
    var girada: Ficha {
        
    }
    
    // Indica si alguna de las dos puntuaciones de entrada es igual a uno de los lado de la ficha
    func contiene(puntos: ParejaPuntos) -> Bool {
        
    }
    
    // Comparación de fichas
    static func == (lhs: Ficha, rhs: Ficha) -> Bool {
        
    }
    
    var description: String {
        return "[\(puntos.izq)|\(puntos.der)]"
    }
}
