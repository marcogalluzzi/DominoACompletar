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
    /// de los extremos de la mesa.
    ///
    /// - Parameters:
    ///   - con: las fichas que encajan con alguno de los extremos de la mesa
    ///   - en: todas la fichas dispuestas sobre la mesa
    ///   - segun: los puntos de las fichas en los extremos de la mesa
    /// - Returns: la ficha a jugar
    func elegirFicha(con fichas: [Ficha], en mesa: [Ficha], segun extremos: ParejaPuntos) -> Ficha

}

extension EstrategiaJuego {
    
    func jugar(con fichas: [Ficha], en mesa: [Ficha]) -> Jugada? {
        if let extremosMesa = extremos(de: mesa) {
            // Hay alguna ficha en la mesa
            
            let fichasPosibles = filtrarFichasPosibles(con: fichas, segun: extremosMesa)
            
            if !fichasPosibles.isEmpty {
                let ficha = elegirFicha(con: fichasPosibles, en: mesa, segun: extremosMesa)
                return crearJugada(con: ficha, segun: extremosMesa)
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
    
    /*
     */
    /// Se crea una jugada según con que extremo de la mesa y con qué lado de la ficha haremos la jugada
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

