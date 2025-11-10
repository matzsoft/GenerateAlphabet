# GenerateAlphabet

A Swift command-line utility that generates a string of unique UTF-8 printable characters.  
The resulting string contains no duplicates, no whitespace, and no combining or control characters — even when normalized under Unicode.

Originally created by ChatGPT and enhanced by Mark T. Johnson.

---

## Features

- Generates a configurable-length string of printable Unicode characters.
- Ensures no duplicates (including after canonical normalization).
- Allows custom prefixes (default is alphanumeric: 0–9, a–z, A–Z).
- Writes output to file or prints directly to stdout.
- Implemented in pure Swift using Foundation and ArgumentParser.

---

## Installation

### From Source

```bash
git clone git@github.com:matzsoft/GenerateAlphabet.git
cd GenerateAlphabet
swift build -c release
````

This will produce an executable at:

```
.build/release/GenerateAlphabet
```

---

## Usage

```bash
GenerateAlphabet [options]
```

### Options

| Option            | Type     | Description                                                                                                                      |
| ----------------- | -------- | -------------------------------------------------------------------------------------------------------------------------------- |
| `-l`, `--length`  | *Int*    | The total number of characters in the generated string (default: **1024**).                                                      |
| `-p`, `--prefix`  | *String* | A custom prefix to include at the start of the string. Defaults to digits 0–9, lowercase a–z, and uppercase A–Z (62 characters). |
| `-o`, `--outFile` | *String* | The file path for output. Defaults to `unicode_<length>_chars.txt` in the current directory.                                     |
| `-s`, `--stdout`  | *Flag*   | Output the string directly to standard output instead of writing to a file. Mutually exclusive with `--outFile`.                 |
| `-h`, `--help`    |          | Show usage information.                                                                                                          |

---

## Examples

Generate the default 1024-character alphabet and save it to the default file:

```bash
GenerateAlphabet
```

Generate a 2048-character alphabet and write it to a custom file:

```bash
GenerateAlphabet --length 2048 --outFile mychars.txt
```

Generate with a custom prefix and print directly to stdout:

```bash
GenerateAlphabet --prefix "abc123" --stdout
```

---

## Output

The generated file will contain a single UTF-8 encoded line of printable characters.
Example default output file:

```
unicode_1024_chars.txt
```

---

## License

This project is licensed under the MIT License (see `LICENSE` file).

© 2025 MATZ Software & Consulting. All rights reserved.


---

## ⚖️ `LICENSE`

```text
MIT License

Copyright (c) 2025 Mark T. Johnson, MATZ Software & Consulting

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the “Software”), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
````