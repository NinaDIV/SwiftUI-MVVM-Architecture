import SwiftUI

struct VistaEditarCurso: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var promedioPracticas: String
    @State private var promedioLaboratorios: String
    @State private var errorMessage: String?

    var curso: Curso
    var cursosVM: CursosViewModel

    init(curso: Curso, cursosVM: CursosViewModel) {
        self.curso = curso
        self.cursosVM = cursosVM
        _promedioPracticas = State(initialValue: "\(curso.promedioPracticas)")
        _promedioLaboratorios = State(initialValue: "\(curso.promedioLaboratorios)")
    }

    var body: some View {
        NavigationView {
            ZStack {
                // Gradiente de fondo elegante
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(.systemBackground),
                        Color(.systemGroupedBackground)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)

                ScrollView {
                    VStack(spacing: 24) {
                        // Header con icono y título
                        VStack(spacing: 16) {
                            Image(systemName: "square.and.pencil")
                                .font(.system(size: 50))
                                .foregroundColor(.orange)
                                .padding(.top, 20)
                            
                            Text("Editar Curso")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                        }
                        .padding(.bottom, 10)

                        // Tarjeta del curso
                        VStack(spacing: 16) {
                            HStack {
                                Image(systemName: "book.closed.fill")
                                    .foregroundColor(.blue)
                                    .font(.system(size: 20))
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Curso Seleccionado")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    Text(curso.nombre)
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.primary)
                                }
                                
                                Spacer()
                            }
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.blue.opacity(0.2), lineWidth: 1)
                        )

                        // Formulario de edición
                        VStack(spacing: 20) {
                            // Campo Promedio de Prácticas
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Image(systemName: "pencil.and.outline")
                                        .foregroundColor(.green)
                                        .font(.system(size: 16))
                                    Text("Promedio de Prácticas")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                }
                                
                                TextField("0.0", text: $promedioPracticas)
                                    .keyboardType(.decimalPad)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 14)
                                    .background(Color(.systemBackground))
                                    .cornerRadius(12)
                                    .shadow(color: .black.opacity(0.08), radius: 4, x: 0, y: 2)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.green.opacity(0.3), lineWidth: 1)
                                    )
                            }

                            // Campo Promedio de Laboratorios
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Image(systemName: "flask.fill")
                                        .foregroundColor(.purple)
                                        .font(.system(size: 16))
                                    Text("Promedio de Laboratorios")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                }
                                
                                TextField("0.0", text: $promedioLaboratorios)
                                    .keyboardType(.decimalPad)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 14)
                                    .background(Color(.systemBackground))
                                    .cornerRadius(12)
                                    .shadow(color: .black.opacity(0.08), radius: 4, x: 0, y: 2)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.purple.opacity(0.3), lineWidth: 1)
                                    )
                            }
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)

                        // Mensaje de error si existe
                        if let errorMessage = errorMessage {
                            HStack {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .foregroundColor(.red)
                                Text(errorMessage)
                                    .font(.subheadline)
                                    .foregroundColor(.red)
                            }
                            .padding()
                            .background(Color.red.opacity(0.1))
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.red.opacity(0.3), lineWidth: 1)
                            )
                        }

                        // Botón de guardar con estilo mejorado
                        Button(action: {
                            if validarCampos() {
                                if let practicas = Double(promedioPracticas),
                                   let labs = Double(promedioLaboratorios) {
                                    let cursoActualizado = Curso(
                                        id: curso.id,
                                        nombre: curso.nombre,
                                        promedioPracticas: practicas,
                                        promedioLaboratorios: labs
                                    )
                                    cursosVM.actualizarCurso(cursoActualizado)
                                    presentationMode.wrappedValue.dismiss()
                                }
                            }
                        }) {
                            HStack {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 18))
                                Text("Actualizar Curso")
                                    .fontWeight(.semibold)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.8)]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .foregroundColor(.white)
                            .cornerRadius(14)
                            .shadow(color: .blue.opacity(0.3), radius: 8, x: 0, y: 4)
                        }
                        .padding(.top, 10)

                        Spacer(minLength: 30)
                    }
                    .padding(.horizontal, 20)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(.red)
                }
            }
        }
    }
    
    // Función de validación
    private func validarCampos() -> Bool {
        guard Double(promedioPracticas) != nil else {
            errorMessage = "Ingrese un promedio de prácticas válido."
            return false
        }
        guard Double(promedioLaboratorios) != nil else {
            errorMessage = "Ingrese un promedio de laboratorios válido."
            return false
        }
        errorMessage = nil
        return true
    }
}
