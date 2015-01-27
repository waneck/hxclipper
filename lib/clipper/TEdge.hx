package clipper;
using StringTools;
import system.*;
import anonymoustypes.*;

class TEdge
{
    public var Bot:clipper.IntPoint;
    public var Curr:clipper.IntPoint;
    public var Top:clipper.IntPoint;
    public var Delta:clipper.IntPoint;
    public var Dx:Float;
    public var PolyTyp:Int;
    public var Side:Int;
    public var WindDelta:Int;
    public var WindCnt:Int;
    public var WindCnt2:Int;
    public var OutIdx:Int;
    public var Next:clipper.TEdge;
    public var Prev:clipper.TEdge;
    public var NextInLML:clipper.TEdge;
    public var NextInAEL:clipper.TEdge;
    public var PrevInAEL:clipper.TEdge;
    public var NextInSEL:clipper.TEdge;
    public var PrevInSEL:clipper.TEdge;
    public function new()
    {
        Bot = new clipper.IntPoint();
        Curr = new clipper.IntPoint();
        Top = new clipper.IntPoint();
        Delta = new clipper.IntPoint();
    }
}
