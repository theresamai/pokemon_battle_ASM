TITLE Pokemon Battle			(pokemon.asm)

;// Author: Theresa Mai
;// Course / Project ID: CS 271 Extra Credit    Date: 2/10/2019
;// Description: A Pokemon Battle Simulator between two randomized pokemon.

INCLUDE Irvine32.inc

POKEMON_LO = 1
POKEMON_HI = 3
MOVE_LO = 1
MOVE_HI = 2

.data

;// ASCII art for Pokemon logo
pokemon_logo_1			BYTE		"							.::.", 0
pokemon_logo_2			BYTE		"						      .;:**'", 0
pokemon_logo_3			BYTE		"						      `", 0
pokemon_logo_4			BYTE		"			  .:XHHHHk.              db.   .;;.     dH  MX", 0
pokemon_logo_5			BYTE		"			oMMMMMMMMMMM       ~MM  dMMP :MMMMMR   MMM  MR      ~MRMN", 0
pokemon_logo_6			BYTE		"			QMMMMMb  'MMX       MMMMMMP !MX' :M~   MMM MMM  .oo. XMMM   'MMM", 0
pokemon_logo_7			BYTE		"			  `MMMM.  )M> :X!Hk. MMMM   XMM.o'  .  MMMMMMM X ? XMMM MMM>!MMP", 0
pokemon_logo_8			BYTE		"			   'MMMb.dM! XM M'?M MMMMMX.`MMMMMMMM~ MM MMM XM `' MX MMXXMM", 0
pokemon_logo_9			BYTE		"			    ~MMMMM~ XMM. .XM XM`'MMMb.~* ? **~.MMX M t MMbooMM XMMMMMP", 0
pokemon_logo_10		BYTE		"			     ?MMM>  YMMMMMM! MM   `?MMRb.    `'''   !L'MMMMM XM IMMM", 0
pokemon_logo_11		BYTE		"			      MMMX   'MMMM'  MM       ~%:           !Mh.''' dMI IMMP", 0
pokemon_logo_12		BYTE		"			      'MMM.                                             IMX", 0
pokemon_logo_13		BYTE		"			       ~M!M                                             IMP ", 0

;// strings for title, author, and art credits
title_str				BYTE		"						  BATTLE SIMULATOR", 0
author_str			BYTE		"						   by Theresa Mai", 0
art_credit_str			BYTE		"					ASCII art from ascii.co.uk and blank", 0

;// strings for whether player won or lost
win_str				BYTE		"			Pokemon trainer Blue's pokemon fainted. Congrats. You won the battle!" ,0
lose_str				BYTE		"					Your pokemon fainted. You lost the battle." ,0

;// ASCII art for Gary challenging the player
gary_panel_1			BYTE		"					                     .:",0
gary_panel_2			BYTE		"					            :+++-   :doh`+s/",0
gary_panel_3			BYTE		"					           /soosyhhssNyydm+N       /yho/.",0
gary_panel_4			BYTE		"					            `/dmyoossyhosdsym/hm  d+//m/yy+.",0
gary_panel_5			BYTE		"					          -/shyssoooooooooosdshy  s//o/.-yN/", 0
gary_panel_6			BYTE		"					         syhhhsoosyoydshmoooosM    so+-..:h/ ", 0
gary_panel_7			BYTE		"					         .--yhoyddyydNdmsdysyyh     +hyy+y+`", 0
gary_panel_8			BYTE		"					         oo/yNMms+-+hmsy+m-:d     m+/oom/", 0
gary_panel_9			BYTE		"					          oy/-yh-/s--os ``-`:h    yd+/oyh:", 0
gary_panel_10			BYTE		"					              :ys--:/:` `:oso---yyyys+om/", 0
gary_panel_11			BYTE		"					        .--`    .-:ssssyyymyyyyyysoooood+` ", 0
gary_panel_12			BYTE		"					      .+/y++/`   -oooyyooooooooydsyyyyy/`",0
gary_panel_13			BYTE		"					    y+-...s/  `oh/+ooooooooosMyy/:` ", 0
gary_panel_14			BYTE		"					       y+sssys/.sdo+shdssoooosm//", 0
gary_panel_15			BYTE		"					        :ds///smmyooydddyoooosN.", 0
gary_panel_16			BYTE		"					         :shyssooooshmyooooooosM", 0
gary_panel_17			BYTE		"					            -+shhysmmooooooooosM", 0
gary_panel_18			BYTE		"					                   :s///ooooooshs", 0
gary_panel_19			BYTE		"					                 +myy//+ssoooosM", 0
gary_panel_20			BYTE		"					               :hMMMMMMMNdddddoo",0
gary_panel_21			BYTE		"					               :hMMMMMMNddMMMMMM", 0
gary_panel_22			BYTE		"					            +dddmMMmo/`+MMMMMMd`", 0
gary_panel_23			BYTE		"					             +mMmdmMy     .MdMdMM:", 0
gary_panel_24			BYTE		"					            smyydmd/       .NdddMM`", 0
gary_panel_25			BYTE		"					         shhddmMs         .MddsdN.", 0
gary_panel_26			BYTE		"					          :smNNNMs`          .NNNmdN.", 0
gary_panel_27			BYTE		"					         ymddmddh/            .MshNM.", 0
gary_panel_28			BYTE		"					         `+sss/.`              .yyy-", 0
gary_panel_29			BYTE		"					     Pokemon Trainer Blue wants to fight!", 0

;// ASCII art for printing out health bar and pokemon
hp_stat_total			BYTE		"/20 HP", 0
hp_border				BYTE		"--------------------",0
hp100_str				BYTE		"|//////////////////|", 0
hp75_str				BYTE		"|//////////////    |", 0
hp50_str				BYTE		"|/////////         |", 0
hp25_str				BYTE		"|/////             |", 0
hp0_str				BYTE		"|/                 |", 0
op_spacing_1			BYTE		"								", 0			;// spacing for opponent's pokemon
op_spacing_2			BYTE		"				", 0							;// spacing for opponent's hp bar

;// names for pokemon
bulbasaur_name			BYTE		" BULBASAUR ",0								;// name of bulbasaur
squirtle_name			BYTE		" SQUIRTLE ",0									;// name of squirtle
charmander_name		BYTE		" CHARMANDER ",0								;// name of charmander

;// ASCII art for bulbasaur (front sprite)
bulbasaur_front_1		BYTE		"                                   ,*", 0
bulbasaur_front_2		BYTE		"                       ((((((*****#(((*/,", 0
bulbasaur_front_3		BYTE		"                     ((%&&&&&&&%%%%((%*(,", 0
bulbasaur_front_4		BYTE		"     ...          /##&&&&&(//%%%###%%%(*.", 0
bulbasaur_front_5		BYTE		"    /%%%,,  ***********,,,%## &&&&&%%%%*/(", 0
bulbasaur_front_6		BYTE		"    /%%#%(((%%####%###/#%%%## &&&&&%%%%*//(", 0
bulbasaur_front_7		BYTE		"    /*#%%%%%%/////%%%########/ %&&&%%%%(/*((,", 0
bulbasaur_front_8		BYTE		"    *%%%%%%%/////%%%%########/ %&&%%%%%(((*(,", 0
bulbasaur_front_9		BYTE		"  **,%%#%%%%%%%%%%#%%*&&%,#//// ,%%%#(((((*(((", 0
bulbasaur_front_10		BYTE		"  ,,*/#%#%%%%//(%#%/**,%@%,//// .,((((((((*(((", 0
bulbasaur_front_11		BYTE		" *#&*@#/%%%%//%%%%/**@,,,@&////,*/,(((((/*((((", 0
bulbasaur_front_12		BYTE		" *%@,@#/#%%%%%%%%#/,,@((#@&////**//,*((*/(((,", 0
bulbasaur_front_13		BYTE		" ,. #####################//,,//////////,/((", 0
bulbasaur_front_14		BYTE		" ,*/ ,(##/###*########*,,  ///*////,,,//*,", 0
bulbasaur_front_15		BYTE		"    ,///*,,,,,,,,,,,,,*//////,//////*,,////,. ", 0
bulbasaur_front_16		BYTE		"        //**,*(((((/*/////   //////**//////,.", 0
bulbasaur_front_17		BYTE		"        ,/............////////,/// ///,,,,//.", 0
bulbasaur_front_18		BYTE		"        /####/,*///////*,##////,. ////,,,,//.", 0
bulbasaur_front_19		BYTE		"         *//##//*,,,,,,*//(##//,. ////*,**/,.", 0
bulbasaur_front_20		BYTE		"         /######//    /##//##//,,  **/*//*/", 0
bulbasaur_front_21		BYTE		"         .(((#((/*    *(####(/    ,(/.(./(,", 0
bulbasaur_front_22		BYTE		"                     ,@/,@,@&", 0

;// ASCII art for bulbasaur (back sprite)
bulbasaur_back_1		BYTE		"                               . ", 0
bulbasaur_back_2		BYTE		"                   ..,.        ,**..                 ,,.", 0
bulbasaur_back_3		BYTE		"              ..,*//////**..,**,,*//(/*,,,,,,,,,,,/*,,,//.", 0
bulbasaur_back_4		BYTE		"            ./***/*//(/(##((####(////##((///(((*.. .,,,*//..", 0
bulbasaur_back_5		BYTE		"            ./***/(((#%%//**/////(####(**,,*##%/,,,,,,,,/(,,", 0
bulbasaur_back_6		BYTE		"             ,((((#((*/(//*,,,,,,,,,**/(((//((%#**,,,,,,*///.", 0
bulbasaur_back_7		BYTE		"             *((//(**.,/((/*,,,,,,,,,,***/((///***,,,,,**(((*", 0
bulbasaur_back_8		BYTE		"            *(**,**,,,,,**/((//**,,,,,,,,,,*//(*,,,,,,,,/(##(,", 0
bulbasaur_back_9		BYTE		"          .//*,,,*(**,,,,,,,***/(#((/**,,,,,**/(**,,,,,,.*(((/.", 0
bulbasaur_back_10		BYTE		"          *(*,,,,*(**,,,,,,,,,,**///((/**,,,,,*(//*,,,,,,*//((*", 0
bulbasaur_back_11		BYTE		"        **/,  ..*(*.......,,,,,,,,,,,*/((*,,,,,/##/,,,,,**///(/..", 0
bulbasaur_back_12		BYTE		"       .//*     ,/,     ..,,,,,,,,,,,,*((/*,,,,/##/,,,,,*/((##* ", 0
bulbasaur_back_13		BYTE		"      .///,...,,/,    ....,,,,,,,,,,,,,**(/*,,,/##/,,,,,**//(*", 0
bulbasaur_back_14		BYTE		"      ,(//,,,,//(*,,,,,,,,,,,,,,,,,,,,,,,/#/,,*(//*****,*///,", 0
bulbasaur_back_15		BYTE		"      ,(//,,,*((/*,,,,,,,,,,,,,,,,,,,,,,,/#/**(#//*#%//**(**", 0
bulbasaur_back_16		BYTE		"      .///*,,*((*,,,,,,,,,,,,,,,,,,,,,,**/(/((%(***%@&&/*///.", 0
bulbasaur_back_17		BYTE		"       *((*,,*****,,,,,,,,,,,,,,,,,,,,,**(((%%#*,,*/%##*,/((,", 0
bulbasaur_back_18		BYTE		"        ,,//*,**(/*,,,,,,,,,,,,,,,,,,,*##%%%//**((#(/***,*///.", 0
bulbasaur_back_19		BYTE		"           ,/(///((//**,,,,,,,,,**//(#%&&%/****/*****//(/*//(,", 0
bulbasaur_back_20		BYTE		"            .*((%##%%%(/***,***/(#%%%%%##/**//%%((*,,**/(*//(,", 0

