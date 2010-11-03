/*
 * GamblingManagerImplementation.cpp
 *
 *  Created on: Apr 11, 2010
 *      Author: swgemu
 */

#include "GamblingManager.h"
#include "server/zone/objects/player/PlayerCreature.h"
#include "server/zone/objects/player/sui/listbox/SuiListBox.h"
#include "server/zone/objects/tangible/terminal/gambling/GamblingTerminal.h"
#include "server/zone/managers/terrain/TerrainManager.h"
#include "server/zone/Zone.h"
#include "server/zone/managers/planet/PlanetManager.h"
#include "server/zone/ZoneServer.h"
#include "server/zone/objects/scene/variables/ParameterizedStringId.h"
#include "system/util/Vector.h"
#include "system/util/VectorMap.h"
#include "server/zone/managers/minigames/events/GamblingEvent.h"
#include "server/zone/objects/player/sui/slotmachinebox/SuiSlotMachineBox.h"
#include "server/zone/managers/minigames/GamblingBet.h"
#include "engine/service/proto/BaseMessage.h"
#include "server/zone/managers/minigames/events/GamblingEvent.h"

void GamblingManagerImplementation::registerPlayer(GamblingTerminal* terminal, PlayerCreature* player) {
	if (terminal == NULL || player == NULL)
		return;

	Locker _locker(_this);
	switch (terminal->getMachineType()) {
		case GamblingTerminal::SLOTMACHINE: {
			slotGames.put(player, terminal);
			break;
		}
		case GamblingTerminal::ROULETTEMACHINE: {
			rouletteGames.put(player, terminal);
			break;
		}
	}
}

uint32 GamblingManagerImplementation::createWindow(GamblingTerminal* terminal, PlayerCreature* player) {
	if (terminal == NULL || player == NULL)
		return 0;

	uint32 boxID=0;

	switch (terminal->getMachineType()) {
		case GamblingTerminal::SLOTMACHINE: {

			boxID = createPayoutWindow(player);
			boxID = createSlotWindow(player, boxID);

			break;
		}
		case GamblingTerminal::ROULETTEMACHINE: {

			boxID = createRouletteWindow(player);

			break;
		}
	}

	return boxID;
}

uint32 GamblingManagerImplementation::createSlotWindow(PlayerCreature* player, uint32 payoutBoxID) {
	if (player == NULL)
		return 0;

	ManagedReference<GamblingTerminal*> terminal = slotGames.get(player);

	if (terminal == NULL)
		return 0;

	String prompt = "Press the button corresponding to the desired action.";

	int amount = 0;

	bool quit = true;

	if (!terminal->getBets()->isEmpty()) {
		amount = terminal->getBets()->get(0)->getAmount();
		quit = false;
	}


	// create new window
	ManagedReference<SuiSlotMachineBox*> box = new SuiSlotMachineBox(player, 121, payoutBoxID, 3);
	box->setPromptTitle("@gambling/game_n:slot_standard");
	box->setPromptText(prompt);
	box->addMenuItem("Current Bet: " + String::valueOf(amount), 0);
	box->addMenuItem("Max Bet: " + String::valueOf(terminal->getMaxBet()), 1);
	box->addMenuItem("Cash Balance: " + String::valueOf(player->getCashCredits()), 2);
	box->addMenuItem("Bank Balance: " + String::valueOf(player->getBankCredits()), 3);
	box->addMenuItem("Total Money: " + String::valueOf(player->getCashCredits() + player->getBankCredits()), 4);

	if (quit)
		box->setCancelButton(true, "@ui:quit");
	else
		box->setCancelButton(true, "@ui:spin");

	box->setOtherButton(true,"@ui:bet_one");
	box->setOkButton(true, "@ui:bet_max");
	player->addSuiBox(box);
	BaseMessage* test = box->generateMessage();

	player->sendMessage(test);

	return box->getBoxID();
}

