`ifndef __BASE_ITERATOR_SVH__
`define __BASE_ITERATOR_SVH__
virtual class base_iterator#(type T_INDEX = int, type T_VALUE);
  protected bit forward_iteration;

  function new(bit forward_iteration);
    this.forward_iteration  = forward_iteration;
  endfunction

  pure virtual function T_VALUE get();
  pure virtual function void set(T_VALUE value);

  pure virtual function T_INDEX index();

  pure virtual function bit next();
  pure virtual function bit is_end();
endclass
`endif
