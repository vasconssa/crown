include = ["core/shaders/common.shader"]

render_states = {
	electricity = {
		rgb_write_enable = true
		alpha_write_enable = true
		depth_func = "always"
		depth_enable = true
		depth_write_enable = true
		blend_enable = true
		blend_src = "src_alpha"
		blend_dst = "inv_src_alpha"
		cull_mode = "cw"
	}
}

bgfx_shaders = {
	electricity = {
		includes = "common"

		samplers = {
			u_albedo = { sampler_state = "clamp_point" }
			u_fl = { sampler_state = "clamp_point" }
		}

		varying = """
			vec2 v_texcoord0 : TEXCOORD0 = vec2(0.0, 0.0);

			vec3 a_position  : POSITION;
			vec2 a_texcoord0 : TEXCOORD0;
			vec3 v_pos : POSITION;
		"""

		vs_input_output = """
			$input a_position, a_texcoord0
			$output v_texcoord0, v_pos
		"""

		vs_code = """
			void main()
			{
				gl_Position = mul(u_modelViewProj, vec4(a_position, 1.0));
				v_texcoord0 = a_texcoord0;
				v_pos = gl_Position.xyz;
			}
		"""

		fs_input_output = """
			$input v_texcoord0, v_pos
		"""

		fs_code = """
			uniform vec4 u_color;
			uniform vec4 u_time;
			SAMPLER2D(u_albedo, 0);
			SAMPLER2D(u_fl, 1);
			// 2D Noise based on Morgan McGuire @morgan3d
			// https://www.shadertoy.com/view/4dS3Wd
			float noise (in vec2 st) {
				vec2 i = floor(st);
				vec2 f = fract(st);

				// Four corners in 2D of a tile
				float a = random(i);
				float b = random(i + vec2(1.0, 0.0));
				float c = random(i + vec2(0.0, 1.0));
				float d = random(i + vec2(1.0, 1.0));

				// Smooth Interpolation

				// Cubic Hermine Curve.  Same as SmoothStep()
				vec2 u = f*f*(3.0-2.0*f);
				// u = smoothstep(0.,1.,f);

				// Mix 4 coorners percentages
				return mix(a, b, u.x) +
						(c - a)* u.y * (1.0 - u.x) +
						(d - b) * u.x * u.y;
			}

			float map(float value, float inMin, float inMax, float outMin, float outMax) {
				  return outMin + (outMax - outMin) * (value - inMin) / (inMax - inMin);
			}
			vec4 texBilinear(sampler2D texture, vec2 uv, float side_step) {
				vec2 weight = fract(uv);

				vec4 bottom = mix(texture2D(texture, uv),
									 texture2D(texture, uv + side_step*vec2(1, 0)),
									 weight.x);

				vec4 top = mix(texture2D(texture, uv + side_step*vec2(0, 1)),
								  texture2D(texture, uv + side_step*vec2(1, 1)),
								  weight.x);

				return mix(bottom, top, weight.y);
			}

			void main()
			{
				vec4 color = texture2D(u_albedo, v_texcoord0);
				vec4 color2 = texture2D(u_fl, v_texcoord0);
				color2.g = 0.0;
				color2.r = 0.0;
				float side_step = 0.001;
				float n = noise(200.0*v_texcoord0);
				//vec2 pos = v_texcoord0 - u_time.x*color2.rg;
				//color2 = texture2D(u_fl, pos);
				//color = texBilinear(u_albedo, pos, 1.0);
				//color *= color2.r;
				//color.b += n;
				//color.gb = vel;
				vec3 pct = vec3(v_texcoord0.x);
				pct.r = 0.0;
				pct.b = sin(v_texcoord0.x*3.14 - u_time.x+cos(n) );
				pct.g = 0.2*sin(v_texcoord0.x*3.14 - u_time.x+cos(n) );
				color.b = 0.4;
				color = mix(vec4(0.0, 0.2*n, n, 0.0)+color, color, vec4(pct, 0.0));
				//color.g = 0.0 + n*(u_time.x)*vel.x;
				//color.b = 0.2 + n*(u_time.x)*vel.y;
				if (color.a <= 0.0)
					discard;
				//color.a = 0.5;

				gl_FragColor = color * u_color;
			}
		"""
	}
}

shaders = {
	electricity = {
		bgfx_shader = "electricity"
		render_state = "electricity"
	}
}

static_compile = [
	{ shader = "electricity" defines = [] }
]
