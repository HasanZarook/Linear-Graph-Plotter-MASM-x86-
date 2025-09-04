
# 📈 Linear Graph Plotter (MASM x86)

This project is a **Linear Graph Plotter** implemented in **MASM x86 assembly** using the **Irvine32 library**. It allows the user to input a linear equation in the form:

```
Y = (A / B) * X + C
```

and then plots the result in a simple text-based graph on the console. 🖥️✨

---

## 📝 Features

* ✅ Input `A`, `B`, `C` values from the user
* ✅ Compute `Y` for a series of `X` values
* ✅ Store results in an array (`myArray`)
* ✅ Display **linear graph** using ASCII characters:

  * `*` for points
  * `|` for Y-axis
  * `-` for X-axis
* ✅ Print **numerical results** for each `X`

---

## 📂 Variables and Data

| Name        | Type  | Description                      |    |
| ----------- | ----- | -------------------------------- | -- |
| `slope`     | REAL8 | Value of A (numerator)           |    |
| `intercept` | REAL8 | Value of B (denominator)         |    |
| `constant`  | REAL8 | Value of C (constant term)       |    |
| `myArray`   | REAL8 | Array to store computed Y values |    |
| `X`         | REAL8 | X values for the plot            |    |
| `result`    | REAL8 | Computed Y values                |    |
| `dot`       | BYTE  | Character for plot points `*`    |    |
| `yline`     | BYTE  | Character for Y-axis \`          | \` |
| `xline`     | BYTE  | Character for X-axis `-`         |    |

---

## 🛠️ How It Works

1. **Read input values** `A`, `B`, and `C` from the user:

```asm
mov edx, OFFSET inputStr1
call WriteString
call ReadFloat
fstp slope
```

2. **Compute linear equation** `Y = (A/B)*X + C` for multiple X values:

```asm
fld X
fmul slope
fdiv intercept
fadd constant
fstp result
```

3. **Store results** in `myArray` for plotting:

```asm
fstp DWORD PTR [esi]
add esi, 4
```

4. **Output numerical results**:

```asm
fld DWORD PTR [esi]
call WriteFloat
call crlf
```

5. **Draw the graph** using ASCII characters:

* Loops through rows and columns
* Prints `*` at points calculated by Y values
* Prints `|` for Y-axis and `-` for X-axis

---

## 🎨 Sample Console Output

```
Linear Graph Plotter
Model Equation: Y=(A/B)*X+C

Enter the value of A: 2
Enter the value of B: 1
Enter the value of C: 3

Result: 3
Result: 3.4
Result: 3.8
...
```

```
        |
  5     *  
  4    *   
  3   *    
  2 *      
----------------
```

---

## ⚡ How to Run

1. Install **MASM32** or set up **MASM** in your IDE
2. Include `Irvine32.inc` in your project directory
3. Assemble and link your program:

```bash
ml /c /coff LinearGraph.asm
link /SUBSYSTEM:CONSOLE LinearGraph.obj Irvine32.lib
```

4. Run the executable:

```bash
LinearGraph.exe
```

---

## 💡 Notes

* Uses **floating point operations** (`REAL8`) for precise calculations
* Uses **`.WHILE`, `.IF`, `.ENDW` directives** for structured loops and conditions
* Designed for console **ASCII graphing** only

