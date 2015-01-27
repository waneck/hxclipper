import clipper.*;

using clipper.pvt.Tools;

@:allow(clipper) class PolyTree extends PolyNode
{
	public var Total(get,never):Int;
	var m_AllPolys = new Array<PolyNode>();

	public function Clear()
	{
		for (i in 0...m_AllPolys.length)
			m_AllPolys[i] = null;
		m_AllPolys.Clear();
		m_Childs.Clear();
	}

	public function GetFirst():PolyNode
	{
		if (m_Childs.length > 0)
			return m_Childs[0];
		else
			return null;
	}

	private function get_Total():Int
	{
		var result = m_AllPolys.length;
		//with negative offsets, ignore the hidden outer polygon ...
		if (result > 0 && m_Childs[0] != m_AllPolys[0]) result--;
		return result;
	}
}
