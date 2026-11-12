import SwiftUI

struct TaskFormView: View {
    @Environment(\.dismiss) var dismiss
    var task: TaskItem?
    var onSave: (String, String) -> Void

    @State private var title = ""
    @State private var desc = ""

    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextField("Description", text: $desc)
            }
            .navigationTitle(task == nil ? "Add Task" : "Edit Task")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                                  Button("Save") {
                                      onSave(title.trimmingCharacters(in: .whitespaces),
                                             desc.trimmingCharacters(in: .whitespaces))
                                      dismiss()
                                  }
                                  .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty)
                              }
                          }
                          .onAppear {
                              title = task?.title ?? ""
                              desc = task?.description ?? ""
                          }
                      }
                  }
              }