;// ASCII art for squirtle (front sprite)
squirtle_front_1		BYTE		"              /////###" ,0
squirtle_front_2		BYTE		"          /......,,,,,,,(# ", 0
squirtle_front_3		BYTE		"         #.....,,,,,,,,,,,# ", 0
squirtle_front_4		BYTE		"       ##,,,,,,,,,/,,,,,,,,# ", 0
squirtle_front_5		BYTE		"      #//,,,,,,,,/,////,,,,/## ", 0
squirtle_front_6		BYTE		"      #  /,,,,,,,,@@@@.#(///@@  ", 0
squirtle_front_7		BYTE		"      #%%/,,,,,,,,@@@% #(///@@", 0
squirtle_front_8		BYTE		"     #...,,,,,,,,,%@@% /////@@  ", 0
squirtle_front_9		BYTE		"     @.,,/,//,,,,,,,,///////@@ ", 0
squirtle_front_10		BYTE		" / //  @@@,,,/#######%%////#  /,,,//@@", 0
squirtle_front_11		BYTE		" #,//#@@@/@@@%(((((%%%////@/,,,,##/@   ", 0
squirtle_front_12		BYTE		"#,,,,,,,,,@##////////@@/,.,,,,,///@ ", 0
squirtle_front_13		BYTE		" .(//////////******//,,(((,,////&&,", 0
squirtle_front_14		BYTE		"   ###///////...../////#(//////@%%      ######", 0
squirtle_front_15		BYTE		"         /....,......../*,@@@@.(((% ##/,,,,,,,/#", 0
squirtle_front_16		BYTE		"         /....,.......,,,,,%...(((%#//,,,,,,,,,#", 0
squirtle_front_17		BYTE		"         //.../....../..,,,(...(@@%/////##,,##,/@", 0
squirtle_front_18		BYTE		"         /.,,////,,///....,/((.,((%////#//,,,,//@", 0
squirtle_front_19		BYTE		"       ///....,.......,/*,//###.((@////@///////@", 0
squirtle_front_20		BYTE		"      /,,,/...,.......,,//,,,,/#..@/////@@////@", 0
squirtle_front_21		BYTE		"     /,,,,,///,,,//,,,,#*,,,,,,/@@/////@@@@", 0
squirtle_front_22		BYTE		"     #,,,,,//%,,,,,////#*,,,,,,/##@@@@@", 0
squirtle_front_23		BYTE		"      @////////@@%%@@@@@%#////////@", 0
squirtle_front_24		BYTE		"      #///////@@@       %@////////@", 0
squirtle_front_25		BYTE		"      @@@ @@@             @,//@,##@@", 0

;// ASCII art for squirtle (back sprite)
squirtle_back_1		BYTE		"                               .,**(####(*." ,0
squirtle_back_2		BYTE		"                               .,*,,*(((((((,,", 0
squirtle_back_3		BYTE		"                            ....    .*//////(((,", 0
squirtle_back_4		BYTE		"                           .,..  .,,**////////((,,", 0
squirtle_back_5		BYTE		"                          .//,,..,***///////((##((,", 0
squirtle_back_6		BYTE		"                        ..((/*****//////////((#((((.", 0
squirtle_back_7		BYTE		"                        ,,#(////////////////((%%###,", 0
squirtle_back_8		BYTE		"                        ,,#(////////////////((%&%%#,", 0
squirtle_back_9		BYTE		"                        ..((//////////////////(###(*", 0
squirtle_back_10		BYTE		"                        ..*(#####((((//////(((((((#(.", 0
squirtle_back_11		BYTE		"                      ,/((/*,,,,,,,,*((((///(((###*,.", 0
squirtle_back_12		BYTE		"                     .((((###((((/**,,*((((///(#((*//,,", 0
squirtle_back_13		BYTE		"                   ,,//*,,*/*,,,,/((((,..*%&%%%#(((**(((.", 0
squirtle_back_14		BYTE		"                  ,///,,//(*,,,,,*///((...##(//////(((.", 0
squirtle_back_15		BYTE		"                ./(////***/(/***/(#####((.,#((//////(((.", 0
squirtle_back_16		BYTE		"              ../////.  ..,*(%%%##((///(((,*((((((((,", 0
squirtle_back_17		BYTE		"              ,,(//**  .,,,*(%%#(//////((#,,###(((*.", 0
squirtle_back_18		BYTE		"             .///,*,,,**///(###////////((#,,((* ", 0
squirtle_back_19		BYTE		"             ,((//(//*////(##((////////((#,,((,", 0
squirtle_back_20		BYTE		"       .**/(/(%%#/(##########((///////(((*,(//. ", 0
squirtle_back_21		BYTE		"    ../*,,.,/(###(/((#/*////(###/////((***((##(.", 0
squirtle_back_22		BYTE		"    **(,..,*//((##(###/*/////((#(///((,,,((/(((*", 0

;// ASCII art for charmander (front sprite)
charmander_front_1		BYTE		"            .((%%%/ " ,0
charmander_front_2		BYTE		"         (,**********@", 0
charmander_front_3		BYTE		"        (,,,,********&,", 0
charmander_front_4		BYTE		"      .(**,******(/***@", 0
charmander_front_5		BYTE		"      ,&(*******(*(&&((@*", 0
charmander_front_6		BYTE		"      ./(********#%&%%(@*", 0
charmander_front_7		BYTE		"      ,@********* *&/%(@*               ( ", 0
charmander_front_8		BYTE		"     %#,,,********/((((@,               (,", 0
charmander_front_9		BYTE		"     ///,**//***/####(%#.     ,**      (,,..", 0
charmander_front_10		BYTE		"      .@@*****%%@ ,(((@   %%%%#(@      (*,,,(", 0
charmander_front_11		BYTE		"   @(%%%%@(((%%%((%@((*******((((@    ((((*,,(", 0
charmander_front_12		BYTE		"  *&(****(&&&((#&&%((((***(((####     (/*((/,*(", 0
charmander_front_13		BYTE		"   @@((((((((((((((((((((((@@         (*,,,,,,(", 0
charmander_front_14		BYTE		"        @@(((%******((**&@             (*(***((", 0
charmander_front_15		BYTE		"          *%#*,,,,,,,***#%#             ,#%%(,", 0
charmander_front_16		BYTE		"           %#,,,,,,,,*****@              %*,@ ", 0
charmander_front_17		BYTE		"          %*,,,,,,,,,******@            %***@", 0
charmander_front_18		BYTE		"         #%,,,,,,,,,,,(****/&     ####***(&@.", 0
charmander_front_19		BYTE		"        %*(*,,,,,,,,,*(*****(@&%%%******(*&@", 0
charmander_front_20		BYTE		"      .@***%#********(*******(&@((((((**@ ", 0
charmander_front_21		BYTE		"      ,@*****#&******%(****(((&@****%&&.", 0
charmander_front_22		BYTE		"        @**((((@@****%((((((((&@**%%.", 0
charmander_front_23		BYTE		"         @(((((@@      %(((((@*", 0
charmander_front_24		BYTE		"      ,@ % (((@.       %((***(%@", 0
charmander_front_25		BYTE		"        @@@@@@          %@ % %* @", 0

;// ASCII art for charmander (back sprite)
charmander_back_1		BYTE		"                                             ..,,,,.", 0
charmander_back_2		BYTE		"                       ...                 .,,,*//(/*,,.", 0
charmander_back_3		BYTE		"                      ....               ,/*..     .,//(/,", 0
charmander_back_4		BYTE		"                 .....,...             ,,//,      .,****//,,", 0
charmander_back_5		BYTE		"             .,,*/****,.              ,///**,,,,*********(((*", 0
charmander_back_6		BYTE		"           .,,,,*//**,.              ,(//***************/(///,", 0
charmander_back_7		BYTE		"           ,****//*,,.               ,(((***************/(((/.", 0
charmander_back_8		BYTE		"          ,***////,..                ,///***************(&@@%*", 0
charmander_back_9		BYTE		"        ..,***////*..               .*/*****************/%&(.", 0
charmander_back_10		BYTE		"        ..,,****///,,               ,((*******************////*..", 0
charmander_back_11		BYTE		"        ...,****/////,              ,(/******************/((/((,,", 0
charmander_back_12		BYTE		"       ....,****/////*.             ,//*****************/#%%%%(..", 0
charmander_back_13		BYTE		"       ,******////*///*.          ,,//**************///(####(*", 0
charmander_back_14		BYTE		"       ,******//(/////,          ,///*************//(####(**.", 0
charmander_back_15		BYTE		"        ,,***/(((//**,          ,/****************(##//.", 0
charmander_back_16		BYTE		"          .*(((((*.          ,,//,,,***********,.../(**", 0
charmander_back_17		BYTE		"           ,(###(,          ,///,.,,***********,...,///,", 0
charmander_back_18		BYTE		"          .*/*(((,         */**..,*************/*******//,", 0
charmander_back_19		BYTE		"          ,(/*(((,        .//,,.,**************///*****/((,,", 0
charmander_back_20		BYTE		"        ..*/****/*.     ..//,...,*************,,**##(///((((,", 0
charmander_back_21		BYTE		"        ,,(*,***/(*    .///,,,,*************,,  ..***((#((//,", 0
charmander_back_22		BYTE		"        ,,/,,****//**. ,((/****************,..  ..*. ,,/((//.", 0

