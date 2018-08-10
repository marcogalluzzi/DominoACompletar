//
//  EstrategiaJuego.swift
//  Domino
//
//  Created by Marco Galluzzi on 10/8/18.
//  Copyright © 2018 Marco. All rights reserved.
//

import Foundation

/* Jugamos la primera ficha que encontremos que coincida
   con alguno de los dos extremos de la mesa
 */
struct EstrategiaJuegoSimple: EstrategiaJuego {

    func jugarConMesa(fichas: [Ficha], mesa: [Ficha]) -> Jugada? {
        let extremosMesa = extremos(mesa: mesa)!
        
        if let ficha = fichas.first(where: {$0.contiene(puntos: extremosMesa)}) {
        
            // Según con que extremo de la mesa y con qué lado de la ficha haremos la jugada
            // - La ficha puede estar girada o no
            // - Se puede colocar la ficha a la izquierda o derecha de la mesa
            switch extremosMesa {
            case (ficha.puntos.izq, _):
                return Jugada(ficha: ficha.girada, lado: .izquierda)
            case (ficha.puntos.der, _):
                return Jugada(ficha: ficha, lado: .izquierda)
            case (_, ficha.puntos.izq):
                return Jugada(ficha: ficha, lado: .derecha)
            case (_, ficha.puntos.der):
                return Jugada(ficha: ficha.girada, lado: .derecha)
            default:
                return nil
            }
        }
        
        return nil
    }

}
