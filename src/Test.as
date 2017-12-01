package {
import flash.display.MovieClip;
import flash.display.Sprite;

public class Test extends Sprite {
    public function Test() {
        super();
        trace(typeof (MovieClip) is Sprite);
    }
}
}
