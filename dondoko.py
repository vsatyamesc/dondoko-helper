import os
import argparse

def main():
    # Setup argparse
    parser = argparse.ArgumentParser(description="Generate links for images and prioritize text files.")
    parser.add_argument("link", help="The base link to prepend (e.g., https://example.com/images/)")
    args = parser.parse_args()

    base_link = args.link
    
    # Ensure the base link ends with a slash
    if not base_link.endswith('/'):
        base_link += '/'

    img_ext = [".jpg", ".png", ".webp", ".jpeg"]
    
    try:
        curr = os.listdir()
    except Exception as e:
        print(f"Error reading directory: {e}")
        return

    # Create separate lists to control the output order
    text_files = []
    image_files = []

    # Filter files
    for filename in curr:
        lower_name = filename.lower()
        
        # Grab .txt files but ignore the output file so it doesn't link itself
        if lower_name.endswith(".txt") and lower_name != "pages.txt":
            text_files.append(filename)
            
        # Grab image files
        elif any(lower_name.endswith(ext) for ext in img_ext):
            image_files.append(filename)

    # Print text files at the top of the list
    for txt in text_files:
        print(f"{base_link}{txt}")

    # Print image files below them
    for img in image_files:
        print(f"{base_link}{img}")

if __name__ == "__main__":
    main()