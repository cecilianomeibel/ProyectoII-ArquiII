transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/galva/OneDrive/Escritorio/TEC/1er_semestre_2025/Arqui2/ProyectoII-ArquiII/HW/SRAM {C:/Users/galva/OneDrive/Escritorio/TEC/1er_semestre_2025/Arqui2/ProyectoII-ArquiII/HW/SRAM/SRAM.v}
vlog -sv -work work +incdir+C:/Users/galva/OneDrive/Escritorio/TEC/1er_semestre_2025/Arqui2/ProyectoII-ArquiII/HW/Data_Unit {C:/Users/galva/OneDrive/Escritorio/TEC/1er_semestre_2025/Arqui2/ProyectoII-ArquiII/HW/Data_Unit/ShiftRegisterChain.sv}
vlog -sv -work work +incdir+C:/Users/galva/OneDrive/Escritorio/TEC/1er_semestre_2025/Arqui2/ProyectoII-ArquiII/HW/Data_Unit {C:/Users/galva/OneDrive/Escritorio/TEC/1er_semestre_2025/Arqui2/ProyectoII-ArquiII/HW/Data_Unit/ShiftRegister.sv}
vlog -sv -work work +incdir+C:/Users/galva/OneDrive/Escritorio/TEC/1er_semestre_2025/Arqui2/ProyectoII-ArquiII/HW/SRAM {C:/Users/galva/OneDrive/Escritorio/TEC/1er_semestre_2025/Arqui2/ProyectoII-ArquiII/HW/SRAM/RAM.sv}
vlog -sv -work work +incdir+C:/Users/galva/OneDrive/Escritorio/TEC/1er_semestre_2025/Arqui2/ProyectoII-ArquiII/HW/PE {C:/Users/galva/OneDrive/Escritorio/TEC/1er_semestre_2025/Arqui2/ProyectoII-ArquiII/HW/PE/PE.sv}
vlog -sv -work work +incdir+C:/Users/galva/OneDrive/Escritorio/TEC/1er_semestre_2025/Arqui2/ProyectoII-ArquiII/HW {C:/Users/galva/OneDrive/Escritorio/TEC/1er_semestre_2025/Arqui2/ProyectoII-ArquiII/HW/systolicArray.sv}
vlog -sv -work work +incdir+C:/Users/galva/OneDrive/Escritorio/TEC/1er_semestre_2025/Arqui2/ProyectoII-ArquiII/HW/Data_Unit {C:/Users/galva/OneDrive/Escritorio/TEC/1er_semestre_2025/Arqui2/ProyectoII-ArquiII/HW/Data_Unit/dataUnit.sv}
vlog -sv -work work +incdir+C:/Users/galva/OneDrive/Escritorio/TEC/1er_semestre_2025/Arqui2/ProyectoII-ArquiII/HW/Data_Unit {C:/Users/galva/OneDrive/Escritorio/TEC/1er_semestre_2025/Arqui2/ProyectoII-ArquiII/HW/Data_Unit/matrixTranspose.sv}
vlog -sv -work work +incdir+C:/Users/galva/OneDrive/Escritorio/TEC/1er_semestre_2025/Arqui2/ProyectoII-ArquiII/HW/telemetry {C:/Users/galva/OneDrive/Escritorio/TEC/1er_semestre_2025/Arqui2/ProyectoII-ArquiII/HW/telemetry/performanceMonitor.sv}
vlog -sv -work work +incdir+C:/Users/galva/OneDrive/Escritorio/TEC/1er_semestre_2025/Arqui2/ProyectoII-ArquiII/HW {C:/Users/galva/OneDrive/Escritorio/TEC/1er_semestre_2025/Arqui2/ProyectoII-ArquiII/HW/ReLU.sv}
vlog -sv -work work +incdir+C:/Users/galva/OneDrive/Escritorio/TEC/1er_semestre_2025/Arqui2/ProyectoII-ArquiII/HW/debug {C:/Users/galva/OneDrive/Escritorio/TEC/1er_semestre_2025/Arqui2/ProyectoII-ArquiII/HW/debug/debouncer.sv}
vlog -sv -work work +incdir+C:/Users/galva/OneDrive/Escritorio/TEC/1er_semestre_2025/Arqui2/ProyectoII-ArquiII/HW/debug {C:/Users/galva/OneDrive/Escritorio/TEC/1er_semestre_2025/Arqui2/ProyectoII-ArquiII/HW/debug/decoder.sv}
vlog -sv -work work +incdir+C:/Users/galva/OneDrive/Escritorio/TEC/1er_semestre_2025/Arqui2/ProyectoII-ArquiII/HW/debug {C:/Users/galva/OneDrive/Escritorio/TEC/1er_semestre_2025/Arqui2/ProyectoII-ArquiII/HW/debug/debugger.sv}
vlog -sv -work work +incdir+C:/Users/galva/OneDrive/Escritorio/TEC/1er_semestre_2025/Arqui2/ProyectoII-ArquiII/HW {C:/Users/galva/OneDrive/Escritorio/TEC/1er_semestre_2025/Arqui2/ProyectoII-ArquiII/HW/NPU.sv}

vlog -sv -work work +incdir+C:/Users/galva/OneDrive/Escritorio/TEC/1er_semestre_2025/Arqui2/ProyectoII-ArquiII/HW {C:/Users/galva/OneDrive/Escritorio/TEC/1er_semestre_2025/Arqui2/ProyectoII-ArquiII/HW/NPU_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  NPU_tb

add wave *
view structure
view signals
run -all
