//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
    {"", "$HOME/.suckless/dwmblocks/scripts/cpu_usage.sh", 1, 0},    
    
    {"", "$HOME/.suckless/dwmblocks/scripts/ram_usage.sh", 1, 0},    

    {"", "$HOME/.suckless/dwmblocks/scripts/bat_percent.sh", 1, 0},    

    {"", "$HOME/.suckless/dwmblocks/scripts/vol_percent.sh", 1, 0},    

	{"", "date '+%b %d (%a) %I:%M%p'",					5,		0},

};

//sets delimiter between status commands. NULL character ('\0') means no delimiter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
