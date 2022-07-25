/*
This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.
*/

#pragma semicolon 1

#include <sourcemod>
#include <sdktools>
#include <cstrike>

#pragma newdecls required

EngineVersion g_Game;

public Plugin myinfo = 
{
	name = "kaccm",
	author = "thunderstorm010 @ github",
	description = "kaccm plugini",
	version = "v1",
	url = "https://"
};

public void OnPluginStart()
{
	g_Game = GetEngineVersion();
	if(g_Game != Engine_CSGO && g_Game != Engine_CSS)
	{
		SetFailState("This plugin is for CSGO/CSS only.");	
	}
	
	RegConsoleCmd("sm_kaccm", Command_KacCm, "Kaccm komutu");
}

int aiPlayersCooldownArray[MAXPLAYERS + 1];


public Action Command_KacCm(int client, int args) {
	int currentTime = GetTime();
	int diff = currentTime - aiPlayersCooldownArray[client];
	if (diff < 30) {
		ReplyToCommand(client, "Malafatının boyunu öğrenmek için \x03%d saniye\x01 daha beklemen gerekiyor.", 30-diff);
		return Plugin_Handled;
	}
	PrintToChatAll("\x06%N\x01, malafatın \x0e%d cm.", client, GetRandomInt(1, 31));
	aiPlayersCooldownArray[client] = currentTime;
	return Plugin_Handled;
}
