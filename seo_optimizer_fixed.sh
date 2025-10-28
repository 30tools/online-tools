#!/bin/bash

# Enhanced SEO Optimization Script - Fixed Version

echo "🚀 Starting enhanced SEO optimization..."

# Function to optimize individual pages
optimize_seo() {
    local file="$1"
    local filename=$(basename "$file")
    
    # Skip redirect files
    if grep -q "window.location.href" "$file" 2>/dev/null; then
        echo "⏭️  Skipping redirect file: $filename"
        return
    fi
    
    # Skip if file doesn't have proper HTML structure
    if ! grep -q "<title>" "$file" 2>/dev/null; then
        echo "⏭️  Skipping file without title: $filename"
        return
    fi
    
    echo "🔧 Optimizing: $filename"
    
    # Get current title for reference
    local current_title=$(grep -o '<title>[^<]*</title>' "$file" | sed 's/<title>\(.*\)<\/title>/\1/')
    
    # Determine tool type and create SEO-optimized content
    local new_title=""
    local new_desc=""
    local keywords=""
    
    case "$filename" in
        "index.html")
            new_title="🔥 Free Online Tools - Hash, Encode, Decrypt &amp; More | 30Tools"
            new_desc="Best collection of 100+ free online developer tools. MD5, SHA, Base64, JSON, XML, QR Code generators. Fast, secure, no downloads!"
            keywords="online tools,free converter,hash generator,base64 encoder,json formatter,xml validator,qr code generator,encryption tools,developer tools,crypto tools"
            ;;
        *"md5"*)
            new_title="⚡ Free MD5 Hash Generator Online | Instant MD5 Calculator &amp; Converter"
            new_desc="Generate MD5 hash instantly! Free online MD5 generator with HMAC support. Calculate MD5 checksums for strings, files. UTF-8, Hex, Base64 supported."
            keywords="md5 generator,md5 hash,md5 checksum,md5 online,hash generator,md5 converter,hmac md5,file hash,md5 calculator"
            ;;
        *"sha1"*)
            new_title="🔐 Free SHA1 Hash Generator Online | Secure SHA-1 Calculator"
            new_desc="Generate SHA1 hash online instantly! Free SHA-1 generator with file support. Calculate secure checksums for strings and files."
            keywords="sha1 generator,sha1 hash,sha1 checksum,sha1 online,secure hash,sha1 calculator,file hash,string hash"
            ;;
        *"sha256"*)
            new_title="🛡️ Free SHA256 Hash Generator | Secure SHA-256 Calculator Online"
            new_desc="Generate SHA256 hash instantly! Professional SHA-256 generator with HMAC support. Calculate secure checksums for files and strings."
            keywords="sha256 generator,sha256 hash,sha256 checksum,sha256 online,secure hash algorithm,sha2,crypto hash,blockchain hash"
            ;;
        *"base64_encode"*)
            new_title="📝 Free Base64 Encoder Online | Encode Text &amp; Files to Base64"
            new_desc="Encode to Base64 instantly! Free online Base64 encoder supporting UTF-8, files, images. RFC 4648 compliant. No upload required."
            keywords="base64 encoder,base64 encode,base64 converter,encode online,base64 text,base64 file,utf8 to base64"
            ;;
        *"base64_decode"*)
            new_title="🔓 Free Base64 Decoder Online | Decode Base64 to Text &amp; Files"
            new_desc="Decode Base64 instantly! Free online Base64 decoder supporting text and files. Safe client-side processing, no server upload."
            keywords="base64 decoder,base64 decode,base64 converter,decode online,base64 to text,base64 to file"
            ;;
        *"json"*)
            new_title="🎯 Free JSON Tools Online | Formatter, Validator &amp; Minifier"
            new_desc="Professional JSON tools! Format, validate, minify and view JSON online. Syntax highlighting, error detection, pretty print."
            keywords="json formatter,json validator,json minifier,json viewer,json pretty print,json parser,json tools online"
            ;;
        *"qr"*)
            new_title="📱 Free QR Code Generator Online | Create Custom QR Codes"
            new_desc="Generate QR codes instantly! Free online QR code generator with custom colors, logos, sizes. Download PNG, SVG, PDF."
            keywords="qr code generator,qr code maker,qr code creator,qr code online,custom qr code,free qr generator"
            ;;
        *"url_encode"*)
            new_title="🔗 Free URL Encoder Online | Encode URLs &amp; Special Characters"
            new_desc="Encode URLs instantly! Free online URL encoder for web developers. Encode special characters, spaces, symbols for safe transmission."
            keywords="url encoder,url encode,percent encoding,url encoding online,encode url,web encoder"
            ;;
        *"url_decode"*)
            new_title="🔓 Free URL Decoder Online | Decode URLs &amp; Percent Encoding"
            new_desc="Decode URLs instantly! Free online URL decoder for web developers. Decode percent-encoded URLs and special characters."
            keywords="url decoder,url decode,percent decoding,url decoding online,decode url,web decoder"
            ;;
        *"hex"*)
            new_title="🔢 Free Hex Encoder/Decoder Online | Hexadecimal Converter"
            new_desc="Convert to/from Hexadecimal instantly! Free online hex encoder and decoder. Convert text, files to hex and back."
            keywords="hex encoder,hex decoder,hexadecimal converter,hex online,text to hex,hex to text,base16"
            ;;
        *)
            # Extract tool name from current title
            tool_name=$(echo "$current_title" | sed 's/ - Online Tools//' | sed 's/Online Tools//' | sed 's/^ *//' | sed 's/ *$//')
            new_title="⚡ Free ${tool_name} Online Tool | ${tool_name} Converter"
            new_desc="Free ${tool_name} tool online! Professional ${tool_name} converter with instant results. No download required, secure processing."
            keywords="${tool_name} online,${tool_name} tool,${tool_name} converter,free ${tool_name},online converter"
            ;;
    esac
    
    # Apply SEO optimizations
    if [ ! -z "$new_title" ]; then
        # Update title
        sed -i '' "s|<title>[^<]*</title>|<title>$new_title</title>|g" "$file"
        
        # Update description
        sed -i '' "s|<meta name=\"description\" content=\"[^\"]*\">|<meta name=\"description\" content=\"$new_desc\">|g" "$file"
        
        # Update keywords
        sed -i '' "s|<meta name=\"keywords\" content=\"[^\"]*\">|<meta name=\"keywords\" content=\"$keywords\">|g" "$file"
        
        # Update og:title (decode HTML entities for OG tags)
        og_title=$(echo "$new_title" | sed 's/&amp;/\&/g')
        sed -i '' "s|<meta property=\"og:title\" content=\"[^\"]*\">|<meta property=\"og:title\" content=\"$og_title\">|g" "$file"
        
        # Update og:description
        sed -i '' "s|<meta property=\"og:description\" content=\"[^\"]*\">|<meta property=\"og:description\" content=\"$new_desc\">|g" "$file"
        
        # Add enhanced SEO meta tags if not present
        if ! grep -q "max-snippet" "$file"; then
            # Insert after viewport meta tag
            sed -i '' "/<meta name=\"viewport\"/a\\
    <!-- Enhanced SEO Meta Tags -->\\
    <meta name=\"robots\" content=\"index, follow, max-snippet:-1, max-image-preview:large, max-video-preview:-1\">\\
    <meta name=\"googlebot\" content=\"index, follow, max-snippet:-1, max-image-preview:large, max-video-preview:-1\">\\
    <meta name=\"theme-color\" content=\"#1a73e8\">\\
    <meta name=\"apple-mobile-web-app-capable\" content=\"yes\">\\
    <meta name=\"format-detection\" content=\"telephone=no\">" "$file"
        fi
        
        # Add preconnect links if not present
        if ! grep -q "preconnect" "$file"; then
            sed -i '' "/<link rel=\"icon\"/i\\
    <link rel=\"preconnect\" href=\"https://fonts.googleapis.com\">\\
    <link rel=\"preconnect\" href=\"https://www.googletagmanager.com\">\\
    <link rel=\"dns-prefetch\" href=\"https://code.jquery.com\">" "$file"
        fi
    fi
}

# Process key files first
echo "📊 Processing HTML files..."

# Process all HTML files
find . -name "*.html" -type f | head -20 | while read file; do
    optimize_seo "$file"
done

echo "✅ SEO optimization completed for sample files!"