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
        return puntos.izq == 6 && puntos.der == 6
    }
    
    // Es una ficha doble? (con la misma puntuación en los dos lados)
    var esDoble: Bool {
        return puntos.izq == puntos.der
    }
    
    // Inicialización
    init(puntos: ParejaPuntos) {
        self.puntos=puntos
    }
    
    // Devuelve la ficha actual girada
    var girada: Ficha {
       return Ficha(puntos: (izq:puntos.der,der:puntos.izq))
    }
    
    // Indica si alguna de las dos puntuaciones de entrada es igual a uno de los lado de la ficha
    func contiene(puntos: ParejaPuntos) -> Bool {
        return  puntos.izq == self.puntos.izq || puntos.der == self.puntos.der  || puntos.der == self.puntos.izq || puntos.izq == self.puntos.der
    }
    
    // Comparación de fichas
    static func == (lhs: Ficha, rhs: Ficha) -> Bool {
        return (lhs.puntos.izq == rhs.puntos.izq && lhs.puntos.der == rhs.puntos.der) || ( lhs.puntos.izq == rhs.puntos.der && lhs.puntos.der == rhs.puntos.izq)
    }
    
    var description: String {
        return "[\(puntos.izq)|\(puntos.der)]"
    }
}
