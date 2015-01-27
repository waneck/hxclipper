package clipper;
using StringTools;
import system.*;
import anonymoustypes.*;

class ClipperBase
{
    public static inline var horizontal:Float = -3.4E+38;
    public static inline var Skip:Int = -2;
    public static inline var Unassigned:Int = -1;
    public static inline var tolerance:Float = 1.0E-20;
    public static function near_zero(val:Float):Bool
    {
        return (val > -tolerance) && (val < tolerance);
    }
    public static inline var loRange:Float = 0x3FFFFFFF;
    public static inline var hiRange:Float = 0x3FFFFFFFFFFFFFFFL;
    public var m_MinimaList:clipper.LocalMinima;
    public var m_CurrentLM:clipper.LocalMinima;
    public var m_edges:Array<Array<clipper.TEdge>>;
    public var m_UseFullRange:Bool;
    public var m_HasOpenPaths:Bool;
    public var PreserveCollinear:Bool;
    public function Swap(val1:CsRef<Float>, val2:CsRef<Float>):Void
    {
        var tmp:Float = val1.Value;
        val1.Value = val2.Value;
        val2.Value = tmp;
    }
    public static function IsHorizontal(e:clipper.TEdge):Bool
    {
        return e.Delta.Y == 0;
    }
    public function PointIsVertex(pt:clipper.IntPoint, pp:clipper.OutPt):Bool
    {
        var pp2:clipper.OutPt = pp;
        do
        {
            if (pp2.Pt == pt)
            {
                return true;
            }
            pp2 = pp2.Next;
        }
        while (pp2 != pp);
        return false;
    }
    public function PointOnLineSegment(pt:clipper.IntPoint, linePt1:clipper.IntPoint, linePt2:clipper.IntPoint, UseFullRange:Bool):Bool
    {
        if (UseFullRange)
        {
            return ((pt.X == linePt1.X) && (pt.Y == linePt1.Y)) || ((pt.X == linePt2.X) && (pt.Y == linePt2.Y)) || (((pt.X > linePt1.X) == (pt.X < linePt2.X)) && ((pt.Y > linePt1.Y) == (pt.Y < linePt2.Y)) && ((clipper.Int128.Int128Mul((pt.X - linePt1.X), (linePt2.Y - linePt1.Y)) == clipper.Int128.Int128Mul((linePt2.X - linePt1.X), (pt.Y - linePt1.Y)))));
        }
        else
        {
            return ((pt.X == linePt1.X) && (pt.Y == linePt1.Y)) || ((pt.X == linePt2.X) && (pt.Y == linePt2.Y)) || (((pt.X > linePt1.X) == (pt.X < linePt2.X)) && ((pt.Y > linePt1.Y) == (pt.Y < linePt2.Y)) && ((pt.X - linePt1.X) * (linePt2.Y - linePt1.Y) == (linePt2.X - linePt1.X) * (pt.Y - linePt1.Y)));
        }
    }
    public function PointOnPolygon(pt:clipper.IntPoint, pp:clipper.OutPt, UseFullRange:Bool):Bool
    {
        var pp2:clipper.OutPt = pp;
        while (true)
        {
            if (PointOnLineSegment(pt, pp2.Pt, pp2.Next.Pt, UseFullRange))
            {
                return true;
            }
            pp2 = pp2.Next;
            if (pp2 == pp)
            {
                break;
            }
        }
        return false;
    }
    public static function SlopesEqual(e1:clipper.TEdge, e2:clipper.TEdge, UseFullRange:Bool):Bool
    {
        if (UseFullRange)
        {
            return clipper.Int128.Int128Mul(e1.Delta.Y, e2.Delta.X) == clipper.Int128.Int128Mul(e1.Delta.X, e2.Delta.Y);
        }
        else
        {
            return (e1.Delta.Y) * (e2.Delta.X) == (e1.Delta.X) * (e2.Delta.Y);
        }
    }
    public static function SlopesEqual_IntPoint_IntPoint_IntPoint_Boolean(pt1:clipper.IntPoint, pt2:clipper.IntPoint, pt3:clipper.IntPoint, UseFullRange:Bool):Bool
    {
        if (UseFullRange)
        {
            return clipper.Int128.Int128Mul(pt1.Y - pt2.Y, pt2.X - pt3.X) == clipper.Int128.Int128Mul(pt1.X - pt2.X, pt2.Y - pt3.Y);
        }
        else
        {
            return (pt1.Y - pt2.Y) * (pt2.X - pt3.X) - (pt1.X - pt2.X) * (pt2.Y - pt3.Y) == 0;
        }
    }
    public static function SlopesEqual_IntPoint_IntPoint_IntPoint_IntPoint_Boolean(pt1:clipper.IntPoint, pt2:clipper.IntPoint, pt3:clipper.IntPoint, pt4:clipper.IntPoint, UseFullRange:Bool):Bool
    {
        if (UseFullRange)
        {
            return clipper.Int128.Int128Mul(pt1.Y - pt2.Y, pt3.X - pt4.X) == clipper.Int128.Int128Mul(pt1.X - pt2.X, pt3.Y - pt4.Y);
        }
        else
        {
            return (pt1.Y - pt2.Y) * (pt3.X - pt4.X) - (pt1.X - pt2.X) * (pt3.Y - pt4.Y) == 0;
        }
    }
    public function new()
    {
        m_edges = new Array<Array<clipper.TEdge>>();
        m_MinimaList = null;
        m_CurrentLM = null;
        m_UseFullRange = false;
        m_HasOpenPaths = false;
    }
    public function Clear():Void
    {
        DisposeLocalMinimaList();
        { //for
            var i:Int = 0;
            while (i < m_edges.length)
            {
                { //for
                    var j:Int = 0;
                    while (j < m_edges[i].length)
                    {
                        m_edges[i][j] = null;
                        ++j;
                    }
                } //end for
                system.Cs2Hx.Clear(m_edges[i]);
                ++i;
            }
        } //end for
        system.Cs2Hx.Clear(m_edges);
        m_UseFullRange = false;
        m_HasOpenPaths = false;
    }
    private function DisposeLocalMinimaList():Void
    {
        while (m_MinimaList != null)
        {
            var tmpLm:clipper.LocalMinima = m_MinimaList.Next;
            m_MinimaList = null;
            m_MinimaList = tmpLm;
        }
        m_CurrentLM = null;
    }
    function RangeTest(Pt:clipper.IntPoint, useFullRange:CsRef<Bool>):Void
    {
        if (useFullRange.Value)
        {
            if (Pt.X > hiRange || Pt.Y > hiRange || -Pt.X > hiRange || -Pt.Y > hiRange)
            {
                throw new clipper.ClipperException("Coordinate outside allowed range");
            }
        }
        else if (Pt.X > loRange || Pt.Y > loRange || -Pt.X > loRange || -Pt.Y > loRange)
        {
            useFullRange.Value = true;
            RangeTest(Pt, useFullRange);
        }
    }
    private function InitEdge(e:clipper.TEdge, eNext:clipper.TEdge, ePrev:clipper.TEdge, pt:clipper.IntPoint):Void
    {
        e.Next = eNext;
        e.Prev = ePrev;
        e.Curr = pt;
        e.OutIdx = Unassigned;
    }
    private function InitEdge2(e:clipper.TEdge, polyType:Int):Void
    {
        if (e.Curr.Y >= e.Next.Curr.Y)
        {
            e.Bot = e.Curr;
            e.Top = e.Next.Curr;
        }
        else
        {
            e.Top = e.Curr;
            e.Bot = e.Next.Curr;
        }
        SetDx(e);
        e.PolyTyp = polyType;
    }
    private function FindNextLocMin(E:clipper.TEdge):clipper.TEdge
    {
        var E2:clipper.TEdge;
				while(true)
				{
					while (E.Bot != E.Prev.Bot || E.Curr == E.Top) E = E.Next;
					if (E.Dx != horizontal && E.Prev.Dx != horizontal) break;
					while (E.Prev.Dx == horizontal) E = E.Prev;
					E2 = E;
					while (E.Dx == horizontal) E = E.Next;
					if (E.Top.Y == E.Prev.Bot.Y) continue; //ie just an intermediate horz.
					if (E2.Prev.Bot.X < E.Bot.X) E = E2;
					break;
				}
		}
