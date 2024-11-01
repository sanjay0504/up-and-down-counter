module up_down_counter(
    input button_up,
    input button_down,
    input button_reset,
    input clk,
    output [6:0] hex4,
    output [6:0] hex5
    );
    
    reg [7:0] count;
	 reg last_button_up,last_button_down;
    wire [3:0] tens,ones;
    
    always@(posedge clk)begin
        if(!button_reset)
            count <= 8'd0;
        else begin
			if(button_up && !last_button_up) begin
            if(count == 8'd99)
                count <= 8'd0;
            else
                count <= count + 1;
        end
        else if(button_down && !last_button_down)begin
            if(count == 8'd0)
                count <= 8'd99;
            else
                count <= count - 1;
			end
		end
		
		last_button_up <= button_up;
		last_button_down <= button_down;
	 end
    
    assign tens = count / 10;
    assign ones = count % 10;
	 
	 hex_decoder ones_place(.digit(ones), .segment(hex4));
	 hex_decoder tens_place(.digit(tens), .segment(hex5));
    
endmodule
