package clipper;
using StringTools;
import system.*;
import anonymoustypes.*;

class JoinType
{
    public static inline var jtSquare:Int = 1;
    public static inline var jtRound:Int = 2;
    public static inline var jtMiter:Int = 3;

    public static function ToString(e:Int):String
    {
        switch (e)
        {
            case 1: return "jtSquare";
            case 2: return "jtRound";
            case 3: return "jtMiter";
            default: throw new InvalidOperationException(Std.string(e));
        }
    }

    public static function Parse(s:String):Int
    {
        switch (s)
        {
            case "jtSquare": return 1;
            case "jtRound": return 2;
            case "jtMiter": return 3;
            default: throw new InvalidOperationException(s);
        }
    }

    public static function Values():Array<Int>
    {
        return [1, 2, 3];
    }
}
