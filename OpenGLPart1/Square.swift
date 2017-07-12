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

class Cube: Model {
    
    let squareVertices : [Vertex] = [
        
        // Front
        Vertex( 1, -1, 1,  1, 0, 0, 1,  1, 0), // 0
        Vertex( 1,  1, 1,  0, 1, 0, 1,  1, 1), // 1
        Vertex(-1,  1, 1,  0, 0, 1, 1,  0, 1), // 2
        Vertex(-1, -1, 1,  0, 0, 0, 1,  0, 0), // 3
        
        // Back
        Vertex(-1, -1, -1, 0, 0, 1, 1,  1, 0), // 4
        Vertex(-1,  1, -1, 0, 1, 0, 1,  1, 1), // 5
        Vertex( 1,  1, -1, 1, 0, 0, 1,  0, 1), // 6
        Vertex( 1, -1, -1, 0, 0, 0, 1,  0, 0), // 7
        
        // Left
        Vertex(-1, -1,  1, 1, 0, 0, 1,  1, 0), // 8
        Vertex(-1,  1,  1, 0, 1, 0, 1,  1, 1), // 9
        Vertex(-1,  1, -1, 0, 0, 1, 1,  0, 1), // 10
        Vertex(-1, -1, -1, 0, 0, 0, 1,  0, 0), // 11
        
        // Right
        Vertex( 1, -1, -1, 1, 0, 0, 1,  1, 0), // 12
        Vertex( 1,  1, -1, 0, 1, 0, 1,  1, 1), // 13
        Vertex( 1,  1,  1, 0, 0, 1, 1,  0, 1), // 14
        Vertex( 1, -1,  1, 0, 0, 0, 1,  0, 0), // 15
        
        // Top
        Vertex( 1,  1,  1, 1, 0, 0, 1,  1, 0), // 16
        Vertex( 1,  1, -1, 0, 1, 0, 1,  1, 1), // 17
        Vertex(-1,  1, -1, 0, 0, 1, 1,  0, 1), // 18
        Vertex(-1,  1,  1, 0, 0, 0, 1,  0, 0), // 19
        
        // Bottom
        Vertex( 1, -1, -1, 1, 0, 0, 1,  1, 0), // 20
        Vertex( 1, -1,  1, 0, 1, 0, 1,  1, 1), // 21
        Vertex(-1, -1,  1, 0, 0, 1, 1,  0, 1), // 22
        Vertex(-1, -1, -1, 0, 0, 0, 1,  0, 0), // 23
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
        self.loadTexture("razewarelogo_128.png")
    }
    
    override func update(with delta: Double) {
        rotationZ += Float(Double.pi * delta)
        rotationY += Float(Double.pi * delta)
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
