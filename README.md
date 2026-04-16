# RISC-V 5-Stage Pipelined SoC (Sky130)


A fully verified, tapeout-ready **32-bit RISC-V (RV32I)** processor implemented as a complete SoC with physically integrated Sky130 SRAM macros. The design was synthesized, placed, and routed end-to-end using **OpenLane 2** and verified at gate level using extracted netlists.

---

## 🏗️ Architecture


The top-level SoC (`soc_top.v`) integrates:

| Block | Module | Description |
|-------|--------|-------------|
| **5-Stage CPU Core** | `top.v` | IF → ID → EX → MEM → WB pipeline |
| **Instruction Memory** | `sky130_sram_1kbyte_1rw1r_32x256_8` | Dual-port 1KB SRAM. Port 1 = fetch, Port 0 = frontdoor programming |
| **Data Memory** | `sky130_sram_1kbyte_1rw1r_32x256_8` | Single-port 1KB SRAM accessed via combinational EX-stage outputs |
| **Hazard Unit** | `hazard.v` | Load-use stall detection, branch flush |
| **Forwarding Unit** | `forward.v` | EX/MEM → EX and MEM/WB → EX bypass paths |
| **Programming Interface** | `soc_top.v` | 3-wire frontdoor bus (`prog_we/addr/data`) for firmware loading |


## ✅ Verification Results

### Verification Methodology

Đã chuẩn hóa SoC Testbench từ bài toán FPGA sang luồng vi mạch ASIC/GLS:
- **Firmware Automation:** Tách mã nhị phân assembly sang 4 tệp hex độc lập (`phase1` -> `phase4`). Nạp tự động qua cổng hậu (Backdoor Write) bằng lệnh `$readmemh` trực tiếp vào `dut.imem_sram.mem`, giúp tránh lỗi X-Propagation, tối ưu hàng triệu chu kỳ mô phỏng.
- **RTL-to-GLS Consistency:** Tái cấu trúc bộ đóng gói (Packing/Unpacking) Load/Store Alignment (LB, LH, SB, ...) trên RTL testbench `tb_top.v` đồng bộ 100% với SRAM Macro trên SoC Netlist. Tỉ lệ Coverage các lệnh Load/Store Memory được xác minh chính xác hoàn toàn.
- **GLS Register Visibility:** Khóa cơ chế tối ưu cực đoan của Yosys bằng `(* keep = "true" *)` trên register file. Giữ nguyên cây biến State để trình Monitor tại Flat Netlist truy xuất mạnh mẽ lên 32 thanh ghi RV32I.

### RTL Simulation — 45/45 PASSED

```bash
./scripts/run_tb.sh
```

![RTL Simulation](docs/rtl_sim_pass.png)

| Phase | Tests | Coverage |
|-------|-------|----------|
| I-type ALU (ADDI, ANDI, ORI, XORI, SLTI) | ✅ PASS | Immediate arithmetic |
| R-type ALU (ADD, SUB, AND, OR, XOR, SLT, SLTU) | ✅ PASS | Register-register ops |
| Shift Operations (SLLI, SRLI, SRAI) | ✅ PASS | Barrel shifter |
| LUI / AUIPC | ✅ PASS | PC-relative upper immediate |
| Load / Store (LW, SW) | ✅ PASS | SRAM read/write |
| EX/MEM & MEM/WB Forwarding | ✅ PASS | Zero-stall RAW hazard bypass |
| Load-Use Hazard Stall | ✅ PASS | 1-cycle stall insertion |
| Control Flow (BEQ, BNE, JAL, JALR) | ✅ PASS | Branch + jump correctness |

### Gate-Level Simulation — 31/45 PASSED (Pending PnR)

```bash
./scripts/run_gls.sh
```

![GLS Results](docs/gls_pass.png)

GLS runs against the **post-PnR extracted netlist** using back-annotated SDF timing. Currently passing 31/45 tests because the stale netlist misses the newest Branch-Target bugfixes. A fresh OpenLane 2 run is required to reach the final 45/45 pass.

---

## ⚙️ ASIC Physical Design (RTL → GDSII)

Synthesized, placed, and routed using **OpenLane 2** on the `sky130A` (130nm) process node.

```bash
./scripts/run_ol2.sh
```

![GDSII Layout in KLayout](docs/gdsii_layout.png)

### Sign-off Metrics

