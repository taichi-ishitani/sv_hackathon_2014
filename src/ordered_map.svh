`ifndef __ORDERED_MAP_SVH__
`define __ORDERED_MAP_SVH__
class ordered_map#(type T_KEY = int, type T_VALUE = int) extends container#(T_KEY, T_VALUE);
  typedef class iterator;

  protected T_KEY   key_list[$];
  protected T_VALUE values[T_KEY];

  function new();
  endfunction

  virtual function void store(T_KEY key, T_VALUE value);
      if (!has_key(key)) begin
        key_list.push_back(key);
      end
      values[key] = value;
  endfunction

  virtual function T_VALUE fetch(T_KEY key);
    if (has_key(key)) begin
      return values[key];
    end
    else begin
      return default_value;
    end
  endfunction

  virtual function int size();
    return values.size();
  endfunction

  virtual function void clear();
    values.delete();
    key_list.delete();
  endfunction

  virtual function bit has_key(T_KEY key);
    return values.exists(key);
  endfunction

  class iterator extends base_iterator#(T_KEY, T_VALUE);
    protected int                           _current_index;
    protected ordered_map#(T_KEY, T_VALUE)  _map;

    function new(ordered_map#(T_KEY, T_VALUE) map, bit forward_iteration);
      super.new(forward_iteration);
      _map            = map;
      _current_index  = (forward_iteration) ? 0 : map.size() - 1;
    endfunction

    virtual function T_VALUE get();
      return _map.fetch(index());
    endfunction

    virtual function void set(T_VALUE value);
      if (!is_end()) begin
        _map.store(index(), value);
      end
    endfunction

    virtual function T_KEY index();
      T_KEY key;
      if (!is_end()) begin
        key = _map.key_list[_current_index];
      end
      return key;
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
        return (_current_index >= _map.size()) ? 1 : 0;
      end
      else begin
        return (_current_index < 0) ? 1 : 0;
      end
    endfunction
  endclass

  `define_iterator_getters
endclass
`endif
