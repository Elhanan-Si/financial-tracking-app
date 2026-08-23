import os
from PIL import Image

src_image_path = r"C:\Users\Eli\.gemini\antigravity-ide\brain\761cb01f-e454-4760-8a3e-69620c0a6665\app_icon_full_1787403516805.jpg"
workspace_dir = r"c:\Users\Eli\Desktop\Projects\FinancialApp\v2\financial_tracking"

img = Image.open(src_image_path).convert("RGBA")

# Ensure assets/icon directory exists
assets_icon_dir = os.path.join(workspace_dir, "assets", "icon")
os.makedirs(assets_icon_dir, exist_ok=True)

# Save master 1024x1024 icon
master_icon = img.resize((1024, 1024), Image.Resampling.LANCZOS)
master_icon.save(os.path.join(assets_icon_dir, "app_icon.png"), "PNG")
print("Saved master icon: 1024x1024")

# Android mipmap target dimensions
android_sizes = {
    "mipmap-mdpi": (48, 48),
    "mipmap-hdpi": (72, 72),
    "mipmap-xhdpi": (96, 96),
    "mipmap-xxhdpi": (144, 144),
    "mipmap-xxxhdpi": (192, 192),
}

android_res_dir = os.path.join(workspace_dir, "android", "app", "src", "main", "res")
for folder, size in android_sizes.items():
    target_folder = os.path.join(android_res_dir, folder)
    os.makedirs(target_folder, exist_ok=True)
    resized_img = img.resize(size, Image.Resampling.LANCZOS)
    out_path = os.path.join(target_folder, "ic_launcher.png")
    resized_img.save(out_path, "PNG")

print("All Android launcher icons generated successfully!")

# iOS AppIcon target dimensions
ios_icons = {
    "Icon-App-20x20@1x.png": (20, 20),
    "Icon-App-20x20@2x.png": (40, 40),
    "Icon-App-20x20@3x.png": (60, 60),
    "Icon-App-29x29@1x.png": (29, 29),
    "Icon-App-29x29@2x.png": (58, 58),
    "Icon-App-29x29@3x.png": (87, 87),
    "Icon-App-40x40@1x.png": (40, 40),
    "Icon-App-40x40@2x.png": (80, 80),
    "Icon-App-40x40@3x.png": (120, 120),
    "Icon-App-60x60@2x.png": (120, 120),
    "Icon-App-60x60@3x.png": (180, 180),
    "Icon-App-76x76@1x.png": (76, 76),
    "Icon-App-76x76@2x.png": (152, 152),
    "Icon-App-83.5x83.5@2x.png": (167, 167),
    "Icon-App-1024x1024@1x.png": (1024, 1024),
}

ios_icon_dir = os.path.join(workspace_dir, "ios", "Runner", "Assets.xcassets", "AppIcon.appiconset")
os.makedirs(ios_icon_dir, exist_ok=True)

# iOS icons should be opaque RGB (no transparent alpha per Apple HIG)
opaque_img = Image.new("RGB", img.size, (255, 255, 255))
opaque_img.paste(img, mask=img.split()[3])

for filename, size in ios_icons.items():
    resized = opaque_img.resize(size, Image.Resampling.LANCZOS)
    out_path = os.path.join(ios_icon_dir, filename)
    resized.save(out_path, "PNG")
    print(f"Saved iOS icon: {filename} ({size[0]}x{size[1]})")

print("All iOS icons generated successfully!")