;// ASCII art for happy pikachu for congrats message
happy_pika_1			BYTE		"				      @@" ,0
happy_pika_2			BYTE		"				     @&&@", 0
happy_pika_3			BYTE		"				     @&&&@", 0
happy_pika_4			BYTE		"				    @&&&&%                           &&&&", 0
happy_pika_5			BYTE		"				    @&&&&,%%                   &#########@", 0
happy_pika_6			BYTE		"				    @,&&&,%%               ##,,##########@@", 0
happy_pika_7			BYTE		"				     #,,,,##%(*,,,,,,(#%,,,.(########&@@        %%%", 0
happy_pika_8			BYTE		"				     %,,,///        ........###..@@@@          #...#", 0
happy_pika_9			BYTE		"				      #(,.........,,%%#,..,*(%%             (/,.....##", 0
happy_pika_10			BYTE		"				     %/(@,........(# @@&....@              /..........#", 0
happy_pika_11			BYTE		"				     %@%,,..*,....#&@%%%....@          @***...........#", 0
happy_pika_12			BYTE		"				     #&%#...............((/./%%      %#................#", 0
happy_pika_13			BYTE		"				    %,...,**%#(/,,,,..,((((#,@@    @(,.................#", 0
happy_pika_14			BYTE		"				    %#,,,,,,######*,,,*#####,@@    #,.................@", 0
happy_pika_15			BYTE		"				    %#,,,,,,,#(((#*,,,,,##(,,@@  ##,,,,,............@@", 0
happy_pika_16			BYTE		"				      @&,,,,,,(##,,,,,,,,,,,,%%@#,,,,,,,,,,,,,.@@@", 0
happy_pika_17			BYTE		"				      @&,,,,,,,,,,,,,,,,,,,,,..@ %%,,,,,,,,,@@@", 0
happy_pika_18			BYTE		"				      @%....,,,,,,,,,,,,,,,....@    %/,,#", 0
happy_pika_19			BYTE		"				      @%......,,,,,,,/*,.......@     &%,,#%", 0
happy_pika_20			BYTE		"				     @/*..##......../..........%@  @/*,,,,,%", 0
happy_pika_21			BYTE		"				     @....//......(#.......,....@  ////,/#%@", 0
happy_pika_22			BYTE		"				     @#(..../....@(/....#......,@@@//&@", 0
happy_pika_23			BYTE		"				    @..*#...#.......##(......,,,,@@ @%##@", 0
happy_pika_24			BYTE		"				  @@#....###................,,,,,@@@####@", 0

;// ASCII art for surprised pikachu for losing message
sad_pika_1			BYTE		"			@@@@                                                      @@@@", 0
sad_pika_2			BYTE		"			 @@@,,@@                                                @@,,@", 0
sad_pika_3			BYTE		"			  @@,,,,,@@                                           @@@,,,@", 0
sad_pika_4			BYTE		"			   @,,,,,,,,/@                                     @@,,,,,,@", 0
sad_pika_5			BYTE		"			    @,,,,,,,,,,,@                              @@,,,,,,,,,@", 0
sad_pika_6			BYTE		"			      @,,,,,,,,,,,,*@                      @@,,,,,,,,,,,,@", 0
sad_pika_7			BYTE		"			        @,,,,,,,,,,,,,,@@@@@@@@@@@@@&&&,,,,,,,,,,,,,,,,,@", 0
sad_pika_8			BYTE		"			         @,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,&", 0
sad_pika_9			BYTE		"			            @,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,@", 0
sad_pika_10			BYTE		"			            @,@,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,*@", 0
sad_pika_11			BYTE		"			               @,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,@", 0
sad_pika_12			BYTE		"			               @,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,@", 0
sad_pika_13			BYTE		"			              @,,,,,,  @%,,,,,,,,,,,,,,@ @@,,,,,,,,,", 0
sad_pika_14			BYTE		"			              @,,,,,,@@@,,,,,,,,,,,,,,,%@@@,,,,,,,,,@", 0
sad_pika_15			BYTE		"			             @,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,", 0
sad_pika_16			BYTE		"			            &(&,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,@@,,,,,@", 0
sad_pika_17			BYTE		"			            @(((((,,,,,,,,,,,,,,,,,,,,,,,,,,(((((%,,,,", 0
sad_pika_18			BYTE		"			            @((((#,,,,,,,,,,@&@(/((,,,,,,,,,#((((@,,,,@", 0
sad_pika_19			BYTE		"			            @,,,,,,,,,,,,,,&@//////#,,,,,,,,,,,,,,,,,,,@", 0
sad_pika_20			BYTE		"			            @,,,,,,,,,,,,,,,///////(,,,,,,,,,,,,,,,,,,,&", 0
sad_pika_21			BYTE		"			             @,,,,,,,,,,,,,,,,@%%@,,,,,,,,,,,,,,,,,,,,,,@", 0
sad_pika_22			BYTE		"			              @,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,(", 0
sad_pika_23			BYTE		"			               /,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,@", 0

;// strings for getting pokemon move from player
move_prompt_1			BYTE		"Enter 1 for ", 0
move_prompt_2			BYTE		" or 2 for ", 0
move_prompt_3			BYTE		": ", 0
invalid_input			BYTE		"Invalid input. Must be 1 or 2.", 0

;// strings for pokemon moves and printing them
tackle				BYTE		"Tackle", 0
scratch				BYTE		"Scratch", 0
tail_whip				BYTE		"Tail Whip", 0
growl				BYTE		"Growl", 0
used					BYTE		" used ", 0

;// variables for Pokemon Trainers
pokemon_1				DWORD	?	;// pokemon for human player
hp_1					DWORD	20	;// health points for human player's pokemon
move_1				DWORD	?	;// pokemon move chosen by human player
atk_1				DWORD	0	;// counter for pokemon's attack modifier
def_1				DWORD	0	;// counter for pokemon's defense modifier

pokemon_2				DWORD	?	;// pokemon for computer player
hp_2					DWORD	20	;// health points for computer player's pokemon
move_2				DWORD	?	;// pokemon move chosen by computer player
atk_2				DWORD	0	;// counter for pokemon's attack modifier
def_2				DWORD	0	;// counter for pokemon's defense modifier

