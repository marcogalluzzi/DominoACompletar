//
//  Jugador.swift
//  Domino
//
//  Created by Marco on 5/8/18.
//  Copyright © 2018 Marco. All rights reserved.
//

import Foundation

// Representa un jugador de dominó
class Jugador: CustomStringConvertible {
    // Las fichas que tiene en posesión el jugador durante una mano
    var fichas: [Ficha]
    
    // El nombre del jugador, para diferenciarlo de los demás
    var nombre: String
    
    // Calcula los puntos restantes de un jugador. Se llama al final de la partida.
    var puntosRestantes: Int {
        
    }
    
    // Constructor
    init(nombre: String) {
        
    }
    
    // El jugador acepta una ficha, proveniente de la caja de fichas disponibles
    func coger(ficha: Ficha) {
        
    }
    
    func jugar(extremosMesa: ParejaPuntos?) -> Jugada? {
        
        // Si hay fichas en la mesa
        if let puntos = extremosMesa {
            // Buscamos la primera ficha del jugador que contenga alguna de las puntaciones de los extremos de la mesa
            if let indice = fichas.indices.first(where: {fichas[$0].contiene(puntos: puntos)}) {
                
                // Quitamos la ficha de entre las que tiene el jugador
                let ficha = fichas.remove(at: indice)
                
                // Según con que extremo de la mesa y con qué lado de la ficha haremos la jugada
                // - La ficha puede estar girada o no
                // - Se puede colocar la ficha a la izquierda o derecha de la mesa
                switch puntos {
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
        // Si no hay fichas en la mesa
        else {
            if let indice = fichas.indices.first(where: {fichas[$0].esDobleSeis}) {
                // Hemos encontrado el doble 6
                let ficha = fichas.remove(at: indice)
                return Jugada(ficha: ficha, lado: .centro)
            } else if let indice = fichas.indices.first(where: {fichas[$0].esDoble}) {
                // Hemos encontrado otra ficha doble
                let ficha = fichas.remove(at: indice)
                return Jugada(ficha: ficha, lado: .centro)
            }
        }
        
        // No se ha encontrado ficha que corresponda con los extremos de las fichas en la mesa
        return nil
    }
    
    var description: String {
        return "\(nombre), fichas: "+fichas.map{$0.description}.joined(separator: " ")
    }
}
