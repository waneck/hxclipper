package clipperlib;
using StringTools;
import system.*;
import anonymoustypes.*;

class EndType
{
    public static inline var etClosedPolygon:Int = 1;
    public static inline var etClosedLine:Int = 2;
    public static inline var etOpenButt:Int = 3;
    public static inline var etOpenSquare:Int = 4;
    public static inline var etOpenRound:Int = 5;

    public static function ToString(e:Int):String
    {
        switch (e)
        {
            case 1: return "etClosedPolygon";
            case 2: return "etClosedLine";
            case 3: return "etOpenButt";
            case 4: return "etOpenSquare";
            case 5: return "etOpenRound";
            default: throw new InvalidOperationException(Std.string(e));
        }
    }

    public static function Parse(s:String):Int
    {
        switch (s)
        {
            case "etClosedPolygon": return 1;
            case "etClosedLine": return 2;
            case "etOpenButt": return 3;
            case "etOpenSquare": return 4;
            case "etOpenRound": return 5;
            default: throw new InvalidOperationException(s);
        }
    }

    public static function Values():Array<Int>
    {
        return [1, 2, 3, 4, 5];
    }
}
