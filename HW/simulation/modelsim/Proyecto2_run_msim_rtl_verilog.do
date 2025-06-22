transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/galva/OneDrive/Escritorio/TEC/1er_semestre_2025/Arqui2/ProyectoII-ArquiII/HW/Data_Unit {C:/Users/galva/OneDrive/Escritorio/TEC/1er_semestre_2025/Arqui2/ProyectoII-ArquiII/HW/Data_Unit/ShiftRegisterChain.sv}
vlog -sv -work work +incdir+C:/Users/galva/OneDrive/Escritorio/TEC/1er_semestre_2025/Arqui2/ProyectoII-ArquiII/HW/Data_Unit {C:/Users/galva/OneDrive/Escritorio/TEC/1er_semestre_2025/Arqui2/ProyectoII-ArquiII/HW/Data_Unit/ShiftRegister.sv}
vlog -sv -work work +incdir+C:/Users/galva/OneDrive/Escritorio/TEC/1er_semestre_2025/Arqui2/ProyectoII-ArquiII/HW/Data_Unit {C:/Users/galva/OneDrive/Escritorio/TEC/1er_semestre_2025/Arqui2/ProyectoII-ArquiII/HW/Data_Unit/dataUnit.sv}
vlog -sv -work work +incdir+C:/Users/galva/OneDrive/Escritorio/TEC/1er_semestre_2025/Arqui2/ProyectoII-ArquiII/HW/Data_Unit {C:/Users/galva/OneDrive/Escritorio/TEC/1er_semestre_2025/Arqui2/ProyectoII-ArquiII/HW/Data_Unit/matrixTranspose.sv}

vlog -sv -work work +incdir+C:/Users/galva/OneDrive/Escritorio/TEC/1er_semestre_2025/Arqui2/ProyectoII-ArquiII/HW/Data_Unit {C:/Users/galva/OneDrive/Escritorio/TEC/1er_semestre_2025/Arqui2/ProyectoII-ArquiII/HW/Data_Unit/dataUnit_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  dataUnit_tb

add wave *
view structure
view signals
run -all
