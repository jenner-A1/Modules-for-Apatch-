import os, sys, zipfile
def pack_apm(folder_name):
    zip_name = f"{folder_name}.zip"
    build_path = os.path.expanduser(f"~/SuperROM_Forge/Builds/{zip_name}")
    source_path = os.path.expanduser(f"~/SuperROM_Forge/Source_APM/{folder_name}")
    with zipfile.ZipFile(build_path, 'w', zipfile.ZIP_DEFLATED) as zipf:
        for root, dirs, files in os.walk(source_path):
            for file in files:
                full_path = os.path.join(root, file)
                rel_path = os.path.relpath(full_path, source_path)
                zipf.write(full_path, rel_path)
    print(f"\n✅ SUCCESS! Module packed to: {build_path}")
if __name__ == "__main__":
    pack_apm(sys.argv[1])
