//
//  Square.swift
//  OpenGLPart1
//
//  Created by scott mehus on 7/10/17.
//  Copyright © 2017 scott mehus. All rights reserved.
//

import Foundation
import GLKit

/*
class Square: Model {
    
    let squareVertices : [Vertex] = [
        Vertex((1, -1, 0), color: (1, 0, 0, 1)),
        Vertex((1, 1, 0), color: (0, 1, 0, 1)),
        Vertex((-1, 1, 0), color: (0, 0, 1, 1)),
        Vertex((-1, -1, 0), color: (1, 1, 0, 1)),
        ]
    
    let squareIndices : [GLubyte] = [
        0, 1, 2,
        2, 3, 0
    ]
    
    init(shader: BaseEffect) {
        super.init(name: "square", shader: shader, vertices: squareVertices, indices: squareIndices)
        self.rotationX = -GLKMathDegreesToRadians(90)
        self.position = GLKVector3Make(0, -5, 0)
        self.scale = (10, 10 , 10)
    }
}
 */


extension CGFloat {
    public static func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    public static func random(min: CGFloat, max: CGFloat) -> CGFloat {
        assert(min < max)
        return CGFloat.random() * (max - min) + min
    }
}

class Terrain: Model {
    
   static var squareVertices: [Vertex] {
        
        var array: [Vertex] = []
        var x: GLfloat = -1
        for i in 0...10 {
            x = x + GLfloat(0.1)
            let y = CGFloat.random(min: 0, max: 2)
                array.append(Vertex(x, GLfloat(y), 1,  0, 0, 0, 1,  0, 0, 0, 0, 1))
            
        }
    
        return array
    
    }
    
    let squareIndices : [GLubyte] = [
        // Front
        0, 1, 2,
        2, 3, 0,
    ]
    
    
    init(shader: BaseEffect) {
        super.init(name: "terrain", shader: shader, vertices: Terrain.squareVertices, indices: squareIndices, type: GLenum(GL_TRIANGLE_STRIP))
        self.loadTexture("dungeon_01.png")
    }
}

class Cube: Model {
    
    let squareVertices : [Vertex] = [
        
        // Front
        Vertex( 1, -1,   1,  1, 0, 0,   1,  1, 0,   0, 0 , 1), // 0
        Vertex( 1,  1, 1,  0, 1, 0, 1,  1, 1, 0, 0, 1), // 1
        Vertex(-1,  1, 1,  0, 0, 1, 1,  0, 1, 0, 0, 1), // 2
        Vertex(-1, -1, 1,  0, 0, 0, 1,  0, 0, 0, 0, 1), // 3
        
        // Back
        Vertex(-1, -1, -1, 0, 0, 1, 1,  1, 0, 0, 0, -1), // 4
        Vertex(-1,  1, -1, 0, 1, 0, 1,  1, 1, 0, 0, -1), // 5
        Vertex( 1,  1, -1, 1, 0, 0, 1,  0, 1, 0, 0, -1), // 6
        Vertex( 1, -1, -1, 0, 0, 0, 1,  0, 0, 0, 0, -1), // 7
        
        // Left
        Vertex(-1, -1,  1, 1, 0, 0, 1,  1, 0, -1, 0, 0), // 8
        Vertex(-1,  1,  1, 0, 1, 0, 1,  1, 1, -1, 0, 0), // 9
        Vertex(-1,  1, -1, 0, 0, 1, 1,  0, 1, -1, 0, 0), // 10
        Vertex(-1, -1, -1, 0, 0, 0, 1,  0, 0, -1, 0, 0), // 11
        
        // Right
        Vertex( 1, -1, -1, 1, 0, 0, 1,  1, 0, 1, 0, 0), // 12
        Vertex( 1,  1, -1, 0, 1, 0, 1,  1, 1, 1, 0, 0), // 13
        Vertex( 1,  1,  1, 0, 0, 1, 1,  0, 1, 1, 0, 0), // 14
        Vertex( 1, -1,  1, 0, 0, 0, 1,  0, 0, 1, 0, 0), // 15
        
        // Top
        Vertex( 1,  1,  1, 1, 0, 0, 1,  1, 0, 0, 1, 0), // 16
        Vertex( 1,  1, -1, 0, 1, 0, 1,  1, 1, 0, 1, 0), // 17
        Vertex(-1,  1, -1, 0, 0, 1, 1,  0, 1, 0, 1, 0), // 18
        Vertex(-1,  1,  1, 0, 0, 0, 1,  0, 0, 0, 1, 0), // 19
        
        // Bottom
        Vertex( 1, -1, -1, 1, 0, 0, 1,  1, 0, 0, -1, 0), // 20
        Vertex( 1, -1,  1, 0, 1, 0, 1,  1, 1, 0, -1, 0), // 21
        Vertex(-1, -1,  1, 0, 0, 1, 1,  0, 1, 0, -1, 0), // 22
        Vertex(-1, -1, -1, 0, 0, 0, 1,  0, 0, 0, -1, 0), // 23
        ]
    
