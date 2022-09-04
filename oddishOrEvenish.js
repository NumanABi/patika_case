function oddishOrEvenish(number) {
    var total = 0;
    String(number).split("").map(Number).forEach((digit) => {
        total += digit;
    });
    return (total % 2 ? 'Odd' : 'Even');
}

console.log(oddishOrEvenish(43)); // Odd
console.log(oddishOrEvenish(373)); // Odd
console.log(oddishOrEvenish(4433)); // Even
