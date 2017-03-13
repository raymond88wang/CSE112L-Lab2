module ram(
	input logic clk ,
	input logic we ,
	input logic [3:0] be , // Byte - enable
	input logic [31:0] addr ,
	input logic [31:0] dataI ,
	output logic [31:0] dataO);
	
	logic [31:0] RAM[63:0];
	logic [31:0] dataInMem;
	
	always_comb
		begin
			if(~we)
				begin
					case(be)
						4'b0001:
							// LDRB
							begin
								case(addr[1:0])
									2'b00:
										begin
											dataO = {{24{1'b0}}, dataO[7:0]};
										end
									2'b01:
										begin
											dataO = {{24{1'b0}}, dataO[15:8]};
										end
									2'b10:
										begin
											dataO = {{24{1'b0}}, dataO[23:16]};
										end
									2'b11:
										begin
											dataO = {{24{1'b0}}, dataO[31:24]};
										end
								endcase
							end
						4'b0010:
							// LDRH
							begin
								case(addr[1:0])
									2'b00:
										begin
											dataO = {{24{1'b0}}, dataO[15:0]};
										end
									2'b01:
										begin
											dataO = {{24{1'b0}}, dataO[31:16]};
										end
								endcase
							end
						4'b0100:
							// LDRSB
							begin
								case(addr[1:0])
									2'b00:
										begin
											dataO = dataO[7] ? {{24{1'b1}}, dataO[7:0]} : {{24{1'b0}}, dataO[7:0]};
										end
									2'b01:
										begin
											dataO = dataO[15] ? {{24{1'b1}}, dataO[15:8]} : {{24{1'b0}}, dataO[15:8]};
										end
									2'b10:
										begin
											dataO = dataO[23] ? {{24{1'b1}}, dataO[23:16]} : {{24{1'b0}}, dataO[23:16]};
										end
									2'b11:
										begin
											dataO = dataO[31] ? {{24{1'b1}}, dataO[31:24]} : {{24{1'b0}}, dataO[31:24]};
										end
								endcase
							end
						4'b1000:
							// LDRSH
							begin
								case(addr[1:0])
									2'b00:
										begin
											dataO = dataO[15] ? {{16{1'b1}}, dataO[15:0]} : {{16{1'b0}}, dataO[15:0]};
										end
									2'b01:
										begin
											dataO = dataO[31] ? {{16{1'b1}}, dataO[31:16]} : {{16{1'b0}}, dataO[31:16]};
										end
								endcase
							end
						default: dataO = RAM[addr[31:2]];
					endcase
				end
		end
			
	always_ff @(posedge clk)
        if (we) 
			begin
				dataInMem <= RAM[addr[31:2]];
				case(be)
					4'b0001:
						begin
							RAM[addr[31:2]] <= {dataInMem[31:8], dataI[7:0]};
						end
					4'b0011:
						begin
							RAM[addr[31:2]] <= {dataInMem[31:16], dataI[15:0]};
						end
				endcase
			end
endmodule