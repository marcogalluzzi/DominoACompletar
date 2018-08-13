//
//  EstrategiaJuego.swift
//  Domino
//
//  Created by Marco Galluzzi on 10/8/18.
//  Copyright © 2018 Marco. All rights reserved.
//

import Foundation

/// Jugamos la primera ficha que encontremos que coincida
/// con alguno de los dos extremos de la mesa
struct EstrategiaJuegoSimple: EstrategiaJuego {

    func elegirJugada(con fichas: [Ficha], en mesa: [Ficha], segun extremos: ParejaPuntos) -> Jugada? {
        return crearJugada(con: fichas[0], segun: extremos)
    }
    
    /// Se crea una jugada según con que extremo de la mesa y con qué lado de la ficha haremos la jugada.
    /// Se busca la primera coincidencia con: izquierda de la mesa (ficha girada o no) y luego la derecha
    /// de la mesa (ficha girada o no)
    /// - La ficha puede estar girada o no
    /// - Se puede colocar la ficha a la izquierda o derecha de la mesa
    func crearJugada(con ficha: Ficha, segun extremos: ParejaPuntos) -> Jugada? {
        switch extremos {
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

}
