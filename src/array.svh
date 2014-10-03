`ifndef __ARRAY_SVH__
`define __ARRAY_SVH__
class array#(type T_VALUE = int) extends container#(int, T_VALUE);
  typedef class iterator;

  protected T_VALUE values[$];

  function new();
  endfunction

  virtual function void set(int index, T_VALUE value);
    if (index < size()) begin
      values[index] = value;
    end
    else begin
      for (int i = size();i < index;i++) begin
        values.push_back(default_value);
      end
      values.push_back(value);
    end
  endfunction

  virtual function T_VALUE get(int index);
    if (index < size()) begin
      return values[index];
    end
    else begin
      return default_value;
    end
  endfunction

  virtual function void push_front(T_VALUE value);
    values.push_front(value);
  endfunction

  virtual function void push_back(T_VALUE value);
    values.push_back(value);
  endfunction

  virtual function T_VALUE pop_front();
    return values.pop_front();
  endfunction

  virtual function T_VALUE pop_back();
    return values.pop_back();
  endfunction

  virtual function int size();
    return values.size();
  endfunction

  virtual function void clear();
    values.delete();
  endfunction

  class iterator extends base_iterator#(int, T_VALUE);
    protected int             _current_index;
    protected array#(T_VALUE) _array;

    function new(array#(T_VALUE) array, bit forward_iteration);
      super.new(forward_iteration);
      _array          = array;
      _current_index  = (forward_iteration) ? 0 : array.size() - 1;
    endfunction

    virtual function T_VALUE get();
      return _array.get(_current_index);
    endfunction

    virtual function void set(T_VALUE value);
      _array.set(_current_index, value);
    endfunction

    virtual function int index();
      return _current_index;
    endfunction

    virtual function bit next();
      if (!is_end()) begin
        if (forward_iteration) begin
          _current_index++;
        end
        else begin
          _current_index--;
        end
        return 1;
      end
      else begin
        return 0;
      end
    endfunction

    virtual function bit is_end();
      if (forward_iteration) begin
        return (_current_index >= _array.size()) ? 1 : 0;
      end
      else begin
        return (_current_index < 0) ? 1 : 0;
      end
    endfunction
  endclass

  `define_iterator_getters
endclass
`endif