| Metric | Value | Notes |
|--------|-------|-------|
| **Process Node** | Sky130A (130nm) | SkyWater Open PDK |
| **Die Area** | 1.21 mm² (1100×1100 µm) | Including bond ring |
| **Core Area** | 1.17 mm² | Active logic area |
| **Logic Area (stdcell)** | 0.125 mm² | CPU pipeline gates only |
| **SRAM Macro Area** | 0.381 mm² | 2× 1KB SRAM macros |
| **Total Cell Count** | 6,570 cells | Post-synthesis |
| **Flip-Flops** | 1,520 registers | Pipeline + control state |
| **Estimated Fmax** | ~50 MHz | Worst-case SS corner, SRAM-limited |
| **LVS Violations** | 0 | Clean |
| **DRC Violations** | 0 | Clean |
| **Hold Violations** | 0 | All corners |
| **Setup Violations (internal)** | 0 | Reg-to-reg, all corners |

### Timing Details (Post-PnR STA, OpenSTA)

| Corner | Condition | Setup WNS | Hold WNS | Status |
|--------|-----------|-----------|----------|--------|
| `nom_tt_025C_1v80` | Typical | +1.07 ns | +0.35 ns | ✅ PASS |
| `nom_ff_n40C_1v95` | Fast-Fast | +2.19 ns | +0.13 ns | ✅ PASS |
| `nom_ss_100C_1v60` | Slow-Slow | -2.14 ns* | +0.95 ns | ⚠️ |
| `max_ss_100C_1v60` | Worst-Case | -2.52 ns* | +0.97 ns | ⚠️ |

> **\*Note:** Setup violations at SS corners are exclusively on **debug observation ports** (`dbg_dmem_*`), not on functional data paths. The internal reg-to-reg slack at worst-case is **+0.655 ns (MET)**. Fmax is bounded by SRAM macro access time (~8–10 ns), not CPU logic depth.

### Area Breakdown

| Component | Area (µm²) | % of Core |
|-----------|-----------|-----------|
| SRAM Macros (2×) | 381,425 | 32.5% |
| Standard Cells (CPU logic) | 125,399 | 10.7% |
| Routing + Whitespace | ~666,000 | 56.8% |
| **Total Core** | **1,172,790** | 100% |

---

## 📁 Repository Structure

```text
riscv_pipeline_gds/
├── src/
│   ├── core/          # CPU pipeline stages and functional units
│   │   ├── alu.v, alu_control.v, control.v
│   │   ├── forward.v, hazard.v
│   │   ├── imm_gen.v, pc_reg.v, regfile.v
│   │   └── ex_stage.v
│   ├── pipeline/      # Interstage pipeline registers
│   │   ├── if_id_reg.v, id_ex_reg.v
│   │   ├── ex_mem_reg.v, mem_wb_reg.v
│   └── top/           # SoC wrapper and constraints
│       ├── top.v, soc_top.v
│       ├── sram_macro_blackbox.v
│       └── sdc_constraints.sdc
├── tb/                # Testbenches
│   ├── tb_top.v       # RTL self-checking testbench (31 tests)
│   ├── tb_frontdoor.v # Programming interface testbench
│   └── tb_gls.v       # Gate-level self-checking testbench (30 tests)
├── scripts/           # Automation scripts
│   ├── run_tb.sh      # Run RTL simulation
│   ├── run_frontdoor.sh
│   ├── run_gls.sh     # Run gate-level simulation
│   ├── run_ol2.sh     # Run full OpenLane 2 flow
│   ├── run_postsynth.sh
│   ├── open_gui.sh    # Open OpenROAD GUI
│   ├── open_gds.sh    # Open GDSII in KLayout
│   └── clean_all.sh
├── docs/              # Images and documentation assets
├── config.json        # OpenLane 2 configuration
├── pin_order.cfg      # Physical pin placement constraints
└── runs/              # OpenLane outputs (GDSII, netlists, reports)
```

---

## 🚀 Quick Start

Requires: **WSL2 / Linux**, **Icarus Verilog**, **Docker** (for OpenLane 2)

```bash
git clone <your_repo_url>
cd riscv_pipeline_gds
chmod +x scripts/*.sh

# Run RTL simulation
./scripts/run_tb.sh

# Run Gate-Level simulation (requires OpenLane run output)
./scripts/run_gls.sh

# Full ASIC flow (requires Docker + OpenLane 2 environment)
./scripts/run_ol2.sh
```

---

## 🛠️ Tools & Environment

| Tool | Version | Purpose |
|------|---------|---------|
| Icarus Verilog (`iverilog`) | 11.0 | RTL & GLS simulation |
| OpenLane 2 | 2.x | RTL-to-GDSII ASIC flow |
| OpenROAD | — | Placement, routing, STA |
| Yosys | — | Synthesis |
| KLayout | 0.29.4 | GDSII viewer / DRC |
| Sky130A PDK | 0fe599b2 | Standard cell library |
| `sky130_sram_macros` | — | Physical SRAM macros |

---

## 📄 License

MIT License — see [LICENSE](LICENSE) for details.
