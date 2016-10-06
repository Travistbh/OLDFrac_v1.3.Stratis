// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: refresh_amounts.sqf
//	@file Author: AgentRev
//	@file Function: mf_items_atm_refresh_amounts

#include "gui_defines.hpp"
disableSerialization;

private ["_dialog", "_balance", "_amountInput", "_accDropdown", "_feeText", "_totalText", "_bmoney", "_balanceText", "_amount", "_fee", "_feeAmount", "_selAcc"];

_gearsEnabled = ["A3W_gearsEnabled"] call isConfigOn;
_gearLevel = player getVariable ["gear", 0];

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

_dialog = findDisplay AtmGUI_IDD;

if (isNull _dialog) exitWith {};

_balance = _dialog displayCtrl AtmBalanceText_IDC;
_amountInput = _dialog displayCtrl AtmAmountInput_IDC;
_accDropdown = _dialog displayCtrl AtmAccountDropdown_IDC;
_feeText = _dialog displayCtrl AtmFeeText_IDC;
_totalText = _dialog displayCtrl AtmTotalText_IDC;

_bmoney = player getVariable ["bmoney", 0];
_balanceText = format ["$%1", [player getVariable ["bmoney", 0]] call fn_numbersText];
if (_bmoney >= _maxBalance) then { _balanceText = format ["<t color='#FFA080'>%1</t>", _balanceText] };

_balance ctrlSetStructuredText parseText _balanceText;

_amount = 0 max floor parseNumber ctrlText _amountInput;
if (!finite _amount) then { _amount = 0 };

_fee = (["A3W_atmTransferFee", 5] call getPublicVar) max 0 min 50;
_feeAmount = 0;
_selAcc = call compile (_accDropdown lbData lbCurSel _accDropdown);

if (!isNil "_selAcc" && {_selAcc != player}) then
{
	_feeAmount = ceil (_amount * (_fee / 100));
	_feeText ctrlSetText format ["$%1%2", [_feeAmount] call fn_numbersText, if (_feeAmount > 0) then { " (" + str _fee + "%)" } else { "" }];
}
else
{
	_feeText ctrlSetText "-";
};

_totalText ctrlSetText format ["$%1", [_amount + _feeAmount] call fn_numbersText];
