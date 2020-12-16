import mt.deepnight.SpriteLib;

class Entity implements haxe.Public {
	var world	: World;
	var cx		: Int;
	var cy		: Int;
	var xr		: Float;
	var yr		: Float;
	
	var dx		: Float;
	var dy		: Float;
	
	var dirY	: Int;
	var spr		: DSprite;
	
	function new(w, s) {
		world = w;
		spr = s;
		cx = cy = 2;
		xr = yr = 0.5;
		dx = dy = 0;
		dirY = 1;
	}
	
	function moveTo(x,y) {
		cx = x;
		cy = y;
		xr = 0.5;
		yr = 0.5;
	}
	
	function lookAt(x,y) {
		if( y>=cy )
			dirY = 1;
		else
			dirY = -1;
	}
	
	function update() {
		// Y
		if( yr+dy>1 && world.collide(cx,cy+1) ) {
			yr = 1;
			dy = 0;
		}
		if( yr+dy<0.4 && world.collide(cx,cy-1) ) {
			yr = 0.4;
			dy = 0;
		}
		
		yr+=dy;
		while (yr<0) {
			yr++;
			cy--;
		}
		while (yr>1) {
			yr--;
			cy++;
		}
		
		
		// X
		if( xr+dx>0.7 && world.collide(cx+1,cy) ) {
			xr = 0.7;
			dx = 0;
		}
		if( xr+dx<0.5 && world.collide(cx-1,cy) ) {
			xr = 0.5;
			dx = 0;
		}
		
		xr+=dx;
		while (xr<0) {
			xr++;
			cx--;
		}
		while (xr>1) {
			xr--;
			cx++;
		}
		
		if( dy<0 ) dirY = -1;
		if( dy>0 ) dirY = 1;
		
		dx = 0;
		dy = 0;
		
		spr.x = Std.int( cx*Manager.CWID + xr*Manager.CWID );
		spr.y = Std.int( cy*Manager.CHEI + yr*Manager.CHEI );
	}
}

