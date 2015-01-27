package clipperlib;
using StringTools;
import system.*;
import anonymoustypes.*;

class TEdge
{
    public var Bot:clipperlib.IntPoint;
    public var Curr:clipperlib.IntPoint;
    public var Top:clipperlib.IntPoint;
    public var Delta:clipperlib.IntPoint;
    public var Dx:Float;
    public var PolyTyp:Int;
    public var Side:Int;
    public var WindDelta:Int;
    public var WindCnt:Int;
    public var WindCnt2:Int;
    public var OutIdx:Int;
    public var Next:clipperlib.TEdge;
    public var Prev:clipperlib.TEdge;
    public var NextInLML:clipperlib.TEdge;
    public var NextInAEL:clipperlib.TEdge;
    public var PrevInAEL:clipperlib.TEdge;
    public var NextInSEL:clipperlib.TEdge;
    public var PrevInSEL:clipperlib.TEdge;
    public function new()
    {
        Bot = new clipperlib.IntPoint();
        Curr = new clipperlib.IntPoint();
        Top = new clipperlib.IntPoint();
        Delta = new clipperlib.IntPoint();
    }
}
