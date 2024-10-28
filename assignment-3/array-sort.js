function sortEvenOddDescending(arr) {
    // Separate even and odd numbers
    const evenNumbers = arr.filter(num => num % 2 === 0);
    const oddNumbers = arr.filter(num => num % 2 !== 0);

    // Sort both arrays in descending order
    evenNumbers.sort((a, b) => b - a);
    oddNumbers.sort((a, b) => b - a);

    // Concatenate the even and odd arrays
    return [...evenNumbers, ...oddNumbers];
}

// Example case
const input = [3, 2, 5, 1, 8, 9, 6];
const output = sortEvenOddDescending(input);
console.log(output); // Output: [8, 6, 2, 9, 5, 3, 1]
