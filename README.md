# Table of contents
- [Problema aggiornamento applicativo](#problema-aggiornamento-applicativo)
  - [Procedura manuale e comandi](#procedura-manuale-e-comandi)
- [Soluzione 1 - Bash script](#soluzione-1---bash-script)
  - [File di configurazione](#file-di-configurazione)
    - [Esempio configurazione](#esempio-configurazione)
    - [Esempio esecuzione](#esempio-esecuzione)
  - [Note](#note)

# Problema aggiornamento applicativo

Il problema è dover aggiornare la versione presente sul cluster.
Bisogna fare una serie di procedure manuali per aggiornare l'applicativo.

L'applicativo consiste in un microservizio Java.
Il microservizio viene compilato automaticamente da una pipeline che osserva lo stato
del branch develop presente sulla repo ufficiale git.

Quando la pipeline riesce a compilare correttamente l'applicativo viene creato un paccheto helm
e deployato nella repository di riferimento.

Bisogna automatizzare i seguenti passaggi:

- Accorgersi della nuova versione rilasciata.
- Fare l'aggiornamento dell'applicativo usando Helm.

## Procedura manuale e comandi

Recuperare l'ultima versione rilasciata. Comando: `helm dep udpate` e `helm search repo NAME`.
Recuperare la versione attuale installata. Comando: `helm list`
Confrontare l'ultima versione recuperata con la versione attuale.
Se le versioni sono differenti bisogna rilasciare l'ultima versione. `helm upgrade --install NAME HELM_NAME -f VALUES_FILE.yaml`

# Soluzione 1 - Bash script

Considerando la semplicità dei passaggi manuali sarebbe possibile creare uno
script bash in grado di ripetere i passaggi.

Lo script deve poter essere configurato per gestire in contemporanea più progetti
e fare uso di **kubectl** e **helm** per l'aggiornamento.


## File di configurazione

Requisiti:
- Poter configurare progetti multipli.
- Definire il path alla repository helm dei progetti.
- Definire i values.

### Esempio configurazione
```json
{
    "projects": [
    {
        "id": "Project id", # Used for logging
            "repo": {
                "chartName": "Chart name",
                    "url": "URL to helm chart"
                        "devel": true # toggle --devel option in helm command
            },
            "chart": {
                "name": "Name of file in project",
                "values": [
                    "/path/file1.yaml",
                    "/path/file2.yaml",
                ]
            }
    }
    ]
}
```

### Esempio esecuzione

```bash
./script.bash --config config-file.json
```

## Note

- Crezione chart helm per l'installazione automatica sul cluster.
- Lo script può essere schedulato direttamente sul cluster kubernetes.
