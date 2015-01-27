package clipper;
using StringTools;
import system.*;
import anonymoustypes.*;

class EdgeSide
{
    public static inline var esLeft:Int = 1;
    public static inline var esRight:Int = 2;

    public static function ToString(e:Int):String
    {
        switch (e)
        {
            case 1: return "esLeft";
            case 2: return "esRight";
            default: throw new InvalidOperationException(Std.string(e));
        }
    }

    public static function Parse(s:String):Int
    {
        switch (s)
        {
            case "esLeft": return 1;
            case "esRight": return 2;
            default: throw new InvalidOperationException(s);
        }
    }

    public static function Values():Array<Int>
    {
        return [1, 2];
    }
}