.code
main PROC	
	print_welcome:
	;// print opening screen to user
		push		OFFSET art_credit_str
		push		OFFSET author_str
		push		OFFSET title_str
		push		OFFSET pokemon_logo_13
		push		OFFSET pokemon_logo_12
		push		OFFSET pokemon_logo_11
		push		OFFSET pokemon_logo_10
		push		OFFSET pokemon_logo_9
		push		OFFSET pokemon_logo_8
		push		OFFSET pokemon_logo_7
		push		OFFSET pokemon_logo_6
		push		OFFSET pokemon_logo_5
		push		OFFSET pokemon_logo_4
		push		OFFSET pokemon_logo_3
		push		OFFSET pokemon_logo_2
		push		OFFSET pokemon_logo_1
		call		welcome				

	assign_pokemon:
	;// randomize pokemon for each trainer
		push		OFFSET pokemon_2
		push		OFFSET pokemon_1
		call		randomize_pokemon		
	
	print_begin_panel:
	;// print gary challenging the player
		push		OFFSET gary_panel_29
		push		OFFSET gary_panel_28
		push		OFFSET gary_panel_27
		push		OFFSET gary_panel_26
		push		OFFSET gary_panel_25
		push		OFFSET gary_panel_24
		push		OFFSET gary_panel_23
		push		OFFSET gary_panel_22
		push		OFFSET gary_panel_21
		push		OFFSET gary_panel_20
		push		OFFSET gary_panel_19
		push		OFFSET gary_panel_18
		push		OFFSET gary_panel_17
		push		OFFSET gary_panel_16
		push		OFFSET gary_panel_15
		push		OFFSET gary_panel_14
		push		OFFSET gary_panel_13
		push		OFFSET gary_panel_12
		push		OFFSET gary_panel_11
		push		OFFSET gary_panel_10
		push		OFFSET gary_panel_9
		push		OFFSET gary_panel_8
		push		OFFSET gary_panel_7
		push		OFFSET gary_panel_6
		push		OFFSET gary_panel_5
		push		OFFSET gary_panel_4
		push		OFFSET gary_panel_3
		push		OFFSET gary_panel_2
		push		OFFSET gary_panel_1
		call		print_gary_panel		

	;// print pokemon's name and HP
	print_opponent_sprite:
		;// jump to corresponding block for pokemon
		cmp		pokemon_2, 1
		je		print_com_bulbasaur
		cmp		pokemon_2, 2
		je		print_com_squirtle
		jmp		print_com_charmander

		print_com_bulbasaur:
			;// print HP bar
			push		OFFSET op_spacing_2
			push		OFFSET hp0_str
			push		OFFSET hp25_str
			push		OFFSET hp50_str
			push		OFFSET hp75_str
			push		OFFSET hp100_str
			push		OFFSET hp_border
			push		hp_2						;// pokemon's hp
			push		OFFSET bulbasaur_name		;// pokemon name
			call		print_com_hp_bar

			;// print bulbasaur sprite
			push		OFFSET op_spacing_1
			push		OFFSET bulbasaur_front_22
			push		OFFSET bulbasaur_front_21
			push		OFFSET bulbasaur_front_20
			push		OFFSET bulbasaur_front_19
			push		OFFSET bulbasaur_front_18
			push		OFFSET bulbasaur_front_17
			push		OFFSET bulbasaur_front_16
			push		OFFSET bulbasaur_front_15
			push		OFFSET bulbasaur_front_14
			push		OFFSET bulbasaur_front_13
			push		OFFSET bulbasaur_front_12
			push		OFFSET bulbasaur_front_11
			push		OFFSET bulbasaur_front_10
			push		OFFSET bulbasaur_front_9
			push		OFFSET bulbasaur_front_8
			push		OFFSET bulbasaur_front_7
			push		OFFSET bulbasaur_front_6
			push		OFFSET bulbasaur_front_5
			push		OFFSET bulbasaur_front_4
			push		OFFSET bulbasaur_front_3
			push		OFFSET bulbasaur_front_2
			push		OFFSET bulbasaur_front_1
			call		print_opponent_bulbasaur
			jmp		print_player_sprite

		print_com_squirtle:
			;// print HP bar
			push		OFFSET op_spacing_2
			push		OFFSET hp0_str
			push		OFFSET hp25_str
			push		OFFSET hp50_str
			push		OFFSET hp75_str
			push		OFFSET hp100_str
			push		OFFSET hp_border
			push		hp_2						;// pokemon's hp
			push		OFFSET squirtle_name		;// pokemon name
			call		print_com_hp_bar

			;// print squirtle sprite
			push		OFFSET op_spacing_1
			push		OFFSET squirtle_front_25
			push		OFFSET squirtle_front_24
			push		OFFSET squirtle_front_23
			push		OFFSET squirtle_front_22
			push		OFFSET squirtle_front_21
			push		OFFSET squirtle_front_20
			push		OFFSET squirtle_front_19
			push		OFFSET squirtle_front_18
			push		OFFSET squirtle_front_17
			push		OFFSET squirtle_front_16
			push		OFFSET squirtle_front_15
			push		OFFSET squirtle_front_14
			push		OFFSET squirtle_front_13
			push		OFFSET squirtle_front_12
			push		OFFSET squirtle_front_11
			push		OFFSET squirtle_front_10
			push		OFFSET squirtle_front_9
			push		OFFSET squirtle_front_8
			push		OFFSET squirtle_front_7
			push		OFFSET squirtle_front_6
			push		OFFSET squirtle_front_5
			push		OFFSET squirtle_front_4
			push		OFFSET squirtle_front_3
			push		OFFSET squirtle_front_2
			push		OFFSET squirtle_front_1
			call		print_opponent_char_or_squirtle
			jmp		print_player_sprite

		print_com_charmander:
			;// print HP bar
			push		OFFSET op_spacing_2
			push		OFFSET hp0_str
			push		OFFSET hp25_str
			push		OFFSET hp50_str
			push		OFFSET hp75_str
			push		OFFSET hp100_str
			push		OFFSET hp_border
			push		hp_2						;// pokemon's hp
			push		OFFSET charmander_name		;// pokemon name
			call		print_com_hp_bar

			;// print charmander sprite
			push		OFFSET op_spacing_1
			push		OFFSET charmander_front_25
			push		OFFSET charmander_front_24
			push		OFFSET charmander_front_23
			push		OFFSET charmander_front_22
			push		OFFSET charmander_front_21
			push		OFFSET charmander_front_20
			push		OFFSET charmander_front_19
			push		OFFSET charmander_front_18
			push		OFFSET charmander_front_17
			push		OFFSET charmander_front_16
			push		OFFSET charmander_front_15
			push		OFFSET charmander_front_14
			push		OFFSET charmander_front_13
			push		OFFSET charmander_front_12
			push		OFFSET charmander_front_11
			push		OFFSET charmander_front_10
			push		OFFSET charmander_front_9
			push		OFFSET charmander_front_8
			push		OFFSET charmander_front_7
			push		OFFSET charmander_front_6
			push		OFFSET charmander_front_5
			push		OFFSET charmander_front_4
			push		OFFSET charmander_front_3
			push		OFFSET charmander_front_2
			push		OFFSET charmander_front_1
			call 	print_opponent_char_or_squirtle
	
	;// print player's pokemon's name and HP
	print_player_sprite:
		;// jump to corresponding block for pokemon
		call		print_spacing
		cmp		pokemon_1, 1
		je		print_hum_bulbasaur
		cmp		pokemon_1, 2
		je		print_hum_squirtle
		cmp		pokemon_1, 3
		je		print_hum_charmander

		print_hum_bulbasaur:
			;// print HP bar
			push		OFFSET op_spacing_1
			push		OFFSET hp0_str
			push		OFFSET hp25_str
			push		OFFSET hp50_str
			push		OFFSET hp75_str
			push		OFFSET hp100_str
			push		OFFSET hp_border
			push		hp_1						;// pokemon's hp
			push		OFFSET bulbasaur_name		;// pokemon name
			call		print_hum_hp_bar

			;// print bulbasaur sprite
			push		OFFSET bulbasaur_back_20
			push		OFFSET bulbasaur_back_19
			push		OFFSET bulbasaur_back_18
			push		OFFSET bulbasaur_back_17
			push		OFFSET bulbasaur_back_16
			push		OFFSET bulbasaur_back_15
			push		OFFSET bulbasaur_back_14
			push		OFFSET bulbasaur_back_13
			push		OFFSET bulbasaur_back_12
			push		OFFSET bulbasaur_back_11
			push		OFFSET bulbasaur_back_10
			push		OFFSET bulbasaur_back_9
			push		OFFSET bulbasaur_back_8
			push		OFFSET bulbasaur_back_7
			push		OFFSET bulbasaur_back_6
			push		OFFSET bulbasaur_back_5
			push		OFFSET bulbasaur_back_4
			push		OFFSET bulbasaur_back_3
			push		OFFSET bulbasaur_back_2
			push		OFFSET bulbasaur_back_1
			call		print_player_bulbasaur
			jmp		hum_choose_move

		print_hum_squirtle:
			;// print HP bar
			push		OFFSET op_spacing_1
			push		OFFSET hp0_str
			push		OFFSET hp25_str
			push		OFFSET hp50_str
			push		OFFSET hp75_str
			push		OFFSET hp100_str
			push		OFFSET hp_border
			push		hp_1							;// pokemon's hp
			push		OFFSET squirtle_name			;// pokemon name
			call		print_hum_hp_bar

			;// print squirtle sprite
			push		OFFSET squirtle_back_22
			push		OFFSET squirtle_back_21
			push		OFFSET squirtle_back_20
			push		OFFSET squirtle_back_19
			push		OFFSET squirtle_back_18
			push		OFFSET squirtle_back_17
			push		OFFSET squirtle_back_16
			push		OFFSET squirtle_back_15
			push		OFFSET squirtle_back_14
			push		OFFSET squirtle_back_13
			push		OFFSET squirtle_back_12
			push		OFFSET squirtle_back_11
			push		OFFSET squirtle_back_10
			push		OFFSET squirtle_back_9
			push		OFFSET squirtle_back_8
			push		OFFSET squirtle_back_7
			push		OFFSET squirtle_back_6
			push		OFFSET squirtle_back_5
			push		OFFSET squirtle_back_4
			push		OFFSET squirtle_back_3
			push		OFFSET squirtle_back_2
			push		OFFSET squirtle_back_1
			call		print_player_char_or_squirtle
			jmp		hum_choose_move

		print_hum_charmander:
			;// print HP bar
			push		OFFSET op_spacing_1
			push		OFFSET hp0_str
			push		OFFSET hp25_str
			push		OFFSET hp50_str
			push		OFFSET hp75_str
			push		OFFSET hp100_str
			push		OFFSET hp_border
			push		hp_1							;// pokemon's hp
			push		OFFSET charmander_name			;// pokemon name
			call		print_hum_hp_bar

			;// print charmander sprite
			push		OFFSET charmander_back_22
			push		OFFSET charmander_back_21
			push		OFFSET charmander_back_20
			push		OFFSET charmander_back_19
			push		OFFSET charmander_back_18
			push		OFFSET charmander_back_17
			push		OFFSET charmander_back_16
			push		OFFSET charmander_back_15
			push		OFFSET charmander_back_14
			push		OFFSET charmander_back_13
			push		OFFSET charmander_back_12
			push		OFFSET charmander_back_11
			push		OFFSET charmander_back_10
			push		OFFSET charmander_back_9
			push		OFFSET charmander_back_8
			push		OFFSET charmander_back_7
			push		OFFSET charmander_back_6
			push		OFFSET charmander_back_5
			push		OFFSET charmander_back_4
			push		OFFSET charmander_back_3
			push		OFFSET charmander_back_2
			push		OFFSET charmander_back_1
			call		print_player_char_or_squirtle
			jmp		hum_choose_move

	;// get a pokemon move from the user
	hum_choose_move:
		;// go to corresponding prompt for that pokemon
		call		print_spacing
		cmp		pokemon_1, 1
		je		choose_hum_bulb_move
		cmp		pokemon_1, 2
		je		choose_hum_squirtle_move
		jmp		choose_hum_char_move

		;// choose move if pokemon is a bulbasaur (tackle or growl)
		choose_hum_bulb_move:
			;// get pokemon move from user
			push		OFFSET invalid_input
			push		OFFSET move_1
			push		OFFSET growl
			push		OFFSET tackle
			push		OFFSET move_prompt_3
			push		OFFSET move_prompt_2
			push		OFFSET move_prompt_1
			call		choose_move

			;// go to corresponding move block
			cmp		move_1, 1
			je		hum_tackle
			jmp		hum_growl

		;// choose move if pokemon is a squirtle (tackle or tail whip)
		choose_hum_squirtle_move:
			;// get pokemon move from user
			push		OFFSET invalid_input
			push		OFFSET move_1
			push		OFFSET tail_whip
			push		OFFSET tackle
			push		OFFSET move_prompt_3
			push		OFFSET move_prompt_2
			push		OFFSET move_prompt_1
			call		choose_move

			;// go to corresponding move block
			cmp		move_1, 1
			je		hum_tackle
			jmp		hum_tail_whip

		;// choose move if pokemon is a charmander (scratch or tail whip)
		choose_hum_char_move:
			;// get pokemon move from user
			push		OFFSET invalid_input
			push		OFFSET move_1
			push		OFFSET tail_whip
			push		OFFSET scratch
			push		OFFSET move_prompt_3
			push		OFFSET move_prompt_2
			push		OFFSET move_prompt_1
			call		choose_move

			;// go to corresponding move block
			cmp		move_1, 1
			je		hum_scratch
			jmp		hum_tail_whip

		;// if pokemon move player chosen is tackle
		hum_tackle:
			;// print the move used
			push		OFFSET tackle
			push		OFFSET used
			push		OFFSET charmander_name
			push		OFFSET squirtle_name
			push		OFFSET bulbasaur_name
			push		pokemon_1
			call		print_move_used
			
			;// calculate damage
			push		OFFSET hp_2			;// hp of computer's pokemon
			push		atk_1				;// atk modifier of player's pokemon
			push		OFFSET def_2			;// def modifier of computer's pokemon
			push		OFFSET atk_2			;// atk modifier of computer's pokemon
			push		1					;// 1 = tackle
			call		calc_damage
			jmp		com_choose_move

		;// if pokemon move player chosen is scratch
		hum_scratch:
			;// print the move used
			push		OFFSET scratch			
			push		OFFSET used			
			push		OFFSET charmander_name
			push		OFFSET squirtle_name
			push		OFFSET bulbasaur_name
			push		pokemon_1
			call		print_move_used

			;// calculate damage
			push		OFFSET hp_2			;// hp of computer's pokemon
			push		atk_1				;// atk modifier of player's pokemon
			push		OFFSET def_2			;// def modifier of computer's pokemon
			push		OFFSET atk_2			;// atk modifier of computer's pokemon
			push		2					;// 2 = scratch
			call		calc_damage
			jmp		com_choose_move

		;// if pokemon move player chosen is tail whip
		hum_tail_whip:
			;// print the move used
			push		OFFSET tail_whip
			push		OFFSET used
			push		OFFSET charmander_name
			push		OFFSET squirtle_name
			push		OFFSET bulbasaur_name
			push		pokemon_1
			call		print_move_used

			;// calculate damage
			push		OFFSET hp_2			;// hp of computer's pokemon
			push		atk_1				;// atk modifier of player's pokemon
			push		OFFSET def_2			;// def modifier of computer's pokemon
			push		OFFSET atk_2			;// atk modifier of computer's pokemon
			push		3					;// 3 = tail whip
			call		calc_damage
			jmp		com_choose_move

		;// if pokemon move player chosen is growl
		hum_growl:
			;// print the move used
			push		OFFSET growl			
			push		OFFSET used
			push		OFFSET charmander_name
			push		OFFSET squirtle_name
			push		OFFSET bulbasaur_name
			push		pokemon_1

			;// calculate damage
			push		OFFSET hp_2			;// hp of computer's pokemon
			push		atk_1				;// atk modifier of player's pokemon
			push		OFFSET def_2			;// def modifier of computer's pokemon
			push		OFFSET atk_2			;// atk modifier of computer's pokemon
			push		4					;// 4 = growl
			call		calc_damage
			call		print_move_used

	;// computer player chooses a move
	com_choose_move:
		;// computer randomly chooses a move
		mov		eax, MOVE_HI
		sub		eax, MOVE_LO
		inc		eax
		call		RandomRange
		add		eax, MOVE_LO
		mov		move_2, eax

		;// depending on pokemon, go to its move calculations
		cmp		pokemon_2, 1
		je		choose_com_bulb_move
		cmp		pokemon_2, 2
		je		choose_com_squirtle_move
		jmp		choose_com_char_move

		;// if it's bulbasaur, go to move block depending on move chosen
		choose_com_bulb_move:
			cmp		move_2, 1
			je		com_tackle
			jmp		com_growl

		;// if it's squirtle, go to move block depending on move chosen
		choose_com_squirtle_move:
			cmp		move_2, 1
			je		com_tackle
			jmp		com_tail_whip

		;// if it's charmander, go to move block depending on move chosen
		choose_com_char_move:
			cmp		move_2, 1
			je		com_scratch
			jmp		com_tail_whip

		;// if pokemon move computer player chosen is tackle
		com_tackle:
			;// print the move chosen
			push		OFFSET tackle
			push		OFFSET used
			push		OFFSET charmander_name
			push		OFFSET squirtle_name
			push		OFFSET bulbasaur_name
			push		pokemon_2
			call		print_move_used

			;// calculate damage
			push		OFFSET hp_1		;// hp of player's pokemon
			push		atk_2			;// atk modifier of computer's pokemon
			push		OFFSET def_1		;// defense modifier of player's pokemon
			push		OFFSET atk_1		;// atk modifier of player's pokemon
			push		1				;// 1 = scratch
			call		calc_damage
			jmp		check_done

		;// if pokemon move computer player chosen is scratch
		com_scratch:
			;// print the move chosen
			push		OFFSET scratch
			push		OFFSET used
			push		OFFSET charmander_name
			push		OFFSET squirtle_name
			push		OFFSET bulbasaur_name
			push		pokemon_2
			call		print_move_used
			
			;// calculate damage
			push		OFFSET hp_1		;// hp of player's pokemon
			push		atk_2			;// atk modifier of computer's pokemon
			push		OFFSET def_1		;// defense modifier of player's pokemon
			push		OFFSET atk_1		;// atk modifier of player's pokemon
			push		2				;// 2 = scratch
			call		calc_damage
			jmp		check_done

		;// if pokemon move computer player chosen is tail whip
		com_tail_whip:
			;// print the move chosen
			push		OFFSET tail_whip
			push		OFFSET used
			push		OFFSET charmander_name
			push		OFFSET squirtle_name
			push		OFFSET bulbasaur_name
			push		pokemon_2
			call		print_move_used

			;// calculate damage
			push		OFFSET hp_1		;// hp of player's pokemon
			push		atk_2			;// atk modifier of computer's pokemon
			push		OFFSET def_1		;// def modifier of player's pokemon
			push		OFFSET atk_1		;// atk modifier of player's pokemon
			push		3				;// 3 = tail whip
			call		calc_damage
			jmp		check_done

		;// if pokemon move computer player chosen is growl
		com_growl:
			;// print the move chosen
			push		OFFSET tail_whip
			push		OFFSET used
			push		OFFSET charmander_name
			push		OFFSET squirtle_name
			push		OFFSET bulbasaur_name
			push		pokemon_2
			call		print_move_used

			;// calculate damage
			push		OFFSET hp_1		;// hp of player's pokemon
			push		atk_2			;// atk modifier of computer's pokemon
			push		OFFSET def_1		;// def modifier of player's pokemon
			push		OFFSET atk_1		;// atk modifier of player's pokemon
			push		4				;// 4 = growl
			call		calc_damage

	;// check if a pokemon is down to 0 hp or below
	check_done:
		cmp		hp_1, 1
		jl		battle_lost
		cmp		hp_2, 1
		jl		battle_won
		call		waitMsg
		call		clrscr
		jmp		print_opponent_sprite

	;// if player won, print congrats message
	battle_won:
		call		clrscr
		push		OFFSET win_str
		push		OFFSET happy_pika_24
		push		OFFSET happy_pika_23
		push		OFFSET happy_pika_22
		push		OFFSET happy_pika_21
		push		OFFSET happy_pika_20
		push		OFFSET happy_pika_19
		push		OFFSET happy_pika_18
		push		OFFSET happy_pika_17
		push		OFFSET happy_pika_16
		push		OFFSET happy_pika_15
		push		OFFSET happy_pika_14		
		push		OFFSET happy_pika_13
		push		OFFSET happy_pika_12
		push		OFFSET happy_pika_10
		push		OFFSET happy_pika_9
		push		OFFSET happy_pika_8
		push		OFFSET happy_pika_7
		push		OFFSET happy_pika_6
		push		OFFSET happy_pika_5
		push		OFFSET happy_pika_4
		push		OFFSET happy_pika_3
		push		OFFSET happy_pika_2
		push		OFFSET happy_pika_1
		call		print_congrats
		call		waitMsg
		jmp		the_end

	;// if player lost, print lost message
	battle_lost:
		call		clrscr
		push		OFFSET lose_str
		push		OFFSET sad_pika_23
		push		OFFSET sad_pika_22
		push		OFFSET sad_pika_21
		push		OFFSET sad_pika_20
		push		OFFSET sad_pika_19
		push		OFFSET sad_pika_18
		push		OFFSET sad_pika_17
		push		OFFSET sad_pika_16
		push		OFFSET sad_pika_15
		push		OFFSET sad_pika_14
		push		OFFSET sad_pika_13
		push		OFFSET sad_pika_12
		push		OFFSET sad_pika_10
		push		OFFSET sad_pika_9
		push		OFFSET sad_pika_8
		push		OFFSET sad_pika_7
		push		OFFSET sad_pika_6
		push		OFFSET sad_pika_5
		push		OFFSET sad_pika_4
		push		OFFSET sad_pika_3
		push		OFFSET sad_pika_2
		push		OFFSET sad_pika_1
		call		print_loss
		call		waitMsg

	;// quit the program and exit to operating system
	the_end:
		exit			
