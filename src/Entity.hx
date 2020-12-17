import dn.heaps.slib.*;

class Entity {
	public var world	: World;
	public var cx		: Int;
	public var cy		: Int;
	public var xr		: Float;
	public var yr		: Float;

	public var dx		: Float;
	public var dy		: Float;

	public var dirY	: Int;
	public var spr		: HSprite;
	final frict = 0.7;

	public var x(get,never) : Int; inline function get_x() return Std.int( (cx+xr)*Const.GRID );
	public var y(get,never) : Int; inline function get_y() return Std.int( (cy+yr)*Const.GRID );

	public function new(w, s) {
		world = w;
		spr = s;
		cx = cy = 2;
		xr = yr = 0.5;
		dx = dy = 0;
		dirY = 1;
	}

	public inline function isMoving() {
		return M.fabs(dx)>0.01 || M.fabs(dy)>0.01;
	}

	public function moveTo(x,y) {
		cx = x;
		cy = y;
		xr = 0.5;
		yr = 0.5;
	}

	public function lookAt(x,y) {
		if( y>=cy )
			dirY = 1;
		else
			dirY = -1;
	}

	public function update(tmod:Float) {
		// Y
		if( yr+dy>1 && world.collide(cx,cy+1) ) {
			yr = 1;
			dy = 0;
		}
		if( yr+dy<0.4 && world.collide(cx,cy-1) ) {
			yr = 0.4;
			dy = 0;
		}

		yr+=dy*tmod;
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

		xr+=dx*tmod;
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

		dx*=Math.pow(frict, tmod);
		dy*=Math.pow(frict, tmod);
		if( M.fabs(dx)<=0.0001 ) dx = 0;
		if( M.fabs(dy)<=0.0001 ) dy = 0;
		// dx = 0;
		// dy = 0;

		spr.x = Std.int( cx*Const.GRID + xr*Const.GRID );
		spr.y = Std.int( cy*Const.GRID + yr*Const.GRID );
	}
}

