#define STANDARD
#ifdef PHYSICAL
	#define IOR
	#define SPECULAR
#endif
uniform vec3 diffuse;
uniform vec3 emissive;
uniform float roughness;
uniform float metalness;
uniform float opacity;
#ifdef IOR
	uniform float ior;
#endif
#ifdef SPECULAR
	uniform float specularIntensity;
	uniform vec3 specularColor;
	#ifdef USE_SPECULARINTENSITYMAP
		uniform sampler2D specularIntensityMap;
	#endif
	#ifdef USE_SPECULARCOLORMAP
		uniform sampler2D specularColorMap;
	#endif
#endif
#ifdef USE_CLEARCOAT
	uniform float clearcoat;
	uniform float clearcoatRoughness;
#endif
#ifdef USE_IRIDESCENCE
	uniform float iridescence;
	uniform float iridescenceIOR;
	uniform float iridescenceThicknessMinimum;
	uniform float iridescenceThicknessMaximum;
#endif
#ifdef USE_SHEEN
	uniform vec3 sheenColor;
	uniform float sheenRoughness;
	#ifdef USE_SHEENCOLORMAP
		uniform sampler2D sheenColorMap;
	#endif
	#ifdef USE_SHEENROUGHNESSMAP
		uniform sampler2D sheenRoughnessMap;
	#endif
#endif
varying vec3 vViewPosition;
#include <common>



// /voxelizedObject/MAT/meshStandardBuilder_INSTANCES/noise1
// Modulo 289 without a division (only multiplications)
float mod289(float x) {
  return x - floor(x * (1.0 / 289.0)) * 289.0;
}
vec2 mod289(vec2 x) {
  return x - floor(x * (1.0 / 289.0)) * 289.0;
}
vec3 mod289(vec3 x) {
  return x - floor(x * (1.0 / 289.0)) * 289.0;
}
vec4 mod289(vec4 x) {
  return x - floor(x * (1.0 / 289.0)) * 289.0;
}
// Modulo 7 without a division
vec3 mod7(vec3 x) {
  return x - floor(x * (1.0 / 7.0)) * 7.0;
}

// Permutation polynomial: (34x^2 + x) mod 289
float permute(float x) {
     return mod289(((x*34.0)+1.0)*x);
}
vec3 permute(vec3 x) {
  return mod289((34.0 * x + 1.0) * x);
}
vec4 permute(vec4 x) {
     return mod289(((x*34.0)+1.0)*x);
}

float taylorInvSqrt(float r)
{
  return 1.79284291400159 - 0.85373472095314 * r;
}
vec4 taylorInvSqrt(vec4 r)
{
  return 1.79284291400159 - 0.85373472095314 * r;
}

vec2 fade(vec2 t) {
  return t*t*t*(t*(t*6.0-15.0)+10.0);
}
vec3 fade(vec3 t) {
  return t*t*t*(t*(t*6.0-15.0)+10.0);
}
vec4 fade(vec4 t) {
  return t*t*t*(t*(t*6.0-15.0)+10.0);
}
//
// Description : Array and textureless GLSL 2D/3D/4D simplex 
//               noise functions.
//      Author : Ian McEwan, Ashima Arts.
//  Maintainer : stegu
//     Lastmod : 20110822 (ijm)
//     License : Copyright (C) 2011 Ashima Arts. All rights reserved.
//               Distributed under the MIT License. See LICENSE file.
//               https://github.com/ashima/webgl-noise
//               https://github.com/stegu/webgl-noise
// 



