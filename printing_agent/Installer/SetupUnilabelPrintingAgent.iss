[Files]
Source: ..\Win32\Release\UnilabelPrintingAgent.exe; DestDir: {userappdata}\UnilabelPrintingAgent; DestName: UnilabelPrintingAgent.exe; Flags: 32bit
Source: ..\..\lib_files\PPLA\32bits\Winppla.dll; DestDir: {userappdata}\UnilabelPrintingAgent; Flags: 32bit
Source: ..\..\lib_files\PPLA\32bits\WinPort.dll; DestDir: {userappdata}\UnilabelPrintingAgent; Flags: 32bit
Source: ..\..\lib_files\PPLA\32bits\WinPort.lib; DestDir: {userappdata}\UnilabelPrintingAgent; Flags: 32bit
Source: ..\..\lib_files\PPLA\32bits\Winppla.lib; DestDir: {userappdata}\UnilabelPrintingAgent; Flags: 32bit
[Run]
Filename: {userappdata}\UnilabelPrintingAgent\UnilabelPrintingAgent.exe; Flags: nowait
[Setup]
AppName=Unilabel Printing Agent
AppVerName=Unilabel Printing Agent 2.0
DefaultDirName={userappdata}\UnilabelPrintingAgent
LanguageDetectionMethod=locale
PrivilegesRequired=none
