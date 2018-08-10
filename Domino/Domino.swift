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
        if let izquierda = mesa.first {
            if let derecha = mesa.last {
                return (izquierda.puntos.izq, derecha.puntos.der)
            }
        }
        return nil
    }
    
    // Inicializa la clase con los jugadores que van a jugar
    init(jugadores: [Jugador]) {
        assert(jugadores.count <= 4)
        self.jugadores = jugadores

        // La mesa de juego está sin piezas al inicio
        self.mesa = []
        
        // Crear piezas del dominó
        self.caja = []
        rellenarCaja()
    }
    
    // Rellena la caja con todas las fichas posibles
    func rellenarCaja() {
        assert(caja.isEmpty)
        for ladoIzq in 0...6 {
            for ladoDer in 0...ladoIzq {
                caja.append(Ficha(puntos: (izq: ladoIzq, der: ladoDer)))
            }
        }
    }
    
    // Saca una ficha al azar desde la caja
    func sacar() -> Ficha? {
        //recorremos caja y cojemos una ficha al azar
        if caja.isEmpty {
            return nil
        } else {
            let numAleatorio = Int(arc4random_uniform(UInt32(caja.count)))
            return caja.remove(at:numAleatorio)
        }
    }
    
    // Colocar un jugada en la mesa
    func colocar(jugada: Jugada) {
        if mesa.isEmpty {
            assert (jugada.lado == .centro)
            mesa.append(jugada.ficha)
        } else {
            // TODO: añadir assert
            if jugada.lado == .izquierda {
                mesa.insert (jugada.ficha,at: 0)
            } else {
                mesa.append (jugada.ficha)
            }
        }
    }
    
    // Reparte las fichas entre los diferentes jugadores
    func repartir() {
        for jugador in jugadores{
            for _ in 0...6 {
                if let ficha = sacar() {
                    jugador.coger(ficha: ficha)
                }
            }
        }
    }
    
    // Al volver a jugar hay que quitar las fichas restantes a los jugadores
    func quitarFichasJugadores() {
        for jugador in jugadores {
            jugador.fichas = []
        }
    }
    
    // Ordena los jugadores según el que tenga el que tenga el doble 6
    func buscarPrimerJugador() -> Int {
      /*
        var maxPuntos = -1
        var maxIndice = 0
        for (indice, jugador) in jugadores.enumerated() {
            if let maxPuntosJugador = jugador.puntosFichaDobleMasAlta(){
                if maxPuntosJugador > maxPuntos {
                    maxPuntos = maxPuntosJugador
                    maxIndice = indice
                }
            }
        }
        return maxIndice
        */
        return jugadores.indices.map{($0,jugadores[$0].puntosFichaDobleMasAlta() ?? -1)}.max{$0.1<$1.1}?.0 ?? 0
    }
    
    // Hace jugar a los jugadores hasta que alguien acabe sus fichas o todos los jugadores hayan pasado,
    // es decir que no tengan fichas para colocar en la mesa.
    func jugar(primerJugador: Int) {
        var pasan = 0
        var siguiente = primerJugador
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
        if let jugadorSinFichas = jugadores.first (where:{ $0.fichas.count == 0 }) {
            return jugadorSinFichas
        } else {
            return jugadores.min(by: {$0.puntosRestantes < $1.puntosRestantes})
        }
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


