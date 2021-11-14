
import SwiftUI

struct NodeView: View {
    static let width = CGFloat(100)
        // 1
    @State var node: Node
        //2
    @ObservedObject var selection: SelectionHandler
        //3
    var isSelected: Bool {
        return selection.isNodeSelected(node)
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color.yellow)
            .overlay(RoundedRectangle(cornerRadius: 20)
                        .stroke(isSelected ? Color.red : Color.black, lineWidth: isSelected ? 5 : 3))
            .overlay(Text(node.text)
                        .multilineTextAlignment(.center)
                        .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)))
            .frame(width: NodeView.width, height: NodeView.width, alignment: .center)
    }
}

struct NodeView_Previews: PreviewProvider {
    static var previews: some View {
        let selection1 = SelectionHandler()
        let node1 = Node(text: "hello world")
        let selection2 = SelectionHandler()
        let node2 = Node(text: "I'm selected, look at me")
        selection2.selectNode(node2)
        
        return VStack {
            NodeView(node: node1, selection: selection1)
            NodeView(node: node2, selection: selection2)
        }
    }
}
