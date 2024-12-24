# UART Verification in UVM

 The uart_top is verified under different testcases with a uvm testbench environment. 

------------------------------------------------------------------
Name                       Type                        Size  Value
------------------------------------------------------------------
 uvm_test_top               tx_write_rx_read_test       -     @479 
   envh                     uart_tb                     -     @495 
     rx_agth                rx_agent                    -     @514 
     drvh                 rx_driver                   -     @549 
        rsp_port           uvm_analysis_port           -     @564 
         seq_item_port      uvm_seq_item_pull_port      -     @556 
       monh                 rx_monitor                  -     @534 
         monitor_port       uvm_analysis_port           -     @541 
       seqrh                rx_sequencer                -     @572 
         rsp_export         uvm_analysis_export         -     @579 
         seq_item_export    uvm_seq_item_pull_imp       -     @673 
         arbitration_queue  array                       0     -    
         lock_queue         array                       0     -    
         num_last_reqs      integral                    32    'd1  
         num_last_rsps      integral                    32    'd1  
     sb_h                   uart_sb                     -     @525 
       rx_fifo              uvm_tlm_analysis_fifo #(T)  -     @735 
         analysis_export    uvm_analysis_imp            -     @774 
         get_ap             uvm_analysis_port           -     @766 
        get_peek_export    uvm_get_peek_imp            -     @750 
        put_ap             uvm_analysis_port           -     @758 
        put_export         uvm_put_imp                 -     @742 
       tx_fifo              uvm_tlm_analysis_fifo #(T)  -     @688 
         analysis_export    uvm_analysis_imp            -     @727 
         get_ap             uvm_analysis_port           -     @719 
         get_peek_export    uvm_get_peek_imp            -     @703 
         put_ap             uvm_analysis_port           -     @711 
         put_export         uvm_put_imp                 -     @695 
     tx_agth                tx_agent                    -     @503 
       drvh                 tx_driver                   -     @799 
         rsp_port           uvm_analysis_port           -     @814 
         seq_item_port      uvm_seq_item_pull_port      -     @806 
       monh                 tx_monitor                  -     @784 
         monitor_port       uvm_analysis_port           -     @791 
       seqrh                tx_sequencer                -     @822 
         rsp_export         uvm_analysis_export         -     @829 
         seq_item_export    uvm_seq_item_pull_imp       -     @923 
         arbitration_queue  array                       0     -    
         lock_queue         array                       0     -    
         num_last_reqs      integral                    32    'd1  
         num_last_rsps      integral                    32    'd1  
 ------------------------------------------------------------------
