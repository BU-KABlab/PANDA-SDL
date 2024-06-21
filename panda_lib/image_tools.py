"""Various functions for image processing."""

from datetime import datetime
from pathlib import Path

from PIL import Image, ImageDraw, ImageFont

from panda_lib.config.config import DATA_ZONE_LOGO
from panda_lib.sql_tools import sql_utilities
from panda_lib.experiment_class import ExperimentBase

def add_data_zone(
    image: Image, experiment: ExperimentBase = None, context: str = None
) -> Image:
    """Adds a data zone to the bottom of the image."""
    # determin the size of the image
    # Get the date and time from the image metadata
    if experiment is None:
        pin = ""
        date_time = datetime.now().isoformat(timespec="seconds")
        project_id = ""
        campaign_id = ""
        experiment_id = ""
        wellplate_id = ""
        well_id = ""
        substrate = ""
    else:
        pin = experiment.pin
        date_time = experiment.status_date.isoformat(timespec="seconds")
        project_id = experiment.project_id
        campaign_id = experiment.project_campaign_id
        experiment_id = experiment.experiment_id
        wellplate_id = experiment.plate_id
        well_id = experiment.well_id

        try:
            substrate = str(
                sql_utilities.execute_sql_command(
                    "SELECT substrate FROM well_types WHERE id = (SELECT type_id FROM wellplates WHERE id = ?)",
                    (wellplate_id,),
                )[0][0]
            )
        except:
            substrate = "ITO"

    try:
        # Check the image file type
        if image.format == "TIFF":
            tiff_tags = image.tag_v2
            date_time = tiff_tags.get("DateTime")
            if date_time is not None:
                date_time = datetime.strptime(date_time, "%Y:%m:%d %H:%M:%S")
            else:
                # Fallback on file creation date if unable to get from metadata
                file_creation_time = datetime.fromtimestamp(
                    Path(image.filename).stat().st_ctime
                )
                date_time = file_creation_time
        else:
            # Fallback on file creation date if unable to get from metadata
            if experiment is None:
                date_time = datetime.now().isoformat(timespec="seconds")
            else:
                file_creation_time = datetime.fromtimestamp(
                    Path(image.filename).stat().st_ctime
                )
                date_time = file_creation_time
        if isinstance(date_time, str):
            date_time = datetime.fromisoformat(date_time)
    except:
        # Fallback on current time if all else fails
        date_time = datetime.now().isoformat(timespec="seconds")

    font = ImageFont.truetype("arial.ttf", 30)
    banner_height = 100
    banner = Image.new("RGB", (image.width, banner_height), "black")
    draw_banner = ImageDraw.Draw(banner)

    segment_widths = [250, 250.0, 200.0, 150.0, 600.0, 175.0, 175.0, 200.0]
    segment_starts = [0] + [
        round(sum(segment_widths[:i]), 0) for i in range(1, len(segment_widths))
    ]

    # draw vertical white lines to separate the segments
    for segment_start in segment_starts[1:]:
        draw_banner.line(
            (segment_start, 0, segment_start, banner_height), fill="white", width=2
        )

    # offset the segments to not touch the lines
    text_starts = [segment + 5 for segment in segment_starts]

    # ePANDA logo
    epanda_logo_x = text_starts[0]
    logo = Image.open(DATA_ZONE_LOGO)
    logo = logo.resize((int(logo.width * 0.15), int(logo.height * 0.15)))
    banner.paste(logo, (epanda_logo_x, 0))
    # ePANDA version
    version_x = text_starts[1]
    draw_banner.text(
        (version_x, 0), "ePANDA PIN", font=font, fill="white", align="center"
    )
    draw_banner.text(
        (version_x, 30),
        f"{pin[:10]}\n{pin[-11:]}",
        font=ImageFont.truetype("arial.ttf", 20),
        fill="white",
        align="center",
    )
    # date and time
    date_x = text_starts[2]
    draw_banner.text((date_x, 0), "Date", font=font, fill="white", align="center")
    draw_banner.text(
        (date_x, 30),
        date_time.strftime("%Y-%m-%d"),
        font=font,
        fill="white",
        align="center",
    )
    draw_banner.text(
        (date_x, 60),
        date_time.strftime("%H:%M:%S"),
        font=font,
        fill="white",
        align="center",
    )
    # project id
    project_id_x = text_starts[3]
    draw_banner.text(
        (project_id_x, 0), "Project", font=font, fill="white", align="center"
    )
    draw_banner.text(
        (project_id_x, 30),
        f"{str(project_id)}-{str(campaign_id)}",
        font=font,
        fill="white",
        align="center",
    )

    # experiment id
    experiment_id_x = text_starts[4]
    draw_banner.text(
        (experiment_id_x, 0),
        f"Experiment {str(experiment_id)}",
        font=font,
        fill="white",
        align="center",
    )
    horizontal_line_x = segment_starts[4]
    draw_banner.line(
        (horizontal_line_x, 50, horizontal_line_x + segment_widths[4], 50),
        fill="white",
        width=2,
    )
    draw_banner.text(
        (experiment_id_x, 60),
        f"{str(context).capitalize()}",
        font=font,
        fill="white",
        align="center",
    )

    # wellplate and well id
    wellplate_well_id_x = text_starts[5]
    draw_banner.text(
        (wellplate_well_id_x, 0), "Wellplate", font=font, fill="white", align="center"
    )
    draw_banner.text(
        (wellplate_well_id_x, 30),
        f"{str(wellplate_id)} - {well_id}",
        font=font,
        fill="white",
        align="center",
    )

    # substrate type
    substrate_type_x = text_starts[6]
    draw_banner.text(
        (substrate_type_x, 0), "Substrate", font=font, fill="white", align="center"
    )
    draw_banner.text(
        (substrate_type_x, 30), f"{substrate}", font=font, fill="white", align="center"
    )

    image_with_banner = Image.new(
        "RGB", (image.width, image.height + banner_height), "white"
    )
    image_with_banner.paste(image, (0, 0))
    image_with_banner.paste(banner, (0, image.height))
    return image_with_banner


