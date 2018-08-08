//
//  Domino.swift
//  Domino
//
//  Created by Marco on 5/8/18.
//  Copyright © 2018 Marco. All rights reserved.
//

import Foundation

// Gestiona el juego del Dominó
class Domino: CustomStringConvertible  {
    // La caja con todas las distintas fichas y de donde se sacan para repartirlas a los jugadores.
    var caja: [Ficha]
    
    // La mesa donde se disponen las fichas durante el juego.
    var mesa: [Ficha]
    
    // Los jugadores
    var jugadores: [Jugador]
    
    // Son las puntuaciones que tenemos en los extremos de las fichas dispuestas sobre la mesa.
    var extremosMesa: ParejaPuntos? {
        // TODO
        return nil
    }
    
    // Inicializa la clase con los jugadores que van a jugar
    init(jugadores: [Jugador]) {
        
        
        // La mesa de juego está sin piezas al inicio
        
        
        // Crear piezas del dominó
        
    }
    
    // Rellena la caja con todas las fichas posibles
    func rellenarCaja() {
        assert(caja.isEmpty)
        
        
    }
    
    // Saca una ficha al azar desde la caja
    func sacar() -> Ficha? {
        
    }
    
    // Colocar un jugada en la mesa
    func colocar(jugada: Jugada) {
        
    }
    
    // Reparte las fichas entre los diferentes jugadores
    func repartir() {

    }
    
    // Al volver a jugar hay que quitar las fichas restantes a los jugadores
    func quitarFichasJugadores() {
        for jugador in jugadores {
            jugador.fichas = []
        }
    }
    
    // Ordena los jugadores según el que tenga el que tenga el doble 6
    func ordenarJugadores() {

    }
    
    // Hace jugar a los jugadores hasta que alguien acabe sus fichas o todos los jugadores hayan pasado,
    // es decir que no tengan fichas para colocar en la mesa.
    func jugar() {
        var pasan = 0
        var siguiente = 0
        while (!jugadores.contains{$0.fichas.isEmpty}) && pasan != jugadores.count {
            let jugador = jugadores[siguiente]
            if let jugada = jugador.jugar(extremosMesa: extremosMesa) {
                colocar(jugada: jugada)
                print("\(jugador.nombre) - \(jugada) - \(self)")
                pasan =  0
            } else {
                print("\(jugador.nombre) - Pasa")
                pasan += 1
            }
            siguiente = (siguiente + 1) % jugadores.count
        }
    }
    
    // Devuelve el ganandor del juego. Será el que tiene menos puntos sumando los puntos de las fichas restantes.
    func ganador() -> Jugador? {

    }
    
    // Devuelve el estado de las fichas en la mesa.
    var description: String {
        if mesa.count < 5 {
            return "Mesa: "+mesa.map{$0.description}.joined(separator: " ")
        } else {
            return "Mesa: \(mesa[0]) \(mesa[1]) ...\(mesa.count - 4)... \(mesa[mesa.count-2]) \(mesa[mesa.count-1])"
        }
        
    }
}


