################################################################################
### Hans Rutger Bosker, Radboud University
### HansRutger.Bosker@donders.ru.nl
### Date: 11 November 2024, run in Python 3.11.5 on Windows 11
### License: CC BY 4.0
################################################################################

######################################
# IMPORTING LIBRARIES
######################################

import requests # to send HTTP requests 
import json # for parsing the JSON data that is received from Elevenlabs
import base64 # for audio
import os # for changing the working directory and removing files
import pandas as pd # for handling input from an Excel file
import xml.etree.ElementTree as ET # to parse the XML response from webmaus
import tgt # to parse and access TextGrids
# IMPORTANT: pandas often uses openpyxl to read Excel files, so make sure to have the 'openpyxl' module installed as well!



######################################
# SET PARAMETERS
######################################

# Set the working directory to the location of the script file
script_dir = os.path.dirname(os.path.abspath(__file__))
os.chdir(script_dir)

# Path to the input file
input_excel_path = "input.xlsx"

# Voice ID to use
VOICE_ID = "9BWtsMINqrJLrRacOk9x"  # Aria

# Construct the URL for the Text-to-Speech API request
tts_url = f"https://api.elevenlabs.io/v1/text-to-speech/{VOICE_ID}/with-timestamps"

# Your personal API Key for Elevenlabs
XI_API_KEY = "paste_your_own_API_key_here"
headers = {
    "Accept": "application/json",
    "xi-api-key": XI_API_KEY,
    "Content-Type": "application/json"
}

# WebMAUSBasic parameters
webmaus_url = f"https://clarin.phonetik.uni-muenchen.de/BASWebServices/services/runMAUSBasic"
webmaus_language = 'eng-US'

# runPho2Syl parameters
runpho2syl_url = f"https://clarin.phonetik.uni-muenchen.de/BASWebServices/services/runPho2Syl"
runpho2syl_input_tier = "MAU"
runpho2syl_wsync = "yes"
runpho2syl_outsym = "sampa"
runpho2syl_output_format = "tg"  # Output format: TextGrid



######################################
# DEFINE CUSTOM FUNCTIONS
######################################

# Function to convert JSON to TextGrid format (for alignment data)
def json_to_textgrid(json_data, output_path):
    characters = json_data["characters"]
    start_times = json_data["character_start_times_seconds"]
    end_times = json_data["character_end_times_seconds"]

    xmin = start_times[0]
    xmax = end_times[-1]

    textgrid_content = f'File type = "ooTextFile"\nObject class = "TextGrid"\n\n'
    textgrid_content += f'xmin = {xmin}\n'
    textgrid_content += f'xmax = {xmax}\n'
    textgrid_content += f'tiers? <exists>\n'
    textgrid_content += f'size = 1\n'
    textgrid_content += f'item []:\n'
    textgrid_content += f'    item [1]:\n'
    textgrid_content += f'        class = "IntervalTier"\n'
    textgrid_content += f'        name = "Characters"\n'
    textgrid_content += f'        xmin = {xmin}\n'
    textgrid_content += f'        xmax = {xmax}\n'
    textgrid_content += f'        intervals: size = {len(characters)}\n'

    for j, char in enumerate(characters):
        char_xmin = start_times[j]
        char_xmax = end_times[j]
        text = char.replace('"', '""')
        textgrid_content += f'        intervals [{j + 1}]:\n'
        textgrid_content += f'            xmin = {char_xmin}\n'
        textgrid_content += f'            xmax = {char_xmax}\n'
        textgrid_content += f'            text = "{text}"\n'

    # Write to the output file
    with open(output_path, 'w') as file:
        file.write(textgrid_content)
    #print(f"TextGrid file written to {output_path}")

# Function to parse and combine TextGrid files with TextGridTools (tgt)
def combine_textgrids_tgt(textgrid_path_1, textgrid_path_2, output_path):
    # Load the TextGrid files using TextGridTools
    tg_1 = tgt.read_textgrid(textgrid_path_1)
    tg_2 = tgt.read_textgrid(textgrid_path_2)

    # Create a list of the textgrids to be merged
    textgrids = [tg_1, tg_2]
    
    ## Create a new TextGrid for the combined output
    #combined_tg = tgt.TextGrid()

    combined_tg = tgt.util.merge_textgrids(
        textgrids=textgrids,
        ignore_duplicates=True)
    
    # Write the combined TextGrid to the output file
    tgt.write_to_file(combined_tg, output_path, format='short')
    print(f"TextGrid file saved as {output_path}")





######################################
# START GENERATING SPEECH + TEXTGRIDS
######################################

# Read the input Excel file using pandas
df = pd.read_excel(input_excel_path)

