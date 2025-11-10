# GenerateAlphabet

**GenerateAlphabet** is a Swift command-line utility that creates a UTF-8–encoded text file containing a sequence of unique, printable Unicode characters.

The generated string:
- Begins with the 62 ASCII alphanumeric characters (`0–9`, `a–z`, `A–Z`)
- Continues with printable glyphs from across all Unicode planes
- Excludes whitespace, combining marks, control codes, and duplicates
- Ensures uniqueness even under **Unicode canonical normalization**

---

## 🧭 Overview

| Property | Description |
|-----------|--------------|
| **Language** | Swift 6 (or Swift 5.9+) |
| **Output Encoding** | UTF-8 |
| **Output File** | `unicode_<N>_chars.txt` |
| **Default Length** | 1024 characters |
| **License** | © 2025 MATZ Software & Consulting. All rights reserved. |

This tool is useful for:
- Testing text rendering, normalization, or collation
- Stress-testing editors and encoders
- Generating synthetic data that covers many Unicode blocks

---

## ⚙️ Building

You can build or run the package using Swift Package Manager.

```bash
git clone https://github.com/<your-username>/GenerateAlphabet.git
cd GenerateAlphabet
swift build
```

To run it directly:

```bash
swift run GenerateAlphabet
```

This creates a file named:

```
unicode_1024_chars.txt
```

in the current working directory.

---

## 🧩 Command-Line Options

You can optionally specify the total string length (must be ≥ 62):

```bash
swift run GenerateAlphabet 2048
```

Example output file:

```
unicode_2048_chars.txt
```

---

## 🔤 Implementation Notes

* **Normalization:**
  Each glyph is normalized using `.precomposedStringWithCanonicalMapping` before uniqueness testing.
  This prevents duplicates where different Unicode sequences form the same visual character (e.g., `é` vs. `e\u{0301}`).

* **Exclusions:**

  * Whitespace (`U+0020`, `U+00A0`, `U+2002`, etc.)
  * Combining marks (`M*` general categories)
  * Control and format characters (`C*` categories)

* **Determinism:**
  Because iteration proceeds in ascending code-point order, the generated string is reproducible across runs and systems.

---

## 🧱 Example Output

| Prefix                                                           | Example Glyphs                                                               |
| ---------------------------------------------------------------- | ---------------------------------------------------------------------------- |
| `0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ` | `¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæç...` |

*(Full file contains exactly 1024 UTF-8 encoded characters.)*

---

## 🔮 Future Enhancements

* Support for custom normalization modes (`precomposed` vs. `decomposed`)
* Optional exclusion of look-alike glyphs across scripts (Latin, Greek, Cyrillic)
* Integration with UnicodeData.txt for fine-grained script filtering
* Output table of scalar values for debugging

---

## 🧑‍💻 Author

**Mark T. Johnson**
[markj@matzsoft.com](mailto:markj@matzsoft.com)
© 2025 [MATZ Software & Consulting](https://matzsoft.com). All rights reserved.

---

## 📜 License

This source code is released under your chosen proprietary or open license.
For internal or client projects, include a `LICENSE` file specifying usage terms.