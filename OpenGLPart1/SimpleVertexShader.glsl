uniform highp mat4 u_modelViewMatrix;
uniform highp mat4 u_projectionMatrix;

attribute vec4 a_Position;
attribute vec4 a_Color;
attribute vec2 a_TexCoord;

varying lowp vec4 frag_Color;
varying lowp vec2 frag_TexCoord;

void main(void) {
    frag_Color = a_Color;
    gl_Position = u_projectionMatrix * u_modelViewMatrix * a_Position;
    frag_TexCoord = a_TexCoord;
}
