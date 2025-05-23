# Copyright lowRISC contributors (OpenTitan project).
# Licensed under the Apache License, Version 2.0, see LICENSE for details.
# SPDX-License-Identifier: Apache-2.0
#
# waiver file for Ibex core

waive -rules EXPLICIT_BITLEN      -location {ibex_top.sv} -regexp {Bit length not specified for constant .*h2} ${"\\"}
      -comment "better way to write it?"
waive -rules HIER_BRANCH_NOT_READ -location {ibex_decoder.sv} -regexp {Net 'instr_rdata_i.*is not read from in module} ${"\\"}
      -comment "not all bits are used"
waive -rules INPUT_NOT_READ       -location {ibex_decoder.sv} -regexp {Input port 'instr_rdata_i.*is not read from in module} ${"\\"}
      -comment "not all bits are used"
waive -rules HIER_BRANCH_NOT_READ -location {ibex_id_stage.sv} -regexp {[nN]et 'test_en_i' .* is not read from} ${"\\"}
      -comment "testability signal used in some versions of register file"
waive -rules INPUT_NOT_READ       -location {ibex_register_file_ff.sv} -regexp {Input port 'test_en_i' is not read from} ${"\\"}
      -comment "testability signal used in some versions of register file"
waive -rules INPUT_NOT_READ       -location {ibex_register_file_fpga.sv} -regexp {Input port 'test_en_i' is not read from} ${"\\"}
      -comment "testability signal used in some versions of register file"
waive -rules INPUT_NOT_READ       -location {ibex_top.sv} -regexp {Input port 'clock_en_i' is not read from} ${"\\"}
      -comment "clock enable signal used in behavioral code"
waive -rules HIER_NET_NOT_READ    -location {${module_instance_name}.sv} -regexp {Net 'instr_addr_o.1.0.' is not read from} ${"\\"}
      -comment "Bottom bits not needed, cleaner to keep them as inputs"
waive -rules NOT_READ             -location {${module_instance_name}.sv} -regexp {Signal 'instr_addr_o.1.0.' is not read from} ${"\\"}
      -comment "Bottom bits not needed, cleaner to keep them as inputs"
waive -rules HIER_NET_NOT_READ    -location {${module_instance_name}.sv} -regexp {Net 'data_addr_o.1.0.' is not read from} ${"\\"}
      -comment "Bottom bits not needed, cleaner to keep them as inputs"
waive -rules NOT_READ             -location {${module_instance_name}.sv} -regexp {Signal 'data_addr_o.1.0.' is not read from} ${"\\"}
      -comment "Bottom bits not needed, cleaner to keep them as inputs"
waive -rules HIER_NET_NOT_READ    -location {ibex_ex_block.sv} -regexp {Net 'alu_adder_result_ext.0.' .* is not read from} ${"\\"}
      -comment "Bottom bit is round, not needed"
waive -rules HIER_NET_NOT_READ    -location {ibex_ex_block.sv} -regexp {Connected net 'alu_adder_ext_i.0.' .* is not read from} ${"\\"}
      -comment "Bottom bit is round, not needed"
waive -rules HIER_NET_NOT_READ    -location {ibex_top.sv} -regexp {[nN]et 'boot_addr_i.7:0.' .* is not read from} ${"\\"}
      -comment "Boot address is 256B aligned, cleaner to pass all bits in"
waive -rules {INPUT_NOT_READ HIER_BRANCH_NOT_READ} -location {ibex_if_stage.sv} -regexp {'boot_addr_i.7:0.' is not read from} ${"\\"}
      -comment "Boot address is 256B aligned, cleaner to pass all bits in"
waive -rules HIER_NET_NOT_READ    -location {ibex_ex_block.sv} -regexp {[nN]et 'alu_adder.*0' is not read from} ${"\\"}
      -comment "LSB is not needed here, shifting off before using"
waive -rules INPUT_NOT_READ       -location {ibex_multdiv_fast.sv} -regexp {Input port 'alu_adder_ext_i.0.' is not read from} ${"\\"}
      -comment "LSB is not needed here, shifting off before using"
waive -rules HIER_NET_NOT_READ    -location {${module_instance_name}.sv} -regexp {Net 'tl_._fifo2ibex.d_(error|opcode|param|sink|size|source|user).*' is not read} ${"\\"}
      -comment "Not all bits of instruction response needed"
waive -rules NOT_READ             -location {${module_instance_name}.sv} -regexp {Signal 'tl_._fifo2ibex.d_(error|opcode|param|sink|size|source|user).*' is not read} ${"\\"}
      -comment "Not all bits of instruction response needed"
waive -rules NOT_READ             -location {ibex_if_stage.sv} -regexp {Signal 'fetch_addr_n.0.' is not read from} ${"\\"}
      -comment "cleaner to write all bits even if not all are used"
waive -rules NOT_READ             -location {ibex_multdiv_fast.sv} -regexp {Signal 'mac_res_ext.34.' is not read from} ${"\\"}
      -comment "cleaner to write all bits even if not all are used"
waive -rules NOT_READ             -location {ibex_multdiv_fast.sv} -regexp {Signal 'res_adder_h.32.' is not read from} ${"\\"}
      -comment "cleaner to write all bits even if not all are used"
waive -rules MULTIPLY             -location {ibex_multdiv_fast.sv} -regexp {Multiply operation.*encountered} ${"\\"}
      -comment "got to pay the price for the multiplier"
waive -rules CONST_OUTPUT         -location {${module_instance_name}.sv} -regexp {Output 'tl_(i|d)_o..*' is driven by constant} ${"\\"}
      -comment "not all bus constructs are used"
waive -rules SIGNED_RANGE         -location {ibex_controller.sv} -msg {Part select of signed signal 'i[3:0]' encountered} ${"\\"}
      -comment "switching the loop variable i to unsigned would require loop restructuring to not change interrupt priorities, making the code less readable"
waive -rules SIGNED_RANGE         -location {ibex_cs_registers.sv} -regexp {Part select of signed signal 'i\[11:0\]' encountered} ${"\\"}
      -comment "'i' is the loop variable of a genvar loop running from 0 to 'PMPNumRegions' which is an unsigned integer number. There is no issue with the part select."
waive -rules SIGNED_RANGE         -location {ibex_cs_registers.sv} -regexp {Part select of signed signal 'i\[DbgHwNumLen ${"\\"}- 1:0\]' encountered} ${"\\"}
      -comment "'i' is the loop variable of a genvar loop running from 0 to 'DbgHwBreakNum' which is an unsigned integer number. There is no issue with the part select."
waive -rules SIGNED_RANGE         -location {ibex_icache.sv} -regexp {Part select of signed signal 'b\[IC_LINE_BEATS_W ${"\\"}- 1:0\]' encountered} ${"\\"}
      -comment "'b' is the loop variable of a genvar loop running from 0 to 'IC_LINE_BEATS' which is an unsigned integer number. There is no issue with the part select."
waive -rules CONST_OUTPUT         -location {ibex_controller.sv} -regexp {Output 'exc_cause_o.5.' is driven by constant} ${"\\"}
      -comment "easier to write with enum, not all causes used yet"
waive -rules CONST_OUTPUT         -location {ibex_decoder.sv} -regexp {Output 'data_reg_offset_o' is driven by constant} ${"\\"}
      -comment "fixed register offset"
waive -rules CONST_OUTPUT         -location {ibex_decoder.sv} -regexp {Output 'alu_op_._mux_sel_o.*' is driven by constant} ${"\\"}
      -comment "not all possible mux select values are used in enum"
waive -rules CONST_OUTPUT         -location {ibex_multdiv_fast.sv} -regexp {Output 'alu_operand_._o.0.' is driven by constant} ${"\\"}
      -comment "bottom bit set to 1 for rounding"
waive -rules VAR_INDEX            -location {ibex_multdiv_fast.sv} -regexp {Variable index expression 'op_numerator_q.div_counter_n.' encountered} ${"\\"}
      -comment "TODO: discuss: I don't think this is a problem"
waive -rules VAR_INDEX            -location {ibex_register_file_ff.sv} -regexp {Variable index expression 'rf_reg.raddr_._i.' encountered} ${"\\"}
      -comment "TODO: discuss: I don't think this is a problem"
waive -rules NOT_READ             -location {ibex_cs_registers.sv} -regexp {Signal 'pccr_index' is not read from} ${"\\"}
      -comment "Used in non synthesis scenario"
waive -rules NOT_READ             -location {ibex_cs_registers.sv} -regexp {Signal 'pccr_all_sel' is not read from} ${"\\"}
      -comment "Used in non synthesis scenario"
waive -rules NOT_USED             -location {ibex_cs_registers.sv} -regexp {Signal 'PCCR_inc.*11.1.' is not used} ${"\\"}
      -comment "Used in non synthesis scenario"
waive -rules NOT_READ             -location {ibex_alu.sv} -regexp {Signal 'shift_right_result_ext.32.' is not read from} ${"\\"}
      -comment "As mentioned in the RTL, MSB of shift_right_result_ext can be safely ignored"
waive -rules NOT_READ             -location {ibex_id_stage.sv} -regexp {Signal 'operand_b_fw_id' is not read from in module 'ibex_id_stage'} ${"\\"}
      -comment "This signal is actually used (not via a port but through hierarchical path) in ibex_top.sv"
waive -rules INTEGER              -location {ibex_register_file_ff.sv ${module_instance_name}.sv} -msg {'i' of type int used as a non-constant value} ${"\\"}
      -comment "This assigns int i (signed) to a multibit logic variable (unsigned), which is fine"
waive -rules ONE_BIT_MEM_WIDTH             -location {ibex_core.sv} -regexp {Memory 'pmp_req_err' has word width which is single bit wide} ${"\\"}
      -comment "For consistency with related signals, we use an unpacked array for this signal."
waive -rules HIER_BRANCH_NOT_READ -location {ibex_branch_predict.sv ibex_decoder.sv ibex_compressed_decoder.sv} -regexp {Net '(clk_i|rst_ni)' is not read from in module '(ibex_branch_predict|ibex_decoder|ibex_compressed_decoder)'.*} ${"\\"}
      -comment "These signals are only used for assertions inside these three modules"
waive -rules INPUT_NOT_READ -location {ibex_branch_predict.sv ibex_decoder.sv ibex_compressed_decoder.sv} -regexp {Input port '(clk_i|rst_ni)' is not read from in module '(ibex_branch_predict|ibex_decoder|ibex_compressed_decoder)'.*} ${"\\"}
      -comment "These signals are only used for assertions inside these two modules"
waive -rules IFDEF_CODE -location {ibex_core.sv} -regexp {Assignment to 'unused_instr_new_id' contained within `else block} ${"\\"}
      -comment "Declaration of signal and assignment to it are in same `else block"
waive -rules IFDEF_CODE -location {ibex_core.sv} -regexp {Assignment to 'unused_instr_id_done' contained within `else block} ${"\\"}
      -comment "Declaration of signal and assignment to it are in same `else block"
waive -rules IFDEF_CODE -location {ibex_core.sv} -regexp {Assignment to 'unused_instr_done_wb' contained within `else block} ${"\\"}
      -comment "Declaration of signal and assignment to it are in same `else block"
waive -rules IFDEF_CODE -location {${module_instance_name}.sv} -regexp {Assignment to 'tl_win_d2h' contained within `else block} ${"\\"}
      -comment "DV environment will drive things when `else block isn't used so assignment only occurs in `else block"
waive -rules IFDEF_CODE -location {ibex_multdiv_fast.sv} -regexp {Assignment to 'unused_sva_mul_fsm_idle' contained within `else block at ibex_multdiv_fast.sv} ${"\\"}
      -comment "Declaration of signal and assignment to it are in same `else block"
waive -rules CLOCK_USE -location {ibex_id_stage.sv} -regexp {'clk_i' is connected to 'ibex_decoder' port 'clk_i'} ${"\\"}
      -comment "clk_i is unused in ibex_decoder configurations without RV32B and isn't connected to logic"
waive -rules RESET_USE -location {ibex_id_stage.sv} -regexp {'rst_ni' is connected to 'ibex_decoder' port 'rst_ni'} ${"\\"}
      -comment "rst_ni is unused in ibex_decoder configurations without RV32B and isn't connected to logic"
waive -rules {ZERO_REP} -location {ibex_icache.sv} -regexp {Replication count is zero in '{22 - IC_TAG_SIZE{1'b0}}'} ${"\\"}
      -comment "if IC_TAG_SIZE=22, no padding is needed"
waive -rules {ZERO_REP} -location {ibex_icache.sv} -regexp {Replication count is zero in '{IC_LINE_BEATS_W - 1{1'b0}}'} ${"\\"}
      -comment "if IC_LINE_BEATS=2, IC_LINE_BEATS_W=1 and no padding is needed"
waive -rules {ARITH_CONTEXT} -location {ibex_icache.sv} -msg {Bitlength of arithmetic operation '(output_addr_q[IC_LINE_W - 1:BUS_W] + {{IC_LINE_BEATS_W - 1{1'b0}},skid_valid_q})' is self-determined in this context} ${"\\"}
      -comment "The bitlengths are determined but the zero replication count (IC_LINE_BEATS_W=1) seems to confuse the tool"
waive -rules MIXED_SIGN           -location {ibex_lockstep.sv} -regexp {Unsigned operand 'rst_shadow_cnt_q' and signed 'LockstepOffsetW'(1)' encountered in a binary expression} ${"\\"}
      -comment "In line with our style guide, LockstepOffsetW'(1) results in a signed operand"
waive -rules UNSIZED_BIT_CONTEXT  -location {ibex_lockstep.sv} -regexp {Bitlength of unsized bit literal "'0" is self determined in this context} ${"\\"}
      -comment {In line with our style guide, writing this as {$bits(delayed_inputs_t){1'b0}} would be much less readable}
waive -rules CONST_FF             -location {ibex_icache.sv} -regexp {Flip-flop 'reset_inval_q' is driven by constant one} ${"\\"}
      -comment "The only purpose of the flop is to initiate the cache invalidation after reset"
waive -rules RESET_DRIVER         -location {ibex_lockstep.sv} -regexp {'(rst_shadow_set_q|rst_shadow_n)' is driven here, and used as an asynchronous reset 'rst_ni' at}
      -comment "A synchronous counter is needed to release the shadow core reset with a delay of LockstepOffset clock cycles"
waive -rules RESET_DRIVER         -location {ibex_lockstep.sv} -regexp {'(rst_shadow_set_q|rst_shadow_n)' driven in module 'ibex_lockstep'}
      -comment "A synchronous counter is needed to release the shadow core reset with a delay of LockstepOffset clock cycles"
waive -rules RESET_DRIVER         -location {ibex_lockstep.sv} -regexp {'rst_shadow_set_q\[0\]' is driven by instance 'u_prim_rst_shadow_set_flop' of module 'prim_flop', and used as an asynchronous reset 'rst_ni' at}
      -comment "A synchronous counter is needed to release the shadow core reset with a delay of LockstepOffset clock cycles"
waive -rules RESET_DRIVER         -location {ibex_lockstep.sv} -regexp {'q_o\[0\]' is driven in module '(prim_flop|prim_generic_flop)'}
      -comment "A synchronous counter is needed to release the shadow core reset with a delay of LockstepOffset clock cycles"
waive -rules RESET_MUX            -location {ibex_lockstep.sv} -regexp {Asynchronous reset 'rst_shadow_n' is driven by a multiplexer here}
      -comment "The test enable input used to control the bypass can be considered static"
waive -rules RESET_USE            -location {ibex_lockstep.sv} -regexp {'rst_shadow_set_q' is used for some other purpose, and as asynchronous reset 'rst_ni' at}
      -comment "A synchronous counter is needed to release the shadow core reset with a delay of LockstepOffset clock cycles and start the comparison logic one clock cycle later"
waive -rules RESET_USE            -location {ibex_lockstep.sv} -regexp {'enable_cmp_d\[0\]' is connected to 'prim_flop' port 'd_i\[0\]', and used as an asynchronous reset or set 'rst_ni' at}
      -comment "enable_cmp_d[0] is assigned to rst_shadow_set_q[0] which is drive by a synchronous counter which is needed to release the shadow core reset with a delay of LockstepOffset clock cycles"
waive -rules {CLOCK_USE RESET_USE} -location {ibex_register_file_ff.sv} ${"\\"}
      -regexp {'(clk_i|rst_ni)' is connected to '(prim_onehot_mux)' port} ${"\\"}
      -comment {The module is fully combinatorial, clk/rst are only used for assertions.}

# Highlighting my main concerns here, documenting areas to review in next dive
#
# data_err_i is not used in load/store unit beyond assertions; this signal is
# true when bus requests return in error. What is the right way to handle?
#
# lsu_load_err/lsu_store_err: similar above, except that the condition is
# tied to false in ibex_load_store_unit and is unused in ID stage. Dead
# code that should be removed? Or is this an indication of missing error
# handling logic?
#
# output signal out_valid_stored_o from ibex_fetch_fifo is not used. Dead
# code or indicating a bigger problem?