# Main loop for processing the data
for index, row in df.iterrows():
    item = row["filename"]
    prompt = row["prompt"]

    # Data payload for the API request
    data = {
        "text": prompt,
        "model_id": "eleven_turbo_v2",
        "voice_settings": {
            "stability": 0.5,
            "similarity_boost": 0.75,
            "style": 0.0,
            "use_speaker_boost": True
        }
    }

    # Make the POST request to the TTS API with headers and data
    response = requests.post(tts_url, headers=headers, json=data, stream=True)

    if response.status_code != 200:
        print(f"Error encountered for prompt '{prompt}', status: {response.status_code}, content: {response.text}")
        continue

    json_string = response.content.decode("utf-8")
    response_dict = json.loads(json_string)

    # Decode the base64-encoded audio data
    audio_bytes = base64.b64decode(response_dict["audio_base64"])

    # Save the input text to a text file using 'item' as the filename
    output_text_path = f"{item}.txt"
    with open(output_text_path, "w") as outfile:
        outfile.write(prompt)
    print(f"Text file saved as {output_text_path}")

    # Save the audio file using 'item' as the filename
    output_audio_path = f"{item}.mp3"
    with open(output_audio_path, 'wb') as f:
        f.write(audio_bytes)
    print(f"Audio file saved as {output_audio_path}")

    # Save character-based alignment data to a JSON file using 'item' as the filename
    output_json_path = f"{item}.json"
    json_object = json.dumps(response_dict['alignment'], indent=4)
    # ??? Do you want to save the JSON file? Then use this:
    #with open(output_json_path, "w") as outfile:
    #    outfile.write(json_object)
    #print(f"Alignment data saved as {output_json_path}")



    # Now convert JSON to TextGrid...
    # ...but wait with saving until the forced-alignment data from WebMAUSBasic have been added
    output_textgrid_path_1 = f"{item}.TextGrid"
    json_to_textgrid(response_dict['alignment'], output_textgrid_path_1)

    # Run WebMAUSBasic on the mp3 and txt pairs
    with open(output_audio_path, 'rb') as audio_file, open(output_text_path, 'r') as text_file:
        # Construct the payload
        files = {
            'SIGNAL': audio_file,
            'TEXT': text_file
        }
        data = {
            'LANGUAGE': webmaus_language,
            'OUTFORMAT': 'bpf'
        }

        # Send the request to the WebMAUSBasic API
        response = requests.post(webmaus_url, files=files, data=data)

        if response.status_code == 200:
            # Parse the XML response
            root = ET.fromstring(response.content)
            download_link = root.find(".//downloadLink").text

            if download_link:
                # Download the BPF file using the download link
                output_filename_webmaus = f"{item}_webmaus.par"
                download_response = requests.get(download_link)

                # Check if the download was successful
                if download_response.status_code == 200:
                    with open(output_filename_webmaus, 'wb') as f:
                        f.write(download_response.content)
                    #print(f"WebMAUS TextGrid file downloaded as {output_filename_webmaus}")
                    
                    # Step 2: Use the .par BPF file as input to runPho2Syl
                    with open(output_filename_webmaus, 'rb') as bpf_file:
                        files = {
                            'i': bpf_file
                        }
                        data = {
                            'wsync': runpho2syl_wsync,
                            'lng': webmaus_language,
                            'tier': runpho2syl_input_tier,
                            'outsym': runpho2syl_outsym,
                            'oform': runpho2syl_output_format
                        }
                        response_pho2syl = requests.post(runpho2syl_url, files=files, data=data)

                        if response_pho2syl.status_code == 200:
                            # Parse the XML response to find download link for runPho2Syl
                            root_pho2syl = ET.fromstring(response_pho2syl.content)
                            download_link_pho2syl = root_pho2syl.find(".//downloadLink").text

                            if download_link_pho2syl:
                                # Download the runPho2Syl output file
                                output_filename_pho2syl = f"{item}_sylls.TextGrid"
                                download_response_pho2syl = requests.get(download_link_pho2syl)
                                
                                if download_response_pho2syl.status_code == 200:
                                    with open(output_filename_pho2syl, 'wb') as f:
                                        f.write(download_response_pho2syl.content)
                                    
                                    # Combine both TextGrid files using TextGridTools (tgt)
                                    output_combined_textgrid_path = f"{item}.TextGrid"
                                    combine_textgrids_tgt(output_textgrid_path_1, output_filename_pho2syl, output_combined_textgrid_path)

                                    # Remove the intermediate output files containing only partial output
                                    os.remove(output_filename_pho2syl)
                                else:
                                    print("Failed to download the runPho2Syl output file.")
                            else:
                                print("Download link not found in the runPho2Syl response.")
                        else:
                            print(f"Failed to process the runPho2Syl request. Status code: {response_pho2syl.status_code}")
                        
                    # Remove the intermediate output files containing only partial output
                    os.remove(output_filename_webmaus)
                else:
                    print("Failed to download the WebMAUS BPF file.")
            else:
                print("Download link not found in the response.")
        else:
            print(f"Failed to process the WebMAUS request. Status code: {response.status_code}")

################################################################################
# End of script
################################################################################
