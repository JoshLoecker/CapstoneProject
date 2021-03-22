from pprint import pprint
import os
import pandas as pd
import plotly
import plotly.express as px
import plotly.io as pio
import random

plotly.io.orca.config.executable = "/Users/joshl/miniconda3/envs/capstone/bin/orca"
plotly.io.orca.config.save()


def add_jitter(num: int) -> float:
    """
    This function will add or subtract a random number from (-0.25, 0.25) from the incoming number, and return it

    This is to add jitter to the graphs in case of overlying numbers

    :param num: The integer to add jitter to
    :return:
    """
    rand_jitter = random.uniform(-0.17, 0.17)
    return num + rand_jitter


def read_data(*args) -> dict:
    """
    Read a single line from a file, containing the runtime of the experiment
    This assumes the number of threads start at 1 and continue until the end of the files are reached

    :param args: A list of directory paths containing files with runtimes
    :return: A pandas dataframe with the headers of Threads and Runtime
    """

    # [threads], [runtime]

    data = {
        "threads": [],
        "runtime": [],
        "run_type": [],
        "type_id": []
    }

    for file_path in args:
        for file in os.scandir(file_path):

            jitter = 0.05
            threads = file.name.split(".")[-1]
            runtime = open(file.path, "r").readline().rstrip("\n")

            if "bash" in file.path:
                run_type = "bash"
                type_id = 0
            elif "run_one" in file.path:
                run_type = "run_one"
                type_id = 1
            elif "run_two" in file.path:
                run_type = "run_two"
                type_id = 2
                jitter = jitter * -1
            else:
                run_type = "traditional"
                type_id = 3
                jitter = jitter * -1

            threads = int(threads) + jitter

            data["threads"].append(threads)
            data["runtime"].append(runtime)
            data["run_type"].append(run_type)
            data["type_id"].append(type_id)

    return data


def generate_dataframe(data_dict: dict) -> pd.DataFrame:
    return pd.DataFrame(data_dict)


def box_plot(dataframe: pd.DataFrame) -> plotly.graph_objs.Figure:
    """
    This will create a box plot without the box/whisker portion.
    This allows for jitter to be added between the points, which prevents points from overlapping

    :param dataframe: A pandas dataframe
    :return: A plotly box/whisker object
    """

    plot = px.scatter(dataframe, x="threads", y="runtime", color="run_type", )
    plot.update_traces(marker=dict(size=12,
                                   line=dict(width=1,
                                             color="DarkSlateGrey")),
                       selector=dict(mode="markers"))
    plot.update_layout(xaxis=dict(
        tickmode="linear",
        tick0=0,
        dtick=1
    ),
        autosize=False,
        width=1000,
        height=1000)

    return plot


def save_plot(plot: plotly.graph_objs.Figure, save_path: str):
    pio.write_image(plot, "image.png")


if __name__ == '__main__':
    results_dir = "/Users/joshl/PycharmProjects/CapstoneProject/results"
    bash_data = os.path.join(results_dir, "bash", "timeit")
    snakemake_run_one = os.path.join(results_dir, "snakemake", "timeit", "run_one")
    snakemake_run_two = os.path.join(results_dir, "snakemake", "timeit", "run_two")
    snakemake_traditional = os.path.join(results_dir, "snakemake", "timeit", "traditional")

    data_dictionary = read_data(bash_data, snakemake_run_one, snakemake_run_two, snakemake_traditional)
    dataframe = generate_dataframe(data_dictionary)
    plot = box_plot(dataframe)
    save_plot(plot, "")
