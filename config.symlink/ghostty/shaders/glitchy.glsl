// Subtle glitch shader – tuned down from https://www.shadertoy.com/view/wld3WN

#define DURATION 10.      // loop duration
#define AMT 0.1          // glitch trigger percentage (reduced from 0.1)

#define SS(a, b, x) (smoothstep(a, b, x) * smoothstep(b, a, x))

#define UI0 1597334673U
#define UI1 3812015801U
#define UI2 uvec2(UI0, UI1)
#define UI3 uvec3(UI0, UI1, 2798796415U)
#define UIF (1. / float(0xffffffffU))

vec3 hash33(vec3 p) {
    uvec3 q = uvec3(ivec3(p)) * UI3;
    q = (q.x ^ q.y ^ q.z) * UI3;
    return -1. + 2. * vec3(q) * UIF;
}

float gnoise(vec3 x) {
    vec3 p = floor(x);
    vec3 w = fract(x);
    vec3 u = w * w * w * (w * (w * 6. - 15.) + 10.);

    vec3 ga = hash33(p + vec3(0.,0.,0.));
    vec3 gb = hash33(p + vec3(1.,0.,0.));
    vec3 gc = hash33(p + vec3(0.,1.,0.));
    vec3 gd = hash33(p + vec3(1.,1.,0.));
    vec3 ge = hash33(p + vec3(0.,0.,1.));
    vec3 gf = hash33(p + vec3(1.,0.,1.));
    vec3 gg = hash33(p + vec3(0.,1.,1.));
    vec3 gh = hash33(p + vec3(1.,1.,1.));

    float va = dot(ga, w - vec3(0.,0.,0.));
    float vb = dot(gb, w - vec3(1.,0.,0.));
    float vc = dot(gc, w - vec3(0.,1.,0.));
    float vd = dot(gd, w - vec3(1.,1.,0.));
    float ve = dot(ge, w - vec3(0.,0.,1.));
    float vf = dot(gf, w - vec3(1.,0.,1.));
    float vg = dot(gg, w - vec3(0.,1.,1.));
    float vh = dot(gh, w - vec3(1.,1.,1.));

    float gNoise = va + u.x*(vb - va) + 
                   u.y*(vc - va) + 
                   u.z*(ve - va) + 
                   u.x*u.y*(va - vb - vc + vd) + 
                   u.y*u.z*(va - vc - ve + vg) + 
                   u.z*u.x*(va - vb - ve + vf) + 
                   u.x*u.y*u.z*(-va + vb + vc - vd + ve - vf - vg + vh);

    return 2. * gNoise;
}

float gnoise01(vec3 x) { return .5 + .5 * gnoise(x); }

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 uv = fragCoord / iResolution.xy;
    float t = iTime;

    // smoother glitch activation
    float glitchAmount = SS(DURATION * 0.002, DURATION * AMT, mod(t, DURATION));
    float displayNoise = 0.;
    vec3 col = vec3(0.);
    vec2 eps = vec2(2. / iResolution.x, 0.); // subtler color shift
    vec2 st = vec2(0.);

    // analog distortion (reduced amplitude)
    float y = uv.y * iResolution.y;
    float distortion = gnoise(vec3(0., y * .01, t * 500.)) * (glitchAmount * 1.2 + .05);
    distortion *= gnoise(vec3(0., y * .02, t * 250.)) * (glitchAmount * 0.6 + .01);

    distortion += smoothstep(.998, 1., sin((uv.y + t * 1.6) * 2.)) * .01;
    distortion -= smoothstep(.998, 1., sin((uv.y + t) * 2.)) * .01;
    st = uv + vec2(distortion, 0.);

    // gentler chromatic aberration
    col.r += textureLod(iChannel0, st + eps + distortion, 0.).r;
    col.g += textureLod(iChannel0, st, 0.).g;
    col.b += textureLod(iChannel0, st - eps - distortion, 0.).b;

    // reduced white noise and scanlines
    displayNoise = 0.05 * clamp(displayNoise, 0., 1.);
    col += (0.05 + 0.25 * glitchAmount) * (hash33(vec3(fragCoord, mod(float(iFrame), 1000.))).r) * displayNoise;
    col -= (0.1 + 0.3 * glitchAmount) * (sin(4. * t + uv.y * iResolution.y * 1.75)) * displayNoise;

    fragColor = vec4(col, 1.0);
}