uint32 GamblingManagerImplementation::createRouletteWindow(PlayerCreature* player) {
	if (player == NULL)
		return 0;

	int totalBet = 0;

	String prompt = "The following is a summary of your current bets...\n\nUse /bet <amount> <1-36,0,00,red,black,odd,even,high,low> to wager.\nExample: '/bet 5 black' to wager 5 credits on black\n\nCash : "
			+ String::valueOf(player->getCashCredits())
			+ "\nBank : "
			+ String::valueOf(player->getBankCredits())
			+ "\nTotal: "
			+ String::valueOf(player->getCashCredits() + player->getBankCredits())
			+ "\n\nNOTE: If you leave the table after placing a bet, all of your outstanding bets will be forfeit.";

	// create new window
	ManagedReference<SuiListBox*> box = new SuiListBox(player, 120, 2);
	box->setPromptTitle("@gambling/game_n:roulette");
	box->setPromptText(prompt);

	ManagedReference<GamblingTerminal*> terminal = rouletteGames.get(player);
	if (terminal->getBets()->size() != 0) {
		for (int i=0; i < terminal->getBets()->size(); ++i) {
			if (terminal->getBets()->get(i)->getPlayer() == player) {
				totalBet += terminal->getBets()->get(i)->getAmount();
				String target = terminal->getBets()->get(i)->getTarget();
				target[0] = toupper(target[0]);
				box->addMenuItem(target + ": " + String::valueOf(terminal->getBets()->get(i)->getAmount()), i);
			}
		}
	}

	if (totalBet == 0) {
		box->addMenuItem("Total Bet : 0", 0);
	} else {
		box->addMenuItem(" ", -2);
		box->addMenuItem("Total Bet : "+String::valueOf(totalBet), -3);
	}
	box->setCancelButton(true, "@ui:leave_game");
	box->setOtherButton(false, "");
	box->setOkButton(true, "@ui:refresh");
	player->addSuiBox(box);
	player->sendMessage(box->generateMessage());

	return box->getBoxID();
}

uint32 GamblingManagerImplementation::createPayoutWindow(PlayerCreature* player) {
	if (player == NULL)
		return 0;

	String prompt = "The following is the payout schedule for this slot machine.\n \nLegend:\nXXX: denotes any 3 of the same number\n*X|Y|Z: denotes any combination of the 3 numbers";

	// create new window
	ManagedReference<SuiListBox*> box = new SuiListBox(player, 122, 1);
	box->setPromptTitle("PAYOUT SCHEDULE");
	box->setPromptText(prompt);
	box->addMenuItem("*1|2|3 -> base:2 max:6", 0);
	box->addMenuItem("000 -> base:4 max:12", 1);
	box->addMenuItem("111 -> base:50 max:150", 2);
	box->addMenuItem("222 -> base:75 max:225", 3);
	box->addMenuItem("333 -> base:100 max:300", 3);
	box->addMenuItem("444 -> base:250 max:750", 3);
	box->addMenuItem("555 -> base:500 max:1500", 3);
	box->addMenuItem("666 -> base:1000 max:3000", 3);
	box->addMenuItem("777 -> base:1500 max:5000", 3);
	box->setCancelButton(false, "");
	box->setOtherButton(false, "");
	box->setOkButton(true, "@ui:ok");
	player->addSuiBox(box);
	player->sendMessage(box->generateMessage());

	return box->getBoxID();
}

void GamblingManagerImplementation::refreshRouletteMenu(PlayerCreature* player) {

	if (player != NULL) {

		ManagedReference<GamblingTerminal*> terminal = rouletteGames.get(player);
		terminal->closeMenu(player, false);

		terminal->getPlayersWindows()->drop(player);
		terminal->getPlayersWindows()->put(player, createRouletteWindow(player));
	}
}

void GamblingManagerImplementation::refreshSlotMenu(PlayerCreature* player, GamblingTerminal* terminal) {
	if (player == NULL || terminal == NULL)
		return;

	terminal->closeMenu(player, false);

	terminal->getPlayersWindows()->drop(player);
	terminal->getPlayersWindows()->put(player, createSlotWindow(player, 0));
}

void GamblingManagerImplementation::handleSlot(PlayerCreature* player, bool cancel, bool other) {
	if (player == NULL)
		return;



	bool ok = (!cancel && !other);

	ManagedReference<GamblingTerminal*> terminal = slotGames.get(player);

	if (ok) {
		if (terminal->getBets()->isEmpty()) {
			bet(terminal, player, 3, 0);
		} else {
			bet(terminal, player, terminal->getMaxBet() - terminal->getBets()->get(0)->getAmount(), 0);
		}
	} else if (other) {
		bet(terminal, player, 1, 0);
	} else if (cancel) {
		if (terminal->getBets()->isEmpty()) {
			leaveTerminal(player, 1);
		} else {
			startGame(player, 1);
		}
	}
}

void GamblingManagerImplementation::bet(PlayerCreature* player, int amount, int target, int machineType) {
	if (player == NULL)
		return;

	if (machineType == 0) {
		bet(rouletteGames.get(player), player, amount, target);
	} else if (machineType == 1) {
		bet(slotGames.get(player), player, amount, target);
	}
}

