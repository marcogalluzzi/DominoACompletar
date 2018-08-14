//
//  EstrategiaJuego.swift
//  Domino
//
//  Created by Jesús Pérez Lorenzo on 13/8/18.
//  Copyright © 2018 Jesús Pérez. All rights reserved.
//

import Foundation

/* Jugamos la primera ficha que encontremos que coincida
   con alguno de los dos extremos de la mesa
 */
struct EstrategiaJuegoDoubles: EstrategiaJuego {
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
    
        guard let fichaEncontrada = (fichas.filter { $0.contiene(puntos: extremos) && $0.esDoble }.max{ $0.puntos.der < $1.puntos.der }) else  {
            let estrategiaJuegoCerrar = EstrategiaJuegoCerrar()
            guard let jugada = estrategiaJuegoCerrar.elegirJugada(con: fichas, en: mesa, segun: extremos) else {
                let estrategiaJuegoSimple = EstrategiaJuegoSimple()
                return estrategiaJuegoSimple.elegirJugada(con: fichas, en: mesa, segun: extremos)
            }
            return jugada
        }
        return crearJugada(con: fichaEncontrada, segun: extremos)
    }

}
