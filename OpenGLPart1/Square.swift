//
//  Square.swift
//  OpenGLPart1
//
//  Created by scott mehus on 7/10/17.
//  Copyright © 2017 scott mehus. All rights reserved.
//

import Foundation
import GLKit

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
    }
}

class Cube: Model {
    
    let squareVertices : [Vertex] = [
        
        // front
        Vertex((1, -1, 1), color: (1, 0, 0, 1)),
        Vertex((1, 1, 1), color: (0, 1, 0, 1)),
        Vertex((-1, 1, 1), color: (0, 0, 1, 1)),
        Vertex((-1, -1, 1), color: (1, 1, 0, 1)),
        
        // back
        Vertex((-1, -1, -1), color: (1, 0, 0, 1)),
        Vertex((-1, 1, -1), color: (0, 1, 0, 1)),
        Vertex((1, 1, -1), color: (0, 0, 1, 1)),
        Vertex((1, -1, -1), color: (1, 1, 0, 1)),
        ]
    
    let squareIndices : [GLubyte] = [
        // front
        0, 1, 2,
        2, 3, 0,
        
        // back
        4, 5, 6,
        6, 7, 4,
        
        // left
        3, 2, 5,
        5, 4, 3,
        
        // right
        7, 6, 1,
        1, 0, 7,
        
        // top
        1, 6, 5,
        5, 2, 1,
        
        // bottom
        3, 4, 7,
        7, 0, 3
        
    ]
    
    init(shader: BaseEffect) {
        super.init(name: "cube", shader: shader, vertices: squareVertices, indices: squareIndices)
    }
    
    override func update(with delta: Double) {
        rotationZ += Float(Double.pi * delta)
        rotationY += Float(Double.pi * delta)
    }
}
