// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: deposit.sqf
//	@file Author: AgentRev
//	@file Function: mf_items_atm_deposit

#include "gui_defines.hpp"

_gearsEnabled = ["A3W_gearsEnabled"] call isConfigOn;
_gearLevel = player getVariable ["gear", 0];

#define ERR_NOT_ENOUGH_FUNDS "You don't have enough money."
#define ERR_MAX_BALANCE "Your account has reached the maximum balance."

disableSerialization;
private ["_dialog", "_input", "_amount", "_balance", "_maxBalance"];

_dialog = findDisplay AtmGUI_IDD;

if (isNull _dialog) exitWith {};

_input = _dialog displayCtrl AtmAmountInput_IDC;
_amount = _input call mf_verify_money_input;

if (_amount < 1) exitWith {};

if (player getVariable ["cmoney", 0] < _amount) exitWith
{
	[ERR_NOT_ENOUGH_FUNDS, 5] call mf_notify_client;
	playSound "FD_CP_Not_Clear_F";
};

_balance = player getVariable ["bmoney", 0];

if (_gearLevel <= 0) then
{
	_maxBalance = ["A3W_atmMaxBalance", 1000000] call getPublicVar;
};
if (_gearLevel == 1) then
{
	_maxBalance = 2000000;
};
if (_gearLevel == 2 then
{
	_maxBalance = 3000000;
};
if (_gearLevel == 3 then
{
	_maxBalance = 4000000;
};
if (_gearLevel == 4 then
{
	_maxBalance = 5000000;
};
if (_gearLevel == 5 then
{
	_maxBalance = 6000000;
};
if (_gearLevel == 6 then
{
	_maxBalance = 7000000;
};
if (_gearLevel == 7 then
{
	_maxBalance = 8000000;
};
if (_gearLevel == 8 then
{
	_maxBalance = 9000000;
};
if (_gearLevel == 9 then
{
	_maxBalance = 10000000;
};
if (_gearLevel == 10 then
{
	_maxBalance = 10000000;
};
if (_gearLevel == 11 then
{
	_maxBalance = 10000000;
};
if (_gearLevel == 12 then
{
	_maxBalance = 10000000;
};
if (_gearLevel == 13 then
{
	_maxBalance = 10000000;
};
if (_gearLevel == 14 then
{
	_maxBalance = 10000000;
};
if (_gearLevel >= 15 then
{
	_maxBalance = 25000000;
};



if (_balance + _amount > _maxBalance) then
{
	_amount = 0 max (_maxBalance - _balance);
};

if (_amount < 1) exitWith
{
	[ERR_MAX_BALANCE, 5] call mf_notify_client;
	playSound "FD_CP_Not_Clear_F";
};

_input ctrlSetText (_amount call fn_numToStr);

pvar_processTransaction = ["atm", player, _amount];
publicVariableServer "pvar_processTransaction";
