MAKEFLAGS += --warn-undefined-variables

PS_SW =
PS_SW += -version 4
PS_SW += -inputformat none
PS_SW += -executionpolicy bypass
PS_SW += -noprofile
PS_SW += -noninteractive

RM = rm

create:
	bash -o pipefail -c 'powershell $(PS_SW) -file create.ps1'
