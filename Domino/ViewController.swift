//
//  ViewController.swift
//  Domino
//
//  Created by Marco on 5/8/18.
//  Copyright © 2018 Marco. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    func pruebaJugarAlDomino() {
        
        // Vamos a empezar a jugar
        let domino = Domino(jugadores: [
            Jugador(nombre: "Marco"),
            Jugador(nombre: "Carla"),
            Jugador(nombre: "Julieta"),
            Jugador(nombre: "Leonardo")
            ])
        
        // Empieza el juego
        domino.repartir()
        
        // El jugador que empieza es el que tiene el doble 6
        domino.ordenarJugadores()
        
        print("\nEl estado inicial de los jugadores es:")
        domino.jugadores.forEach{print($0)}
        
        // Los jugadores van jugando por turnos hasta que uno termine sus fichas o todos pasan
        print("\nLa partida:")
        domino.jugar()
        
        print("\nEl estado final de los jugadores es:")
        domino.jugadores.forEach{print($0)}
        
        if let ganador = domino.ganador() {
            print("\nEl ganador es: \(ganador.nombre)")
        } else {
            print("\nNo hay un ganador")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        pruebaJugarAlDomino()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

