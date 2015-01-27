package clipperlib;
using StringTools;
import system.*;
import anonymoustypes.*;

class OutPt
{
    public var Idx:Int;
    public var Pt:clipperlib.IntPoint;
    public var Next:clipperlib.OutPt;
    public var Prev:clipperlib.OutPt;
    public function new()
    {
        Pt = new clipperlib.IntPoint();
    }
}