void GamblingManagerImplementation::bet(GamblingTerminal* terminal, PlayerCreature* player, int amount, int target) {
	if (player == NULL || terminal == NULL)
		return;

	switch (terminal->getMachineType()) {
		case GamblingTerminal::SLOTMACHINE: {
			if (amount > terminal->getMaxBet()) {

				ParameterizedStringId body("gambling/default_interface","bet_above_max");
				body.setDI(terminal->getMaxBet());

				player->sendSystemMessage(body);

			} else if (player->getCashCredits() < amount) {

				player->sendSystemMessage("@gambling/default_interface:player_broke");

			} else if (!player->isInRange(terminal, 25.0)) {

				player->sendSystemMessage("@gambling/default_interface:bet_failed_distance");

			} else if (amount < terminal->getMinBet()) {

				ParameterizedStringId body("gambling/default_interface","bet_below_min");
				body.setDI(terminal->getMinBet());

				player->sendSystemMessage(body);

			} else {
				Locker _locker(terminal);

				player->setCashCredits(player->getCashCredits() - amount,true);

				ParameterizedStringId textPlayer("base_player","prose_pay_success");
				textPlayer.setDI(amount);

				String terminalName;
				terminal->getObjectName()->getFullPath(terminalName);
				textPlayer.setTT(terminalName);

				player->sendSystemMessage(textPlayer);

				if (!terminal->getBets()->isEmpty()) {
					amount += terminal->getBets()->get(0)->getAmount();
					terminal->getBets()->removeAll();
				}

				terminal->getBets()->add(new GamblingBet(player, amount));

				if (amount >= terminal->getMaxBet())
					startGame(player, 1);
				else
					refreshSlotMenu(player, terminal);
			}
			break;
		}
		case GamblingTerminal::ROULETTEMACHINE: {
			if (amount > terminal->getMaxBet()) {

				ParameterizedStringId body("gambling/default_interface","bet_above_max");
				body.setDI(terminal->getMaxBet());

				player->sendSystemMessage(body);

			} else if (player->getCashCredits() < amount) {

				player->sendSystemMessage("@gambling/default_interface:player_broke");

			} else if (!player->isInRange(terminal, 25.0)) {

				player->sendSystemMessage("@gambling/default_interface:bet_failed_distance");

			} else if (amount < terminal->getMinBet()) {

				ParameterizedStringId body("gambling/default_interface","bet_below_min");
				body.setDI(terminal->getMinBet());

				player->sendSystemMessage(body);

			} else {
				Locker _locker(terminal);
				player->setCashCredits(player->getCashCredits() - amount,true);
				terminal->getBets()->add(new GamblingBet(player, amount, roulette.get(target)));
				ParameterizedStringId textPlayer("gambling/default_interface","prose_bet_placed");
				textPlayer.setDI(amount);
				player->sendSystemMessage(textPlayer);
			}
			break;
		}
	}
}

void GamblingManagerImplementation::startGame(PlayerCreature* player, int machineType) {

	if (player != NULL) {
		switch (machineType) {
			case GamblingTerminal::SLOTMACHINE: {
				startGame(slotGames.get(player));
				break;
			}
			case GamblingTerminal::ROULETTEMACHINE: {
				startGame(rouletteGames.get(player));
				break;
			}
		}
	}
}

void GamblingManagerImplementation::startGame(GamblingTerminal* terminal) {

	if (terminal != NULL) {

		switch (terminal->getMachineType()) {
			case GamblingTerminal::SLOTMACHINE: {

				Locker _locker(terminal);

				terminal->setState(GamblingTerminal::GAMESTARTED);

				//bet(terminal, terminal->getPlayersWindows()->elementAt(0).getKey(), 3, 0);

				terminal->statusUpdate(terminal->getState());

				createEvent(terminal, slotTimer.get(terminal->getState() - 2) * 1000);

				break;
			}
			case GamblingTerminal::ROULETTEMACHINE: {

				terminal->statusUpdate(terminal->getState());

				createEvent(terminal, rouletteTimer.get(terminal->getState() - 1) * 1000);

				break;
			}
		}
	}
}

void GamblingManagerImplementation::createEvent(GamblingTerminal* terminal, int time) {
	if ((terminal != NULL) && (time > 0) && (time < 60000)) {

		terminal->setEvent(new GamblingEvent(terminal, terminal->getGameCount(), zoneServer));
		terminal->getEvent()->schedule(time);
	}
}

