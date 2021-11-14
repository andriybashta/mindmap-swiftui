
import Foundation
import CoreGraphics

extension Mesh {
    static func sampleMesh() -> Mesh {
        let mesh = Mesh()
        mesh.updateNodeText(mesh.rootNode(), string: "New note")
        [(0, "mind 1"),
         (120, "mind 2"),
         (240, "mind 3")].forEach { (angle, name) in
            let point = mesh.pointWithCenter(center: .zero, radius: 200, angle: angle.radians)
            let node = mesh.addChild(mesh.rootNode(), at: point)
            mesh.updateNodeText(node, string: name)
        }
        return mesh
    }
    
    func addChildrenRecursive(to node: Node, distance: CGFloat, generation: Int) {
        let labels = ["A", "B", "C", "D", "E", "F"]
        guard generation < labels.count else {
            return
        }
        
        let childCount = Int.random(in: 1..<4)
        var count = 0
        while count < childCount {
            count += 1
            let position = positionForNewChild(node, length: distance)
            let child = addChild(node, at: position)
            updateNodeText(child, string: "\(labels[generation])\(count + 1)")
            addChildrenRecursive(to: child, distance: distance + 200.0, generation: generation + 1)
        }
    }
}

extension Int {
    var radians: CGFloat {
        CGFloat(self) * CGFloat.pi/180.0
    }
}