float snoise(vec3 v)
  { 
  const vec2  C = vec2(1.0/6.0, 1.0/3.0) ;
  const vec4  D = vec4(0.0, 0.5, 1.0, 2.0);

// First corner
  vec3 i  = floor(v + dot(v, C.yyy) );
  vec3 x0 =   v - i + dot(i, C.xxx) ;

// Other corners
  vec3 g = step(x0.yzx, x0.xyz);
  vec3 l = 1.0 - g;
  vec3 i1 = min( g.xyz, l.zxy );
  vec3 i2 = max( g.xyz, l.zxy );

  //   x0 = x0 - 0.0 + 0.0 * C.xxx;
  //   x1 = x0 - i1  + 1.0 * C.xxx;
  //   x2 = x0 - i2  + 2.0 * C.xxx;
  //   x3 = x0 - 1.0 + 3.0 * C.xxx;
  vec3 x1 = x0 - i1 + C.xxx;
  vec3 x2 = x0 - i2 + C.yyy; // 2.0*C.x = 1/3 = C.y
  vec3 x3 = x0 - D.yyy;      // -1.0+3.0*C.x = -0.5 = -D.y

// Permutations
  i = mod289(i); 
  vec4 p = permute( permute( permute( 
             i.z + vec4(0.0, i1.z, i2.z, 1.0 ))
           + i.y + vec4(0.0, i1.y, i2.y, 1.0 )) 
           + i.x + vec4(0.0, i1.x, i2.x, 1.0 ));

// Gradients: 7x7 points over a square, mapped onto an octahedron.
// The ring size 17*17 = 289 is close to a multiple of 49 (49*6 = 294)
  float n_ = 0.142857142857; // 1.0/7.0
  vec3  ns = n_ * D.wyz - D.xzx;

  vec4 j = p - 49.0 * floor(p * ns.z * ns.z);  //  mod(p,7*7)

  vec4 x_ = floor(j * ns.z);
  vec4 y_ = floor(j - 7.0 * x_ );    // mod(j,N)

  vec4 x = x_ *ns.x + ns.yyyy;
  vec4 y = y_ *ns.x + ns.yyyy;
  vec4 h = 1.0 - abs(x) - abs(y);

  vec4 b0 = vec4( x.xy, y.xy );
  vec4 b1 = vec4( x.zw, y.zw );

  //vec4 s0 = vec4(lessThan(b0,0.0))*2.0 - 1.0;
  //vec4 s1 = vec4(lessThan(b1,0.0))*2.0 - 1.0;
  vec4 s0 = floor(b0)*2.0 + 1.0;
  vec4 s1 = floor(b1)*2.0 + 1.0;
  vec4 sh = -step(h, vec4(0.0));

  vec4 a0 = b0.xzyw + s0.xzyw*sh.xxyy ;
  vec4 a1 = b1.xzyw + s1.xzyw*sh.zzww ;

  vec3 p0 = vec3(a0.xy,h.x);
  vec3 p1 = vec3(a0.zw,h.y);
  vec3 p2 = vec3(a1.xy,h.z);
  vec3 p3 = vec3(a1.zw,h.w);

//Normalise gradients
  vec4 norm = taylorInvSqrt(vec4(dot(p0,p0), dot(p1,p1), dot(p2, p2), dot(p3,p3)));
  p0 *= norm.x;
  p1 *= norm.y;
  p2 *= norm.z;
  p3 *= norm.w;

// Mix final noise value
  vec4 m = max(0.6 - vec4(dot(x0,x0), dot(x1,x1), dot(x2,x2), dot(x3,x3)), 0.0);
  m = m * m;
  return 42.0 * dot( m*m, vec4( dot(p0,x0), dot(p1,x1), 
                                dot(p2,x2), dot(p3,x3) ) );
  }


float fbm_snoise_voxelizedObject_MAT_meshStandardBuilder_INSTANCES_noise1(in vec3 st) {
	float value = 0.0;
	float amplitude = 1.0;
	for (int i = 0; i < 3; i++) {
		value += amplitude * snoise(st);
		st *= 2.0;
		amplitude *= 0.5;
	}
	return value;
}


// /voxelizedObject/MAT/meshStandardBuilder_INSTANCES/rgbToOklab1
//////////////////////////////////////////////////////////////////////
//
// Visualizing Björn Ottosson's "oklab" colorspace
//
// shadertoy implementation by mattz
//
// license CC0 (public domain)
// https://creativecommons.org/share-your-work/public-domain/cc0/
//
// Click and drag to set lightness (mouse x) and chroma (mouse y).
// Hue varies linearly across the image from left to right.
//
// While mouse is down, plotted curves show oklab components
// L (red), a (green), and b (blue). 
//
// To test the inverse mapping, the plotted curves are generated
// by mapping the (pre-clipping) linear RGB color back to oklab 
// space.
//
// White bars on top of the image (and black bars on the bottom of
// the image) indicate clipping when one or more of the R, G, B 
// components are greater than 1.0 (or less than 0.0 respectively).
//
// The color accompanying the black/white bar shows which channels
// are out of gamut.
//
// Click in the bottom left to reset the view.
//
// Hit the 'G' key to toggle displaying a gamut test:
//
//   * black pixels indicate that RGB values for some hues
//     were clipped to 0 at the given lightness/chroma pair.
//
//   * white pixels indicate that RGB values for some hues
//     were clipped to 1 at the given lightness/chroma pair
//
//   * gray pixels indicate that both types of clipping happened
//
// Hit the 'U' key to display a uniform sampling of linear sRGB 
// space, converted into oklab lightness (x position) and chroma
// (y position) coordinates. If you mouse over a colored dot, the
// spectrum on screen should include that exact color.
//
//////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////
// sRGB color transform and inverse from 
// https://bottosson.github.io/posts/colorwrong/#what-can-we-do%3F

