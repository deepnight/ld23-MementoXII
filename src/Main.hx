import World;

class Main extends dn.Process {
	public static var ME : Main;

	/** Used to create "Access" instances that allow controller checks (keyboard or gamepad) **/
	public var controller : dn.heaps.Controller;

	/** Controller Access created for Main & Boot **/
	public var ca : dn.heaps.Controller.ControllerAccess;

	public function new(s:h2d.Scene) {
		super();
		ME = this;

        createRoot(s);

		// Engine settings
		engine.backgroundColor = 0xff<<24|0x111133;
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
		controller = new dn.heaps.Controller(s);
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
		// new dn.heaps.GameFocusHelper(Boot.ME.s2d, Assets.fontMedium);
		#end

		// Start with 1 frame delay, to avoid 1st frame freezing from the game perspective
		hxd.Timer.wantedFPS = 30;
		hxd.Timer.skip();
		delayer.addF( startGame, 1 );
		trace("hello");
	}

	/** Start game process **/
	public function startGame() {
		var e = Assets.tiles.h_getAndPlay("flow", root);
		e.scale(16);

		// if( Game.ME!=null ) {
		// 	Game.ME.destroy();
		// 	delayer.addF(function() {
		// 		new Game();
		// 	}, 1);
		// }
		// else
		// 	new Game();
	}


    override function update() {
		Assets.tiles.tmod = tmod;
		super.update();
    }
}