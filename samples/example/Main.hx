import clipper.*;

class Main
{
	static function main()
	{
		var subj = [
			[
				new IntPoint(180,200),
				new IntPoint(260,200),
				new IntPoint(260,150),
				new IntPoint(180,150)
			],
			[
				new IntPoint(215, 160),
				new IntPoint(230, 190),
				new IntPoint(200, 190)
			]
		];

		var clip = [
			[
				new IntPoint(190,210),
				new IntPoint(240,210),
				new IntPoint(240,130),
				new IntPoint(190,130)
			]
		];

		var solution = [];
		var c = new Clipper();
		c.AddPaths(subj, Subject, true);
		c.AddPaths(clip, Clip, true);
		c.Execute(Intersection, solution, EvenOdd, EvenOdd);

		trace(solution);
	}
}
