[Files]
Source: ..\Win32\Release\UnilabelPrintingAgent.exe; DestDir: {userappdata}\UnilabelPrintingAgent; DestName: UnilabelPrintingAgent.exe
Source: ..\..\lib_files\Winppla.dll; DestDir: {userappdata}\UnilabelPrintingAgent
Source: ..\..\lib_files\WinPort.dll; DestDir: {userappdata}\UnilabelPrintingAgent
Source: ..\..\lib_files\WinPort.lib; DestDir: {userappdata}\UnilabelPrintingAgent
Source: ..\..\lib_files\Winppla.lib; DestDir: {userappdata}\UnilabelPrintingAgent
[Run]
Filename: {userappdata}\UnilabelPrintingAgent\UnilabelPrintingAgent.exe; Flags: nowait
[Setup]
AppName=Unilabel Printing Agent
AppVerName=Unilabel Printing Agent 1.0
DefaultDirName={userappdata}\UnilabelPrintingAgent
LanguageDetectionMethod=locale
PrivilegesRequired=none
