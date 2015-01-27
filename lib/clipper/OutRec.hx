package clipper;
using StringTools;
import system.*;
import anonymoustypes.*;

class OutRec
{
    public var Idx:Int;
    public var IsHole:Bool;
    public var IsOpen:Bool;
    public var FirstLeft:clipper.OutRec;
    public var Pts:clipper.OutPt;
    public var BottomPt:clipper.OutPt;
    public var PolyNode:clipper.PolyNode;
    public function new()
    {
    }
}
