//
//  FilesListView.swift
//  mindmap-swiftui
//
//  Created by Bashta on 14.11.2021.
//

import SwiftUI

class FileList: ObservableObject {
    @Published var files: [File] = [
        File.init(mesh: Mesh.sampleMesh(), selection: SelectionHandler.init())
    ]
    
    func addNote() {
        files.append(File.init(mesh: Mesh.sampleMesh(), selection: SelectionHandler.init()))
    }
}

class File: Identifiable {
    @Published var mesh: Mesh
    @Published var selection: SelectionHandler
    
    init(mesh: Mesh = .sampleMesh(),
         selection: SelectionHandler = .init()) {
        self.mesh = mesh
        self.selection = selection
    }
    
    var id: String {
        mesh.rootNodeID.uuidString
    }
}

struct FilesListView: View {
    @StateObject var list: FileList = .init()
    
    var body: some View {
        NavigationView {
            VStack {
                Trailing
                List(list.files) { item in
                    NavigationLink(item.mesh.rootNode().text) {
                        SurfaceView(mesh: item.mesh, selection: item.selection)
                            .navigationTitle(Text(item.mesh.rootNode().text))
                    }
                }
            }
            .padding(.vertical, 50)
        }
        .navigationTitle("Mindmap")
        .navigationViewStyle(.stack)
        .navigationBarItems(trailing: Trailing)
    }
    
    var Trailing: some View {
        Button("Add note") {
            list.addNote()
        }
    }
}

struct FilesListView_Previews: PreviewProvider {
    static var previews: some View {
        FilesListView()
    }
}
