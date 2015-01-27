package clipperlib;
using StringTools;
import system.*;
import anonymoustypes.*;

class IntersectNode
{
    public var Edge1:clipperlib.TEdge;
    public var Edge2:clipperlib.TEdge;
    public var Pt:clipperlib.IntPoint;
    public function new()
    {
        Pt = new clipperlib.IntPoint();
    }
}
