`ifndef __CONTAINER_UTILITY_MACROS_SVH__
`define __CONTAINER_UTILITY_MACROS_SVH__
`define define_iterator_getters \
virtual function iterator get_iterator(); \
  iterator  itr = new(this, 1); \
  return itr; \
endfunction \
 \
virtual function iterator get_riterator(); \
  iterator  itr = new(this, 0); \
  return itr; \
endfunction

`endif
