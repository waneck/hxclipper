package clipperlib;
using StringTools;
import system.*;
import anonymoustypes.*;

class ClipType
{
    public static inline var ctIntersection:Int = 1;
    public static inline var ctUnion:Int = 2;
    public static inline var ctDifference:Int = 3;
    public static inline var ctXor:Int = 4;

    public static function ToString(e:Int):String
    {
        switch (e)
        {
            case 1: return "ctIntersection";
            case 2: return "ctUnion";
            case 3: return "ctDifference";
            case 4: return "ctXor";
            default: throw new InvalidOperationException(Std.string(e));
        }
    }

    public static function Parse(s:String):Int
    {
        switch (s)
        {
            case "ctIntersection": return 1;
            case "ctUnion": return 2;
            case "ctDifference": return 3;
            case "ctXor": return 4;
            default: throw new InvalidOperationException(s);
        }
    }

    public static function Values():Array<Int>
    {
        return [1, 2, 3, 4];
    }
}
