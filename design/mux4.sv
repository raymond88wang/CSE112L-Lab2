module mux4 
    #(parameter WIDTH = 8)
    (input logic [WIDTH-1:0] d0, d1, d2, d3,
    input logic [3:0] s,
    output logic [WIDTH-1:0] y);

	
	case (s)
		4'b0000:
			begin
				assign y = d0;
			end
		4'b0000:
			begin
				assign y = d1;
			end
		4'b0000:
			begin
				assign y = d2;
			end
		4'b0000:
			begin
				assign y = d3;
			end
endmodule
