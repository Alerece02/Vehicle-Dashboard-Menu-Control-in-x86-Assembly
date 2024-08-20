#include <stdio.h>
#include <stdlib.h>
#include <ncurses.h>
#include <unistd.h>

#define NUM_RIGHE_UTENTE 6
#define NUM_RIGHE_SUPERVISOR 8
#define MIN_LAMPEGGI 2
#define MAX_LAMPEGGI 5

int bloccoAutomaticoPorte = 1; // Impostazione iniziale: ON
int backHome = 1; // Impostazione iniziale: ON
int lampeggiAutostrada = 3; // Numero di lampeggi modalità autostrada

void visualizzaRiga(int rigaCorrente, int indiceSelezione, int isSupervisor) {
    clear();

    if (isSupervisor) {
        if (rigaCorrente == 1) {
            printw("Setting automobile (supervisor)\n");
        } else if (rigaCorrente == 2) {
            printw("Data: 15/06/2014\n");
        } else if (rigaCorrente == 3) {
            printw("Ora: 15:32\n");
        } else if (rigaCorrente == 4) {
            printw("Blocco automatico porte: %s\n", bloccoAutomaticoPorte ? "ON" : "OFF");
        } else if (rigaCorrente == 5) {
            printw("Back-home: %s\n", backHome ? "ON" : "OFF");
        } else if (rigaCorrente == 6) {
            printw("Check olio\n");
        } else if (rigaCorrente == 7) {
            printw("Frecce direzione: %d\n", lampeggiAutostrada);
        } else if (rigaCorrente == 8) {
            printw("Reset pressione gomme\n");
        }
    } else {
        if (rigaCorrente == 1) {
            printw("Setting automobile\n");
        } else if (rigaCorrente == 2) {
            printw("Data: 15/06/2014\n");
        } else if (rigaCorrente == 3) {
            printw("Ora: 15:32\n");
        } else if (rigaCorrente == 4) {
            printw("Blocco automatico porte: %s\n", bloccoAutomaticoPorte ? "ON" : "OFF");
        } else if (rigaCorrente == 5) {
            printw("Back-home: %s\n", backHome ? "ON" : "OFF");
        } else if (rigaCorrente == 6) {
            printw("Check olio\n");
        }
    }

    if (rigaCorrente == indiceSelezione) {
        printw("  ^\n");
    }

    refresh();
}

void cambiaImpostazione(int rigaCorrente) {
    
        if (rigaCorrente == 4) {
            bloccoAutomaticoPorte = !bloccoAutomaticoPorte;
        } else if (rigaCorrente == 5) {
            backHome = !backHome;
        } else if (rigaCorrente == 7) {
            lampeggiAutostrada++;
            if (lampeggiAutostrada > MAX_LAMPEGGI) {
                lampeggiAutostrada = MIN_LAMPEGGI;
            }
       }
    
}

int main(int argc, char *argv[]) {
    int isSupervisor = 0;

    if (argc == 2 && atoi(argv[1]) == 2244) {
        isSupervisor = 1;
    }

    initscr(); // Inizializza la modalità curses
    keypad(stdscr, TRUE); // Abilita l'uso delle frecce direzionali
    noecho(); // Disabilita l'eco delle caratteri inseriti dall'utente

    int rigaCorrente = 1;
    int indiceSelezione = 1;

    while (1) {
        if (isSupervisor && rigaCorrente > NUM_RIGHE_SUPERVISOR) {
            rigaCorrente = 1;
        } else if (!isSupervisor && rigaCorrente > NUM_RIGHE_UTENTE) {
            rigaCorrente = 1;
        }

        visualizzaRiga(rigaCorrente, indiceSelezione, isSupervisor);

        int input = getch(); // Legge l'input da tastiera

        if (input == KEY_DOWN) {
            rigaCorrente++;
        } else if (input == KEY_UP) {
            rigaCorrente--;
        } else if (input == KEY_RIGHT) {
            cambiaImpostazione(rigaCorrente);
        } else if (input == 10) { // Tasto Invio
            if (isSupervisor && rigaCorrente == 8) {
                printw("Pressione gomme resettata\n");
                refresh();
                sleep(2);
            }
        } else if (input == 'q') {
            break;
        }

        if (isSupervisor && rigaCorrente < 1) {
            rigaCorrente = NUM_RIGHE_SUPERVISOR;
        } else if (!isSupervisor && rigaCorrente < 1) {
            rigaCorrente = NUM_RIGHE_UTENTE;
        }

        indiceSelezione = rigaCorrente;
    }

    endwin(); // Termina la modalità curses

    return 0;
}