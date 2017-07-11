//
//  BaseEffect.swift
//  OpenGLPart1
//
//  Created by scott mehus on 7/9/17.
//  Copyright © 2017 scott mehus. All rights reserved.
//

import Foundation
import GLKit

class BaseEffect {
    
    var modelViewMatrix: GLKMatrix4!
    var projectionMatrix: GLKMatrix4!
    
    fileprivate var programHandle : GLuint = 0
    fileprivate var modelViewMatrixUniform: Int32!
    fileprivate var projectionMatrixUniform: Int32!
    
    
    init(vertexShader: String, fragmentShader: String) {
        self.compile(vertexShader: vertexShader, fragmentShader: fragmentShader)
    }
    
    func prepareToDraw() {
        glUseProgram(self.programHandle)
        withUnsafePointer(to: &modelViewMatrix.m) {
            $0.withMemoryRebound(to: GLfloat.self, capacity: MemoryLayout.size(ofValue: modelViewMatrix.m)) {
                    glUniformMatrix4fv(modelViewMatrixUniform, 1, GLboolean(false)  , $0)
            }
        }
        
        withUnsafePointer(to: &projectionMatrix.m) {
            $0.withMemoryRebound(to: GLfloat.self, capacity: MemoryLayout.size(ofValue: projectionMatrix.m)) {
                glUniformMatrix4fv(projectionMatrixUniform, 1, GLboolean(false)  , $0)
            }
        }
    }
}

extension BaseEffect {
    func compileShader(_ shaderName: String, shaderType: GLenum) -> GLuint {
        let path = Bundle.main.path(forResource: shaderName, ofType: nil)
        
        do {
            
            let shaderString = try NSString(contentsOfFile: path!, encoding: String.Encoding.utf8.rawValue)
            
            
            let shaderHandle = glCreateShader(shaderType)
            
            var shaderStringLength : GLint = GLint(Int32(shaderString.length))
            var shaderCString = shaderString.utf8String
            
            glShaderSource(shaderHandle, GLsizei(1), &shaderCString, &shaderStringLength)
            
            glCompileShader(shaderHandle)
            
            // Error handling
            var compileStatus : GLint = 0
            glGetShaderiv(shaderHandle, GLenum(GL_COMPILE_STATUS), &compileStatus)
            
            if compileStatus == GL_FALSE {
                
                var infoLength : GLsizei = 0
                let bufferLength : GLsizei = 1024
                glGetShaderiv(shaderHandle, GLenum(GL_INFO_LOG_LENGTH), &infoLength)
                
                let info : [GLchar] = Array(repeating: GLchar(0), count: Int(bufferLength))
                var actualLength : GLsizei = 0
                
                glGetShaderInfoLog(shaderHandle, bufferLength, &actualLength, UnsafeMutablePointer(mutating: info))
                NSLog(String(validatingUTF8: info)!)
                exit(1)
            }
            
            return shaderHandle
            
        } catch {
            exit(1)
        }
    }
    
    func compile(vertexShader: String, fragmentShader: String) {
        let vertexShaderName = self.compileShader(vertexShader, shaderType: GLenum(GL_VERTEX_SHADER))
        let fragmentShaderName = self.compileShader(fragmentShader, shaderType: GLenum(GL_FRAGMENT_SHADER))
        
        self.programHandle = glCreateProgram()
        glAttachShader(self.programHandle, vertexShaderName)
        glAttachShader(self.programHandle, fragmentShaderName)
        
        glBindAttribLocation(self.programHandle, VertexAttributes.position.rawValue, "a_Position")
        glBindAttribLocation(self.programHandle, VertexAttributes.color.rawValue, "a_Color")
        
        
        glLinkProgram(self.programHandle)
        
        modelViewMatrix = GLKMatrix4Identity
        modelViewMatrixUniform = glGetUniformLocation(programHandle, "u_modelViewMatrix")
        projectionMatrixUniform = glGetUniformLocation(programHandle, "u_projectionMatrix")
        
        // Eror handling
        var linkStatus : GLint = 0
        glGetProgramiv(self.programHandle, GLenum(GL_LINK_STATUS), &linkStatus)
        if linkStatus == GL_FALSE {
            var infoLength : GLsizei = 0
            let bufferLength : GLsizei = 1024
            glGetProgramiv(self.programHandle, GLenum(GL_INFO_LOG_LENGTH), &infoLength)
            
            let info : [GLchar] = Array(repeating: GLchar(0), count: Int(bufferLength))
            var actualLength : GLsizei = 0
            
            glGetProgramInfoLog(self.programHandle, bufferLength, &actualLength, UnsafeMutablePointer(mutating: info))
            NSLog(String(validatingUTF8: info)!)
            exit(1)
        }
    }
}
