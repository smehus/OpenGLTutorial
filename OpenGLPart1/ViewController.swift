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
enum VertexAttributes: GLuint {
    case position = 0
    case color = 1
    case texCoord
}

struct Vertex {
    var x : GLfloat = 0.0
    var y : GLfloat = 0.0
    var z : GLfloat = 0.0
    
    var r : GLfloat = 0.0
    var g : GLfloat = 0.0
    var b : GLfloat = 0.0
    var a : GLfloat = 1.0
    
    var u : GLfloat = 0.0
    var v : GLfloat = 0.0
    
    
    init(_ x : GLfloat, _ y : GLfloat, _ z : GLfloat, _ r : GLfloat = 0.0, _ g : GLfloat = 0.0, _ b : GLfloat = 0.0, _ a : GLfloat = 1.0, _ u : GLfloat = 0.0, _ v : GLfloat = 0.0) {
        self.x = x
        self.y = y
        self.z = z
        
        self.r = r
        self.g = g
        self.b = b
        self.a = a
        
        self.u = u
        self.v = v
    }
}
class ViewController: GLKViewController {

    var glkView: GLKView {
        return view as! GLKView
    }
    
    
    var shader: BaseEffect!
//    var square: Square!
    var cube: Cube!
//    var cone: Cone!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        glkView.context = EAGLContext(api: EAGLRenderingAPI.openGLES2)
        
        glkView.drawableDepthFormat = .format16
        EAGLContext.setCurrent(glkView.context)
        
        setupScene()
    }
    
    func setupScene() {
        shader = BaseEffect(vertexShader: "SimpleVertexShader.glsl", fragmentShader: "SimpleFragmentShader.glsl")
//        square = Square(shader: shader)
        cube = Cube(shader: shader)
//        cone = Cone(shader: shader)
        shader.projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(85), Float(view.bounds.size.width / view.bounds.size.height), 1, 150)
    }

    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClearColor(0, 0, 0, 1.0)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT))
        glEnable(GLenum(GL_DEPTH_TEST))
        glEnable(GLenum(GL_CULL_FACE))
        glEnable(GLenum(GL_BLEND))
        glBlendFunc(GLenum(GL_SRC_ALPHA), GLenum(GL_ONE_MINUS_SRC_ALPHA))
    
        var viewMatrix = GLKMatrix4MakeTranslation(0, 0, -5)
        viewMatrix = GLKMatrix4Rotate(viewMatrix, GLKMathDegreesToRadians(45), 1, 0, 0)
        
//        square.render(with: viewMatrix)
        cube.render(with: viewMatrix)
//        cone.render(with: viewMatrix)
    }
    
    func update() {
//        square.update(with: timeSinceLastUpdate)
           cube.update(with: timeSinceLastUpdate)
//        cone.update(with: timeSinceLastUpdate)
    }
}

