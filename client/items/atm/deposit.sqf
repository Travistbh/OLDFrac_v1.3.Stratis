// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: deposit.sqf
//	@file Author: AgentRev
//	@file Function: mf_items_atm_deposit

#include "gui_defines.hpp"

#define ERR_NOT_ENOUGH_FUNDS "You don't have enough money."
#define ERR_MAX_BALANCE "Your account has reached the maximum balance."

disableSerialization;
private ["_dialog", "_input", "_amount", "_balance", "_maxBalance", "_mBalance"];

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
_mBalance = ["A3W_atmMaxBalance", 1000000] call getPublicVar;

_gearLevel = player getVariable ["gear", 0];
_maxBalance = switch (_donatorLevel) do
   {
    case 1: {_maxBalance + 1000000;};
	case 2: {_maxBalance + 2000000;};
	case 3: {_maxBalance + 3000000;};
	case 4: {_maxBalance + 4000000;};
	case 5: {_maxBalance + 5000000;};
	case 6: {_maxBalance + 6000000;};
	case 7: {_maxBalance + 7000000;};
	case 8: {_maxBalance + 8000000;};
	case 9: {_maxBalance + 9000000;};
	case 10: {_maxBalance + 9000000;};
	case 11: {_maxBalance + 900000;};
	case 12: {_maxBalance + 9000000;};
	case 13: {_maxBalance + 9000000;};
	case 14: {_maxBalance + 24000000;};
	case 15: {_maxBalance + 24000000;};
	case 16: {_maxBalance + 24000000;};
	default {_maxBalance};
   };

if (_balance + _amount > _mBalance) then
{
	_amount = 0 max (_m3Balance - _balance);
};

if (_amount < 1) exitWith
{
	[ERR_MAX_BALANCE, 5] call mf_notify_client;
	playSound "FD_CP_Not_Clear_F";
};

_input ctrlSetText (_amount call fn_numToStr);

pvar_processTransaction = ["atm", player, _amount];
publicVariableServer "pvar_processTransaction";