main ENDP

;// name: welcome
;// description: prints opening screen to player
;// parameters: all pokemon_logo strings, title_str, author_str, art_credit_str
;// pre-condition: Must contain some string
;// post-condition: none
welcome PROC
	;// base of stack frame
	push		ebp
	mov		ebp, esp

	;// pause program for 1 second
	mov		eax, 750
	call		Delay

	;// print Pokemon logo
	mov		edx, [ebp + 8]
	call		writeString
	call		crlf

	mov		edx, [ebp + 12]
	call		writeString
	call		crlf

	mov		edx, [ebp + 16]
	call		writeString
	call		crlf

	mov		edx, [ebp + 20]
	call		writeString
	call		crlf

	mov		edx, [ebp + 24]
	call		writeString
	call		crlf

	call		Delay			;// pause program for 1 second
	
	mov		edx, [ebp + 28]
	call		writeString
	call		crlf

	mov		edx, [ebp + 32]
	call		writeString
	call		crlf

	mov		edx, [ebp + 36]
	call		writeString
	call		crlf

	mov		edx, [ebp + 40]
	call		writeString
	call		crlf

	call		Delay			;// pause program for 1 second

	mov		edx, [ebp + 44]
	call		writeString
	call		crlf

	mov		edx, [ebp + 48]
	call		writeString
	call		crlf

	mov		edx, [ebp + 52]
	call		writeString
	call		crlf

	mov		edx, [ebp + 56]
	call		writeString
	call		crlf
	call		crlf

	call		Delay			;// pause program for 1 second

	;// print Battle Simulator
	mov		edx, [ebp + 60]
	call		writeString
	call		crlf
	call		crlf

	;// print author string
	mov		edx, [ebp + 64]
	call		writeString
	call		crlf

	;// print art credit
	mov		edx, [ebp + 68]
	call		writeString
	call		crlf
	call		crlf

	;// wait for user to enter a key and clear screen
	call		waitMsg
	call		clrscr

	;// return to main
	pop		ebp
	ret		56
welcome ENDP

