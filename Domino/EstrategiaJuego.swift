//
//  EstrategiaJuego.swift
//  Domino
//
//  Created by Marco Galluzzi on 10/8/18.
//  Copyright © 2018 Marco. All rights reserved.
//

import Foundation

protocol EstrategiaJuego {
    
    /// Elige una ficha a jugar de sólo entre las fichas cuya puntuación coincide con alguno
    /// de los extremos de la mesa. También indica en que lado de la mesa hay que jugarla.
    ///
    /// - Parameters:
    ///   - con: las fichas que encajan con alguno de los extremos de la mesa
    ///   - en: todas la fichas dispuestas sobre la mesa
    ///   - segun: los puntos de las fichas en los extremos de la mesa
    /// - Returns: la mejor jugada
    func elegirJugada(con fichas: [Ficha], en mesa: [Ficha], segun extremos: ParejaPuntos) -> Jugada?

}

extension EstrategiaJuego {
    
    func jugar(con fichas: [Ficha], en mesa: [Ficha]) -> Jugada? {
        if let extremosMesa = extremos(de: mesa) {
            // Hay alguna ficha en la mesa
            
            let fichasPosibles = filtrarFichasPosibles(con: fichas, segun: extremosMesa)
            
            if !fichasPosibles.isEmpty {
                let jugada = elegirJugada(con: fichasPosibles, en: mesa, segun: extremosMesa)
                
                assert(jugada != nil, "Hay fichas disponibles para jugar pero no se ha devuelto ninguna jugada.")
                return jugada
            }
            
        } else if let ficha = fichas.first(where: {$0.esDobleSeis}) {
            // Hemos encontrado el doble 6
            return Jugada(ficha: ficha, lado: .centro)
        } else if let ficha = fichas.first(where: {$0.esDoble}) {
            // Hemos encontrado otra ficha doble
            return Jugada(ficha: ficha, lado: .centro)
        } else if let ficha = fichas.first {
            // Ponemos la primera ficha que tengamos
            return Jugada(ficha: ficha, lado: .centro)
        }
        
        return nil
    }
    
    
    func filtrarFichasPosibles(con fichas: [Ficha], segun extremosMesa: ParejaPuntos) -> [Ficha] {
        return fichas.filter{$0.contiene(puntos: extremosMesa)}
    }
    
    func extremos(de mesa: [Ficha]) -> ParejaPuntos? {
        if let izquierda = mesa.first {
            if let derecha = mesa.last {
                return (izquierda.puntos.izq, derecha.puntos.der)
            }
        }
        return nil
    }
}

