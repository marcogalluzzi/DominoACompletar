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
       /*var puntos = 0
        fichas.forEach {puntos += $0.puntos.izq + $0.puntos.der}
        return puntos*/
        return fichas.map{$0.puntos.izq + $0.puntos.der}.reduce(0, +)
    }
    
    // Constructor
    init(nombre: String) {
        self.nombre = nombre
        fichas = []
    }
    
    // El jugador acepta una ficha, proveniente de la caja de fichas disponibles
    func coger(ficha: Ficha) {
        fichas.append(ficha)        
    }
    
    // TODO: ¿ añadir clase estrategia ?
    func jugar(extremosMesa: ParejaPuntos?) -> Jugada? {
        // Si hay fichas en la mesa
        if let puntosExtremos = extremosMesa {
            
            // TODO: Cómo lograr la mejor jugada
            //  - ¿ Cierro fichas ?
            //  - Puntuación en caso de fin de jugada
            //  - Historial de jugadas de cada uno para forzar siguente ficha
            
            // Buscamos la primera ficha del jugador que contenga alguna de las puntaciones de los extremos de la mesa
            if let indice = fichas.indices.first(where: {fichas[$0].contiene(puntos: puntosExtremos)}) {
                
                // Quitamos la ficha de entre las que tiene el jugador
                let ficha = fichas.remove(at: indice)
                
                // Según con que extremo de la mesa y con qué lado de la ficha haremos la jugada
                // - La ficha puede estar girada o no
                // - Se puede colocar la ficha a la izquierda o derecha de la mesa
                switch puntosExtremos {
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
            /*
            var indice: Int?
            for i in 0..<fichas.count {
                if (fichas[i].esDobleSeis) {
                    indice = i
                    break
                }
            }
            */
            if let indice = fichas.indices.first(where: {fichas[$0].esDobleSeis}) {
                // Hemos encontrado el doble 6
                let ficha = fichas.remove(at: indice)
                return Jugada(ficha: ficha, lado: .centro)
            } else if let indice = fichas.indices.first(where: {fichas[$0].esDoble}) {
                // Hemos encontrado otra ficha doble
                let ficha = fichas.remove(at: indice)
                return Jugada(ficha: ficha, lado: Lado.centro)
            }
        }
        // No se ha encontrado ficha que corresponda con los extremos de las fichas en la mesa
        return nil
    }
    
    var description: String {
        return "\(nombre), fichas: "+fichas.map{$0.description}.joined(separator: " ")
    }
}
