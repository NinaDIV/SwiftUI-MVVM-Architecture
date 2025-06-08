//
//  CursosViewModel.swift
//  Caso propuesto
//
//  Created by MILWARD on 2/06/25.
//
import SwiftUI

class CursosViewModel: ObservableObject {
    @Published var cursos: [Curso] = []

    init() {
        cargarDesdeDispositivo()
    }

    func guardarCurso(nombre: String, promedioPracticas: Double, promedioLaboratorios: Double) {
        let nuevoCurso = Curso(nombre: nombre, promedioPracticas: promedioPracticas, promedioLaboratorios: promedioLaboratorios)
        cursos.append(nuevoCurso)
        guardarEnDispositivo()
    }

    func eliminarCurso(at offsets: IndexSet) {
        cursos.remove(atOffsets: offsets)
        guardarEnDispositivo()
    }

    func actualizarCurso(_ curso: Curso) {
        if let index = cursos.firstIndex(where: { $0.id == curso.id }) {
            cursos[index] = curso
            guardarEnDispositivo()
        }
    }

    func cantidadCursos() -> Int {
        return cursos.count
    }

    // Persistencia simple con UserDefaults (para demo)
    private let key = "CursosGuardados"

    func guardarEnDispositivo() {
        if let data = try? JSONEncoder().encode(cursos) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    func cargarDesdeDispositivo() {
        if let data = UserDefaults.standard.data(forKey: key),
           let decoded = try? JSONDecoder().decode([Curso].self, from: data) {
            cursos = decoded
        }
    }
}
