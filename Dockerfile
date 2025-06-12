# Image de base légère avec Python 3.11 slim
FROM python:3.11-slim

# Variables d'environnement pour éviter les interactions
ENV PYTHONUNBUFFERED=1

# Installer gcc et libpq-dev pour psycopg2 (Postgres) et wget (optionnel)
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Installer Jupyter et librairies nécessaires
RUN pip install --no-cache-dir \
    jupyterlab \
    pandas \
    sqlalchemy \
    psycopg2-binary

# Créer un dossier de travail
WORKDIR /app

# Exposer le port Jupyter
EXPOSE 8887

# Commande par défaut pour lancer Jupyter
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--no-browser"]
