
################################################################
# This is a generated script based on design: base_system
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2017.1
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source base_system_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7z010clg400-1
   set_property BOARD_PART digilentinc.com:zybo:part0:1.0 [current_project]
}


# CHANGE DESIGN NAME HERE
set design_name base_system

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_msg_id "BD_TCL-001" "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_msg_id "BD_TCL-002" "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_msg_id "BD_TCL-003" "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_msg_id "BD_TCL-004" "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_msg_id "BD_TCL-005" "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_msg_id "BD_TCL-114" "ERROR" $errMsg}
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports

  # Create ports
  set clk [ create_bd_port -dir I -type clk clk ]
  set ctrl_out [ create_bd_port -dir I ctrl_out ]
  set ctrl_out_1 [ create_bd_port -dir I ctrl_out_1 ]
  set ctrl_out_2 [ create_bd_port -dir I ctrl_out_2 ]
  set ctrl_out_3 [ create_bd_port -dir I ctrl_out_3 ]
  set ctrl_out_4 [ create_bd_port -dir I ctrl_out_4 ]
  set ctrl_out_5 [ create_bd_port -dir I ctrl_out_5 ]
  set ctrl_out_6 [ create_bd_port -dir I ctrl_out_6 ]
  set enable [ create_bd_port -dir I enable ]
  set led [ create_bd_port -dir O led ]
  set rst_n [ create_bd_port -dir I -type rst rst_n ]

  # Create instance: blk_mem_gen_0, and set properties
  set blk_mem_gen_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.3 blk_mem_gen_0 ]
  set_property -dict [ list \
CONFIG.Byte_Size {9} \
CONFIG.Enable_32bit_Address {false} \
CONFIG.Enable_A {Always_Enabled} \
CONFIG.Enable_B {Always_Enabled} \
CONFIG.Memory_Type {True_Dual_Port_RAM} \
CONFIG.Operating_Mode_A {NO_CHANGE} \
CONFIG.Port_B_Clock {100} \
CONFIG.Port_B_Enable_Rate {100} \
CONFIG.Port_B_Write_Rate {50} \
CONFIG.Register_PortA_Output_of_Memory_Primitives {true} \
CONFIG.Register_PortB_Output_of_Memory_Primitives {true} \
CONFIG.Use_Byte_Write_Enable {false} \
CONFIG.Use_RSTA_Pin {false} \
CONFIG.use_bram_block {Stand_Alone} \
 ] $blk_mem_gen_0

  # Create instance: ports_ctrl_0, and set properties
  set ports_ctrl_0 [ create_bd_cell -type ip -vlnv xilinx.com:user:ports_ctrl:1.0 ports_ctrl_0 ]

  # Create instance: ports_ctrl_1, and set properties
  set ports_ctrl_1 [ create_bd_cell -type ip -vlnv xilinx.com:user:ports_ctrl:1.0 ports_ctrl_1 ]

  # Create instance: ports_ctrl_2, and set properties
  set ports_ctrl_2 [ create_bd_cell -type ip -vlnv xilinx.com:user:ports_ctrl:1.0 ports_ctrl_2 ]

  # Create instance: ports_ctrl_3, and set properties
  set ports_ctrl_3 [ create_bd_cell -type ip -vlnv xilinx.com:user:ports_ctrl:1.0 ports_ctrl_3 ]

  # Create instance: ports_ctrl_4, and set properties
  set ports_ctrl_4 [ create_bd_cell -type ip -vlnv xilinx.com:user:ports_ctrl:1.0 ports_ctrl_4 ]

  # Create instance: ports_ctrl_5, and set properties
  set ports_ctrl_5 [ create_bd_cell -type ip -vlnv xilinx.com:user:ports_ctrl:1.0 ports_ctrl_5 ]

  # Create instance: ports_ctrl_6, and set properties
  set ports_ctrl_6 [ create_bd_cell -type ip -vlnv xilinx.com:user:ports_ctrl:1.0 ports_ctrl_6 ]

  # Create instance: ports_ctrl_7, and set properties
  set ports_ctrl_7 [ create_bd_cell -type ip -vlnv xilinx.com:user:ports_ctrl:1.0 ports_ctrl_7 ]

  # Create instance: ports_ro_out_0, and set properties
  set ports_ro_out_0 [ create_bd_cell -type ip -vlnv xilinx.com:user:ports_ro_out:1.0 ports_ro_out_0 ]

  # Create instance: ports_ro_out_1, and set properties
  set ports_ro_out_1 [ create_bd_cell -type ip -vlnv xilinx.com:user:ports_ro_out:1.0 ports_ro_out_1 ]

  # Create instance: ports_ro_out_2, and set properties
  set ports_ro_out_2 [ create_bd_cell -type ip -vlnv xilinx.com:user:ports_ro_out:1.0 ports_ro_out_2 ]

  # Create instance: ports_ro_out_3, and set properties
  set ports_ro_out_3 [ create_bd_cell -type ip -vlnv xilinx.com:user:ports_ro_out:1.0 ports_ro_out_3 ]

  # Create instance: ports_ro_out_4, and set properties
  set ports_ro_out_4 [ create_bd_cell -type ip -vlnv xilinx.com:user:ports_ro_out:1.0 ports_ro_out_4 ]

  # Create instance: ports_ro_out_5, and set properties
  set ports_ro_out_5 [ create_bd_cell -type ip -vlnv xilinx.com:user:ports_ro_out:1.0 ports_ro_out_5 ]

  # Create instance: ports_ro_out_6, and set properties
  set ports_ro_out_6 [ create_bd_cell -type ip -vlnv xilinx.com:user:ports_ro_out:1.0 ports_ro_out_6 ]

  # Create instance: ports_ro_out_7, and set properties
  set ports_ro_out_7 [ create_bd_cell -type ip -vlnv xilinx.com:user:ports_ro_out:1.0 ports_ro_out_7 ]

  # Create instance: ro_counter_0, and set properties
  set ro_counter_0 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_counter:1.0 ro_counter_0 ]

  # Create instance: ro_counter_1, and set properties
  set ro_counter_1 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_counter:1.0 ro_counter_1 ]

  # Create instance: ro_counter_2, and set properties
  set ro_counter_2 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_counter:1.0 ro_counter_2 ]

  # Create instance: ro_counter_3, and set properties
  set ro_counter_3 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_counter:1.0 ro_counter_3 ]

  # Create instance: ro_counter_4, and set properties
  set ro_counter_4 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_counter:1.0 ro_counter_4 ]

  # Create instance: ro_counter_5, and set properties
  set ro_counter_5 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_counter:1.0 ro_counter_5 ]

  # Create instance: ro_counter_6, and set properties
  set ro_counter_6 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_counter:1.0 ro_counter_6 ]

  # Create instance: ro_counter_7, and set properties
  set ro_counter_7 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_counter:1.0 ro_counter_7 ]

  # Create instance: ro_out_bram_0, and set properties
  set ro_out_bram_0 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_out_bram:1.0 ro_out_bram_0 ]

  # Create instance: ro_probe_0, and set properties
  set ro_probe_0 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_0 ]

  # Create instance: ro_probe_1, and set properties
  set ro_probe_1 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_1 ]

  # Create instance: ro_probe_2, and set properties
  set ro_probe_2 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_2 ]

  # Create instance: ro_probe_3, and set properties
  set ro_probe_3 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_3 ]

  # Create instance: ro_probe_4, and set properties
  set ro_probe_4 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_4 ]

  # Create instance: ro_probe_5, and set properties
  set ro_probe_5 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_5 ]

  # Create instance: ro_probe_6, and set properties
  set ro_probe_6 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_6 ]

  # Create instance: ro_probe_7, and set properties
  set ro_probe_7 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_7 ]

  # Create instance: ro_probe_8, and set properties
  set ro_probe_8 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_8 ]

  # Create instance: ro_probe_9, and set properties
  set ro_probe_9 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_9 ]

  # Create instance: ro_probe_10, and set properties
  set ro_probe_10 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_10 ]

  # Create instance: ro_probe_11, and set properties
  set ro_probe_11 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_11 ]

  # Create instance: ro_probe_12, and set properties
  set ro_probe_12 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_12 ]

  # Create instance: ro_probe_13, and set properties
  set ro_probe_13 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_13 ]

  # Create instance: ro_probe_14, and set properties
  set ro_probe_14 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_14 ]

  # Create instance: ro_probe_15, and set properties
  set ro_probe_15 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_15 ]

  # Create instance: ro_probe_16, and set properties
  set ro_probe_16 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_16 ]

  # Create instance: ro_probe_17, and set properties
  set ro_probe_17 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_17 ]

  # Create instance: ro_probe_18, and set properties
  set ro_probe_18 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_18 ]

  # Create instance: ro_probe_19, and set properties
  set ro_probe_19 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_19 ]

  # Create instance: ro_probe_20, and set properties
  set ro_probe_20 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_20 ]

  # Create instance: ro_probe_21, and set properties
  set ro_probe_21 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_21 ]

  # Create instance: ro_probe_22, and set properties
  set ro_probe_22 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_22 ]

  # Create instance: ro_probe_23, and set properties
  set ro_probe_23 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_23 ]

  # Create instance: ro_probe_24, and set properties
  set ro_probe_24 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_24 ]

  # Create instance: ro_probe_25, and set properties
  set ro_probe_25 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_25 ]

  # Create instance: ro_probe_26, and set properties
  set ro_probe_26 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_26 ]

  # Create instance: ro_probe_27, and set properties
  set ro_probe_27 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_27 ]

  # Create instance: ro_probe_28, and set properties
  set ro_probe_28 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_28 ]

  # Create instance: ro_probe_29, and set properties
  set ro_probe_29 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_29 ]

  # Create instance: ro_probe_30, and set properties
  set ro_probe_30 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_30 ]

  # Create instance: ro_probe_31, and set properties
  set ro_probe_31 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_31 ]

  # Create instance: ro_probe_32, and set properties
  set ro_probe_32 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_32 ]

  # Create instance: ro_probe_33, and set properties
  set ro_probe_33 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_33 ]

  # Create instance: ro_probe_34, and set properties
  set ro_probe_34 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_34 ]

  # Create instance: ro_probe_35, and set properties
  set ro_probe_35 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_35 ]

  # Create instance: ro_probe_36, and set properties
  set ro_probe_36 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_36 ]

  # Create instance: ro_probe_37, and set properties
  set ro_probe_37 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_37 ]

  # Create instance: ro_probe_38, and set properties
  set ro_probe_38 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_38 ]

  # Create instance: ro_probe_39, and set properties
  set ro_probe_39 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_39 ]

  # Create instance: ro_probe_40, and set properties
  set ro_probe_40 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_40 ]

  # Create instance: ro_probe_41, and set properties
  set ro_probe_41 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_41 ]

  # Create instance: ro_probe_42, and set properties
  set ro_probe_42 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_42 ]

  # Create instance: ro_probe_43, and set properties
  set ro_probe_43 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_43 ]

  # Create instance: ro_probe_44, and set properties
  set ro_probe_44 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_44 ]

  # Create instance: ro_probe_45, and set properties
  set ro_probe_45 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_45 ]

  # Create instance: ro_probe_46, and set properties
  set ro_probe_46 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_46 ]

  # Create instance: ro_probe_47, and set properties
  set ro_probe_47 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_47 ]

  # Create instance: ro_probe_48, and set properties
  set ro_probe_48 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_48 ]

  # Create instance: ro_probe_49, and set properties
  set ro_probe_49 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_49 ]

  # Create instance: ro_probe_50, and set properties
  set ro_probe_50 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_50 ]

  # Create instance: ro_probe_51, and set properties
  set ro_probe_51 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_51 ]

  # Create instance: ro_probe_52, and set properties
  set ro_probe_52 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_52 ]

  # Create instance: ro_probe_53, and set properties
  set ro_probe_53 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_53 ]

  # Create instance: ro_probe_54, and set properties
  set ro_probe_54 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_54 ]

  # Create instance: ro_probe_55, and set properties
  set ro_probe_55 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_55 ]

  # Create instance: ro_probe_56, and set properties
  set ro_probe_56 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_56 ]

  # Create instance: ro_probe_57, and set properties
  set ro_probe_57 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_57 ]

  # Create instance: ro_probe_58, and set properties
  set ro_probe_58 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_58 ]

  # Create instance: ro_probe_59, and set properties
  set ro_probe_59 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_59 ]

  # Create instance: ro_probe_60, and set properties
  set ro_probe_60 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_60 ]

  # Create instance: ro_probe_61, and set properties
  set ro_probe_61 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_61 ]

  # Create instance: ro_probe_62, and set properties
  set ro_probe_62 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_62 ]

  # Create instance: ro_probe_63, and set properties
  set ro_probe_63 [ create_bd_cell -type ip -vlnv xilinx.com:user:ro_probe:1.0 ro_probe_63 ]

  # Create port connections
  connect_bd_net -net Net [get_bd_ports rst_n] [get_bd_pins ro_counter_0/rst_n] [get_bd_pins ro_counter_1/rst_n] [get_bd_pins ro_counter_2/rst_n] [get_bd_pins ro_counter_3/rst_n] [get_bd_pins ro_counter_4/rst_n] [get_bd_pins ro_counter_5/rst_n] [get_bd_pins ro_counter_6/rst_n] [get_bd_pins ro_counter_7/rst_n]
  connect_bd_net -net clk_1 [get_bd_ports clk] [get_bd_pins ro_counter_0/clk] [get_bd_pins ro_counter_1/clk] [get_bd_pins ro_counter_2/clk] [get_bd_pins ro_counter_3/clk] [get_bd_pins ro_counter_4/clk] [get_bd_pins ro_counter_5/clk] [get_bd_pins ro_counter_6/clk] [get_bd_pins ro_counter_7/clk] [get_bd_pins ro_out_bram_0/clk]
  connect_bd_net -net ctrl_out_1 [get_bd_ports ctrl_out] [get_bd_pins ports_ctrl_0/ctrl_out]
  connect_bd_net -net ctrl_out_1_1 [get_bd_ports ctrl_out_1] [get_bd_pins ports_ctrl_1/ctrl_out]
  connect_bd_net -net ctrl_out_2_1 [get_bd_ports ctrl_out_2] [get_bd_pins ports_ctrl_2/ctrl_out]
  connect_bd_net -net ctrl_out_3_1 [get_bd_ports ctrl_out_3] [get_bd_pins ports_ctrl_3/ctrl_out]
  connect_bd_net -net ctrl_out_4_1 [get_bd_ports ctrl_out_4] [get_bd_pins ports_ctrl_4/ctrl_out]
  connect_bd_net -net ctrl_out_5_1 [get_bd_ports ctrl_out_5] [get_bd_pins ports_ctrl_5/ctrl_out]
  connect_bd_net -net ctrl_out_6_1 [get_bd_ports ctrl_out_6] [get_bd_pins ports_ctrl_6/ctrl_out]
  connect_bd_net -net enable_1 [get_bd_ports enable] [get_bd_pins ro_out_bram_0/enable]
  connect_bd_net -net ports_ctrl_0_ena0 [get_bd_pins ports_ctrl_0/ena0] [get_bd_pins ro_probe_0/enable]
  connect_bd_net -net ports_ctrl_0_ena1 [get_bd_pins ports_ctrl_0/ena1] [get_bd_pins ro_probe_1/enable]
  connect_bd_net -net ports_ctrl_0_ena2 [get_bd_pins ports_ctrl_0/ena2] [get_bd_pins ro_probe_2/enable]
  connect_bd_net -net ports_ctrl_0_ena3 [get_bd_pins ports_ctrl_0/ena3] [get_bd_pins ro_probe_3/enable]
  connect_bd_net -net ports_ctrl_0_ena4 [get_bd_pins ports_ctrl_0/ena4] [get_bd_pins ro_probe_4/enable]
  connect_bd_net -net ports_ctrl_0_ena5 [get_bd_pins ports_ctrl_0/ena5] [get_bd_pins ro_probe_5/enable]
  connect_bd_net -net ports_ctrl_0_ena6 [get_bd_pins ports_ctrl_0/ena6] [get_bd_pins ro_probe_6/enable]
  connect_bd_net -net ports_ctrl_0_ena7 [get_bd_pins ports_ctrl_0/ena7] [get_bd_pins ro_probe_7/enable]
  connect_bd_net -net ports_ctrl_1_ena0 [get_bd_pins ports_ctrl_1/ena0] [get_bd_pins ro_probe_8/enable]
  connect_bd_net -net ports_ctrl_1_ena1 [get_bd_pins ports_ctrl_1/ena1] [get_bd_pins ro_probe_9/enable]
  connect_bd_net -net ports_ctrl_1_ena2 [get_bd_pins ports_ctrl_1/ena2] [get_bd_pins ro_probe_10/enable]
  connect_bd_net -net ports_ctrl_1_ena3 [get_bd_pins ports_ctrl_1/ena3] [get_bd_pins ro_probe_11/enable]
  connect_bd_net -net ports_ctrl_1_ena4 [get_bd_pins ports_ctrl_1/ena4] [get_bd_pins ro_probe_12/enable]
  connect_bd_net -net ports_ctrl_1_ena5 [get_bd_pins ports_ctrl_1/ena5] [get_bd_pins ro_probe_13/enable]
  connect_bd_net -net ports_ctrl_1_ena6 [get_bd_pins ports_ctrl_1/ena6] [get_bd_pins ro_probe_14/enable]
  connect_bd_net -net ports_ctrl_1_ena7 [get_bd_pins ports_ctrl_1/ena7] [get_bd_pins ro_probe_15/enable]
  connect_bd_net -net ports_ctrl_2_ena0 [get_bd_pins ports_ctrl_2/ena0] [get_bd_pins ro_probe_16/enable]
  connect_bd_net -net ports_ctrl_2_ena1 [get_bd_pins ports_ctrl_2/ena1] [get_bd_pins ro_probe_17/enable]
  connect_bd_net -net ports_ctrl_2_ena2 [get_bd_pins ports_ctrl_2/ena2] [get_bd_pins ro_probe_19/enable]
  connect_bd_net -net ports_ctrl_2_ena3 [get_bd_pins ports_ctrl_2/ena3] [get_bd_pins ro_probe_18/enable]
  connect_bd_net -net ports_ctrl_2_ena4 [get_bd_pins ports_ctrl_2/ena4] [get_bd_pins ro_probe_20/enable]
  connect_bd_net -net ports_ctrl_2_ena5 [get_bd_pins ports_ctrl_2/ena5] [get_bd_pins ro_probe_21/enable]
  connect_bd_net -net ports_ctrl_2_ena6 [get_bd_pins ports_ctrl_2/ena6] [get_bd_pins ro_probe_22/enable]
  connect_bd_net -net ports_ctrl_2_ena7 [get_bd_pins ports_ctrl_2/ena7] [get_bd_pins ro_probe_23/enable]
  connect_bd_net -net ports_ctrl_3_ena0 [get_bd_pins ports_ctrl_3/ena0] [get_bd_pins ro_probe_24/enable]
  connect_bd_net -net ports_ctrl_3_ena1 [get_bd_pins ports_ctrl_3/ena1] [get_bd_pins ro_probe_25/enable]
  connect_bd_net -net ports_ctrl_3_ena2 [get_bd_pins ports_ctrl_3/ena2] [get_bd_pins ro_probe_26/enable]
  connect_bd_net -net ports_ctrl_3_ena3 [get_bd_pins ports_ctrl_3/ena3] [get_bd_pins ro_probe_27/enable]
  connect_bd_net -net ports_ctrl_3_ena4 [get_bd_pins ports_ctrl_3/ena4] [get_bd_pins ro_probe_28/enable]
  connect_bd_net -net ports_ctrl_3_ena5 [get_bd_pins ports_ctrl_3/ena5] [get_bd_pins ro_probe_29/enable]
  connect_bd_net -net ports_ctrl_3_ena6 [get_bd_pins ports_ctrl_3/ena6] [get_bd_pins ro_probe_30/enable]
  connect_bd_net -net ports_ctrl_3_ena7 [get_bd_pins ports_ctrl_3/ena7] [get_bd_pins ro_probe_31/enable]
  connect_bd_net -net ports_ctrl_4_ena0 [get_bd_pins ports_ctrl_4/ena0] [get_bd_pins ro_probe_32/enable]
  connect_bd_net -net ports_ctrl_4_ena1 [get_bd_pins ports_ctrl_4/ena1] [get_bd_pins ro_probe_33/enable]
  connect_bd_net -net ports_ctrl_4_ena2 [get_bd_pins ports_ctrl_4/ena2] [get_bd_pins ro_probe_34/enable]
  connect_bd_net -net ports_ctrl_4_ena3 [get_bd_pins ports_ctrl_4/ena3] [get_bd_pins ro_probe_35/enable]
  connect_bd_net -net ports_ctrl_4_ena4 [get_bd_pins ports_ctrl_4/ena4] [get_bd_pins ro_probe_36/enable]
  connect_bd_net -net ports_ctrl_4_ena5 [get_bd_pins ports_ctrl_4/ena5] [get_bd_pins ro_probe_37/enable]
  connect_bd_net -net ports_ctrl_4_ena6 [get_bd_pins ports_ctrl_4/ena6] [get_bd_pins ro_probe_38/enable]
  connect_bd_net -net ports_ctrl_4_ena7 [get_bd_pins ports_ctrl_4/ena7] [get_bd_pins ro_probe_39/enable]
  connect_bd_net -net ports_ctrl_5_ena0 [get_bd_pins ports_ctrl_5/ena0] [get_bd_pins ro_probe_40/enable]
  connect_bd_net -net ports_ctrl_5_ena1 [get_bd_pins ports_ctrl_5/ena1] [get_bd_pins ro_probe_41/enable]
  connect_bd_net -net ports_ctrl_5_ena2 [get_bd_pins ports_ctrl_5/ena2] [get_bd_pins ro_probe_42/enable]
  connect_bd_net -net ports_ctrl_5_ena3 [get_bd_pins ports_ctrl_5/ena3] [get_bd_pins ro_probe_43/enable]
  connect_bd_net -net ports_ctrl_5_ena4 [get_bd_pins ports_ctrl_5/ena4] [get_bd_pins ro_probe_44/enable]
  connect_bd_net -net ports_ctrl_5_ena5 [get_bd_pins ports_ctrl_5/ena5] [get_bd_pins ro_probe_45/enable]
  connect_bd_net -net ports_ctrl_5_ena6 [get_bd_pins ports_ctrl_5/ena6] [get_bd_pins ro_probe_46/enable]
  connect_bd_net -net ports_ctrl_5_ena7 [get_bd_pins ports_ctrl_5/ena7] [get_bd_pins ro_probe_47/enable]
  connect_bd_net -net ports_ctrl_6_ena0 [get_bd_pins ports_ctrl_6/ena0] [get_bd_pins ro_probe_48/enable]
  connect_bd_net -net ports_ctrl_6_ena1 [get_bd_pins ports_ctrl_6/ena1] [get_bd_pins ro_probe_49/enable]
  connect_bd_net -net ports_ctrl_6_ena2 [get_bd_pins ports_ctrl_6/ena2] [get_bd_pins ro_probe_50/enable]
  connect_bd_net -net ports_ctrl_6_ena3 [get_bd_pins ports_ctrl_6/ena3] [get_bd_pins ro_probe_51/enable]
  connect_bd_net -net ports_ctrl_6_ena4 [get_bd_pins ports_ctrl_6/ena4] [get_bd_pins ro_probe_52/enable]
  connect_bd_net -net ports_ctrl_6_ena5 [get_bd_pins ports_ctrl_6/ena5] [get_bd_pins ro_probe_53/enable]
  connect_bd_net -net ports_ctrl_6_ena6 [get_bd_pins ports_ctrl_6/ena6] [get_bd_pins ro_probe_54/enable]
  connect_bd_net -net ports_ctrl_6_ena7 [get_bd_pins ports_ctrl_6/ena7] [get_bd_pins ro_probe_55/enable]
  connect_bd_net -net ports_ctrl_7_ena0 [get_bd_pins ports_ctrl_7/ena0] [get_bd_pins ro_probe_56/enable]
  connect_bd_net -net ports_ctrl_7_ena1 [get_bd_pins ports_ctrl_7/ena1] [get_bd_pins ro_probe_57/enable]
  connect_bd_net -net ports_ctrl_7_ena2 [get_bd_pins ports_ctrl_7/ena2] [get_bd_pins ro_probe_58/enable]
  connect_bd_net -net ports_ctrl_7_ena3 [get_bd_pins ports_ctrl_7/ena3] [get_bd_pins ro_probe_59/enable]
  connect_bd_net -net ports_ctrl_7_ena4 [get_bd_pins ports_ctrl_7/ena4] [get_bd_pins ro_probe_60/enable]
  connect_bd_net -net ports_ctrl_7_ena5 [get_bd_pins ports_ctrl_7/ena5] [get_bd_pins ro_probe_61/enable]
  connect_bd_net -net ports_ctrl_7_ena6 [get_bd_pins ports_ctrl_7/ena6] [get_bd_pins ro_probe_62/enable]
  connect_bd_net -net ports_ctrl_7_ena7 [get_bd_pins ports_ctrl_7/ena7] [get_bd_pins ro_probe_63/enable]
  connect_bd_net -net ports_ro_out_0_ro_out [get_bd_pins ports_ro_out_0/ro_out] [get_bd_pins ro_counter_0/ro_in]
  connect_bd_net -net ports_ro_out_1_ro_out [get_bd_pins ports_ro_out_1/ro_out] [get_bd_pins ro_counter_1/ro_in]
  connect_bd_net -net ports_ro_out_2_ro_out [get_bd_pins ports_ro_out_2/ro_out] [get_bd_pins ro_counter_2/ro_in]
  connect_bd_net -net ports_ro_out_3_ro_out [get_bd_pins ports_ro_out_3/ro_out] [get_bd_pins ro_counter_3/ro_in]
  connect_bd_net -net ports_ro_out_4_ro_out [get_bd_pins ports_ro_out_4/ro_out] [get_bd_pins ro_counter_4/ro_in]
  connect_bd_net -net ports_ro_out_5_ro_out [get_bd_pins ports_ro_out_5/ro_out] [get_bd_pins ro_counter_5/ro_in]
  connect_bd_net -net ports_ro_out_6_ro_out [get_bd_pins ports_ro_out_6/ro_out] [get_bd_pins ro_counter_6/ro_in]
  connect_bd_net -net ports_ro_out_7_ro_out [get_bd_pins ports_ro_out_7/ro_out] [get_bd_pins ro_counter_7/ro_in]
  connect_bd_net -net ro_counter_7_clk_count [get_bd_pins ro_counter_7/clk_count] [get_bd_pins ro_out_bram_0/ro_count_in]
  connect_bd_net -net ro_out_bram_0_addr [get_bd_pins blk_mem_gen_0/addrb] [get_bd_pins ro_out_bram_0/addr]
  connect_bd_net -net ro_out_bram_0_clkout [get_bd_pins blk_mem_gen_0/clkb] [get_bd_pins ro_out_bram_0/clkout]
  connect_bd_net -net ro_out_bram_0_led [get_bd_ports led] [get_bd_pins ro_out_bram_0/led]
  connect_bd_net -net ro_out_bram_0_ro_out [get_bd_pins blk_mem_gen_0/dinb] [get_bd_pins ro_out_bram_0/ro_out]
  connect_bd_net -net ro_out_bram_0_we [get_bd_pins blk_mem_gen_0/web] [get_bd_pins ro_out_bram_0/we]
  connect_bd_net -net ro_probe_0_out [get_bd_pins ports_ro_out_0/ro_in0] [get_bd_pins ro_probe_0/out]
  connect_bd_net -net ro_probe_10_out [get_bd_pins ports_ro_out_1/ro_in2] [get_bd_pins ro_probe_10/out]
  connect_bd_net -net ro_probe_11_out [get_bd_pins ports_ro_out_1/ro_in3] [get_bd_pins ro_probe_11/out]
  connect_bd_net -net ro_probe_12_out [get_bd_pins ports_ro_out_1/ro_in4] [get_bd_pins ro_probe_12/out]
  connect_bd_net -net ro_probe_13_out [get_bd_pins ports_ro_out_1/ro_in5] [get_bd_pins ro_probe_13/out]
  connect_bd_net -net ro_probe_14_out [get_bd_pins ports_ro_out_1/ro_in6] [get_bd_pins ro_probe_14/out]
  connect_bd_net -net ro_probe_15_out [get_bd_pins ports_ro_out_1/ro_in7] [get_bd_pins ro_probe_15/out]
  connect_bd_net -net ro_probe_16_out [get_bd_pins ports_ro_out_2/ro_in0] [get_bd_pins ro_probe_16/out]
  connect_bd_net -net ro_probe_17_out [get_bd_pins ports_ro_out_2/ro_in1] [get_bd_pins ro_probe_17/out]
  connect_bd_net -net ro_probe_18_out [get_bd_pins ports_ro_out_2/ro_in3] [get_bd_pins ro_probe_18/out]
  connect_bd_net -net ro_probe_19_out [get_bd_pins ports_ro_out_2/ro_in2] [get_bd_pins ro_probe_19/out]
  connect_bd_net -net ro_probe_1_out [get_bd_pins ports_ro_out_0/ro_in1] [get_bd_pins ro_probe_1/out]
  connect_bd_net -net ro_probe_20_out [get_bd_pins ports_ro_out_2/ro_in4] [get_bd_pins ro_probe_20/out]
  connect_bd_net -net ro_probe_21_out [get_bd_pins ports_ro_out_2/ro_in5] [get_bd_pins ro_probe_21/out]
  connect_bd_net -net ro_probe_22_out [get_bd_pins ports_ro_out_2/ro_in6] [get_bd_pins ro_probe_22/out]
  connect_bd_net -net ro_probe_23_out [get_bd_pins ports_ro_out_2/ro_in7] [get_bd_pins ro_probe_23/out]
  connect_bd_net -net ro_probe_24_out [get_bd_pins ports_ro_out_3/ro_in0] [get_bd_pins ro_probe_24/out]
  connect_bd_net -net ro_probe_25_out [get_bd_pins ports_ro_out_3/ro_in1] [get_bd_pins ro_probe_25/out]
  connect_bd_net -net ro_probe_26_out [get_bd_pins ports_ro_out_3/ro_in2] [get_bd_pins ro_probe_26/out]
  connect_bd_net -net ro_probe_27_out [get_bd_pins ports_ro_out_3/ro_in3] [get_bd_pins ro_probe_27/out]
  connect_bd_net -net ro_probe_28_out [get_bd_pins ports_ro_out_3/ro_in4] [get_bd_pins ro_probe_28/out]
  connect_bd_net -net ro_probe_29_out [get_bd_pins ports_ro_out_3/ro_in5] [get_bd_pins ro_probe_29/out]
  connect_bd_net -net ro_probe_2_out [get_bd_pins ports_ro_out_0/ro_in2] [get_bd_pins ro_probe_2/out]
  connect_bd_net -net ro_probe_30_out [get_bd_pins ports_ro_out_3/ro_in6] [get_bd_pins ro_probe_30/out]
  connect_bd_net -net ro_probe_31_out [get_bd_pins ports_ro_out_3/ro_in7] [get_bd_pins ro_probe_31/out]
  connect_bd_net -net ro_probe_32_out [get_bd_pins ports_ro_out_4/ro_in0] [get_bd_pins ro_probe_32/out]
  connect_bd_net -net ro_probe_33_out [get_bd_pins ports_ro_out_4/ro_in1] [get_bd_pins ro_probe_33/out]
  connect_bd_net -net ro_probe_34_out [get_bd_pins ports_ro_out_4/ro_in2] [get_bd_pins ro_probe_34/out]
  connect_bd_net -net ro_probe_35_out [get_bd_pins ports_ro_out_4/ro_in3] [get_bd_pins ro_probe_35/out]
  connect_bd_net -net ro_probe_36_out [get_bd_pins ports_ro_out_4/ro_in4] [get_bd_pins ro_probe_36/out]
  connect_bd_net -net ro_probe_37_out [get_bd_pins ports_ro_out_4/ro_in5] [get_bd_pins ro_probe_37/out]
  connect_bd_net -net ro_probe_38_out [get_bd_pins ports_ro_out_4/ro_in6] [get_bd_pins ro_probe_38/out]
  connect_bd_net -net ro_probe_39_out [get_bd_pins ports_ro_out_4/ro_in7] [get_bd_pins ro_probe_39/out]
  connect_bd_net -net ro_probe_3_out [get_bd_pins ports_ro_out_0/ro_in3] [get_bd_pins ro_probe_3/out]
  connect_bd_net -net ro_probe_40_out [get_bd_pins ports_ro_out_5/ro_in0] [get_bd_pins ro_probe_40/out]
  connect_bd_net -net ro_probe_41_out [get_bd_pins ports_ro_out_5/ro_in1] [get_bd_pins ro_probe_41/out]
  connect_bd_net -net ro_probe_42_out [get_bd_pins ports_ro_out_5/ro_in2] [get_bd_pins ro_probe_42/out]
  connect_bd_net -net ro_probe_43_out [get_bd_pins ports_ro_out_5/ro_in3] [get_bd_pins ro_probe_43/out]
  connect_bd_net -net ro_probe_44_out [get_bd_pins ports_ro_out_5/ro_in4] [get_bd_pins ro_probe_44/out]
  connect_bd_net -net ro_probe_45_out [get_bd_pins ports_ro_out_5/ro_in5] [get_bd_pins ro_probe_45/out]
  connect_bd_net -net ro_probe_46_out [get_bd_pins ports_ro_out_5/ro_in6] [get_bd_pins ro_probe_46/out]
  connect_bd_net -net ro_probe_47_out [get_bd_pins ports_ro_out_5/ro_in7] [get_bd_pins ro_probe_47/out]
  connect_bd_net -net ro_probe_48_out [get_bd_pins ports_ro_out_6/ro_in0] [get_bd_pins ro_probe_48/out]
  connect_bd_net -net ro_probe_49_out [get_bd_pins ports_ro_out_6/ro_in1] [get_bd_pins ro_probe_49/out]
  connect_bd_net -net ro_probe_4_out [get_bd_pins ports_ro_out_0/ro_in4] [get_bd_pins ro_probe_4/out]
  connect_bd_net -net ro_probe_50_out [get_bd_pins ports_ro_out_6/ro_in2] [get_bd_pins ro_probe_50/out]
  connect_bd_net -net ro_probe_51_out [get_bd_pins ports_ro_out_6/ro_in3] [get_bd_pins ro_probe_51/out]
  connect_bd_net -net ro_probe_52_out [get_bd_pins ports_ro_out_6/ro_in4] [get_bd_pins ro_probe_52/out]
  connect_bd_net -net ro_probe_53_out [get_bd_pins ports_ro_out_6/ro_in5] [get_bd_pins ro_probe_53/out]
  connect_bd_net -net ro_probe_54_out [get_bd_pins ports_ro_out_6/ro_in6] [get_bd_pins ro_probe_54/out]
  connect_bd_net -net ro_probe_55_out [get_bd_pins ports_ro_out_6/ro_in7] [get_bd_pins ro_probe_55/out]
  connect_bd_net -net ro_probe_56_out [get_bd_pins ports_ro_out_7/ro_in0] [get_bd_pins ro_probe_56/out]
  connect_bd_net -net ro_probe_57_out [get_bd_pins ports_ro_out_7/ro_in1] [get_bd_pins ro_probe_57/out]
  connect_bd_net -net ro_probe_58_out [get_bd_pins ports_ro_out_7/ro_in2] [get_bd_pins ro_probe_58/out]
  connect_bd_net -net ro_probe_59_out [get_bd_pins ports_ro_out_7/ro_in3] [get_bd_pins ro_probe_59/out]
  connect_bd_net -net ro_probe_5_out [get_bd_pins ports_ro_out_0/ro_in5] [get_bd_pins ro_probe_5/out]
  connect_bd_net -net ro_probe_60_out [get_bd_pins ports_ro_out_7/ro_in4] [get_bd_pins ro_probe_60/out]
  connect_bd_net -net ro_probe_61_out [get_bd_pins ports_ro_out_7/ro_in5] [get_bd_pins ro_probe_61/out]
  connect_bd_net -net ro_probe_62_out [get_bd_pins ports_ro_out_7/ro_in6] [get_bd_pins ro_probe_62/out]
  connect_bd_net -net ro_probe_63_out [get_bd_pins ports_ro_out_7/ro_in7] [get_bd_pins ro_probe_63/out]
  connect_bd_net -net ro_probe_6_out [get_bd_pins ports_ro_out_0/ro_in6] [get_bd_pins ro_probe_6/out]
  connect_bd_net -net ro_probe_7_out [get_bd_pins ports_ro_out_0/ro_in7] [get_bd_pins ro_probe_7/out]
  connect_bd_net -net ro_probe_8_out [get_bd_pins ports_ro_out_1/ro_in0] [get_bd_pins ro_probe_8/out]
  connect_bd_net -net ro_probe_9_out [get_bd_pins ports_ro_out_1/ro_in1] [get_bd_pins ro_probe_9/out]

  # Create address segments


  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


common::send_msg_id "BD_TCL-1000" "WARNING" "This Tcl script was generated from a block design that has not been validated. It is possible that design <$design_name> may result in errors during validation."

