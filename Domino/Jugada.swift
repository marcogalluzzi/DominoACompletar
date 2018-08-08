//
//  Jugada.swift
//  Domino
//
//  Created by Marco on 6/8/18.
//  Copyright © 2018 Marco. All rights reserved.
//

import Foundation

// Con este tipo se indica si la jugada será por la derecha o izquierda de las fichas en la mesa, o en el centro
// si todavía no hay ninguna fichas colocada.
enum Lado {
    case izquierda
    case derecha
    case centro
}

// Es la jugada que genera un jugador durante la partida
struct Jugada: CustomStringConvertible {
    let ficha: Ficha
    let lado: Lado
    
    var description: String {
        return "Jugada: \(ficha) a la \(lado)"
    }
}
