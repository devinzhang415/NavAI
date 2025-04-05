#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#if 0
NGS_BACKEND_SHADER_FLAGS_BEGIN__
NGS_BACKEND_SHADER_FLAGS_END__
#endif
namespace SNAP_VS {
int sc_GetStereoViewIndex()
{
    return 0;
}
}
    #ifndef sc_TextureRenderingLayout_Regular
        #define sc_TextureRenderingLayout_Regular 0
        #define sc_TextureRenderingLayout_StereoInstancedClipped 1
        #define sc_TextureRenderingLayout_StereoMultiview 2
    #endif
    #define depthToGlobal   depthScreenToViewSpace
    #define depthToLocal    depthViewToScreenSpace
    #ifndef quantizeUV
        #define quantizeUV sc_QuantizeUV
        #define sc_platformUVFlip sc_PlatformFlipV
        #define sc_PlatformFlipUV sc_PlatformFlipV
    #endif
    #ifndef sc_SampleTexture
        #define sc_SampleTexture sc_SampleTextureBiasOrLevel
    #endif
    #ifndef sc_texture2DLod
        #define sc_texture2DLod sc_InternalTextureLevel
        #define sc_textureLod sc_InternalTextureLevel
        #define sc_textureBias sc_InternalTextureBiasOrLevel
        #define sc_texture sc_InternalTexture
    #endif
//SG_REFLECTION_BEGIN(200)
//attribute vec4 boneData 5
//attribute vec3 blendShape0Pos 6
//attribute vec3 blendShape0Normal 12
//attribute vec3 blendShape1Pos 7
//attribute vec3 blendShape1Normal 13
//attribute vec3 blendShape2Pos 8
//attribute vec3 blendShape2Normal 14
//attribute vec3 blendShape3Pos 9
//attribute vec3 blendShape4Pos 10
//attribute vec3 blendShape5Pos 11
//attribute vec4 position 0
//attribute vec3 normal 1
//attribute vec4 tangent 2
//attribute vec2 texture0 3
//attribute vec2 texture1 4
//attribute vec4 color 18
//attribute vec3 positionNext 15
//attribute vec3 positionPrevious 16
//attribute vec4 strandProperties 17
//output vec4 FragColor0 0
//output vec4 FragColor1 1
//output vec4 FragColor2 2
//output vec4 FragColor3 3
//sampler sampler baseTexSmpSC 0:19
//sampler sampler intensityTextureSmpSC 0:20
//sampler sampler opacityTexSmpSC 0:21
//sampler sampler sc_ScreenTextureSmpSC 0:26
//sampler sampler screenTextureSmpSC 0:29
//texture texture2D baseTex 0:1:0:19
//texture texture2D intensityTexture 0:2:0:20
//texture texture2D opacityTex 0:3:0:21
//texture texture2D sc_ScreenTexture 0:15:0:26
//texture texture2D screenTexture 0:18:0:29
//ubo float sc_BonesUBO 0:0:96 {
//sc_Bone_t sc_Bones 0:[]:96
//float4 sc_Bones.boneMatrix 0:[3]:16
//float4 sc_Bones.normalMatrix 48:[3]:16
//}
//ubo int UserUniforms 0:30:4432 {
//sc_PointLight_t sc_PointLights 0:[3]:80
//bool sc_PointLights.falloffEnabled 0
//float sc_PointLights.falloffEndDistance 4
//float sc_PointLights.negRcpFalloffEndDistance4 8
//float sc_PointLights.angleScale 12
//float sc_PointLights.angleOffset 16
//float3 sc_PointLights.direction 32
//float3 sc_PointLights.position 48
//float4 sc_PointLights.color 64
//sc_DirectionalLight_t sc_DirectionalLights 240:[5]:32
//float3 sc_DirectionalLights.direction 0
//float4 sc_DirectionalLights.color 16
//sc_AmbientLight_t sc_AmbientLights 400:[3]:32
//float3 sc_AmbientLights.color 0
//float sc_AmbientLights.intensity 16
//sc_LightEstimationData_t sc_LightEstimationData 496
//sc_SphericalGaussianLight_t sc_LightEstimationData.sg 0:[12]:48
//float3 sc_LightEstimationData.sg.color 0
//float sc_LightEstimationData.sg.sharpness 16
//float3 sc_LightEstimationData.sg.axis 32
//float3 sc_LightEstimationData.ambientLight 576
//float4 sc_EnvmapDiffuseSize 1088
//float4 sc_EnvmapDiffuseDims 1104
//float4 sc_EnvmapDiffuseView 1120
//float4 sc_EnvmapSpecularSize 1136
//float4 sc_EnvmapSpecularDims 1152
//float4 sc_EnvmapSpecularView 1168
//float3 sc_EnvmapRotation 1184
//float sc_EnvmapExposure 1200
//float3 sc_Sh 1216:[9]:16
//float sc_ShIntensity 1360
//float4 sc_Time 1376
//float4 sc_UniformConstants 1392
//float4 sc_GeometryInfo 1408
//float4x4 sc_ModelViewProjectionMatrixArray 1424:[2]:64
//float4x4 sc_ModelViewProjectionMatrixInverseArray 1552:[2]:64
//float4x4 sc_ViewProjectionMatrixArray 1680:[2]:64
//float4x4 sc_ViewProjectionMatrixInverseArray 1808:[2]:64
//float4x4 sc_ModelViewMatrixArray 1936:[2]:64
//float4x4 sc_ModelViewMatrixInverseArray 2064:[2]:64
//float3x3 sc_ViewNormalMatrixArray 2192:[2]:48
//float3x3 sc_ViewNormalMatrixInverseArray 2288:[2]:48
//float4x4 sc_ProjectionMatrixArray 2384:[2]:64
//float4x4 sc_ProjectionMatrixInverseArray 2512:[2]:64
//float4x4 sc_ViewMatrixArray 2640:[2]:64
//float4x4 sc_ViewMatrixInverseArray 2768:[2]:64
//float4x4 sc_PrevFrameViewProjectionMatrixArray 2896:[2]:64
//float4x4 sc_ModelMatrix 3024
//float4x4 sc_ModelMatrixInverse 3088
//float3x3 sc_NormalMatrix 3152
//float3x3 sc_NormalMatrixInverse 3200
//float4x4 sc_PrevFrameModelMatrix 3248
//float4x4 sc_PrevFrameModelMatrixInverse 3312
//float3 sc_LocalAabbMin 3376
//float3 sc_LocalAabbMax 3392
//float3 sc_WorldAabbMin 3408
//float3 sc_WorldAabbMax 3424
//float4 sc_WindowToViewportTransform 3440
//float4 sc_CurrentRenderTargetDims 3456
//sc_Camera_t sc_Camera 3472
//float3 sc_Camera.position 0
//float sc_Camera.aspect 16
//float2 sc_Camera.clipPlanes 24
//float sc_ShadowDensity 3504
//float4 sc_ShadowColor 3520
//float4x4 sc_ProjectorMatrix 3536
//float _sc_GetFramebufferColorInvalidUsageMarker 3600
//float shaderComplexityValue 3604
//float sc_DisableFrustumCullingMarker 3608
//float4 weights0 3616
//float4 weights1 3632
//float4 weights2 3648
//float4 sc_StereoClipPlanes 3664:[2]:16
//int sc_FallbackInstanceID 3696
//float _sc_framebufferFetchMarker 3700
//float2 sc_TAAJitterOffset 3704
//float strandWidth 3712
//float strandTaper 3716
//float4 sc_StrandDataMapTextureSize 3728
//float clumpInstanceCount 3744
//float clumpRadius 3748
//float clumpTipScale 3752
//float hairstyleInstanceCount 3756
//float hairstyleNoise 3760
//float4 sc_ScreenTextureSize 3776
//float4 sc_ScreenTextureDims 3792
//float4 sc_ScreenTextureView 3808
//float correctedIntensity 3824
//float4 intensityTextureSize 3840
//float4 intensityTextureDims 3856
//float4 intensityTextureView 3872
//float3x3 intensityTextureTransform 3888
//float4 intensityTextureUvMinMax 3936
//float4 intensityTextureBorderColor 3952
//float reflBlurWidth 3968
//float reflBlurMinRough 3972
//float reflBlurMaxRough 3976
//int overrideTimeEnabled 3980
//float overrideTimeElapsed 3984
//float overrideTimeDelta 3988
//int PreviewEnabled 3992
//int PreviewNodeID 3996
//float alphaTestThreshold 4000
//float4 screenTextureSize 4016
//float4 screenTextureDims 4032
//float4 screenTextureView 4048
//float3x3 screenTextureTransform 4064
//float4 screenTextureUvMinMax 4112
//float4 screenTextureBorderColor 4128
//float4 baseTexSize 4144
//float4 baseTexDims 4160
//float4 baseTexView 4176
//float3x3 baseTexTransform 4192
//float4 baseTexUvMinMax 4240
//float4 baseTexBorderColor 4256
//float4 baseColor 4272
//float4 opacityTexSize 4288
//float4 opacityTexDims 4304
//float4 opacityTexView 4320
//float3x3 opacityTexTransform 4336
//float4 opacityTexUvMinMax 4384
//float4 opacityTexBorderColor 4400
//float opacity 4416
//float Port_Input2_N011 4420
//}
//spec_const bool BLEND_MODE_AVERAGE 0
//spec_const bool BLEND_MODE_BRIGHT 1
//spec_const bool BLEND_MODE_COLOR_BURN 2
//spec_const bool BLEND_MODE_COLOR_DODGE 3
//spec_const bool BLEND_MODE_COLOR 4
//spec_const bool BLEND_MODE_DARKEN 5
//spec_const bool BLEND_MODE_DIFFERENCE 6
//spec_const bool BLEND_MODE_DIVIDE 7
//spec_const bool BLEND_MODE_DIVISION 8
//spec_const bool BLEND_MODE_EXCLUSION 9
//spec_const bool BLEND_MODE_FORGRAY 10
//spec_const bool BLEND_MODE_HARD_GLOW 11
//spec_const bool BLEND_MODE_HARD_LIGHT 12
//spec_const bool BLEND_MODE_HARD_MIX 13
//spec_const bool BLEND_MODE_HARD_PHOENIX 14
//spec_const bool BLEND_MODE_HARD_REFLECT 15
//spec_const bool BLEND_MODE_HUE 16
//spec_const bool BLEND_MODE_INTENSE 17
//spec_const bool BLEND_MODE_LIGHTEN 18
//spec_const bool BLEND_MODE_LINEAR_LIGHT 19
//spec_const bool BLEND_MODE_LUMINOSITY 20
//spec_const bool BLEND_MODE_NEGATION 21
//spec_const bool BLEND_MODE_NOTBRIGHT 22
//spec_const bool BLEND_MODE_OVERLAY 23
//spec_const bool BLEND_MODE_PIN_LIGHT 24
//spec_const bool BLEND_MODE_REALISTIC 25
//spec_const bool BLEND_MODE_SATURATION 26
//spec_const bool BLEND_MODE_SOFT_LIGHT 27
//spec_const bool BLEND_MODE_SUBTRACT 28
//spec_const bool BLEND_MODE_VIVID_LIGHT 29
//spec_const bool ENABLE_OPACITY_TEX 30
//spec_const bool ENABLE_STIPPLE_PATTERN_TEST 31
//spec_const bool SC_USE_CLAMP_TO_BORDER_baseTex 32
//spec_const bool SC_USE_CLAMP_TO_BORDER_intensityTexture 33
//spec_const bool SC_USE_CLAMP_TO_BORDER_opacityTex 34
//spec_const bool SC_USE_CLAMP_TO_BORDER_screenTexture 35
//spec_const bool SC_USE_UV_MIN_MAX_baseTex 36
//spec_const bool SC_USE_UV_MIN_MAX_intensityTexture 37
//spec_const bool SC_USE_UV_MIN_MAX_opacityTex 38
//spec_const bool SC_USE_UV_MIN_MAX_screenTexture 39
//spec_const bool SC_USE_UV_TRANSFORM_baseTex 40
//spec_const bool SC_USE_UV_TRANSFORM_intensityTexture 41
//spec_const bool SC_USE_UV_TRANSFORM_opacityTex 42
//spec_const bool SC_USE_UV_TRANSFORM_screenTexture 43
//spec_const bool USE_LEGACY_512_TEXTURE 44
//spec_const bool UseViewSpaceDepthVariant 45
//spec_const bool baseTexHasSwappedViews 46
//spec_const bool intensityTextureHasSwappedViews 47
//spec_const bool opacityTexHasSwappedViews 48
//spec_const bool sc_BlendMode_AddWithAlphaFactor 49
//spec_const bool sc_BlendMode_Add 50
//spec_const bool sc_BlendMode_AlphaTest 51
//spec_const bool sc_BlendMode_AlphaToCoverage 52
//spec_const bool sc_BlendMode_ColoredGlass 53
//spec_const bool sc_BlendMode_Custom 54
//spec_const bool sc_BlendMode_Max 55
//spec_const bool sc_BlendMode_Min 56
//spec_const bool sc_BlendMode_MultiplyOriginal 57
//spec_const bool sc_BlendMode_Multiply 58
//spec_const bool sc_BlendMode_Normal 59
//spec_const bool sc_BlendMode_PremultipliedAlphaAuto 60
//spec_const bool sc_BlendMode_PremultipliedAlphaHardware 61
//spec_const bool sc_BlendMode_PremultipliedAlpha 62
//spec_const bool sc_BlendMode_Screen 63
//spec_const bool sc_DepthOnly 64
//spec_const bool sc_FramebufferFetch 65
//spec_const bool sc_MotionVectorsPass 66
//spec_const bool sc_OITCompositingPass 67
//spec_const bool sc_OITDepthBoundsPass 68
//spec_const bool sc_OITDepthGatherPass 69
//spec_const bool sc_ProjectiveShadowsCaster 70
//spec_const bool sc_ProjectiveShadowsReceiver 71
//spec_const bool sc_RenderAlphaToColor 72
//spec_const bool sc_ScreenTextureHasSwappedViews 73
//spec_const bool sc_ShaderComplexityAnalyzer 74
//spec_const bool sc_UseFramebufferFetchMarker 75
//spec_const bool sc_VertexBlendingUseNormals 76
//spec_const bool sc_VertexBlending 77
//spec_const bool screenTextureHasSwappedViews 78
//spec_const int SC_SOFTWARE_WRAP_MODE_U_baseTex 79
//spec_const int SC_SOFTWARE_WRAP_MODE_U_intensityTexture 80
//spec_const int SC_SOFTWARE_WRAP_MODE_U_opacityTex 81
//spec_const int SC_SOFTWARE_WRAP_MODE_U_screenTexture 82
//spec_const int SC_SOFTWARE_WRAP_MODE_V_baseTex 83
//spec_const int SC_SOFTWARE_WRAP_MODE_V_intensityTexture 84
//spec_const int SC_SOFTWARE_WRAP_MODE_V_opacityTex 85
//spec_const int SC_SOFTWARE_WRAP_MODE_V_screenTexture 86
//spec_const int baseTexLayout 87
//spec_const int intensityTextureLayout 88
//spec_const int opacityTexLayout 89
//spec_const int sc_DepthBufferMode 90
//spec_const int sc_RenderingSpace 91
//spec_const int sc_ScreenTextureLayout 92
//spec_const int sc_ShaderCacheConstant 93
//spec_const int sc_SkinBonesCount 94
//spec_const int sc_StereoRenderingMode 95
//spec_const int sc_StereoRendering_IsClipDistanceEnabled 96
//spec_const int screenTextureLayout 97
//SG_REFLECTION_END
constant bool BLEND_MODE_AVERAGE [[function_constant(0)]];
constant bool BLEND_MODE_AVERAGE_tmp = is_function_constant_defined(BLEND_MODE_AVERAGE) ? BLEND_MODE_AVERAGE : false;
constant bool BLEND_MODE_BRIGHT [[function_constant(1)]];
constant bool BLEND_MODE_BRIGHT_tmp = is_function_constant_defined(BLEND_MODE_BRIGHT) ? BLEND_MODE_BRIGHT : false;
constant bool BLEND_MODE_COLOR_BURN [[function_constant(2)]];
constant bool BLEND_MODE_COLOR_BURN_tmp = is_function_constant_defined(BLEND_MODE_COLOR_BURN) ? BLEND_MODE_COLOR_BURN : false;
constant bool BLEND_MODE_COLOR_DODGE [[function_constant(3)]];
constant bool BLEND_MODE_COLOR_DODGE_tmp = is_function_constant_defined(BLEND_MODE_COLOR_DODGE) ? BLEND_MODE_COLOR_DODGE : false;
constant bool BLEND_MODE_COLOR [[function_constant(4)]];
constant bool BLEND_MODE_COLOR_tmp = is_function_constant_defined(BLEND_MODE_COLOR) ? BLEND_MODE_COLOR : false;
constant bool BLEND_MODE_DARKEN [[function_constant(5)]];
constant bool BLEND_MODE_DARKEN_tmp = is_function_constant_defined(BLEND_MODE_DARKEN) ? BLEND_MODE_DARKEN : false;
constant bool BLEND_MODE_DIFFERENCE [[function_constant(6)]];
constant bool BLEND_MODE_DIFFERENCE_tmp = is_function_constant_defined(BLEND_MODE_DIFFERENCE) ? BLEND_MODE_DIFFERENCE : false;
constant bool BLEND_MODE_DIVIDE [[function_constant(7)]];
constant bool BLEND_MODE_DIVIDE_tmp = is_function_constant_defined(BLEND_MODE_DIVIDE) ? BLEND_MODE_DIVIDE : false;
constant bool BLEND_MODE_DIVISION [[function_constant(8)]];
constant bool BLEND_MODE_DIVISION_tmp = is_function_constant_defined(BLEND_MODE_DIVISION) ? BLEND_MODE_DIVISION : false;
constant bool BLEND_MODE_EXCLUSION [[function_constant(9)]];
constant bool BLEND_MODE_EXCLUSION_tmp = is_function_constant_defined(BLEND_MODE_EXCLUSION) ? BLEND_MODE_EXCLUSION : false;
constant bool BLEND_MODE_FORGRAY [[function_constant(10)]];
constant bool BLEND_MODE_FORGRAY_tmp = is_function_constant_defined(BLEND_MODE_FORGRAY) ? BLEND_MODE_FORGRAY : false;
constant bool BLEND_MODE_HARD_GLOW [[function_constant(11)]];
constant bool BLEND_MODE_HARD_GLOW_tmp = is_function_constant_defined(BLEND_MODE_HARD_GLOW) ? BLEND_MODE_HARD_GLOW : false;
constant bool BLEND_MODE_HARD_LIGHT [[function_constant(12)]];
constant bool BLEND_MODE_HARD_LIGHT_tmp = is_function_constant_defined(BLEND_MODE_HARD_LIGHT) ? BLEND_MODE_HARD_LIGHT : false;
constant bool BLEND_MODE_HARD_MIX [[function_constant(13)]];
constant bool BLEND_MODE_HARD_MIX_tmp = is_function_constant_defined(BLEND_MODE_HARD_MIX) ? BLEND_MODE_HARD_MIX : false;
constant bool BLEND_MODE_HARD_PHOENIX [[function_constant(14)]];
constant bool BLEND_MODE_HARD_PHOENIX_tmp = is_function_constant_defined(BLEND_MODE_HARD_PHOENIX) ? BLEND_MODE_HARD_PHOENIX : false;
constant bool BLEND_MODE_HARD_REFLECT [[function_constant(15)]];
constant bool BLEND_MODE_HARD_REFLECT_tmp = is_function_constant_defined(BLEND_MODE_HARD_REFLECT) ? BLEND_MODE_HARD_REFLECT : false;
constant bool BLEND_MODE_HUE [[function_constant(16)]];
constant bool BLEND_MODE_HUE_tmp = is_function_constant_defined(BLEND_MODE_HUE) ? BLEND_MODE_HUE : false;
constant bool BLEND_MODE_INTENSE [[function_constant(17)]];
constant bool BLEND_MODE_INTENSE_tmp = is_function_constant_defined(BLEND_MODE_INTENSE) ? BLEND_MODE_INTENSE : false;
constant bool BLEND_MODE_LIGHTEN [[function_constant(18)]];
constant bool BLEND_MODE_LIGHTEN_tmp = is_function_constant_defined(BLEND_MODE_LIGHTEN) ? BLEND_MODE_LIGHTEN : false;
constant bool BLEND_MODE_LINEAR_LIGHT [[function_constant(19)]];
constant bool BLEND_MODE_LINEAR_LIGHT_tmp = is_function_constant_defined(BLEND_MODE_LINEAR_LIGHT) ? BLEND_MODE_LINEAR_LIGHT : false;
constant bool BLEND_MODE_LUMINOSITY [[function_constant(20)]];
constant bool BLEND_MODE_LUMINOSITY_tmp = is_function_constant_defined(BLEND_MODE_LUMINOSITY) ? BLEND_MODE_LUMINOSITY : false;
constant bool BLEND_MODE_NEGATION [[function_constant(21)]];
constant bool BLEND_MODE_NEGATION_tmp = is_function_constant_defined(BLEND_MODE_NEGATION) ? BLEND_MODE_NEGATION : false;
constant bool BLEND_MODE_NOTBRIGHT [[function_constant(22)]];
constant bool BLEND_MODE_NOTBRIGHT_tmp = is_function_constant_defined(BLEND_MODE_NOTBRIGHT) ? BLEND_MODE_NOTBRIGHT : false;
constant bool BLEND_MODE_OVERLAY [[function_constant(23)]];
constant bool BLEND_MODE_OVERLAY_tmp = is_function_constant_defined(BLEND_MODE_OVERLAY) ? BLEND_MODE_OVERLAY : false;
constant bool BLEND_MODE_PIN_LIGHT [[function_constant(24)]];
constant bool BLEND_MODE_PIN_LIGHT_tmp = is_function_constant_defined(BLEND_MODE_PIN_LIGHT) ? BLEND_MODE_PIN_LIGHT : false;
constant bool BLEND_MODE_REALISTIC [[function_constant(25)]];
constant bool BLEND_MODE_REALISTIC_tmp = is_function_constant_defined(BLEND_MODE_REALISTIC) ? BLEND_MODE_REALISTIC : false;
constant bool BLEND_MODE_SATURATION [[function_constant(26)]];
constant bool BLEND_MODE_SATURATION_tmp = is_function_constant_defined(BLEND_MODE_SATURATION) ? BLEND_MODE_SATURATION : false;
constant bool BLEND_MODE_SOFT_LIGHT [[function_constant(27)]];
constant bool BLEND_MODE_SOFT_LIGHT_tmp = is_function_constant_defined(BLEND_MODE_SOFT_LIGHT) ? BLEND_MODE_SOFT_LIGHT : false;
constant bool BLEND_MODE_SUBTRACT [[function_constant(28)]];
constant bool BLEND_MODE_SUBTRACT_tmp = is_function_constant_defined(BLEND_MODE_SUBTRACT) ? BLEND_MODE_SUBTRACT : false;
constant bool BLEND_MODE_VIVID_LIGHT [[function_constant(29)]];
constant bool BLEND_MODE_VIVID_LIGHT_tmp = is_function_constant_defined(BLEND_MODE_VIVID_LIGHT) ? BLEND_MODE_VIVID_LIGHT : false;
constant bool ENABLE_OPACITY_TEX [[function_constant(30)]];
constant bool ENABLE_OPACITY_TEX_tmp = is_function_constant_defined(ENABLE_OPACITY_TEX) ? ENABLE_OPACITY_TEX : false;
constant bool ENABLE_STIPPLE_PATTERN_TEST [[function_constant(31)]];
constant bool ENABLE_STIPPLE_PATTERN_TEST_tmp = is_function_constant_defined(ENABLE_STIPPLE_PATTERN_TEST) ? ENABLE_STIPPLE_PATTERN_TEST : false;
constant bool SC_USE_CLAMP_TO_BORDER_baseTex [[function_constant(32)]];
constant bool SC_USE_CLAMP_TO_BORDER_baseTex_tmp = is_function_constant_defined(SC_USE_CLAMP_TO_BORDER_baseTex) ? SC_USE_CLAMP_TO_BORDER_baseTex : false;
constant bool SC_USE_CLAMP_TO_BORDER_intensityTexture [[function_constant(33)]];
constant bool SC_USE_CLAMP_TO_BORDER_intensityTexture_tmp = is_function_constant_defined(SC_USE_CLAMP_TO_BORDER_intensityTexture) ? SC_USE_CLAMP_TO_BORDER_intensityTexture : false;
constant bool SC_USE_CLAMP_TO_BORDER_opacityTex [[function_constant(34)]];
constant bool SC_USE_CLAMP_TO_BORDER_opacityTex_tmp = is_function_constant_defined(SC_USE_CLAMP_TO_BORDER_opacityTex) ? SC_USE_CLAMP_TO_BORDER_opacityTex : false;
constant bool SC_USE_CLAMP_TO_BORDER_screenTexture [[function_constant(35)]];
constant bool SC_USE_CLAMP_TO_BORDER_screenTexture_tmp = is_function_constant_defined(SC_USE_CLAMP_TO_BORDER_screenTexture) ? SC_USE_CLAMP_TO_BORDER_screenTexture : false;
constant bool SC_USE_UV_MIN_MAX_baseTex [[function_constant(36)]];
constant bool SC_USE_UV_MIN_MAX_baseTex_tmp = is_function_constant_defined(SC_USE_UV_MIN_MAX_baseTex) ? SC_USE_UV_MIN_MAX_baseTex : false;
constant bool SC_USE_UV_MIN_MAX_intensityTexture [[function_constant(37)]];
constant bool SC_USE_UV_MIN_MAX_intensityTexture_tmp = is_function_constant_defined(SC_USE_UV_MIN_MAX_intensityTexture) ? SC_USE_UV_MIN_MAX_intensityTexture : false;
constant bool SC_USE_UV_MIN_MAX_opacityTex [[function_constant(38)]];
constant bool SC_USE_UV_MIN_MAX_opacityTex_tmp = is_function_constant_defined(SC_USE_UV_MIN_MAX_opacityTex) ? SC_USE_UV_MIN_MAX_opacityTex : false;
constant bool SC_USE_UV_MIN_MAX_screenTexture [[function_constant(39)]];
constant bool SC_USE_UV_MIN_MAX_screenTexture_tmp = is_function_constant_defined(SC_USE_UV_MIN_MAX_screenTexture) ? SC_USE_UV_MIN_MAX_screenTexture : false;
constant bool SC_USE_UV_TRANSFORM_baseTex [[function_constant(40)]];
constant bool SC_USE_UV_TRANSFORM_baseTex_tmp = is_function_constant_defined(SC_USE_UV_TRANSFORM_baseTex) ? SC_USE_UV_TRANSFORM_baseTex : false;
constant bool SC_USE_UV_TRANSFORM_intensityTexture [[function_constant(41)]];
constant bool SC_USE_UV_TRANSFORM_intensityTexture_tmp = is_function_constant_defined(SC_USE_UV_TRANSFORM_intensityTexture) ? SC_USE_UV_TRANSFORM_intensityTexture : false;
constant bool SC_USE_UV_TRANSFORM_opacityTex [[function_constant(42)]];
constant bool SC_USE_UV_TRANSFORM_opacityTex_tmp = is_function_constant_defined(SC_USE_UV_TRANSFORM_opacityTex) ? SC_USE_UV_TRANSFORM_opacityTex : false;
constant bool SC_USE_UV_TRANSFORM_screenTexture [[function_constant(43)]];
constant bool SC_USE_UV_TRANSFORM_screenTexture_tmp = is_function_constant_defined(SC_USE_UV_TRANSFORM_screenTexture) ? SC_USE_UV_TRANSFORM_screenTexture : false;
constant bool USE_LEGACY_512_TEXTURE [[function_constant(44)]];
constant bool USE_LEGACY_512_TEXTURE_tmp = is_function_constant_defined(USE_LEGACY_512_TEXTURE) ? USE_LEGACY_512_TEXTURE : false;
constant bool UseViewSpaceDepthVariant [[function_constant(45)]];
constant bool UseViewSpaceDepthVariant_tmp = is_function_constant_defined(UseViewSpaceDepthVariant) ? UseViewSpaceDepthVariant : true;
constant bool baseTexHasSwappedViews [[function_constant(46)]];
constant bool baseTexHasSwappedViews_tmp = is_function_constant_defined(baseTexHasSwappedViews) ? baseTexHasSwappedViews : false;
constant bool intensityTextureHasSwappedViews [[function_constant(47)]];
constant bool intensityTextureHasSwappedViews_tmp = is_function_constant_defined(intensityTextureHasSwappedViews) ? intensityTextureHasSwappedViews : false;
constant bool opacityTexHasSwappedViews [[function_constant(48)]];
constant bool opacityTexHasSwappedViews_tmp = is_function_constant_defined(opacityTexHasSwappedViews) ? opacityTexHasSwappedViews : false;
constant bool sc_BlendMode_AddWithAlphaFactor [[function_constant(49)]];
constant bool sc_BlendMode_AddWithAlphaFactor_tmp = is_function_constant_defined(sc_BlendMode_AddWithAlphaFactor) ? sc_BlendMode_AddWithAlphaFactor : false;
constant bool sc_BlendMode_Add [[function_constant(50)]];
constant bool sc_BlendMode_Add_tmp = is_function_constant_defined(sc_BlendMode_Add) ? sc_BlendMode_Add : false;
constant bool sc_BlendMode_AlphaTest [[function_constant(51)]];
constant bool sc_BlendMode_AlphaTest_tmp = is_function_constant_defined(sc_BlendMode_AlphaTest) ? sc_BlendMode_AlphaTest : false;
constant bool sc_BlendMode_AlphaToCoverage [[function_constant(52)]];
constant bool sc_BlendMode_AlphaToCoverage_tmp = is_function_constant_defined(sc_BlendMode_AlphaToCoverage) ? sc_BlendMode_AlphaToCoverage : false;
constant bool sc_BlendMode_ColoredGlass [[function_constant(53)]];
constant bool sc_BlendMode_ColoredGlass_tmp = is_function_constant_defined(sc_BlendMode_ColoredGlass) ? sc_BlendMode_ColoredGlass : false;
constant bool sc_BlendMode_Custom [[function_constant(54)]];
constant bool sc_BlendMode_Custom_tmp = is_function_constant_defined(sc_BlendMode_Custom) ? sc_BlendMode_Custom : false;
constant bool sc_BlendMode_Max [[function_constant(55)]];
constant bool sc_BlendMode_Max_tmp = is_function_constant_defined(sc_BlendMode_Max) ? sc_BlendMode_Max : false;
constant bool sc_BlendMode_Min [[function_constant(56)]];
constant bool sc_BlendMode_Min_tmp = is_function_constant_defined(sc_BlendMode_Min) ? sc_BlendMode_Min : false;
constant bool sc_BlendMode_MultiplyOriginal [[function_constant(57)]];
constant bool sc_BlendMode_MultiplyOriginal_tmp = is_function_constant_defined(sc_BlendMode_MultiplyOriginal) ? sc_BlendMode_MultiplyOriginal : false;
constant bool sc_BlendMode_Multiply [[function_constant(58)]];
constant bool sc_BlendMode_Multiply_tmp = is_function_constant_defined(sc_BlendMode_Multiply) ? sc_BlendMode_Multiply : false;
constant bool sc_BlendMode_Normal [[function_constant(59)]];
constant bool sc_BlendMode_Normal_tmp = is_function_constant_defined(sc_BlendMode_Normal) ? sc_BlendMode_Normal : false;
constant bool sc_BlendMode_PremultipliedAlphaAuto [[function_constant(60)]];
constant bool sc_BlendMode_PremultipliedAlphaAuto_tmp = is_function_constant_defined(sc_BlendMode_PremultipliedAlphaAuto) ? sc_BlendMode_PremultipliedAlphaAuto : false;
constant bool sc_BlendMode_PremultipliedAlphaHardware [[function_constant(61)]];
constant bool sc_BlendMode_PremultipliedAlphaHardware_tmp = is_function_constant_defined(sc_BlendMode_PremultipliedAlphaHardware) ? sc_BlendMode_PremultipliedAlphaHardware : false;
constant bool sc_BlendMode_PremultipliedAlpha [[function_constant(62)]];
constant bool sc_BlendMode_PremultipliedAlpha_tmp = is_function_constant_defined(sc_BlendMode_PremultipliedAlpha) ? sc_BlendMode_PremultipliedAlpha : false;
constant bool sc_BlendMode_Screen [[function_constant(63)]];
constant bool sc_BlendMode_Screen_tmp = is_function_constant_defined(sc_BlendMode_Screen) ? sc_BlendMode_Screen : false;
constant bool sc_DepthOnly [[function_constant(64)]];
constant bool sc_DepthOnly_tmp = is_function_constant_defined(sc_DepthOnly) ? sc_DepthOnly : false;
constant bool sc_FramebufferFetch [[function_constant(65)]];
constant bool sc_FramebufferFetch_tmp = is_function_constant_defined(sc_FramebufferFetch) ? sc_FramebufferFetch : false;
constant bool sc_MotionVectorsPass [[function_constant(66)]];
constant bool sc_MotionVectorsPass_tmp = is_function_constant_defined(sc_MotionVectorsPass) ? sc_MotionVectorsPass : false;
constant bool sc_OITCompositingPass [[function_constant(67)]];
constant bool sc_OITCompositingPass_tmp = is_function_constant_defined(sc_OITCompositingPass) ? sc_OITCompositingPass : false;
constant bool sc_OITDepthBoundsPass [[function_constant(68)]];
constant bool sc_OITDepthBoundsPass_tmp = is_function_constant_defined(sc_OITDepthBoundsPass) ? sc_OITDepthBoundsPass : false;
constant bool sc_OITDepthGatherPass [[function_constant(69)]];
constant bool sc_OITDepthGatherPass_tmp = is_function_constant_defined(sc_OITDepthGatherPass) ? sc_OITDepthGatherPass : false;
constant bool sc_ProjectiveShadowsCaster [[function_constant(70)]];
constant bool sc_ProjectiveShadowsCaster_tmp = is_function_constant_defined(sc_ProjectiveShadowsCaster) ? sc_ProjectiveShadowsCaster : false;
constant bool sc_ProjectiveShadowsReceiver [[function_constant(71)]];
constant bool sc_ProjectiveShadowsReceiver_tmp = is_function_constant_defined(sc_ProjectiveShadowsReceiver) ? sc_ProjectiveShadowsReceiver : false;
constant bool sc_RenderAlphaToColor [[function_constant(72)]];
constant bool sc_RenderAlphaToColor_tmp = is_function_constant_defined(sc_RenderAlphaToColor) ? sc_RenderAlphaToColor : false;
constant bool sc_ScreenTextureHasSwappedViews [[function_constant(73)]];
constant bool sc_ScreenTextureHasSwappedViews_tmp = is_function_constant_defined(sc_ScreenTextureHasSwappedViews) ? sc_ScreenTextureHasSwappedViews : false;
constant bool sc_ShaderComplexityAnalyzer [[function_constant(74)]];
constant bool sc_ShaderComplexityAnalyzer_tmp = is_function_constant_defined(sc_ShaderComplexityAnalyzer) ? sc_ShaderComplexityAnalyzer : false;
constant bool sc_UseFramebufferFetchMarker [[function_constant(75)]];
constant bool sc_UseFramebufferFetchMarker_tmp = is_function_constant_defined(sc_UseFramebufferFetchMarker) ? sc_UseFramebufferFetchMarker : false;
constant bool sc_VertexBlendingUseNormals [[function_constant(76)]];
constant bool sc_VertexBlendingUseNormals_tmp = is_function_constant_defined(sc_VertexBlendingUseNormals) ? sc_VertexBlendingUseNormals : false;
constant bool sc_VertexBlending [[function_constant(77)]];
constant bool sc_VertexBlending_tmp = is_function_constant_defined(sc_VertexBlending) ? sc_VertexBlending : false;
constant bool screenTextureHasSwappedViews [[function_constant(78)]];
constant bool screenTextureHasSwappedViews_tmp = is_function_constant_defined(screenTextureHasSwappedViews) ? screenTextureHasSwappedViews : false;
constant int SC_SOFTWARE_WRAP_MODE_U_baseTex [[function_constant(79)]];
constant int SC_SOFTWARE_WRAP_MODE_U_baseTex_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_baseTex) ? SC_SOFTWARE_WRAP_MODE_U_baseTex : -1;
constant int SC_SOFTWARE_WRAP_MODE_U_intensityTexture [[function_constant(80)]];
constant int SC_SOFTWARE_WRAP_MODE_U_intensityTexture_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_intensityTexture) ? SC_SOFTWARE_WRAP_MODE_U_intensityTexture : -1;
constant int SC_SOFTWARE_WRAP_MODE_U_opacityTex [[function_constant(81)]];
constant int SC_SOFTWARE_WRAP_MODE_U_opacityTex_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_opacityTex) ? SC_SOFTWARE_WRAP_MODE_U_opacityTex : -1;
constant int SC_SOFTWARE_WRAP_MODE_U_screenTexture [[function_constant(82)]];
constant int SC_SOFTWARE_WRAP_MODE_U_screenTexture_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_screenTexture) ? SC_SOFTWARE_WRAP_MODE_U_screenTexture : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_baseTex [[function_constant(83)]];
constant int SC_SOFTWARE_WRAP_MODE_V_baseTex_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_baseTex) ? SC_SOFTWARE_WRAP_MODE_V_baseTex : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_intensityTexture [[function_constant(84)]];
constant int SC_SOFTWARE_WRAP_MODE_V_intensityTexture_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_intensityTexture) ? SC_SOFTWARE_WRAP_MODE_V_intensityTexture : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_opacityTex [[function_constant(85)]];
constant int SC_SOFTWARE_WRAP_MODE_V_opacityTex_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_opacityTex) ? SC_SOFTWARE_WRAP_MODE_V_opacityTex : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_screenTexture [[function_constant(86)]];
constant int SC_SOFTWARE_WRAP_MODE_V_screenTexture_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_screenTexture) ? SC_SOFTWARE_WRAP_MODE_V_screenTexture : -1;
constant int baseTexLayout [[function_constant(87)]];
constant int baseTexLayout_tmp = is_function_constant_defined(baseTexLayout) ? baseTexLayout : 0;
constant int intensityTextureLayout [[function_constant(88)]];
constant int intensityTextureLayout_tmp = is_function_constant_defined(intensityTextureLayout) ? intensityTextureLayout : 0;
constant int opacityTexLayout [[function_constant(89)]];
constant int opacityTexLayout_tmp = is_function_constant_defined(opacityTexLayout) ? opacityTexLayout : 0;
constant int sc_DepthBufferMode [[function_constant(90)]];
constant int sc_DepthBufferMode_tmp = is_function_constant_defined(sc_DepthBufferMode) ? sc_DepthBufferMode : 0;
constant int sc_RenderingSpace [[function_constant(91)]];
constant int sc_RenderingSpace_tmp = is_function_constant_defined(sc_RenderingSpace) ? sc_RenderingSpace : -1;
constant int sc_ScreenTextureLayout [[function_constant(92)]];
constant int sc_ScreenTextureLayout_tmp = is_function_constant_defined(sc_ScreenTextureLayout) ? sc_ScreenTextureLayout : 0;
constant int sc_ShaderCacheConstant [[function_constant(93)]];
constant int sc_ShaderCacheConstant_tmp = is_function_constant_defined(sc_ShaderCacheConstant) ? sc_ShaderCacheConstant : 0;
constant int sc_SkinBonesCount [[function_constant(94)]];
constant int sc_SkinBonesCount_tmp = is_function_constant_defined(sc_SkinBonesCount) ? sc_SkinBonesCount : 0;
constant int sc_StereoRenderingMode [[function_constant(95)]];
constant int sc_StereoRenderingMode_tmp = is_function_constant_defined(sc_StereoRenderingMode) ? sc_StereoRenderingMode : 0;
constant int sc_StereoRendering_IsClipDistanceEnabled [[function_constant(96)]];
constant int sc_StereoRendering_IsClipDistanceEnabled_tmp = is_function_constant_defined(sc_StereoRendering_IsClipDistanceEnabled) ? sc_StereoRendering_IsClipDistanceEnabled : 0;
constant int screenTextureLayout [[function_constant(97)]];
constant int screenTextureLayout_tmp = is_function_constant_defined(screenTextureLayout) ? screenTextureLayout : 0;

