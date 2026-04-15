@echo off
REM Auto-cd to project root so relative paths work
cd /d "%~dp0\.."
REM ============================================================
REM  RISC-V 5-Stage Pipeline — Icarus Verilog Test Runner
REM ============================================================
echo.
echo [1/3] Compiling with Icarus Verilog...

iverilog -g2012 -o tb_top.vvp ^
  tb/tb_top.v ^
  src/core/alu.v ^
  src/core/alu_control.v ^
  src/core/control.v ^
  src/core/ex_stage.v ^
  src/core/forward.v ^
  src/core/hazard.v ^
  src/core/imm_gen.v ^
  src/core/pc_reg.v ^
  src/core/regfile.v ^
  src/pipeline/if_id_reg.v ^
  src/pipeline/id_ex_reg.v ^
  src/pipeline/ex_mem_reg.v ^
  src/pipeline/mem_wb_reg.v ^
  src/top/top.v

if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Compilation failed!
    pause
    exit /b 1
)

echo [2/3] Running simulation...
vvp tb_top.vvp

echo.
echo [3/3] Done! VCD waveform saved to tb_top.vcd
echo        Open with GTKWave: gtkwave tb_top.vcd
pause
