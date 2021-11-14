
import Foundation
import CoreGraphics

typealias EdgeID = UUID

struct Edge: Identifiable {
    var id = EdgeID()
    var start: NodeID
    var end: NodeID
}

struct EdgeProxy: Identifiable {
    var id: EdgeID
    var start: CGPoint
    var end: CGPoint
}

extension Edge {
    static func == (lhs: Edge, rhs: Edge) -> Bool {
        return lhs.start == rhs.start && lhs.end == rhs.end
    }
}