namespace SNAP_VS {
struct sc_Vertex_t
{
float4 position;
float3 normal;
float3 tangent;
float2 texture0;
float2 texture1;
};
struct sc_PointLight_t
{
int falloffEnabled;
float falloffEndDistance;
float negRcpFalloffEndDistance4;
float angleScale;
float angleOffset;
float3 direction;
float3 position;
float4 color;
};
struct sc_DirectionalLight_t
{
float3 direction;
float4 color;
};
struct sc_AmbientLight_t
{
float3 color;
float intensity;
};
struct sc_SphericalGaussianLight_t
{
float3 color;
float sharpness;
float3 axis;
};
struct sc_LightEstimationData_t
{
sc_SphericalGaussianLight_t sg[12];
float3 ambientLight;
};
struct sc_Camera_t
{
float3 position;
float aspect;
float2 clipPlanes;
};
struct userUniformsObj
{
sc_PointLight_t sc_PointLights[3];
sc_DirectionalLight_t sc_DirectionalLights[5];
sc_AmbientLight_t sc_AmbientLights[3];
sc_LightEstimationData_t sc_LightEstimationData;
float4 sc_EnvmapDiffuseSize;
float4 sc_EnvmapDiffuseDims;
float4 sc_EnvmapDiffuseView;
float4 sc_EnvmapSpecularSize;
float4 sc_EnvmapSpecularDims;
float4 sc_EnvmapSpecularView;
float3 sc_EnvmapRotation;
float sc_EnvmapExposure;
float3 sc_Sh[9];
float sc_ShIntensity;
float4 sc_Time;
float4 sc_UniformConstants;
float4 sc_GeometryInfo;
float4x4 sc_ModelViewProjectionMatrixArray[2];
float4x4 sc_ModelViewProjectionMatrixInverseArray[2];
float4x4 sc_ViewProjectionMatrixArray[2];
float4x4 sc_ViewProjectionMatrixInverseArray[2];
float4x4 sc_ModelViewMatrixArray[2];
float4x4 sc_ModelViewMatrixInverseArray[2];
float3x3 sc_ViewNormalMatrixArray[2];
float3x3 sc_ViewNormalMatrixInverseArray[2];
float4x4 sc_ProjectionMatrixArray[2];
float4x4 sc_ProjectionMatrixInverseArray[2];
float4x4 sc_ViewMatrixArray[2];
float4x4 sc_ViewMatrixInverseArray[2];
float4x4 sc_PrevFrameViewProjectionMatrixArray[2];
float4x4 sc_ModelMatrix;
float4x4 sc_ModelMatrixInverse;
float3x3 sc_NormalMatrix;
float3x3 sc_NormalMatrixInverse;
float4x4 sc_PrevFrameModelMatrix;
float4x4 sc_PrevFrameModelMatrixInverse;
float3 sc_LocalAabbMin;
float3 sc_LocalAabbMax;
float3 sc_WorldAabbMin;
float3 sc_WorldAabbMax;
float4 sc_WindowToViewportTransform;
float4 sc_CurrentRenderTargetDims;
sc_Camera_t sc_Camera;
float sc_ShadowDensity;
float4 sc_ShadowColor;
float4x4 sc_ProjectorMatrix;
float _sc_GetFramebufferColorInvalidUsageMarker;
float shaderComplexityValue;
float sc_DisableFrustumCullingMarker;
float4 weights0;
float4 weights1;
float4 weights2;
float4 sc_StereoClipPlanes[2];
int sc_FallbackInstanceID;
float _sc_framebufferFetchMarker;
float2 sc_TAAJitterOffset;
float strandWidth;
float strandTaper;
float4 sc_StrandDataMapTextureSize;
float clumpInstanceCount;
float clumpRadius;
float clumpTipScale;
float hairstyleInstanceCount;
float hairstyleNoise;
float4 sc_ScreenTextureSize;
float4 sc_ScreenTextureDims;
float4 sc_ScreenTextureView;
float correctedIntensity;
float4 intensityTextureSize;
float4 intensityTextureDims;
float4 intensityTextureView;
float3x3 intensityTextureTransform;
float4 intensityTextureUvMinMax;
float4 intensityTextureBorderColor;
float reflBlurWidth;
float reflBlurMinRough;
float reflBlurMaxRough;
int overrideTimeEnabled;
float overrideTimeElapsed;
float overrideTimeDelta;
int PreviewEnabled;
int PreviewNodeID;
float alphaTestThreshold;
float4 screenTextureSize;
float4 screenTextureDims;
float4 screenTextureView;
float3x3 screenTextureTransform;
float4 screenTextureUvMinMax;
float4 screenTextureBorderColor;
float4 baseTexSize;
float4 baseTexDims;
float4 baseTexView;
float3x3 baseTexTransform;
float4 baseTexUvMinMax;
float4 baseTexBorderColor;
float4 baseColor;
float4 opacityTexSize;
float4 opacityTexDims;
float4 opacityTexView;
float3x3 opacityTexTransform;
float4 opacityTexUvMinMax;
float4 opacityTexBorderColor;
float opacity;
float Port_Input2_N011;
};
struct sc_Bone_t
{
float4 boneMatrix[3];
float4 normalMatrix[3];
};
struct sc_Bones_obj
{
sc_Bone_t sc_Bones[1];
};
struct ssPreviewInfo
{
float4 Color;
bool Saved;
};
struct sc_Set0
{
constant sc_Bones_obj* sc_BonesUBO [[id(0)]];
texture2d<float> baseTex [[id(1)]];
texture2d<float> intensityTexture [[id(2)]];
texture2d<float> opacityTex [[id(3)]];
texture2d<float> sc_ScreenTexture [[id(15)]];
texture2d<float> screenTexture [[id(18)]];
sampler baseTexSmpSC [[id(19)]];
sampler intensityTextureSmpSC [[id(20)]];
sampler opacityTexSmpSC [[id(21)]];
sampler sc_ScreenTextureSmpSC [[id(26)]];
sampler screenTextureSmpSC [[id(29)]];
constant userUniformsObj* UserUniforms [[id(30)]];
};
struct main_vert_out
{
float3 varPos [[user(locn0)]];
float3 varNormal [[user(locn1)]];
float4 varTangent [[user(locn2)]];
float4 varPackedTex [[user(locn3)]];
float4 varScreenPos [[user(locn4)]];
float2 varScreenTexturePos [[user(locn5)]];
float varViewSpaceDepth [[user(locn6)]];
float2 varShadowTex [[user(locn7)]];
int varStereoViewID [[user(locn8)]];
float varClipDistance [[user(locn9)]];
float4 varColor [[user(locn10)]];
float4 PreviewVertexColor [[user(locn11)]];
float PreviewVertexSaved [[user(locn12)]];
float4 gl_Position [[position]];
};
struct main_vert_in
{
float4 position [[attribute(0)]];
float3 normal [[attribute(1)]];
float4 tangent [[attribute(2)]];
float2 texture0 [[attribute(3)]];
float2 texture1 [[attribute(4)]];
float4 boneData [[attribute(5)]];
float3 blendShape0Pos [[attribute(6)]];
float3 blendShape1Pos [[attribute(7)]];
float3 blendShape2Pos [[attribute(8)]];
float3 blendShape3Pos [[attribute(9)]];
float3 blendShape4Pos [[attribute(10)]];
float3 blendShape5Pos [[attribute(11)]];
float3 blendShape0Normal [[attribute(12)]];
float3 blendShape1Normal [[attribute(13)]];
float3 blendShape2Normal [[attribute(14)]];
float3 positionNext [[attribute(15)]];
float3 positionPrevious [[attribute(16)]];
float4 strandProperties [[attribute(17)]];
float4 color [[attribute(18)]];
};
vertex main_vert_out main_vert(main_vert_in in [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],uint gl_InstanceIndex [[instance_id]])
{
main_vert_out out={};
out.PreviewVertexColor=float4(0.5);
ssPreviewInfo PreviewInfo;
PreviewInfo.Color=float4(0.5);
PreviewInfo.Saved=false;
out.PreviewVertexSaved=0.0;
sc_Vertex_t l9_0;
l9_0.position=in.position;
l9_0.normal=in.normal;
l9_0.tangent=in.tangent.xyz;
l9_0.texture0=in.texture0;
l9_0.texture1=in.texture1;
sc_Vertex_t l9_1=l9_0;
sc_Vertex_t param=l9_1;
sc_Vertex_t l9_2=param;
if ((int(sc_VertexBlending_tmp)!=0))
{
if ((int(sc_VertexBlendingUseNormals_tmp)!=0))
{
sc_Vertex_t l9_3=l9_2;
float3 l9_4=in.blendShape0Pos;
float3 l9_5=in.blendShape0Normal;
float l9_6=(*sc_set0.UserUniforms).weights0.x;
sc_Vertex_t l9_7=l9_3;
float3 l9_8=l9_4;
float l9_9=l9_6;
float3 l9_10=l9_7.position.xyz+(l9_8*l9_9);
l9_7.position=float4(l9_10.x,l9_10.y,l9_10.z,l9_7.position.w);
l9_3=l9_7;
l9_3.normal+=(l9_5*l9_6);
l9_2=l9_3;
sc_Vertex_t l9_11=l9_2;
float3 l9_12=in.blendShape1Pos;
float3 l9_13=in.blendShape1Normal;
float l9_14=(*sc_set0.UserUniforms).weights0.y;
sc_Vertex_t l9_15=l9_11;
float3 l9_16=l9_12;
float l9_17=l9_14;
float3 l9_18=l9_15.position.xyz+(l9_16*l9_17);
l9_15.position=float4(l9_18.x,l9_18.y,l9_18.z,l9_15.position.w);
l9_11=l9_15;
l9_11.normal+=(l9_13*l9_14);
l9_2=l9_11;
sc_Vertex_t l9_19=l9_2;
float3 l9_20=in.blendShape2Pos;
float3 l9_21=in.blendShape2Normal;
float l9_22=(*sc_set0.UserUniforms).weights0.z;
sc_Vertex_t l9_23=l9_19;
float3 l9_24=l9_20;
float l9_25=l9_22;
float3 l9_26=l9_23.position.xyz+(l9_24*l9_25);
l9_23.position=float4(l9_26.x,l9_26.y,l9_26.z,l9_23.position.w);
l9_19=l9_23;
l9_19.normal+=(l9_21*l9_22);
l9_2=l9_19;
}
else
{
sc_Vertex_t l9_27=l9_2;
float3 l9_28=in.blendShape0Pos;
float l9_29=(*sc_set0.UserUniforms).weights0.x;
float3 l9_30=l9_27.position.xyz+(l9_28*l9_29);
l9_27.position=float4(l9_30.x,l9_30.y,l9_30.z,l9_27.position.w);
l9_2=l9_27;
sc_Vertex_t l9_31=l9_2;
float3 l9_32=in.blendShape1Pos;
float l9_33=(*sc_set0.UserUniforms).weights0.y;
float3 l9_34=l9_31.position.xyz+(l9_32*l9_33);
l9_31.position=float4(l9_34.x,l9_34.y,l9_34.z,l9_31.position.w);
l9_2=l9_31;
sc_Vertex_t l9_35=l9_2;
float3 l9_36=in.blendShape2Pos;
float l9_37=(*sc_set0.UserUniforms).weights0.z;
float3 l9_38=l9_35.position.xyz+(l9_36*l9_37);
l9_35.position=float4(l9_38.x,l9_38.y,l9_38.z,l9_35.position.w);
l9_2=l9_35;
sc_Vertex_t l9_39=l9_2;
float3 l9_40=in.blendShape3Pos;
float l9_41=(*sc_set0.UserUniforms).weights0.w;
float3 l9_42=l9_39.position.xyz+(l9_40*l9_41);
l9_39.position=float4(l9_42.x,l9_42.y,l9_42.z,l9_39.position.w);
l9_2=l9_39;
sc_Vertex_t l9_43=l9_2;
float3 l9_44=in.blendShape4Pos;
float l9_45=(*sc_set0.UserUniforms).weights1.x;
float3 l9_46=l9_43.position.xyz+(l9_44*l9_45);
l9_43.position=float4(l9_46.x,l9_46.y,l9_46.z,l9_43.position.w);
l9_2=l9_43;
sc_Vertex_t l9_47=l9_2;
float3 l9_48=in.blendShape5Pos;
float l9_49=(*sc_set0.UserUniforms).weights1.y;
float3 l9_50=l9_47.position.xyz+(l9_48*l9_49);
l9_47.position=float4(l9_50.x,l9_50.y,l9_50.z,l9_47.position.w);
l9_2=l9_47;
}
}
param=l9_2;
sc_Vertex_t l9_51=param;
if (sc_SkinBonesCount_tmp>0)
{
float4 l9_52=float4(0.0);
if (sc_SkinBonesCount_tmp>0)
{
l9_52=float4(1.0,fract(in.boneData.yzw));
l9_52.x-=dot(l9_52.yzw,float3(1.0));
}
float4 l9_53=l9_52;
float4 l9_54=l9_53;
int l9_55=int(in.boneData.x);
int l9_56=int(in.boneData.y);
int l9_57=int(in.boneData.z);
int l9_58=int(in.boneData.w);
int l9_59=l9_55;
float4 l9_60=l9_51.position;
float3 l9_61=float3(0.0);
if (sc_SkinBonesCount_tmp>0)
{
int l9_62=l9_59;
float4 l9_63=(*sc_set0.sc_BonesUBO).sc_Bones[l9_62].boneMatrix[0];
float4 l9_64=(*sc_set0.sc_BonesUBO).sc_Bones[l9_62].boneMatrix[1];
float4 l9_65=(*sc_set0.sc_BonesUBO).sc_Bones[l9_62].boneMatrix[2];
float4 l9_66[3];
l9_66[0]=l9_63;
l9_66[1]=l9_64;
l9_66[2]=l9_65;
l9_61=float3(dot(l9_60,l9_66[0]),dot(l9_60,l9_66[1]),dot(l9_60,l9_66[2]));
}
else
{
l9_61=l9_60.xyz;
}
float3 l9_67=l9_61;
float3 l9_68=l9_67;
float l9_69=l9_54.x;
int l9_70=l9_56;
float4 l9_71=l9_51.position;
float3 l9_72=float3(0.0);
if (sc_SkinBonesCount_tmp>0)
{
int l9_73=l9_70;
float4 l9_74=(*sc_set0.sc_BonesUBO).sc_Bones[l9_73].boneMatrix[0];
float4 l9_75=(*sc_set0.sc_BonesUBO).sc_Bones[l9_73].boneMatrix[1];
float4 l9_76=(*sc_set0.sc_BonesUBO).sc_Bones[l9_73].boneMatrix[2];
float4 l9_77[3];
l9_77[0]=l9_74;
l9_77[1]=l9_75;
l9_77[2]=l9_76;
l9_72=float3(dot(l9_71,l9_77[0]),dot(l9_71,l9_77[1]),dot(l9_71,l9_77[2]));
}
else
{
l9_72=l9_71.xyz;
}
float3 l9_78=l9_72;
float3 l9_79=l9_78;
float l9_80=l9_54.y;
int l9_81=l9_57;
float4 l9_82=l9_51.position;
float3 l9_83=float3(0.0);
if (sc_SkinBonesCount_tmp>0)
{
int l9_84=l9_81;
float4 l9_85=(*sc_set0.sc_BonesUBO).sc_Bones[l9_84].boneMatrix[0];
float4 l9_86=(*sc_set0.sc_BonesUBO).sc_Bones[l9_84].boneMatrix[1];
float4 l9_87=(*sc_set0.sc_BonesUBO).sc_Bones[l9_84].boneMatrix[2];
float4 l9_88[3];
l9_88[0]=l9_85;
l9_88[1]=l9_86;
l9_88[2]=l9_87;
l9_83=float3(dot(l9_82,l9_88[0]),dot(l9_82,l9_88[1]),dot(l9_82,l9_88[2]));
}
else
{
l9_83=l9_82.xyz;
}
float3 l9_89=l9_83;
float3 l9_90=l9_89;
float l9_91=l9_54.z;
int l9_92=l9_58;
float4 l9_93=l9_51.position;
float3 l9_94=float3(0.0);
if (sc_SkinBonesCount_tmp>0)
{
int l9_95=l9_92;
float4 l9_96=(*sc_set0.sc_BonesUBO).sc_Bones[l9_95].boneMatrix[0];
float4 l9_97=(*sc_set0.sc_BonesUBO).sc_Bones[l9_95].boneMatrix[1];
float4 l9_98=(*sc_set0.sc_BonesUBO).sc_Bones[l9_95].boneMatrix[2];
float4 l9_99[3];
l9_99[0]=l9_96;
l9_99[1]=l9_97;
l9_99[2]=l9_98;
l9_94=float3(dot(l9_93,l9_99[0]),dot(l9_93,l9_99[1]),dot(l9_93,l9_99[2]));
}
else
{
l9_94=l9_93.xyz;
}
float3 l9_100=l9_94;
float3 l9_101=(((l9_68*l9_69)+(l9_79*l9_80))+(l9_90*l9_91))+(l9_100*l9_54.w);
l9_51.position=float4(l9_101.x,l9_101.y,l9_101.z,l9_51.position.w);
int l9_102=l9_55;
float3x3 l9_103=float3x3(float3((*sc_set0.sc_BonesUBO).sc_Bones[l9_102].normalMatrix[0].xyz),float3((*sc_set0.sc_BonesUBO).sc_Bones[l9_102].normalMatrix[1].xyz),float3((*sc_set0.sc_BonesUBO).sc_Bones[l9_102].normalMatrix[2].xyz));
float3x3 l9_104=l9_103;
float3x3 l9_105=l9_104;
int l9_106=l9_56;
float3x3 l9_107=float3x3(float3((*sc_set0.sc_BonesUBO).sc_Bones[l9_106].normalMatrix[0].xyz),float3((*sc_set0.sc_BonesUBO).sc_Bones[l9_106].normalMatrix[1].xyz),float3((*sc_set0.sc_BonesUBO).sc_Bones[l9_106].normalMatrix[2].xyz));
float3x3 l9_108=l9_107;
float3x3 l9_109=l9_108;
int l9_110=l9_57;
float3x3 l9_111=float3x3(float3((*sc_set0.sc_BonesUBO).sc_Bones[l9_110].normalMatrix[0].xyz),float3((*sc_set0.sc_BonesUBO).sc_Bones[l9_110].normalMatrix[1].xyz),float3((*sc_set0.sc_BonesUBO).sc_Bones[l9_110].normalMatrix[2].xyz));
float3x3 l9_112=l9_111;
float3x3 l9_113=l9_112;
int l9_114=l9_58;
float3x3 l9_115=float3x3(float3((*sc_set0.sc_BonesUBO).sc_Bones[l9_114].normalMatrix[0].xyz),float3((*sc_set0.sc_BonesUBO).sc_Bones[l9_114].normalMatrix[1].xyz),float3((*sc_set0.sc_BonesUBO).sc_Bones[l9_114].normalMatrix[2].xyz));
float3x3 l9_116=l9_115;
float3x3 l9_117=l9_116;
l9_51.normal=((((l9_105*l9_51.normal)*l9_54.x)+((l9_109*l9_51.normal)*l9_54.y))+((l9_113*l9_51.normal)*l9_54.z))+((l9_117*l9_51.normal)*l9_54.w);
l9_51.tangent=((((l9_105*l9_51.tangent)*l9_54.x)+((l9_109*l9_51.tangent)*l9_54.y))+((l9_113*l9_51.tangent)*l9_54.z))+((l9_117*l9_51.tangent)*l9_54.w);
}
param=l9_51;
if (sc_RenderingSpace_tmp==3)
{
out.varPos=float3(0.0);
out.varNormal=param.normal;
out.varTangent=float4(param.tangent.x,param.tangent.y,param.tangent.z,out.varTangent.w);
}
else
{
if (sc_RenderingSpace_tmp==4)
{
out.varPos=float3(0.0);
out.varNormal=param.normal;
out.varTangent=float4(param.tangent.x,param.tangent.y,param.tangent.z,out.varTangent.w);
}
else
{
if (sc_RenderingSpace_tmp==2)
{
out.varPos=param.position.xyz;
out.varNormal=param.normal;
out.varTangent=float4(param.tangent.x,param.tangent.y,param.tangent.z,out.varTangent.w);
}
else
{
if (sc_RenderingSpace_tmp==1)
{
out.varPos=((*sc_set0.UserUniforms).sc_ModelMatrix*param.position).xyz;
out.varNormal=(*sc_set0.UserUniforms).sc_NormalMatrix*param.normal;
float3 l9_118=(*sc_set0.UserUniforms).sc_NormalMatrix*param.tangent;
out.varTangent=float4(l9_118.x,l9_118.y,l9_118.z,out.varTangent.w);
}
}
}
}
if ((*sc_set0.UserUniforms).PreviewEnabled==1)
{
param.texture0.x=1.0-param.texture0.x;
}
out.varColor=in.color;
sc_Vertex_t v=param;
float3 WorldPosition=out.varPos;
float3 WorldNormal=out.varNormal;
float3 WorldTangent=out.varTangent.xyz;
if ((*sc_set0.UserUniforms).PreviewEnabled==1)
{
WorldPosition=out.varPos;
WorldNormal=out.varNormal;
WorldTangent=out.varTangent.xyz;
}
sc_Vertex_t param_1=v;
float3 param_2=WorldPosition;
float3 param_3=WorldNormal;
float3 param_4=WorldTangent;
float4 param_5=v.position;
out.varPos=param_2;
out.varNormal=normalize(param_3);
float3 l9_119=normalize(param_4);
out.varTangent=float4(l9_119.x,l9_119.y,l9_119.z,out.varTangent.w);
out.varTangent.w=in.tangent.w;
if ((int(UseViewSpaceDepthVariant_tmp)!=0)&&(((int(sc_OITDepthGatherPass_tmp)!=0)||(int(sc_OITCompositingPass_tmp)!=0))||(int(sc_OITDepthBoundsPass_tmp)!=0)))
{
float4 l9_120=param_1.position;
float4 l9_121=float4(0.0);
if (sc_RenderingSpace_tmp==3)
{
int l9_122=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_122=0;
}
else
{
l9_122=gl_InstanceIndex%2;
}
int l9_123=l9_122;
l9_121=(*sc_set0.UserUniforms).sc_ProjectionMatrixInverseArray[l9_123]*l9_120;
}
else
{
if (sc_RenderingSpace_tmp==2)
{
int l9_124=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_124=0;
}
else
{
l9_124=gl_InstanceIndex%2;
}
int l9_125=l9_124;
l9_121=(*sc_set0.UserUniforms).sc_ViewMatrixArray[l9_125]*l9_120;
}
else
{
if (sc_RenderingSpace_tmp==1)
{
int l9_126=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_126=0;
}
else
{
l9_126=gl_InstanceIndex%2;
}
int l9_127=l9_126;
l9_121=(*sc_set0.UserUniforms).sc_ModelViewMatrixArray[l9_127]*l9_120;
}
else
{
l9_121=l9_120;
}
}
}
float4 l9_128=l9_121;
out.varViewSpaceDepth=-l9_128.z;
}
float4 l9_129=float4(0.0);
if (sc_RenderingSpace_tmp==3)
{
l9_129=param_5;
}
else
{
if (sc_RenderingSpace_tmp==4)
{
int l9_130=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_130=0;
}
else
{
l9_130=gl_InstanceIndex%2;
}
int l9_131=l9_130;
l9_129=((*sc_set0.UserUniforms).sc_ModelViewMatrixArray[l9_131]*param_1.position)*float4(1.0/(*sc_set0.UserUniforms).sc_Camera.aspect,1.0,1.0,1.0);
}
else
{
if (sc_RenderingSpace_tmp==2)
{
int l9_132=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_132=0;
}
else
{
l9_132=gl_InstanceIndex%2;
}
int l9_133=l9_132;
l9_129=(*sc_set0.UserUniforms).sc_ViewProjectionMatrixArray[l9_133]*float4(out.varPos,1.0);
}
else
{
if (sc_RenderingSpace_tmp==1)
{
int l9_134=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_134=0;
}
else
{
l9_134=gl_InstanceIndex%2;
}
int l9_135=l9_134;
l9_129=(*sc_set0.UserUniforms).sc_ViewProjectionMatrixArray[l9_135]*float4(out.varPos,1.0);
}
}
}
}
out.varPackedTex=float4(param_1.texture0,param_1.texture1);
if ((int(sc_ProjectiveShadowsReceiver_tmp)!=0))
{
float4 l9_136=param_1.position;
float4 l9_137=l9_136;
if (sc_RenderingSpace_tmp==1)
{
l9_137=(*sc_set0.UserUniforms).sc_ModelMatrix*l9_136;
}
float4 l9_138=(*sc_set0.UserUniforms).sc_ProjectorMatrix*l9_137;
float2 l9_139=((l9_138.xy/float2(l9_138.w))*0.5)+float2(0.5);
out.varShadowTex=l9_139;
}
float4 l9_140=l9_129;
if (sc_DepthBufferMode_tmp==1)
{
int l9_141=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_141=0;
}
else
{
l9_141=gl_InstanceIndex%2;
}
int l9_142=l9_141;
if ((*sc_set0.UserUniforms).sc_ProjectionMatrixArray[l9_142][2].w!=0.0)
{
float l9_143=2.0/log2((*sc_set0.UserUniforms).sc_Camera.clipPlanes.y+1.0);
l9_140.z=((log2(fast::max((*sc_set0.UserUniforms).sc_Camera.clipPlanes.x,1.0+l9_140.w))*l9_143)-1.0)*l9_140.w;
}
}
float4 l9_144=l9_140;
l9_129=l9_144;
float4 l9_145=l9_129;
float4 l9_146=l9_145;
if (sc_ShaderCacheConstant_tmp!=0)
{
l9_146.x+=((*sc_set0.UserUniforms).sc_UniformConstants.x*float(sc_ShaderCacheConstant_tmp));
}
if (sc_StereoRenderingMode_tmp>0)
{
out.varStereoViewID=gl_InstanceIndex%2;
}
float4 l9_147=l9_146;
if (sc_StereoRenderingMode_tmp==1)
{
float l9_148=dot(l9_147,(*sc_set0.UserUniforms).sc_StereoClipPlanes[gl_InstanceIndex%2]);
float l9_149=l9_148;
if (sc_StereoRendering_IsClipDistanceEnabled_tmp==1)
{
}
else
{
out.varClipDistance=l9_149;
}
}
float4 l9_150=float4(l9_146.x,-l9_146.y,(l9_146.z*0.5)+(l9_146.w*0.5),l9_146.w);
out.gl_Position=l9_150;
v=param_1;
if (PreviewInfo.Saved)
{
out.PreviewVertexColor=float4(PreviewInfo.Color.xyz,1.0);
out.PreviewVertexSaved=1.0;
}
return out;
}
} // VERTEX SHADER


