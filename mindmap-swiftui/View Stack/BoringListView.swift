
import SwiftUI

struct BoringListView: View {
    @ObservedObject var mesh: Mesh
    @ObservedObject var selection: SelectionHandler
    
    func indent(_ node: Node) -> CGFloat {
        let base = 20.0
        
        return CGFloat(mesh.distanceFromRoot(node) ?? 0) * CGFloat(base)
    }
    
    var body: some View {
        List(mesh.nodes, id: \.id) { node in
            Text(node.text)
                .padding(EdgeInsets(
                    top: 0,
                    leading: self.indent(node),
                    bottom: 0,
                    trailing: 0))
        }
    }
}

struct BoringListView_Previews: PreviewProvider {
    static var previews: some View {
        let mesh = Mesh.sampleMesh()
        let selection =  SelectionHandler()
        
        return BoringListView(mesh: mesh, selection: selection)
    }
}
