# opt

some useful scripts for optimization methods and game theory exam

# Game theory

## Bimatrix game

```Matlab
C1 = [
    2   0   2
    1   3  -1
]
C2 = [
    3   1   2
    2   4   1
]
```

Nella prima natrice, guardi le righe ed elimini la più grande.
Nellsa seconda matrice, guardi le colonne ed elimini la più grande.

Nell'esempio (dentro C2) `[3 2]'` domina `[2 1]'` e si elimina (anche C1 elimina la stessa colonna)

```Matlab
C1R = [
   (0)  2
    3 (-1)
]
C2R = [
   (1)  2
    4  (1)
]
```

Ricerca dei `pure nash equilibra`

P1 minimizza le colonne di C1R e P2 minimizza le righe su C2R

`PNE = {(1, 2), (2, 3)}`

## Monomatrix game

```Matlab

C = [
    1   4   -1  5   2
    2   1   3   3   5
    2   3  -2   3   1
    1   1   3   2   3
]
```

- P1 guarda le righe cancella quelle maggiori
- P2 guarda le colonne e cancella quelle maggiori

```Matlab
CR = [
    (1)   3    3   [5]
    [3] (-2)  [3]  (1)
    (1)  [3]  (2)  [3]
]
```


## ricerca dei pure nash equilibra

- P1 minimizza le colonne ()
- P2 massimizza le righe []

> Usa gli indici della matrice originale !!!

`PNE = {}`
