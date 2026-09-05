import os
import glob
import logging

import pandas as pd


logging.basicConfig(level=logging.INFO)

INPUT_DIR = "/opt/ml/processing/input"
OUTPUT_DIR = "/opt/ml/processing/output"


def main():

    logging.info("Starting preprocessing")

    os.makedirs(OUTPUT_DIR, exist_ok=True)

    # Find CSV files downloaded from S3.
    files = glob.glob(
        os.path.join(INPUT_DIR, "**", "*.csv"),
        recursive=True
    )

    if not files:
        raise RuntimeError(
            f"No CSV files found under {INPUT_DIR}"
        )

    logging.info("Found input files: %s", files)

    frames = []

    for file in files:

        logging.info("Reading %s", file)

        df = pd.read_csv(file)

        logging.info(
            "Loaded %s rows and %s columns",
            len(df),
            len(df.columns)
        )

        frames.append(df)

    # Combine all CSV files.
    df = pd.concat(
        frames,
        ignore_index=True
    )

    logging.info(
        "Combined dataset: %s rows, %s columns",
        len(df),
        len(df.columns)
    )

    # Remove duplicates.
    df = df.drop_duplicates()

    # Fill missing numeric values.
    numeric_columns = df.select_dtypes(
        include=["number"]
    ).columns

    for column in numeric_columns:

        median = df[column].median()

        df[column] = df[column].fillna(median)

    # Example categorical handling.
    categorical_columns = df.select_dtypes(
        include=["object", "category"]
    ).columns

    for column in categorical_columns:

        df[column] = df[column].fillna("UNKNOWN")

    output_file = os.path.join(
        OUTPUT_DIR,
        "processed.csv"
    )

    df.to_csv(
        output_file,
        index=False
    )

    logging.info(
        "Wrote processed data to %s",
        output_file
    )


if __name__ == "__main__":
    main()