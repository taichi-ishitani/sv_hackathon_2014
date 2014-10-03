`ifndef __CONTAINER_MANIPULATION_MACROS_SVH__
`define __CONTAINER_MANIPULATION_MACROS_SVH__
`define for_each(container_type, container_handle, block, iterator_name = itr) \
begin \
  bit                                     dummy; \
  container_pkg::container_type::iterator iterator_name; \
  for (iterator_name = container_handle.get_iterator();!iterator_name.is_end();dummy = iterator_name.next()) begin \
    block \
  end \
end

`define select(container_type, container_handle, output_queue, expression, iterator_name = itr) \
begin \
  bit                                     dummy; \
  container_pkg::container_type::iterator iterator_name; \
\
  output_queue.delete(); \
  for (iterator_name = container_handle.get_iterator();!iterator_name.is_end();dummy = iterator_name.next()) begin \
    if (expression) begin \
      output_queue.push_back(iterator_name.get()); \
    end \
  end \
end
`endif
