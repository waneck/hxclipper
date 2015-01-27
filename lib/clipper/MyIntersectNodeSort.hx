package clipper;
using StringTools;
import system.*;
import anonymoustypes.*;

class MyIntersectNodeSort implements system.collections.generic.IComparer<clipper.IntersectNode>
{
    public function Compare(node1:clipper.IntersectNode, node2:clipper.IntersectNode):Int
    {
        var i:Float = node2.Pt.Y - node1.Pt.Y;
        if (i > 0)
        {
            return 1;
        }
        else if (i < 0)
        {
            return -1;
        }
        else
        {
            return 0;
        }
    }
    public function new()
    {
    }
}
