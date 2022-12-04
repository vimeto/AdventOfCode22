import scala.io.Source

@main def hello: Unit =
  val filename = "src/main/resources/input.txt"
  var numOfInclusions = 0;

  for line <- Source.fromFile(filename).getLines do
    val firstlines = line.takeWhile(_ != ',');
    val secondlines = line.dropWhile(_ != ',').drop(1);

    val firststart = firstlines.takeWhile(_ != '-').toIntOption.getOrElse(-1);
    val firstend = firstlines.dropWhile(_ != '-').drop(1).toIntOption.getOrElse(-1);

    val secondstart = secondlines.takeWhile(_ != '-').toIntOption.getOrElse(-1);
    val secondend = secondlines.dropWhile(_ != '-').drop(1).toIntOption.getOrElse(-1);

    if (firststart == -1 || firstend == -1 || secondstart == -1 || secondend == -1) {
      println("Invalid input");
    }
    else {
      val first = firststart to firstend;
      val second = secondstart to secondend;

      val result = first.intersect(second).toList;

      // if (result.length == Math.min(first.length, second.length)) {
      //   numOfInclusions += 1;
      // } // first answer
      if (result.length > 0) {
        numOfInclusions += 1;
      }
    }

  println(numOfInclusions);
