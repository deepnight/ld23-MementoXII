class Main extends dn.Process {
	public static var ME : Main;

	var overlay : dn.heaps.filter.OverlayTexture;

	/** Used to create "Access" instances that allow controller checks (keyboard or gamepad) **/
	public var controller : dn.legacy.Controller;

	/** Controller Access created for Main & Boot **/
	public var ca : dn.legacy.Controller.ControllerAccess;

	public function new(s:h2d.Scene) {
		super();
		ME = this;

        createRoot(s);

		// Engine settings
		engine.backgroundColor = 0xff<<24|Const.BG_COLOR;
        #if( hl && !debug )
        engine.fullScreen = true;
        #end

		// Heaps resources
		#if( hl && debug )
			hxd.Res.initLocal();
        #else
      		hxd.Res.initEmbed();
        #end

		// Assets & data init
		hxd.snd.Manager.get(); // force sound manager init on startup instead of first sound play
		Assets.init();

		// Game controller & default key bindings
		controller = new dn.legacy.Controller(s);
		ca = controller.createAccess("main");
		// controller.bind(AXIS_LEFT_X_NEG, Key.LEFT, Key.Q, Key.A);
		// controller.bind(AXIS_LEFT_X_POS, Key.RIGHT, Key.D);
		// controller.bind(X, Key.SPACE, Key.F, Key.E);
		// controller.bind(A, Key.UP, Key.Z, Key.W);
		// controller.bind(B, Key.ENTER, Key.NUMPAD_ENTER);
		// controller.bind(SELECT, Key.R);
		// controller.bind(START, Key.N);

		#if js
		// Optional helper that shows a "Click to start/continue" message when the game looses focus
		new dn.heaps.GameFocusHelper(Boot.ME.s2d, Assets.font);
		#end

		overlay = new dn.heaps.filter.OverlayTexture(Classic, Const.SCALE); // TODO scanlines 7%
		overlay.alpha = 0.3;
		Boot.ME.s2d.filter = overlay;

		// Start with 1 frame delay, to avoid 1st frame freezing from the game perspective
		hxd.Timer.wantedFPS = 30;
		hxd.Timer.skip();
		delayer.addF( startGame, 1 );

		dn.Process.resizeAll();
	}

	override function onResize() {
		super.onResize();
		Const.SCALE = dn.heaps.Scaler.bestFit_i(Const.WID, Const.HEI);
		overlay.size = Const.SCALE;
	}

	/** Start game process **/
	public function startGame() {
		if( Game.ME!=null ) {
			Game.ME.destroy();
			delayer.addF(function() {
				new Game();
			}, 1);
		}
		else
			new Game();
	}


    override function update() {
		Assets.tiles.tmod = tmod;
		super.update();
    }
}