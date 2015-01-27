package clipper.pvt;

class Tools
{
	inline public static function Clear<T>(arr:Array<T>)
	{
		if (arr.length != 0) arr.splice(0,arr.length);
	}
}
