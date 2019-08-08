[Files]
Source: ..\Win64\Release\UnilabelPrintingAgent.exe; DestDir: {userappdata}\UnilabelPrintingAgent; DestName: UnilabelPrintingAgent.exe; Flags: 64bit replacesameversion
Source: ..\..\lib_files\PPLA\64bits\Winppla.dll; DestDir: {userappdata}\UnilabelPrintingAgent; Flags: 64bit
Source: ..\..\lib_files\PPLA\64bits\WinPort.dll; DestDir: {userappdata}\UnilabelPrintingAgent; Flags: 64bit
Source: ..\..\lib_files\PPLA\64bits\WinPort.lib; DestDir: {userappdata}\UnilabelPrintingAgent; Flags: 64bit
Source: ..\..\lib_files\PPLA\64bits\Winppla.lib; DestDir: {userappdata}\UnilabelPrintingAgent; Flags: 64bit
[Run]
Filename: {userappdata}\UnilabelPrintingAgent\UnilabelPrintingAgent.exe; Flags: nowait
[Setup]
AppName=Unilabel Printing Agent
AppVerName=Unilabel Printing Agent 4.1
DefaultDirName={userappdata}\UnilabelPrintingAgent
LanguageDetectionMethod=locale
PrivilegesRequired=none
