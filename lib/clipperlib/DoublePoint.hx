package clipperlib;
using StringTools;
import system.*;
import anonymoustypes.*;

class DoublePoint
{
    public var X:Float;
    public var Y:Float;
    public function new(x:Float = 0, y:Float = 0)
    {
        this.X = x;
        this.Y = y;
    }
    public function new(dp:clipperlib.DoublePoint)
    {
        this.X = dp.X;
        this.Y = dp.Y;
    }
    public function new(ip:clipperlib.IntPoint)
    {
        this.X = ip.X;
        this.Y = ip.Y;
    }
