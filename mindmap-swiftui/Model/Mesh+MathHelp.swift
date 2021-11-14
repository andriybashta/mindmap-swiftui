
import Foundation
import CoreGraphics

extension Mesh {
    public func positionForNewChild(_ parent: Node, length: CGFloat) -> CGPoint {
        let childEdges = edges.filter { $0.start == parent.id }
        if let grandparentedge = edges.filter({ $0.end == parent.id }).first, let grandparent = nodeWithID(grandparentedge.start) {
            let baseAngle = angleFrom(start: grandparent.position, end: parent.position)
            let childBasedAngle = positionForChildAtIndex(childEdges.count, baseAngle: baseAngle)
            let newpoint = pointWithCenter(center: parent.position, radius: length, angle: childBasedAngle)
            return newpoint
        }
        return CGPoint(x: 200, y: 200)
    }
    
        /// get angle for n'th child in order delta * 0,1,-1,2,-2
    func positionForChildAtIndex(_ index: Int, baseAngle: CGFloat) -> CGFloat {
        let jitter = CGFloat.random(in: CGFloat(-1.0)...CGFloat(1.0)) * CGFloat.pi/32.0
        guard index > 0 else { return baseAngle + jitter }
        
        let level = (index + 1)/2
        let polarity: CGFloat = index % 2 == 0 ? -1.0:1.0
        
        let delta = CGFloat.pi/6.0 + jitter
        return baseAngle + polarity * delta * CGFloat(level)
    }
    
        /// angle in radians
    func pointWithCenter(center: CGPoint, radius: CGFloat, angle: CGFloat) -> CGPoint {
        let deltax = radius*cos(angle)
        let deltay = radius*sin(angle)
        let newpoint = CGPoint(x: center.x + deltax, y: center.y + deltay)
        return newpoint
    }
    
    func angleFrom(start: CGPoint, end: CGPoint) -> CGFloat {
        var deltax = end.x - start.x
        let deltay = end.y - start.y
        if abs(deltax) < 0.001 {
            deltax = 0.001
        }
        let  angle = atan(deltay/abs(deltax))
        return deltax > 0 ? angle: CGFloat.pi - angle
    }
}
