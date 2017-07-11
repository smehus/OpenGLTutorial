//
//  Model.swift
//  OpenGLPart1
//
//  Created by scott mehus on 7/10/17.
//  Copyright © 2017 scott mehus. All rights reserved.
//

import Foundation
import GLKit

class Model {
    
    var shader: BaseEffect!
    var name: String!
    var vertices: [Vertex]!
    var vertextCount: GLuint!
    var indices: [GLubyte]!
    var indexCount: GLuint!
    
    var vao: GLuint = 0
    var vertexBuffer: GLuint = 0
    var indexBuffer: GLuint = 0
    
    var position = GLKVector3Make(0, 0, 0)
    var rotationX: GLfloat = 0
    var rotationY: GLfloat = 0
    var rotationZ: GLfloat = 0
    var scale: GLfloat = 1.0
    
    
    init(name: String, shader: BaseEffect, vertices: [Vertex], indices: [GLubyte]) {
        self.name = name
        self.shader = shader
        self.vertices = vertices
        self.vertextCount = GLuint(vertices.count)
        self.indices = indices
        self.indexCount = GLuint(indices.count)
        
        
        
        glGenVertexArraysOES(1, &vao)
        glBindVertexArrayOES(vao)
        
        // Generate vertext buffere
        glGenBuffers(GLsizei(1), &vertexBuffer)
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), vertexBuffer)
        glBufferData(GLenum(GL_ARRAY_BUFFER), vertices.count * MemoryLayout<Vertex>.size, vertices, GLenum(GL_STATIC_DRAW))
        
        
        /// generate index buffer
        glGenBuffers(GLsizei(1), &indexBuffer)
        glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), indexBuffer)
        glBufferData(GLenum(GL_ELEMENT_ARRAY_BUFFER), indices.count * MemoryLayout<GLubyte>.size, indices, GLenum(GL_STATIC_DRAW))
        
        
        // Enable vertex attributes - maps the vertrex attribute index to the property -basically assigning the property here
        glEnableVertexAttribArray(VertexAttributes.position.rawValue)
        glVertexAttribPointer(VertexAttributes.position.rawValue, 3, GLenum(GL_FLOAT), GLboolean(GL_FALSE), GLsizei(MemoryLayout<Vertex>.size), BUFFER_OFFSET(0))
        
        
        glEnableVertexAttribArray(VertexAttributes.color.rawValue)
        glVertexAttribPointer(VertexAttributes.color.rawValue, 4, GLenum(GL_FLOAT), GLboolean(GL_FALSE), GLsizei(MemoryLayout<Vertex>.size), BUFFER_OFFSET(3 * MemoryLayout<GLfloat>.size))
        
        glBindVertexArrayOES(0)
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), 0)
        glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), 0)
    }
    
    
    
    /// Matrix multiplication - to get the final positions
    func modelMatrix() -> GLKMatrix4 {
        var modelMatrix = GLKMatrix4Identity
        modelMatrix = GLKMatrix4Translate(modelMatrix, position.x, position.y, position.y)
        modelMatrix = GLKMatrix4Rotate(modelMatrix, rotationX, 1, 0, 0)
        modelMatrix = GLKMatrix4Rotate(modelMatrix, rotationY, 0, 1, 0)
        modelMatrix = GLKMatrix4Rotate(modelMatrix, rotationZ, 0, 0, 1)
        modelMatrix = GLKMatrix4Scale(modelMatrix, scale, scale, scale)
        
        return modelMatrix
    }
    
    // sinf is the key here
    func update(with delta: Double) {
        let secsPerMove: Double = 2
        position = GLKVector3Make(sinf(Float(CACurrentMediaTime() * 2 * Double.pi / secsPerMove)), position.y, position.z)
    }
    
    func render(with parentModelViewMatrix: GLKMatrix4) {
        
        let newMatrix = GLKMatrix4Multiply(parentModelViewMatrix, modelMatrix())
        
        shader.modelViewMatrix = newMatrix
        shader.prepareToDraw()
        
        glBindVertexArrayOES(vao)
//        glDrawArrays(GLenum(GL_LINE_STRIP), 0, 10) - Challenge
        glDrawElements(GLenum(GL_TRIANGLES), GLsizei(indices.count), GLenum(GL_UNSIGNED_BYTE), nil)
        glBindVertexArrayOES(0)
    }
    
    func BUFFER_OFFSET(_ n: Int) -> UnsafeRawPointer? {
        return UnsafeRawPointer(bitPattern: n)
    }
}
