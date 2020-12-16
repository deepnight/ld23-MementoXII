class World {
	public var wid		: Int;
	public var hei		: Int;
	public var cmap		: Array<Array<Bool>>;

	public function new() {
		wid = 13;
		hei = 11;
		cmap = new Array();
		for(x in 0...wid) {
			cmap[x] = new Array();
			for(y in 0...hei)
				cmap[x][y] = true;
		}
	}

	public inline function addCollision(x,y, ?w=1, ?h=1) {
		for(x2 in x...x+w)
			for(y2 in y...y+h)
				cmap[x2][y2] = true;
	}

	public inline function removeRectangle(x,y,w,h) {
		for(x2 in x...x+w)
			for(y2 in y...y+h)
				cmap[x2][y2] = false;
	}

	public inline function collide(x,y) {
		return
			if( x<0 || x>=wid || y<0 || y>=hei ) true;
			else cmap[x][y];
	}
}

