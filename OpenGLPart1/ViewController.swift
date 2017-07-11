//
//  ViewController.swift
//  OpenGLPart1
//
//  Created by scott mehus on 7/9/17.
//  Copyright © 2017 scott mehus. All rights reserved.
//

import UIKit
import GLKit



/// This is used as an index for the shaders in the buffers - not the index of the vertex info
///
/// - position: <#position description#>
/// - color: <#color description#>
enum VertexAttributes: GLuint {
    case position = 0
    case color = 1
}

struct Vertex {
    let position: (x: GLfloat, y: GLfloat, z: GLfloat)
    let color: (r: GLfloat, g: GLfloat, b: GLfloat, a: GLfloat)
    
    
    init(_ pos: (x: GLfloat, y: GLfloat, z: GLfloat), color: (r: GLfloat, g: GLfloat, b: GLfloat, a: GLfloat)) {
        position = pos
        self.color = color
    }
}

class ViewController: GLKViewController {

    var glkView: GLKView {
        return view as! GLKView
    }
    
    
    var shader: BaseEffect!
    var square: Square!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        glkView.context = EAGLContext(api: EAGLRenderingAPI.openGLES2)
        EAGLContext.setCurrent(glkView.context)
        
        setupScene()
    }
    
    func setupScene() {
        shader = BaseEffect(vertexShader: "SimpleVertexShader.glsl", fragmentShader: "SimpleFragmentShader.glsl")
        square = Square(shader: shader)
    }

    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClearColor(1.0, 0, 0, 1.0)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
    
        square.render()
    }
}

extension ViewController: GLKViewControllerDelegate {
    func glkViewControllerUpdate(_ controller: GLKViewController) {
        
    }
}