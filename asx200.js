let rawInput = '';
process.stdin.resume();
process.stdin.setEncoding('utf8');
process.stdin.on('data', x => rawInput += x);
process.stdin.on('end', () => {
  const input = JSON.parse(rawInput);
  input.items.map(x => x.symbol.split('.')[0].toUpperCase()).forEach(x => console.log(x));
});

