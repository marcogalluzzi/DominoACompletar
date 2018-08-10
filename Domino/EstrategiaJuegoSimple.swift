//
//  EstrategiaJuego.swift
//  Domino
//
//  Created by Marco Galluzzi on 10/8/18.
//  Copyright © 2018 Marco. All rights reserved.
//

import Foundation

/* Jugamos la primera ficha que encontremos que coincida
   con alguno de los dos extremos de la mesa
 */
struct EstrategiaJuegoSimple: EstrategiaJuego {

    func elegirFicha(con fichas: [Ficha], en mesa: [Ficha], segun extremos: ParejaPuntos) -> Ficha {
        return fichas[0]
    }

}