namespace SNAP_FS {
struct ssGlobals
{
float gTimeElapsed;
float gTimeDelta;
float gTimeElapsedShifted;
float2 gScreenCoord;
};
struct sc_PointLight_t
{
int falloffEnabled;
float falloffEndDistance;
float negRcpFalloffEndDistance4;
float angleScale;
float angleOffset;
float3 direction;
float3 position;
float4 color;
};
struct sc_DirectionalLight_t
{
float3 direction;
float4 color;
};
struct sc_AmbientLight_t
{
float3 color;
float intensity;
};
struct sc_SphericalGaussianLight_t
{
float3 color;
float sharpness;
float3 axis;
};
struct sc_LightEstimationData_t
{
sc_SphericalGaussianLight_t sg[12];
float3 ambientLight;
};
struct sc_Camera_t
{
float3 position;
float aspect;
float2 clipPlanes;
};
struct userUniformsObj
{
sc_PointLight_t sc_PointLights[3];
sc_DirectionalLight_t sc_DirectionalLights[5];
sc_AmbientLight_t sc_AmbientLights[3];
sc_LightEstimationData_t sc_LightEstimationData;
float4 sc_EnvmapDiffuseSize;
float4 sc_EnvmapDiffuseDims;
float4 sc_EnvmapDiffuseView;
float4 sc_EnvmapSpecularSize;
float4 sc_EnvmapSpecularDims;
float4 sc_EnvmapSpecularView;
float3 sc_EnvmapRotation;
float sc_EnvmapExposure;
float3 sc_Sh[9];
float sc_ShIntensity;
float4 sc_Time;
float4 sc_UniformConstants;
float4 sc_GeometryInfo;
float4x4 sc_ModelViewProjectionMatrixArray[2];
float4x4 sc_ModelViewProjectionMatrixInverseArray[2];
float4x4 sc_ViewProjectionMatrixArray[2];
float4x4 sc_ViewProjectionMatrixInverseArray[2];
float4x4 sc_ModelViewMatrixArray[2];
float4x4 sc_ModelViewMatrixInverseArray[2];
float3x3 sc_ViewNormalMatrixArray[2];
float3x3 sc_ViewNormalMatrixInverseArray[2];
float4x4 sc_ProjectionMatrixArray[2];
float4x4 sc_ProjectionMatrixInverseArray[2];
float4x4 sc_ViewMatrixArray[2];
float4x4 sc_ViewMatrixInverseArray[2];
float4x4 sc_PrevFrameViewProjectionMatrixArray[2];
float4x4 sc_ModelMatrix;
float4x4 sc_ModelMatrixInverse;
float3x3 sc_NormalMatrix;
float3x3 sc_NormalMatrixInverse;
float4x4 sc_PrevFrameModelMatrix;
float4x4 sc_PrevFrameModelMatrixInverse;
float3 sc_LocalAabbMin;
float3 sc_LocalAabbMax;
float3 sc_WorldAabbMin;
float3 sc_WorldAabbMax;
float4 sc_WindowToViewportTransform;
float4 sc_CurrentRenderTargetDims;
sc_Camera_t sc_Camera;
float sc_ShadowDensity;
float4 sc_ShadowColor;
float4x4 sc_ProjectorMatrix;
float _sc_GetFramebufferColorInvalidUsageMarker;
float shaderComplexityValue;
float sc_DisableFrustumCullingMarker;
float4 weights0;
float4 weights1;
float4 weights2;
float4 sc_StereoClipPlanes[2];
int sc_FallbackInstanceID;
float _sc_framebufferFetchMarker;
float2 sc_TAAJitterOffset;
float strandWidth;
float strandTaper;
float4 sc_StrandDataMapTextureSize;
float clumpInstanceCount;
float clumpRadius;
float clumpTipScale;
float hairstyleInstanceCount;
float hairstyleNoise;
float4 sc_ScreenTextureSize;
float4 sc_ScreenTextureDims;
float4 sc_ScreenTextureView;
float correctedIntensity;
float4 intensityTextureSize;
float4 intensityTextureDims;
float4 intensityTextureView;
float3x3 intensityTextureTransform;
float4 intensityTextureUvMinMax;
float4 intensityTextureBorderColor;
float reflBlurWidth;
float reflBlurMinRough;
float reflBlurMaxRough;
int overrideTimeEnabled;
float overrideTimeElapsed;
float overrideTimeDelta;
int PreviewEnabled;
int PreviewNodeID;
float alphaTestThreshold;
float4 screenTextureSize;
float4 screenTextureDims;
float4 screenTextureView;
float3x3 screenTextureTransform;
float4 screenTextureUvMinMax;
float4 screenTextureBorderColor;
float4 baseTexSize;
float4 baseTexDims;
float4 baseTexView;
float3x3 baseTexTransform;
float4 baseTexUvMinMax;
float4 baseTexBorderColor;
float4 baseColor;
float4 opacityTexSize;
float4 opacityTexDims;
float4 opacityTexView;
float3x3 opacityTexTransform;
float4 opacityTexUvMinMax;
float4 opacityTexBorderColor;
float opacity;
float Port_Input2_N011;
};
struct ssPreviewInfo
{
float4 Color;
bool Saved;
};
struct sc_Bone_t
{
float4 boneMatrix[3];
float4 normalMatrix[3];
};
struct sc_Bones_obj
{
sc_Bone_t sc_Bones[1];
};
struct sc_Set0
{
constant sc_Bones_obj* sc_BonesUBO [[id(0)]];
texture2d<float> baseTex [[id(1)]];
texture2d<float> intensityTexture [[id(2)]];
texture2d<float> opacityTex [[id(3)]];
texture2d<float> sc_ScreenTexture [[id(15)]];
texture2d<float> screenTexture [[id(18)]];
sampler baseTexSmpSC [[id(19)]];
sampler intensityTextureSmpSC [[id(20)]];
sampler opacityTexSmpSC [[id(21)]];
sampler sc_ScreenTextureSmpSC [[id(26)]];
sampler screenTextureSmpSC [[id(29)]];
constant userUniformsObj* UserUniforms [[id(30)]];
};
struct main_frag_out
{
float4 FragColor0 [[color(0)]];
float4 FragColor1 [[color(1)]];
float4 FragColor2 [[color(2)]];
float4 FragColor3 [[color(3)]];
};
struct main_frag_in
{
float3 varPos [[user(locn0)]];
float3 varNormal [[user(locn1)]];
float4 varTangent [[user(locn2)]];
float4 varPackedTex [[user(locn3)]];
float4 varScreenPos [[user(locn4)]];
float2 varScreenTexturePos [[user(locn5)]];
float varViewSpaceDepth [[user(locn6)]];
float2 varShadowTex [[user(locn7)]];
int varStereoViewID [[user(locn8)]];
float varClipDistance [[user(locn9)]];
float4 varColor [[user(locn10)]];
float4 PreviewVertexColor [[user(locn11)]];
float PreviewVertexSaved [[user(locn12)]];
};
// Implementation of the GLSL mod() function,which is slightly different than Metal fmod()
template<typename Tx,typename Ty>
Tx mod(Tx x,Ty y)
{
return x-y*floor(x/y);
}
float transformSingleColor(thread const float& original,thread const float& intMap,thread const float& target)
{
if (((int(BLEND_MODE_REALISTIC_tmp)!=0)||(int(BLEND_MODE_FORGRAY_tmp)!=0))||(int(BLEND_MODE_NOTBRIGHT_tmp)!=0))
{
return original/pow(1.0-target,intMap);
}
else
{
if ((int(BLEND_MODE_DIVISION_tmp)!=0))
{
return original/(1.0-target);
}
else
{
if ((int(BLEND_MODE_BRIGHT_tmp)!=0))
{
return original/pow(1.0-target,2.0-(2.0*original));
}
}
}
return 0.0;
}
float3 transformColor(thread const float& yValue,thread const float3& original,thread const float3& target,thread const float& weight,thread const float& intMap)
{
if ((int(BLEND_MODE_INTENSE_tmp)!=0))
{
float3 param=original;
float3 l9_0=param;
float4 l9_1;
if (l9_0.y<l9_0.z)
{
l9_1=float4(l9_0.zy,-1.0,0.66666669);
}
else
{
l9_1=float4(l9_0.yz,0.0,-0.33333334);
}
float4 l9_2=l9_1;
float4 l9_3;
if (l9_0.x<l9_2.x)
{
l9_3=float4(l9_2.xyw,l9_0.x);
}
else
{
l9_3=float4(l9_0.x,l9_2.yzx);
}
float4 l9_4=l9_3;
float l9_5=l9_4.x-fast::min(l9_4.w,l9_4.y);
float l9_6=abs(((l9_4.w-l9_4.y)/((6.0*l9_5)+1e-07))+l9_4.z);
float l9_7=l9_4.x;
float3 l9_8=float3(l9_6,l9_5,l9_7);
float3 l9_9=l9_8;
float l9_10=l9_9.z-(l9_9.y*0.5);
float l9_11=l9_9.y/((1.0-abs((2.0*l9_10)-1.0))+1e-07);
float3 l9_12=float3(l9_9.x,l9_11,l9_10);
float3 hslOrig=l9_12;
float3 res=float3(0.0);
res.x=target.x;
res.y=target.y;
res.z=hslOrig.z;
float3 param_1=res;
float l9_13=param_1.x;
float l9_14=abs((6.0*l9_13)-3.0)-1.0;
float l9_15=2.0-abs((6.0*l9_13)-2.0);
float l9_16=2.0-abs((6.0*l9_13)-4.0);
float3 l9_17=fast::clamp(float3(l9_14,l9_15,l9_16),float3(0.0),float3(1.0));
float3 l9_18=l9_17;
float l9_19=(1.0-abs((2.0*param_1.z)-1.0))*param_1.y;
l9_18=((l9_18-float3(0.5))*l9_19)+float3(param_1.z);
float3 l9_20=l9_18;
res=l9_20;
float3 resColor=mix(original,res,float3(weight));
return resColor;
}
else
{
float3 tmpColor=float3(0.0);
float param_2=yValue;
float param_3=intMap;
float param_4=target.x;
tmpColor.x=transformSingleColor(param_2,param_3,param_4);
float param_5=yValue;
float param_6=intMap;
float param_7=target.y;
tmpColor.y=transformSingleColor(param_5,param_6,param_7);
float param_8=yValue;
float param_9=intMap;
float param_10=target.z;
tmpColor.z=transformSingleColor(param_8,param_9,param_10);
tmpColor=fast::clamp(tmpColor,float3(0.0),float3(1.0));
float3 resColor_1=mix(original,tmpColor,float3(weight));
return resColor_1;
}
}
float3 definedBlend(thread const float3& a,thread const float3& b,thread int& varStereoViewID,constant userUniformsObj& UserUniforms,thread texture2d<float> intensityTexture,thread sampler intensityTextureSmpSC)
{
if ((int(BLEND_MODE_LIGHTEN_tmp)!=0))
{
return fast::max(a,b);
}
else
{
if ((int(BLEND_MODE_DARKEN_tmp)!=0))
{
return fast::min(a,b);
}
else
{
if ((int(BLEND_MODE_DIVIDE_tmp)!=0))
{
return b/a;
}
else
{
if ((int(BLEND_MODE_AVERAGE_tmp)!=0))
{
return (a+b)*0.5;
}
else
{
if ((int(BLEND_MODE_SUBTRACT_tmp)!=0))
{
return fast::max((a+b)-float3(1.0),float3(0.0));
}
else
{
if ((int(BLEND_MODE_DIFFERENCE_tmp)!=0))
{
return abs(a-b);
}
else
{
if ((int(BLEND_MODE_NEGATION_tmp)!=0))
{
return float3(1.0)-abs((float3(1.0)-a)-b);
}
else
{
if ((int(BLEND_MODE_EXCLUSION_tmp)!=0))
{
return (a+b)-((a*2.0)*b);
}
else
{
if ((int(BLEND_MODE_OVERLAY_tmp)!=0))
{
float l9_0;
if (a.x<0.5)
{
l9_0=(2.0*a.x)*b.x;
}
else
{
l9_0=1.0-((2.0*(1.0-a.x))*(1.0-b.x));
}
float l9_1=l9_0;
float l9_2;
if (a.y<0.5)
{
l9_2=(2.0*a.y)*b.y;
}
else
{
l9_2=1.0-((2.0*(1.0-a.y))*(1.0-b.y));
}
float l9_3=l9_2;
float l9_4;
if (a.z<0.5)
{
l9_4=(2.0*a.z)*b.z;
}
else
{
l9_4=1.0-((2.0*(1.0-a.z))*(1.0-b.z));
}
return float3(l9_1,l9_3,l9_4);
}
else
{
if ((int(BLEND_MODE_SOFT_LIGHT_tmp)!=0))
{
return (((float3(1.0)-(b*2.0))*a)*a)+((a*2.0)*b);
}
else
{
if ((int(BLEND_MODE_HARD_LIGHT_tmp)!=0))
{
float l9_5;
if (b.x<0.5)
{
l9_5=(2.0*b.x)*a.x;
}
else
{
l9_5=1.0-((2.0*(1.0-b.x))*(1.0-a.x));
}
float l9_6=l9_5;
float l9_7;
if (b.y<0.5)
{
l9_7=(2.0*b.y)*a.y;
}
else
{
l9_7=1.0-((2.0*(1.0-b.y))*(1.0-a.y));
}
float l9_8=l9_7;
float l9_9;
if (b.z<0.5)
{
l9_9=(2.0*b.z)*a.z;
}
else
{
l9_9=1.0-((2.0*(1.0-b.z))*(1.0-a.z));
}
return float3(l9_6,l9_8,l9_9);
}
else
{
if ((int(BLEND_MODE_COLOR_DODGE_tmp)!=0))
{
float l9_10;
if (b.x==1.0)
{
l9_10=b.x;
}
else
{
l9_10=fast::min(a.x/(1.0-b.x),1.0);
}
float l9_11=l9_10;
float l9_12;
if (b.y==1.0)
{
l9_12=b.y;
}
else
{
l9_12=fast::min(a.y/(1.0-b.y),1.0);
}
float l9_13=l9_12;
float l9_14;
if (b.z==1.0)
{
l9_14=b.z;
}
else
{
l9_14=fast::min(a.z/(1.0-b.z),1.0);
}
return float3(l9_11,l9_13,l9_14);
}
else
{
if ((int(BLEND_MODE_COLOR_BURN_tmp)!=0))
{
float l9_15;
if (b.x==0.0)
{
l9_15=b.x;
}
else
{
l9_15=fast::max(1.0-((1.0-a.x)/b.x),0.0);
}
float l9_16=l9_15;
float l9_17;
if (b.y==0.0)
{
l9_17=b.y;
}
else
{
l9_17=fast::max(1.0-((1.0-a.y)/b.y),0.0);
}
float l9_18=l9_17;
float l9_19;
if (b.z==0.0)
{
l9_19=b.z;
}
else
{
l9_19=fast::max(1.0-((1.0-a.z)/b.z),0.0);
}
return float3(l9_16,l9_18,l9_19);
}
else
{
if ((int(BLEND_MODE_LINEAR_LIGHT_tmp)!=0))
{
float l9_20;
if (b.x<0.5)
{
l9_20=fast::max((a.x+(2.0*b.x))-1.0,0.0);
}
else
{
l9_20=fast::min(a.x+(2.0*(b.x-0.5)),1.0);
}
float l9_21=l9_20;
float l9_22;
if (b.y<0.5)
{
l9_22=fast::max((a.y+(2.0*b.y))-1.0,0.0);
}
else
{
l9_22=fast::min(a.y+(2.0*(b.y-0.5)),1.0);
}
float l9_23=l9_22;
float l9_24;
if (b.z<0.5)
{
l9_24=fast::max((a.z+(2.0*b.z))-1.0,0.0);
}
else
{
l9_24=fast::min(a.z+(2.0*(b.z-0.5)),1.0);
}
return float3(l9_21,l9_23,l9_24);
}
else
{
if ((int(BLEND_MODE_VIVID_LIGHT_tmp)!=0))
{
float l9_25;
if (b.x<0.5)
{
float l9_26;
if ((2.0*b.x)==0.0)
{
l9_26=2.0*b.x;
}
else
{
l9_26=fast::max(1.0-((1.0-a.x)/(2.0*b.x)),0.0);
}
l9_25=l9_26;
}
else
{
float l9_27;
if ((2.0*(b.x-0.5))==1.0)
{
l9_27=2.0*(b.x-0.5);
}
else
{
l9_27=fast::min(a.x/(1.0-(2.0*(b.x-0.5))),1.0);
}
l9_25=l9_27;
}
float l9_28=l9_25;
float l9_29;
if (b.y<0.5)
{
float l9_30;
if ((2.0*b.y)==0.0)
{
l9_30=2.0*b.y;
}
else
{
l9_30=fast::max(1.0-((1.0-a.y)/(2.0*b.y)),0.0);
}
l9_29=l9_30;
}
else
{
float l9_31;
if ((2.0*(b.y-0.5))==1.0)
{
l9_31=2.0*(b.y-0.5);
}
else
{
l9_31=fast::min(a.y/(1.0-(2.0*(b.y-0.5))),1.0);
}
l9_29=l9_31;
}
float l9_32=l9_29;
float l9_33;
if (b.z<0.5)
{
float l9_34;
if ((2.0*b.z)==0.0)
{
l9_34=2.0*b.z;
}
else
{
l9_34=fast::max(1.0-((1.0-a.z)/(2.0*b.z)),0.0);
}
l9_33=l9_34;
}
else
{
float l9_35;
if ((2.0*(b.z-0.5))==1.0)
{
l9_35=2.0*(b.z-0.5);
}
else
{
l9_35=fast::min(a.z/(1.0-(2.0*(b.z-0.5))),1.0);
}
l9_33=l9_35;
}
return float3(l9_28,l9_32,l9_33);
}
else
{
if ((int(BLEND_MODE_PIN_LIGHT_tmp)!=0))
{
float l9_36;
if (b.x<0.5)
{
l9_36=fast::min(a.x,2.0*b.x);
}
else
{
l9_36=fast::max(a.x,2.0*(b.x-0.5));
}
float l9_37=l9_36;
float l9_38;
if (b.y<0.5)
{
l9_38=fast::min(a.y,2.0*b.y);
}
else
{
l9_38=fast::max(a.y,2.0*(b.y-0.5));
}
float l9_39=l9_38;
float l9_40;
if (b.z<0.5)
{
l9_40=fast::min(a.z,2.0*b.z);
}
else
{
l9_40=fast::max(a.z,2.0*(b.z-0.5));
}
return float3(l9_37,l9_39,l9_40);
}
else
{
if ((int(BLEND_MODE_HARD_MIX_tmp)!=0))
{
float l9_41;
if (b.x<0.5)
{
float l9_42;
if ((2.0*b.x)==0.0)
{
l9_42=2.0*b.x;
}
else
{
l9_42=fast::max(1.0-((1.0-a.x)/(2.0*b.x)),0.0);
}
l9_41=l9_42;
}
else
{
float l9_43;
if ((2.0*(b.x-0.5))==1.0)
{
l9_43=2.0*(b.x-0.5);
}
else
{
l9_43=fast::min(a.x/(1.0-(2.0*(b.x-0.5))),1.0);
}
l9_41=l9_43;
}
float l9_44=l9_41;
float l9_45;
if (b.y<0.5)
{
float l9_46;
if ((2.0*b.y)==0.0)
{
l9_46=2.0*b.y;
}
else
{
l9_46=fast::max(1.0-((1.0-a.y)/(2.0*b.y)),0.0);
}
l9_45=l9_46;
}
else
{
float l9_47;
if ((2.0*(b.y-0.5))==1.0)
{
l9_47=2.0*(b.y-0.5);
}
else
{
l9_47=fast::min(a.y/(1.0-(2.0*(b.y-0.5))),1.0);
}
l9_45=l9_47;
}
float l9_48=l9_45;
float l9_49;
if (b.z<0.5)
{
float l9_50;
if ((2.0*b.z)==0.0)
{
l9_50=2.0*b.z;
}
else
{
l9_50=fast::max(1.0-((1.0-a.z)/(2.0*b.z)),0.0);
}
l9_49=l9_50;
}
else
{
float l9_51;
if ((2.0*(b.z-0.5))==1.0)
{
l9_51=2.0*(b.z-0.5);
}
else
{
l9_51=fast::min(a.z/(1.0-(2.0*(b.z-0.5))),1.0);
}
l9_49=l9_51;
}
return float3((l9_44<0.5) ? 0.0 : 1.0,(l9_48<0.5) ? 0.0 : 1.0,(l9_49<0.5) ? 0.0 : 1.0);
}
else
{
if ((int(BLEND_MODE_HARD_REFLECT_tmp)!=0))
{
float l9_52;
if (b.x==1.0)
{
l9_52=b.x;
}
else
{
l9_52=fast::min((a.x*a.x)/(1.0-b.x),1.0);
}
float l9_53=l9_52;
float l9_54;
if (b.y==1.0)
{
l9_54=b.y;
}
else
{
l9_54=fast::min((a.y*a.y)/(1.0-b.y),1.0);
}
float l9_55=l9_54;
float l9_56;
if (b.z==1.0)
{
l9_56=b.z;
}
else
{
l9_56=fast::min((a.z*a.z)/(1.0-b.z),1.0);
}
return float3(l9_53,l9_55,l9_56);
}
else
{
if ((int(BLEND_MODE_HARD_GLOW_tmp)!=0))
{
float l9_57;
if (a.x==1.0)
{
l9_57=a.x;
}
else
{
l9_57=fast::min((b.x*b.x)/(1.0-a.x),1.0);
}
float l9_58=l9_57;
float l9_59;
if (a.y==1.0)
{
l9_59=a.y;
}
else
{
l9_59=fast::min((b.y*b.y)/(1.0-a.y),1.0);
}
float l9_60=l9_59;
float l9_61;
if (a.z==1.0)
{
l9_61=a.z;
}
else
{
l9_61=fast::min((b.z*b.z)/(1.0-a.z),1.0);
}
return float3(l9_58,l9_60,l9_61);
}
else
{
if ((int(BLEND_MODE_HARD_PHOENIX_tmp)!=0))
{
return (fast::min(a,b)-fast::max(a,b))+float3(1.0);
}
else
{
if ((int(BLEND_MODE_HUE_tmp)!=0))
{
float3 param=a;
float3 param_1=b;
float3 l9_62=param;
float3 l9_63=l9_62;
float4 l9_64;
if (l9_63.y<l9_63.z)
{
l9_64=float4(l9_63.zy,-1.0,0.66666669);
}
else
{
l9_64=float4(l9_63.yz,0.0,-0.33333334);
}
float4 l9_65=l9_64;
float4 l9_66;
if (l9_63.x<l9_65.x)
{
l9_66=float4(l9_65.xyw,l9_63.x);
}
else
{
l9_66=float4(l9_63.x,l9_65.yzx);
}
float4 l9_67=l9_66;
float l9_68=l9_67.x-fast::min(l9_67.w,l9_67.y);
float l9_69=abs(((l9_67.w-l9_67.y)/((6.0*l9_68)+1e-07))+l9_67.z);
float l9_70=l9_67.x;
float3 l9_71=float3(l9_69,l9_68,l9_70);
float3 l9_72=l9_71;
float l9_73=l9_72.z-(l9_72.y*0.5);
float l9_74=l9_72.y/((1.0-abs((2.0*l9_73)-1.0))+1e-07);
float3 l9_75=float3(l9_72.x,l9_74,l9_73);
float3 l9_76=l9_75;
float3 l9_77=param_1;
float3 l9_78=l9_77;
float4 l9_79;
if (l9_78.y<l9_78.z)
{
l9_79=float4(l9_78.zy,-1.0,0.66666669);
}
else
{
l9_79=float4(l9_78.yz,0.0,-0.33333334);
}
float4 l9_80=l9_79;
float4 l9_81;
if (l9_78.x<l9_80.x)
{
l9_81=float4(l9_80.xyw,l9_78.x);
}
else
{
l9_81=float4(l9_78.x,l9_80.yzx);
}
float4 l9_82=l9_81;
float l9_83=l9_82.x-fast::min(l9_82.w,l9_82.y);
float l9_84=abs(((l9_82.w-l9_82.y)/((6.0*l9_83)+1e-07))+l9_82.z);
float l9_85=l9_82.x;
float3 l9_86=float3(l9_84,l9_83,l9_85);
float3 l9_87=l9_86;
float l9_88=l9_87.z-(l9_87.y*0.5);
float l9_89=l9_87.y/((1.0-abs((2.0*l9_88)-1.0))+1e-07);
float3 l9_90=float3(l9_87.x,l9_89,l9_88);
float3 l9_91=float3(l9_90.x,l9_76.y,l9_76.z);
float l9_92=l9_91.x;
float l9_93=abs((6.0*l9_92)-3.0)-1.0;
float l9_94=2.0-abs((6.0*l9_92)-2.0);
float l9_95=2.0-abs((6.0*l9_92)-4.0);
float3 l9_96=fast::clamp(float3(l9_93,l9_94,l9_95),float3(0.0),float3(1.0));
float3 l9_97=l9_96;
float l9_98=(1.0-abs((2.0*l9_91.z)-1.0))*l9_91.y;
l9_97=((l9_97-float3(0.5))*l9_98)+float3(l9_91.z);
float3 l9_99=l9_97;
float3 l9_100=l9_99;
return l9_100;
}
else
{
if ((int(BLEND_MODE_SATURATION_tmp)!=0))
{
float3 param_2=a;
float3 param_3=b;
float3 l9_101=param_2;
float3 l9_102=l9_101;
float4 l9_103;
if (l9_102.y<l9_102.z)
{
l9_103=float4(l9_102.zy,-1.0,0.66666669);
}
else
{
l9_103=float4(l9_102.yz,0.0,-0.33333334);
}
float4 l9_104=l9_103;
float4 l9_105;
if (l9_102.x<l9_104.x)
{
l9_105=float4(l9_104.xyw,l9_102.x);
}
else
{
l9_105=float4(l9_102.x,l9_104.yzx);
}
float4 l9_106=l9_105;
float l9_107=l9_106.x-fast::min(l9_106.w,l9_106.y);
float l9_108=abs(((l9_106.w-l9_106.y)/((6.0*l9_107)+1e-07))+l9_106.z);
float l9_109=l9_106.x;
float3 l9_110=float3(l9_108,l9_107,l9_109);
float3 l9_111=l9_110;
float l9_112=l9_111.z-(l9_111.y*0.5);
float l9_113=l9_111.y/((1.0-abs((2.0*l9_112)-1.0))+1e-07);
float3 l9_114=float3(l9_111.x,l9_113,l9_112);
float3 l9_115=l9_114;
float l9_116=l9_115.x;
float3 l9_117=param_3;
float3 l9_118=l9_117;
float4 l9_119;
if (l9_118.y<l9_118.z)
{
l9_119=float4(l9_118.zy,-1.0,0.66666669);
}
else
{
l9_119=float4(l9_118.yz,0.0,-0.33333334);
}
float4 l9_120=l9_119;
float4 l9_121;
if (l9_118.x<l9_120.x)
{
l9_121=float4(l9_120.xyw,l9_118.x);
}
else
{
l9_121=float4(l9_118.x,l9_120.yzx);
}
float4 l9_122=l9_121;
float l9_123=l9_122.x-fast::min(l9_122.w,l9_122.y);
float l9_124=abs(((l9_122.w-l9_122.y)/((6.0*l9_123)+1e-07))+l9_122.z);
float l9_125=l9_122.x;
float3 l9_126=float3(l9_124,l9_123,l9_125);
float3 l9_127=l9_126;
float l9_128=l9_127.z-(l9_127.y*0.5);
float l9_129=l9_127.y/((1.0-abs((2.0*l9_128)-1.0))+1e-07);
float3 l9_130=float3(l9_127.x,l9_129,l9_128);
float3 l9_131=float3(l9_116,l9_130.y,l9_115.z);
float l9_132=l9_131.x;
float l9_133=abs((6.0*l9_132)-3.0)-1.0;
float l9_134=2.0-abs((6.0*l9_132)-2.0);
float l9_135=2.0-abs((6.0*l9_132)-4.0);
float3 l9_136=fast::clamp(float3(l9_133,l9_134,l9_135),float3(0.0),float3(1.0));
float3 l9_137=l9_136;
float l9_138=(1.0-abs((2.0*l9_131.z)-1.0))*l9_131.y;
l9_137=((l9_137-float3(0.5))*l9_138)+float3(l9_131.z);
float3 l9_139=l9_137;
float3 l9_140=l9_139;
return l9_140;
}
else
{
if ((int(BLEND_MODE_COLOR_tmp)!=0))
{
float3 param_4=a;
float3 param_5=b;
float3 l9_141=param_5;
float3 l9_142=l9_141;
float4 l9_143;
if (l9_142.y<l9_142.z)
{
l9_143=float4(l9_142.zy,-1.0,0.66666669);
}
else
{
l9_143=float4(l9_142.yz,0.0,-0.33333334);
}
float4 l9_144=l9_143;
float4 l9_145;
if (l9_142.x<l9_144.x)
{
l9_145=float4(l9_144.xyw,l9_142.x);
}
else
{
l9_145=float4(l9_142.x,l9_144.yzx);
}
float4 l9_146=l9_145;
float l9_147=l9_146.x-fast::min(l9_146.w,l9_146.y);
float l9_148=abs(((l9_146.w-l9_146.y)/((6.0*l9_147)+1e-07))+l9_146.z);
float l9_149=l9_146.x;
float3 l9_150=float3(l9_148,l9_147,l9_149);
float3 l9_151=l9_150;
float l9_152=l9_151.z-(l9_151.y*0.5);
float l9_153=l9_151.y/((1.0-abs((2.0*l9_152)-1.0))+1e-07);
float3 l9_154=float3(l9_151.x,l9_153,l9_152);
float3 l9_155=l9_154;
float l9_156=l9_155.x;
float l9_157=l9_155.y;
float3 l9_158=param_4;
float3 l9_159=l9_158;
float4 l9_160;
if (l9_159.y<l9_159.z)
{
l9_160=float4(l9_159.zy,-1.0,0.66666669);
}
else
{
l9_160=float4(l9_159.yz,0.0,-0.33333334);
}
float4 l9_161=l9_160;
float4 l9_162;
if (l9_159.x<l9_161.x)
{
l9_162=float4(l9_161.xyw,l9_159.x);
}
else
{
l9_162=float4(l9_159.x,l9_161.yzx);
}
float4 l9_163=l9_162;
float l9_164=l9_163.x-fast::min(l9_163.w,l9_163.y);
float l9_165=abs(((l9_163.w-l9_163.y)/((6.0*l9_164)+1e-07))+l9_163.z);
float l9_166=l9_163.x;
float3 l9_167=float3(l9_165,l9_164,l9_166);
float3 l9_168=l9_167;
float l9_169=l9_168.z-(l9_168.y*0.5);
float l9_170=l9_168.y/((1.0-abs((2.0*l9_169)-1.0))+1e-07);
float3 l9_171=float3(l9_168.x,l9_170,l9_169);
float3 l9_172=float3(l9_156,l9_157,l9_171.z);
float l9_173=l9_172.x;
float l9_174=abs((6.0*l9_173)-3.0)-1.0;
float l9_175=2.0-abs((6.0*l9_173)-2.0);
float l9_176=2.0-abs((6.0*l9_173)-4.0);
float3 l9_177=fast::clamp(float3(l9_174,l9_175,l9_176),float3(0.0),float3(1.0));
float3 l9_178=l9_177;
float l9_179=(1.0-abs((2.0*l9_172.z)-1.0))*l9_172.y;
l9_178=((l9_178-float3(0.5))*l9_179)+float3(l9_172.z);
float3 l9_180=l9_178;
float3 l9_181=l9_180;
return l9_181;
}
else
{
if ((int(BLEND_MODE_LUMINOSITY_tmp)!=0))
{
float3 param_6=a;
float3 param_7=b;
float3 l9_182=param_6;
float3 l9_183=l9_182;
float4 l9_184;
if (l9_183.y<l9_183.z)
{
l9_184=float4(l9_183.zy,-1.0,0.66666669);
}
else
{
l9_184=float4(l9_183.yz,0.0,-0.33333334);
}
float4 l9_185=l9_184;
float4 l9_186;
if (l9_183.x<l9_185.x)
{
l9_186=float4(l9_185.xyw,l9_183.x);
}
else
{
l9_186=float4(l9_183.x,l9_185.yzx);
}
float4 l9_187=l9_186;
float l9_188=l9_187.x-fast::min(l9_187.w,l9_187.y);
float l9_189=abs(((l9_187.w-l9_187.y)/((6.0*l9_188)+1e-07))+l9_187.z);
float l9_190=l9_187.x;
float3 l9_191=float3(l9_189,l9_188,l9_190);
float3 l9_192=l9_191;
float l9_193=l9_192.z-(l9_192.y*0.5);
float l9_194=l9_192.y/((1.0-abs((2.0*l9_193)-1.0))+1e-07);
float3 l9_195=float3(l9_192.x,l9_194,l9_193);
float3 l9_196=l9_195;
float l9_197=l9_196.x;
float l9_198=l9_196.y;
float3 l9_199=param_7;
float3 l9_200=l9_199;
float4 l9_201;
if (l9_200.y<l9_200.z)
{
l9_201=float4(l9_200.zy,-1.0,0.66666669);
}
else
{
l9_201=float4(l9_200.yz,0.0,-0.33333334);
}
float4 l9_202=l9_201;
float4 l9_203;
if (l9_200.x<l9_202.x)
{
l9_203=float4(l9_202.xyw,l9_200.x);
}
else
{
l9_203=float4(l9_200.x,l9_202.yzx);
}
float4 l9_204=l9_203;
float l9_205=l9_204.x-fast::min(l9_204.w,l9_204.y);
float l9_206=abs(((l9_204.w-l9_204.y)/((6.0*l9_205)+1e-07))+l9_204.z);
float l9_207=l9_204.x;
float3 l9_208=float3(l9_206,l9_205,l9_207);
float3 l9_209=l9_208;
float l9_210=l9_209.z-(l9_209.y*0.5);
float l9_211=l9_209.y/((1.0-abs((2.0*l9_210)-1.0))+1e-07);
float3 l9_212=float3(l9_209.x,l9_211,l9_210);
float3 l9_213=float3(l9_197,l9_198,l9_212.z);
float l9_214=l9_213.x;
float l9_215=abs((6.0*l9_214)-3.0)-1.0;
float l9_216=2.0-abs((6.0*l9_214)-2.0);
float l9_217=2.0-abs((6.0*l9_214)-4.0);
float3 l9_218=fast::clamp(float3(l9_215,l9_216,l9_217),float3(0.0),float3(1.0));
float3 l9_219=l9_218;
float l9_220=(1.0-abs((2.0*l9_213.z)-1.0))*l9_213.y;
l9_219=((l9_219-float3(0.5))*l9_220)+float3(l9_213.z);
float3 l9_221=l9_219;
float3 l9_222=l9_221;
return l9_222;
}
else
{
float3 param_8=a;
float3 param_9=b;
float3 l9_223=param_8;
float l9_224=((0.29899999*l9_223.x)+(0.58700001*l9_223.y))+(0.114*l9_223.z);
float l9_225=l9_224;
float l9_226=1.0;
float l9_227=pow(l9_225,1.0/UserUniforms.correctedIntensity);
int l9_228=0;
if ((int(intensityTextureHasSwappedViews_tmp)!=0))
{
int l9_229=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_229=0;
}
else
{
l9_229=varStereoViewID;
}
int l9_230=l9_229;
l9_228=1-l9_230;
}
else
{
int l9_231=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_231=0;
}
else
{
l9_231=varStereoViewID;
}
int l9_232=l9_231;
l9_228=l9_232;
}
int l9_233=l9_228;
int l9_234=intensityTextureLayout_tmp;
int l9_235=l9_233;
float2 l9_236=float2(l9_227,0.5);
bool l9_237=(int(SC_USE_UV_TRANSFORM_intensityTexture_tmp)!=0);
float3x3 l9_238=UserUniforms.intensityTextureTransform;
int2 l9_239=int2(SC_SOFTWARE_WRAP_MODE_U_intensityTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_intensityTexture_tmp);
bool l9_240=(int(SC_USE_UV_MIN_MAX_intensityTexture_tmp)!=0);
float4 l9_241=UserUniforms.intensityTextureUvMinMax;
bool l9_242=(int(SC_USE_CLAMP_TO_BORDER_intensityTexture_tmp)!=0);
float4 l9_243=UserUniforms.intensityTextureBorderColor;
float l9_244=0.0;
bool l9_245=l9_242&&(!l9_240);
float l9_246=1.0;
float l9_247=l9_236.x;
int l9_248=l9_239.x;
if (l9_248==1)
{
l9_247=fract(l9_247);
}
else
{
if (l9_248==2)
{
float l9_249=fract(l9_247);
float l9_250=l9_247-l9_249;
float l9_251=step(0.25,fract(l9_250*0.5));
l9_247=mix(l9_249,1.0-l9_249,fast::clamp(l9_251,0.0,1.0));
}
}
l9_236.x=l9_247;
float l9_252=l9_236.y;
int l9_253=l9_239.y;
if (l9_253==1)
{
l9_252=fract(l9_252);
}
else
{
if (l9_253==2)
{
float l9_254=fract(l9_252);
float l9_255=l9_252-l9_254;
float l9_256=step(0.25,fract(l9_255*0.5));
l9_252=mix(l9_254,1.0-l9_254,fast::clamp(l9_256,0.0,1.0));
}
}
l9_236.y=l9_252;
if (l9_240)
{
bool l9_257=l9_242;
bool l9_258;
if (l9_257)
{
l9_258=l9_239.x==3;
}
else
{
l9_258=l9_257;
}
float l9_259=l9_236.x;
float l9_260=l9_241.x;
float l9_261=l9_241.z;
bool l9_262=l9_258;
float l9_263=l9_246;
float l9_264=fast::clamp(l9_259,l9_260,l9_261);
float l9_265=step(abs(l9_259-l9_264),9.9999997e-06);
l9_263*=(l9_265+((1.0-float(l9_262))*(1.0-l9_265)));
l9_259=l9_264;
l9_236.x=l9_259;
l9_246=l9_263;
bool l9_266=l9_242;
bool l9_267;
if (l9_266)
{
l9_267=l9_239.y==3;
}
else
{
l9_267=l9_266;
}
float l9_268=l9_236.y;
float l9_269=l9_241.y;
float l9_270=l9_241.w;
bool l9_271=l9_267;
float l9_272=l9_246;
float l9_273=fast::clamp(l9_268,l9_269,l9_270);
float l9_274=step(abs(l9_268-l9_273),9.9999997e-06);
l9_272*=(l9_274+((1.0-float(l9_271))*(1.0-l9_274)));
l9_268=l9_273;
l9_236.y=l9_268;
l9_246=l9_272;
}
float2 l9_275=l9_236;
bool l9_276=l9_237;
float3x3 l9_277=l9_238;
if (l9_276)
{
l9_275=float2((l9_277*float3(l9_275,1.0)).xy);
}
float2 l9_278=l9_275;
float2 l9_279=l9_278;
float2 l9_280=l9_279;
l9_236=l9_280;
float l9_281=l9_236.x;
int l9_282=l9_239.x;
bool l9_283=l9_245;
float l9_284=l9_246;
if ((l9_282==0)||(l9_282==3))
{
float l9_285=l9_281;
float l9_286=0.0;
float l9_287=1.0;
bool l9_288=l9_283;
float l9_289=l9_284;
float l9_290=fast::clamp(l9_285,l9_286,l9_287);
float l9_291=step(abs(l9_285-l9_290),9.9999997e-06);
l9_289*=(l9_291+((1.0-float(l9_288))*(1.0-l9_291)));
l9_285=l9_290;
l9_281=l9_285;
l9_284=l9_289;
}
l9_236.x=l9_281;
l9_246=l9_284;
float l9_292=l9_236.y;
int l9_293=l9_239.y;
bool l9_294=l9_245;
float l9_295=l9_246;
if ((l9_293==0)||(l9_293==3))
{
float l9_296=l9_292;
float l9_297=0.0;
float l9_298=1.0;
bool l9_299=l9_294;
float l9_300=l9_295;
float l9_301=fast::clamp(l9_296,l9_297,l9_298);
float l9_302=step(abs(l9_296-l9_301),9.9999997e-06);
l9_300*=(l9_302+((1.0-float(l9_299))*(1.0-l9_302)));
l9_296=l9_301;
l9_292=l9_296;
l9_295=l9_300;
}
l9_236.y=l9_292;
l9_246=l9_295;
float2 l9_303=l9_236;
int l9_304=l9_234;
int l9_305=l9_235;
float l9_306=l9_244;
float2 l9_307=l9_303;
int l9_308=l9_304;
int l9_309=l9_305;
float3 l9_310=float3(0.0);
if (l9_308==0)
{
l9_310=float3(l9_307,0.0);
}
else
{
if (l9_308==1)
{
l9_310=float3(l9_307.x,(l9_307.y*0.5)+(0.5-(float(l9_309)*0.5)),0.0);
}
else
{
l9_310=float3(l9_307,float(l9_309));
}
}
float3 l9_311=l9_310;
float3 l9_312=l9_311;
float2 l9_313=l9_312.xy;
float l9_314=l9_306;
float4 l9_315=intensityTexture.sample(intensityTextureSmpSC,l9_313,bias(l9_314));
float4 l9_316=l9_315;
float4 l9_317=l9_316;
if (l9_242)
{
l9_317=mix(l9_243,l9_317,float4(l9_246));
}
float4 l9_318=l9_317;
float3 l9_319=l9_318.xyz;
float3 l9_320=l9_319;
float l9_321=16.0;
float l9_322=((((l9_320.x*256.0)+l9_320.y)+(l9_320.z/256.0))/257.00391)*l9_321;
float l9_323=l9_322;
if ((int(BLEND_MODE_FORGRAY_tmp)!=0))
{
l9_323=fast::max(l9_323,1.0);
}
if ((int(BLEND_MODE_NOTBRIGHT_tmp)!=0))
{
l9_323=fast::min(l9_323,1.0);
}
float l9_324=l9_225;
float3 l9_325=param_8;
float3 l9_326=param_9;
float l9_327=l9_226;
float l9_328=l9_323;
float3 l9_329=transformColor(l9_324,l9_325,l9_326,l9_327,l9_328);
return l9_329;
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
float4 outputMotionVectorsIfNeeded(thread const float3& surfacePosWorldSpace,thread const float4& finalColor,thread int& varStereoViewID,constant userUniformsObj& UserUniforms)
{
if ((int(sc_MotionVectorsPass_tmp)!=0))
{
float3 param=surfacePosWorldSpace;
int l9_0=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_0=0;
}
else
{
l9_0=varStereoViewID;
}
int l9_1=l9_0;
float4 l9_2=UserUniforms.sc_ViewProjectionMatrixArray[l9_1]*float4(param,1.0);
float2 l9_3=l9_2.xy/float2(l9_2.w);
l9_2=float4(l9_3.x,l9_3.y,l9_2.z,l9_2.w);
int l9_4=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_4=0;
}
else
{
l9_4=varStereoViewID;
}
int l9_5=l9_4;
float4 l9_6=((UserUniforms.sc_PrevFrameViewProjectionMatrixArray[l9_5]*UserUniforms.sc_PrevFrameModelMatrix)*UserUniforms.sc_ModelMatrixInverse)*float4(param,1.0);
float2 l9_7=l9_6.xy/float2(l9_6.w);
l9_6=float4(l9_7.x,l9_7.y,l9_6.z,l9_6.w);
float2 l9_8=(l9_2.xy-l9_6.xy)*0.5;
float2 l9_9=l9_8;
float l9_10=(l9_9.x*5.0)+0.5;
float l9_11=floor(l9_10*65535.0);
float l9_12=floor(l9_11*0.00390625);
float2 l9_13=float2(l9_12/255.0,(l9_11-(l9_12*256.0))/255.0);
float l9_14=(l9_9.y*5.0)+0.5;
float l9_15=floor(l9_14*65535.0);
float l9_16=floor(l9_15*0.00390625);
float2 l9_17=float2(l9_16/255.0,(l9_15-(l9_16*256.0))/255.0);
float4 l9_18=float4(l9_13,l9_17);
float4 l9_19=l9_18;
return l9_19;
}
else
{
return finalColor;
}
}
fragment main_frag_out main_frag(main_frag_in in [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],float4 gl_FragCoord [[position]])
{
main_frag_out out={};
float3 N12_ScreenTexture=float3(0.0);
float4 N12_BaseColor=float4(0.0);
float N12_factor=0.0;
float4 N12_Result=float4(0.0);
if ((int(sc_DepthOnly_tmp)!=0))
{
return out;
}
if ((sc_StereoRenderingMode_tmp==1)&&(sc_StereoRendering_IsClipDistanceEnabled_tmp==0))
{
if (in.varClipDistance<0.0)
{
discard_fragment();
}
}
ssPreviewInfo PreviewInfo;
PreviewInfo.Color=in.PreviewVertexColor;
PreviewInfo.Saved=((in.PreviewVertexSaved*1.0)!=0.0) ? true : false;
float4 FinalColor=float4(1.0);
float l9_0;
if ((*sc_set0.UserUniforms).overrideTimeEnabled==1)
{
l9_0=(*sc_set0.UserUniforms).overrideTimeElapsed;
}
else
{
l9_0=(*sc_set0.UserUniforms).sc_Time.x;
}
ssGlobals Globals;
Globals.gTimeElapsed=l9_0;
float l9_1;
if ((*sc_set0.UserUniforms).overrideTimeEnabled==1)
{
l9_1=(*sc_set0.UserUniforms).overrideTimeDelta;
}
else
{
l9_1=(*sc_set0.UserUniforms).sc_Time.y;
}
Globals.gTimeDelta=l9_1;
float4 l9_2=gl_FragCoord;
float2 l9_3=l9_2.xy*(*sc_set0.UserUniforms).sc_CurrentRenderTargetDims.zw;
float2 l9_4=l9_3;
float2 l9_5=float2(0.0);
if (sc_StereoRenderingMode_tmp==1)
{
int l9_6=1;
int l9_7=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_7=0;
}
else
{
l9_7=in.varStereoViewID;
}
int l9_8=l9_7;
int l9_9=l9_8;
float3 l9_10=float3(l9_4,0.0);
int l9_11=l9_6;
int l9_12=l9_9;
if (l9_11==1)
{
l9_10.y=((2.0*l9_10.y)+float(l9_12))-1.0;
}
float2 l9_13=l9_10.xy;
l9_5=l9_13;
}
else
{
l9_5=l9_4;
}
float2 l9_14=l9_5;
float2 l9_15=l9_14;
Globals.gScreenCoord=l9_15;
float4 Output_N14=float4(0.0);
float4 param=float4(1.0);
float4 param_1=float4(0.0);
ssGlobals param_3=Globals;
float4 param_2;
if ((int(USE_LEGACY_512_TEXTURE_tmp)!=0))
{
float2 l9_16=float2(0.0);
l9_16=param_3.gScreenCoord;
float4 l9_17=float4(0.0);
int l9_18=0;
if ((int(screenTextureHasSwappedViews_tmp)!=0))
{
int l9_19=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_19=0;
}
else
{
l9_19=in.varStereoViewID;
}
int l9_20=l9_19;
l9_18=1-l9_20;
}
else
{
int l9_21=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_21=0;
}
else
{
l9_21=in.varStereoViewID;
}
int l9_22=l9_21;
l9_18=l9_22;
}
int l9_23=l9_18;
int l9_24=screenTextureLayout_tmp;
int l9_25=l9_23;
float2 l9_26=l9_16;
bool l9_27=(int(SC_USE_UV_TRANSFORM_screenTexture_tmp)!=0);
float3x3 l9_28=(*sc_set0.UserUniforms).screenTextureTransform;
int2 l9_29=int2(SC_SOFTWARE_WRAP_MODE_U_screenTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_screenTexture_tmp);
bool l9_30=(int(SC_USE_UV_MIN_MAX_screenTexture_tmp)!=0);
float4 l9_31=(*sc_set0.UserUniforms).screenTextureUvMinMax;
bool l9_32=(int(SC_USE_CLAMP_TO_BORDER_screenTexture_tmp)!=0);
float4 l9_33=(*sc_set0.UserUniforms).screenTextureBorderColor;
float l9_34=0.0;
bool l9_35=l9_32&&(!l9_30);
float l9_36=1.0;
float l9_37=l9_26.x;
int l9_38=l9_29.x;
if (l9_38==1)
{
l9_37=fract(l9_37);
}
else
{
if (l9_38==2)
{
float l9_39=fract(l9_37);
float l9_40=l9_37-l9_39;
float l9_41=step(0.25,fract(l9_40*0.5));
l9_37=mix(l9_39,1.0-l9_39,fast::clamp(l9_41,0.0,1.0));
}
}
l9_26.x=l9_37;
float l9_42=l9_26.y;
int l9_43=l9_29.y;
if (l9_43==1)
{
l9_42=fract(l9_42);
}
else
{
if (l9_43==2)
{
float l9_44=fract(l9_42);
float l9_45=l9_42-l9_44;
float l9_46=step(0.25,fract(l9_45*0.5));
l9_42=mix(l9_44,1.0-l9_44,fast::clamp(l9_46,0.0,1.0));
}
}
l9_26.y=l9_42;
if (l9_30)
{
bool l9_47=l9_32;
bool l9_48;
if (l9_47)
{
l9_48=l9_29.x==3;
}
else
{
l9_48=l9_47;
}
float l9_49=l9_26.x;
float l9_50=l9_31.x;
float l9_51=l9_31.z;
bool l9_52=l9_48;
float l9_53=l9_36;
float l9_54=fast::clamp(l9_49,l9_50,l9_51);
float l9_55=step(abs(l9_49-l9_54),9.9999997e-06);
l9_53*=(l9_55+((1.0-float(l9_52))*(1.0-l9_55)));
l9_49=l9_54;
l9_26.x=l9_49;
l9_36=l9_53;
bool l9_56=l9_32;
bool l9_57;
if (l9_56)
{
l9_57=l9_29.y==3;
}
else
{
l9_57=l9_56;
}
float l9_58=l9_26.y;
float l9_59=l9_31.y;
float l9_60=l9_31.w;
bool l9_61=l9_57;
float l9_62=l9_36;
float l9_63=fast::clamp(l9_58,l9_59,l9_60);
float l9_64=step(abs(l9_58-l9_63),9.9999997e-06);
l9_62*=(l9_64+((1.0-float(l9_61))*(1.0-l9_64)));
l9_58=l9_63;
l9_26.y=l9_58;
l9_36=l9_62;
}
float2 l9_65=l9_26;
bool l9_66=l9_27;
float3x3 l9_67=l9_28;
if (l9_66)
{
l9_65=float2((l9_67*float3(l9_65,1.0)).xy);
}
float2 l9_68=l9_65;
float2 l9_69=l9_68;
float2 l9_70=l9_69;
l9_26=l9_70;
float l9_71=l9_26.x;
int l9_72=l9_29.x;
bool l9_73=l9_35;
float l9_74=l9_36;
if ((l9_72==0)||(l9_72==3))
{
float l9_75=l9_71;
float l9_76=0.0;
float l9_77=1.0;
bool l9_78=l9_73;
float l9_79=l9_74;
float l9_80=fast::clamp(l9_75,l9_76,l9_77);
float l9_81=step(abs(l9_75-l9_80),9.9999997e-06);
l9_79*=(l9_81+((1.0-float(l9_78))*(1.0-l9_81)));
l9_75=l9_80;
l9_71=l9_75;
l9_74=l9_79;
}
l9_26.x=l9_71;
l9_36=l9_74;
float l9_82=l9_26.y;
int l9_83=l9_29.y;
bool l9_84=l9_35;
float l9_85=l9_36;
if ((l9_83==0)||(l9_83==3))
{
float l9_86=l9_82;
float l9_87=0.0;
float l9_88=1.0;
bool l9_89=l9_84;
float l9_90=l9_85;
float l9_91=fast::clamp(l9_86,l9_87,l9_88);
float l9_92=step(abs(l9_86-l9_91),9.9999997e-06);
l9_90*=(l9_92+((1.0-float(l9_89))*(1.0-l9_92)));
l9_86=l9_91;
l9_82=l9_86;
l9_85=l9_90;
}
l9_26.y=l9_82;
l9_36=l9_85;
float2 l9_93=l9_26;
int l9_94=l9_24;
int l9_95=l9_25;
float l9_96=l9_34;
float2 l9_97=l9_93;
int l9_98=l9_94;
int l9_99=l9_95;
float3 l9_100=float3(0.0);
if (l9_98==0)
{
l9_100=float3(l9_97,0.0);
}
else
{
if (l9_98==1)
{
l9_100=float3(l9_97.x,(l9_97.y*0.5)+(0.5-(float(l9_99)*0.5)),0.0);
}
else
{
l9_100=float3(l9_97,float(l9_99));
}
}
float3 l9_101=l9_100;
float3 l9_102=l9_101;
float2 l9_103=l9_102.xy;
float l9_104=l9_96;
float4 l9_105=sc_set0.screenTexture.sample(sc_set0.screenTextureSmpSC,l9_103,bias(l9_104));
float4 l9_106=l9_105;
float4 l9_107=l9_106;
if (l9_32)
{
l9_107=mix(l9_33,l9_107,float4(l9_36));
}
float4 l9_108=l9_107;
l9_17=l9_108;
float4 l9_109=float4(0.0);
float4 l9_110=(*sc_set0.UserUniforms).baseColor;
l9_109=l9_110;
float l9_111=0.0;
l9_111=l9_109.w;
float l9_112=0.0;
float l9_113=1.0;
float l9_114=(*sc_set0.UserUniforms).Port_Input2_N011;
ssGlobals l9_115=param_3;
float l9_116;
if ((int(ENABLE_OPACITY_TEX_tmp)!=0))
{
float2 l9_117=float2(0.0);
l9_117=l9_115.gScreenCoord;
float4 l9_118=float4(0.0);
int l9_119=0;
if ((int(opacityTexHasSwappedViews_tmp)!=0))
{
int l9_120=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_120=0;
}
else
{
l9_120=in.varStereoViewID;
}
int l9_121=l9_120;
l9_119=1-l9_121;
}
else
{
int l9_122=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_122=0;
}
else
{
l9_122=in.varStereoViewID;
}
int l9_123=l9_122;
l9_119=l9_123;
}
int l9_124=l9_119;
int l9_125=opacityTexLayout_tmp;
int l9_126=l9_124;
float2 l9_127=l9_117;
bool l9_128=(int(SC_USE_UV_TRANSFORM_opacityTex_tmp)!=0);
float3x3 l9_129=(*sc_set0.UserUniforms).opacityTexTransform;
int2 l9_130=int2(SC_SOFTWARE_WRAP_MODE_U_opacityTex_tmp,SC_SOFTWARE_WRAP_MODE_V_opacityTex_tmp);
bool l9_131=(int(SC_USE_UV_MIN_MAX_opacityTex_tmp)!=0);
float4 l9_132=(*sc_set0.UserUniforms).opacityTexUvMinMax;
bool l9_133=(int(SC_USE_CLAMP_TO_BORDER_opacityTex_tmp)!=0);
float4 l9_134=(*sc_set0.UserUniforms).opacityTexBorderColor;
float l9_135=0.0;
bool l9_136=l9_133&&(!l9_131);
float l9_137=1.0;
float l9_138=l9_127.x;
int l9_139=l9_130.x;
if (l9_139==1)
{
l9_138=fract(l9_138);
}
else
{
if (l9_139==2)
{
float l9_140=fract(l9_138);
float l9_141=l9_138-l9_140;
float l9_142=step(0.25,fract(l9_141*0.5));
l9_138=mix(l9_140,1.0-l9_140,fast::clamp(l9_142,0.0,1.0));
}
}
l9_127.x=l9_138;
float l9_143=l9_127.y;
int l9_144=l9_130.y;
if (l9_144==1)
{
l9_143=fract(l9_143);
}
else
{
if (l9_144==2)
{
float l9_145=fract(l9_143);
float l9_146=l9_143-l9_145;
float l9_147=step(0.25,fract(l9_146*0.5));
l9_143=mix(l9_145,1.0-l9_145,fast::clamp(l9_147,0.0,1.0));
}
}
l9_127.y=l9_143;
if (l9_131)
{
bool l9_148=l9_133;
bool l9_149;
if (l9_148)
{
l9_149=l9_130.x==3;
}
else
{
l9_149=l9_148;
}
float l9_150=l9_127.x;
float l9_151=l9_132.x;
float l9_152=l9_132.z;
bool l9_153=l9_149;
float l9_154=l9_137;
float l9_155=fast::clamp(l9_150,l9_151,l9_152);
float l9_156=step(abs(l9_150-l9_155),9.9999997e-06);
l9_154*=(l9_156+((1.0-float(l9_153))*(1.0-l9_156)));
l9_150=l9_155;
l9_127.x=l9_150;
l9_137=l9_154;
bool l9_157=l9_133;
bool l9_158;
if (l9_157)
{
l9_158=l9_130.y==3;
}
else
{
l9_158=l9_157;
}
float l9_159=l9_127.y;
float l9_160=l9_132.y;
float l9_161=l9_132.w;
bool l9_162=l9_158;
float l9_163=l9_137;
float l9_164=fast::clamp(l9_159,l9_160,l9_161);
float l9_165=step(abs(l9_159-l9_164),9.9999997e-06);
l9_163*=(l9_165+((1.0-float(l9_162))*(1.0-l9_165)));
l9_159=l9_164;
l9_127.y=l9_159;
l9_137=l9_163;
}
float2 l9_166=l9_127;
bool l9_167=l9_128;
float3x3 l9_168=l9_129;
if (l9_167)
{
l9_166=float2((l9_168*float3(l9_166,1.0)).xy);
}
float2 l9_169=l9_166;
float2 l9_170=l9_169;
float2 l9_171=l9_170;
l9_127=l9_171;
float l9_172=l9_127.x;
int l9_173=l9_130.x;
bool l9_174=l9_136;
float l9_175=l9_137;
if ((l9_173==0)||(l9_173==3))
{
float l9_176=l9_172;
float l9_177=0.0;
float l9_178=1.0;
bool l9_179=l9_174;
float l9_180=l9_175;
float l9_181=fast::clamp(l9_176,l9_177,l9_178);
float l9_182=step(abs(l9_176-l9_181),9.9999997e-06);
l9_180*=(l9_182+((1.0-float(l9_179))*(1.0-l9_182)));
l9_176=l9_181;
l9_172=l9_176;
l9_175=l9_180;
}
l9_127.x=l9_172;
l9_137=l9_175;
float l9_183=l9_127.y;
int l9_184=l9_130.y;
bool l9_185=l9_136;
float l9_186=l9_137;
if ((l9_184==0)||(l9_184==3))
{
float l9_187=l9_183;
float l9_188=0.0;
float l9_189=1.0;
bool l9_190=l9_185;
float l9_191=l9_186;
float l9_192=fast::clamp(l9_187,l9_188,l9_189);
float l9_193=step(abs(l9_187-l9_192),9.9999997e-06);
l9_191*=(l9_193+((1.0-float(l9_190))*(1.0-l9_193)));
l9_187=l9_192;
l9_183=l9_187;
l9_186=l9_191;
}
l9_127.y=l9_183;
l9_137=l9_186;
float2 l9_194=l9_127;
int l9_195=l9_125;
int l9_196=l9_126;
float l9_197=l9_135;
float2 l9_198=l9_194;
int l9_199=l9_195;
int l9_200=l9_196;
float3 l9_201=float3(0.0);
if (l9_199==0)
{
l9_201=float3(l9_198,0.0);
}
else
{
if (l9_199==1)
{
l9_201=float3(l9_198.x,(l9_198.y*0.5)+(0.5-(float(l9_200)*0.5)),0.0);
}
else
{
l9_201=float3(l9_198,float(l9_200));
}
}
float3 l9_202=l9_201;
float3 l9_203=l9_202;
float2 l9_204=l9_203.xy;
float l9_205=l9_197;
float4 l9_206=sc_set0.opacityTex.sample(sc_set0.opacityTexSmpSC,l9_204,bias(l9_205));
float4 l9_207=l9_206;
float4 l9_208=l9_207;
if (l9_133)
{
l9_208=mix(l9_134,l9_208,float4(l9_137));
}
float4 l9_209=l9_208;
l9_118=l9_209;
float l9_210=0.0;
l9_210=l9_118.x;
float l9_211=0.0;
float l9_212=(*sc_set0.UserUniforms).opacity;
l9_211=l9_212;
float l9_213=0.0;
l9_213=l9_210*l9_211;
l9_113=l9_213;
l9_116=l9_113;
}
else
{
l9_116=l9_114;
}
l9_112=l9_116;
float l9_214=0.0;
l9_214=l9_111*l9_112;
float4 l9_215=float4(0.0);
float3 l9_216=l9_17.xyz;
float4 l9_217=l9_109;
float l9_218=l9_214;
float4 l9_219=float4(0.0);
N12_ScreenTexture=l9_216;
N12_BaseColor=l9_217;
N12_factor=l9_218;
float3 l9_220=N12_ScreenTexture;
float l9_221=(l9_220.z*255.0)/4.0;
float2 l9_222=fast::clamp(float2(floor(l9_221))+float2(0.0,1.0),float2(0.0),float2(63.0));
float2 l9_223=floor((l9_222/float2(8.0))+float2(1e-06));
float4 l9_224=float4(l9_223,l9_222-(l9_223*8.0));
float4 l9_225=((l9_220.yyxx*0.12304688)+(l9_224*0.125))+float4(0.0009765625);
float l9_226=l9_221-l9_222.x;
float2 l9_227=float2(l9_225.z,1.0-l9_225.x);
float4 l9_228=float4(0.0);
int l9_229=0;
if ((int(baseTexHasSwappedViews_tmp)!=0))
{
int l9_230=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_230=0;
}
else
{
l9_230=in.varStereoViewID;
}
int l9_231=l9_230;
l9_229=1-l9_231;
}
else
{
int l9_232=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_232=0;
}
else
{
l9_232=in.varStereoViewID;
}
int l9_233=l9_232;
l9_229=l9_233;
}
int l9_234=l9_229;
int l9_235=baseTexLayout_tmp;
int l9_236=l9_234;
float2 l9_237=l9_227;
bool l9_238=(int(SC_USE_UV_TRANSFORM_baseTex_tmp)!=0);
float3x3 l9_239=(*sc_set0.UserUniforms).baseTexTransform;
int2 l9_240=int2(SC_SOFTWARE_WRAP_MODE_U_baseTex_tmp,SC_SOFTWARE_WRAP_MODE_V_baseTex_tmp);
bool l9_241=(int(SC_USE_UV_MIN_MAX_baseTex_tmp)!=0);
float4 l9_242=(*sc_set0.UserUniforms).baseTexUvMinMax;
bool l9_243=(int(SC_USE_CLAMP_TO_BORDER_baseTex_tmp)!=0);
float4 l9_244=(*sc_set0.UserUniforms).baseTexBorderColor;
float l9_245=0.0;
bool l9_246=l9_243&&(!l9_241);
float l9_247=1.0;
float l9_248=l9_237.x;
int l9_249=l9_240.x;
if (l9_249==1)
{
l9_248=fract(l9_248);
}
else
{
if (l9_249==2)
{
float l9_250=fract(l9_248);
float l9_251=l9_248-l9_250;
float l9_252=step(0.25,fract(l9_251*0.5));
l9_248=mix(l9_250,1.0-l9_250,fast::clamp(l9_252,0.0,1.0));
}
}
l9_237.x=l9_248;
float l9_253=l9_237.y;
int l9_254=l9_240.y;
if (l9_254==1)
{
l9_253=fract(l9_253);
}
else
{
if (l9_254==2)
{
float l9_255=fract(l9_253);
float l9_256=l9_253-l9_255;
float l9_257=step(0.25,fract(l9_256*0.5));
l9_253=mix(l9_255,1.0-l9_255,fast::clamp(l9_257,0.0,1.0));
}
}
l9_237.y=l9_253;
if (l9_241)
{
bool l9_258=l9_243;
bool l9_259;
if (l9_258)
{
l9_259=l9_240.x==3;
}
else
{
l9_259=l9_258;
}
float l9_260=l9_237.x;
float l9_261=l9_242.x;
float l9_262=l9_242.z;
bool l9_263=l9_259;
float l9_264=l9_247;
float l9_265=fast::clamp(l9_260,l9_261,l9_262);
float l9_266=step(abs(l9_260-l9_265),9.9999997e-06);
l9_264*=(l9_266+((1.0-float(l9_263))*(1.0-l9_266)));
l9_260=l9_265;
l9_237.x=l9_260;
l9_247=l9_264;
bool l9_267=l9_243;
bool l9_268;
if (l9_267)
{
l9_268=l9_240.y==3;
}
else
{
l9_268=l9_267;
}
float l9_269=l9_237.y;
float l9_270=l9_242.y;
float l9_271=l9_242.w;
bool l9_272=l9_268;
float l9_273=l9_247;
float l9_274=fast::clamp(l9_269,l9_270,l9_271);
float l9_275=step(abs(l9_269-l9_274),9.9999997e-06);
l9_273*=(l9_275+((1.0-float(l9_272))*(1.0-l9_275)));
l9_269=l9_274;
l9_237.y=l9_269;
l9_247=l9_273;
}
float2 l9_276=l9_237;
bool l9_277=l9_238;
float3x3 l9_278=l9_239;
if (l9_277)
{
l9_276=float2((l9_278*float3(l9_276,1.0)).xy);
}
float2 l9_279=l9_276;
float2 l9_280=l9_279;
float2 l9_281=l9_280;
l9_237=l9_281;
float l9_282=l9_237.x;
int l9_283=l9_240.x;
bool l9_284=l9_246;
float l9_285=l9_247;
if ((l9_283==0)||(l9_283==3))
{
float l9_286=l9_282;
float l9_287=0.0;
float l9_288=1.0;
bool l9_289=l9_284;
float l9_290=l9_285;
float l9_291=fast::clamp(l9_286,l9_287,l9_288);
float l9_292=step(abs(l9_286-l9_291),9.9999997e-06);
l9_290*=(l9_292+((1.0-float(l9_289))*(1.0-l9_292)));
l9_286=l9_291;
l9_282=l9_286;
l9_285=l9_290;
}
l9_237.x=l9_282;
l9_247=l9_285;
float l9_293=l9_237.y;
int l9_294=l9_240.y;
bool l9_295=l9_246;
float l9_296=l9_247;
if ((l9_294==0)||(l9_294==3))
{
float l9_297=l9_293;
float l9_298=0.0;
float l9_299=1.0;
bool l9_300=l9_295;
float l9_301=l9_296;
float l9_302=fast::clamp(l9_297,l9_298,l9_299);
float l9_303=step(abs(l9_297-l9_302),9.9999997e-06);
l9_301*=(l9_303+((1.0-float(l9_300))*(1.0-l9_303)));
l9_297=l9_302;
l9_293=l9_297;
l9_296=l9_301;
}
l9_237.y=l9_293;
l9_247=l9_296;
float2 l9_304=l9_237;
int l9_305=l9_235;
int l9_306=l9_236;
float l9_307=l9_245;
float2 l9_308=l9_304;
int l9_309=l9_305;
int l9_310=l9_306;
float3 l9_311=float3(0.0);
if (l9_309==0)
{
l9_311=float3(l9_308,0.0);
}
else
{
if (l9_309==1)
{
l9_311=float3(l9_308.x,(l9_308.y*0.5)+(0.5-(float(l9_310)*0.5)),0.0);
}
else
{
l9_311=float3(l9_308,float(l9_310));
}
}
float3 l9_312=l9_311;
float3 l9_313=l9_312;
float2 l9_314=l9_313.xy;
float l9_315=l9_307;
float4 l9_316=sc_set0.baseTex.sample(sc_set0.baseTexSmpSC,l9_314,bias(l9_315));
float4 l9_317=l9_316;
float4 l9_318=l9_317;
if (l9_243)
{
l9_318=mix(l9_244,l9_318,float4(l9_247));
}
float4 l9_319=l9_318;
l9_228=l9_319;
float4 l9_320=l9_228;
float3 l9_321=l9_320.xyz;
float2 l9_322=float2(l9_225.w,1.0-l9_225.y);
float4 l9_323=float4(0.0);
int l9_324=0;
if ((int(baseTexHasSwappedViews_tmp)!=0))
{
int l9_325=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_325=0;
}
else
{
l9_325=in.varStereoViewID;
}
int l9_326=l9_325;
l9_324=1-l9_326;
}
else
{
int l9_327=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_327=0;
}
else
{
l9_327=in.varStereoViewID;
}
int l9_328=l9_327;
l9_324=l9_328;
}
int l9_329=l9_324;
int l9_330=baseTexLayout_tmp;
int l9_331=l9_329;
float2 l9_332=l9_322;
bool l9_333=(int(SC_USE_UV_TRANSFORM_baseTex_tmp)!=0);
float3x3 l9_334=(*sc_set0.UserUniforms).baseTexTransform;
int2 l9_335=int2(SC_SOFTWARE_WRAP_MODE_U_baseTex_tmp,SC_SOFTWARE_WRAP_MODE_V_baseTex_tmp);
bool l9_336=(int(SC_USE_UV_MIN_MAX_baseTex_tmp)!=0);
float4 l9_337=(*sc_set0.UserUniforms).baseTexUvMinMax;
bool l9_338=(int(SC_USE_CLAMP_TO_BORDER_baseTex_tmp)!=0);
float4 l9_339=(*sc_set0.UserUniforms).baseTexBorderColor;
float l9_340=0.0;
bool l9_341=l9_338&&(!l9_336);
float l9_342=1.0;
float l9_343=l9_332.x;
int l9_344=l9_335.x;
if (l9_344==1)
{
l9_343=fract(l9_343);
}
else
{
if (l9_344==2)
{
float l9_345=fract(l9_343);
float l9_346=l9_343-l9_345;
float l9_347=step(0.25,fract(l9_346*0.5));
l9_343=mix(l9_345,1.0-l9_345,fast::clamp(l9_347,0.0,1.0));
}
}
l9_332.x=l9_343;
float l9_348=l9_332.y;
int l9_349=l9_335.y;
if (l9_349==1)
{
l9_348=fract(l9_348);
}
else
{
if (l9_349==2)
{
float l9_350=fract(l9_348);
float l9_351=l9_348-l9_350;
float l9_352=step(0.25,fract(l9_351*0.5));
l9_348=mix(l9_350,1.0-l9_350,fast::clamp(l9_352,0.0,1.0));
}
}
l9_332.y=l9_348;
if (l9_336)
{
bool l9_353=l9_338;
bool l9_354;
if (l9_353)
{
l9_354=l9_335.x==3;
}
else
{
l9_354=l9_353;
}
float l9_355=l9_332.x;
float l9_356=l9_337.x;
float l9_357=l9_337.z;
bool l9_358=l9_354;
float l9_359=l9_342;
float l9_360=fast::clamp(l9_355,l9_356,l9_357);
float l9_361=step(abs(l9_355-l9_360),9.9999997e-06);
l9_359*=(l9_361+((1.0-float(l9_358))*(1.0-l9_361)));
l9_355=l9_360;
l9_332.x=l9_355;
l9_342=l9_359;
bool l9_362=l9_338;
bool l9_363;
if (l9_362)
{
l9_363=l9_335.y==3;
}
else
{
l9_363=l9_362;
}
float l9_364=l9_332.y;
float l9_365=l9_337.y;
float l9_366=l9_337.w;
bool l9_367=l9_363;
float l9_368=l9_342;
float l9_369=fast::clamp(l9_364,l9_365,l9_366);
float l9_370=step(abs(l9_364-l9_369),9.9999997e-06);
l9_368*=(l9_370+((1.0-float(l9_367))*(1.0-l9_370)));
l9_364=l9_369;
l9_332.y=l9_364;
l9_342=l9_368;
}
float2 l9_371=l9_332;
bool l9_372=l9_333;
float3x3 l9_373=l9_334;
if (l9_372)
{
l9_371=float2((l9_373*float3(l9_371,1.0)).xy);
}
float2 l9_374=l9_371;
float2 l9_375=l9_374;
float2 l9_376=l9_375;
l9_332=l9_376;
float l9_377=l9_332.x;
int l9_378=l9_335.x;
bool l9_379=l9_341;
float l9_380=l9_342;
if ((l9_378==0)||(l9_378==3))
{
float l9_381=l9_377;
float l9_382=0.0;
float l9_383=1.0;
bool l9_384=l9_379;
float l9_385=l9_380;
float l9_386=fast::clamp(l9_381,l9_382,l9_383);
float l9_387=step(abs(l9_381-l9_386),9.9999997e-06);
l9_385*=(l9_387+((1.0-float(l9_384))*(1.0-l9_387)));
l9_381=l9_386;
l9_377=l9_381;
l9_380=l9_385;
}
l9_332.x=l9_377;
l9_342=l9_380;
float l9_388=l9_332.y;
int l9_389=l9_335.y;
bool l9_390=l9_341;
float l9_391=l9_342;
if ((l9_389==0)||(l9_389==3))
{
float l9_392=l9_388;
float l9_393=0.0;
float l9_394=1.0;
bool l9_395=l9_390;
float l9_396=l9_391;
float l9_397=fast::clamp(l9_392,l9_393,l9_394);
float l9_398=step(abs(l9_392-l9_397),9.9999997e-06);
l9_396*=(l9_398+((1.0-float(l9_395))*(1.0-l9_398)));
l9_392=l9_397;
l9_388=l9_392;
l9_391=l9_396;
}
l9_332.y=l9_388;
l9_342=l9_391;
float2 l9_399=l9_332;
int l9_400=l9_330;
int l9_401=l9_331;
float l9_402=l9_340;
float2 l9_403=l9_399;
int l9_404=l9_400;
int l9_405=l9_401;
float3 l9_406=float3(0.0);
if (l9_404==0)
{
l9_406=float3(l9_403,0.0);
}
else
{
if (l9_404==1)
{
l9_406=float3(l9_403.x,(l9_403.y*0.5)+(0.5-(float(l9_405)*0.5)),0.0);
}
else
{
l9_406=float3(l9_403,float(l9_405));
}
}
float3 l9_407=l9_406;
float3 l9_408=l9_407;
float2 l9_409=l9_408.xy;
float l9_410=l9_402;
float4 l9_411=sc_set0.baseTex.sample(sc_set0.baseTexSmpSC,l9_409,bias(l9_410));
float4 l9_412=l9_411;
float4 l9_413=l9_412;
if (l9_338)
{
l9_413=mix(l9_339,l9_413,float4(l9_342));
}
float4 l9_414=l9_413;
l9_323=l9_414;
float4 l9_415=l9_323;
float3 l9_416=l9_415.xyz;
float3 l9_417=mix(l9_321,l9_416,float3(l9_226));
float3 l9_418=l9_417;
float3 l9_419=l9_418*N12_BaseColor.xyz;
N12_Result=float4(mix(N12_ScreenTexture,l9_419,float3(N12_factor)),1.0);
l9_219=N12_Result;
l9_215=l9_219;
param=l9_215;
param_2=param;
}
else
{
float2 l9_420=float2(0.0);
l9_420=param_3.gScreenCoord;
float4 l9_421=float4(0.0);
int l9_422=0;
if ((int(screenTextureHasSwappedViews_tmp)!=0))
{
int l9_423=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_423=0;
}
else
{
l9_423=in.varStereoViewID;
}
int l9_424=l9_423;
l9_422=1-l9_424;
}
else
{
int l9_425=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_425=0;
}
else
{
l9_425=in.varStereoViewID;
}
int l9_426=l9_425;
l9_422=l9_426;
}
int l9_427=l9_422;
int l9_428=screenTextureLayout_tmp;
int l9_429=l9_427;
float2 l9_430=l9_420;
bool l9_431=(int(SC_USE_UV_TRANSFORM_screenTexture_tmp)!=0);
float3x3 l9_432=(*sc_set0.UserUniforms).screenTextureTransform;
int2 l9_433=int2(SC_SOFTWARE_WRAP_MODE_U_screenTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_screenTexture_tmp);
bool l9_434=(int(SC_USE_UV_MIN_MAX_screenTexture_tmp)!=0);
float4 l9_435=(*sc_set0.UserUniforms).screenTextureUvMinMax;
bool l9_436=(int(SC_USE_CLAMP_TO_BORDER_screenTexture_tmp)!=0);
float4 l9_437=(*sc_set0.UserUniforms).screenTextureBorderColor;
float l9_438=0.0;
bool l9_439=l9_436&&(!l9_434);
float l9_440=1.0;
float l9_441=l9_430.x;
int l9_442=l9_433.x;
if (l9_442==1)
{
l9_441=fract(l9_441);
}
else
{
if (l9_442==2)
{
float l9_443=fract(l9_441);
float l9_444=l9_441-l9_443;
float l9_445=step(0.25,fract(l9_444*0.5));
l9_441=mix(l9_443,1.0-l9_443,fast::clamp(l9_445,0.0,1.0));
}
}
l9_430.x=l9_441;
float l9_446=l9_430.y;
int l9_447=l9_433.y;
if (l9_447==1)
{
l9_446=fract(l9_446);
}
else
{
if (l9_447==2)
{
float l9_448=fract(l9_446);
float l9_449=l9_446-l9_448;
float l9_450=step(0.25,fract(l9_449*0.5));
l9_446=mix(l9_448,1.0-l9_448,fast::clamp(l9_450,0.0,1.0));
}
}
l9_430.y=l9_446;
if (l9_434)
{
bool l9_451=l9_436;
bool l9_452;
if (l9_451)
{
l9_452=l9_433.x==3;
}
else
{
l9_452=l9_451;
}
float l9_453=l9_430.x;
float l9_454=l9_435.x;
float l9_455=l9_435.z;
bool l9_456=l9_452;
float l9_457=l9_440;
float l9_458=fast::clamp(l9_453,l9_454,l9_455);
float l9_459=step(abs(l9_453-l9_458),9.9999997e-06);
l9_457*=(l9_459+((1.0-float(l9_456))*(1.0-l9_459)));
l9_453=l9_458;
l9_430.x=l9_453;
l9_440=l9_457;
bool l9_460=l9_436;
bool l9_461;
if (l9_460)
{
l9_461=l9_433.y==3;
}
else
{
l9_461=l9_460;
}
float l9_462=l9_430.y;
float l9_463=l9_435.y;
float l9_464=l9_435.w;
bool l9_465=l9_461;
float l9_466=l9_440;
float l9_467=fast::clamp(l9_462,l9_463,l9_464);
float l9_468=step(abs(l9_462-l9_467),9.9999997e-06);
l9_466*=(l9_468+((1.0-float(l9_465))*(1.0-l9_468)));
l9_462=l9_467;
l9_430.y=l9_462;
l9_440=l9_466;
}
float2 l9_469=l9_430;
bool l9_470=l9_431;
float3x3 l9_471=l9_432;
if (l9_470)
{
l9_469=float2((l9_471*float3(l9_469,1.0)).xy);
}
float2 l9_472=l9_469;
float2 l9_473=l9_472;
float2 l9_474=l9_473;
l9_430=l9_474;
float l9_475=l9_430.x;
int l9_476=l9_433.x;
bool l9_477=l9_439;
float l9_478=l9_440;
if ((l9_476==0)||(l9_476==3))
{
float l9_479=l9_475;
float l9_480=0.0;
float l9_481=1.0;
bool l9_482=l9_477;
float l9_483=l9_478;
float l9_484=fast::clamp(l9_479,l9_480,l9_481);
float l9_485=step(abs(l9_479-l9_484),9.9999997e-06);
l9_483*=(l9_485+((1.0-float(l9_482))*(1.0-l9_485)));
l9_479=l9_484;
l9_475=l9_479;
l9_478=l9_483;
}
l9_430.x=l9_475;
l9_440=l9_478;
float l9_486=l9_430.y;
int l9_487=l9_433.y;
bool l9_488=l9_439;
float l9_489=l9_440;
if ((l9_487==0)||(l9_487==3))
{
float l9_490=l9_486;
float l9_491=0.0;
float l9_492=1.0;
bool l9_493=l9_488;
float l9_494=l9_489;
float l9_495=fast::clamp(l9_490,l9_491,l9_492);
float l9_496=step(abs(l9_490-l9_495),9.9999997e-06);
l9_494*=(l9_496+((1.0-float(l9_493))*(1.0-l9_496)));
l9_490=l9_495;
l9_486=l9_490;
l9_489=l9_494;
}
l9_430.y=l9_486;
l9_440=l9_489;
float2 l9_497=l9_430;
int l9_498=l9_428;
int l9_499=l9_429;
float l9_500=l9_438;
float2 l9_501=l9_497;
int l9_502=l9_498;
int l9_503=l9_499;
float3 l9_504=float3(0.0);
if (l9_502==0)
{
l9_504=float3(l9_501,0.0);
}
else
{
if (l9_502==1)
{
l9_504=float3(l9_501.x,(l9_501.y*0.5)+(0.5-(float(l9_503)*0.5)),0.0);
}
else
{
l9_504=float3(l9_501,float(l9_503));
}
}
float3 l9_505=l9_504;
float3 l9_506=l9_505;
float2 l9_507=l9_506.xy;
float l9_508=l9_500;
float4 l9_509=sc_set0.screenTexture.sample(sc_set0.screenTextureSmpSC,l9_507,bias(l9_508));
float4 l9_510=l9_509;
float4 l9_511=l9_510;
if (l9_436)
{
l9_511=mix(l9_437,l9_511,float4(l9_440));
}
float4 l9_512=l9_511;
l9_421=l9_512;
float4 l9_513=float4(0.0);
float4 l9_514=l9_421;
float l9_515=l9_514.z*15.0;
float2 l9_516=fast::clamp(float2(floor(l9_515))+float2(0.0,1.0),float2(0.0),float2(15.0));
float3 l9_517=((l9_514.xxy*float3(0.05859375,0.05859375,0.9375))+float3(l9_516*0.0625,0.0))+float3(0.001953125,0.001953125,0.03125);
float l9_518=l9_515-l9_516.x;
int l9_519=0;
if ((int(baseTexHasSwappedViews_tmp)!=0))
{
int l9_520=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_520=0;
}
else
{
l9_520=in.varStereoViewID;
}
int l9_521=l9_520;
l9_519=1-l9_521;
}
else
{
int l9_522=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_522=0;
}
else
{
l9_522=in.varStereoViewID;
}
int l9_523=l9_522;
l9_519=l9_523;
}
int l9_524=l9_519;
int l9_525=baseTexLayout_tmp;
int l9_526=l9_524;
float2 l9_527=l9_517.xz;
bool l9_528=(int(SC_USE_UV_TRANSFORM_baseTex_tmp)!=0);
float3x3 l9_529=(*sc_set0.UserUniforms).baseTexTransform;
int2 l9_530=int2(SC_SOFTWARE_WRAP_MODE_U_baseTex_tmp,SC_SOFTWARE_WRAP_MODE_V_baseTex_tmp);
bool l9_531=(int(SC_USE_UV_MIN_MAX_baseTex_tmp)!=0);
float4 l9_532=(*sc_set0.UserUniforms).baseTexUvMinMax;
bool l9_533=(int(SC_USE_CLAMP_TO_BORDER_baseTex_tmp)!=0);
float4 l9_534=(*sc_set0.UserUniforms).baseTexBorderColor;
float l9_535=0.0;
bool l9_536=l9_533&&(!l9_531);
float l9_537=1.0;
float l9_538=l9_527.x;
int l9_539=l9_530.x;
if (l9_539==1)
{
l9_538=fract(l9_538);
}
else
{
if (l9_539==2)
{
float l9_540=fract(l9_538);
float l9_541=l9_538-l9_540;
float l9_542=step(0.25,fract(l9_541*0.5));
l9_538=mix(l9_540,1.0-l9_540,fast::clamp(l9_542,0.0,1.0));
}
}
l9_527.x=l9_538;
float l9_543=l9_527.y;
int l9_544=l9_530.y;
if (l9_544==1)
{
l9_543=fract(l9_543);
}
else
{
if (l9_544==2)
{
float l9_545=fract(l9_543);
float l9_546=l9_543-l9_545;
float l9_547=step(0.25,fract(l9_546*0.5));
l9_543=mix(l9_545,1.0-l9_545,fast::clamp(l9_547,0.0,1.0));
}
}
l9_527.y=l9_543;
if (l9_531)
{
bool l9_548=l9_533;
bool l9_549;
if (l9_548)
{
l9_549=l9_530.x==3;
}
else
{
l9_549=l9_548;
}
float l9_550=l9_527.x;
float l9_551=l9_532.x;
float l9_552=l9_532.z;
bool l9_553=l9_549;
float l9_554=l9_537;
float l9_555=fast::clamp(l9_550,l9_551,l9_552);
float l9_556=step(abs(l9_550-l9_555),9.9999997e-06);
l9_554*=(l9_556+((1.0-float(l9_553))*(1.0-l9_556)));
l9_550=l9_555;
l9_527.x=l9_550;
l9_537=l9_554;
bool l9_557=l9_533;
bool l9_558;
if (l9_557)
{
l9_558=l9_530.y==3;
}
else
{
l9_558=l9_557;
}
float l9_559=l9_527.y;
float l9_560=l9_532.y;
float l9_561=l9_532.w;
bool l9_562=l9_558;
float l9_563=l9_537;
float l9_564=fast::clamp(l9_559,l9_560,l9_561);
float l9_565=step(abs(l9_559-l9_564),9.9999997e-06);
l9_563*=(l9_565+((1.0-float(l9_562))*(1.0-l9_565)));
l9_559=l9_564;
l9_527.y=l9_559;
l9_537=l9_563;
}
float2 l9_566=l9_527;
bool l9_567=l9_528;
float3x3 l9_568=l9_529;
if (l9_567)
{
l9_566=float2((l9_568*float3(l9_566,1.0)).xy);
}
float2 l9_569=l9_566;
float2 l9_570=l9_569;
float2 l9_571=l9_570;
l9_527=l9_571;
float l9_572=l9_527.x;
int l9_573=l9_530.x;
bool l9_574=l9_536;
float l9_575=l9_537;
if ((l9_573==0)||(l9_573==3))
{
float l9_576=l9_572;
float l9_577=0.0;
float l9_578=1.0;
bool l9_579=l9_574;
float l9_580=l9_575;
float l9_581=fast::clamp(l9_576,l9_577,l9_578);
float l9_582=step(abs(l9_576-l9_581),9.9999997e-06);
l9_580*=(l9_582+((1.0-float(l9_579))*(1.0-l9_582)));
l9_576=l9_581;
l9_572=l9_576;
l9_575=l9_580;
}
l9_527.x=l9_572;
l9_537=l9_575;
float l9_583=l9_527.y;
int l9_584=l9_530.y;
bool l9_585=l9_536;
float l9_586=l9_537;
if ((l9_584==0)||(l9_584==3))
{
float l9_587=l9_583;
float l9_588=0.0;
float l9_589=1.0;
bool l9_590=l9_585;
float l9_591=l9_586;
float l9_592=fast::clamp(l9_587,l9_588,l9_589);
float l9_593=step(abs(l9_587-l9_592),9.9999997e-06);
l9_591*=(l9_593+((1.0-float(l9_590))*(1.0-l9_593)));
l9_587=l9_592;
l9_583=l9_587;
l9_586=l9_591;
}
l9_527.y=l9_583;
l9_537=l9_586;
float2 l9_594=l9_527;
int l9_595=l9_525;
int l9_596=l9_526;
float l9_597=l9_535;
float2 l9_598=l9_594;
int l9_599=l9_595;
int l9_600=l9_596;
float3 l9_601=float3(0.0);
if (l9_599==0)
{
l9_601=float3(l9_598,0.0);
}
else
{
if (l9_599==1)
{
l9_601=float3(l9_598.x,(l9_598.y*0.5)+(0.5-(float(l9_600)*0.5)),0.0);
}
else
{
l9_601=float3(l9_598,float(l9_600));
}
}
float3 l9_602=l9_601;
float3 l9_603=l9_602;
float2 l9_604=l9_603.xy;
float l9_605=l9_597;
float4 l9_606=sc_set0.baseTex.sample(sc_set0.baseTexSmpSC,l9_604,bias(l9_605));
float4 l9_607=l9_606;
float4 l9_608=l9_607;
if (l9_533)
{
l9_608=mix(l9_534,l9_608,float4(l9_537));
}
float4 l9_609=l9_608;
float4 l9_610=l9_609;
int l9_611=0;
if ((int(baseTexHasSwappedViews_tmp)!=0))
{
int l9_612=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_612=0;
}
else
{
l9_612=in.varStereoViewID;
}
int l9_613=l9_612;
l9_611=1-l9_613;
}
else
{
int l9_614=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_614=0;
}
else
{
l9_614=in.varStereoViewID;
}
int l9_615=l9_614;
l9_611=l9_615;
}
int l9_616=l9_611;
int l9_617=baseTexLayout_tmp;
int l9_618=l9_616;
float2 l9_619=l9_517.yz;
bool l9_620=(int(SC_USE_UV_TRANSFORM_baseTex_tmp)!=0);
float3x3 l9_621=(*sc_set0.UserUniforms).baseTexTransform;
int2 l9_622=int2(SC_SOFTWARE_WRAP_MODE_U_baseTex_tmp,SC_SOFTWARE_WRAP_MODE_V_baseTex_tmp);
bool l9_623=(int(SC_USE_UV_MIN_MAX_baseTex_tmp)!=0);
float4 l9_624=(*sc_set0.UserUniforms).baseTexUvMinMax;
bool l9_625=(int(SC_USE_CLAMP_TO_BORDER_baseTex_tmp)!=0);
float4 l9_626=(*sc_set0.UserUniforms).baseTexBorderColor;
float l9_627=0.0;
bool l9_628=l9_625&&(!l9_623);
float l9_629=1.0;
float l9_630=l9_619.x;
int l9_631=l9_622.x;
if (l9_631==1)
{
l9_630=fract(l9_630);
}
else
{
if (l9_631==2)
{
float l9_632=fract(l9_630);
float l9_633=l9_630-l9_632;
float l9_634=step(0.25,fract(l9_633*0.5));
l9_630=mix(l9_632,1.0-l9_632,fast::clamp(l9_634,0.0,1.0));
}
}
l9_619.x=l9_630;
float l9_635=l9_619.y;
int l9_636=l9_622.y;
if (l9_636==1)
{
l9_635=fract(l9_635);
}
else
{
if (l9_636==2)
{
float l9_637=fract(l9_635);
float l9_638=l9_635-l9_637;
float l9_639=step(0.25,fract(l9_638*0.5));
l9_635=mix(l9_637,1.0-l9_637,fast::clamp(l9_639,0.0,1.0));
}
}
l9_619.y=l9_635;
if (l9_623)
{
bool l9_640=l9_625;
bool l9_641;
if (l9_640)
{
l9_641=l9_622.x==3;
}
else
{
l9_641=l9_640;
}
float l9_642=l9_619.x;
float l9_643=l9_624.x;
float l9_644=l9_624.z;
bool l9_645=l9_641;
float l9_646=l9_629;
float l9_647=fast::clamp(l9_642,l9_643,l9_644);
float l9_648=step(abs(l9_642-l9_647),9.9999997e-06);
l9_646*=(l9_648+((1.0-float(l9_645))*(1.0-l9_648)));
l9_642=l9_647;
l9_619.x=l9_642;
l9_629=l9_646;
bool l9_649=l9_625;
bool l9_650;
if (l9_649)
{
l9_650=l9_622.y==3;
}
else
{
l9_650=l9_649;
}
float l9_651=l9_619.y;
float l9_652=l9_624.y;
float l9_653=l9_624.w;
bool l9_654=l9_650;
float l9_655=l9_629;
float l9_656=fast::clamp(l9_651,l9_652,l9_653);
float l9_657=step(abs(l9_651-l9_656),9.9999997e-06);
l9_655*=(l9_657+((1.0-float(l9_654))*(1.0-l9_657)));
l9_651=l9_656;
l9_619.y=l9_651;
l9_629=l9_655;
}
float2 l9_658=l9_619;
bool l9_659=l9_620;
float3x3 l9_660=l9_621;
if (l9_659)
{
l9_658=float2((l9_660*float3(l9_658,1.0)).xy);
}
float2 l9_661=l9_658;
float2 l9_662=l9_661;
float2 l9_663=l9_662;
l9_619=l9_663;
float l9_664=l9_619.x;
int l9_665=l9_622.x;
bool l9_666=l9_628;
float l9_667=l9_629;
if ((l9_665==0)||(l9_665==3))
{
float l9_668=l9_664;
float l9_669=0.0;
float l9_670=1.0;
bool l9_671=l9_666;
float l9_672=l9_667;
float l9_673=fast::clamp(l9_668,l9_669,l9_670);
float l9_674=step(abs(l9_668-l9_673),9.9999997e-06);
l9_672*=(l9_674+((1.0-float(l9_671))*(1.0-l9_674)));
l9_668=l9_673;
l9_664=l9_668;
l9_667=l9_672;
}
l9_619.x=l9_664;
l9_629=l9_667;
float l9_675=l9_619.y;
int l9_676=l9_622.y;
bool l9_677=l9_628;
float l9_678=l9_629;
if ((l9_676==0)||(l9_676==3))
{
float l9_679=l9_675;
float l9_680=0.0;
float l9_681=1.0;
bool l9_682=l9_677;
float l9_683=l9_678;
float l9_684=fast::clamp(l9_679,l9_680,l9_681);
float l9_685=step(abs(l9_679-l9_684),9.9999997e-06);
l9_683*=(l9_685+((1.0-float(l9_682))*(1.0-l9_685)));
l9_679=l9_684;
l9_675=l9_679;
l9_678=l9_683;
}
l9_619.y=l9_675;
l9_629=l9_678;
float2 l9_686=l9_619;
int l9_687=l9_617;
int l9_688=l9_618;
float l9_689=l9_627;
float2 l9_690=l9_686;
int l9_691=l9_687;
int l9_692=l9_688;
float3 l9_693=float3(0.0);
if (l9_691==0)
{
l9_693=float3(l9_690,0.0);
}
else
{
if (l9_691==1)
{
l9_693=float3(l9_690.x,(l9_690.y*0.5)+(0.5-(float(l9_692)*0.5)),0.0);
}
else
{
l9_693=float3(l9_690,float(l9_692));
}
}
float3 l9_694=l9_693;
float3 l9_695=l9_694;
float2 l9_696=l9_695.xy;
float l9_697=l9_689;
float4 l9_698=sc_set0.baseTex.sample(sc_set0.baseTexSmpSC,l9_696,bias(l9_697));
float4 l9_699=l9_698;
float4 l9_700=l9_699;
if (l9_625)
{
l9_700=mix(l9_626,l9_700,float4(l9_629));
}
float4 l9_701=l9_700;
float4 l9_702=l9_701;
float4 l9_703=float4(mix(l9_610.xyz,l9_702.xyz,float3(l9_518)),l9_514.w);
l9_513=l9_703;
float4 l9_704=float4(0.0);
float4 l9_705=(*sc_set0.UserUniforms).baseColor;
l9_704=l9_705;
float3 l9_706=float3(0.0);
l9_706=l9_513.xyz*l9_704.xyz;
float l9_707=0.0;
l9_707=l9_704.w;
float l9_708=0.0;
float l9_709=1.0;
float l9_710=(*sc_set0.UserUniforms).Port_Input2_N011;
ssGlobals l9_711=param_3;
float l9_712;
if ((int(ENABLE_OPACITY_TEX_tmp)!=0))
{
float2 l9_713=float2(0.0);
l9_713=l9_711.gScreenCoord;
float4 l9_714=float4(0.0);
int l9_715=0;
if ((int(opacityTexHasSwappedViews_tmp)!=0))
{
int l9_716=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_716=0;
}
else
{
l9_716=in.varStereoViewID;
}
int l9_717=l9_716;
l9_715=1-l9_717;
}
else
{
int l9_718=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_718=0;
}
else
{
l9_718=in.varStereoViewID;
}
int l9_719=l9_718;
l9_715=l9_719;
}
int l9_720=l9_715;
int l9_721=opacityTexLayout_tmp;
int l9_722=l9_720;
float2 l9_723=l9_713;
bool l9_724=(int(SC_USE_UV_TRANSFORM_opacityTex_tmp)!=0);
float3x3 l9_725=(*sc_set0.UserUniforms).opacityTexTransform;
int2 l9_726=int2(SC_SOFTWARE_WRAP_MODE_U_opacityTex_tmp,SC_SOFTWARE_WRAP_MODE_V_opacityTex_tmp);
bool l9_727=(int(SC_USE_UV_MIN_MAX_opacityTex_tmp)!=0);
float4 l9_728=(*sc_set0.UserUniforms).opacityTexUvMinMax;
bool l9_729=(int(SC_USE_CLAMP_TO_BORDER_opacityTex_tmp)!=0);
float4 l9_730=(*sc_set0.UserUniforms).opacityTexBorderColor;
float l9_731=0.0;
bool l9_732=l9_729&&(!l9_727);
float l9_733=1.0;
float l9_734=l9_723.x;
int l9_735=l9_726.x;
if (l9_735==1)
{
l9_734=fract(l9_734);
}
else
{
if (l9_735==2)
{
float l9_736=fract(l9_734);
float l9_737=l9_734-l9_736;
float l9_738=step(0.25,fract(l9_737*0.5));
l9_734=mix(l9_736,1.0-l9_736,fast::clamp(l9_738,0.0,1.0));
}
}
l9_723.x=l9_734;
float l9_739=l9_723.y;
int l9_740=l9_726.y;
if (l9_740==1)
{
l9_739=fract(l9_739);
}
else
{
if (l9_740==2)
{
float l9_741=fract(l9_739);
float l9_742=l9_739-l9_741;
float l9_743=step(0.25,fract(l9_742*0.5));
l9_739=mix(l9_741,1.0-l9_741,fast::clamp(l9_743,0.0,1.0));
}
}
l9_723.y=l9_739;
if (l9_727)
{
bool l9_744=l9_729;
bool l9_745;
if (l9_744)
{
l9_745=l9_726.x==3;
}
else
{
l9_745=l9_744;
}
float l9_746=l9_723.x;
float l9_747=l9_728.x;
float l9_748=l9_728.z;
bool l9_749=l9_745;
float l9_750=l9_733;
float l9_751=fast::clamp(l9_746,l9_747,l9_748);
float l9_752=step(abs(l9_746-l9_751),9.9999997e-06);
l9_750*=(l9_752+((1.0-float(l9_749))*(1.0-l9_752)));
l9_746=l9_751;
l9_723.x=l9_746;
l9_733=l9_750;
bool l9_753=l9_729;
bool l9_754;
if (l9_753)
{
l9_754=l9_726.y==3;
}
else
{
l9_754=l9_753;
}
float l9_755=l9_723.y;
float l9_756=l9_728.y;
float l9_757=l9_728.w;
bool l9_758=l9_754;
float l9_759=l9_733;
float l9_760=fast::clamp(l9_755,l9_756,l9_757);
float l9_761=step(abs(l9_755-l9_760),9.9999997e-06);
l9_759*=(l9_761+((1.0-float(l9_758))*(1.0-l9_761)));
l9_755=l9_760;
l9_723.y=l9_755;
l9_733=l9_759;
}
float2 l9_762=l9_723;
bool l9_763=l9_724;
float3x3 l9_764=l9_725;
if (l9_763)
{
l9_762=float2((l9_764*float3(l9_762,1.0)).xy);
}
float2 l9_765=l9_762;
float2 l9_766=l9_765;
float2 l9_767=l9_766;
l9_723=l9_767;
float l9_768=l9_723.x;
int l9_769=l9_726.x;
bool l9_770=l9_732;
float l9_771=l9_733;
if ((l9_769==0)||(l9_769==3))
{
float l9_772=l9_768;
float l9_773=0.0;
float l9_774=1.0;
bool l9_775=l9_770;
float l9_776=l9_771;
float l9_777=fast::clamp(l9_772,l9_773,l9_774);
float l9_778=step(abs(l9_772-l9_777),9.9999997e-06);
l9_776*=(l9_778+((1.0-float(l9_775))*(1.0-l9_778)));
l9_772=l9_777;
l9_768=l9_772;
l9_771=l9_776;
}
l9_723.x=l9_768;
l9_733=l9_771;
float l9_779=l9_723.y;
int l9_780=l9_726.y;
bool l9_781=l9_732;
float l9_782=l9_733;
if ((l9_780==0)||(l9_780==3))
{
float l9_783=l9_779;
float l9_784=0.0;
float l9_785=1.0;
bool l9_786=l9_781;
float l9_787=l9_782;
float l9_788=fast::clamp(l9_783,l9_784,l9_785);
float l9_789=step(abs(l9_783-l9_788),9.9999997e-06);
l9_787*=(l9_789+((1.0-float(l9_786))*(1.0-l9_789)));
l9_783=l9_788;
l9_779=l9_783;
l9_782=l9_787;
}
l9_723.y=l9_779;
l9_733=l9_782;
float2 l9_790=l9_723;
int l9_791=l9_721;
int l9_792=l9_722;
float l9_793=l9_731;
float2 l9_794=l9_790;
int l9_795=l9_791;
int l9_796=l9_792;
float3 l9_797=float3(0.0);
if (l9_795==0)
{
l9_797=float3(l9_794,0.0);
}
else
{
if (l9_795==1)
{
l9_797=float3(l9_794.x,(l9_794.y*0.5)+(0.5-(float(l9_796)*0.5)),0.0);
}
else
{
l9_797=float3(l9_794,float(l9_796));
}
}
float3 l9_798=l9_797;
float3 l9_799=l9_798;
float2 l9_800=l9_799.xy;
float l9_801=l9_793;
float4 l9_802=sc_set0.opacityTex.sample(sc_set0.opacityTexSmpSC,l9_800,bias(l9_801));
float4 l9_803=l9_802;
float4 l9_804=l9_803;
if (l9_729)
{
l9_804=mix(l9_730,l9_804,float4(l9_733));
}
float4 l9_805=l9_804;
l9_714=l9_805;
float l9_806=0.0;
l9_806=l9_714.x;
float l9_807=0.0;
float l9_808=(*sc_set0.UserUniforms).opacity;
l9_807=l9_808;
float l9_809=0.0;
l9_809=l9_806*l9_807;
l9_709=l9_809;
l9_712=l9_709;
}
else
{
l9_712=l9_710;
}
l9_708=l9_712;
float l9_810=0.0;
l9_810=l9_707*l9_708;
float3 l9_811=float3(0.0);
l9_811=mix(l9_421.xyz,l9_706,float3(l9_810));
float4 l9_812=float4(0.0);
l9_812=float4(l9_811.x,l9_811.y,l9_811.z,1.0);
param_1=l9_812;
param_2=param_1;
}
Output_N14=param_2;
FinalColor=Output_N14;
float param_4=FinalColor.w;
if ((int(sc_BlendMode_AlphaTest_tmp)!=0))
{
if (param_4<(*sc_set0.UserUniforms).alphaTestThreshold)
{
discard_fragment();
}
}
if ((int(ENABLE_STIPPLE_PATTERN_TEST_tmp)!=0))
{
float4 l9_813=gl_FragCoord;
float2 l9_814=floor(mod(l9_813.xy,float2(4.0)));
float l9_815=(mod(dot(l9_814,float2(4.0,1.0))*9.0,16.0)+1.0)/17.0;
if (param_4<l9_815)
{
discard_fragment();
}
}
float4 param_5=FinalColor;
if ((int(sc_ProjectiveShadowsCaster_tmp)!=0))
{
float4 l9_816=param_5;
float4 l9_817=l9_816;
float l9_818=1.0;
if ((((int(sc_BlendMode_Normal_tmp)!=0)||(int(sc_BlendMode_AlphaToCoverage_tmp)!=0))||(int(sc_BlendMode_PremultipliedAlphaHardware_tmp)!=0))||(int(sc_BlendMode_PremultipliedAlphaAuto_tmp)!=0))
{
l9_818=l9_817.w;
}
else
{
if ((int(sc_BlendMode_PremultipliedAlpha_tmp)!=0))
{
l9_818=fast::clamp(l9_817.w*2.0,0.0,1.0);
}
else
{
if ((int(sc_BlendMode_AddWithAlphaFactor_tmp)!=0))
{
l9_818=fast::clamp(dot(l9_817.xyz,float3(l9_817.w)),0.0,1.0);
}
else
{
if ((int(sc_BlendMode_AlphaTest_tmp)!=0))
{
l9_818=1.0;
}
else
{
if ((int(sc_BlendMode_Multiply_tmp)!=0))
{
l9_818=(1.0-dot(l9_817.xyz,float3(0.33333001)))*l9_817.w;
}
else
{
if ((int(sc_BlendMode_MultiplyOriginal_tmp)!=0))
{
l9_818=(1.0-fast::clamp(dot(l9_817.xyz,float3(1.0)),0.0,1.0))*l9_817.w;
}
else
{
if ((int(sc_BlendMode_ColoredGlass_tmp)!=0))
{
l9_818=fast::clamp(dot(l9_817.xyz,float3(1.0)),0.0,1.0)*l9_817.w;
}
else
{
if ((int(sc_BlendMode_Add_tmp)!=0))
{
l9_818=fast::clamp(dot(l9_817.xyz,float3(1.0)),0.0,1.0);
}
else
{
if ((int(sc_BlendMode_AddWithAlphaFactor_tmp)!=0))
{
l9_818=fast::clamp(dot(l9_817.xyz,float3(1.0)),0.0,1.0)*l9_817.w;
}
else
{
if ((int(sc_BlendMode_Screen_tmp)!=0))
{
l9_818=dot(l9_817.xyz,float3(0.33333001))*l9_817.w;
}
else
{
if ((int(sc_BlendMode_Min_tmp)!=0))
{
l9_818=1.0-fast::clamp(dot(l9_817.xyz,float3(1.0)),0.0,1.0);
}
else
{
if ((int(sc_BlendMode_Max_tmp)!=0))
{
l9_818=fast::clamp(dot(l9_817.xyz,float3(1.0)),0.0,1.0);
}
}
}
}
}
}
}
}
}
}
}
}
float l9_819=l9_818;
float l9_820=l9_819;
float l9_821=(*sc_set0.UserUniforms).sc_ShadowDensity*l9_820;
float3 l9_822=mix((*sc_set0.UserUniforms).sc_ShadowColor.xyz,(*sc_set0.UserUniforms).sc_ShadowColor.xyz*l9_816.xyz,float3((*sc_set0.UserUniforms).sc_ShadowColor.w));
float4 l9_823=float4(l9_822.x,l9_822.y,l9_822.z,l9_821);
param_5=l9_823;
}
else
{
if ((int(sc_RenderAlphaToColor_tmp)!=0))
{
param_5=float4(param_5.w);
}
else
{
if ((int(sc_BlendMode_Custom_tmp)!=0))
{
float4 l9_824=param_5;
float4 l9_825=float4(0.0);
float4 l9_826=float4(0.0);
if ((int(sc_FramebufferFetch_tmp)!=0))
{
float4 l9_827=out.FragColor0;
float4 l9_828=l9_827;
if ((int(sc_UseFramebufferFetchMarker_tmp)!=0))
{
l9_828.x+=(*sc_set0.UserUniforms)._sc_framebufferFetchMarker;
}
float4 l9_829=l9_828;
l9_826=l9_829;
}
else
{
float4 l9_830=gl_FragCoord;
float2 l9_831=l9_830.xy*(*sc_set0.UserUniforms).sc_CurrentRenderTargetDims.zw;
float2 l9_832=l9_831;
float2 l9_833=float2(0.0);
if (sc_StereoRenderingMode_tmp==1)
{
int l9_834=1;
int l9_835=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_835=0;
}
else
{
l9_835=in.varStereoViewID;
}
int l9_836=l9_835;
int l9_837=l9_836;
float3 l9_838=float3(l9_832,0.0);
int l9_839=l9_834;
int l9_840=l9_837;
if (l9_839==1)
{
l9_838.y=((2.0*l9_838.y)+float(l9_840))-1.0;
}
float2 l9_841=l9_838.xy;
l9_833=l9_841;
}
else
{
l9_833=l9_832;
}
float2 l9_842=l9_833;
float2 l9_843=l9_842;
float2 l9_844=l9_843;
int l9_845=0;
if ((int(sc_ScreenTextureHasSwappedViews_tmp)!=0))
{
int l9_846=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_846=0;
}
else
{
l9_846=in.varStereoViewID;
}
int l9_847=l9_846;
l9_845=1-l9_847;
}
else
{
int l9_848=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_848=0;
}
else
{
l9_848=in.varStereoViewID;
}
int l9_849=l9_848;
l9_845=l9_849;
}
int l9_850=l9_845;
float2 l9_851=l9_844;
int l9_852=l9_850;
float2 l9_853=l9_851;
int l9_854=l9_852;
float l9_855=0.0;
float4 l9_856=float4(0.0);
float2 l9_857=l9_853;
int l9_858=sc_ScreenTextureLayout_tmp;
int l9_859=l9_854;
float l9_860=l9_855;
float2 l9_861=l9_857;
int l9_862=l9_858;
int l9_863=l9_859;
float3 l9_864=float3(0.0);
if (l9_862==0)
{
l9_864=float3(l9_861,0.0);
}
else
{
if (l9_862==1)
{
l9_864=float3(l9_861.x,(l9_861.y*0.5)+(0.5-(float(l9_863)*0.5)),0.0);
}
else
{
l9_864=float3(l9_861,float(l9_863));
}
}
float3 l9_865=l9_864;
float3 l9_866=l9_865;
float2 l9_867=l9_866.xy;
float l9_868=l9_860;
float4 l9_869=sc_set0.sc_ScreenTexture.sample(sc_set0.sc_ScreenTextureSmpSC,l9_867,bias(l9_868));
float4 l9_870=l9_869;
l9_856=l9_870;
float4 l9_871=l9_856;
float4 l9_872=l9_871;
float4 l9_873=l9_872;
l9_826=l9_873;
}
float4 l9_874=l9_826;
float4 l9_875=l9_874;
float3 l9_876=l9_875.xyz;
float3 l9_877=l9_876;
float3 l9_878=l9_824.xyz;
float3 l9_879=definedBlend(l9_877,l9_878,in.varStereoViewID,(*sc_set0.UserUniforms),sc_set0.intensityTexture,sc_set0.intensityTextureSmpSC);
l9_825=float4(l9_879.x,l9_879.y,l9_879.z,l9_825.w);
float3 l9_880=mix(l9_876,l9_825.xyz,float3(l9_824.w));
l9_825=float4(l9_880.x,l9_880.y,l9_880.z,l9_825.w);
l9_825.w=1.0;
float4 l9_881=l9_825;
param_5=l9_881;
}
else
{
float4 l9_882=param_5;
float4 l9_883=float4(0.0);
if ((int(sc_BlendMode_MultiplyOriginal_tmp)!=0))
{
l9_883=float4(mix(float3(1.0),l9_882.xyz,float3(l9_882.w)),l9_882.w);
}
else
{
if ((int(sc_BlendMode_Screen_tmp)!=0)||(int(sc_BlendMode_PremultipliedAlphaAuto_tmp)!=0))
{
float l9_884=l9_882.w;
if ((int(sc_BlendMode_PremultipliedAlphaAuto_tmp)!=0))
{
l9_884=fast::clamp(l9_884,0.0,1.0);
}
l9_883=float4(l9_882.xyz*l9_884,l9_884);
}
else
{
l9_883=l9_882;
}
}
float4 l9_885=l9_883;
param_5=l9_885;
}
}
}
float4 l9_886=param_5;
FinalColor=l9_886;
if ((*sc_set0.UserUniforms).PreviewEnabled==1)
{
if (PreviewInfo.Saved)
{
FinalColor=float4(PreviewInfo.Color);
}
else
{
FinalColor=float4(0.0);
}
}
float4 l9_887=float4(0.0);
if ((int(sc_ShaderComplexityAnalyzer_tmp)!=0))
{
l9_887=float4((*sc_set0.UserUniforms).shaderComplexityValue/255.0,0.0,0.0,1.0);
}
else
{
l9_887=float4(0.0);
}
float4 l9_888=l9_887;
float4 Cost=l9_888;
if (Cost.w>0.0)
{
FinalColor=Cost;
}
FinalColor=fast::max(FinalColor,float4(0.0));
float3 param_6=in.varPos;
float4 param_7=FinalColor;
FinalColor=outputMotionVectorsIfNeeded(param_6,param_7,in.varStereoViewID,(*sc_set0.UserUniforms));
float4 param_8=FinalColor;
float4 l9_889=param_8;
if (sc_ShaderCacheConstant_tmp!=0)
{
l9_889.x+=((*sc_set0.UserUniforms).sc_UniformConstants.x*float(sc_ShaderCacheConstant_tmp));
}
out.FragColor0=l9_889;
return out;
}
} // FRAGMENT SHADER
