package clipperlib;
using StringTools;
import system.*;
import anonymoustypes.*;

class OutRec
{
    public var Idx:Int;
    public var IsHole:Bool;
    public var IsOpen:Bool;
    public var FirstLeft:clipperlib.OutRec;
    public var Pts:clipperlib.OutPt;
    public var BottomPt:clipperlib.OutPt;
    public var PolyNode:clipperlib.PolyNode;
    public function new()
    {
    }
}
