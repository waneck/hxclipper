package clipperlib;
using StringTools;
import system.*;
import anonymoustypes.*;

class PolyType
{
    public static inline var ptSubject:Int = 1;
    public static inline var ptClip:Int = 2;

    public static function ToString(e:Int):String
    {
        switch (e)
        {
            case 1: return "ptSubject";
            case 2: return "ptClip";
            default: throw new InvalidOperationException(Std.string(e));
        }
    }

    public static function Parse(s:String):Int
    {
        switch (s)
        {
            case "ptSubject": return 1;
            case "ptClip": return 2;
            default: throw new InvalidOperationException(s);
        }
    }

    public static function Values():Array<Int>
    {
        return [1, 2];
    }
}
