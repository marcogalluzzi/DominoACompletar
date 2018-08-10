//
//  EstrategiaJuego.swift
//  Domino
//
//  Created by Marco Galluzzi on 10/8/18.
//  Copyright © 2018 Marco. All rights reserved.
//

import Foundation

protocol EstrategiaJuego {

    func jugarConMesa(fichas: [Ficha], mesa: [Ficha]) -> Jugada?
}

extension EstrategiaJuego {
    
    func extremos(mesa: [Ficha]) -> ParejaPuntos? {
        if let izquierda = mesa.first {
            if let derecha = mesa.last {
                return (izquierda.puntos.izq, derecha.puntos.der)
            }
        }
        return nil
    }
}