;// name: randomize_pokemon
;// description: Randomly choose pokemon for each player
;// parameters: pokemon_1, pokemon_2
;// pre-condition: None
;// post-condition: pokemon_1 and pokemon_2 will be set to 1, 2, or 3
randomize_pokemon PROC
	;// base of stack frame
	push		ebp
	mov		ebp, esp

	;// assign random pokemon to trainers
	;// 1 is bulbasaur, 2 is squirtle, and 3 is charmander
	call		Randomize

	;// assign pokemon to human trainer
	trainer_1:
		mov		eax, POKEMON_HI
		sub		eax, POKEMON_LO
		inc		eax
		call		RandomRange
		add		eax, POKEMON_LO
		mov		edx, [ebp + 8]
		mov		[edx], eax 

	;// assign pokemon to computer trainer
	trainer_2:
		mov		eax, POKEMON_HI
		sub		eax, POKEMON_LO
		inc		eax
		call		RandomRange
		add		eax, POKEMON_LO
		mov		ebx, [ebp + 12]
		mov		[ebx], eax
		cmp		[edx], eax
		je		trainer_2

	;// return to main
	pop		ebp
	ret		8
randomize_pokemon ENDP

;// name: print_gary_panel
;// description: print strings needed for gary's battle challenge
;// parameters: gary_panel_1 - gary_panel_29
;// pre-condition: 
;// post-condition: 
print_gary_panel PROC
	;// base of stack frame
	push		ebp
	mov		ebp, esp

	;// print Gary challenging the trainer
	call		crlf
	mov		edx, [ebp + 8]
	call		writeString
	call		crlf

	mov		edx, [ebp + 12]
	call		writeString
	call		crlf

	mov		edx, [ebp + 16]
	call		writeString
	call		crlf

	mov		edx, [ebp + 20]
	call		writeString
	call		crlf

	mov		edx, [ebp + 24]
	call		writeString
	call		crlf

	mov		edx, [ebp + 28]
	call		writeString
	call		crlf

	mov		edx, [ebp + 32]
	call		writeString
	call		crlf

	mov		edx, [ebp + 36]
	call		writeString
	call		crlf

	mov		edx, [ebp + 40]
	call		writeString
	call		crlf

	mov		edx, [ebp + 44]
	call		writeString
	call		crlf

	mov		edx, [ebp + 48]
	call		writeString
	call		crlf

	mov		edx, [ebp + 52]
	call		writeString
	call		crlf

	mov		edx, [ebp + 56]
	call		writeString
	call		crlf

	mov		edx, [ebp + 60]
	call		writeString
	call		crlf

	mov		edx, [ebp + 64]
	call		writeString
	call		crlf

	mov		edx, [ebp + 68]
	call		writeString
	call		crlf

	mov		edx, [ebp + 72]
	call		writeString
	call		crlf

	mov		edx, [ebp + 76]
	call		writeString
	call		crlf

	mov		edx, [ebp + 80]
	call		writeString
	call		crlf

	mov		edx, [ebp + 84]
	call		writeString
	call		crlf

	mov		edx, [ebp + 88]
	call		writeString
	call		crlf

	mov		edx, [ebp + 92]
	call		writeString
	call		crlf

	mov		edx, [ebp + 96]
	call		writeString
	call		crlf

	mov		edx, [ebp + 100]
	call		writeString
	call		crlf

	mov		edx, [ebp + 104]
	call		writeString
	call		crlf

	mov		edx, [ebp + 108]
	call		writeString
	call		crlf

	mov		edx, [ebp + 112]
	call		writeString
	call		crlf

	mov		edx, [ebp + 116]
	call		writeString
	call		crlf
	call		crlf

	mov		edx, [ebp + 120]
	call		writeString
	call		crlf
	call		crlf

	;// wait for user to enter a key and clear screen
	call		waitMsg
	call		clrscr

	;// return to main
	pop		ebp
	ret		116
print_gary_panel ENDP

;// name: print_com_hp_bar
;// description: Print computer's hp bar
;// parameters: pokemon's name (OFFSET), hp_2 (value), hp_border (OFFSET), op_spacing_2
;//			 hp0_str (OFFSET), hp25_str (OFFSET), hp50_str (OFFSET), hp75_str (OFFSET),
;//			 hp100_str (OFFSET)
;// pre-condition: hp_2 must be a value from 0 to 20
;// post-condition: None
print_com_hp_bar PROC
	;// base of stack frame
	push		ebp
	mov		ebp, esp

	;// print pokemon's name
	print_name:
		call		crlf
		mov		edx, [ebp + 40]
		call		writeString
		mov		edx, [ebp + 8]
		call		writeString

	;// print top of health bar
	print_top_of_hp_bar:
		call		crlf
		mov		edx, [ebp + 40]
		call		writeString
		mov		edx, [ebp + 16]
		call		writeString
		call		crlf

	;// print actual health bar based on pokemon's HP
	check_hp:
		mov		eax, [ebp + 12]
		cmp		eax, 3
		jl		print_0
		cmp		eax, 8
		jl		print_25
		cmp		eax, 13
		jl		print_50
		cmp		eax, 18
		jl		print_75
		jmp		print_100

	;// if hp is close to 0-2hp, print hp bar close to 0
	print_0:
		mov		edx, [ebp + 40]
		call		writeString
		mov		edx, [ebp + 36]
		call		writeString
		call		crlf
		jmp		out_of_function

	;// if hp is 3-7hp, print hp bar with 25% left
	print_25:
		mov		edx, [ebp + 40]
		call		writeString
		mov		edx, [ebp + 32]
		call		writeString
		call		crlf
		jmp		out_of_function

	;// if hp is around 8-12hp, print hp bar with 50% left
	print_50:
		mov		edx, [ebp + 40]
		call		writeString
		mov		edx, [ebp + 28]
		call		writeString
		call		crlf
		jmp		out_of_function

	;// if hp is around 13-17hp, print hp bar with 75% left
	print_75: 
		mov		edx, [ebp + 40]
		call		writeString
		mov		edx, [ebp + 24]
		call		writeString
		call		crlf
		jmp		out_of_function

	;// if hp is 18-20hp, print hp bar with 100% left
	print_100:
		mov		edx, [ebp + 40]
		call		writeString
		mov		edx, [ebp + 20]
		call		writeString
		call		crlf

	;// print last border and return to main
	out_of_function:
		mov		edx, [ebp + 40]
		call		writeString
		mov		edx, [ebp + 16]
		call		writeString
		call		crlf
		pop		ebp
		ret		36
print_com_hp_bar ENDP

;// name: print_hum_hp_bar
;// description: Print human's hp bar
;// parameters: pokemon's name (OFFSET), hp_1 (value), hp_border (OFFSET), op_spacing_2
;//			 hp0_str (OFFSET), hp25_str (OFFSET), hp50_str (OFFSET), hp75_str (OFFSET),
;//			 hp100_str (OFFSET)
;// pre-condition: hp_1 must be a value from 0 to 20
;// post-condition: None
print_hum_hp_bar PROC
	;// base of stack frame
	push		ebp
	mov		ebp, esp

	;// print pokemon's
	print_name:
		call		crlf
		mov		edx, [ebp + 40]		;// print tab (tab = [ebp + 40])
		call		writeString
		mov		edx, [ebp + 8]			;// print name
		call		writeString

	;// print numeric hp value
	print_actual_hp:
		mov		al, ' '
		call		writeChar
		mov		al, '('
		call		writeChar
		mov		eax, [ebp + 12]
		call		writeDec
		mov		al, '/'
		call		writeChar
		mov		eax, 20
		call		writeDec
		mov		al, ' '
		call		writeChar
		mov		al, 'H'
		call		writeChar
		mov		al, 'P'
		call		writeChar
		mov		al, ')'
		call		writeChar

	;// print top of health bar
	print_top_of_hp_bar:
		call		crlf
		mov		edx, [ebp + 40]
		call		writeString
		mov		edx, [ebp + 16]
		call		writeString
		call		crlf

	;// print actual health bar based on pokemon's HP
	check_hp:
		mov		eax, [ebp + 12]
		cmp		eax, 3
		jl		print_0
		cmp		eax, 8
		jl		print_25
		cmp		eax, 13
		jl		print_50
		cmp		eax, 18
		jl		print_75
		jmp		print_100

	;// if hp is close to 0-2hp, print hp bar close to 0
	print_0:
		mov		edx, [ebp + 40]
		call		writeString
		mov		edx, [ebp + 36]
		call		writeString
		call		crlf
		jmp		out_of_function

	;// if hp is 3-7hp, print hp bar with 25% left
	print_25:
		mov		edx, [ebp + 40]
		call		writeString
		mov		edx, [ebp + 32]
		call		writeString
		call		crlf
		jmp		out_of_function

	;// if hp is around 8-12hp, print hp bar with 50% left
	print_50:
		mov		edx, [ebp + 40]
		call		writeString
		mov		edx, [ebp + 28]
		call		writeString
		call		crlf
		jmp		out_of_function

	;// if hp is around 13-17hp, print hp bar with 75% left
	print_75:
		mov		edx, [ebp + 40]
		call		writeString
		mov		edx, [ebp + 24]
		call		writeString
		call		crlf
		jmp		out_of_function

	;// if hp is 18-20hp, print hp bar with 100% left
	print_100:
		mov		edx, [ebp + 40]
		call		writeString
		mov		edx, [ebp + 20]
		call		writeString
		call		crlf

	;// print last border and return to main
	out_of_function:
		mov		edx, [ebp + 40]
		call		writeString
		mov		edx, [ebp + 16]
		call		writeString
		call		crlf
		pop		ebp
		ret		36
print_hum_hp_bar ENDP

