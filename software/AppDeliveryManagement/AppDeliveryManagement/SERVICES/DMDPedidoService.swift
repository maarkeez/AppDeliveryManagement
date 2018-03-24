//
//  DMDPedidoService.swift
//  AppDeliveryManagement
//
//  Created by David Márquez Delgado on 20/3/18.
//  Copyright © 2018 David Márquez Delgado. All rights reserved.
//

import Foundation
class DMDPedidoService {
    //Singleton
    static let shared = DMDPedidoService()
    
    
    func getToday() -> [DMDPedido] {
        let pais = DMDPais(id: 1, nombre: "España")
        let provincia = DMDProvincia(id: 1, nombre: "Madrid", pais: pais)
        let ciudad = DMDCiudad(id: 1, nombre: "Getafe", provincia: provincia)

        let usuario = DMDUsuario(email: "maarkeez19@gmail.com", nombre: "David Márquez Delgado", telefono: "652966851")
        let producto1 = DMDProducto(id: 1, nombre: "Producto 1", descripcion: "Este es el producto 1")
        let producto2 = DMDProducto(id: 2, nombre: "Producto 2", descripcion: "Este es el producto 2")
        let producto3 = DMDProducto(id: 3, nombre: "Producto 3", descripcion: "Este es el producto 3")
        let producto4 = DMDProducto(id: 4, nombre: "Producto 4", descripcion: "Este es el producto 4")
        let productos = [producto1,producto2,producto3,producto4]
        
        let direccion1 = DMDDireccion(id: 1, cuidad: ciudad, CP: "28904", calle: "Calle Maestro Arbós, 15", piso: "3º C")
        let pedido1 = DMDPedido(id: 1,
                                fechaPedido: Date.init(),
                                usuario: usuario,
                                direccion: direccion1,
                                productos: productos)
        
        let direccion2 = DMDDireccion(id: 2, cuidad: ciudad, CP: "28904", calle: "Calle Greco, 5", piso: "Bajo Izquierda")
        let pedido2 = DMDPedido(id: 2,
                                fechaPedido: Date.init(),
                                usuario: usuario,
                                direccion: direccion2,
                                productos: productos)
        
        let direccion3 = DMDDireccion(id: 3, cuidad: ciudad, CP: "28903", calle: "Calle Tarragona, 9", piso: "4º 3")
        let pedido3 = DMDPedido(id: 3,
                                fechaPedido: Date.init(),
                                usuario: usuario,
                                direccion: direccion3,
                                productos: productos)
        
        return [pedido2,pedido1,pedido3]
    }
}