vec3 srgb_from_linear_srgb(vec3 x) {

    vec3 xlo = 12.92*x;
    vec3 xhi = 1.055 * pow(x, vec3(0.4166666666666667)) - 0.055;
    
    return mix(xlo, xhi, step(vec3(0.0031308), x));

}

vec3 linear_srgb_from_srgb(vec3 x) {

    vec3 xlo = x / 12.92;
    vec3 xhi = pow((x + 0.055)/(1.055), vec3(2.4));
    
    return mix(xlo, xhi, step(vec3(0.04045), x));

}

//////////////////////////////////////////////////////////////////////
// oklab transform and inverse from
// https://bottosson.github.io/posts/oklab/


const mat3 fwdA = mat3(1.0, 1.0, 1.0,
                       0.3963377774, -0.1055613458, -0.0894841775,
                       0.2158037573, -0.0638541728, -1.2914855480);
                       
const mat3 fwdB = mat3(4.0767245293, -1.2681437731, -0.0041119885,
                       -3.3072168827, 2.6093323231, -0.7034763098,
                       0.2307590544, -0.3411344290,  1.7068625689);

const mat3 invB = mat3(0.4121656120, 0.2118591070, 0.0883097947,
                       0.5362752080, 0.6807189584, 0.2818474174,
                       0.0514575653, 0.1074065790, 0.6302613616);
                       
const mat3 invA = mat3(0.2104542553, 1.9779984951, 0.0259040371,
                       0.7936177850, -2.4285922050, 0.7827717662,
                       -0.0040720468, 0.4505937099, -0.8086757660);

vec3 oklab_from_linear_srgb(vec3 c) {

    vec3 lms = invB * c;
            
    return invA * (sign(lms)*pow(abs(lms), vec3(0.3333333333333)));
    
}

vec3 linear_srgb_from_oklab(vec3 c) {

    vec3 lms = fwdA * c;
    
    return fwdB * (lms * lms * lms);
    
}


// https://www.shadertoy.com/view/WtccD7
const float max_chroma = 0.33;
vec3 uvToOklab(vec3 uvw){

    // setup oklab color
    float theta = 2.*3.141592653589793*uvw.x;
    
    float L = 0.8;
    float chroma = 0.1;
    
    //if (max(iMouse.x, iMouse.y) > 0.05 * iResolution.y) {
        L = uvw.y;//iMouse.x / iResolution.x;
        chroma = uvw.z * max_chroma;// / iResolution.y;
    //}
    
    float a = chroma*cos(theta);
    float b = chroma*sin(theta);
    
    vec3 lab = vec3(L, a, b);
	return lab;

    // convert to rgb 
    // vec3 rgb = linear_srgb_from_oklab(lab);

}







// /voxelizedObject/MAT/meshStandardBuilder_INSTANCES/globals1
uniform float time;

// /voxelizedObject/MAT/meshStandardBuilder_INSTANCES/attribute2
varying vec3 v_POLY_attribute_instancePosition;




#include <packing>
#include <dithering_pars_fragment>
#include <color_pars_fragment>
#include <uv_pars_fragment>
#include <uv2_pars_fragment>
#include <map_pars_fragment>
#include <alphamap_pars_fragment>
#include <alphatest_pars_fragment>
#include <aomap_pars_fragment>
#include <lightmap_pars_fragment>
#include <emissivemap_pars_fragment>
#include <bsdfs>
#include <iridescence_fragment>
#include <cube_uv_reflection_fragment>
#include <envmap_common_pars_fragment>
#include <envmap_physical_pars_fragment>
#include <fog_pars_fragment>
#include <lights_pars_begin>
#include <normal_pars_fragment>
#include <lights_physical_pars_fragment>
#include <transmission_pars_fragment>
#include <shadowmap_pars_fragment>
#include <bumpmap_pars_fragment>
#include <normalmap_pars_fragment>
#include <clearcoat_pars_fragment>
#include <iridescence_pars_fragment>
#include <roughnessmap_pars_fragment>
#include <metalnessmap_pars_fragment>
#include <logdepthbuf_pars_fragment>
#include <clipping_planes_pars_fragment>
struct SSSModel {
	bool isActive;
	vec3 color;
	float thickness;
	float power;
	float scale;
	float distortion;
	float ambient;
	float attenuation;
};

