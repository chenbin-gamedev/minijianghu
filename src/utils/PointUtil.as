package utils {
import flash.geom.Point;

public class PointUtil {
    public function PointUtil() {
    }

    public static function equit(p1:Point, p2:Point):Boolean {
        if (p1.x == p2.x && p1.y == p2.y) {
            return true;
        }
        return false;
    }
}
}
