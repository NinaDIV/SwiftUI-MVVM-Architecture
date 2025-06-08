//
//  Curso.swift
//  Caso propuesto
//
//  Created by MILWARD on 2/06/25.
//

import Foundation

struct Curso: Identifiable, Codable {
    var id = UUID()
    var nombre: String
    var promedioPracticas: Double
    var promedioLaboratorios: Double

    var aprobado: Bool {
        let promedioGeneral = (promedioPracticas + promedioLaboratorios) / 2
        return promedioGeneral >= 13.0
    }
}

