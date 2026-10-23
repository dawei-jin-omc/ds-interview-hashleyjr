FROM condaforge/miniforge3:latest

RUN conda create -n ds python=3.11 \
      jupyterlab pandas numpy scipy scikit-learn xgboost \
      matplotlib seaborn statsmodels \
      -c conda-forge -y && \
    conda clean -afy

WORKDIR /home/interview

# Copy CSVs + load script to a build-only location, run the load,
# then remove the CSVs so only the .db ships in the final image
COPY data/ /build/data/
COPY data/ /home/interview/data/
COPY load_data.py /build/load_data.py
RUN conda run -n ds python /build/load_data.py

# Optional starter notebook
COPY starter.ipynb /home/interview/

EXPOSE 8888

CMD ["conda", "run", "--no-capture-output", "-n", "ds", \
     "jupyter", "lab", \
     "--ip=0.0.0.0", "--port=8888", "--no-browser", \
     "--allow-root", \
     "--ServerApp.token=", "--ServerApp.password="]