;// name: print_opponent_bulbasaur
;// description: print opponent's bulbasaur sprite
;// parameters: op_spacing_1 (OFFSET) and OFFSETs of bulbasaur's ASCII art
;// pre-condition: Must be OFFSETs
;// post-condition: None
print_opponent_bulbasaur PROC
	;// base of stack frame
	push		ebp
	mov		ebp, esp
	pushad

	;// print bulbasaur ASCII art
	mov		edx, [ebp + 96]		;// [ebp + 96] is tab spacing
	call		writeString
	mov		edx, [ebp + 8]
	call		writeString
	call		crlf

	mov		edx, [ebp + 96]
	call		writeString
	mov		edx, [ebp + 12]
	call		writeString
	call		crlf

	mov		edx, [ebp + 96]
	call		writeString
	mov		edx, [ebp + 16]
	call		writeString
	call		crlf

	mov		edx, [ebp + 96]
	call		writeString
	mov		edx, [ebp + 20]
	call		writeString
	call		crlf

	mov		edx, [ebp + 96]
	call		writeString
	mov		edx, [ebp + 24]
	call		writeString
	call		crlf

	mov		edx, [ebp + 96]
	call		writeString
	mov		edx, [ebp + 28]
	call		writeString
	call		crlf

	mov		edx, [ebp + 96]
	call		writeString
	mov		edx, [ebp + 32]
	call		writeString
	call		crlf

	mov		edx, [ebp + 96]
	call		writeString
	mov		edx, [ebp + 36]
	call		writeString
	call		crlf

	mov		edx, [ebp + 96]
	call		writeString
	mov		edx, [ebp + 40]
	call		writeString
	call		crlf

	mov		edx, [ebp + 96]
	call		writeString
	mov		edx, [ebp + 44]
	call		writeString
	call		crlf

	mov		edx, [ebp + 96]
	call		writeString
	mov		edx, [ebp + 48]
	call		writeString
	call		crlf

	mov		edx, [ebp + 96]
	call		writeString
	mov		edx, [ebp + 52]
	call		writeString
	call		crlf

	mov		edx, [ebp + 96]
	call		writeString
	mov		edx, [ebp + 56]
	call		writeString
	call		crlf

	mov		edx, [ebp + 96]
	call		writeString
	mov		edx, [ebp + 60]
	call		writeString
	call		crlf

	mov		edx, [ebp + 96]
	call		writeString
	mov		edx, [ebp + 64]
	call		writeString
	call		crlf

	mov		edx, [ebp + 96]
	call		writeString
	mov		edx, [ebp + 68]
	call		writeString
	call		crlf

	mov		edx, [ebp + 96]
	call		writeString
	mov		edx, [ebp + 72]
	call		writeString
	call		crlf

	mov		edx, [ebp + 96]
	call		writeString
	mov		edx, [ebp + 76]
	call		writeString
	call		crlf

	mov		edx, [ebp + 96]
	call		writeString
	mov		edx, [ebp + 80]
	call		writeString
	call		crlf

	mov		edx, [ebp + 96]
	call		writeString
	mov		edx, [ebp + 84]
	call		writeString
	call		crlf

	mov		edx, [ebp + 96]
	call		writeString
	mov		edx, [ebp + 88]
	call		writeString
	call		crlf

	mov		edx, [ebp + 96]
	call		writeString
	mov		edx, [ebp + 92]
	call		writeString
	call		crlf

	;// return to main
	popad
	pop		ebp
	ret		92
print_opponent_bulbasaur ENDP


;// name: print_opponent_char_or_squirtle
;// description: Print ASCII for charmander or squirtle
;// parameters: op_spacing_1 (OFFSET), and OFFSETs of all of pokemon's ASCII art
;// pre-condition: Must be OFFSETS
;// post-condition: None
print_opponent_char_or_squirtle PROC
	;// base of stack frame
	push		ebp
	mov		ebp, esp
	pushad

	;// print charmander or squirtle ASCII art
	mov		edx, [ebp + 108];// [ebp + 108] is the tab spacing
	call		writeString
	mov		edx, [ebp + 8]
	call		writeString
	call		crlf

	mov		edx, [ebp + 108]
	call		writeString
	mov		edx, [ebp + 12]
	call		writeString
	call		crlf

	mov		edx, [ebp + 108]
	call		writeString
	mov		edx, [ebp + 16]
	call		writeString
	call		crlf

	mov		edx, [ebp + 108]
	call		writeString
	mov		edx, [ebp + 20]
	call		writeString
	call		crlf

	mov		edx, [ebp + 108]
	call		writeString
	mov		edx, [ebp + 24]
	call		writeString
	call		crlf

	mov		edx, [ebp + 108]
	call		writeString
	mov		edx, [ebp + 28]
	call		writeString
	call		crlf

	mov		edx, [ebp + 108]
	call		writeString
	mov		edx, [ebp + 32]
	call		writeString
	call		crlf

	mov		edx, [ebp + 108]
	call		writeString
	mov		edx, [ebp + 36]
	call		writeString
	call		crlf

	mov		edx, [ebp + 108]
	call		writeString
	mov		edx, [ebp + 40]
	call		writeString
	call		crlf

	mov		edx, [ebp + 108]
	call		writeString
	mov		edx, [ebp + 44]
	call		writeString
	call		crlf

	mov		edx, [ebp + 108]
	call		writeString
	mov		edx, [ebp + 48]
	call		writeString
	call		crlf

	mov		edx, [ebp + 108]
	call		writeString
	mov		edx, [ebp + 52]
	call		writeString
	call		crlf

	mov		edx, [ebp + 108]
	call		writeString
	mov		edx, [ebp + 56]
	call		writeString
	call		crlf

	mov		edx, [ebp + 108]
	call		writeString
	mov		edx, [ebp + 60]
	call		writeString
	call		crlf

	mov		edx, [ebp + 108]
	call		writeString
	mov		edx, [ebp + 64]
	call		writeString
	call		crlf

	mov		edx, [ebp + 108]
	call		writeString
	mov		edx, [ebp + 68]
	call		writeString
	call		crlf

	mov		edx, [ebp + 108]
	call		writeString
	mov		edx, [ebp + 72]
	call		writeString
	call		crlf

	mov		edx, [ebp + 108]
	call		writeString
	mov		edx, [ebp + 76]
	call		writeString
	call		crlf

	mov		edx, [ebp + 108]
	call		writeString
	mov		edx, [ebp + 80]
	call		writeString
	call		crlf

	mov		edx, [ebp + 108]
	call		writeString
	mov		edx, [ebp + 84]
	call		writeString
	call		crlf

	mov		edx, [ebp + 108]
	call		writeString
	mov		edx, [ebp + 88]
	call		writeString
	call		crlf

	mov		edx, [ebp + 108]
	call		writeString
	mov		edx, [ebp + 92]
	call		writeString
	call		crlf

	mov		edx, [ebp + 108]
	call		writeString
	mov		edx, [ebp + 96]
	call		writeString
	call		crlf

	mov		edx, [ebp + 108]
	call		writeString
	mov		edx, [ebp + 100]
	call		writeString
	call		crlf

	mov		edx, [ebp + 108]
	call		writeString
	mov		edx, [ebp + 104]
	call		writeString
	call		crlf

	;// return to main
	popad
	pop		ebp
	ret		104
print_opponent_char_or_squirtle ENDP

;// name: print_player_bulbasaur
;// description: print player's bulbasaur sprite
;// parameters: OFFSETs of bulbasaur's ASCII art
;// pre-condition: Must be OFFSETs
;// post-condition: None
print_player_bulbasaur PROC
	;// base of stack frame
	push		ebp
	mov		ebp, esp
	pushad

	;// print pokemon ASCII art
	mov		edx, [ebp + 8]
	call		writeString
	call		crlf

	mov		edx, [ebp + 12]
	call		writeString
	call		crlf

	mov		edx, [ebp + 16]
	call		writeString
	call		crlf

	mov		edx, [ebp + 20]
	call		writeString
	call		crlf

	mov		edx, [ebp + 24]
	call		writeString
	call		crlf

	mov		edx, [ebp + 28]
	call		writeString
	call		crlf

	mov		edx, [ebp + 32]
	call		writeString
	call		crlf

	mov		edx, [ebp + 36]
	call		writeString
	call		crlf

	mov		edx, [ebp + 40]
	call		writeString
	call		crlf

	mov		edx, [ebp + 44]
	call		writeString
	call		crlf

	mov		edx, [ebp + 48]
	call		writeString
	call		crlf

	mov		edx, [ebp + 52]
	call		writeString
	call		crlf

	mov		edx, [ebp + 56]
	call		writeString
	call		crlf

	mov		edx, [ebp + 60]
	call		writeString
	call		crlf

	mov		edx, [ebp + 64]
	call		writeString
	call		crlf

	mov		edx, [ebp + 68]
	call		writeString
	call		crlf

	mov		edx, [ebp + 72]
	call		writeString
	call		crlf

	mov		edx, [ebp + 76]
	call		writeString
	call		crlf

	mov		edx, [ebp + 80]
	call		writeString
	call		crlf

	mov		edx, [ebp + 84]
	call		writeString
	call		crlf

	;// return to main
	popad
	pop		ebp
	ret		80
print_player_bulbasaur ENDP

;// name: print_player_char_or_squirtle	
;// description: print player's charmander or squirtle sprite
;// parameters: OFFSETs of squirtle's or charmander's ASCII art
;// pre-condition: Must be OFFSETs
;// post-condition: None
print_player_char_or_squirtle PROC
	;// base of stack frame
	push		ebp
	mov		ebp, esp
	pushad

	;// print pokemon ASCII art
	mov		edx, [ebp + 8]
	call		writeString
	call		crlf

	mov		edx, [ebp + 12]
	call		writeString
	call		crlf

	mov		edx, [ebp + 16]
	call		writeString
	call		crlf

	mov		edx, [ebp + 20]
	call		writeString
	call		crlf

	mov		edx, [ebp + 24]
	call		writeString
	call		crlf

	mov		edx, [ebp + 28]
	call		writeString
	call		crlf

	mov		edx, [ebp + 32]
	call		writeString
	call		crlf

	mov		edx, [ebp + 36]
	call		writeString
	call		crlf

	mov		edx, [ebp + 40]
	call		writeString
	call		crlf

	mov		edx, [ebp + 44]
	call		writeString
	call		crlf

	mov		edx, [ebp + 48]
	call		writeString
	call		crlf

	mov		edx, [ebp + 52]
	call		writeString
	call		crlf

	mov		edx, [ebp + 56]
	call		writeString
	call		crlf

	mov		edx, [ebp + 60]
	call		writeString
	call		crlf

	mov		edx, [ebp + 64]
	call		writeString
	call		crlf

	mov		edx, [ebp + 68]
	call		writeString
	call		crlf

	mov		edx, [ebp + 72]
	call		writeString
	call		crlf

	mov		edx, [ebp + 76]
	call		writeString
	call		crlf

	mov		edx, [ebp + 80]
	call		writeString
	call		crlf

	mov		edx, [ebp + 84]
	call		writeString
	call		crlf

	mov		edx, [ebp + 88]
	call		writeString
	call		crlf

	mov		edx, [ebp + 92]
	call		writeString
	call		crlf

	;// return to main
	popad
	pop		ebp
	ret		88
print_player_char_or_squirtle	 ENDP

;// name: print_spacing
;// description: Prints extra spaces
;// parameters: None
;// pre-condition: None
;// post-condition: None
print_spacing PROC 
	pushad

	call		crlf 
	call		crlf
	call		crlf
	call		crlf

	popad
	ret
