# Języki formalne i teoria translacji
semestr 5, zima 2019

## Lista 1
### Matcher
Program w języku Java znajdujący wzorzec w tekście na podstawie algorytmów wyszukiwania wzorca z wykorzystaniem automatów skończonych i Knutha-Morrisa-Pratta (opisane w książce: Cormen T.H., LeisersonCh.E., Rivest R.L.: Wprowadzenie do algorytmów, rozdział 34.3 i 34.4, ISBN 83-204-2144-6).

## Lista 2
### Flex
Zadania:
* Program usuwający nadmiar białych znaków
* Program usuwający komentarze z pliku .xml
* Program usuwający komentarze z pliku .cpp (z możliwością pozostawienia komentarzy dokumentacyjnych)
* Kalkulator ONP

Uruchomienie:

```
$>flex zad.l
$>gcc lex.yy.c -o zad
$>zad < test.txt > wynik.txt
```

## Lista 3
### Bison
Translator wyrażeń arytmetycznych na liczbach całkowitych z postaci infiksowej do postaci postfiksowej podający wynik obliczenia tłumaczonego wyrażenia. Program przetwarza wejście liniami. Można podzielić linię znakiem `\` (tak jak w języku C). Aby wprowadzić komentarz należy na początku linii umieścić `#`.

Kompilacja programu (na Windowsie):
```
$>mingw32-make
```

Uruchomienie interaktywne:
```
$>calc
```
Uruchomienie dla przykładów z pliku:
```
$>calc < test.txt
```

Czyszczenie plików wynikowych:
```
$>mingw-make clean
```