void GamblingManagerImplementation::continueGame(GamblingTerminal* terminal) {

	if (terminal != NULL) {
		Locker _locker(terminal);

		if (terminal->getPlayersWindows()->size() != 0) {

			switch (terminal->getMachineType()) {
				case GamblingTerminal::SLOTMACHINE: {

					if (terminal->getState() == GamblingTerminal::SLOTGAMEENDED) {
						//createNextRound
						terminal->joinTerminal(terminal->getPlayersWindows()->elementAt(0).getKey());

					} else {

						if (terminal->getState() == GamblingTerminal::END) {

							stopGame(terminal, false);

						} else {

							terminal->setState(terminal->getState() + 1);

							terminal->statusUpdate(terminal->getState());

							createEvent(terminal, slotTimer.get(terminal->getState() - 2) * 1000);
						}
					}

					break;
				}
				case GamblingTerminal::ROULETTEMACHINE: {

					if (terminal->getState() == GamblingTerminal::WHEELPAYOUT) {

						stopGame(terminal, false);

					} else {

						terminal->setState(terminal->getState() + 1);

						terminal->statusUpdate(terminal->getState());

						createEvent(terminal, rouletteTimer.get(terminal->getState() - 1) * 1000);
					}

					break;
				}
			}
		}
	}
}

void GamblingManagerImplementation::stopGame(GamblingTerminal* terminal, bool cancel) {
	if (terminal != NULL) {
		Locker _locker(terminal);

		switch (terminal->getMachineType()) {
			case GamblingTerminal::SLOTMACHINE: {

				if (!cancel) {
					calculateOutcome(terminal);

					terminal->closeAllMenus();

					terminal->setState(GamblingTerminal::SLOTGAMEENDED);

					terminal->statusUpdate(terminal->getState());

					terminal->getBets()->removeAll();

					createEvent(terminal, slotTimer.get(terminal->getState() - 2) * 1000);
				} else {
					terminal->closeAllMenus();

					if ((terminal->getEvent() != NULL) && (terminal->getState() >= GamblingTerminal::GAMESTARTED)) {
						terminal->getEvent()->cancel();
					}

					terminal->reset();
				}

				break;
			}
			case GamblingTerminal::ROULETTEMACHINE: {

				if (!cancel) {

					calculateOutcome(terminal);

					terminal->closeAllMenus();

					terminal->reset();
				} else {

					terminal->closeAllMenus();

					if (terminal->getEvent() != NULL) {
						terminal->getEvent()->cancel();
					}

					terminal->reset();
				}
				break;
			}
		}

	}
}

