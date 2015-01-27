import clipper.*;

@:allow(clipper) class PolyNode
{
	var m_Parent:PolyNode;
	var m_polygon = new Path();
	var m_Index:Int;
	var m_jointype:JoinType;
	var m_endtype:EndType;
	var m_Childs = new Array<PolyNode>();

	public var ChildCount(get,never):Int;
	public var Contour(get,never):Path;
	public var IsOpen:Bool;
	public var Childs(get,never):Array<PolyNode>;
	public var Parent(get,never):PolyNode;
	public var IsHole(get,never):Bool;

	private function IsHoleNode():Bool
	{
		var result = true;
		var node = m_Parent;
		while (node != null)
		{
			result = !result;
			node = node.m_Parent;
		}
		return result;
	}

	inline function get_Childs():PolyNode
		return m_Childs;

	inline function get_Parent()
		return m_Parent;

	inline function get_IsHole()
		return IsHoleNode();

	inline function get_ChildCount()
		return m_Childs.length;

	inline function get_Contour()
		return m_polygon;

	function AddChild(PolyNode Child)
	{
		var cnt = m_Childs.length;
		m_Childs.push(Child);
		Child.m_Parent = this;
		Child.m_Index = cnt;
	}

	public function GetNext():PolyNode
	{
		if (m_Childs.length > 0)
			return m_Childs[0];
		else
			return GetNextSiblingUp();
	}

	function GetNextSiblingUp():PolyNode
	{
		if (m_Parent == null)
			return null;
		else if (m_Index == m_Parent.m_Childs.Count - 1)
			return m_Parent.GetNextSiblingUp();
		else
			return m_Parent.m_Childs[m_Index + 1];
	}
}
