//-----------------------------------------------------------------
//
// AC97 codec declaration
//
//-----------------------------------------------------------------
module ac97_if(ClkIn,
			PCM_Playback_Left,
			PCM_Playback_Right,
			PCM_Record_Left,
			PCM_Record_Right,
			New_Frame,
			AC97Reset_n,
			AC97Clk,
			Sync,
			SData_Out,
			SData_In);

input ClkIn;
input [15:0] PCM_Playback_Left;
input [15:0] PCM_Playback_Right;
output [15:0] PCM_Record_Left;
output [15:0] PCM_Record_Right;
output New_Frame;
output AC97Reset_n;
input AC97Clk;
output Sync;
output SData_Out;
input SData_In;

endmodule 