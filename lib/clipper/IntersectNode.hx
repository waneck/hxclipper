package clipper;
using StringTools;
import system.*;
import anonymoustypes.*;

class IntersectNode
{
    public var Edge1:clipper.TEdge;
    public var Edge2:clipper.TEdge;
    public var Pt:clipper.IntPoint;
    public function new()
    {
        Pt = new clipper.IntPoint();
    }
}
