import fs from 'fs';
import readline from 'readline';

const readFile = async () => {
  const rl = readline.createInterface({
    input: fs.createReadStream('input.txt'),
    crlfDelay: Infinity,
  });

  const scores: number[] = [];
  let currentscore = 0;

  rl.on('line', (line) => {
    if (line.length == 0) {
      scores.push(currentscore);
      currentscore = 0;
    }
    else {
      currentscore += Number(line) || 0;
    }
  });


  await new Promise((res) => rl.once('close', res));

  const sorted = scores.sort((a, b) => a - b);

  let best: number = Math.max(...scores);

  console.log(sorted[scores.length - 1]);
  console.log(best);
  console.log(sorted[sorted.length - 1] + sorted[sorted.length - 2] + sorted[sorted.length - 3]);
}

void (async () => {
  await readFile();
})();
