module top();
  import  container_pkg::*;

  array#(string)            test_array;
  ordered_map#(string, int) test_map;
  int                       int_queue;
  int temp;

  initial begin
    test_array  = new();
    test_array.set(0, "A");
    test_array.set(2, "B");
    `for_each(array#(string), test_array,
      begin
        $display("%s", itr.get());
      end
    )
    for (array#(string)::iterator itr = test_array.get_riterator();!itr.is_end();temp = itr.next()) begin
      $display("%s", itr.get());
    end

    test_map  = new();
    test_map.store("A", 0);
    test_map.store("B", 1);
    test_map.store("C", 2);
    test_map.store("D", 3);
    `for_each(ordered_map#(string, int), test_map,
      begin
        $display("%0d", itr.get());
      end
    )
    `select(ordered_map#(string, int), test_map, int_queue,
      (itr.index() inside {"A", "C"})
    )
    foreach (int_queue[i]) begin
      $display("%0d", int_queue[i]);
    end
    $finish;
  end
endmodule
