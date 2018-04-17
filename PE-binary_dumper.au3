#cs

      Trancexx's idea from autoitscript.com forum
	  Automated by : 9aylas

	  Greetz to  :
	      Ghosty - AX302 - Redwan Red - EliteTrojan - Erreur404 - Sudo_Root
		  TheHappyBit - DebAAkrem - Hacker-Fire - Indoushka - And all ^_^ ...


#ce

#pragma compile(ProductName, PE Binary Dumper)

#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#Region ### START GUI ###
$bnina = GUICreate(" PE Binary Dumper ", 426, 382, 192, 114)
$loadpe = GUICtrlCreateButton("Load ...", 232, 8, 67, 23)
$path = GUICtrlCreateInput("", 16, 8, 209, 21)
$bin_res = GUICtrlCreateEdit("", 16, 40, 393, 305, BitOR($ES_AUTOVSCROLL,$ES_AUTOHSCROLL,$ES_WANTRETURN,$WS_VSCROLL))
$genbin = GUICtrlCreateButton("GEN IT", 341, 8, 67, 23)
$cp = GUICtrlCreateButton("Copy ...", 16, 352, 75, 25)
$help = GUICtrlCreateButton("&Help ?", 336, 352, 75, 25)
GUISetState(@SW_SHOW)
#EndRegion ### END GUI ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		 case $loadpe
			loading()
		 case $genbin
			hell()
		 case $cp
			copy()
		 case $help
			MsgBox(0x0000,""," You may need this tool to run a PE from memory ."& @crlf& " Or to write your PE, ...etc " & @crlf& " You can read more about it ..." &@CRLF&""&@CRLF&"Ps : These result of strings you get , works only as AutoIt ..." &@CRLF&""&@CRLF&"./9aylas ~ End of file.")
			; https://www.autoitscript.com/forum/topic/116040-run-exe-from-memory-3264-bit/  <-- something like this :)
	EndSwitch
WEnd

func loading()
Global $sModule = FileOpenDialog("Load your exe file",@ScriptDir,"(*.exe)")
GUICtrlSetData($path,$sModule)
Global $hModule = FileOpen($sModule, 16)
If @error Then  Exit
EndFunc


   func hell()

Global $bBinary = FileRead($hModule)
FileClose($hModule)

Global Const $MAX_LINESIZE = 4095
Global $iNewLine, $j
Global $iChinkSize = 32
Global $sBinary


For $i = 1 To BinaryLen($bBinary) Step $iChinkSize

    $j += 1

    If 4*($j * $iChinkSize) > $MAX_LINESIZE - 129 Then
        $iNewLine = 1
    EndIf

    If $iNewLine Then
        $iNewLine = 0
        $j = 0
        $sBinary = StringTrimRight($sBinary, 5)
        $sBinary &= @CRLF & '$x &= "' & StringTrimLeft(BinaryMid($bBinary, $i, $iChinkSize), 2) & '" & _' & @CRLF
        ContinueLoop
    EndIf

    If $i = 1 Then
        $sBinary &= '$x = "' & BinaryMid($bBinary, $i, $iChinkSize) & '" & _' & @CRLF
    Else
        $sBinary &= '       "' & StringTrimLeft(BinaryMid($bBinary, $i, $iChinkSize), 2) & '" & _' & @CRLF
    EndIf

Next

$sBinary = StringTrimRight($sBinary, 5)
GUICtrlSetData($bin_res,$sBinary)
EndFunc


func copy()

   ClipPut($sBinary)
   Sleep(600)
   MsgBox(0x0000,""," Done ")
   EndFunc
