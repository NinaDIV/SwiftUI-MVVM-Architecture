import SwiftUI

struct VistaAgregarCurso: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var cursosVM: CursosViewModel

    @State private var nombreCurso: String = ""
    @State private var promedioPracticas: String = ""
    @State private var promedioLaboratorios: String = ""
    @State private var errorMessage: String?

    var body: some View {
        NavigationView {
            ZStack {
                // Gradiente de fondo moderno
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(.systemBackground),
                        Color(.systemGroupedBackground)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .edgesIgnoringSafeArea(.all)

                ScrollView {
                    VStack(alignment: .leading, spacing: 28) {
                        // Header con icono
                        HStack {
                            Image(systemName: "book.circle.fill")
                                .font(.system(size: 32))
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [.blue, .purple],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Registrar Nuevo Curso")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                                
                                Text("Complete la información del curso")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                        }
                        .padding(.top, 10)

                        VStack(spacing: 24) {
                            // Campo Nombre del Curso
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Image(systemName: "textbook")
                                        .foregroundColor(.blue)
                                        .frame(width: 20)
                                    Text("Nombre del Curso")
                                        .font(.headline)
                                        .fontWeight(.medium)
                                }
                                
                                TextField("Ingrese nombre del curso", text: $nombreCurso)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 14)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color(.systemBackground))
                                            .shadow(
                                                color: Color.black.opacity(0.06),
                                                radius: 8,
                                                x: 0,
                                                y: 2
                                            )
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color(.systemGray4), lineWidth: 1)
                                    )
                            }

                            // Campo Promedio de Prácticas
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Image(systemName: "pencil.and.ruler")
                                        .foregroundColor(.green)
                                        .frame(width: 20)
                                    Text("Promedio de Prácticas")
                                        .font(.headline)
                                        .fontWeight(.medium)
                                }
                                
                                TextField("0.0", text: $promedioPracticas)
                                    .keyboardType(.decimalPad)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 14)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color(.systemBackground))
                                            .shadow(
                                                color: Color.black.opacity(0.06),
                                                radius: 8,
                                                x: 0,
                                                y: 2
                                            )
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color(.systemGray4), lineWidth: 1)
                                    )
                            }

                            // Campo Promedio de Laboratorios
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Image(systemName: "flask")
                                        .foregroundColor(.orange)
                                        .frame(width: 20)
                                    Text("Promedio de Laboratorios")
                                        .font(.headline)
                                        .fontWeight(.medium)
                                }
                                
                                TextField("0.0", text: $promedioLaboratorios)
                                    .keyboardType(.decimalPad)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 14)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color(.systemBackground))
                                            .shadow(
                                                color: Color.black.opacity(0.06),
                                                radius: 8,
                                                x: 0,
                                                y: 2
                                            )
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color(.systemGray4), lineWidth: 1)
                                    )
                            }
                        }

                        // Mensaje de error con mejor presentación
                        if let errorMessage = errorMessage {
                            HStack {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .foregroundColor(.red)
                                Text(errorMessage)
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                            }
                            .foregroundColor(.red)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.red.opacity(0.1))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.red.opacity(0.3), lineWidth: 1)
                                    )
                            )
                        }

                        // Botón principal con gradiente
                        Button(action: {
                            if validarCampos() {
                                let practicas = Double(promedioPracticas) ?? 0.0
                                let labs = Double(promedioLaboratorios) ?? 0.0
                                cursosVM.guardarCurso(nombre: nombreCurso, promedioPracticas: practicas, promedioLaboratorios: labs)
                                dismiss()
                            }
                        }) {
                            HStack {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 18, weight: .medium))
                                Text("Guardar Curso")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [.blue, .blue.opacity(0.8)]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .foregroundColor(.white)
                            .cornerRadius(14)
                            .shadow(
                                color: Color.blue.opacity(0.3),
                                radius: 8,
                                x: 0,
                                y: 4
                            )
                        }
                        .padding(.top, 32)
                        .scaleEffect(errorMessage == nil ? 1.0 : 0.98)
                        .animation(.easeInOut(duration: 0.2), value: errorMessage)
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 16)
                }
            }
            .navigationTitle("Nuevo Curso")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 16))
                            Text("Cancelar")
                                .font(.body)
                                .fontWeight(.medium)
                        }
                        .foregroundColor(.secondary)
                    }
                }
            }
        }
    }

    private func validarCampos() -> Bool {
        guard !nombreCurso.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Ingrese el nombre del curso."
            return false
        }
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
