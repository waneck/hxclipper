package clipper;
using StringTools;
import system.*;
import anonymoustypes.*;

@:struct class DoublePoint
{
    public var X:Float;
    public var Y:Float;
    public function new(x:Float = 0, y:Float = 0)
    {
        this.X = x;
        this.Y = y;
    }

		inline public static function fromPoint(pt:DoublePoint)
		{
			return new DoublePoint(pt.X, pt.Y);
		}

		inline public static function fromIntPoint(ip:IntPoint)
		{
			return new DoublePoint(ip.X, ip.Y);
		}
}