print_spacing ENDP

;// name: choose_move
;// description: Prompt human player to choose a move
;// parameters: invalid_input (OFFSET), move_1 (OFFSET), strings of two pokemon moves (OFFSET)
;//			 move_prompt_1 (OFFSET), move_prompt_2 (OFFSET), move_prompt_3 (OFFSET),   
;// pre-condition: None
;// post-condition: move_1 will be changed
choose_move PROC 
	;// base of stack frame
	push		ebp
	mov		ebp, esp
	pushad
	jmp		prompt_user

	;// print invalid input message
	print_invalid_input:
		mov		edx, [ebp + 32]
		call		WriteString
		call		crlf

	;// print prompt for a move from user
	prompt_user:
		mov		edx, [ebp + 8]
		call		WriteString
		mov		edx, [ebp + 20]
		call		WriteString
		mov		edx, [ebp + 12]
		call		WriteString 
		mov		edx, [ebp + 24]
		call		WriteString 
		mov		edx, [ebp + 16]
		call		WriteString
		call		ReadInt

	;// validate input (make sure input is 1 or 2)
	validate_input:
		cmp		eax, 1
		jl		print_invalid_input
		cmp		eax, 2
		jg		print_invalid_input

	;// set input as value of move_1
	set_move:
		mov		ebx, [ebp + 28]
		mov		[ebx], eax

	;// return to main
	popad
	pop		ebp
	ret		28
choose_move ENDP

;// name: print_move_used
;// description: Print the pokemon move used
;// parameters: string of move chosen (OFFSET), used (OFFSET), all pokemon names (OFFSET), pokemon (value)
;// pre-condition: None
;// post-condition: None
print_move_used PROC
	;// base of stack frame
	push		ebp
	mov		ebp, esp
	pushad

	;// print name of pokemon depending on what pokemon it is
	mov		eax, [ebp + 8]
	cmp		eax, 1
	je		print_bulb_name_1
	cmp		eax, 2
	je		print_squirtle_name_1
	jmp		print_char_name_1

	;// if it's a bulbasaur, print BULBASAUR
	print_bulb_name_1:
		mov		edx, [ebp + 12]
		call		writeString
		jmp		print_move_1

	;// if it's a squirtle, print SQUIRTLE
	print_squirtle_name_1:
		mov		edx, [ebp + 16]
		call		writeString
		jmp		print_move_1

	;// if it's charmander, print CHARMANDER
	print_char_name_1:
		mov		edx, [ebp + 20]
		call		writeString

	;// print the move chosen
	print_move_1:
		mov		edx,  [ebp + 24]
		call		writeString
		mov		edx, [ebp + 28]
		call		writeString
		mov		al, '.'
		call		writeChar
		call		crlf

	;// return to main
	popad
	pop		ebp
	ret		24
print_move_used ENDP

;// name: calc_damage
;// description: Calculate damage on a pokemon
;// parameters: move (value), target_atk (OFFSET), target_def (OFFSET), atk (value), hp (OFFSET)
;// pre-condition: None
;// post-condition: hp may be changed
calc_damage PROC
	;// base of stack frame
	push		ebp
	mov		ebp, esp
	pushad
	call		Randomize

	;// see which move is used and jump to corresponding calculation block
	mov		eax, [ebp + 8]				;// eax = move
	cmp		eax, 3
	jl		calc_physical
	cmp		eax, 3
	je		calc_tail_whip
	jmp		calc_growl

	;// for pokemon moves TACKLE and SCRATCH
	;// calculate damage depending on own atk stat modifier and opponent's def modifier
	calc_physical:
		mov		eax, [ebp + 20]		;// own pokemon's attack stat modifier
		cmp		eax, 0
		jg		weakened_atk			;// if own atk modifier is more than 0
		mov		edx, [ebp + 16]		
		mov		eax, [edx]			;// opponent's defense stat modifier
		cmp		eax, 0				
		jg		stronger_atk			;// if target's def modifier is more than 0
		jmp		normal_atk			;// if no modifiers are modified

	;// own attack is weakened if own atk modifier is more than 0
	weakened_atk:
		;// calculate damage
		mov		eax, 4
		sub		eax, 1
		inc		eax
		call		RandomRange
		add		eax, 1
		
		;// subtract calculated damage from opponent's hp
		mov		ebx, eax				;// numeric value of damage from atk
		mov		edx, [ebp + 24] 
		mov		eax, [edx]
		sub		eax, ebx
		mov		[edx], eax
		jmp		function_end

	normal_atk:
		;// calculate damage
		mov		eax, 5
		sub		eax, 2
		inc		eax
		call		RandomRange
		add		eax, 2
		
		;// subtract calculated damage from opponent's hp
		mov		ebx, eax				;// numeric value of damage from atk
		mov		edx, [ebp + 24]
		mov		eax, [edx]
		sub		eax, ebx
		mov		[edx], eax
		jmp		function_end

	;// stronger attack if target's def modifier is more than 0
	stronger_atk:
		;// calculate damage
		mov		eax, 6
		sub		eax, 3
		inc		eax
		call		RandomRange
		add		eax, 3

		;// subtract calculated damage from target's hp
		mov		ebx, eax				;// numeric value of damage from atk
		mov		edx, [ebp + 24]
		mov		eax, [edx]
		sub		eax, ebx
		mov		[edx], eax
		jmp		function_end

	;// if pokemon move chosen is TAIL WHIP, increase target's defense modifier
	calc_tail_whip:
		mov		ebx, [ebp + 16]
		mov		eax, [ebx]
		inc		eax
		mov		[ebx], eax
		jmp		function_end

	;// if pokemon move chosen is GROWL, increase target's atk modifier
	calc_growl:
		mov		ebx, [ebp + 12]
		mov		eax, [ebx]
		inc		eax
		mov		[ebx], eax

	;// return to main
	function_end:
		popad
		pop		ebp
		ret		20
calc_damage ENDP

;// name: print_congrats
;// description: Print a happy pikachu and a congrats on winning the battle
;// parameters: OFFSETs of happy_pika ASCII art and OFFSET of win_str
;// pre-condition: None
;// post-condition: None
print_congrats PROC
	;// base of stack frame
	push		ebp
	mov		ebp, esp
	pushad

	;// print happy pikachu sprite
	mov		edx, [ebp + 8]
	call		writeString
	call		crlf

	mov		edx, [ebp + 12]
	call		writeString
	call		crlf

	mov		edx, [ebp + 16]
	call		writeString
	call		crlf

	mov		edx, [ebp + 20]
	call		writeString
	call		crlf

	mov		edx, [ebp + 24]
	call		writeString
	call		crlf

	mov		edx, [ebp + 28]
	call		writeString
	call		crlf

	mov		edx, [ebp + 32]
	call		writeString
	call		crlf

	mov		edx, [ebp + 36]
	call		writeString
	call		crlf

	mov		edx, [ebp + 40]
	call		writeString
	call		crlf

	mov		edx, [ebp + 44]
	call		writeString
	call		crlf

	mov		edx, [ebp + 48]
	call		writeString
	call		crlf

	mov		edx, [ebp + 52]
	call		writeString
	call		crlf

	mov		edx, [ebp + 56]
	call		writeString
	call		crlf

	mov		edx, [ebp + 60]
	call		writeString
	call		crlf

	mov		edx, [ebp + 64]
	call		writeString
	call		crlf

	mov		edx, [ebp + 68]
	call		writeString
	call		crlf

	mov		edx, [ebp + 72]
	call		writeString
	call		crlf

	mov		edx, [ebp + 76]
	call		writeString
	call		crlf

	mov		edx, [ebp + 80]
	call		writeString
	call		crlf

	mov		edx, [ebp + 84]
	call		writeString
	call		crlf

	mov		edx, [ebp + 88]
	call		writeString
	call		crlf

	mov		edx, [ebp + 92]
	call		writeString
	call		crlf

	mov		edx, [ebp + 96]
	call		writeString
	call		crlf
	call		crlf

	;// print congrats message
	mov		edx, [ebp + 100]
	call		writeString
	call		crlf
	call		crlf

	;// return to main
	popad
	pop		ebp
	ret		100
print_congrats ENDP

;// name: print_loss
;// description: Print a surprised pikachu and a string saying the player lost the battle
;// parameters: OFFSETs of sad_pika ASCII art and OFFSET of lose_str
;// pre-condition: None
;// post-condition: None
print_loss PROC
	;// base of stack frame
	push		ebp
	mov		ebp, esp
	pushad

	;// print surprised pikachu sprite
	mov		edx, [ebp + 8]
	call		writeString
	call		crlf

	mov		edx, [ebp + 12]
	call		writeString
	call		crlf

	mov		edx, [ebp + 16]
	call		writeString
	call		crlf

	mov		edx, [ebp + 20]
	call		writeString
	call		crlf

	mov		edx, [ebp + 24]
	call		writeString
	call		crlf

	mov		edx, [ebp + 28]
	call		writeString
	call		crlf

	mov		edx, [ebp + 32]
	call		writeString
	call		crlf

	mov		edx, [ebp + 36]
	call		writeString
	call		crlf

	mov		edx, [ebp + 40]
	call		writeString
	call		crlf

	mov		edx, [ebp + 44]
	call		writeString
	call		crlf

	mov		edx, [ebp + 48]
	call		writeString
	call		crlf

	mov		edx, [ebp + 52]
	call		writeString
	call		crlf

	mov		edx, [ebp + 56]
	call		writeString
	call		crlf

	mov		edx, [ebp + 60]
	call		writeString
	call		crlf

	mov		edx, [ebp + 64]
	call		writeString
	call		crlf

	mov		edx, [ebp + 68]
	call		writeString
	call		crlf

	mov		edx, [ebp + 72]
	call		writeString
	call		crlf

	mov		edx, [ebp + 76]
	call		writeString
	call		crlf

	mov		edx, [ebp + 80]
	call		writeString
	call		crlf

	mov		edx, [ebp + 84]
	call		writeString
	call		crlf

	mov		edx, [ebp + 88]
	call		writeString
	call		crlf

	mov		edx, [ebp + 92]
	call		writeString
	call		crlf
	call		crlf

	;// print loss message
	mov		edx, [ebp + 96]
	call		writeString
	call		crlf
	call		crlf

	;// return to main
	popad
	pop		ebp
	ret		96
print_loss ENDP

END main