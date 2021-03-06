package clipper;
using StringTools;
import system.*;
import anonymoustypes.*;

class ClipperOffset
{
    private var m_destPolys:Array<Array<clipper.IntPoint>>;
    private var m_srcPoly:Array<clipper.IntPoint>;
    private var m_destPoly:Array<clipper.IntPoint>;
    private var m_normals:Array<clipper.DoublePoint>;
    private var m_delta:Float;
    private var m_sinA:Float;
    private var m_sin:Float;
    private var m_cos:Float;
    private var m_miterLim:Float;
    private var m_StepsPerRad:Float;
    private var m_lowest:clipper.IntPoint;
    private var m_polyNodes:clipper.PolyNode;
    public var ArcTolerance:Float;
    public var MiterLimit:Float;
    private static inline var two_pi:Float = system.MathCS.PI * 2;
    private static inline var def_arc_tolerance:Float = 0.25;
    public function new(miterLimit:Float = 2.0, arcTolerance:Float = def_arc_tolerance)
    {
        m_normals = new Array<clipper.DoublePoint>();
        m_lowest = new clipper.IntPoint();
        m_polyNodes = new clipper.PolyNode();
        MiterLimit = miterLimit;
        ArcTolerance = arcTolerance;
        m_lowest.X = -1;
    }
    public function Clear():Void
    {
        system.Cs2Hx.Clear(m_polyNodes.Childs);
        m_lowest.X = -1;
    }
    public static function Round(value:Float):Float
    {
        return value < 0 ? (value - 0.5) : (value + 0.5);
    }
    public function AddPath(path:Array<clipper.IntPoint>, joinType:Int, endType:Int):Void
    {
        var highI:Int = path.length - 1;
        if (highI < 0)
        {
            return;
        }
        var newNode:clipper.PolyNode = new clipper.PolyNode();
        newNode.m_jointype = joinType;
        newNode.m_endtype = endType;
        if (endType == clipper.EndType.etClosedLine || endType == clipper.EndType.etClosedPolygon)
        {
            while (highI > 0 && path[0] == path[highI])
            {
                highI--;
            }
        }
        newNode.m_polygon.Capacity = highI + 1;
        newNode.m_polygon.push(path[0]);
        var j:Int = 0;
        var k:Int = 0;
        { //for
            var i:Int = 1;
            while (i <= highI)
            {
                if (newNode.m_polygon[j] != path[i])
                {
                    j++;
                    newNode.m_polygon.push(path[i]);
                    if (path[i].Y > newNode.m_polygon[k].Y || (path[i].Y == newNode.m_polygon[k].Y && path[i].X < newNode.m_polygon[k].X))
                    {
                        k = j;
                    }
                }
                i++;
            }
        } //end for
        if (endType == clipper.EndType.etClosedPolygon && j < 2)
        {
            return;
        }
        m_polyNodes.AddChild(newNode);
        if (endType != clipper.EndType.etClosedPolygon)
        {
            return;
        }
        if (m_lowest.X < 0)
        {
            m_lowest = new clipper.IntPoint(m_polyNodes.ChildCount - 1, k);
        }
        else
        {
            var ip:clipper.IntPoint = m_polyNodes.Childs[Std.int(m_lowest.X)].m_polygon[Std.int(m_lowest.Y)];
            if (newNode.m_polygon[k].Y > ip.Y || (newNode.m_polygon[k].Y == ip.Y && newNode.m_polygon[k].X < ip.X))
            {
                m_lowest = new clipper.IntPoint(m_polyNodes.ChildCount - 1, k);
            }
        }
    }
    public function AddPaths(paths:Array<Array<clipper.IntPoint>>, joinType:Int, endType:Int):Void
    {
        for (p in paths)
        {
            AddPath(p, joinType, endType);
        }
    }
    private function FixOrientations():Void
    {
        if (m_lowest.X >= 0 && !clipper.Clipper.Orientation(m_polyNodes.Childs[Std.int(m_lowest.X)].m_polygon))
        {
            { //for
                var i:Int = 0;
                while (i < m_polyNodes.ChildCount)
                {
                    var node:clipper.PolyNode = m_polyNodes.Childs[i];
                    if (node.m_endtype == clipper.EndType.etClosedPolygon || (node.m_endtype == clipper.EndType.etClosedLine && clipper.Clipper.Orientation(node.m_polygon)))
                    {
                        node.m_polygon.reverse();
                    }
                    i++;
                }
            } //end for
        }
        else
        {
            { //for
                var i:Int = 0;
                while (i < m_polyNodes.ChildCount)
                {
                    var node:clipper.PolyNode = m_polyNodes.Childs[i];
                    if (node.m_endtype == clipper.EndType.etClosedLine && !clipper.Clipper.Orientation(node.m_polygon))
                    {
                        node.m_polygon.reverse();
                    }
                    i++;
                }
            } //end for
        }
    }
    public static function GetUnitNormal(pt1:clipper.IntPoint, pt2:clipper.IntPoint):clipper.DoublePoint
    {
        var dx:Float = (pt2.X - pt1.X);
        var dy:Float = (pt2.Y - pt1.Y);
        if ((dx == 0) && (dy == 0))
        {
            return new clipper.DoublePoint();
        }
        var f:Float = 1 * 1.0 / system.MathCS.Sqrt(dx * dx + dy * dy);
        dx *= f;
        dy *= f;
        return new clipper.DoublePoint(dy, -dx);
    }
    private function DoOffset(delta:Float):Void
    {
        m_destPolys = new Array<Array<clipper.IntPoint>>();
        m_delta = delta;
        if (clipper.ClipperBase.near_zero(delta))
        {
            m_destPolys.Capacity = m_polyNodes.ChildCount;
            { //for
                var i:Int = 0;
                while (i < m_polyNodes.ChildCount)
                {
                    var node:clipper.PolyNode = m_polyNodes.Childs[i];
                    if (node.m_endtype == clipper.EndType.etClosedPolygon)
                    {
                        m_destPolys.push(node.m_polygon);
                    }
                    i++;
                }
            } //end for
            return;
        }
        if (MiterLimit > 2)
        {
            m_miterLim = 2 / (MiterLimit * MiterLimit);
        }
        else
        {
            m_miterLim = 0.5;
        }
        var y:Float;
        if (ArcTolerance <= 0.0)
        {
            y = def_arc_tolerance;
        }
        else if (ArcTolerance > system.MathCS.Abs_Double(delta) * def_arc_tolerance)
        {
            y = system.MathCS.Abs_Double(delta) * def_arc_tolerance;
        }
        else
        {
            y = ArcTolerance;
        }
        var steps:Float = system.MathCS.PI / system.MathCS.Acos(1 - y / system.MathCS.Abs_Double(delta));
        m_sin = system.MathCS.Sin(two_pi / steps);
        m_cos = system.MathCS.Cos(two_pi / steps);
        m_StepsPerRad = steps / two_pi;
        if (delta < 0.0)
        {
            m_sin = -m_sin;
        }
        m_destPolys.Capacity = m_polyNodes.ChildCount * 2;
