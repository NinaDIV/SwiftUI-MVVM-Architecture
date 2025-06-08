import SwiftUI

struct ContentView: View {
    @StateObject var cursosVM = CursosViewModel()
    @State private var mostrandoAgregarCurso = false

    var body: some View {
        NavigationView {
            ZStack {
                // Gradiente de fondo más elegante
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(.systemBackground),
                        Color(.systemGroupedBackground),
                        Color(.systemGroupedBackground).opacity(0.8)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)

                if cursosVM.cursos.isEmpty {
                    // Estado vacío mejorado
                    VStack(spacing: 24) {
                        // Animación sutil para el ícono
                        Image(systemName: "graduationcap.fill")
                            .font(.system(size: 80))
                            .foregroundStyle(
                                LinearGradient(
                                    gradient: Gradient(colors: [.blue.opacity(0.6), .purple.opacity(0.6)]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .padding(.bottom, 10)
                        
                        VStack(spacing: 12) {
                            Text("¡Comienza tu Journey Académico!")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                            
                            Text("No hay cursos registrados aún.\nToca el botón + para agregar tu primer curso.")
                                .font(.body)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                                .lineSpacing(4)
                        }
                        
                        // Botón de acción llamativo en estado vacío
                        Button(action: {
                            mostrandoAgregarCurso = true
                        }) {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                    .font(.system(size: 18))
                                Text("Agregar Primer Curso")
                                    .fontWeight(.semibold)
                            }
                            .padding(.horizontal, 24)
                            .padding(.vertical, 12)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [.blue, .blue.opacity(0.8)]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .foregroundColor(.white)
                            .cornerRadius(25)
                            .shadow(color: .blue.opacity(0.3), radius: 8, x: 0, y: 4)
                        }
                        .padding(.top, 20)
                    }
                    .padding(.horizontal, 40)
                    
                } else {
                    // Lista de cursos mejorada
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            // Header con estadísticas
                            VStack(spacing: 16) {
                                HStack {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("Mis Cursos")
                                            .font(.title)
                                            .fontWeight(.bold)
                                        Text("\(cursosVM.cantidadCursos()) curso\(cursosVM.cantidadCursos() == 1 ? "" : "s") registrado\(cursosVM.cantidadCursos() == 1 ? "" : "s")")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                    Spacer()
                                    
                                    // Badge con estadísticas
                                    VStack(spacing: 4) {
                                        Text("\(cursosAprobados())")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .foregroundColor(.green)
                                        Text("Aprobados")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .background(Color.green.opacity(0.1))
                                    .cornerRadius(12)
                                }
                                .padding(.horizontal, 20)
                                .padding(.top, 10)
                            }
                            
                            // Lista de cursos con diseño de tarjetas
                            ForEach(cursosVM.cursos) { curso in
                                NavigationLink(destination: VistaEditarCurso(curso: curso, cursosVM: cursosVM)) {
                                    CursoCardView(curso: curso)
                                }
                                .buttonStyle(PlainButtonStyle())
                                .contextMenu {
                                    Button(role: .destructive) {
                                        if let index = cursosVM.cursos.firstIndex(where: { $0.id == curso.id }) {
                                            cursosVM.eliminarCurso(at: IndexSet(integer: index))
                                        }
                                    } label: {
                                        Label("Eliminar Curso", systemImage: "trash")
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 100) // Espacio para el botón flotante
                    }
                }

                // Botón flotante mejorado
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            mostrandoAgregarCurso = true
                        }) {
                            Image(systemName: "plus")
                                .font(.system(size: 24, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(width: 60, height: 60)
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [.blue, .blue.opacity(0.8)]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .clipShape(Circle())
                                .shadow(color: .blue.opacity(0.4), radius: 12, x: 0, y: 6)
                                .overlay(
                                    Circle()
                                        .stroke(Color.white.opacity(0.2), lineWidth: 2)
                                )
                        }
                        .scaleEffect(1.0)
                        .animation(.easeInOut(duration: 0.1), value: mostrandoAgregarCurso)
                        .padding(.trailing, 24)
                        .padding(.bottom, 24)
                    }
                }
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $mostrandoAgregarCurso) {
                VistaAgregarCurso(cursosVM: cursosVM)
            }
        }
    }
    
    // Función auxiliar para contar cursos aprobados
    private func cursosAprobados() -> Int {
        return cursosVM.cursos.filter { $0.aprobado }.count
    }
}

// Vista de tarjeta de curso personalizada
struct CursoCardView: View {
    let curso: Curso
    
    var body: some View {
        HStack(spacing: 16) {
            // Indicador de estado con diseño mejorado
            VStack {
                Image(systemName: curso.aprobado ? "checkmark.seal.fill" : "exclamationmark.triangle.fill")
                    .font(.system(size: 24))
                    .foregroundColor(curso.aprobado ? .green : .red)
                    .padding(12)
                    .background(
                        Circle()
                            .fill(curso.aprobado ? Color.green.opacity(0.1) : Color.red.opacity(0.1))
                    )
            }
            
            // Información del curso
            VStack(alignment: .leading, spacing: 8) {
                Text(curso.nombre)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                    .lineLimit(2)
                
                HStack(spacing: 16) {
                    // Prácticas
                    HStack(spacing: 4) {
                        Image(systemName: "pencil.and.outline")
                            .font(.system(size: 12))
                            .foregroundColor(.green)
                        Text("Prácticas: \(curso.promedioPracticas, specifier: "%.1f")")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    // Laboratorios
                    HStack(spacing: 4) {
                        Image(systemName: "flask.fill")
                            .font(.system(size: 12))
                            .foregroundColor(.purple)
                        Text("Labs: \(curso.promedioLaboratorios, specifier: "%.1f")")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                
                // Badge de estado
                HStack {
                    Text(curso.aprobado ? "APROBADO" : "JALADO")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(curso.aprobado ? .green : .red)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(curso.aprobado ? Color.green.opacity(0.1) : Color.red.opacity(0.1))
                        )
                    
                    Spacer()
                }
            }
            
            Spacer()
            
            // Flecha indicadora
            Image(systemName: "chevron.right")
                .font(.system(size: 14))
                .foregroundColor(.gray.opacity(0.6))
        }
        .padding(20)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            curso.aprobado ? Color.green.opacity(0.3) : Color.red.opacity(0.3),
                            Color.clear
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1
                )
        )
    }
}
