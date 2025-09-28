precision mediump float;
varying vec2 v_texcoord;
uniform sampler2D tex;

vec3 gamma(vec3 color, float g) {
    return pow(color, vec3(g));
}

void main() {
    vec4 pixColor = texture2D(tex, v_texcoord);
    vec3 gammad = gamma(vec3(pixColor.xyz), 1.5);

    gl_FragColor = vec4(gammad, pixColor.w);
}
