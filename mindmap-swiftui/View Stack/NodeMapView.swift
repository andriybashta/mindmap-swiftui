
import SwiftUI

struct NodeMapView: View {
    @ObservedObject var selection: SelectionHandler
    @Binding var nodes: [Node]
    
    var body: some View {
        ZStack {
            ForEach(nodes, id: \.visualID) { node in
                NodeView(node: node, selection: self.selection)
                    .offset(x: node.position.x, y: node.position.y)
                    .onTapGesture {
                        self.selection.selectNode(node)
                    }
            }
        }
    }
}

struct NodeMapView_Previews: PreviewProvider {
    static let node1 = Node(position: CGPoint(x: -100, y: -30), text: "hello")
    static let node2 = Node(position: CGPoint(x: 100, y: 30), text: "world")
    @State static var nodes = [node1, node2]
    
    static var previews: some View {
        let selection = SelectionHandler()
        return NodeMapView(selection: selection, nodes: $nodes)
    }
}