void GamblingManagerImplementation::calculateOutcome(GamblingTerminal* terminal) {


	if (terminal != NULL) {

		Locker locker(terminal);

		switch (terminal->getMachineType()) {

			case GamblingTerminal::SLOTMACHINE: {

				GamblingBet* bet = terminal->getBets()->get(0);

				ManagedReference<PlayerCreature*> player = terminal->getPlayersWindows()->elementAt(0).getKey();


				if ((bet != NULL) && (player != NULL)) {

					if (terminal->getFirst() == terminal->getSecond() && terminal->getSecond() == terminal->getThird()) {

						Locker _locker(player);

						int win = bet->getAmount() * slot.get(terminal->getFirst());

						ParameterizedStringId textPlayer("gambling/default_interface","winner_to_winner");
						textPlayer.setDI(win);
						player->sendSystemMessage(textPlayer);

						player->setCashCredits(player->getCashCredits() + win, true);

					} else if ((0 < terminal->getFirst() && terminal->getFirst() < 4) && (0 < terminal->getSecond() && terminal->getSecond() < 4) && (0 < terminal->getThird() && terminal->getThird() < 4)) {

						Locker _locker(player);

						int win = bet->getAmount() * 2;

						ParameterizedStringId textPlayer("gambling/default_interface","winner_to_winner");
						textPlayer.setDI(win);
						player->sendSystemMessage(textPlayer);

						player->setCashCredits(player->getCashCredits() + win, true);

					} else {

						player->sendSystemMessage("Sorry, you did not win this round. Please try again.");

					}

				}

				break;
			}
			case GamblingTerminal::ROULETTEMACHINE: {

				VectorMap<ManagedReference<PlayerCreature*>, int>* winnings = terminal->getWinnings();

				Vector<GamblingBet*>* bets = terminal->getBets();

				int tempReward;
				String tempTarget;

				for (int i=0; i < bets->size(); ++i) {
					tempTarget = bets->get(i)->getTarget();

					if (tempTarget == "odd") {
						// odd
						if (isOdd(terminal->getFirst())) {

							tempReward = (bets->get(i)->getAmount() * 2);

							if (winnings->contains(bets->get(i)->getPlayer())) {

								tempReward += winnings->get(bets->get(i)->getPlayer());

								winnings->drop(bets->get(i)->getPlayer());

							}

							winnings->put(bets->get(i)->getPlayer(), tempReward);

						}
					} else if (tempTarget == "even") {
						// even
						if (isEven(terminal->getFirst())) {

							tempReward = (bets->get(i)->getAmount() * 2);

							if (winnings->contains(bets->get(i)->getPlayer())) {

								tempReward += winnings->get(bets->get(i)->getPlayer());

								winnings->drop(bets->get(i)->getPlayer());
							}

							winnings->put(bets->get(i)->getPlayer(), tempReward);
						}
					} else if (tempTarget == "high") {
						// high
						if (isHigh(terminal->getFirst())) {

							tempReward = (bets->get(i)->getAmount() * 2);

							if (winnings->contains(bets->get(i)->getPlayer())) {

								tempReward += winnings->get(bets->get(i)->getPlayer());

								winnings->drop(bets->get(i)->getPlayer());
							}

							winnings->put(bets->get(i)->getPlayer(), tempReward);
						}
					} else if (tempTarget == "low") {
						// low
						if (isLow(terminal->getFirst())) {

							tempReward = (bets->get(i)->getAmount() * 2);

							if (winnings->contains(bets->get(i)->getPlayer())) {

								tempReward += winnings->get(bets->get(i)->getPlayer());

								winnings->drop(bets->get(i)->getPlayer());
							}

							winnings->put(bets->get(i)->getPlayer(), tempReward);
						}
					} else if (tempTarget == "red") {
						// red
						if (isRed(terminal->getFirst())) {

							tempReward = (bets->get(i)->getAmount() * 2);

							if (winnings->contains(bets->get(i)->getPlayer())) {

								tempReward += winnings->get(bets->get(i)->getPlayer());

								winnings->drop(bets->get(i)->getPlayer());
							}

							winnings->put(bets->get(i)->getPlayer(), tempReward);
						}
					} else if (tempTarget == "black") {
						// black
						if (isBlack(terminal->getFirst())) {

							tempReward = (bets->get(i)->getAmount() * 2);

							if (winnings->contains(bets->get(i)->getPlayer())) {

								tempReward += winnings->get(bets->get(i)->getPlayer());

								winnings->drop(bets->get(i)->getPlayer());
							}

							winnings->put(bets->get(i)->getPlayer(), tempReward);
						}
					} else {
						// single number: 0,00,1-36

						if (tempTarget == roulette.get(terminal->getFirst())) {

							tempReward = ((bets->get(i)->getAmount() * 35) * 2);

							if (winnings->contains(bets->get(i)->getPlayer())) {

								tempReward += winnings->get(bets->get(i)->getPlayer());

								winnings->drop(bets->get(i)->getPlayer());
							}

							winnings->put(bets->get(i)->getPlayer(), tempReward);
						}
					}

				}

				for (int i = 0; i < winnings->size(); ++i) { // send money and messages to players

					if (winnings->get(i) == 0) {

						winnings->elementAt(i).getKey()->sendSystemMessage("You don't win anything");

					} else {

						PlayerCreature* player = winnings->elementAt(i).getKey();

						if (player != NULL) {

							Locker _locker(player);

							// Send message to others
							ParameterizedStringId textOther("gambling/default_interface","winner_to_other");
							textOther.setDI(winnings->get(i));
							textOther.setTO(player->getFirstName());
							textOther.setTO(player);
							terminal->notifyOthers(player, &textOther);

							ParameterizedStringId textPlayer("gambling/default_interface","winner_to_winner");
							textPlayer.setDI(winnings->get(i));
							player->sendSystemMessage(textPlayer);

							player->setCashCredits(player->getCashCredits() + winnings->get(i), true);
						}
					}
				}

				break;
			}
		}
	}
}

void GamblingManagerImplementation::leaveTerminal(PlayerCreature* player, int machineType) {

	if (player != NULL) {

		switch (machineType) {
			case GamblingTerminal::SLOTMACHINE: {

				ManagedReference<GamblingTerminal*> terminal = slotGames.get(player);

				Locker locker(terminal);

				if (terminal->getPlayersWindows()->contains(player)) {
					terminal->leaveTerminal(player);
				}

				break;
			}
			case GamblingTerminal::ROULETTEMACHINE: {

				ManagedReference<GamblingTerminal*> terminal = rouletteGames.get(player);

				Locker locker(terminal);

				if (terminal->getPlayersWindows()->contains(player)) {
					terminal->leaveTerminal(player);
				}

				break;
			}
		}

	}

}
