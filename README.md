# 📘 T Flip-Flop (Toggle Flip-Flop) – Verilog

## 🔹 Overview

This project implements a **T Flip-Flop (Toggle Flip-Flop)** in Verilog along with a **self-checking testbench**.

A T Flip-Flop changes its state (toggles) when the input `T = 1` at the **rising edge of the clock**, and holds its state when `T = 0`.

---

## 🔹 Features

* Positive edge-triggered operation
* Toggle functionality
* Synchronous reset (`rst_i`)
* Complement output (`Qbar_o`)
* Self-checking testbench
* Randomized input testing

---

## 🔹 Module Description

### 📌 Inputs

* `T_i` → Toggle input
* `clk_i` → Clock input
* `rst_i` → Reset (active HIGH)

### 📌 Outputs

* `Q_o` → Output
* `Qbar_o` → Complement output

---

## 🔹 Working Principle

### 🔸 T Flip-Flop Behavior

| T | Clock Edge | Next State          |
| - | ---------- | ------------------- |
| 0 | ↑          | Hold (Q stays same) |
| 1 | ↑          | Toggle (Q → Q̅)     |

---

### 🔸 Sequential Logic

```id="tff_seq"
always @(posedge clk_i)
   if (rst_i)
      Q_o <= 1'b0;
   else if (T_i)
      Q_o <= ~Q_o;
```

---

## 🔹 Reset Behavior

* Active HIGH reset
* Initializes:

```
Q_o = 0
Qbar_o = 1
```

---

## 🔹 Testbench Details

The testbench (`tb_Tff`) verifies correct functionality using:

### 🔸 Features

* Continuous clock generation
* Reset initialization
* Deterministic + random input patterns
* Self-checking mechanism
* Pass/Fail tracking

---

## 🔹 Verification Strategy

### 🔸 Expected Output Logic

```id="tff_check"
if (rst_ti)
   exp_Q = 0;
else if (T_ti)
   exp_Q = ~exp_Q;
else
   exp_Q = exp_Q;
```

### 🔸 Auto Checking

* Triggered on every **posedge clock**
* Small delay (`#1`) ensures stable outputs

---

## 🔹 Simulation

### ▶️ Tools

* ModelSim / QuestaSim
* Xilinx Vivado
* Icarus Verilog + GTKWave

### ▶️ Run (Icarus Verilog Example)

```bash id="tff_run"
iverilog -o Tff.vvp Tff.v tb_Tff.v
vvp Tff.vvp
gtkwave Tff.vcd
```

---

## 🔹 Output

* Error messages for mismatches
* Final summary:

```
Total Checks: X | Pass: Y | Fail: Z
```

* Waveform file:

```
Tff.vcd
```

---

## 🔹 Sample Output Format

```id="tff_sample"
Time: 20 | T: 1 | Q: 0, Q+: 1
```

---

## 🔹 Applications

* Frequency division circuits
* Binary counters
* Toggle-based control systems
* Clock division

---

## 🔹 Design Insights

* T Flip-Flop is a simplified form of JK Flip-Flop (`J=K=T`)
* Efficient for toggle operations and counters
* Always synchronize verification with clock edges
* Reset ensures predictable simulation startup

---

## 🔹 File Structure

```id="tff_struct"
├── Tff.v          # T Flip-Flop Design
├── tb_Tff.v       # Testbench
├── Tff.vcd        # Waveform output (generated)
└── README.txt     # Documentation
```
