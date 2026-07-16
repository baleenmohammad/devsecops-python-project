FROM python:3.11-slim

# 1. Erstelle einen System-Benutzer ohne Root-Rechte
RUN useradd -u 1001 -m appuser

WORKDIR /app

# 2. Kopiere die requirements und installiere sie
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 3. Kopiere den Code und übertrage den Besitz (Ownership) an den neuen appuser
COPY --chown=appuser:appuser . .

# 4. Wechsle zum sicheren Non-Root-User
USER appuser

EXPOSE 5000

# 5. Startbefehl für deine App (falls noch nicht vorhanden)
CMD ["python", "app.py"]