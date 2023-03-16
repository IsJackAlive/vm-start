#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>

FILE* process(char* prcsname) {
  FILE* fp;
  char* cmand = "ps -e | grep ";
  char line[256];

  char command[256];
  strcpy(command, cmand);
  strcat(command, prcsname);

  fp = popen(command, "r");
  if (fp == NULL) {
    printf("Błąd otwarcia potoku do ps.\n");
    exit(1);
  }
  return fp;
}

void show(FILE* fp) {
  int lineNumber = 0;
  char line[256];
  printf("\n");
  while (fgets(line, sizeof(line), fp) != NULL) {
    if (lineNumber == 0) {
      printf("%s", line);
      break;
    }
  }
  fclose(fp);
}

void kill_process(FILE* fp, int signal_number) {
  pid_t pid;
  char line[256];

  // Odczytanie pierwszej linii pliku (informacje o procesie)
  if (fgets(line, sizeof(line), fp) == NULL) {
    printf("Nie udało się odczytać informacji o procesie\n");
    return;
  }

  // Pobranie numeru PID procesu
  char* token = strtok(line, " ");
  if (token == NULL) {
    printf("Nie udało się odczytać numeru PID procesu\n");
    return;
  }
  pid = atoi(token);

  // Zamknięcie pliku
  pclose(fp);

  // Wysłanie sygnału do procesu
  int result = kill(pid, signal_number);
  if (result == -1) {
    printf("Nie udało się wysłać sygnału do procesu\n");
    return;
  }

  printf("Proces o PID %d został zamknięty\n", pid);
}

int main(int argc, char* argv[]) {
  char line[256];

  printf("Nazwa procesu: ");
  scanf("%s", &line);

  if (strcmp(argv[1], "-s") == 0 || strcmp(argv[1], "-S") == 0)
    show(process(line));
  else if (strcmp(argv[1], "-t") == 0 || strcmp(argv[1], "-T") == 0) {
    kill_process(process(line), SIGTERM);
    exit(1);
  }

  printf("Czy zamknąć proces? (T/N) ");
  char answer;
  scanf(" %c", &answer);

  if (answer == 'T' || answer == 't' || answer == 'y') {
    kill_process(process(line), SIGTERM);
  } 

  return 0;
}
