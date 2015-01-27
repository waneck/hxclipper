package clipper;
using StringTools;
import system.*;
import anonymoustypes.*;

class Join
{
    public var OutPt1:clipper.OutPt;
    public var OutPt2:clipper.OutPt;
    public var OffPt:clipper.IntPoint;
    public function new()
    {
        OffPt = new clipper.IntPoint();
    }
}
