<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>File Editor</title>
    <!-- Favicon to prevent 404 error -->
    <link rel="icon" href="data:image/x-icon;base64,AAABAAEAEBAAAAEAIABoBAAAFgAAACgAAAAQAAAAIAAAAAEAGAAAAAAAAAAA" type="image/x-icon">
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        /* Custom styles for Inter font and general layout */
        body {
            font-family: "Inter", sans-serif;
            display: flex;
            justify-content: center;
            align-items: flex-start; /* Align items to the top */
            min-height: 100vh;
            background-color: #f0f2f5;
            padding: 2rem;
            box-sizing: border-box;
        }
        .container {
            background-color: #ffffff;
            border-radius: 1rem;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            padding: 2.5rem;
            width: 100%;
            max-width: 800px; /* Max width for better readability */
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }
        textarea {
            min-height: 300px; /* Make textarea larger */
            resize: vertical; /* Allow vertical resizing */
            font-family: monospace; /* Monospace font for code/data */
            font-size: 0.9rem;
        }
        .input-group {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }
        .input-pair {
            display: flex;
            gap: 1rem;
            align-items: center;
        }
        .input-pair label {
            width: 60px; /* Fixed width for labels */
            text-align: right;
            font-weight: 500;
        }
        .input-pair input[type="text"] {
            flex-grow: 1;
        }
        .button-group {
            display: flex;
            flex-wrap: wrap; /* Allow wrapping on small screens */
            gap: 1rem;
            justify-content: center;
        }
        .button-group button, .button-group label {
            flex: 1 1 auto; /* Allow buttons to grow and shrink */
            min-width: 120px; /* Minimum width for buttons */
        }
        /* Style file input label as a button */
        .file-input-label {
            background-color: #3b82f6; /* Blue */
            color: white;
            padding: 0.75rem 1.5rem;
            border-radius: 0.5rem;
            cursor: pointer;
            text-align: center;
            transition: background-color 0.2s;
            display: inline-block; /* Ensure it behaves like a block for flex */
            font-weight: 600;
        }
        .file-input-label:hover {
            background-color: #2563eb; /* Darker blue */
        }
        .file-input-label input[type="file"] {
            display: none; /* Hide actual file input */
        }
        .message-box {
            padding: 1rem;
            border-radius: 0.5rem;
            font-weight: 500;
            text-align: center;
            margin-top: 1rem; /* Space below the button */
        }
        .message-box.success {
            background-color: #d1fae5; /* Green light */
            color: #065f46; /* Green dark */
        }
        .message-box.error {
            background-color: #fee2e2; /* Red light */
            color: #991b1b; /* Red dark */
        }
        .message-box.info {
            background-color: #e0f2fe; /* Blue light */
            color: #0369a1; /* Blue dark */
        }
        .detected-patterns-section {
            background-color: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 0.75rem;
            padding: 1.5rem;
            margin-top: 1.5rem;
        }
        .detected-patterns-section h2 {
            margin-bottom: 1rem;
        }
        /* Changed pattern-list to column to stack pattern-rows */
        .pattern-list {
            display: flex;
            flex-direction: column;
            gap: 0.5rem; /* Reduced gap between rows */
        }
        /* New styles for table-like layout */
        .pattern-row {
            display: flex;
            align-items: baseline; /* Align text baselines */
            gap: 0.75rem; /* Space between label and values */
        }
        .pattern-label {
            min-width: 150px; /* Fixed width for labels to align values */
            font-weight: 600;
            color: #4a5568;
            flex-shrink: 0; /* Prevent label from shrinking */
        }
        .pattern-values {
            display: flex;
            flex-wrap: wrap;
            gap: 0.75rem; /* Space between individual pattern items */
            flex-grow: 1; /* Allow values container to take remaining space */
        }

        .pattern-item {
            background-color: #e0f2fe;
            color: #0369a1;
            padding: 0.5rem 1rem;
            border-radius: 0.5rem;
            font-size: 0.875rem;
            font-weight: 600;
            cursor: pointer; /* Indicate clickable */
            transition: background-color 0.2s, transform 0.1s;
        }
        .pattern-item:hover {
            background-color: #90cdf4; /* Lighter blue on hover */
            transform: translateY(-2px);
        }
        .pattern-item:active {
            transform: translateY(0);
        }
        /* Style for non-clickable H and D values */
        .non-clickable-pattern-item {
            background-color: #f0f4f8; /* Lighter background */
            color: #4a5568; /* Darker text color */
            padding: 0.5rem 1rem;
            border-radius: 0.5rem;
            font-size: 0.875rem;
            font-weight: 500; /* Slightly less bold */
            cursor: default; /* No pointer cursor */
            transition: none; /* No hover/active effects */
        }
        .non-clickable-pattern-item:hover {
            background-color: #f0f4f8; /* No change on hover */
            transform: none; /* No transform on hover */
        }
        /* Tailwind's hidden class for dynamic visibility */
        .hidden {
            display: none !important;
        }
        .formula-input {
            width: 100%;
            padding: 0.5rem;
            border: 1px solid #ccc;
            border-radius: 0.375rem;
            font-family: monospace;
            font-size: 0.9rem;
            margin-top: 0.5rem;
        }
        /* Style for highlighting a line in the textarea */
        .highlighted-line {
            background-color: rgba(255, 0, 0, 0.3); /* Red with some transparency */
            animation: fadeOutRed 3s forwards; /* Fade out animation */
        }

        @keyframes fadeOutRed {
            from { background-color: rgba(255, 0, 0, 0.3); } /* Start with red */
            to { background-color: transparent; }
        }

        /* New style for G84 pattern items */
        .g84-pattern-item {
            background-color: #ef4444; /* Red-500 */
            color: white;
        }
        .g84-pattern-item:hover {
            background-color: #dc2626; /* Red-600 */
        }
        /* Style for disabled button */
        .button-disabled {
            opacity: 0.6;
            cursor: not-allowed;
            background-color: #9ca3af; /* Gray-400 */
        }
        .button-disabled:hover {
            background-color: #9ca3af; /* Keep gray on hover */
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="text-3xl font-bold text-center text-gray-800 mb-4">File Content Editor</h1>

        <!-- File Upload Section -->
        <div class="flex flex-col items-center gap-4">
            <label for="fileInput" class="file-input-label">
                Upload File
                <input type="file" id="fileInput" accept=".txt, .csv, .json, .log, .xml, .html, .css, .js">
            </label>
            <span id="fileName" class="text-gray-600 text-sm">No file selected</span>
        </div>

        <!-- Text Area for Content -->
        <textarea id="fileContent"
                  class="w-full p-4 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none"
                  placeholder="Upload a file or type content here..."
                  rows="15"></textarea>

        <!-- Find and Replace Section -->
        <div class="input-group" id="findReplaceInputsContainer">
            <h2 class="text-xl font-semibold text-gray-700 mb-2">Find and Replace Values</h2>
            <!-- Dynamically generated input pairs will go here -->
            <!-- Initial pair (always visible) -->
            <div class="input-pair" id="inputPair1">
                <label for="find1">Find 1:</label>
                <input type="text" id="find1" class="p-2 border border-gray-300 rounded-md focus:ring-1 focus:ring-blue-400 outline-none" placeholder="e.g., T10">
                <label for="replace1">Replace 1:</label>
                <input type="text" id="replace1" class="p-2 border border-gray-300 rounded-md focus:ring-1 focus:ring-blue-400 outline-none" placeholder="e.g., TempValue">
            </div>
            <!-- Hidden pairs (up to 50) will be generated by JS -->
            <button id="replaceButton"
                    class="bg-green-500 hover:bg-green-600 text-white font-bold py-2 px-4 rounded-lg transition duration-200 shadow-md">
                Scan & Replace All
            </button>
            <!-- Message Box moved here -->
            <div id="messageBox" class="message-box hidden"></div>
        </div>

        <!-- New Button for Next Tool Logic -->
        <button id="applyNextToolButton"
                class="bg-purple-600 hover:bg-purple-700 text-white font-bold py-2 px-4 rounded-lg transition duration-200 shadow-md mt-4">
            Apply Next Tool Logic
        </button>

        <!-- Detected Patterns Section -->
        <div id="detectedPatternsSection" class="detected-patterns-section">
            <h2 class="text-xl font-semibold text-gray-700">Detected Patterns (Click to use in Find fields)</h2>
            <div id="patternList">
                <!-- Grouped patterns will be inserted here by JavaScript -->
                <p class="text-gray-500">Upload a file to detect patterns.</p>
            </div>

            <!-- Formula Editing Section -->
            <div class="formula-editing-section mt-6 pt-4 border-t border-gray-200">
                <h3 class="text-lg font-semibold text-gray-700 mb-2">Calculated Formulas (Editable)</h3>
                <div class="mb-3">
                    <label for="sFormulaInput" class="block text-sm font-medium text-gray-700">S Formula:</label>
                    <input type="text" id="sFormulaInput" class="formula-input" value="S = (3.82 * 800) / TOOL DIA">
                    <p class="text-xs text-gray-500 mt-1">Format: S = (Num1 * Num2) / TOOL DIA</p>
                </div>
                <div>
                    <label for="fFormulaInput" class="block text-sm font-medium text-gray-700">F Formula:</label>
                    <input type="text" id="fFormulaInput" class="formula-input" value="F = S * 4 * 0.003">
                    <p class="text-xs text-gray-500 mt-1">Format: F = S * Num1 * Num2</p>
                </div>
            </div>
        </div>

        <!-- Action Buttons -->
        <div class="button-group">
            <button id="downloadButton"
                    class="bg-indigo-500 hover:bg-indigo-600 text-white font-bold py-2 px-4 rounded-lg transition duration-200 shadow-md">
                Download Edited File
            </button>
            <button id="clearButton"
                    class="bg-gray-400 hover:bg-gray-500 text-white font-bold py-2 px-4 rounded-lg transition duration-200 shadow-md">
                Clear All
            </button>
        </div>
    </div>

    <script>
        // Get references to DOM elements
        const fileInput = document.getElementById('fileInput');
        const fileNameSpan = document.getElementById('fileName');
        const fileContentTextArea = document.getElementById('fileContent');
        const replaceButton = document.getElementById('replaceButton');
        const applyNextToolButton = document.getElementById('applyNextToolButton'); // New button reference
        const downloadButton = document.getElementById('downloadButton');
        const clearButton = document.getElementById('clearButton');
        const messageBox = document.getElementById('messageBox');
        const patternListDiv = document.getElementById('patternList');
        const findReplaceInputsContainer = document.getElementById('findReplaceInputsContainer');
        const sFormulaInput = document.getElementById('sFormulaInput');
        const fFormulaInput = document.getElementById('fFormulaInput');

        let currentFileName = 'edited_file.txt'; // Default download filename
        let currentFindInputIndex = 0; // To cycle through find1, find2, ... find50 inputs
        let hasAppliedNextToolLogic = false; // New flag to control "Apply Next Tool Logic" button

        const MAX_INPUT_PAIRS = 50;
        const findInputs = [];
        const replaceInputs = [];
        const inputPairContainers = [];

        // Global array to store all detected T patterns for auto-population
        let allDetectedTPatterns = [];

        // Default formulas and their parsed values
        let sFormulaConstants = { num1: 3.82, num2: 800 }; // Updated default to match user's latest input
        let fFormulaConstants = { num1: 4, num2: 0.003 };

        // Regex for T, H, D, S, F patterns - UPDATED TO ALLOW DECIMALS
        const patternRegex = /^[THDSF]\d+\.?\d*$/i;
        // Updated regex for TOOL DIA. pattern (to handle optional dot and flexible separators and robust value capture)
        const toolDiaPatternRegex = /^TOOL DIA\.?\s*[=\-]?\s*([+\-]?\d*\.?\d+)$/i;


        /**
         * Parses the S formula string to extract numeric constants.
         * @param {string} formulaString - The S formula string (e.g., "S = (1000 * 3.82) / TOOL DIA").
         * @returns {{num1: number, num2: number}|null} Parsed numbers or null if format is invalid.
         */
        function parseSFormula(formulaString) {
            const regex = /S\s*=\s*\(\s*(\d+\.?\d*)\s*[\*x]\s*(\d+\.?\d*)\s*\)\s*\/\s*TOOL DIA/i; // Added 'x' to regex
            const match = formulaString.match(regex);
            if (match && match.length === 3) {
                const num1 = parseFloat(match[1]);
                const num2 = parseFloat(match[2]);
                if (!isNaN(num1) && !isNaN(num2)) {
                    return { num1, num2 };
                }
            }
            return null;
        }

        /**
         * Parses the F formula string to extract numeric constants.
         * @param {string} formulaString - The F formula string (e.g., "F = S * 4 * 0.003").
         * @returns {{num1: number, num2: number}|null} Parsed numbers or null if format is invalid.
         */
        function parseFFormula(formulaString) {
            const regex = /F\s*=\s*S\s*[\*x]\s*(\d+\.?\d*)\s*[\*x]\s*(\d+\.?\d*)/i; // Added 'x' to regex
            const match = formulaString.match(regex);
            if (match && match.length === 3) {
                const num1 = parseFloat(match[1]);
                const num2 = parseFloat(match[2]);
                if (!isNaN(num1) && !isNaN(num2)) {
                    return { num1, num2 };
                }
            }
            return null;
        }


        /**
         * Dynamically creates find/replace input pairs and adds them to the DOM.
         */
        function createInputPairs() {
            // Add the first pair (already in HTML)
            findInputs.push(document.getElementById('find1'));
            replaceInputs.push(document.getElementById('replace1'));
            inputPairContainers.push(document.getElementById('inputPair1'));

            for (let i = 2; i <= MAX_INPUT_PAIRS; i++) {
                const inputPairDiv = document.createElement('div');
                inputPairDiv.className = 'input-pair hidden'; // Start hidden
                inputPairDiv.id = `inputPair${i}`;

                const findLabel = document.createElement('label');
                findLabel.htmlFor = `find${i}`;
                findLabel.textContent = `Find ${i}:`;
                inputPairDiv.appendChild(findLabel);

                const findInput = document.createElement('input');
                findInput.type = 'text';
                findInput.id = `find${i}`;
                findInput.className = 'p-2 border border-gray-300 rounded-md focus:ring-1 focus:ring-blue-400 outline-none';
                findInput.placeholder = `e.g., T${i}`;
                findInputs.push(findInput);
                inputPairDiv.appendChild(findInput);

                const replaceLabel = document.createElement('label');
                replaceLabel.htmlFor = `replace${i}`;
                replaceLabel.textContent = `Replace ${i}:`;
                inputPairDiv.appendChild(replaceLabel);

                const replaceInput = document.createElement('input');
                replaceInput.type = 'text';
                replaceInput.id = `replace${i}`;
                replaceInput.className = 'p-2 border border-gray-300 rounded-md focus:ring-1 focus:ring-blue-400 outline-none';
                replaceInputs.push(replaceInput);
                inputPairDiv.appendChild(replaceInput);

                // Insert before the replaceButton
                findReplaceInputsContainer.insertBefore(inputPairDiv, replaceButton);
                inputPairContainers.push(inputPairDiv);
            }
        }

        /**
         * Clears the message box.
         */
        function clearMessageBox() {
            messageBox.textContent = '';
            messageBox.classList.add('hidden');
            messageBox.className = 'message-box hidden'; // Reset classes
        }

        /**
         * Displays a message in the message box.
         * @param {string} message - The message to display.
         * @param {'success'|'error'|'info'} type - The type of message (for styling).
         */
        function showMessage(message, type) {
            clearMessageBox(); // Clear any existing message first
            messageBox.textContent = message;
            messageBox.className = `message-box ${type}`; // Apply type-specific class
            messageBox.classList.remove('hidden'); // Make it visible

            // Only auto-hide success and info messages
            if (type === 'success' || type === 'info') {
                setTimeout(() => {
                    clearMessageBox();
                }, 5000);
            }
        }

        /**
         * Populates the next available find input field with the clicked pattern.
         * @param {string} pattern - The pattern string to populate.
         * @param {HTMLElement} clickedItem - The HTML element that was clicked (the pattern span).
         */
        function populateNextFindField(pattern, clickedItem) {
            clearMessageBox(); // Clear message when populating fields

            // Ensure the target input pair is visible if it's currently hidden
            if (currentFindInputIndex < inputPairContainers.length && inputPairContainers[currentFindInputIndex].classList.contains('hidden')) {
                inputPairContainers[currentFindInputIndex].classList.remove('hidden');
            }

            const targetFindInput = findInputs[currentFindInputIndex];
            const targetReplaceInput = replaceInputs[currentFindInputIndex];

            console.log(`Populating fields: Pattern clicked: "${pattern}"`);
            console.log(`Target Find Input (ID: ${targetFindInput.id}):`, targetFindInput);
            console.log(`Target Replace Input (ID: ${targetReplaceInput.id}):`, targetReplaceInput);

            targetFindInput.value = pattern;
            
            // Special handling for 'T' patterns: populate replace with just 'T'
            if (pattern.toUpperCase().startsWith('T') && /\d+/.test(pattern)) {
                targetReplaceInput.value = 'T';
            } else {
                // For other patterns, populate replace with the same pattern for convenience
                targetReplaceInput.value = pattern;
            }
            
            targetFindInput.focus(); // Focus on the input for immediate editing

            // Hide the clicked pattern item
            if (clickedItem) {
                clickedItem.classList.add('hidden');
                console.log(`Hidden clicked item:`, clickedItem);
            }

            showMessage(`'${pattern}' copied to Find ${currentFindInputIndex + 1}.`, 'info');

            // Move to the next input index, cycle back to 0 if at the end
            currentFindInputIndex = (currentFindInputIndex + 1) % MAX_INPUT_PAIRS;
            console.log(`Next currentFindInputIndex: ${currentFindInputIndex}`);
        }

        /**
         * Cleans a line by removing comments (both parentheses and semicolon styles).
         * @param {string} line - The original line of text.
         * @returns {string} The cleaned line with comments removed.
         */
        function cleanLineFromComments(line) {
            // First, remove all content within parentheses comments globally
            let cleanedLine = line.replace(/\([^)]*\)/g, '');
            // Then, remove everything from the first semicolon to the end of the line
            cleanedLine = cleanedLine.split(';')[0];
            return cleanedLine.trim(); // Trim any leading/trailing whitespace
        }

        /**
         * Scans a given text segment for T<number>, H<number>, D<number>, S<number>, F<number>, G84 patterns
         * and returns them as maps. This function now explicitly ignores patterns found within comments.
         * @param {string} segmentContent - The text content of a segment.
         * @returns {object} An object containing maps for T, H, D, S, F, G84 patterns, and TOOL DIA.
         */
        function findPatternsInSegment(segmentContent) {
            const regexT = /T(\d+)/gi;
            const regexH = /H(\d+)/gi;
            const regexD = /D(\d+)/gi;
            const regexS = /S(\d+)/gi;
            const regexF = /F(\d+\.?\d*)/gi; 
            const regexG84 = /G84/gi; // New regex for G84
            const localRegexToolDia = /TOOL DIA\.?\s*[=\-]?\s*([+\-]?\d*\.?\d+)/gi;
            // New regex to capture the specific comment structure
            const specialCommentRegex = /\(\s*T\d+\s*\|\s*([^|]+?)\s*\|\s*H\d+\s*\|\s*D\d+\s*\|\s*WEAR COMP\s*\|\s*TOOL DIA\.?\s*-\s*\d*\.?\d+\s*\)/gi;


            const tPatterns = new Map();
            const hPatterns = new Map();
            const dPatterns = new Map();
            const sPatterns = new Map();
            const fPatterns = new Map();
            const g84Patterns = new Map(); // New map for G84 patterns
            const toolDiaPatterns = new Map();
            const specialCommentDescriptions = new Map(); // New map for special comment descriptions

            const lines = segmentContent.split('\n');

            lines.forEach(line => {
                let match;
                
                // First, check for the special comment pattern in the original line
                specialCommentRegex.lastIndex = 0; // Reset regex index
                while ((match = specialCommentRegex.exec(line)) !== null) {
                    const description = match[1].trim(); // Capture group 1 is the description
                    if (description) {
                        specialCommentDescriptions.set(description, (specialCommentDescriptions.get(description) || 0) + 1);
                    }
                }

                // Then, clean the line for other pattern detections
                const cleanedLine = cleanLineFromComments(line);

                if (cleanedLine === '') {
                    return;
                }

                const tM6Match = cleanedLine.match(/(T\d+)\s+M6/i);
                if (tM6Match) {
                    const tPattern = tM6Match[1];
                    tPatterns.set(tPattern, (tPatterns.get(tPattern) || 0) + 1);
                }

                regexT.lastIndex = 0;
                while ((match = regexT.exec(cleanedLine)) !== null) {
                    const pattern = match[0];
                    tPatterns.set(pattern, (tPatterns.get(pattern) || 0) + 1);
                }

                regexH.lastIndex = 0;
                while ((match = regexH.exec(cleanedLine)) !== null) {
                    const pattern = match[0];
                    hPatterns.set(pattern, (hPatterns.get(pattern) || 0) + 1);
                }

                regexD.lastIndex = 0;
                while ((match = regexD.exec(cleanedLine)) !== null) {
                    const pattern = match[0];
                    dPatterns.set(pattern, (dPatterns.get(pattern) || 0) + 1);
                }

                regexS.lastIndex = 0;
                while ((match = regexS.exec(cleanedLine)) !== null) {
                    const pattern = match[0];
                    sPatterns.set(pattern, (sPatterns.get(pattern) || 0) + 1);
                }

                regexF.lastIndex = 0;
                while ((match = regexF.exec(cleanedLine)) !== null) {
                    const pattern = match[0];
                    fPatterns.set(pattern, (fPatterns.get(pattern) || 0) + 1);
                }

                // Scan for G84 patterns
                regexG84.lastIndex = 0;
                if (regexG84.test(cleanedLine)) {
                    const nMatch = cleanedLine.match(/N(\d+)/i);
                    const nValue = nMatch ? nMatch[0].toUpperCase() : 'N/A';
                    g84Patterns.set(nValue, (g84Patterns.get(nValue) || 0) + 1);
                }

                localRegexToolDia.lastIndex = 0;
                while ((match = localRegexToolDia.exec(cleanedLine)) !== null) {
                    const pattern = match[0];
                    toolDiaPatterns.set(pattern, (toolDiaPatterns.get(pattern) || 0) + 1);
                }
            });

            return { tPatterns, hPatterns, dPatterns, sPatterns, fPatterns, g84Patterns, toolDiaPatterns, specialCommentDescriptions };
        }

        /**
         * Scans the textarea content for patterns grouped by "M01" delimiters and displays them.
         */
        function scanAndDisplayPatterns() {
            const fullContent = fileContentTextArea.value;
            const lines = fullContent.split('\n');

            patternListDiv.innerHTML = ''; // Clear previous patterns
            allDetectedTPatterns = []; // Reset for new scan

            let patternsFoundOverall = false;
            let groupCounter = 0;
            let currentGroupContentLines = []; // Stores lines for the current group

            const blockTools = getBlockTools(fullContent); // Get all T tools from blocks once
            console.log("getBlockTools result (all T...M6 tools in sequence):", blockTools);


            for (let i = 0; i < lines.length; i++) {
                const line = lines[i];
                const trimmedLine = line.trim();

                if (trimmedLine.toLowerCase().includes('m01')) {
                    // Process the current block before starting a new one
                    groupCounter++;
                    const nMatchOnM01Line = trimmedLine.match(/N(\d+)/i);
                    const nValueForThisM01 = nMatchOnM01Line ? nMatchOnM01Line[0].toUpperCase() : null;

                    const { tPatterns, hPatterns, dPatterns, sPatterns, fPatterns, g84Patterns, toolDiaPatterns, specialCommentDescriptions } = findPatternsInSegment(currentGroupContentLines.join('\n'));
                    console.log(`Debug: Group ${groupCounter} specialCommentDescriptions:`, Array.from(specialCommentDescriptions.keys()));

                    // Determine the 'next tool' for this block
                    let nextToolForThisBlock = null;
                    if (blockTools.length > 0) {
                        const currentToolInBlock = Array.from(tPatterns.keys()).find(t => t.match(/T\d+/i)); // Find the T tool of this segment
                        const currentToolIndexInBlockTools = blockTools.indexOf(currentToolInBlock);
                        if (currentToolIndexInBlockTools !== -1) {
                            const nextBlockToolIndex = (currentToolIndexInBlockTools + 1) % blockTools.length;
                            nextToolForThisBlock = blockTools[nextBlockToolIndex];
                            console.log(`Debug: For Tool Path ${groupCounter}, Current Tool in Block: ${currentToolInBlock}, Next Tool Calculated: ${nextToolForThisBlock}`);
                        } else {
                            console.log(`Debug: For Tool Path ${groupCounter}, No T tool found in block content to determine next tool.`);
                        }
                    } else {
                        console.log(`Debug: blockTools array is empty, cannot determine next tool.`);
                    }

                    // Aggregate T patterns for auto-population
                    tPatterns.forEach((count, pattern) => {
                        if (!allDetectedTPatterns.includes(pattern)) { // Avoid duplicates
                            allDetectedTPatterns.push(pattern);
                        }
                    });

                    // Process G84 patterns for this group to calculate S and F
                    const g84DetailsForGroup = [];
                    let currentToolDiaForGroup = null; // Track TOOL DIA within this segment

                    // Re-iterate lines in the current group to find TOOL DIA and G84 in order
                    currentGroupContentLines.forEach(segmentLine => {
                        const cleanedSegmentLine = cleanLineFromComments(segmentLine);
                        const toolDiaMatch = cleanedSegmentLine.match(/TOOL DIA\.?\s*[=\-]?\s*([+\-]?\d*\.?\d+)/i);
                        if (toolDiaMatch) {
                            currentToolDiaForGroup = parseFloat(toolDiaMatch[1]);
                        }

                        if (cleanedSegmentLine.includes('G84')) {
                            const nMatch = cleanedSegmentLine.match(/N(\d+)/i);
                            const nValue = nMatch ? nMatch[0].toUpperCase() : 'N/A';
                            
                            let suggestedS = 'N/A';
                            let suggestedF = 'N/A';

                            if (currentToolDiaForGroup !== null && !isNaN(currentToolDiaForGroup) && currentToolDiaForGroup !== 0) {
                                suggestedS = Math.round((sFormulaConstants.num1 * sFormulaConstants.num2) / currentToolDiaForGroup);
                                // Apply S capping
                                if (suggestedS > 15000) suggestedS = 15000;

                                suggestedF = (suggestedS * fFormulaConstants.num1 * fFormulaConstants.num2).toFixed(3);
                                // Apply F capping
                                if (suggestedF > 40) suggestedF = 40;
                            }
                            g84DetailsForGroup.push({ nValue, suggestedS, suggestedF });
                        }
                    });


                    renderGroupPatterns(groupCounter, tPatterns, hPatterns, dPatterns, sPatterns, fPatterns, g84DetailsForGroup, toolDiaPatterns, specialCommentDescriptions, nValueForThisM01, true, nextToolForThisBlock);
                    
                    if (tPatterns.size > 0 || hPatterns.size > 0 || dPatterns.size > 0 || sPatterns.size > 0 || fPatterns.size > 0 || g84Patterns.size > 0 || toolDiaPatterns.size > 0 || specialCommentDescriptions.size > 0 || nValueForThisM01) {
                        patternsFoundOverall = true;
                    }

                    currentGroupContentLines = [];
                } else {
                    currentGroupContentLines.push(line);
                }
            }

            // Process any remaining content after the last M01 (or if no M01s were found)
            if (currentGroupContentLines.length > 0) {
                groupCounter++;
                const { tPatterns, hPatterns, dPatterns, sPatterns, fPatterns, g84Patterns, toolDiaPatterns, specialCommentDescriptions } = findPatternsInSegment(currentGroupContentLines.join('\n'));
                console.log(`Debug: Last Group (${groupCounter}) specialCommentDescriptions:`, Array.from(specialCommentDescriptions.keys()));

                // Determine the 'next tool' for the last block (cyclical)
                let nextToolForThisBlock = null;
                if (blockTools.length > 0) {
                    const currentToolInBlock = Array.from(tPatterns.keys()).find(t => t.match(/T\d+/i));
                    const currentToolIndexInBlockTools = blockTools.indexOf(currentToolInBlock);
                    if (currentToolIndexInBlockTools !== -1) {
                        const nextBlockToolIndex = (currentToolIndexInBlockTools + 1) % blockTools.length;
                        nextToolForThisBlock = blockTools[nextBlockToolIndex];
                        console.log(`Debug: For Last Tool Path ${groupCounter}, Current Tool in Block: ${currentToolInBlock}, Next Tool Calculated: ${nextToolForThisBlock}`);
                    } else {
                        console.log(`Debug: For Last Tool Path ${groupCounter}, No T tool found in block content to determine next tool.`);
                    }
                } else {
                    console.log(`Debug: blockTools array is empty, cannot determine next tool for last block.`);
                }

                // Aggregate T patterns for auto-population for the last group
                tPatterns.forEach((count, pattern) => {
                    if (!allDetectedTPatterns.includes(pattern)) { // Avoid duplicates
                        allDetectedTPatterns.push(pattern);
                    }
                });

                // Process G84 patterns for this last group
                const g84DetailsForGroup = [];
                let currentToolDiaForGroup = null; 
                currentGroupContentLines.forEach(segmentLine => {
                    const cleanedSegmentLine = cleanLineFromComments(segmentLine);
                    const toolDiaMatch = cleanedSegmentLine.match(/TOOL DIA\.?\s*[=\-]?\s*([+\-]?\d*\.?\d+)/i);
                    if (toolDiaMatch) {
                        currentToolDiaForGroup = parseFloat(toolDiaMatch[1]);
                    }

                    if (cleanedSegmentLine.includes('G84')) {
                        const nMatch = cleanedSegmentLine.match(/N(\d+)/i);
                        const nValue = nMatch ? nMatch[0].toUpperCase() : 'N/A';
                        
                        let suggestedS = 'N/A';
                        let suggestedF = 'N/A';

                        if (currentToolDiaForGroup !== null && !isNaN(currentToolDiaForGroup) && currentToolDiaForGroup !== 0) {
                            suggestedS = Math.round((sFormulaConstants.num1 * sFormulaConstants.num2) / currentToolDiaForGroup);
                            if (suggestedS > 15000) suggestedS = 15000;

                            suggestedF = (suggestedS * fFormulaConstants.num1 * fFormulaConstants.num2).toFixed(3);
                            if (suggestedF > 40) suggestedF = 40;
                        }
                        g84DetailsForGroup.push({ nValue, suggestedS, suggestedF });
                    }
                });

                renderGroupPatterns(groupCounter, tPatterns, hPatterns, dPatterns, sPatterns, fPatterns, g84DetailsForGroup, toolDiaPatterns, specialCommentDescriptions, null, false, nextToolForThisBlock);
                if (tPatterns.size > 0 || hPatterns.size > 0 || dPatterns.size > 0 || sPatterns.size > 0 || fPatterns.size > 0 || g84Patterns.size > 0 || toolDiaPatterns.size > 0 || specialCommentDescriptions.size > 0) {
                    patternsFoundOverall = true;
                }
            }

            // Handle case where no patterns or groups were found at all
            if (!patternsFoundOverall && groupCounter === 0) {
                const noPatterns = document.createElement('p');
                noPatterns.className = 'text-gray-500';
                noPatterns.textContent = 'No T, H, D, S, F, G84, TOOL DIA., or special comment patterns with values found in any group.';
                patternListDiv.appendChild(noPatterns);
            }

            // After all patterns are scanned and rendered, auto-populate T values
            fillFindReplaceWithTPatterns();
        }

        /**
         * Renders patterns for a specific group into the patternListDiv.
         * @param {number} groupNumber - The number of the current group.
         * @param {Map<string, number>} tPatterns - Map of T patterns and their counts.
         * @param {Map<string, number>} hPatterns - Map of H patterns and their counts.
         * @param {Map<string, number>} dPatterns - Map of D patterns and their counts.
         * @param {Map<string, number>} sPatterns - Map of S patterns and their counts.
         * @param {Map<string, number>} fPatterns - Map of F patterns and their counts.
         * @param {Array<Object>} g84DetailsForGroup - Array of G84 details (N-value, suggested S/F).
         * @param {Map<string, number>} toolDiaPatterns - Map of TOOL DIA. patterns and their counts.
         * @param {Map<string, number>} specialCommentDescriptions - Map of special comment descriptions.
         * @param {string|null} nValueAssociatedWithM01 - The N value found on the M01 line, or null if not applicable.
         * @param {boolean} hasM01Separator - True if this group is followed by an M01.
         * @param {string|null} nextToolForThisGroup - The T value of the next tool in sequence.
         */
        function renderGroupPatterns(groupNumber, tPatterns, hPatterns, dPatterns, sPatterns, fPatterns, g84DetailsForGroup, toolDiaPatterns, specialCommentDescriptions, nValueAssociatedWithM01, hasM01Separator, nextToolForThisGroup) {
            const groupSection = document.createElement('div');
            groupSection.className = 'group-section';

            const groupHeader = document.createElement('h3');
            groupHeader.textContent = `Tool Path ${groupNumber}`; 
            groupSection.appendChild(groupHeader);

            const patternsInGroupDiv = document.createElement('div');
            patternsInGroupDiv.className = 'pattern-list';

            let patternsFoundInGroupContent = false; // Tracks if T, H, D, S, F, TOOL DIA. patterns are found

            // Render special comment descriptions
            if (specialCommentDescriptions.size > 0) {
                const patternRow = document.createElement('div');
                patternRow.className = 'pattern-row';

                const labelSpan = document.createElement('span');
                labelSpan.className = 'pattern-label';
                labelSpan.textContent = 'Comment Descriptions:';
                patternRow.appendChild(labelSpan);

                const valuesDiv = document.createElement('div');
                valuesDiv.className = 'pattern-values';
                specialCommentDescriptions.forEach((count, description) => {
                    patternsFoundInGroupContent = true;
                    const item = document.createElement('span');
                    item.className = 'pattern-item';
                    item.textContent = description;
                    item.title = `Click to add '${description}' to a Find field`;
                    item.addEventListener('click', (event) => populateNextFindField(description, event.target));
                    valuesDiv.appendChild(item);
                });
                patternRow.appendChild(valuesDiv);
                patternsInGroupDiv.appendChild(patternRow);
            }


            // Render T patterns
            if (tPatterns.size > 0) {
                const patternRow = document.createElement('div');
                patternRow.className = 'pattern-row';

                const labelSpan = document.createElement('span');
                labelSpan.className = 'pattern-label';
                labelSpan.textContent = 'T Tool:';
                patternRow.appendChild(labelSpan);

                const valuesDiv = document.createElement('div');
                valuesDiv.className = 'pattern-values';
                tPatterns.forEach((count, pattern) => {
                    patternsFoundInGroupContent = true;
                    const item = document.createElement('span');
                    item.className = 'pattern-item';
                    item.textContent = pattern;
                    item.title = `Click to add '${pattern}' to a Find field`;
                    item.addEventListener('click', (event) => populateNextFindField(pattern, event.target));
                    valuesDiv.appendChild(item);
                });
                patternRow.appendChild(valuesDiv);
                patternsInGroupDiv.appendChild(patternRow);
            }

            // Render Next Tool
            if (nextToolForThisGroup) {
                console.log(`renderGroupPatterns: Displaying Next Tool: ${nextToolForThisGroup} for group ${groupNumber}`);
                const patternRow = document.createElement('div');
                patternRow.className = 'pattern-row';

                const labelSpan = document.createElement('span');
                labelSpan.className = 'pattern-label';
                labelSpan.textContent = 'Next Tool (Calculated):';
                patternRow.appendChild(labelSpan);

                const valuesDiv = document.createElement('div');
                valuesDiv.className = 'pattern-values';
                const item = document.createElement('span');
                item.className = 'non-clickable-pattern-item'; // Non-clickable
                item.textContent = nextToolForThisGroup;
                item.title = `This is the next tool in sequence: ${nextToolForThisGroup}`;
                valuesDiv.appendChild(item);
                patternRow.appendChild(valuesDiv);
                patternsInGroupDiv.appendChild(patternRow);
                patternsFoundInGroupContent = true; // Mark as found
            } else {
                console.log(`renderGroupPatterns: No Next Tool to display for group ${groupNumber}`);
            }

            // Render H patterns (now non-clickable)
            if (hPatterns.size > 0) {
                const patternRow = document.createElement('div');
                patternRow.className = 'pattern-row';

                const labelSpan = document.createElement('span');
                labelSpan.className = 'pattern-label';
                labelSpan.textContent = 'H Height:';
                patternRow.appendChild(labelSpan);

                const valuesDiv = document.createElement('div');
                valuesDiv.className = 'pattern-values';
                hPatterns.forEach((count, pattern) => {
                    patternsFoundInGroupContent = true;
                    const item = document.createElement('span');
                    item.className = 'non-clickable-pattern-item'; // Changed class
                    item.textContent = `${pattern} (${count})`;
                    item.title = `H value: ${pattern}`; // Changed title
                    // Removed event listener
                    valuesDiv.appendChild(item);
                });
                patternRow.appendChild(valuesDiv);
                patternsInGroupDiv.appendChild(patternRow);
            }

            // Render D patterns (now non-clickable)
            if (dPatterns.size > 0) {
                const patternRow = document.createElement('div');
                patternRow.className = 'pattern-row';

                const labelSpan = document.createElement('span');
                labelSpan.className = 'pattern-label';
                labelSpan.textContent = 'D Diameter:';
                patternRow.appendChild(labelSpan);

                const valuesDiv = document.createElement('div');
                valuesDiv.className = 'pattern-values';
                dPatterns.forEach((count, pattern) => {
                    patternsFoundInGroupContent = true;
                    const item = document.createElement('span');
                    item.className = 'non-clickable-pattern-item'; // Changed class
                    item.textContent = `${pattern} (${count})`;
                    item.title = `D value: ${pattern}`; // Changed title
                    // Removed event listener
                    valuesDiv.appendChild(item);
                });
                patternRow.appendChild(valuesDiv);
                patternsInGroupDiv.appendChild(patternRow);
            }

            // Render S patterns
            if (sPatterns.size > 0) {
                const patternRow = document.createElement('div');
                patternRow.className = 'pattern-row';

                const labelSpan = document.createElement('span');
                labelSpan.className = 'pattern-label';
                labelSpan.textContent = 'S Speed:';
                patternRow.appendChild(labelSpan);

                const valuesDiv = document.createElement('div');
                valuesDiv.className = 'pattern-values';
                sPatterns.forEach((count, pattern) => {
                    patternsFoundInGroupContent = true;
                    const item = document.createElement('span');
                    item.className = 'pattern-item';
                    item.textContent = `${pattern} (${count})`;
                    item.title = `Click to add '${pattern}' to a Find field`;
                    item.addEventListener('click', (event) => populateNextFindField(pattern, event.target));
                    valuesDiv.appendChild(item);
                });
                patternRow.appendChild(valuesDiv);
                patternsInGroupDiv.appendChild(patternRow);
            }

            // Render F patterns
            if (fPatterns.size > 0) {
                const patternRow = document.createElement('div');
                patternRow.className = 'pattern-row';

                const labelSpan = document.createElement('span');
                labelSpan.className = 'pattern-label';
                labelSpan.textContent = 'F Feed:';
                patternRow.appendChild(labelSpan);

                const valuesDiv = document.createElement('div');
                valuesDiv.className = 'pattern-values';
                fPatterns.forEach((count, pattern) => {
                    patternsFoundInGroupContent = true;
                    const item = document.createElement('span');
                    item.className = 'pattern-item';
                    item.textContent = `${pattern} (${count})`;
                    item.title = `Click to add '${pattern}' to a Find field`;
                    item.addEventListener('click', (event) => populateNextFindField(pattern, event.target));
                    valuesDiv.appendChild(item);
                });
                patternRow.appendChild(valuesDiv);
                patternsInGroupDiv.appendChild(patternRow);
            }

            // Render TOOL DIA. patterns
            if (toolDiaPatterns.size > 0) {
                const patternRow = document.createElement('div');
                patternRow.className = 'pattern-row';

                const labelSpan = document.createElement('span');
                labelSpan.className = 'pattern-label';
                labelSpan.textContent = 'Tool Diameter Values:';
                patternRow.appendChild(labelSpan);

                const valuesDiv = document.createElement('div');
                valuesDiv.className = 'pattern-values';
                toolDiaPatterns.forEach((count, pattern) => {
                    patternsFoundInGroupContent = true;
                    const item = document.createElement('span');
                    item.className = 'pattern-item'; 
                    
                    // Extract just the numeric value for display
                    const numericValueMatch = pattern.match(/([+\-]?\d*\.?\d+)$/);
                    const displayValue = numericValueMatch ? parseFloat(numericValueMatch[1]) : 'N/A';
                    item.textContent = `Dia: ${displayValue}`;
                    
                    item.title = `Click to add '${pattern}' to a Find field`; 
                    item.addEventListener('click', (event) => populateNextFindField(pattern, event.target)); 
                    valuesDiv.appendChild(item);
                });
                patternRow.appendChild(valuesDiv);
                patternsInGroupDiv.appendChild(patternRow);
            }

            // Render G84 Operations
            if (g84DetailsForGroup.length > 0) {
                const patternRow = document.createElement('div');
                patternRow.className = 'pattern-row';

                const labelSpan = document.createElement('span');
                labelSpan.className = 'pattern-label';
                labelSpan.textContent = 'G84 Operations:';
                patternRow.appendChild(labelSpan);

                const valuesDiv = document.createElement('div');
                valuesDiv.className = 'pattern-values';
                g84DetailsForGroup.forEach(detail => {
                    patternsFoundInGroupContent = true;
                    const item = document.createElement('span');
                    item.className = 'pattern-item g84-pattern-item'; // Added g84-pattern-item class
                    item.textContent = `${detail.nValue}: S${detail.suggestedS} F${detail.suggestedF}`;
                    item.title = `Click to highlight line ${detail.nValue} and scroll to it`;
                    // Attach event listener to highlight and scroll, passing S and F
                    item.addEventListener('click', () => highlightLineAndScroll(detail.nValue, detail.suggestedS, detail.suggestedF));
                    valuesDiv.appendChild(item);
                });
                patternRow.appendChild(valuesDiv);
                patternsInGroupDiv.appendChild(patternRow);
            }


            if (!patternsFoundInGroupContent && (!nValueAssociatedWithM01 || nValueAssociatedWithM01 === 'N220') && specialCommentDescriptions.size === 0) { 
                const noPatterns = document.createElement('p');
                noPatterns.className = 'text-gray-500';
                noPatterns.textContent = 'No T, H, D, S, F, G84, TOOL DIA., or special comment patterns with values found in any group.';
                patternListDiv.appendChild(noPatterns);
            }

            groupSection.appendChild(patternsInGroupDiv);
            patternListDiv.appendChild(groupSection);

            if (hasM01Separator) {
                const m01Separator = document.createElement('p');
                m01Separator.className = 'text-center text-gray-600 font-bold my-4';
                m01Separator.textContent = '--- M01 ---';
                patternListDiv.appendChild(m01Separator);
            }
        }

        /**
         * Populates all detected T-patterns into the Find and Replace input fields.
         */
        function fillFindReplaceWithTPatterns() {
            // Clear existing find/replace inputs first
            for (let i = 0; i < MAX_INPUT_PAIRS; i++) {
                findInputs[i].value = '';
                replaceInputs[i].value = '';
                if (i > 0) { // Keep first pair visible, hide others
                    inputPairContainers[i].classList.add('hidden');
                }
            }
            
            let populatedCount = 0;
            for (let i = 0; i < allDetectedTPatterns.length && populatedCount < MAX_INPUT_PAIRS; i++) {
                const tPattern = allDetectedTPatterns[i];
                
                // Ensure the input pair is visible
                if (inputPairContainers[populatedCount].classList.contains('hidden')) {
                    inputPairContainers[populatedCount].classList.remove('hidden');
                }

                findInputs[populatedCount].value = tPattern;
                replaceInputs[populatedCount].value = 'T'; // Populate replace with 'T'
                populatedCount++;
            }

            currentFindInputIndex = populatedCount; // Set next available index for manual clicks

            if (populatedCount > 0) {
                showMessage(`${populatedCount} T-patterns automatically populated into Find/Replace fields.`, 'info');
            } else {
                showMessage('No T-patterns found to auto-populate.', 'info');
            }
        }

        let activeHighlightTempDiv = null;
        let originalTextAreaInitialParent = null; // To store the parent of fileContentTextArea when it's first replaced

        /**
         * Highlights a specific line in the textarea and scrolls to it.
         * Note: Direct background highlighting of a single line within a <textarea>
         * is not natively supported by CSS. This function simulates it by
         * replacing the content with HTML for a brief period.
         * @param {string} nValue - The N-value of the line to highlight (e.g., "N100").
         * @param {string|number} suggestedS - The suggested S value for the G84 operation.
         * @param {string|number} suggestedF - The suggested F value for the G84 operation.
         */
        function highlightLineAndScroll(nValue, suggestedS = 'N/A', suggestedF = 'N/A') {
            console.log(`Attempting to highlight line for N-value: ${nValue}`);
            const lines = fileContentTextArea.value.split('\n');
            let lineIndex = -1;
            let lineContent = '';

            // If there's an active highlight, revert it before starting a new one
            if (activeHighlightTempDiv) {
                console.log('Clearing previous highlight before new one.');
                // Ensure the original textarea is back in place
                if (activeHighlightTempDiv.parentNode && originalTextAreaInitialParent) {
                    // Check if fileContentTextArea is already in the DOM (e.g., if another highlight call already reverted it)
                    if (!originalTextAreaInitialParent.contains(fileContentTextArea)) {
                         activeHighlightTempDiv.parentNode.replaceChild(fileContentTextArea, activeHighlightTempDiv);
                         fileContentTextArea.scrollTop = activeHighlightTempDiv.scrollTop; // Restore scroll
                    }
                }
                activeHighlightTempDiv = null; // Clear reference
                clearTimeout(fileContentTextArea._highlightTimeout); // Clear any pending timeout
            }

            // Find the line index and content
            for (let i = 0; i < lines.length; i++) {
                const cleanedLine = cleanLineFromComments(lines[i]);
                const nValueRegex = new RegExp(`\\b${nValue}\\b`, 'i'); 
                if (nValueRegex.test(cleanedLine)) {
                    lineIndex = i;
                    lineContent = lines[i]; // Keep original line content for display
                    console.log(`Found line at index ${lineIndex}: "${lineContent}"`);
                    break;
                }
            }

            if (lineIndex !== -1) {
                // Store the initial parent if not already stored (only once)
                if (!originalTextAreaInitialParent) {
                    originalTextAreaInitialParent = fileContentTextArea.parentNode;
                }

                const tempDiv = document.createElement('div');
                // Copy all computed styles from the textarea to the temporary div
                const computedStyle = window.getComputedStyle(fileContentTextArea);
                for (const prop of computedStyle) {
                    tempDiv.style[prop] = computedStyle.getPropertyValue(prop);
                }
                // Override specific properties that might interfere or are not needed
                tempDiv.style.overflow = 'auto'; // Ensure scrollability
                tempDiv.style.whiteSpace = 'pre-wrap'; // Preserve whitespace and wrap lines
                tempDiv.style.wordBreak = 'break-all'; // Break long words if necessary
                tempDiv.style.height = fileContentTextArea.clientHeight + 'px'; // Explicitly set height to match textarea
                tempDiv.style.width = fileContentTextArea.clientWidth + 'px'; // Explicitly set width to match textarea


                const preContent = lines.slice(0, lineIndex).join('\n');
                const postContent = lines.slice(lineIndex + 1).join('\n');

                // Create a <pre> element inside the temporary div to preserve line breaks and spacing
                const contentHtml = document.createElement('pre');
                contentHtml.style.margin = '0'; // Remove default pre margin
                contentHtml.style.padding = '0'; // Remove default pre padding
                contentHtml.style.fontFamily = 'inherit'; // Inherit font from parent
                contentHtml.style.fontSize = 'inherit'; // Inherit font size from parent
                contentHtml.style.whiteSpace = 'pre-wrap'; // Ensure wrapping within pre

                // Create a span for the highlighted line
                const highlightedSpan = document.createElement('span');
                highlightedSpan.className = 'highlighted-line'; // This class will now apply red
                highlightedSpan.textContent = lineContent; // Use textContent to prevent HTML injection

                // Append content parts to the <pre> element
                contentHtml.appendChild(document.createTextNode(preContent));
                // Add a newline before the highlighted span only if there was content before it
                if (preContent.length > 0) {
                    contentHtml.appendChild(document.createTextNode('\n'));
                }
                contentHtml.appendChild(highlightedSpan);
                // Add a newline after the highlighted span only if there is content after it
                if (postContent.length > 0) {
                    contentHtml.appendChild(document.createTextNode('\n'));
                }
                contentHtml.appendChild(document.createTextNode(postContent));

                tempDiv.appendChild(contentHtml);

                // Perform the replacement
                if (fileContentTextArea.parentNode) { // Ensure the textarea still has a parent before replacing
                    fileContentTextArea.parentNode.replaceChild(tempDiv, fileContentTextArea);
                    activeHighlightTempDiv = tempDiv; // Set the active highlight
                    console.log('Textarea replaced with temporary div.');
                } else {
                    console.error("fileContentTextArea has no parent. Cannot replace it.");
                    showMessage("Error highlighting: Internal DOM issue.", 'error');
                    return;
                }

                tempDiv.scrollTop = highlightedSpan.offsetTop - tempDiv.clientHeight / 2 + highlightedSpan.clientHeight / 2;
                console.log(`Scrolled to offset: ${highlightedSpan.offsetTop}`);

                showMessage(`Line ${nValue} highlighted. Suggested S: ${suggestedS}, F: ${suggestedF}.`, 'info');

                // Store the timeout ID on the textarea itself or a global variable
                fileContentTextArea._highlightTimeout = setTimeout(() => {
                    if (activeHighlightTempDiv && activeHighlightTempDiv.parentNode) { // Ensure it's still the active one and has a parent
                        const currentScrollTop = activeHighlightTempDiv.scrollTop;
                        activeHighlightTempDiv.parentNode.replaceChild(fileContentTextArea, activeHighlightTempDiv);
                        fileContentTextArea.scrollTop = currentScrollTop;
                        console.log('Temporary div reverted to textarea. Scroll position restored.');
                    } else {
                        console.warn('Highlight div no longer active or has no parent, cannot revert gracefully.');
                    }
                    activeHighlightTempDiv = null; // Clear active highlight
                    fileContentTextArea._highlightTimeout = null;
                }, 3000);
            } else {
                showMessage(`Line with N-value '${nValue}' not found.`, 'error');
                console.log(`Line with N-value '${nValue}' not found.`);
            }
        }


        /**
         * Handles the file upload event.
         * Reads the file content and displays it in the textarea.
         */
        fileInput.addEventListener('change', (event) => {
            clearMessageBox();
            const file = event.target.files[0];
            if (file) {
                currentFileName = file.name.split('.').slice(0, -1).join('.') + '_edited.' + file.name.split('.').pop();
                fileNameSpan.textContent = `Selected: ${file.name}`;
                const reader = new FileReader();

                reader.onload = (e) => {
                    fileContentTextArea.value = e.target.result;
                    showMessage('File loaded successfully!', 'success');
                    hasAppliedNextToolLogic = false; // Reset flag on new file load
                    applyNextToolButton.classList.remove('button-disabled');
                    applyNextToolButton.disabled = false;
                    scanAndDisplayPatterns(); // This will now also trigger auto-population of T values
                };

                reader.onerror = () => {
                    showMessage('Error reading file!', 'error');
                    fileContentTextArea.value = '';
                    fileNameSpan.textContent = 'No file selected';
                };

                reader.readAsText(file);
            } else {
                fileContentTextArea.value = '';
                fileNameSpan.textContent = 'No file selected';
                currentFileName = 'edited_file.txt';
                showMessage('No file selected.', 'info');
                hasAppliedNextToolLogic = false; // Reset flag if no file is selected (cleared)
                applyNextToolButton.classList.remove('button-disabled');
                applyNextToolButton.disabled = false;
                scanAndDisplayPatterns(); // This will now also trigger auto-population of T values
            }
        });

        /**
         * Scans the content to find the first T<number>M6 in each M01-delimited block.
         * @param {string} content - The full file content.
         * @returns {Array<string>} An array of T<number> strings (e.g., "T5") found in each block.
         */
        function getBlockTools(content) {
            const lines = content.split('\n');
            const blockTools = [];
            let currentBlockContentLines = [];

            for (let i = 0; i < lines.length; i++) {
                const line = lines[i];
                const trimmedLine = line.trim();

                if (trimmedLine.toLowerCase().includes('m01')) {
                    // Process the current block content
                    let tMatch = null;
                    for (const blockLine of currentBlockContentLines) {
                        const cleanedBlockLine = cleanLineFromComments(blockLine);
                        const tM6Match = cleanedBlockLine.match(/(T\d+)\s*M6/i); // Robust regex for T<number>M6
                        if (tM6Match) {
                            tMatch = tM6Match[1].toUpperCase(); // Capture T<number> and ensure uppercase
                            break; // Found the first T<number>M6 in this block
                        }
                    }
                    if (tMatch) { // Only push if a T<number>M6 was found in the block
                        blockTools.push(tMatch);
                    }
                    currentBlockContentLines = []; // Reset for next block
                } else {
                    currentBlockContentLines.push(line);
                }
            }

            // Process any remaining content after the last M01 (or if no M01s were found)
            if (currentBlockContentLines.length > 0) {
                let tMatch = null;
                for (const blockLine of currentBlockContentLines) {
                    const cleanedBlockLine = cleanLineFromComments(blockLine);
                    const tM6Match = cleanedBlockLine.match(/(T\d+)\s*M6/i);
                    if (tM6Match) {
                        tMatch = tM6Match[1].toUpperCase();
                        break;
                    }
                }
                if (tMatch) { // Only push if a T<number>M6 was found in the block
                    blockTools.push(tMatch);
                }
            }
            return blockTools; // This array will now only contain T<number> strings
        }


        /**
         * Handles the "Scan & Replace All" button click.
         * Applies direct find/replace operations and T, H, D, S, F propagation.
         */
        replaceButton.addEventListener('click', () => {
            clearMessageBox();
            let fullContent = fileContentTextArea.value;
            let replacementsMade = 0;
            let validationPassed = true;

            // Attempt to parse formulas from input fields
            const tempSConstants = parseSFormula(sFormulaInput.value);
            const tempFConstants = parseFFormula(fFormulaInput.value);

            if (!tempSConstants) {
                showMessage('Error: Invalid S Formula format. Using default: S = (3.82 * 800) / TOOL DIA', 'error');
                sFormulaInput.value = "S = (3.82 * 800) / TOOL DIA"; 
                sFormulaConstants = { num1: 3.82, num2: 800 }; 
            } else {
                sFormulaConstants = tempSConstants;
            }

            if (!tempFConstants) {
                showMessage('Error: Invalid F Formula format. Using default: F = S * 4 * 0.003', 'error');
                fFormulaInput.value = "F = S * 4 * 0.003"; 
                fFormulaConstants = { num1: 4, num2: 0.003 }; 
            } else {
                fFormulaConstants = tempFConstants;
            }

            console.log(`--- Formula Parsing Results ---`);
            console.log(`Parsed S Formula Constants: num1=${sFormulaConstants.num1}, num2=${sFormulaConstants.num2}`);
            console.log(`Parsed F Formula Constants: num1=${fFormulaConstants.num1}, num2=${fFormulaConstants.num2}`);
            console.log(`-----------------------------`);


            const replacementsToApply = [];
            for (let i = 0; i < MAX_INPUT_PAIRS; i++) {
                const findValue = findInputs[i].value.trim();
                let replaceValue = replaceInputs[i].value.trim(); // User's input in replace field

                if (findValue === '' && replaceValue === '') {
                    continue; // Skip empty pairs
                }

                // Validation: if one is present, the other must also be present
                if ((findValue === '' && replaceValue !== '') || (findValue !== '' && replaceValue === '')) {
                    showMessage(`Error: Both Find ${i + 1} and Replace ${i + 1} must be filled or both left empty.`, 'error');
                    validationPassed = false;
                    break;
                }

                let effectiveReplaceValue = replaceValue; // This will be the value used for actual replacement
                let newTNumericForPair = null; // This will be the numeric part of the T value for propagation

                // Handle 'T' patterns specifically
                if (findValue.toUpperCase().startsWith('T') && /\d+/.test(findValue)) {
                    const originalTNumeric = parseInt(findValue.match(/\d+/)[0], 10);

                    // Case 1: Replace is empty or 'T' (case-insensitive)
                    // If replaceValue is empty, or just 'T', use findValue as effectiveReplaceValue
                    // and original numeric for propagation.
                    if (replaceValue === '' || replaceValue.toLowerCase() === 't') {
                        effectiveReplaceValue = findValue;
                        newTNumericForPair = originalTNumeric;
                        console.log(`Debug: T pattern, replace empty/T. effectiveReplaceValue: ${effectiveReplaceValue}, newTNumericForPair: ${newTNumericForPair}`);
                    }
                    // Case 2: Replace is a number (e.g., "25")
                    else if (/^\d+$/.test(replaceValue)) {
                        effectiveReplaceValue = 'T' + replaceValue; // Convert "25" to "T25"
                        newTNumericForPair = parseInt(replaceValue, 10);
                        console.log(`Debug: T pattern, replace is number. effectiveReplaceValue: ${effectiveReplaceValue}, newTNumericForPair: ${newTNumericForPair}`);
                    }
                    // Case 3: Replace is a full T pattern (e.g., "T30")
                    else if (replaceValue.toUpperCase().startsWith('T') && /\d+/.test(replaceValue)) {
                        effectiveReplaceValue = replaceValue;
                        newTNumericForPair = parseInt(replaceValue.match(/\d+/)[0], 10);
                        console.log(`Debug: T pattern, replace is full T. effectiveReplaceValue: ${effectiveReplaceValue}, newTNumericForPair: ${newTNumericForPair}`);
                    }
                    // If none of the above, it's an invalid T replacement.
                    else {
                        showMessage(`Error: For T-pattern '${findValue}', Replace ${i + 1} must be empty, 'T', a number (e.g., '25'), or a full T-pattern (e.g., 'T25').`, 'error');
                        validationPassed = false;
                        break;
                    }
                } else {
                    // For non-T patterns, if replaceValue is empty, use findValue as effectiveReplaceValue
                    if (replaceValue === '') {
                        effectiveReplaceValue = findValue;
                        console.log(`Debug: Non-T pattern, replace empty. effectiveReplaceValue: ${effectiveReplaceValue}`);
                    }
                }

                const pair = {
                    find: findValue,
                    replace: replaceValue, // Keep original user input for display/debug
                    effectiveReplace: effectiveReplaceValue, // The value actually used for replacement
                    findLabel: `Find ${i + 1}`,
                    replaceLabel: `Replace ${i + 1}`,
                    originalTNumeric: findValue.toUpperCase().startsWith('T') && /\d+/.test(findValue) ? parseInt(findValue.match(/\d+/)[0], 10) : null,
                    newTNumeric: newTNumericForPair // Numeric value derived from effectiveReplaceValue for T-propagation
                };
                replacementsToApply.push(pair);
            }

            if (!validationPassed) {
                return;
            }

            // Global propagation variables, persist across lines within a block
            let propagateNewTNumericValue = null;
            let propagationStartNValue = -1; 
            let shouldPropagateHD = false; // Flag to enable H/D propagation

            let propagateNewSNumericValue = null;
            let sPropagationOriginLineN = -1;
            let propagateNewFNumericValue = null;
            let fPropagationOriginLineN = -1;

            let currentGroupToolDiaValue = null; 
            let currentGroupSNumericValue = null; 

            const lines = fullContent.split('\n');
            const newLines = [];

            lines.forEach((line, index) => { 
                let processedLine = line;
                let nMatch = line.match(/N(\d+)/i);
                let currentLineNValue = nMatch ? parseInt(nMatch[1], 10) : -1;

                // Flags and values for current line's processing
                let tValueFoundOnM6Line = false; 
                let tNumericValueFromM6Line = null; 
                let tChangedByDirectReplaceOnThisLine = false; // New flag

                let sChangedOnThisLine = false; 
                let fChangedOnThisLine = false; 
                let toolDiaChangedOnThisLine = false; 

                let sNewNumericValueForCurrentLine = null; 
                let fNewNumericValueForCurrentLine = null; 
                let toolDiaNewNumericValueForCurrentLine = null; 

                console.log(`--- Processing Line ${index + 1} (N${currentLineNValue !== -1 ? currentLineNValue : 'N/A'}) ---`);
                console.log(`Original Line: "${line}"`);
                console.log(`  Initial propagation state: T=${propagateNewTNumericValue}, H/D_Enabled=${shouldPropagateHD}`);


                const originalCleanedLine = cleanLineFromComments(line);

                // Check for M01 to reset propagation for new blocks
                const isM01Line = processedLine.toLowerCase().includes('m01');
                if (isM01Line) {
                    propagateNewTNumericValue = null;
                    propagationStartNValue = -1;
                    shouldPropagateHD = false; 
                    propagateNewSNumericValue = null;
                    sPropagationOriginLineN = -1;
                    propagateNewFNumericValue = null;
                    fPropagationOriginLineN = -1;
                    
                    currentGroupSNumericValue = null; 
                    currentGroupToolDiaValue = null; 

                    console.log(`Line ${index + 1}: M01 detected. All propagations and group contexts reset.`); 
                }

                // --- Determine T value for H/D propagation based on M6 on original line ---
                // This must happen *before* direct replacements, to capture the original T value associated with M6.
                const tM6OnOriginalLineMatch = originalCleanedLine.match(/(T(\d+))\s*M6/i);
                if (tM6OnOriginalLineMatch) {
                    tValueFoundOnM6Line = true;
                    tNumericValueFromM6Line = tM6OnOriginalLineMatch[2]; // Capture the numeric part of T from the M6 line
                    console.log(`Line ${index + 1}: T${tNumericValueFromM6Line}M6 found on original line. This line is a potential H/D propagation origin.`);
                }


                // --- Apply all direct find/replace operations ---
                replacementsToApply.forEach(pair => {
                    const findValue = pair.find;
                    const effectiveReplaceValue = pair.effectiveReplace.toUpperCase();
                    const escapedFindValue = findValue.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
                    const regex = new RegExp(escapedFindValue, 'gi');

                    // Check if a T replacement is happening on this specific line
                    if (findValue.toUpperCase().startsWith('T') && /\d+/.test(findValue)) {
                        if (regex.test(processedLine)) { // If the findValue (T pattern) is found in the current processed line
                            // A direct T replacement is occurring on this line.
                            // The new T numeric from this replacement should be considered for propagation.
                            tNumericValueFromM6Line = String(pair.newTNumeric); // This overrides the original M6 T if a replacement happens
                            tChangedByDirectReplaceOnThisLine = true; // Mark that a T was directly replaced
                            console.log(`Line ${index + 1}: Direct T replacement for '${findValue}'. New T numeric for propagation (overriding if M6 present): ${tNumericValueFromM6Line}.`);
                        }
                    }

                    // Check for S replacement
                    if (findValue.toUpperCase().startsWith('S') && /\d+\.?\d*/.test(findValue) && /\d+\.?\d*/.test(effectiveReplaceValue)) {
                        const originalSNumeric = parseFloat(findValue.match(/\d+\.?\d*/)[0]);
                        const newSNumeric = parseFloat(effectiveReplaceValue.match(/\d+\.?\d*/)[0]);
                        if (regex.test(processedLine) && originalSNumeric !== newSNumeric) {
                            sChangedOnThisLine = true;
                            sNewNumericValueForCurrentLine = newSNumeric;
                            console.log(`Line ${index + 1}: Direct replacement of S value: ${findValue} -> ${effectiveReplaceValue}. New S numeric for propagation: ${sNewNumericValueForCurrentLine}`);
                        }
                    }

                    // Check for F replacement
                    if (findValue.toUpperCase().startsWith('F') && /\d+\.?\d*/.test(findValue) && /\d+\.?\d*/.test(effectiveReplaceValue)) {
                        const originalFNumeric = parseFloat(findValue.match(/\d+\.?\d*/)[0]);
                        const newFNumeric = parseFloat(effectiveReplaceValue.match(/\d+\.?\d*/)[0]);
                        if (regex.test(processedLine) && originalFNumeric !== newFNumeric) {
                            fChangedOnThisLine = true;
                            fNewNumericValueForCurrentLine = newFNumeric;
                            console.log(`Line ${index + 1}: Direct replacement of F value: ${findValue} -> ${effectiveReplaceValue}. New F numeric for propagation: ${fNewNumericValueForCurrentLine}`);
                        }
                    }

                    // Check for TOOL DIA. replacement
                    if (toolDiaPatternRegex.test(findValue) && toolDiaPatternRegex.test(effectiveReplaceValue)) {
                        const newToolDiaMatch = effectiveReplaceValue.match(/([+\-]?\d*\.?\d+)$/i);
                        if (newToolDiaMatch) {
                            const newToolDiaValue = parseFloat(newToolDiaMatch[1]);
                            if (regex.test(processedLine)) { 
                                toolDiaChangedOnThisLine = true;
                                toolDiaNewNumericValueForCurrentLine = newToolDiaValue;
                                console.log(`Line ${index + 1}: Direct TOOL DIA replacement: ${findValue} -> ${effectiveReplaceValue}. New TOOL DIA numeric for context: ${toolDiaNewNumericValueForCurrentLine}`);
                            }
                        }
                    }

                    processedLine = processedLine.replace(regex, (match) => {
                        replacementsMade++;
                        console.log(`Line ${index + 1}: Direct replacement: "${match}" replaced with "${effectiveReplaceValue}"`);
                        return effectiveReplaceValue;
                    });
                });
                console.log(`Line ${index + 1}: After direct replacements: "${processedLine}"`);

                // --- Update currentGroupToolDiaValue and currentGroupSNumericValue based on *this line's* content (after direct replacements) ---
                const toolDiaMatchOnProcessedLine = processedLine.match(/TOOL DIA\.?\s*[=\-]?\s*([+\-]?\d*\.?\d+)/i);
                if (toolDiaMatchOnProcessedLine) {
                    currentGroupToolDiaValue = parseFloat(toolDiaMatchOnProcessedLine[1]);
                    console.log(`Line ${index + 1}: Re-evaluated TOOL DIA on processed line for context: ${currentGroupToolDiaValue}.`);
                }

                const sMatchOnProcessedLineForContext = processedLine.match(/S(\d+\.?\d*)/i);
                if (sMatchOnProcessedLineForContext) {
                    currentGroupSNumericValue = parseFloat(sMatchOnProcessedLineForContext[1]);
                    console.log(`Line ${index + 1}: currentGroupSNumericValue updated after S replacement on this line: ${currentGroupSNumericValue}.`);
                }

                // --- Set global T, H, D propagation state ---
                // If this line has T<num>M6 (either originally or after direct replacement),
                // then this is the new source for H/D propagation.
                if (tValueFoundOnM6Line && tNumericValueFromM6Line !== null) {
                    propagateNewTNumericValue = tNumericValueFromM6Line;
                    propagationStartNValue = currentLineNValue;
                    shouldPropagateHD = true; 
                    console.log(`Line ${index + 1}: T<num>M6 detected. H/D propagation INITIATED/UPDATED. Propagating T=${propagateNewTNumericValue}`);
                } else if (!isM01Line) {
                    // If it's not an M01 line and no new T<num>M6 was found on this line,
                    // the propagation state should simply persist from the previous M6 line.
                    // No explicit action needed here, as the variables already hold their previous state.
                    console.log(`Line ${index + 1}: No new T<num>M6. H/D propagation CONTINUES. Propagating T=${propagateNewTNumericValue}`);
                }


                // --- Set propagation values for S and F ---
                if (sChangedOnThisLine) {
                    propagateNewSNumericValue = sNewNumericValueForCurrentLine;
                    sPropagationOriginLineN = currentLineNValue;
                    console.log(`Line ${index + 1}: S Propagation activated. Target S numeric: ${propagateNewSNumericValue}, Start N: ${sPropagationOriginLineN}`);
                }
                if (fChangedOnThisLine) {
                    propagateNewFNumericValue = fNewNumericValueForCurrentLine;
                    fPropagationOriginLineN = currentLineNValue;
                    console.log(`Line ${index + 1}: F Propagation activated. Target F numeric: ${propagateNewFNumericValue}, Start N: ${fPropagationOriginLineN}`);
                }


                // --- Apply S value calculation and propagation ---
                let calculatedSNumericFromToolDia = null;
                if (currentGroupToolDiaValue !== null && !isNaN(currentGroupToolDiaValue) && currentGroupToolDiaValue !== 0) {
                    calculatedSNumericFromToolDia = Math.round((sFormulaConstants.num1 * sFormulaConstants.num2) / currentGroupToolDiaValue);
                    console.log(`Line ${index + 1}: S calculated from TOOL DIA in context: ${calculatedSNumericFromToolDia}`);
                }

                const regexS = /S(\d+\.?\d*)/gi;
                if ((propagateNewSNumericValue !== null && currentLineNValue >= sPropagationOriginLineN && sPropagationOriginLineN !== -1) ||
                    (processedLine.match(regexS) && calculatedSNumericFromToolDia !== null)) {

                    processedLine = processedLine.replace(regexS, (match, p1) => {
                        const oldSNumericValue = parseFloat(p1);
                        let newSNumericToApply = propagateNewSNumericValue; 

                        if (propagateNewSNumericValue === null && calculatedSNumericFromToolDia !== null) {
                            newSNumericToApply = calculatedSNumericFromToolDia;
                        }

                        if (newSNumericToApply !== null) {
                            if (newSNumericToApply > 15000) {
                                showMessage(`S value ${newSNumericToApply} on line N${currentLineNValue !== -1 ? currentLineNValue : 'N/A'} capped at 15000!`, 'error');
                                newSNumericToApply = 15000;
                            }

                            if (oldSNumericValue !== newSNumericToApply) {
                                replacementsMade++;
                                console.log(`Line ${index + 1}: S value updated by propagation/calculation: "${match}" -> "S${newSNumericToApply}"`);
                                return 'S' + newSNumericToApply;
                            }
                        }
                        return match;
                    });

                    const sMatchAfterSUpdate = processedLine.match(/S(\d+\.?\d*)/i);
                    if (sMatchAfterSUpdate) {
                        currentGroupSNumericValue = parseFloat(sMatchAfterSUpdate[1]);
                        console.log(`Line ${index + 1}: currentGroupSNumericValue updated after S replacement on this line: ${currentGroupSNumericValue}`);
                    }
                }


                // --- Apply F value calculation and propagation ---
                let calculatedFNumericFromS = null;
                if (currentGroupSNumericValue !== null && !isNaN(currentGroupSNumericValue) && currentGroupToolDiaValue !== null && !isNaN(currentGroupToolDiaValue) && currentGroupToolDiaValue !== 0) {
                    calculatedFNumericFromS = currentGroupSNumericValue * fFormulaConstants.num1 * fFormulaConstants.num2;
                    console.log(`Line ${index + 1}: F calculated from S in context: ${calculatedFNumericFromS}`);
                }

                const regexF = /F(\d+\.?\d*)/gi;
                if ((propagateNewFNumericValue !== null && currentLineNValue >= fPropagationOriginLineN && fPropagationOriginLineN !== -1) ||
                    (processedLine.match(regexF) && calculatedFNumericFromS !== null)) {

                    processedLine = processedLine.replace(regexF, (match, p1) => {
                        const oldFNumericValue = parseFloat(p1);
                        let newFNumericToApply = propagateNewFNumericValue; 

                        if (propagateNewFNumericValue === null && calculatedFNumericFromS !== null) {
                            newFNumericToApply = calculatedFNumericFromS;
                        }

                        if (newFNumericToApply !== null) {
                            if (newFNumericToApply > 40) {
                                showMessage(`F value ${newFNumericToApply.toFixed(3)} on line N${currentLineNValue !== -1 ? currentLineNValue : 'N/A'} capped at 40!`, 'error');
                                newFNumericToApply = 40;
                            }

                            if (oldFNumericValue.toFixed(3) !== newFNumericToApply.toFixed(3)) { 
                                replacementsMade++;
                                console.log(`Line ${index + 1}: F value updated by propagation/calculation: "${match}" -> "F${newFNumericToApply.toFixed(3)}"`);
                                return 'F' + newFNumericToApply.toFixed(3);
                            }
                        }
                        return match;
                    });
                }


                // --- Apply H and D propagation (based on T) ---
                if (shouldPropagateHD && propagateNewTNumericValue !== null && currentLineNValue >= propagationStartNValue && propagationStartNValue !== -1) {
                    console.log(`Line ${index + 1}: H/D PROPAGATION ACTIVE. Target T numeric for H/D: ${propagateNewTNumericValue}`);
                    const targetNumericValue = parseInt(propagateNewTNumericValue, 10);

                    // Apply H replacements
                    const regexH = /H(\d+)/gi;
                    processedLine = processedLine.replace(regexH, (match, p1) => {
                        const oldHNumericValue = parseInt(p1, 10);
                        if (oldHNumericValue !== targetNumericValue) { 
                            replacementsMade++;
                            console.log(`Line ${index + 1}: H value updated: "${match}" -> "H${propagateNewTNumericValue}"`);
                            return 'H' + propagateNewTNumericValue; 
                        }
                        return match;
                    });

                    // Apply D replacements
                    const regexD = /D(\d+)/gi;
                    processedLine = processedLine.replace(regexD, (match, p1) => {
                        const oldDNumericValue = parseInt(p1, 10);
                        if (oldDNumericValue !== targetNumericValue) { 
                            replacementsMade++;
                            console.log(`Line ${index + 1}: D value updated: "${match}" -> "D${propagateNewTNumericValue}"`);
                            return 'D' + propagateNewTNumericValue; 
                        }
                        return match;
                    });
                } else if (propagateNewTNumericValue !== null && currentLineNValue >= propagationStartNValue && propagationStartNValue !== -1 && !shouldPropagateHD) {
                    console.log(`Line ${index + 1}: T propagation active (${propagateNewTNumericValue}), but H/D update skipped as shouldPropagateHD is false.`);
                }
                newLines.push(processedLine);
                console.log(`Line ${index + 1}: Final Line: "${processedLine}"`);
                console.log(`--- End Line ${index + 1} ---`);
            });

            fileContentTextArea.value = newLines.join('\n');

            if (replacementsMade > 0) {
                showMessage(`${replacementsMade} replacements made!`, 'success');
            } else {
                showMessage('No replacements made or nothing to replace.', 'info');
            }
            scanAndDisplayPatterns(); 

            for (let i = 0; i < MAX_INPUT_PAIRS; i++) {
                findInputs[i].value = '';
                replaceInputs[i].value = '';
                if (i > 0) {
                    inputPairContainers[i].classList.add('hidden');
                }
            }
            currentFindInputIndex = 0; 
        });

        /**
         * Applies the "next tool" logic to the file content, inserting a new line and re-indexing N values.
         */
        applyNextToolButton.addEventListener('click', () => {
            clearMessageBox();
            if (hasAppliedNextToolLogic) {
                showMessage("The 'Apply Next Tool Logic' has already been applied. Please use 'Scan & Replace All' for further updates or clear the content to re-enable this function.", 'info');
                return;
            }

            let fullContent = fileContentTextArea.value;
            if (fullContent.trim() === "") {
                showMessage("Please upload a CNC file or enter content before applying 'Next Tool' logic.", 'error');
                return;
            }

            const originalLines = fullContent.split('\n');
            const linesWithInsertions = []; 
            const blockTools = getBlockTools(fullContent);
            console.log("Apply Next Tool Logic: Detected blockTools (unique T...M6 tools in order):", blockTools);

            let currentBlockIndex = -1;
            let changesMade = 0;

            originalLines.forEach((line, lineIndex) => {
                linesWithInsertions.push(line); 

                const isM01Line = line.toLowerCase().includes('m01');
                if (isM01Line) {
                    currentBlockIndex++;
                    console.log(`Line ${lineIndex + 1}: M01 detected. currentBlockIndex set to ${currentBlockIndex}`);
                }

                const tM6Regex = /(T\d+)\s*M6/i;
                const tM6Match = line.match(tM6Regex); 

                if (tM6Match) {
                    const currentToolOnly = tM6Match[1].match(/T(\d+)/i)[0]; 
                    console.log(`Line ${lineIndex + 1}: Found T...M6: "${tM6Match[1]}". Current tool for this line: "${currentToolOnly}"`);

                    let nextToolValue = null;
                    if (blockTools.length > 0) {
                        const currentToolIndexInBlockTools = blockTools.indexOf(currentToolOnly);
                        if (currentToolIndexInBlockTools !== -1) {
                            const nextBlockToolIndex = (currentToolIndexInBlockTools + 1) % blockTools.length;
                            nextToolValue = blockTools[nextBlockToolIndex];
                            console.log(`Line ${lineIndex + 1}: Calculated next tool value: ${nextToolValue} (from index ${nextBlockToolIndex})`);
                        } else {
                            console.log(`Line ${lineIndex + 1}: Current tool "${currentToolOnly}" not found in blockTools array. Cannot determine next tool.`);
                        }
                    } else {
                        console.log(`Line ${lineIndex + 1}: blockTools array is empty. Cannot determine next tool.`);
                    }

                    if (nextToolValue) {
                        const currentToolNumeric = parseInt(currentToolOnly.replace('T', ''), 10);
                        const nextToolNumeric = parseInt(nextToolValue.replace('T', ''), 10);

                        if (currentToolNumeric !== nextToolNumeric) {
                            linesWithInsertions.push(`   ${nextToolValue}`); 
                            changesMade++;
                            console.log(`Line ${lineIndex + 1}: Inserting new line for next tool: "   ${nextToolValue}"`);
                        } else {
                            console.log(`Line ${lineIndex + 1}: Next tool "${nextToolValue}" is same as current tool "${currentToolOnly}". No new line inserted.`);
                        }
                    } else {
                        console.log(`Line ${lineIndex + 1}: No next tool value determined for insertion.`);
                    }
                }
            });

            // --- Second Pass: Re-index N values ---
            const finalLines = [];
            let currentN = 10; 
            const nIncrement = 5; 

            let firstNFound = false;
            for (const line of linesWithInsertions) {
                const nMatch = line.match(/^N(\d+)/i);
                if (nMatch) {
                    currentN = parseInt(nMatch[1], 10);
                    firstNFound = true;
                    break;
                }
            }

            linesWithInsertions.forEach(line => {
                let modifiedLine = line;
                const nMatch = line.match(/^N(\d+)/i);

                if (nMatch) {
                    modifiedLine = `N${currentN} ` + line.substring(nMatch[0].length).trim();
                    currentN += nIncrement;
                } else if (line.trim().startsWith('T') && line.trim().length > 1) { 
                    modifiedLine = `N${currentN} ${line.trim()}`;
                    currentN += nIncrement;
                }
                finalLines.push(modifiedLine);
            });

            fileContentTextArea.value = finalLines.join('\n');

            if (changesMade > 0) {
                showMessage(`${changesMade} 'Next Tool' lines inserted and N values re-indexed!`, 'success');
                hasAppliedNextToolLogic = true; // Set flag to true after successful application
                applyNextToolButton.classList.add('button-disabled');
                applyNextToolButton.disabled = true;
            } else {
                showMessage('No "Next Tool" changes were needed or found.', 'info');
            }
            scanAndDisplayPatterns(); 
        });


        /**
         * Handles the "Download Edited File" button click.
         * Creates a Blob from the textarea content and triggers a download.
         */
        downloadButton.addEventListener('click', () => {
            clearMessageBox();
            const content = fileContentTextArea.value;
            if (!content) {
                showMessage('No content to download!', 'error');
                return;
            }

            const blob = new Blob([content], { type: 'text/plain' });
            const url = URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.href = url;
            a.download = currentFileName;
            document.body.appendChild(a);
            a.click();
            document.body.removeChild(a);
            URL.revokeObjectURL(url);

            showMessage('File downloaded successfully!', 'success');
        });

        /**
         * Handles the "Clear All" button click.
         * Clears all inputs and the textarea.
         */
        clearButton.addEventListener('click', () => {
            clearMessageBox();
            fileInput.value = '';
            fileNameSpan.textContent = 'No file selected';
            fileContentTextArea.value = '';
            
            for (let i = 0; i < MAX_INPUT_PAIRS; i++) {
                findInputs[i].value = '';
                replaceInputs[i].value = '';
                if (i > 0) {
                    inputPairContainers[i].classList.add('hidden');
                }
            }
            currentFileName = 'edited_file.txt';
            showMessage('All fields cleared.', 'info');
            hasAppliedNextToolLogic = false; // Reset flag on clear
            applyNextToolButton.classList.remove('button-disabled');
            applyNextToolButton.disabled = false;
            scanAndDisplayPatterns(); 
            currentFindInputIndex = 0;
        });

        // Add event listener for direct input into the textarea
        fileContentTextArea.addEventListener('input', () => {
            scanAndDisplayPatterns(); 
        });

        // Initial setup on window load
        window.addEventListener('load', () => {
            createInputPairs();
            sFormulaInput.value = `S = (${sFormulaConstants.num1} * ${sFormulaConstants.num2}) / TOOL DIA`;
            fFormulaInput.value = `F = S * ${fFormulaConstants.num1} * ${fFormulaConstants.num2}`;
            scanAndDisplayPatterns(); 
        });
    </script>
</body>
</html>
