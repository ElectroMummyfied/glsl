float fade(float value, float start, float end)
{
    return (clamp(value,start,end)-start)/(end-start);
}

float rand(float co) { return fract(sin(co*(91.3458)) * 47453.5453); }
float rand(vec2 co){ return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453); }
float rand(vec3 co){ return rand(co.xy+rand(co.z)); }

vec3 palette(in float t, in vec3 a, in vec3 b, in vec3 c, in vec3 d) {
    float pi = 3.1415926535;
    float tau = 2.0*pi;
    
    return a+b*cos(tau*(c*t + d));
}
vec3 nats_palette(in float t) {
    float pi = 3.1415926535;
    float tau = 2.0*pi;
    
    float u = 0.5;
    float v = 0.5;
    float w = 1.0;
    float s = 0.0;
    
    return palette (t,
        vec3(u, u, u),
        vec3(v, v, v),
        vec3(w, 2.0*w, 3.0*w),
        vec3(0.0 + s, 0.333 + s, 0.667 + s)
    );
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    
    vec2 uv = (fragCoord *2.0 - iResolution.xy)/(iResolution.y);
    uv = 6.0*(fract(uv)-0.5);
    
    float pi = 3.1415926535;
    float tau = 2.0*pi;
    
    float r = distance(vec2(0.0, 0.0),uv);
    float theta = atan(uv.y,uv.x);
    
    float R = 1.0+cos(8.0*r*sin(2.0*iTime) - 10.0*theta + iTime)/2.0;
    
    float f = (tanh(5.0*(r-R))+1.0)/2.0 + exp(-1.75*r);
    
    fragColor = vec4(nats_palette(f + 0.6+pow(0.25*sin(iTime),2.0)),1.0);
}
