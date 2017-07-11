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
