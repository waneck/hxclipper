package clipperlib;
using StringTools;
import system.*;
import anonymoustypes.*;

class PolyFillType
{
    public static inline var pftEvenOdd:Int = 1;
    public static inline var pftNonZero:Int = 2;
    public static inline var pftPositive:Int = 3;
    public static inline var pftNegative:Int = 4;

    public static function ToString(e:Int):String
    {
        switch (e)
        {
            case 1: return "pftEvenOdd";
            case 2: return "pftNonZero";
            case 3: return "pftPositive";
            case 4: return "pftNegative";
            default: throw new InvalidOperationException(Std.string(e));
        }
    }

    public static function Parse(s:String):Int
    {
        switch (s)
        {
            case "pftEvenOdd": return 1;
            case "pftNonZero": return 2;
            case "pftPositive": return 3;
            case "pftNegative": return 4;
            default: throw new InvalidOperationException(s);
        }
    }

    public static function Values():Array<Int>
    {
        return [1, 2, 3, 4];
    }
}
