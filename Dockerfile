FROM python:3.11.5-slim-bullseye

WORKDIR /app

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    software-properties-common \
    git \
    && rm -rf /var/lib/apt/lists/* 

RUN pip install --upgrade pip

RUN git clone https://github.com/gregorywmorris/code-basic-LLM-tutorial.git .

RUN pip install -r requirements.txt

WORKDIR /app/RestaurantNameGenerator

EXPOSE 8501

HEALTHCHECK CMD curl --fail http://localhost:8501/_stcore/health

ENTRYPOINT ["streamlit", "run", "main.py", "--server.port=8501", "--server.address=0.0.0.0"]