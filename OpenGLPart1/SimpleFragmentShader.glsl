varying lowp vec4 frag_Color;
varying lowp vec2 frag_TexCoord;
varying lowp vec3 frag_Normal;

uniform sampler2D u_Texture;

struct Light {
    lowp vec3 Color;
    lowp float AmbientIntensity;
    lowp float DiffuseIntensity;
    lowp vec3 Direction;
};

uniform Light u_Light;

void main(void) {
    // Multiplying because we're basically taking the texture2D (which is black and white) and multiplying the alpha value + the regular color. You can just use texture2D if you want it ot just be black and white (the color of the texture png)
//    gl_FragColor = frag_Color * texture2D(u_Texture, frag_TexCoord);
    
    // Ambient Color
    lowp vec3 AmbientColor = u_Light.Color *  u_Light.AmbientIntensity;
    
    // diffuse
    
    lowp vec3 Normal = normalize(frag_Normal);
    lowp float DiffuseFactor = max(-dot(Normal, u_Light.Direction), 0.0);
    lowp vec3 DiffuseColor = u_Light.Color * u_Light.DiffuseIntensity * DiffuseFactor;
    
    gl_FragColor = texture2D(u_Texture, frag_TexCoord) * vec4((AmbientColor + DiffuseColor), 1.0);
}
