//
//  EstrategiaJuegoCerrar.swift
//  Domino
//
//  Created by Jesús Pérez Lorenzo on 13/8/18.
//  Copyright © 2018 Jesús Pérez. All rights reserved.
//

import Foundation

/* Jugamos la primera ficha que encontremos que coincida
 con alguno de los dos extremos de la mesa
 */
struct EstrategiaJuegoCerrar: EstrategiaJuego {
    
    func crearJugada(con ficha: Ficha, segun extremos: ParejaPuntos) -> Jugada? {
        // Según con que extremo de la mesa y con qué lado de la ficha haremos la jugada
        // - La ficha puede estar girada o no
        // - Se puede colocar la ficha a la izquierda o derecha de la mesa
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
    func elegirJugada(con fichas: [Ficha], en mesa: [Ficha], segun extremos: ParejaPuntos) -> Jugada? {
        let fallback: () -> Jugada? = {
            let estrategiaJuegoSimple = EstrategiaJuegoSimple()
            return estrategiaJuegoSimple.elegirJugada(con: fichas, en: mesa, segun: extremos)
        }
        guard let maxFicha = ([0,1,2,3,4,5,6].map{ (itm) -> Int in
            var cnt=0
            mesa.forEach{ cnt += $0.puntos.izq == itm || $0.puntos.der == itm ? 1 : 0 }
            return cnt
        }.enumerated().max{ $0.element < $1.element}) else {
            return fallback()
        }
        guard let fichaEncontrada = (fichas.filter { $0.puntos.der == maxFicha.offset || $0.puntos.der == maxFicha.offset}.first) else {
            return fallback()
        }
        return crearJugada(con: fichaEncontrada, segun: extremos)
    }
}