void RE_Direct_Scattering(
	const in IncidentLight directLight,
	const in GeometricContext geometry,
	const in SSSModel sssModel,
	inout ReflectedLight reflectedLight
	){
	vec3 scatteringHalf = normalize(directLight.direction + (geometry.normal * sssModel.distortion));
	float scatteringDot = pow(saturate(dot(geometry.viewDir, -scatteringHalf)), sssModel.power) * sssModel.scale;
	vec3 scatteringIllu = (scatteringDot + sssModel.ambient) * (sssModel.color * (1.0-sssModel.thickness));
	reflectedLight.directDiffuse += scatteringIllu * sssModel.attenuation * directLight.color;
}

void main() {
	#include <clipping_planes_fragment>
	vec4 diffuseColor = vec4( diffuse, opacity );



	// /voxelizedObject/MAT/meshStandardBuilder_INSTANCES/constant1
	vec3 v_POLY_constant1_val = vec3(0.8627450980392157, 0.03529411764705882, 0.03529411764705882);
	
	// /voxelizedObject/MAT/meshStandardBuilder_INSTANCES/constant3
	vec3 v_POLY_constant3_val = vec3(0.03529411764705882, 0.8627450980392157, 0.43529411764705883);
	
	// /voxelizedObject/MAT/meshStandardBuilder_INSTANCES/globals1
	float v_POLY_globals1_time = time;
	
	// /voxelizedObject/MAT/meshStandardBuilder_INSTANCES/constant2
	vec3 v_POLY_constant2_val = vec3(0.43137254901960786, 0.1450980392156863, 0.7137254901960784);
	
	// /voxelizedObject/MAT/meshStandardBuilder_INSTANCES/constant4
	vec3 v_POLY_constant4_val = vec3(0.1450980392156863, 0.39215686274509803, 0.7137254901960784);
	
	// /voxelizedObject/MAT/meshStandardBuilder_INSTANCES/attribute2
	vec3 v_POLY_attribute2_val = v_POLY_attribute_instancePosition;
	
	// /voxelizedObject/MAT/meshStandardBuilder_INSTANCES/globals2
	float v_POLY_globals2_time = time;
	
	// /voxelizedObject/MAT/meshStandardBuilder_INSTANCES/multAdd1
	float v_POLY_multAdd1_val = (1.0*(v_POLY_globals1_time + 0.0)) + 0.0;
	
	// /voxelizedObject/MAT/meshStandardBuilder_INSTANCES/multAdd3
	float v_POLY_multAdd3_val = (0.36*(v_POLY_globals1_time + 7.1)) + 0.0;
	
	// /voxelizedObject/MAT/meshStandardBuilder_INSTANCES/multAdd5
	float v_POLY_multAdd5_val = (0.16*(v_POLY_globals2_time + 0.0)) + 0.0;
	
	// /voxelizedObject/MAT/meshStandardBuilder_INSTANCES/sin1
	float v_POLY_sin1_val = sin(v_POLY_multAdd1_val);
	
	// /voxelizedObject/MAT/meshStandardBuilder_INSTANCES/sin2
	float v_POLY_sin2_val = sin(v_POLY_multAdd3_val);
	
	// /voxelizedObject/MAT/meshStandardBuilder_INSTANCES/floatToVec3_1
	vec3 v_POLY_floatToVec3_1_vec3 = vec3(0.0, 0.0, v_POLY_multAdd5_val);
	
	// /voxelizedObject/MAT/meshStandardBuilder_INSTANCES/multAdd2
	float v_POLY_multAdd2_val = (0.5*(v_POLY_sin1_val + 1.0)) + 0.0;
	
	// /voxelizedObject/MAT/meshStandardBuilder_INSTANCES/multAdd4
	float v_POLY_multAdd4_val = (0.5*(v_POLY_sin2_val + 1.0)) + 0.0;
	
	// /voxelizedObject/MAT/meshStandardBuilder_INSTANCES/noise1
	float v_POLY_noise1_noise = 4.0*fbm_snoise_voxelizedObject_MAT_meshStandardBuilder_INSTANCES_noise1((v_POLY_attribute2_val*vec3(0.6, 0.6, 0.6))+v_POLY_floatToVec3_1_vec3);
	
	// /voxelizedObject/MAT/meshStandardBuilder_INSTANCES/mix2
	vec3 v_POLY_mix2_mix = mix(v_POLY_constant1_val, v_POLY_constant3_val, v_POLY_multAdd2_val);
	
	// /voxelizedObject/MAT/meshStandardBuilder_INSTANCES/mix3
	vec3 v_POLY_mix3_mix = mix(v_POLY_constant2_val, v_POLY_constant4_val, v_POLY_multAdd4_val);
	
	// /voxelizedObject/MAT/meshStandardBuilder_INSTANCES/clamp1
	float v_POLY_clamp1_val = clamp(v_POLY_noise1_noise, 0.0, 1.0);
	
	// /voxelizedObject/MAT/meshStandardBuilder_INSTANCES/rgbToOklab1
	vec3 v_POLY_rgbToOklab1_oklab = oklab_from_linear_srgb(v_POLY_mix2_mix);
	
	// /voxelizedObject/MAT/meshStandardBuilder_INSTANCES/rgbToOklab2
	vec3 v_POLY_rgbToOklab2_oklab = oklab_from_linear_srgb(v_POLY_mix3_mix);
	
	// /voxelizedObject/MAT/meshStandardBuilder_INSTANCES/mix1
	vec3 v_POLY_mix1_mix = mix(v_POLY_rgbToOklab1_oklab, v_POLY_rgbToOklab2_oklab, v_POLY_clamp1_val);
	
	// /voxelizedObject/MAT/meshStandardBuilder_INSTANCES/oklabToRgb1
	vec3 v_POLY_oklabToRgb1_rgb = linear_srgb_from_oklab(v_POLY_mix1_mix);
	
	// /voxelizedObject/MAT/meshStandardBuilder_INSTANCES/output1
	diffuseColor.xyz = v_POLY_oklabToRgb1_rgb;
	float POLY_metalness = 1.0;
	float POLY_roughness = 1.0;
	vec3 POLY_emissive = vec3(1.0, 1.0, 1.0);
	SSSModel POLY_SSSModel = SSSModel(/*isActive*/false,/*color*/vec3(1.0, 1.0, 1.0), /*thickness*/0.1, /*power*/2.0, /*scale*/16.0, /*distortion*/0.1,/*ambient*/0.4,/*attenuation*/0.8 );



	ReflectedLight reflectedLight = ReflectedLight( vec3( 0.0 ), vec3( 0.0 ), vec3( 0.0 ), vec3( 0.0 ) );
	vec3 totalEmissiveRadiance = emissive * POLY_emissive;
	#include <logdepthbuf_fragment>
	#include <map_fragment>
	#include <color_fragment>
	#include <alphamap_fragment>
	#include <alphatest_fragment>
	float roughnessFactor = roughness * POLY_roughness;

#ifdef USE_ROUGHNESSMAP

	vec4 texelRoughness = texture2D( roughnessMap, vUv );

	// reads channel G, compatible with a combined OcclusionRoughnessMetallic (RGB) texture
	roughnessFactor *= texelRoughness.g;

#endif

	float metalnessFactor = metalness * POLY_metalness;

#ifdef USE_METALNESSMAP

	vec4 texelMetalness = texture2D( metalnessMap, vUv );

	// reads channel B, compatible with a combined OcclusionRoughnessMetallic (RGB) texture
	metalnessFactor *= texelMetalness.b;

#endif

	#include <normal_fragment_begin>
	#include <normal_fragment_maps>
	#include <clearcoat_normal_fragment_begin>
	#include <clearcoat_normal_fragment_maps>
	#include <emissivemap_fragment>
	#include <lights_physical_fragment>
	#include <lights_fragment_begin>
if(POLY_SSSModel.isActive){
	RE_Direct_Scattering(directLight, geometry, POLY_SSSModel, reflectedLight);
}


	#include <lights_fragment_maps>
	#include <lights_fragment_end>
	#include <aomap_fragment>
	vec3 totalDiffuse = reflectedLight.directDiffuse + reflectedLight.indirectDiffuse;
	vec3 totalSpecular = reflectedLight.directSpecular + reflectedLight.indirectSpecular;
	#include <transmission_fragment>
	vec3 outgoingLight = totalDiffuse + totalSpecular + totalEmissiveRadiance;
	#ifdef USE_SHEEN
		float sheenEnergyComp = 1.0 - 0.157 * max3( material.sheenColor );
		outgoingLight = outgoingLight * sheenEnergyComp + sheenSpecular;
	#endif
	#ifdef USE_CLEARCOAT
		float dotNVcc = saturate( dot( geometry.clearcoatNormal, geometry.viewDir ) );
		vec3 Fcc = F_Schlick( material.clearcoatF0, material.clearcoatF90, dotNVcc );
		outgoingLight = outgoingLight * ( 1.0 - material.clearcoat * Fcc ) + clearcoatSpecular * material.clearcoat;
	#endif
	#include <output_fragment>
	#include <tonemapping_fragment>
	#include <encodings_fragment>
	#include <fog_fragment>
	#include <premultiplied_alpha_fragment>
	#include <dithering_fragment>
}