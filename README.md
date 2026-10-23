# Data Science Interview — Candidate Instructions

Welcome, and thanks for taking the time to do this exercise. Everything you need
runs inside a single Docker image — a data science environment (Python, pandas,
NumPy, scikit-learn, and JupyterLab) with the interview dataset already loaded
into a SQLite database. You don't need to install Python or any packages
yourself.

---

## 1. Prerequisites

You only need **Docker** installed on your laptop.

- **Mac / Windows:** install [Docker Desktop](https://www.docker.com/products/docker-desktop/).
  Make sure it's running (you'll see the Docker whale icon in your menu bar / system tray).
- **Linux:** install Docker Engine via your package manager.

To confirm Docker is working, open a terminal and run:

```bash
docker run --rm hello-world
```

If that prints a "Hello from Docker!" message, you're ready.

---

## 2. Get the image

Pull the interview image (this may take a few minutes — it's a few GB):

```bash
docker pull daweijinomc/datascience-interview-public:latest
```

No login or account is required.

---

## 3. Run the environment

```bash
docker run --rm -p 8888:8888 daweijinomc/datascience-interview-public:latest
```

When it starts, the terminal will show JupyterLab booting up. Leave this terminal
window open — closing it stops the environment.

> If port 8888 is already in use on your machine, map a different one, e.g.
> `docker run --rm -p 8899:8888 ...`, and use `localhost:8899` in the next step.

---

## 4. Open JupyterLab

In your browser, go to:

```
http://localhost:8888
```

You'll land in JupyterLab. Open **`starter.ipynb`** — it's already set up to connect
to the dataset and shows a few example queries to get you going.

---

## 5. The data

The dataset is preloaded into a SQLite database at:

```
/home/interview/interview.db
```

You can query it directly with SQL through pandas — no need to load any CSV files.
The starter notebook shows how:

```python
import sqlite3
import pandas as pd

conn = sqlite3.connect("/home/interview/interview.db")

# List available tables
pd.read_sql("SELECT name FROM sqlite_master WHERE type='table'", conn)

# Query a table
df = pd.read_sql("SELECT * FROM campaigns WHERE target_acos > 0.1", conn)
df.head()
```

Run the table-listing cell first to see exactly which tables and columns are
available to you.

---

## 6. Saving your work

The container is temporary — **anything you create is lost when it stops** unless
you save it out. When you're finished, download your notebook from JupyterLab:

**File → Download** (or right-click the notebook in the file browser → Download)

Then send the downloaded `.ipynb` file to us as instructed below.

*(Optional — persist work automatically:* you can mount a local folder so your work
is saved to your real machine as you go. Run instead:*

```bash
docker run --rm -p 8888:8888 -v "$(pwd)/work":/home/interview/work \
  daweijinomc/datascience-interview-public:latest
```

*then save your notebook into the `work` folder inside JupyterLab. It will appear in
a `work` directory wherever you ran the command. On Windows PowerShell, use
`${PWD}` instead of `$(pwd)`.)*

---

## 7. When you're done

- Save / download your notebook as above.
- Send it to **[YOUR CONTACT EMAIL]**.

---

## Stopping the environment

Go back to the terminal running the container and press **Ctrl-C**, or run in
another terminal:

```bash
docker ps            # find the container id
docker stop <id>     # stop it
```

---

## Troubleshooting

- **`docker: command not found`** — Docker isn't installed or isn't on your PATH.
  Install Docker Desktop and make sure it's running.
- **Browser shows "can't connect" at localhost:8888** — give it a few seconds after
  starting; JupyterLab takes a moment to boot. Confirm the container is still running
  (`docker ps`) and that you used the right port.
- **Pull is slow / times out** — the image is a few GB; try again on a stable
  connection. If you're on a restricted corporate network, a personal network may
  work better.
- **`port is already allocated`** — something else is using 8888. Re-run with a
  different port, e.g. `-p 8899:8888`, and open `localhost:8899`.

If you run into anything else, reach out to **[YOUR CONTACT EMAIL]**.

Good luck!
