`timescale 1 ns/1 ps
module tb_aes;
reg [127:0] state;
reg [127:0] key;
wire [127:0] out;
reg clk;
reg [127:0]test_key;
reg [127:0]test_ptext;
integer file;



aes_128 uut (
	.state(state),
	.key (key),
	.clk (clk),
	.out(out)
);

// Generator
task test_pattern_gen;
    output [127:0] test_pattern;
    output [127:0] plain_text;
        begin: B1
            test_pattern[31:0] = $urandom;
            test_pattern[63:32] = $urandom;
            test_pattern[95:64] = $urandom;
            test_pattern[127:96] = $urandom;
            $display ("Test Pattern - Key = %h",test_pattern );
	    plain_text[31:0] = $urandom;
            plain_text[63:32] = $urandom;
            plain_text[95:64] = $urandom;
            plain_text[127:96] = $urandom;
	    $display ("Test Pattern - Plain Text = %h",plain_text );
        end
endtask

always
begin
	#10 clk = !clk;
end
//DUT
initial 
begin 
	file = $fopen("vcs_aes_output.txt","a+");
	clk=0;
	#50;
	for (int i =0; i <10; i++) begin 
		
		test_pattern_gen(test_key,test_ptext);
		key=test_key;
		state=test_ptext;
	
		#600;
$fwrite(file,"%h	%h	%h\n",key,state,out);
		
	end
	$fclose(file);
	$finish;
	
end

endmodule
