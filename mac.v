module mac(
    clk,

    i__constant,
    i__pkt_1,
    i__pkt_2,
    i__pkt_3,
    i__sel1,
    i__sel2,
    i__sel3,

    o__write,
    o__read
);

// Parameters
parameter COUNT_WIDTH                   = 32;

// Input signals
input  logic [COUNT_WIDTH-1:0]          i__constant;
input  logic [COUNT_WIDTH-1:0]          i__pkt_1;
input  logic [COUNT_WIDTH-1:0]          i__pkt_2;
input  logic [COUNT_WIDTH-1:0]          i__pkt_3;
input  logic                            i__sel1;
input  logic                            i__sel2;
input  logic                            i__sel3;

// Sequential elements
logic [COUNT_WIDTH-1:0]                 r__register__pff;
input  logic clk;
logic [COUNT_WIDTH-1:0]          r__constant;
logic [COUNT_WIDTH-1:0]          r__pkt_1;
logic [COUNT_WIDTH-1:0]          r__pkt_2;
logic [COUNT_WIDTH-1:0]          r__pkt_3;
logic                            r__sel1;
logic                            r__sel2;
logic                            r__sel3;

// Output signals
output logic [COUNT_WIDTH-1:0]          o__write;
output logic [COUNT_WIDTH-1:0]          o__read;

// 2-way mux
function logic [COUNT_WIDTH-1:0] mux (input logic [COUNT_WIDTH-1:0] x, input logic [COUNT_WIDTH-1:0] y, input logic sel);
  case (sel)
    1'b0 : return x;
    1'b1 : return y;
  endcase
endfunction

//------------------------------------------------------------------------------
// Write register
//------------------------------------------------------------------------------
always_comb
begin
  o__read  = r__register__pff;
  o__write = (mux(r__register__pff, 0, r__sel1) * mux(r__constant, r__pkt_1, r__sel2)) + (mux(r__pkt_2, r__pkt_3, r__sel3));
end

//------------------------------------------------------------------------------
//
always_ff @ (posedge clk)
begin
  r__register__pff <= o__write;
  r__constant      <= i__constant;
  r__pkt_1         <= i__pkt_1;
  r__pkt_2         <= i__pkt_2;
  r__pkt_3         <= i__pkt_3;
  r__sel1          <= i__sel1;
  r__sel2          <= i__sel2;
  r__sel3          <= i__sel3;
end

endmodule
