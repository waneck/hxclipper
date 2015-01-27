package clipperlib;
using StringTools;
import system.*;
import anonymoustypes.*;

class Direction
{
    public static inline var dRightToLeft:Int = 1;
    public static inline var dLeftToRight:Int = 2;

    public static function ToString(e:Int):String
    {
        switch (e)
        {
            case 1: return "dRightToLeft";
            case 2: return "dLeftToRight";
            default: throw new InvalidOperationException(Std.string(e));
        }
    }

    public static function Parse(s:String):Int
    {
        switch (s)
        {
            case "dRightToLeft": return 1;
            case "dLeftToRight": return 2;
            default: throw new InvalidOperationException(s);
        }
    }

    public static function Values():Array<Int>
    {
        return [1, 2];
    }
}
