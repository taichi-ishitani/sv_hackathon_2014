`ifndef __CONTAINER_SVH__
`define __CONTAINER_SVH__
virtual class container#(type T_INDEX = int, type T_VALUE = int);
  protected T_VALUE default_value;

  virtual function void set_default_value(T_VALUE value);
    this.default_value  = value;
  endfunction

  pure virtual function int size();

  virtual function bit is_empty();
    return (size() == 0) ? 1 : 0;
  endfunction

  pure virtual function void clear();

  virtual function base_iterator#(T_INDEX, T_VALUE) get_iterator();
  virtual function base_iterator#(T_INDEX, T_VALUE) get_riterator();
endclass
`endif
