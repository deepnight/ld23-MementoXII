class Assets {
	public static var tiles : SpriteLib;
	public static var font : h2d.Font;
	public static var SOUNDS = dn.heaps.assets.SfxDirectory.load("sfx",true);

	public static function init() {
		var t = hxd.Res.tiles.toTile();
		tiles = new SpriteLib([t]);
		font = hxd.Res.fonts._04b03.toFont();

		tiles.setDefaultCenterRatio(0,0);

		tiles.slice("collision",0,  0, 16*2, 8,8);
		tiles.slice("separator",0,  0,16*3, 16*8,16, 2);
		tiles.slice("cell",0,  0,16*4, 16*7,16*5, 1, 4);

		tiles.slice("picPart1",0,  7*16,5*16, 16,16);
		tiles.slice("calendar",0,  7*16,6*16, 16,16);
		tiles.slice("picPart3",0,  7*16,7*16, 16,16);
		tiles.slice("framed",0,  7*16,8*16, 16,16);
		tiles.slice("ringBack",0,  8*16,6*16, 16,16);
		tiles.slice("reflections",0,  9*16,6*16, 16,16);
		tiles.sliceGrid("sinkWater",0,  8,5);
		tiles.sliceAnimGrid("flow",0,2,  8,5, 4); // flow

		tiles.slice("kitchenDoor",0,  7*16,10*16, 16,16);
		tiles.slice("kitchenKnife",0,  7*16,11*16, 16,16);
		tiles.slice("kitchenTable",0,  7*16,12*16, 16,16, 2);
		tiles.slice("kitchenChest",0,  7*16,13*16, 16,16, 2);
		tiles.slice("cupDoors",0,  8*16,10*16, 16,20);

		tiles.slice("phone",0,  7*16,15*16, 16,16);
		tiles.slice("finalLetter",0,  7*16,16*16, 16,16);

		tiles.setSliceGrid(16,16);
		tiles.slice("player",0,  0,0, 16,16, 16,2);
		tiles.sliceAnimGrid("wakeWait",0,1,  10,0);
		tiles.sliceAnimGrid("wakeUp",0,1,  10,0, 4);
		tiles.sliceAnimGrid("standDown",0,1, 0,0);
		tiles.sliceAnimGrid("standUp",0,1, 5,0);

		tiles.sliceGrid("walkDown",0, 0,0, 5);
		tiles.defineAnim("walkDown", "0,1,2,1,0, 3,4,3");

		tiles.sliceGrid("walkUp",0, 5,0, 5);
		tiles.defineAnim("walkUp", "0,1,2,1,0, 3,4,3");

		tiles.sliceAnimGrid("read",0,25,  14,0, 2);

		tiles.sliceGrid("cry",0,  0,1, 5);
		tiles.defineAnim("cry", "0(20), 1(70), 2(10), 3(100), 4(60)");
		tiles.sliceAnimGrid("afterCry",0,100,  0,1);

		tiles.slice("heroFade",0,  0,16*25, 12*16, 9*16);

	}
}