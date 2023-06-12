float fade(float value, float start, float end)
{
    return (clamp(value,start,end)-start)/(end-start);
}
// testing
float rand(float co) { return fract(sin(co*(91.3458)) * 47453.5453); }
float rand(vec2 co){ return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453); }
float rand(vec3 co){ return rand(co.xy+rand(co.z)); }

vec3 palette(in float t, in vec3 a, in vec3 b, in vec3 c, in vec3 d) {
    return a+b*cos(c*t*d);
}
vec3 nats_palette(in float t) {
    float u = 0.5;
    float v = 0.5;
    float w = 10.0;
    float s = 1.0;

    return palette (t,
        vec3(u, u, u),
        vec3(v, v, v),
        vec3(w, w, w),
        vec3(s, s, s)
    );
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    //vec2 uv = fragCoord/iResolution.xy;
    //uv.x*= iResolution.x / iResolution.y;

    vec2 uv = (fragCoord *2.0 - iResolution.xy)/(iResolution.y);




    float r = distance(vec2(0.0, 0.0),uv);
    float theta = atan(uv.y,uv.x);

    //uv.x = r * cos(theta)/100.0;
    //uv.y = r * sin(theta)/100.0;

    // Output to screen
    //fragColor = vec4(nats_palette(r),1.0);
    fragColor = vec4(nats_palette(r-(theta-iTime)),1.0);


}
