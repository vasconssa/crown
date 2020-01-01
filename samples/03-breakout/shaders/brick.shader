include = ["core/shaders/common.shader"]

render_states = {
	brick = {
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
	brick = {
		includes = "common"

		samplers = {
			u_albedo = { sampler_state = "clamp_point" }
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
			uniform vec4 u_block_size;
			SAMPLER2D(u_albedo, 0);
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

			void main()
			{
				float n = noise(200.0*v_pos.xy);
				vec4 color = texture2D(u_albedo, v_texcoord0);
				float x = (1.0 + v_pos.x)/u_block_size.x;
				float y = (1.0 - v_pos.y)/u_block_size.y;
				x = map(x, 0.0, 10.0, 0.0, 1.0);
				y = map(y, 0.0, 10.0, 0.0, 1.0);
				vec3 pct = vec3(x*y);
				color = mix(vec4(x, y, y, 1.0), color, vec4(pct, 1.0));
				if (color.a <= 0.0)
					discard;

				color.a = 0.7;
				gl_FragColor = color * u_color;
			}
		"""
	}
}

shaders = {
	brick = {
		bgfx_shader = "brick"
		render_state = "brick"
	}
}

static_compile = [
	{ shader = "brick" defines = [] }
]