    let squareIndices : [GLubyte] = [
        // Front
        0, 1, 2,
        2, 3, 0,
        
        // Back
        4, 5, 6,
        6, 7, 4,
        
        // Left
        8, 9, 10,
        10, 11, 8,
        
        // Right
        12, 13, 14,
        14, 15, 12,
        
        // Top
        16, 17, 18,
        18, 19, 16,
        
        // Bottom
        20, 21, 22,
        22, 23, 20
        
    ]
    
    init(shader: BaseEffect) {
        super.init(name: "cube", shader: shader, vertices: squareVertices, indices: squareIndices)
        self.loadTexture("dungeon_01.png")
    }
    
    override func update(with delta: Double) {
        rotationY += Float(Double.pi/8 * delta)
    }
}

/*
class Cone: Model {
    
    let squareVertices : [Vertex] = [
        
        // face 1: red
        Vertex((1, 0, 0.5), color: (1, 0, 0, 1)),
        Vertex((0, 1, 0), color: (1, 0, 0, 1)),
        Vertex((0, 0, 1), color: (1, 0, 0, 1)),
        
        // face 2 6 1 : orange
        Vertex((1, 0, -0.5), color: (1, 0.5, 0, 1)),
        Vertex((0, 1, 0), color: (1, 0.5, 0, 1)),
        Vertex((1, 0, 0.5), color: (1, 0.5, 0, 1)),
  
        // face 2 6 1 : orange
        Vertex((0, 0, -1), color: (1, 1, 0, 1)),
        Vertex((0, 1, 0), color: (1, 1, 0, 1)),
        Vertex((1, 0, -0.5), color: (1, 1, 0, 1)),
        
        // face 2 6 1 : green
        Vertex((-1, 0, -0.5), color: (0, 1, 0.2, 1)),
        Vertex((0, 1, 0), color: (0, 1, 0.2, 1)),
        Vertex((0, 0, -1), color: (0, 1, 0.2, 1)),
        
        // face 2 6 1 : orange
        Vertex((-1, 0, 0.5), color: (0, 0.3, 1, 1)),
        Vertex((0, 1, 0), color: (0, 0.3, 1, 1)),
        Vertex((-1, 0, -0.5), color: (0, 0.3, 1, 1)),
        
        // face 2 6 1 : orange
        Vertex((0, 0, 1), color: (0.2, 0, 1, 1)),
        Vertex((0, 1, 0), color: (0.2, 0, 1, 1)),
        Vertex((-1, 0, 0.5), color: (0.2, 0, 1, 1))
    ]
    
    let squareIndices : [GLubyte] = [
        0, 1, 2,
        3, 4, 5,
        6, 7, 8,
        9, 10, 11,
        12, 13, 14,
        15, 16, 17
    ]
    
    init(shader: BaseEffect) {        
        super.init(name: "cone", shader: shader, vertices: squareVertices, indices: squareIndices)
        self.scale = (0.25, 2, 0.25)
        self.position = GLKVector3Make(0, -5, 0)
        self.velocity = GLKVector3Make(0, 2, 0)
    }
    
    override func update(with delta: Double) {
        super.update(with: delta)
        rotationY += Float(Double.pi * delta)
        self.position = GLKVector3Add(position, GLKVector3MultiplyScalar(velocity, Float(delta)))
    }
}
*/
