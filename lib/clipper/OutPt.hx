package clipper;
using StringTools;
import system.*;
import anonymoustypes.*;

class OutPt
{
    public var Idx:Int;
    public var Pt:clipper.IntPoint;
    public var Next:clipper.OutPt;
    public var Prev:clipper.OutPt;
    public function new()
    {
        Pt = new clipper.IntPoint();
    }
}
