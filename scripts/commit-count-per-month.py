#!/usr/bin/env python3

import subprocess
import tempfile

import numpy as np
import plotly.express as px

if __name__ == "__main__":
    # use subprocess to generate this data
    with tempfile.NamedTemporaryFile() as f:
        file = f.name
        subprocess.check_call(
            [
                f'git log --format="%ad" --date=format:"%Y-%m" | sort | uniq -c > {f.name}'
            ],
            shell=True,
        )

        f.flush()

        # read the data from the tempfile
        with open(file) as f:
            data = f.readlines()

        x, y = [], []
        for line in data:
            if line:
                count, date = line.strip().split()
                x.append(date.strip())
                y.append(int(count.strip()))
        # convert the date array to a numpy datetime object
        x = np.array(x, dtype="datetime64[m]")
        fig = px.line(
            x=x,
            y=y,
            labels={"x": "date", "y": "count"},
            title="Commit History per Month",
        )
        fig.write_html("commit_count_per_month.html", auto_open=True)