def invert_image(image_path: str) -> str:
    """Inverts the colors of an image."""
    image_path: Path = Path(image_path)
    # Open the original image
    with Image.open(image_path) as img:
        # Convert the image to RGBA if it's not already in that mode
        img = img.convert("RGBA")

        # Extract the data
        datas = img.getdata()

        fully_inverted_data = []
        for item in datas:
            # Invert the colors, changing black to white and vice versa
            if item[0] in list(range(200, 256)):  # white and shades close to white
                fully_inverted_data.append((0, 0, 0, item[3]))  # change to black
            elif item[0] in list(range(0, 56)):  # black and shades close to black
                fully_inverted_data.append((255, 255, 255, item[3]))  # change to white
            else:
                # For other colors, just invert the RGB values
                fully_inverted_data.append(
                    (255 - item[0], 255 - item[1], 255 - item[2], item[3])
                )

        # Update image data with the fully inverted colors
        img.putdata(fully_inverted_data)

        # Save the new image with full color inversion
        fully_inverted_image_path = (
            image_path.parent / f"{image_path.stem}_fully_inverted{image_path.suffix}"
        )
        img.show()
        img_save = input("Do you want to save the fully inverted image? (y/n): ")
        if img_save.lower() == "y":
            img.save(fully_inverted_image_path)

    return fully_inverted_image_path


if __name__ == "__main__":

    test_image = Image.open(Path(input("Enter the path to the image: ")))
    # pin = "201010102040500000101"
    # date_time = "2021-01-01 12:00:00"
    # project_id = 16
    # campaign_id = 2
    # experiment_id = 10000596
    # wellplate_id = 107
    # well_id = "G8"
    # context = "before deposition"
    # substrate = "ITO"

    new_image = add_data_zone(
        experiment=None, image=test_image, context="before deposition"
    )
    new_image.show()
    new_image.save(Path(input("Enter the path to save the image to: ")))

    # inverted_image_path = invert_image(r"images\PANDA_logo.png")
