(function () {
  "use strict";

  var canvas = document.getElementById("sky-scroll-bg");
  var blogSection = document.getElementById("blog-section");
  var blogList = document.getElementById("blog-list");
  var blogCards = blogList ? blogList.querySelectorAll("a") : [];

  if (!canvas || !blogSection || !blogList) {
    return;
  }

  var gl =
    canvas.getContext("webgl", {
      alpha: true,
      antialias: false,
      depth: false,
      stencil: false,
      preserveDrawingBuffer: false,
    }) || canvas.getContext("experimental-webgl");

  if (!gl) {
    return;
  }

  // Transition lands around the 4th blog card so the dark sky reveals over older posts.
  var TRIGGER_CARD_INDEX = 3;

  var motionQuery = window.matchMedia("(prefers-reduced-motion: reduce)");
  var reduceMotion = motionQuery.matches;

  var vertexSource = [
    "attribute vec2 aPosition;",
    "varying vec2 vUv;",
    "void main() {",
    "  vUv = aPosition * 0.5 + 0.5;",
    "  gl_Position = vec4(aPosition, 0.0, 1.0);",
    "}",
  ].join("\n");

  var fragmentSource = [
    "precision mediump float;",
    "uniform vec2 uResolution;",
    "uniform float uProgress;",
    "uniform float uSunProgress;",
    "uniform float uTime;",
    "varying vec2 vUv;",
    "float saturate(float x) { return clamp(x, 0.0, 1.0); }",
    "float hash(vec2 p) {",
    "  return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);",
    "}",
    "void main() {",
    "  vec2 uv = vUv;",
    "  float progress = smoothstep(0.0, 1.0, uProgress);",
    "  float aspect = uResolution.x / max(uResolution.y, 1.0);",
    "  vec2 p = vec2((uv.x - 0.5) * aspect, uv.y - 0.5);",
    "  float sunT = 1.0 - pow(1.0 - smoothstep(0.0, 1.0, uSunProgress), 1.35);",
    "  vec2 sunCenter = vec2(0.24, 0.34);",
    "  vec2 sunRadius = vec2(0.50, 0.48);",
    "  float sunAngle = mix(1.5708, 0.0, sunT);",
    "  vec2 sunUv = sunCenter + sunRadius * vec2(cos(sunAngle), sin(sunAngle));",
    "  float sunAltitude = smoothstep(0.34, 0.82, sunUv.y);",
    "  float lowSun = (1.0 - sunAltitude) * progress;",
    "  float descent = clamp(progress * 0.58 + lowSun * 0.42, 0.0, 1.0);",
    "  vec2 sunP = vec2((sunUv.x - 0.5) * aspect, sunUv.y - 0.5);",
    "  vec3 viewDir = normalize(vec3(p.x, p.y * 0.92 + 0.10, 1.0));",
    "  vec3 sunDir = normalize(vec3(sunP.x, sunP.y * 0.92 + 0.10, 1.0));",
    "  float mu = dot(viewDir, sunDir);",
    "  float rayleighPhase = 0.75 * (1.0 + mu * mu);",
    "  float g = 0.76;",
    "  float miePhase = (1.0 - g * g) / pow(max(1.0 + g * g - 2.0 * g * mu, 0.04), 1.5);",
    "  float altitude = mix(1.0, 0.08, lowSun);",
    "  float airMass = (1.08 - uv.y) * mix(0.24, 1.18, lowSun) + (1.0 - altitude) * 0.32;",
    "  vec3 betaRayleigh = vec3(0.16, 0.28, 0.52);",
    "  vec3 betaMie = vec3(0.70, 0.55, 0.38);",
    "  vec3 ozone = vec3(0.08, 0.18, 0.05) * lowSun;",
    "  vec3 transmittance = exp(-(betaRayleigh * airMass * 0.45 + betaMie * airMass * lowSun * 0.25 + ozone));",
    "  vec3 highSky = mix(vec3(0.995, 1.0, 1.0), vec3(0.003, 0.012, 0.032), progress * 0.98);",
    "  vec3 lowSky = mix(vec3(1.0, 0.995, 0.97), vec3(0.004, 0.010, 0.020), progress);",
    "  vec3 sky = mix(lowSky, highSky, smoothstep(-0.08, 0.92, uv.y));",
    "  sky += vec3(0.20, 0.35, 0.68) * rayleighPhase * transmittance.b * progress * 0.13;",
    "  sky += vec3(0.80, 0.38, 0.12) * miePhase * lowSun * 0.034;",
    "  float limbCenter = mix(-0.78, -0.20, descent) - p.x * p.x * 0.006 + p.x * 0.092;",
    "  float layer = p.y - limbCenter;",
    "  float visibleLimb = smoothstep(0.02, 0.78, progress);",
    "  float earthShadow = 1.0 - smoothstep(-0.16, -0.055, layer);",
    "  float deepSpace = smoothstep(0.46, 0.82, layer);",
    "  float emberLayer = exp(-abs(layer + 0.072) * 24.0) * visibleLimb;",
    "  float orangeLayer = exp(-abs(layer + 0.034) * 28.0) * visibleLimb;",
    "  float rimLayer = exp(-abs(layer - 0.002) * 48.0) * visibleLimb;",
    "  float whiteLayer = exp(-abs(layer - 0.042) * 11.5) * visibleLimb;",
    "  float paleBlueLayer = exp(-abs(layer - 0.150) * 6.2) * visibleLimb;",
    "  float cyanLayer = exp(-abs(layer - 0.285) * 3.8) * visibleLimb;",
    "  float blueLayer = exp(-abs(layer - 0.440) * 3.0) * visibleLimb;",
    "  float warmAmount = mix(0.45, 1.0, lowSun);",
    "  vec3 atmosphere = vec3(0.006, 0.014, 0.032);",
    "  atmosphere = mix(atmosphere, vec3(0.36, 0.80, 1.0), paleBlueLayer * 0.78);",
    "  atmosphere = mix(atmosphere, vec3(0.02, 0.42, 0.82), cyanLayer * 0.72);",
    "  atmosphere = mix(atmosphere, vec3(0.006, 0.10, 0.32), blueLayer * 0.72);",
    "  atmosphere = mix(atmosphere, vec3(0.96, 0.98, 0.92), whiteLayer * mix(0.68, 0.82, lowSun));",
    "  atmosphere = mix(atmosphere, vec3(1.0, 0.78, 0.30), rimLayer * 0.44 * warmAmount);",
    "  atmosphere = mix(atmosphere, vec3(1.0, 0.34, 0.02), orangeLayer * 0.64 * warmAmount);",
    "  atmosphere = mix(atmosphere, vec3(0.48, 0.07, 0.02), emberLayer * 0.28 * warmAmount);",
    "  atmosphere = mix(atmosphere, vec3(0.0), earthShadow * 0.92);",
    "  atmosphere = mix(atmosphere, vec3(0.0), deepSpace * 0.86);",
    "  sky = mix(sky, atmosphere, visibleLimb * progress);",
    "  float sunDist = length(p - sunP);",
    "  float sunCore = smoothstep(mix(0.070, 0.038, progress), 0.0, sunDist);",
    "  float sunGlow = pow(saturate(1.0 - sunDist / mix(0.95, 0.62, progress)), mix(2.2, 3.0, lowSun));",
    "  vec3 sunColor = mix(vec3(1.0), vec3(1.0, 0.58, 0.22), lowSun);",
    "  sky += sunColor * (sunCore * 0.36 + sunGlow * mix(0.06, 0.15, lowSun));",
    "  float paper = 0.58 - progress * 0.52;",
    "  sky = mix(sky, vec3(1.0), paper);",
    "  float grain = hash(gl_FragCoord.xy + uTime * 0.08) - 0.5;",
    "  sky += grain * 0.006;",
    "  sky = max(sky, vec3(0.030, 0.045, 0.075));",
    "  gl_FragColor = vec4(clamp(sky, 0.0, 1.0), 1.0);",
    "}",
  ].join("\n");

  function compileShader(type, source) {
    var shader = gl.createShader(type);
    gl.shaderSource(shader, source);
    gl.compileShader(shader);
    if (!gl.getShaderParameter(shader, gl.COMPILE_STATUS)) {
      console.warn("sky-scroll: shader compile failed:", gl.getShaderInfoLog(shader));
      gl.deleteShader(shader);
      return null;
    }
    return shader;
  }

  var vertexShader = compileShader(gl.VERTEX_SHADER, vertexSource);
  var fragmentShader = compileShader(gl.FRAGMENT_SHADER, fragmentSource);

  if (!vertexShader || !fragmentShader) {
    return;
  }

  var program = gl.createProgram();
  gl.attachShader(program, vertexShader);
  gl.attachShader(program, fragmentShader);
  gl.linkProgram(program);

  if (!gl.getProgramParameter(program, gl.LINK_STATUS)) {
    console.warn("sky-scroll: program link failed:", gl.getProgramInfoLog(program));
    return;
  }

  var positionBuffer = gl.createBuffer();
  var positionLocation = gl.getAttribLocation(program, "aPosition");
  var resolutionLocation = gl.getUniformLocation(program, "uResolution");
  var progressLocation = gl.getUniformLocation(program, "uProgress");
  var sunProgressLocation = gl.getUniformLocation(program, "uSunProgress");
  var timeLocation = gl.getUniformLocation(program, "uTime");
  var positions = new Float32Array([-1, -1, 1, -1, -1, 1, -1, 1, 1, -1, 1, 1]);
  var currentProgress = 0;
  var targetProgress = 0;
  var currentSunProgress = 0;
  var targetSunProgress = 0;
  var startTime = performance.now();
  var rafId = 0;
  var lastContrast = false;
  var transitionStart = 0;
  var transitionSpan = 1;
  var sunSpan = 1;

  gl.bindBuffer(gl.ARRAY_BUFFER, positionBuffer);
  gl.bufferData(gl.ARRAY_BUFFER, positions, gl.STATIC_DRAW);
  gl.useProgram(program);
  gl.enableVertexAttribArray(positionLocation);
  gl.vertexAttribPointer(positionLocation, 2, gl.FLOAT, false, 0, 0);

  function clamp(value, min, max) {
    return Math.min(Math.max(value, min), max);
  }

  function approach(current, target, smoothing) {
    var next = current + (target - current) * smoothing;
    return Math.abs(target - next) < 0.001 ? target : next;
  }

  function recomputeBounds() {
    var triggerCard = blogCards[Math.min(TRIGGER_CARD_INDEX, blogCards.length - 1)] || blogSection;
    var triggerTop = triggerCard.getBoundingClientRect().top + window.scrollY;
    var pageEnd = Math.max(1, document.documentElement.scrollHeight - window.innerHeight);
    transitionStart = Math.min(pageEnd - 1, Math.max(0, triggerTop - window.innerHeight * 1.15));
    var transitionEnd = Math.min(pageEnd, transitionStart + window.innerHeight * 1.35);
    transitionSpan = Math.max(1, transitionEnd - transitionStart);
    sunSpan = Math.max(1, pageEnd - transitionStart);
  }

  function updateTargets() {
    var scrollY = window.scrollY;
    var rawProgress = clamp((scrollY - transitionStart) / transitionSpan, 0, 1);
    targetProgress = 1 - Math.pow(1 - rawProgress, 3.25);
    targetSunProgress = clamp((scrollY - transitionStart) / sunSpan, 0, 1);
  }

  function scheduleRender() {
    if (rafId === 0) {
      rafId = window.requestAnimationFrame(render);
    }
  }

  function resize() {
    var dpr = Math.min(window.devicePixelRatio || 1, 2);
    var width = Math.max(1, Math.floor(window.innerWidth * dpr));
    var height = Math.max(1, Math.floor(window.innerHeight * dpr));

    if (canvas.width !== width || canvas.height !== height) {
      canvas.width = width;
      canvas.height = height;
      gl.viewport(0, 0, width, height);
    }

    recomputeBounds();
    updateTargets();
    scheduleRender();
  }

  function onScroll() {
    updateTargets();
    scheduleRender();
  }

  function onMotionChange() {
    reduceMotion = motionQuery.matches;
    scheduleRender();
  }

  function render(now) {
    rafId = 0;
    currentProgress = approach(currentProgress, targetProgress, 0.12);
    currentSunProgress = approach(currentSunProgress, targetSunProgress, 0.10);

    gl.uniform2f(resolutionLocation, canvas.width, canvas.height);
    gl.uniform1f(progressLocation, currentProgress);
    gl.uniform1f(sunProgressLocation, currentSunProgress);
    gl.uniform1f(timeLocation, reduceMotion ? 0 : (now - startTime) * 0.001);
    gl.drawArrays(gl.TRIANGLES, 0, 6);

    var contrast = currentProgress > 0.46;
    if (contrast !== lastContrast) {
      document.body.classList.toggle("sky-scroll-contrast", contrast);
      lastContrast = contrast;
    }

    if (currentProgress !== targetProgress || currentSunProgress !== targetSunProgress) {
      scheduleRender();
    }
  }

  window.addEventListener("resize", resize, { passive: true });
  window.addEventListener("scroll", onScroll, { passive: true });
  if (motionQuery.addEventListener) {
    motionQuery.addEventListener("change", onMotionChange);
  } else if (motionQuery.addListener) {
    motionQuery.addListener(onMotionChange);
  }

  resize();
})();
