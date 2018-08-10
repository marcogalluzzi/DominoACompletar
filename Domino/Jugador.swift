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
    
    // Estrategia de juego a utilizar
    let estrategia: EstrategiaJuego
    
    // Calcula los puntos restantes de un jugador. Se llama al final de la partida.
    var puntosRestantes: Int {
       /*var puntos = 0
        fichas.forEach {puntos += $0.puntos.izq + $0.puntos.der}
        return puntos*/
        return fichas.map{$0.puntos.izq + $0.puntos.der}.reduce(0, +)
    }
    
    // Constructor
    init(nombre: String, estrategia: EstrategiaJuego) {
        self.nombre = nombre
        self.estrategia = estrategia
        fichas = []
    }
    
    func puntosFichaDobleMasAlta() -> Int? {
        /*var puntos = -1
        for ficha in fichas {
            if ficha.esDoble && ficha.puntos.der > puntos {
                puntos = ficha.puntos.der
            }
        }
        return puntos == -1 ? nil : puntos*/
        return fichas.filter{$0.esDoble}.max{$0.puntos.der < $1.puntos.der}?.puntos.der
    }
    // El jugador acepta una ficha, proveniente de la caja de fichas disponibles
    func coger(ficha: Ficha) {
        fichas.append(ficha)        
    }
    
    func soltar(ficha: Ficha) -> Bool {
        if let indice = fichas.indices.first(where: {fichas[$0] == ficha}) {
            fichas.remove(at: indice)
            return true
        }
        return false
    }
    
    func jugar(con mesa: [Ficha]) -> Jugada? {

        if let jugada = estrategia.jugar(con: fichas, en: mesa) {
            let eliminadaFicha = soltar(ficha: jugada.ficha)
            
            // Comprobamos que la estrategia ha devuelto una ficha existente
            assert(eliminadaFicha, "¡La estrategia ha devuelto una ficha que el jugador no tiene! -> \(jugada.ficha)")
            
            return jugada
        }

        // No se ha encontrado ficha que corresponda con los extremos de las fichas en la mesa
        return nil
    }
    
    var description: String {
        return "\(nombre), fichas: "+fichas.map{$0.description}.joined(separator: " ")
    }
}
