class DistortFilter extends h2d.filter.Shader<InternalShader> {
	public var offsetX : Float;
	public var waveLenX : Float;
	public var speedX : Float;

	public var offsetY : Float;
	public var waveLenY : Float;
	public var speedY : Float;

	public var intensity = 1.0;


	public var offset(never,set) : Float;
		inline function set_offset(v:Float) return offsetX = offsetY = v;

	public var waveLen(never,set) : Float;
		inline function set_waveLen(v:Float) return waveLenX = waveLenY = v;

	public var speed(never,set) : Float;
		inline function set_speed(v) return speedX = speedY = v;


	public function new(offset=2.0, waveLength=32., speed=1.0, ?noise:h3d.mat.Texture) {
		super(new InternalShader(), "tex");

		this.offset = offset;
		this.waveLen = waveLength;
		this.speed = speed;

		if( noise!=null )
			shader.noiseTex = noise;
		else {
			var bd = new hxd.BitmapData(32,32);
			for(x in 0...bd.width)
			for(y in 0...bd.height)
				bd.setPixel(x,y, dn.legacy.Color.randomColor());
			shader.noiseTex = h3d.mat.Texture.fromBitmap(bd);
			bd.dispose();
		}
	}

	override function draw(ctx:h2d.RenderContext, t:h2d.Tile):h2d.Tile {
		shader.time = ctx.time;
		shader.intensity = M.fclamp(intensity,0,1);

		shader.offsetY = offsetY / t.height;
		shader.waveLenY = waveLenY / t.height;
		shader.speedY = speedY;

		shader.offsetX = offsetX / t.width;
		shader.waveLenX = waveLenX / t.width;
		shader.speedX = speedX;

		return super.draw(ctx, t);
	}
}


// --- Shader -------------------------------------------------------------------------------
private class InternalShader extends h3d.shader.ScreenShader {
	static var SRC = {
		@param var tex : Sampler2D;
		@param var noiseTex : Sampler2D;

		@param var time : Float;
		@param var intensity : Float;

		@param var speedX : Float;
		@param var waveLenX : Float;
		@param var offsetX : Float;

		@param var speedY : Float;
		@param var waveLenY : Float;
		@param var offsetY : Float;

		function fragment() {
			var uv = calculatedUV;
			var noise = noiseTex.get(uv);

			uv.x += cos( 6.28*uv.y/waveLenX + time*speedX + noise.r*2 ) * offsetX * intensity;
			uv.y += cos( 1 + 6.28*uv.x/waveLenY + time*speedY + noise.g*2 ) * offsetY * intensity;

			pixelColor = tex.get(uv);
		}
	};
}
