  <!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>File Editor</title>
    <link rel="icon" href="data:image/x-icon;base64,AAABAAEAEBAAAAEAIABoBAAAFgAAACgAAAAQAAAAIAAAAAEAGAAAAAAAAAAA" type="image/x-icon">
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body {
            font-family: "Inter", sans-serif;
            display: flex;
            justify-content: center;
            align-items: flex-start;
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
            max-width: 800px;
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }
        .file-content-editor {
            min-height: 300px;
            resize: vertical;
            font-family: monospace;
            font-size: 0.9rem;
            width: 100%;
            padding: 1rem;
            border: 1px solid #d1d5db; /* gray-300 */
            border-radius: 0.5rem; /* rounded-lg */
            outline: none;
            overflow-y: auto;
            white-space: pre-wrap;
            word-break: break-all;
            line-height: 1.5;
            tab-size: 4;
        }
        .file-content-editor:focus {
            border-color: #3b82f6; /* blue-500 */
            box-shadow: 0 0 0 2px rgba(59, 130, 246, 0.5); /* ring-2 focus:ring-blue-500 */
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
            width: 60px;
            text-align: right;
            font-weight: 500;
        }
        .input-pair input[type="text"] {
            flex-grow: 1;
        }
        .button-group {
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
            justify-content: center;
        }
        .button-group button, .button-group label {
            flex: 1 1 auto;
            min-width: 120px;
        }
        .file-input-label {
            background-color: #3b82f6;
            color: white;
            padding: 0.75rem 1.5rem;
            border-radius: 0.5rem;
            cursor: pointer;
            text-align: center;
            transition: background-color 0.2s;
            display: inline-block;
            font-weight: 600;
        }
        .file-input-label:hover {
            background-color: #2563eb;
        }
        .file-input-label input[type="file"] {
            display: none;
        }
        .message-box {
            padding: 1rem;
            border-radius: 0.5rem;
            font-weight: 500;
            text-align: center;
            margin-top: 1rem;
        }
        .message-box.success {
            background-color: #d1fae5;
            color: #065f46;
        }
        .message-box.error {
            background-color: #fee2e2;
            color: #991b1b;
        }
        .message-box.info {
            background-color: #e0f2fe;
            color: #0369a1;
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
        .pattern-list {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }
        .pattern-row {
            display: flex;
            align-items: baseline;
            gap: 0.75rem;
        }
        .pattern-label {
            min-width: 150px;
            font-weight: 600;
            color: #4a5568;
            flex-shrink: 0;
        }
        .pattern-values {
            display: flex;
            flex-wrap: wrap;
            gap: 0.75rem;
            flex-grow: 1;
        }

        .pattern-item {
            background-color: #e0f2fe;
            color: #0369a1;
            padding: 0.5rem 1rem;
            border-radius: 0.5rem;
            font-size: 0.875rem;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.2s, transform 0.1s;
        }
        .pattern-item:hover {
            background-color: #90cdf4;
            transform: translateY(-2px);
        }
        .pattern-item:active {
            transform: translateY(0);
        }
        .non-clickable-pattern-item {
            background-color: #f0f4f8;
            color: #4a5568;
            padding: 0.5rem 1rem;
            border-radius: 0.5rem;
            font-size: 0.875rem;
            font-weight: 500;
            cursor: default;
            transition: none;
        }
        .non-clickable-pattern-item:hover {
            background-color: #f0f4f8;
            transform: none;
        }
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
        .highlighted-line {
            background-color: rgba(255, 0, 0, 0.3);
            animation: fadeOutRed 3s forwards;
        }

        @keyframes fadeOutRed {
            from { background-color: rgba(255, 0, 0, 0.3); }
            to { background-color: transparent; }
        }

        .g84-pattern-item {
            background-color: #ef4444;
            color: white;
        }
        .g84-pattern-item:hover {
            background-color: #dc2626;
        }
        .button-disabled {
            opacity: 0.6;
            cursor: not-allowed;
            background-color: #9ca3af;
        }
        .button-disabled:hover {
            background-color: #9ca3af;
        }
        .error-highlight {
            color: red;
            font-weight: bold;
        }
        .match-highlight {
            color: green;
            font-weight: bold;
        }
        /* New classes for pattern list items */
        .match-highlight-pattern-item {
            background-color: #d1fae5; /* green-100 */
            color: #065f46; /* green-800 */
            font-weight: 600;
            padding: 0.5rem 1rem;
            border-radius: 0.5rem;
            font-size: 0.875rem;
        }
        .error-highlight-pattern-item {
            background-color: #fee2e2; /* red-100 */
            color: #991b1b; /* red-800 */
            font-weight: 600;
            padding: 0.5rem 1rem;
            border-radius: 0.5rem;
            font-size: 0.875rem;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="text-3xl font-bold text-center text-gray-800 mb-4">File Content Editor</h1>

        <div class="flex flex-col items-center gap-4">
            <label for="fileInput" class="file-input-label">
                Upload File
                <input type="file" id="fileInput" accept=".txt, .csv, .json, .log, .xml, .html, .css, .js">
            </label>
            <span id="fileName" class="text-gray-600 text-sm">No file selected</span>
        </div>

        <div id="fileContentEditor"
             class="file-content-editor"
             contenteditable="true"
             spellcheck="false"></div>

        <div class="input-group" id="findReplaceInputsContainer">
            <h2 class="text-xl font-semibold text-gray-700 mb-2">Find and Replace Values</h2>
            <div class="input-pair" id="inputPair1">
                <label for="find1">Find 1:</label>
                <input type="text" id="find1" class="p-2 border border-gray-300 rounded-md focus:ring-1 focus:ring-blue-400 outline-none" placeholder="e.g., T10">
                <label for="replace1">Replace 1:</label>
                <input type="text" id="replace1" class="p-2 border border-gray-300 rounded-md focus:ring-1 focus:ring-blue-400 outline-none" placeholder="e.g., TempValue">
            </div>
            <button id="replaceButton"
                    class="bg-green-500 hover:bg-green-600 text-white font-bold py-2 px-4 rounded-lg transition duration-200 shadow-md">
                Scan & Replace All
            </button>
            <div id="messageBox" class="message-box hidden"></div>
        </div>

        <div class="button-group">
            <button id="applyNextToolButton"
                    class="bg-purple-600 hover:bg-purple-700 text-white font-bold py-2 px-4 rounded-lg transition duration-200 shadow-md">
                Apply Next Tool Logic
            </button>
            <button id="togglePatternsButton"
                    class="bg-blue-500 hover:bg-blue-600 text-white font-bold py-2 px-4 rounded-lg transition duration-200 shadow-md">
                Hide Patterns
            </button>
        </div>


        <div id="detectedPatternsSection" class="detected-patterns-section">
            <h2 class="text-xl font-semibold text-gray-700">Detected Patterns (Click to use in Find fields)</h2>
            <div id="patternList">
                <p class="text-gray-500">Upload a file to detect patterns.</p>
            </div>

            <div class="formula-editing-section mt-6 pt-4 border-t border-gray-200">
                <h3 class="text-lg font-semibold text-gray-700 mb-2">Calculated Formulas (Editable)</h3>
                <div class="mb-3">
                    <label for="sFormulaInput" class="block text-sm font-medium text-gray-700">S Formula:</label>
                    <input type="text" id="sFormulaInput" class="formula-input" value="S = (3.82 * 800) / DIAMETER">
                    <p class="text-xs text-gray-500 mt-1">Format: S = (Num1 * Num2) / DIAMETER</p>
                </div>
                <div>
                    <label for="fFormulaInput" class="block text-sm font-medium text-gray-700">F Formula:</label>
                    <input type="text" id="fFormulaInput" class="formula-input" value="F = S * 4 * 0.003">
                    <p class="text-xs text-gray-500 mt-1">Format: F = S * Num1 * Num2</p>
                </div>
            </div>
        </div>

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
        const fileInput = document.getElementById('fileInput');
        const fileNameSpan = document.getElementById('fileName');
        const fileContentEditor = document.getElementById('fileContentEditor'); // Changed to div
        const replaceButton = document.getElementById('replaceButton');
        const applyNextToolButton = document.getElementById('applyNextToolButton');
        const togglePatternsButton = document.getElementById('togglePatternsButton'); // New button
        const downloadButton = document.getElementById('downloadButton');
        const clearButton = document.getElementById('clearButton');
        const messageBox = document.getElementById('messageBox');
        const patternListDiv = document.getElementById('patternList');
        const findReplaceInputsContainer = document.getElementById('findReplaceInputsContainer');
        const sFormulaInput = document.getElementById('sFormulaInput');
        const fFormulaInput = document.getElementById('fFormulaInput');
        const detectedPatternsSection = document.getElementById('detectedPatternsSection'); // Reference to the section

        let currentFileName = 'edited_file.txt';
        let currentFindInputIndex = 0;
        let hasAppliedNextToolLogic = false;
        let hasHDCrossMatchErrors = false; // New global flag for H/D mismatches

        const MAX_INPUT_PAIRS = 50;
        const findInputs = [];
        const replaceInputs = [];
        const inputPairContainers = [];

        let allDetectedTPatterns = [];

        let sFormulaConstants = { num1: 3.82, num2: 800 };
        let fFormulaConstants = { num1: 4, num2: 0.003 }; // Default F formula constants

        const toolDiaPatternRegex = /^DIAMETER\.?\s*[=\-]?\s*([+\-]?\d*\.?\d+)$/i;

        function parseSFormula(formulaString) {
            const regex = /S\s*=\s*\(\s*(\d+\.?\d*)\s*[\*x]\s*(\d+\.?\d*)\s*\)\s*\/\s*DIAMETER/i;
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

        function parseFFormula(formulaString) {
            const regex = /F\s*=\s*S\s*[\*x]\s*(\d+\.?\d*)\s*[\*x]\s*(\d+\.?\d*)/i;
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

        function createInputPairs() {
            findInputs.push(document.getElementById('find1'));
            replaceInputs.push(document.getElementById('replace1'));
            inputPairContainers.push(document.getElementById('inputPair1'));

            for (let i = 2; i <= MAX_INPUT_PAIRS; i++) {
                const inputPairDiv = document.createElement('div');
                inputPairDiv.className = 'input-pair hidden';
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

                findReplaceInputsContainer.insertBefore(inputPairDiv, replaceButton);
                inputPairContainers.push(inputPairDiv);
            }
        }

        function clearMessageBox() {
            messageBox.textContent = '';
            messageBox.classList.add('hidden');
            messageBox.className = 'message-box hidden';
        }

        function showMessage(message, type) {
            clearMessageBox();
            messageBox.textContent = message;
            messageBox.className = `message-box ${type}`;
            messageBox.classList.remove('hidden');

            if (type === 'success' || type === 'info') {
                setTimeout(() => {
                    clearMessageBox();
                }, 5000);
            }
        }

        function populateNextFindField(pattern, clickedItem) {
            clearMessageBox();

            if (currentFindInputIndex < inputPairContainers.length && inputPairContainers[currentFindInputIndex].classList.contains('hidden')) {
                inputPairContainers[currentFindInputIndex].classList.remove('hidden');
            }

            const targetFindInput = findInputs[currentFindInputIndex];
            const targetReplaceInput = replaceInputs[currentFindInputIndex];

            targetFindInput.value = pattern;
            
            if (pattern.toUpperCase().startsWith('T') && /\d+/.test(pattern)) {
                targetReplaceInput.value = 'T';
            } else {
                targetReplaceInput.value = pattern;
            }
            
            targetFindInput.focus();

            if (clickedItem) {
                clickedItem.classList.add('hidden');
            }

            showMessage(`'${pattern}' copied to Find ${currentFindInputIndex + 1}.`, 'info');

            currentFindInputIndex = (currentFindInputIndex + 1) % MAX_INPUT_PAIRS;
        }

        function cleanLineFromComments(line) {
            let cleanedLine = line.replace(/\([^)]*\)/g, '');
            cleanedLine = cleanedLine.split(';')[0];
            return cleanedLine.trim();
        }

        function findPatternsInSegment(segmentContent) {
            const regexT = /T(\d+)/gi;
            const regexH = /H(\d+)/gi;
            const regexD = /D(\d+)/gi;
            const regexS = /S(\d+)/gi;
            const regexF = /F(\d+\.?\d*)/gi; 
            const regexG84 = /G84/gi;
            const localRegexToolDia = /(DIAMETER\.?\s*[=\-]?\s*([+\-]?\d*\.?\d+))/gi; // Capture full string and numeric value
            const specialCommentRegex = /\(\s*T\d+\s*\|\s*([^|]+?)\s*\|\s*H\d+\s*\|\s*D\d+\s*\|\s*WEAR COMP\s*\|\s*DIAMETER\.?\s*-\s*\d*\.?\d+\s*\)/gi;
            // Removed generalDiameterCommentRegex and generalDiameterComments map as they are now handled specifically

            const tPatterns = new Map();
            const hPatterns = new Map();
            const dPatterns = new Map();
            const sPatterns = new Map();
            const fPatterns = new Map();
            const g84Patterns = new Map();
            const toolDiaPatterns = new Map(); // Stores full string like "DIAMETER - 0.1"
            const fullDiameterPatterns = new Map(); // Stores full string like "DIAMETER - 0.1"
            const specialCommentDescriptions = new Map();

            const lines = segmentContent.split('\n');

            lines.forEach(line => {
                let match;
                
                specialCommentRegex.lastIndex = 0;
                while ((match = specialCommentRegex.exec(line)) !== null) {
                    const description = match[1].trim();
                    if (description) {
                        specialCommentDescriptions.set(description, (specialCommentDescriptions.get(description) || 0) + 1);
                    }
                }

                const lineWithoutComments = line.replace(/\([^)]*\)/g, '').split(';')[0].trim();

                const tM6Match = lineWithoutComments.match(/(T\d+)\s+M6/i);
                if (tM6Match) {
                    const tPattern = tM6Match[1];
                    tPatterns.set(tPattern, (tPatterns.get(tPattern) || 0) + 1);
                }

                regexT.lastIndex = 0;
                while ((match = regexT.exec(lineWithoutComments)) !== null) {
                    const pattern = match[0];
                    tPatterns.set(pattern, (tPatterns.get(pattern) || 0) + 1);
                }

                regexH.lastIndex = 0;
                while ((match = regexH.exec(lineWithoutComments)) !== null) {
                    const pattern = match[0];
                    hPatterns.set(pattern, (hPatterns.get(pattern) || 0) + 1);
                }

                regexD.lastIndex = 0;
                while ((match = regexD.exec(lineWithoutComments)) !== null) {
                    const pattern = match[0];
                    dPatterns.set(pattern, (dPatterns.get(pattern) || 0) + 1);
                }

                regexS.lastIndex = 0;
                while ((match = regexS.exec(lineWithoutComments)) !== null) {
                    const pattern = match[0];
                    sPatterns.set(pattern, (sPatterns.get(pattern) || 0) + 1);
                }

                regexF.lastIndex = 0;
                while ((match = regexF.exec(lineWithoutComments)) !== null) {
                    const pattern = match[0];
                    fPatterns.set(pattern, (fPatterns.get(pattern) || 0) + 1);
                }

                regexG84.lastIndex = 0;
                if (regexG84.test(lineWithoutComments)) {
                    const nMatch = lineWithoutComments.match(/N(\d+)/i);
                    const nValue = nMatch ? nMatch[0].toUpperCase() : 'N/A';
                    g84Patterns.set(nValue, (g84Patterns.get(nValue) || 0) + 1);
                }

                localRegexToolDia.lastIndex = 0;
                while ((match = localRegexToolDia.exec(lineWithoutComments)) !== null) {
                    const fullPattern = match[1]; // Capture the full matched string
                    toolDiaPatterns.set(fullPattern, (toolDiaPatterns.get(fullPattern) || 0) + 1);
                    fullDiameterPatterns.set(fullPattern, (fullDiameterPatterns.get(fullPattern) || 0) + 1); // Store full pattern
                }
            });

            return { tPatterns, hPatterns, dPatterns, sPatterns, fPatterns, g84Patterns, toolDiaPatterns, fullDiameterPatterns, specialCommentDescriptions };
        }

        function scanAndDisplayPatterns() {
            // Get the current content from the editor, which now includes HTML spans for highlighting
            const fullContentWithHtml = fileContentEditor.innerHTML;
            // Convert it back to plain text for parsing patterns, as findPatternsInSegment expects plain text.
            const tempDiv = document.createElement('div');
            tempDiv.innerHTML = fullContentWithHtml;
            const fullContentPlain = tempDiv.textContent;


            patternListDiv.innerHTML = '';
            allDetectedTPatterns = [];

            let patternsFoundOverall = false;
            
            const { blocks, tM6LineIndices } = parseToolBlocksDetailed(fullContentPlain); // Parse plain text content and get tM6LineIndices

            let toolPathCounter = 0; // New counter for user-facing "Tool Path" numbers

            blocks.forEach((block, groupCounter) => {
                let displayToolPathLabel = '';
                let blockActiveToolNumeric = null; // This will be passed to renderGroupPatterns

                // Determine the label for the current block
                // Skip rendering 'File Preamble' in the patterns section if it's the very first block and has no actual tool
                if (block.actualTool === null && groupCounter === 0 && tM6LineIndices.length > 0) {
                    // This is the initial preamble block, do not assign a display label to skip rendering
                    displayToolPathLabel = ''; // Set to empty string to indicate it should not be rendered
                } else if (block.actualTool) {
                    // This is a tool operation block (starts with or contains a T#M6)
                    toolPathCounter++;
                    displayToolPathLabel = `Tool Path ${toolPathCounter}`;
                    const match = block.actualTool.match(/T(\d+)/i);
                    if (match) {
                        blockActiveToolNumeric = parseInt(match[1], 10);
                    }
                } else if (block.actualTool === null && groupCounter > 0) {
                    // This is a trailing block after the last T#M6, or a block without a T#M6
                    // that is not the initial setup.
                    displayToolPathLabel = 'Remaining Content';
                } else {
                    // This covers a single file with no T#M6 at all
                    displayToolPathLabel = 'File Content (No Tool Changes)';
                }

                // Only render the group if it has a valid display label
                if (displayToolPathLabel) {
                    // --- NEW DIAGNOSTIC LOG ---
                    console.log(`[Display] Rendering Block: ${displayToolPathLabel}, First Line: "${block.lines[0] ? block.lines[0].trim().substring(0, 50) + '...' : '[Empty Block]'}"`);
                    // --- END NEW DIAGNOSTIC LOG ---

                    const { tPatterns, hPatterns, dPatterns, sPatterns, fPatterns, g84Patterns, toolDiaPatterns, fullDiameterPatterns, specialCommentDescriptions } = findPatternsInSegment(block.lines.join('\n'));

                    let nextToolForThisBlock = block.nextToolValue;

                    // Collect all T patterns from the entire file for auto-population, not just within the current block
                    const blockTPatterns = Array.from(tPatterns.keys());
                    blockTPatterns.forEach(pattern => {
                        if (!allDetectedTPatterns.includes(pattern)) {
                            allDetectedTPatterns.push(pattern);
                        }
                    });


                    const g84DetailsForGroup = [];
                    let currentToolDiaForGroup = null;

                    block.lines.forEach(segmentLine => {
                        const cleanedSegmentLine = cleanLineFromComments(segmentLine);
                        const toolDiaMatch = cleanedSegmentLine.match(/DIAMETER\.?\s*[=\-]?\s*([+\-]?\d*\.?\d+)/i);
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
                                if (suggestedF > 30) suggestedF = 30; // Changed from 40 to 30
                            }
                            g84DetailsForGroup.push({ nValue, suggestedS, suggestedF });
                        }
                    });

                    // Pass block.actualTool directly to renderGroupPatterns, as it's the correct tool for the block.
                    // blockActiveToolNumeric is correctly derived from block.actualTool.
                    renderGroupPatterns(displayToolPathLabel, tPatterns, hPatterns, dPatterns, sPatterns, fPatterns, g84DetailsForGroup, toolDiaPatterns, fullDiameterPatterns, specialCommentDescriptions, block.actualTool, block.actualTool !== null, nextToolForThisBlock, blockActiveToolNumeric, block.leadingDiameterComment);
                    
                    if (tPatterns.size > 0 || hPatterns.size > 0 || dPatterns.size > 0 || sPatterns.size > 0 || fPatterns.size > 0 || g84Patterns.size > 0 || toolDiaPatterns.size > 0 || fullDiameterPatterns.size > 0 || specialCommentDescriptions.size > 0 || block.actualTool || block.leadingDiameterComment) {
                        patternsFoundOverall = true;
                    }
                }
            });

            if (!patternsFoundOverall && blocks.length === 0) {
                const noPatterns = document.createElement('p');
                noPatterns.className = 'text-gray-500';
                noPatterns.textContent = 'No T, H, D, S, F, G84, DIAMETER., or special comment patterns with values found in any group.';
                patternListDiv.appendChild(noPatterns);
            }

            fillFindReplaceWithTPatterns();
            updateDownloadButtonState(); // Update download button state after scan
        }

        function renderGroupPatterns(displayLabel, tPatterns, hPatterns, dPatterns, sPatterns, fPatterns, g84DetailsForGroup, toolDiaPatterns, fullDiameterPatterns, specialCommentDescriptions, toolValueForThisGroup, hasToolDelimiter, nextToolForThisGroup, currentBlockActiveToolNumeric, leadingDiameterCommentForThisGroup) {
            // If displayLabel is empty, we should not render this group at all.
            if (!displayLabel) {
                return;
            }

            const groupSection = document.createElement('div');
            groupSection.className = 'group-section';

            const groupHeader = document.createElement('h3');
            groupHeader.textContent = displayLabel; // Use the adjusted label here
            groupSection.appendChild(groupHeader);

            const patternsInGroupDiv = document.createElement('div');
            patternsInGroupDiv.className = 'pattern-list';

            let patternsFoundInGroupContent = false;

            // Use the passed currentBlockActiveToolNumeric for H/D matching
            const toolNumericValue = currentBlockActiveToolNumeric;

            // Display the leading diameter comment if found - NEW SECTION
            if (leadingDiameterCommentForThisGroup) {
                const patternRow = document.createElement('div');
                patternRow.className = 'pattern-row';

                const labelSpan = document.createElement('span');
                labelSpan.className = 'pattern-label';
                labelSpan.textContent = 'Tool Diameter Comment:'; // More specific label
                patternRow.appendChild(labelSpan);

                const valuesDiv = document.createElement('div');
                valuesDiv.className = 'pattern-values';
                const item = document.createElement('span');
                item.className = 'non-clickable-pattern-item'; // This is a comment, not directly actionable
                item.textContent = leadingDiameterCommentForThisGroup;
                item.title = `Leading Diameter Comment: ${leadingDiameterCommentForThisGroup}`;
                valuesDiv.appendChild(item);
                patternRow.appendChild(valuesDiv);
                patternsInGroupDiv.appendChild(patternRow);
                patternsFoundInGroupContent = true;
            }

            // Display the actual tool for the group if available (MOVED TO TOP)
            if (toolValueForThisGroup) { 
                const patternRow = document.createElement('div');
                patternRow.className = 'pattern-row';

                const labelSpan = document.createElement('span');
                labelSpan.className = 'pattern-label';
                labelSpan.textContent = 'T Tool:';
                patternRow.appendChild(labelSpan);

                const valuesDiv = document.createElement('div');
                valuesDiv.className = 'pattern-values';
                const item = document.createElement('span');
                item.className = 'pattern-item';
                item.textContent = toolValueForThisGroup;
                item.title = `Click to add '${toolValueForThisGroup}' to a Find field`;
                item.addEventListener('click', (event) => populateNextFindField(toolValueForThisGroup, event.target));
                valuesDiv.appendChild(item);
                patternRow.appendChild(valuesDiv);
                patternsInGroupDiv.appendChild(patternRow);
                patternsFoundInGroupContent = true;
            }


            if (nextToolForThisGroup) {
                const patternRow = document.createElement('div');
                patternRow.className = 'pattern-row';

                const labelSpan = document.createElement('span');
                labelSpan.className = 'pattern-label';
                labelSpan.textContent = 'Next Tool (Calculated):';
                patternRow.appendChild(labelSpan);

                const valuesDiv = document.createElement('div');
                valuesDiv.className = 'pattern-values';
                const item = document.createElement('span');
                item.className = 'non-clickable-pattern-item';
                item.textContent = `( TOOL CHANGE, TOOL ${nextToolForThisGroup} )`;
                item.title = `This is the next tool in sequence: ${nextToolForThisGroup}`;
                valuesDiv.appendChild(item);
                patternRow.appendChild(valuesDiv);
                patternsInGroupDiv.appendChild(patternRow);
                patternsFoundInGroupContent = true;
            }

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

            // Removed generalDiameterComments section as it's replaced by leadingDiameterCommentForThisGroup

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
                    const hNumeric = parseFloat(pattern.substring(1)); // Get numeric part of H
                    let statusText = '';
                    let itemClass = 'non-clickable-pattern-item';

                    if (toolNumericValue !== null) {
                        if (isNaN(hNumeric)) {
                            statusText = ' (NaN)';
                            itemClass = 'error-highlight-pattern-item'; // Red background
                        } else if (hNumeric === toolNumericValue) {
                            statusText = ' (Match)';
                            itemClass = 'match-highlight-pattern-item'; // Green background
                        } else {
                            statusText = ` (Mismatch, Expected T${toolNumericValue})`;
                            itemClass = 'error-highlight-pattern-item'; // Red background
                        }
                    }
                    item.className = itemClass;
                    item.textContent = `${pattern}${statusText}`;
                    item.title = `H value: ${pattern}`;
                    valuesDiv.appendChild(item);
                });
                patternRow.appendChild(valuesDiv);
                patternsInGroupDiv.appendChild(patternRow);
            }

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
                    const dNumeric = parseFloat(pattern.substring(1)); // Get numeric part of D
                    let statusText = '';
                    let itemClass = 'non-clickable-pattern-item';

                    if (toolNumericValue !== null) {
                        if (isNaN(dNumeric)) {
                            statusText = ' (NaN)';
                            itemClass = 'error-highlight-pattern-item'; // Red background
                        } else if (dNumeric === toolNumericValue) {
                            statusText = ' (Match)';
                            itemClass = 'match-highlight-pattern-item'; // Green background
                        } else {
                            statusText = ` (Mismatch, Expected T${toolNumericValue})`;
                            itemClass = 'error-highlight-pattern-item'; // Red background
                        }
                    }
                    item.className = itemClass;
                    item.textContent = `${pattern}${statusText}`;
                    item.title = `D value: ${pattern}`;
                    valuesDiv.appendChild(item);
                });
                patternRow.appendChild(valuesDiv);
                patternsInGroupDiv.appendChild(patternRow);
            }

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

            // Updated section for "DIAMETER Patterns" (non-clickable)
            if (fullDiameterPatterns.size > 0) {
                const patternRow = document.createElement('div');
                patternRow.className = 'pattern-row';

                const labelSpan = document.createElement('span');
                labelSpan.className = 'pattern-label';
                labelSpan.textContent = 'DIAMETER Patterns:'; // Changed label
                patternRow.appendChild(labelSpan);

                const valuesDiv = document.createElement('div');
                valuesDiv.className = 'pattern-values';
                fullDiameterPatterns.forEach((count, pattern) => { // Iterate over full patterns
                    patternsFoundInGroupContent = true;
                    const item = document.createElement('span');
                    item.className = 'non-clickable-pattern-item'; // Non-clickable
                    item.textContent = pattern; // Display the full pattern string
                    item.title = `Full DIAMETER pattern: ${pattern}`;
                    // No event listener for click
                    valuesDiv.appendChild(item);
                });
                patternRow.appendChild(valuesDiv);
                patternsInGroupDiv.appendChild(patternRow);
            }

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
                    item.className = 'pattern-item g84-pattern-item';
                    item.textContent = `${detail.nValue}: S${detail.suggestedS} F${detail.suggestedF}`;
                    item.title = `Click to highlight line ${detail.nValue} and scroll to it`;
                    item.addEventListener('click', () => highlightLineAndScroll(detail.nValue, detail.suggestedS, detail.suggestedF));
                    valuesDiv.appendChild(item);
                });
                patternRow.appendChild(valuesDiv);
                patternsInGroupDiv.appendChild(patternRow);
            }

            if (!patternsFoundInGroupContent && (!toolValueForThisGroup || toolValueForThisGroup === 'N220') && specialCommentDescriptions.size === 0 && !leadingDiameterCommentForThisGroup) { 
                const noPatterns = document.createElement('p');
                noPatterns.className = 'text-gray-500';
                noPatterns.textContent = 'No T, H, D, S, F, G84, DIAMETER., or special comment patterns with values found in any group.';
                patternListDiv.appendChild(noPatterns);
            }

            groupSection.appendChild(patternsInGroupDiv);
            patternListDiv.appendChild(groupSection);

            if (hasToolDelimiter) {
                const delimiterSeparator = document.createElement('p');
                delimiterSeparator.className = 'text-center text-gray-600 font-bold my-4';
                delimiterSeparator.textContent = `--- ${toolValueForThisGroup} M6 ---`;
                patternListDiv.appendChild(delimiterSeparator);
            }
        }

        function fillFindReplaceWithTPatterns() {
            for (let i = 0; i < MAX_INPUT_PAIRS; i++) {
                findInputs[i].value = '';
                replaceInputs[i].value = '';
                if (i > 0) {
                    inputPairContainers[i].classList.add('hidden');
                }
            }
            
            let populatedCount = 0;
            for (let i = 0; i < allDetectedTPatterns.length && populatedCount < MAX_INPUT_PAIRS; i++) {
                const tPattern = allDetectedTPatterns[i];
                
                if (inputPairContainers[populatedCount].classList.contains('hidden')) {
                    inputPairContainers[populatedCount].classList.remove('hidden');
                }

                findInputs[populatedCount].value = tPattern;
                replaceInputs[populatedCount].value = 'T';
                populatedCount++;
            }

            currentFindInputIndex = populatedCount;

            if (populatedCount > 0) {
                showMessage(`${populatedCount} T-patterns automatically populated into Find/Replace fields.`, 'info');
            } else {
                showMessage('No T-patterns found to auto-populate.', 'info');
            }
        }

        let activeHighlightTempDiv = null; // For G84 temporary highlight
        let originalEditorScrollTop = 0; // To preserve scroll position

        function highlightLineAndScroll(nValue, suggestedS = 'N/A', suggestedF = 'N/A', doScroll = true) {
            const currentContent = fileContentEditor.textContent;
            const lines = currentContent.split('\n');
            let lineIndex = -1;

            if (activeHighlightTempDiv) {
                // Remove previous G84 highlight if exists
                fileContentEditor.innerHTML = fileContentEditor.textContent; // Reset content to plain text
                activeHighlightTempDiv = null;
            }

            for (let i = 0; i < lines.length; i++) {
                const cleanedLine = cleanLineFromComments(lines[i]);
                const nValueRegex = new RegExp(`\\bN${nValue}\\b`, 'i'); 
                if (nValueRegex.test(cleanedLine)) {
                    lineIndex = i;
                    break;
                }
            }

            if (lineIndex !== -1) {
                const range = document.createRange();
                const sel = window.getSelection();
                
                // Temporarily replace content with HTML to apply highlight
                const tempDiv = document.createElement('div');
                tempDiv.style.whiteSpace = 'pre-wrap';
                tempDiv.style.wordBreak = 'break-all';
                tempDiv.style.fontFamily = 'monospace';
                tempDiv.style.fontSize = '0.9rem';

                const preContent = lines.slice(0, lineIndex).join('\n');
                const lineToHighlight = lines[lineIndex];
                const postContent = lines.slice(lineIndex + 1).join('\n');

                const highlightedSpan = document.createElement('span');
                highlightedSpan.className = 'highlighted-line';
                highlightedSpan.textContent = lineToHighlight;

                tempDiv.appendChild(document.createTextNode(preContent));
                if (preContent.length > 0) {
                    tempDiv.appendChild(document.createTextNode('\n'));
                }
                tempDiv.appendChild(highlightedSpan);
                if (postContent.length > 0) {
                    tempDiv.appendChild(document.createTextNode('\n'));
                }
                tempDiv.appendChild(document.createTextNode(postContent));

                originalEditorScrollTop = fileContentEditor.scrollTop; // Save current scroll
                fileContentEditor.innerHTML = ''; // Clear current content
                fileContentEditor.appendChild(tempDiv); // Append the new HTML content
                activeHighlightTempDiv = highlightedSpan; // Keep reference to the highlighted span

                if (doScroll) {
                    fileContentEditor.scrollTop = highlightedSpan.offsetTop - fileContentEditor.clientHeight / 2 + highlightedSpan.clientHeight / 2;
                }

                // Remove highlight after 3 seconds and restore plain text
                setTimeout(() => {
                    if (activeHighlightTempDiv) {
                        fileContentEditor.innerHTML = fileContentEditor.textContent; // Restore plain text
                        fileContentEditor.scrollTop = originalEditorScrollTop; // Restore scroll
                        activeHighlightTempDiv = null;
                    }
                }, 3000);

                showMessage(`Line ${nValue} highlighted. Suggested S: ${suggestedS}, F: ${suggestedF}.`, 'info');
            } else {
                if (suggestedS !== 'N/A' || suggestedF !== 'N/A') {
                    showMessage(`Line with N-value '${nValue}' not found for highlighting.`, 'error');
                }
            }
        }

        function updateDownloadButtonState() {
            if (hasHDCrossMatchErrors) {
                downloadButton.classList.add('button-disabled');
                downloadButton.disabled = true;
            } else {
                downloadButton.classList.remove('button-disabled');
                downloadButton.disabled = false;
            }
        }

        fileInput.addEventListener('change', (event) => {
            clearMessageBox();
            const file = event.target.files[0];
            if (file) {
                currentFileName = file.name.split('.').slice(0, -1).join('.') + '_edited.' + file.name.split('.').pop();
                fileNameSpan.textContent = `Selected: ${file.name}`;
                const reader = new FileReader();

                reader.onload = (e) => {
                    fileContentEditor.textContent = e.target.result; // Set plain text
                    showMessage('File loaded successfully!', 'success');
                    hasAppliedNextToolLogic = false;
                    applyNextToolButton.classList.remove('hidden'); // Show button on new file load
                    applyNextToolButton.classList.remove('button-disabled');
                    applyNextToolButton.disabled = false;
                    scanAndReplaceAllLogic(false); // Perform initial scan and highlight errors without replacements
                };

                reader.onerror = () => {
                    showMessage('Error reading file!', 'error');
                    fileContentEditor.textContent = '';
                    fileNameSpan.textContent = 'No file selected';
                };

                reader.readAsText(file);
            } else {
                fileContentEditor.textContent = '';
                fileNameSpan.textContent = 'No file selected';
                currentFileName = 'edited_file.txt';
                showMessage('No file selected.', 'info');
                hasAppliedNextToolLogic = false;
                applyNextToolButton.classList.remove('hidden'); // Show button if no file selected
                applyNextToolButton.classList.remove('button-disabled');
                applyNextToolButton.disabled = false;
                scanAndReplaceAllLogic(false); // Perform initial scan and highlight errors
            }
        });

        // Refined function to parse the file into tool blocks with detailed info
        function parseToolBlocksDetailed(content) {
            const lines = content.split('\n');
            const blocks = [];
            const tM6LineIndices = [];

            // First pass: Identify all T#M6 lines and their indices
            lines.forEach((line, index) => {
                const trimmedLine = line.trim();
                if (trimmedLine.match(/(T\d+)\s*M6/i)) {
                    tM6LineIndices.push(index);
                }
            });

            let lastBlockEndIndex = -1; // Tracks the last line index of the previous block

            // Handle the preamble block (everything before the first T#M6's logical start)
            if (tM6LineIndices.length > 0) {
                let firstToolLogicalStart = tM6LineIndices[0];
                // Look backward from the first T#M6 to find the start of its logical block
                // This includes blank lines and comments (especially tool change or diameter comments)
                for (let i = tM6LineIndices[0] - 1; i >= 0; i--) {
                    const line = lines[i].trim();
                    if (line === '' || (line.startsWith('(') && (line.toLowerCase().includes('tool change') || line.toLowerCase().includes('diameter') || line.toLowerCase().includes('operation') || line.toLowerCase().includes('cs#') || line.toLowerCase().includes('rod stop')))) {
                        firstToolLogicalStart = i;
                    } else {
                        // Found a non-comment/non-blank line that doesn't seem to be a tool-related comment
                        break;
                    }
                }

                if (firstToolLogicalStart > 0) { // If there's content before the first tool's logical start
                    const preambleLines = lines.slice(0, firstToolLogicalStart);
                    if (preambleLines.some(line => line.trim() !== '' && !line.trim().startsWith('('))) {
                        // Only add preamble block if it contains actual code/non-comment lines
                        blocks.push({
                            lines: preambleLines,
                            actualTool: null,
                            tM6LineIndexInBlock: -1,
                            toolChangeCommentIndexInBlock: -1,
                            leadingDiameterComment: null, // Preamble won't have a *leading* diameter comment for a T#M6
                            nextToolValue: null
                        });
                        console.log(`[Parse] Preamble Block (lines ${0}-${firstToolLogicalStart - 1}):`, preambleLines.map(l => l.trim().substring(0, 30) + '...'));
                    }
                }
                lastBlockEndIndex = firstToolLogicalStart - 1; // Update last processed index for subsequent blocks
            } else {
                // If no T#M6 lines at all, whole file is one block ("File Content (No Tool Changes)")
                blocks.push({
                    lines: lines,
                    actualTool: null,
                    tM6LineIndexInBlock: -1,
                    toolChangeCommentIndexInBlock: -1,
                    leadingDiameterComment: null,
                    nextToolValue: null
                });
                console.log(`[Parse] Single Block (no T#M6):`, lines.map(l => l.trim().substring(0, 30) + '...'));
                return { blocks, tM6LineIndices };
            }

            // Process blocks starting with each T#M6, including preceding comments
            for (let i = 0; i < tM6LineIndices.length; i++) {
                const tM6CurrentIndex = tM6LineIndices[i];
                const tM6LineContent = lines[tM6CurrentIndex];
                const tM6Match = tM6LineContent.match(/(T(\d+))\s*M6/i);
                const toolValue = tM6Match ? tM6Match[1].toUpperCase() : null;

                // Determine the logical start of this tool's block by looking backwards from tM6CurrentIndex
                let blockStart = tM6CurrentIndex;
                let foundLeadingDiameterComment = null; // New variable to store the comment

                for (let j = tM6CurrentIndex - 1; j > lastBlockEndIndex; j--) {
                    const line = lines[j].trim();
                    if (line.startsWith('(') && line.toLowerCase().includes('diameter')) {
                        foundLeadingDiameterComment = lines[j]; // Store the full line (most recent diameter comment)
                        blockStart = j; // This line is part of the block
                    } else if (line === '' || (line.startsWith('(') && (line.toLowerCase().includes('tool change') || line.toLowerCase().includes('operation') || line.toLowerCase().includes('cs#') || line.toLowerCase().includes('rod stop')))) {
                        blockStart = j; // These are also part of the block
                    } else {
                        // Found a non-comment/non-blank line that doesn't seem to be a tool-related comment
                        break;
                    }
                }
                
                let nextBlockStartIndex = (i + 1 < tM6LineIndices.length) ? tM6LineIndices[i + 1] : lines.length;

                const blockLines = lines.slice(blockStart, nextBlockStartIndex);
                
                blocks.push({
                    lines: blockLines,
                    actualTool: toolValue,
                    // tM6LineIndexInBlock is now relative to the start of this block
                    tM6LineIndexInBlock: tM6CurrentIndex - blockStart,
                    toolChangeCommentIndexInBlock: blockLines.findIndex(l => l.trim().match(/^\(\s*TOOL CHANGE,\s*TOOL\s*(T\d+|#\d+)\s*\)/i)),
                    leadingDiameterComment: foundLeadingDiameterComment, // Add this
                    nextToolValue: null
                });
                console.log(`[Parse] Tool Block ${toolValue} (lines ${blockStart}-${nextBlockStartIndex - 1}):`, blockLines.map(l => l.trim().substring(0, 30) + '...'));
                lastBlockEndIndex = nextBlockStartIndex - 1; // Update last processed index
            }

            // Handle any remaining lines after the last T#M6 block (if any)
            if (lastBlockEndIndex < lines.length - 1) {
                const remainingLines = lines.slice(lastBlockEndIndex + 1);
                if (remainingLines.length > 0) {
                    blocks.push({
                        lines: remainingLines,
                        actualTool: null,
                        tM6LineIndexInBlock: -1,
                        toolChangeCommentIndexInBlock: -1,
                        leadingDiameterComment: null,
                        nextToolValue: null
                    });
                    console.log(`[Parse] Remaining Content Block (lines ${lastBlockEndIndex + 1}-${lines.length - 1}):`, remainingLines.map(l => l.trim().substring(0, 30) + '...'));
                }
            }

            // Second pass to determine nextToolValue for all blocks
            const allActualToolsInOrder = blocks.map(block => block.actualTool).filter(tool => tool !== null);
            const firstToolInFile = allActualToolsInOrder.length > 0 ? allActualToolsInOrder[0] : null;

            for (let i = 0; i < blocks.length; i++) {
                const block = blocks[i];
                if (block.actualTool) {
                    let currentToolIndexInList = allActualToolsInOrder.indexOf(block.actualTool);
                    if (currentToolIndexInList !== -1 && (currentToolIndexInList + 1) < allActualToolsInOrder.length) {
                        block.nextToolValue = allActualToolsInOrder[currentToolIndexInList + 1];
                    } else if (i === blocks.length - 1 && firstToolInFile) {
                        block.nextToolValue = firstToolInFile;
                    } else {
                        block.nextToolValue = null;
                    }
                } else if (block.actualTool === null && i === 0 && allActualToolsInOrder.length > 0) {
                    block.nextToolValue = allActualToolsInOrder[0];
                } else {
                    block.nextToolValue = null;
                }
            }
            
            return { blocks, tM6LineIndices };
        }

        function scanAndReplaceAllLogic(performReplacement = true) {
            clearMessageBox();
            let fullContent = fileContentEditor.textContent; // Get plain text
            let replacementsMade = 0;
            let hDMismatches = []; // This array tracks original line indices for H/D mismatches

            const tempSConstants = parseSFormula(sFormulaInput.value);
            const tempFConstants = parseFFormula(fFormulaInput.value);

            if (!tempSConstants) {
                showMessage('Error: Invalid S Formula format. Using default: S = (3.82 * 800) / DIAMETER', 'error');
                sFormulaInput.value = "S = (3.82 * 800) / DIAMETER"; 
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

            const replacementsToApply = [];
            if (performReplacement) {
                let validationPassed = true;
                for (let i = 0; i < MAX_INPUT_PAIRS; i++) {
                    const findValue = findInputs[i].value.trim();
                    let replaceValue = replaceInputs[i].value.trim();

                    if (findValue === '' && replaceValue === '') continue;

                    if ((findValue === '' && replaceValue !== '') || (findValue !== '' && replaceValue === '')) {
                        showMessage(`Error: Both Find ${i + 1} and Replace ${i + 1} must be filled or both left empty.`, 'error');
                        validationPassed = false;
                        break;
                    }

                    let effectiveReplaceValue = replaceValue;
                    let newTNumericForPair = null;

                    if (findValue.toUpperCase().startsWith('T') && /\d+/.test(findValue)) {
                        const originalTNumeric = parseInt(findValue.match(/\d+/)[0], 10);
                        if (replaceValue === '' || replaceValue.toLowerCase() === 't') {
                            effectiveReplaceValue = findValue;
                            newTNumericForPair = originalTNumeric;
                        } else if (/^\d+$/.test(replaceValue)) {
                            effectiveReplaceValue = 'T' + replaceValue;
                            newTNumericForPair = parseInt(replaceValue, 10);
                        } else if (replaceValue.toUpperCase().startsWith('T') && /\d+/.test(replaceValue)) {
                            effectiveReplaceValue = replaceValue;
                            newTNumericForPair = parseInt(replaceValue.match(/\d+/)[0], 10);
                        } else {
                            showMessage(`Error: For T-pattern '${findValue}', Replace ${i + 1} must be empty, 'T', a number (e.g., '25'), or a full T-pattern (e.g., 'T25').`, 'error');
                            validationPassed = false;
                            break;
                        }
                    } else {
                        if (replaceValue === '') {
                            effectiveReplaceValue = findValue;
                        }
                    }
                    replacementsToApply.push({ find: findValue, effectiveReplace: effectiveReplaceValue, newTNumeric: newTNumericForPair });
                }
                if (!validationPassed) return;
            }

            const { blocks } = parseToolBlocksDetailed(fullContent);
            const finalProcessedLines = [];
            let globalLineIndex = 0; // To track original line index for error reporting

            let currentActiveToolNumeric = null;
            let currentToolPathDiaValue = null; 
            let currentToolPathSValue = null; 
            
            // Initialize currentActiveToolNumeric based on the first T#M6 found in the entire content
            const initialTMatch = fullContent.match(/(T(\d+))\s*M6/i);
            if (initialTMatch) {
                currentActiveToolNumeric = parseInt(initialTMatch[2], 10);
            } else {
                // Fallback: if no T#M6 found, but there's a T value in the first block, use that.
                if (blocks.length > 0 && blocks[0].actualTool) { 
                    const match = blocks[0].actualTool.match(/T(\d+)/i);
                    if (match) {
                        currentActiveToolNumeric = parseInt(match[1], 10);
                    }
                }
            }


            blocks.forEach(block => {
                // Reset tool path specific values for each new block (if it's a new tool path)
                if (block.actualTool) {
                    const match = block.actualTool.match(/T(\d+)/i);
                    if (match) {
                        currentActiveToolNumeric = parseInt(match[1], 10);
                    }
                    currentToolPathDiaValue = null; // Reset DIAMETER for new tool path
                    currentToolPathSValue = null; // Reset S for new tool path
                }

                block.lines.forEach((line) => {
                    let currentLineContent = line;
                    let nMatch = line.match(/N(\d+)/i);
                    let currentLineNValue = nMatch ? parseInt(nMatch[1], 10) : -1;

                    // Update currentToolPathDiaValue if a DIAMETER line is found within the current block
                    const toolDiaMatchOnCurrentLine = currentLineContent.match(/DIAMETER\.?\s*[=\-]?\s*([+\-]?\d*\.?\d+)/i);
                    if (toolDiaMatchOnCurrentLine) {
                        currentToolPathDiaValue = parseFloat(toolDiaMatchOnCurrentLine[1]);
                    }

                    // Apply user-defined find/replace operations
                    if (performReplacement) {
                        replacementsToApply.forEach(pair => {
                            const escapedFindValue = pair.find.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
                            const regex = new RegExp(escapedFindValue, 'gi');
                            currentLineContent = currentLineContent.replace(regex, (match) => {
                                replacementsMade++;
                                // If a T-value is explicitly replaced by user, update currentActiveToolNumeric
                                // This ensures the active tool for H/D validation reflects user's T-replacements
                                if (pair.find.toUpperCase().startsWith('T') && regex.test(match)) {
                                    currentActiveToolNumeric = pair.newTNumeric;
                                }
                                return pair.effectiveReplace;
                            });
                        });
                    }

                    // Process H and D values (outside comments) for correction/highlighting
                    if (currentActiveToolNumeric !== null) {
                        const targetNumericValue = currentActiveToolNumeric;
                        // Regex to match H or D values *outside* of parentheses
                        const regexHDOutsideComments = /(?![^(]*\))([HD])([+\-]?\d*\.?\d*)/gi;

                        currentLineContent = currentLineContent.replace(regexHDOutsideComments, (fullMatch, prefix, valueStr) => {
                            const numericValue = parseFloat(valueStr);
                            let finalValue = String(valueStr); // Default to original string value
                            let highlightClass = '';

                            if (isNaN(numericValue)) {
                                hDMismatches.push({ lineIndex: globalLineIndex, type: prefix, value: valueStr, isNan: true });
                                highlightClass = 'error-highlight';
                            } else if (numericValue !== targetNumericValue) {
                                hDMismatches.push({ lineIndex: globalLineIndex, type: prefix, value: valueStr, expected: targetNumericValue });
                                finalValue = String(targetNumericValue); // Always correct the value in the content
                                highlightClass = 'error-highlight'; // Mark as error because it needed correction
                                replacementsMade++; // Count this as a replacement
                            } else {
                                // Match
                                highlightClass = 'match-highlight';
                            }
                            
                            // Construct the HTML with the final value and appropriate highlight
                            return `<span class="${highlightClass}">${prefix}${finalValue}</span>`;
                        });
                    }

                    // Calculate and apply S value
                    let calculatedSNumericFromToolDia = null;
                    if (currentToolPathDiaValue !== null && !isNaN(currentToolPathDiaValue) && currentToolPathDiaValue !== 0) {
                        calculatedSNumericFromToolDia = Math.round((sFormulaConstants.num1 * sFormulaConstants.num2) / currentToolPathDiaValue);
                    }
                    const regexS = /S(\d+\.?\d*)/gi;
                    if (currentLineContent.match(regexS)) {
                        currentLineContent = currentLineContent.replace(regexS, (match, p1) => {
                            const oldSNumericValue = parseFloat(p1);
                            let newSNumericToApply = calculatedSNumericFromToolDia;
                            if (newSNumericToApply !== null) {
                                if (newSNumericToApply > 15000) {
                                    showMessage(`S value ${newSNumericToApply} on line N${currentLineNValue !== -1 ? currentLineNValue : 'N/A'} capped at 15000!`, 'error');
                                    newSNumericToApply = 15000;
                                }
                                if (performReplacement && oldSNumericValue !== newSNumericToApply) {
                                    replacementsMade++;
                                    currentToolPathSValue = newSNumericToApply; // Update for F calculation
                                    return 'S' + newSNumericToApply;
                                }
                            }
                            return match;
                        });
                    } else if (calculatedSNumericFromToolDia !== null) {
                        // If no S on line, but diameter is present, update currentToolPathSValue for F calculation
                        currentToolPathSValue = calculatedSNumericFromToolDia; 
                    }

                    // Calculate and apply F value
                    let calculatedFNumericFromS = null;
                    if (currentToolPathSValue !== null && !isNaN(currentToolPathSValue)) {
                        calculatedFNumericFromS = currentToolPathSValue * fFormulaConstants.num1 * fFormulaConstants.num2;
                    }
                    const regexF = /F(\d+\.?\d*)/gi;
                    if (currentLineContent.match(regexF)) {
                        currentLineContent = currentLineContent.replace(regexF, (match, p1) => {
                            const oldFNumericValue = parseFloat(p1);
                            let newFNumericToApply = calculatedFNumericFromS;
                            if (newFNumericToApply !== null) {
                                if (newFNumericToApply > 30) {
                                    showMessage(`F value ${newFNumericToApply.toFixed(3)} on line N${currentLineNValue !== -1 ? currentLineNValue : 'N/A'} capped at 30!`, 'error');
                                    newFNumericToApply = 30;
                                }
                                if (performReplacement && oldFNumericValue.toFixed(3) !== newFNumericToApply.toFixed(3)) {
                                    replacementsMade++;
                                    return 'F' + newFNumericToApply.toFixed(3);
                                }
                            }
                            return match;
                        });
                    }
                    finalProcessedLines.push(currentLineContent);
                    globalLineIndex++;
                });
            });

            // --- Diagnostic Logs ---
            console.log("--- scanAndReplaceAllLogic Diagnostics ---");
            console.log("Original content line count:", fullContent.split('\n').length);
            console.log("Final processed lines array length:", finalProcessedLines.length);
            console.log("First 15 lines of finalProcessedLines:", finalProcessedLines.slice(0, 15));
            console.log("Last 15 lines of finalProcessedLines:", finalProcessedLines.slice(-15));
            console.log("-----------------------------------------");
            // --- End Diagnostic Logs ---


            fileContentEditor.innerHTML = finalProcessedLines.join('\n'); // Set HTML content with highlights
            hasHDCrossMatchErrors = hDMismatches.length > 0;
            updateDownloadButtonState();

            if (performReplacement && replacementsMade > 0) {
                showMessage(`${replacementsMade} replacements made!`, 'success');
            } else if (performReplacement) {
                showMessage('No replacements made or nothing to replace.', 'info');
            }

            if (hasHDCrossMatchErrors) {
                let errorMessage = "Errors found in H/D values! Please correct them before downloading:\n";
                hDMismatches.forEach(item => {
                    if (item.isNan) {
                        errorMessage += `Line (index ${item.lineIndex}): ${item.type}${item.value} is not a valid number.\n`;
                    } else {
                        errorMessage += `Line (index ${item.lineIndex}): ${item.type}${item.value} (Expected T${item.expected}) mismatch.\n`;
                    }
                });
                showMessage(errorMessage, 'error');
            }
            
            scanAndDisplayPatterns(); 

            if (performReplacement) { // Clear find/replace fields only after explicit scan & replace
                for (let i = 0; i < MAX_INPUT_PAIRS; i++) {
                    findInputs[i].value = '';
                    replaceInputs[i].value = '';
                    if (i > 0) {
                        inputPairContainers[i].classList.add('hidden');
                    }
                }
                currentFindInputIndex = 0; 
            }
        }

        replaceButton.addEventListener('click', () => {
            scanAndReplaceAllLogic(true); // Perform replacements and highlight errors
        });

        applyNextToolButton.addEventListener('click', () => {
            clearMessageBox();
            if (hasAppliedNextToolLogic) {
                showMessage("The 'Apply Next Tool Logic' has already been applied. Please use 'Scan & Replace All' for further updates or clear the content to re-enable this function.", 'info');
                return;
            }

            let fullContent = fileContentEditor.textContent; // Get plain text
            if (fullContent.trim() === "") {
                showMessage("Please upload a CNC file or enter content before applying 'Next Tool' logic.", 'error');
                return;
            }

            // Identify all old tool change comments in the *entire* file to be removed
            const linesToFilterOut = new Set();
            fullContent.split('\n').forEach((line, index) => {
                const trimmedLine = line.trim();
                // This regex targets comments that look like tool change comments
                if (trimmedLine.startsWith('(') && trimmedLine.toLowerCase().includes('tool change, tool')) {
                    linesToFilterOut.add(index);
                }
            });

            let { blocks } = parseToolBlocksDetailed(fullContent); // Parse based on original content
            const finalLines = [];
            let changesMade = 0;
            let globalOriginalLineIndex = 0; // To track the index in the original fullContent

            blocks.forEach(block => {
                const tempBlockFinalLines = [];
                const originalBlockLines = block.lines;
                
                let nakedTInsertedForThisBlock = false;

                for (let i = 0; i < originalBlockLines.length; i++) {
                    const line = originalBlockLines[i];
                    // Before processing the line, check if it's one of the lines we need to filter out
                    // We use globalOriginalLineIndex because linesToFilterOut was built based on it.
                    if (linesToFilterOut.has(globalOriginalLineIndex)) {
                        changesMade++; // Count this as a change because it's being removed
                        globalOriginalLineIndex++; // Increment for the skipped line
                        continue; // Skip adding this line to tempBlockFinalLines
                    }

                    const trimmedLine = line.trim();

                    // Check if this is the T#M6 line for the current block
                    // In the new parseToolBlocksDetailed, tM6LineIndexInBlock is always 0 for actual tool blocks
                    const isCurrentBlockM6Line = (block.actualTool !== null && i === block.tM6LineIndexInBlock);

                    if (isCurrentBlockM6Line) {
                        // Insert the new comment *before* the T#M6 line
                        if (block.nextToolValue) {
                            const newToolChangeComment = `( TOOL CHANGE, TOOL ${block.nextToolValue} )`;
                            tempBlockFinalLines.push(newToolChangeComment);
                            changesMade++;
                        }
                        
                        tempBlockFinalLines.push(line); // Add the T#M6 line
                        
                        // Now, insert the naked T *after* this T#M6 line
                        if (block.nextToolValue && !nakedTInsertedForThisBlock) {
                            const nakedTLine = ` ${block.nextToolValue}`;
                            
                            // Check if the naked T line already exists immediately after in the original content
                            // Use globalOriginalLineIndex + 1 to check the next line in the original content
                            const originalContentLines = fullContent.split('\n');
                            const nextOriginalLine = originalContentLines[globalOriginalLineIndex + 1];
                            
                            if (!nextOriginalLine || nextOriginalLine.trim().toUpperCase() !== nakedTLine.trim().toUpperCase()) {
                                tempBlockFinalLines.push(nakedTLine);
                                changesMade++;
                            }
                            nakedTInsertedForThisBlock = true;
                        }
                    } else {
                        tempBlockFinalLines.push(line); // Add other lines
                    }
                    globalOriginalLineIndex++; // Increment for the line just processed
                }
                finalLines.push(...tempBlockFinalLines);
            });

            // Re-index N values in finalLines (this logic seems fine as is)
            const reIndexedLines = [];
            let currentN = 10; // Default starting N value
            const nIncrement = 5; 

            // Find the starting N value from the first N line in the original file, if any
            let firstNFoundInFinalLines = false;
            for (const line of finalLines) {
                const nMatch = line.match(/^N(\d+)/i);
                if (nMatch) {
                    currentN = parseInt(nMatch[1], 10);
                    firstNFoundInFinalLines = true;
                    break;
                }
            }

            finalLines.forEach(line => {
                let modifiedLine = line;
                const trimmedLine = line.trim();

                // Only exclude the (TOOL CHANGE, TOOL T#) comment from N-indexing
                if (trimmedLine.startsWith('( TOOL CHANGE, TOOL T')) {
                    reIndexedLines.push(modifiedLine); // Add as is, no N
                } else {
                    const nMatch = line.match(/^N(\d+)/i);
                    if (nMatch) {
                        // If it already has an N, update it
                        modifiedLine = `N${currentN} ` + line.substring(nMatch[0].length).trim();
                        currentN += nIncrement;
                    } else if (trimmedLine.length > 0) { 
                        // If it doesn't have an N but has content, add an N
                        modifiedLine = `N${currentN} ${trimmedLine}`;
                        currentN += nIncrement;
                    }
                    reIndexedLines.push(modifiedLine);
                }
            });

            fileContentEditor.textContent = reIndexedLines.join('\n'); // Set plain text
            scanAndReplaceAllLogic(false); // Re-scan to update highlights and button state

            if (changesMade > 0) {
                showMessage(`${changesMade} 'Next Tool' lines inserted/updated and N values re-indexed!`, 'success');
                hasAppliedNextToolLogic = true;
                applyNextToolButton.classList.add('hidden'); // Hide the button
            } else {
                showMessage('No "Next Tool" changes were needed or info.', 'info');
            }
        });

        downloadButton.addEventListener('click', () => {
            clearMessageBox();
            if (hasHDCrossMatchErrors) {
                showMessage('Errors found in H/D values! Please correct them before downloading.', 'error');
                return;
            }

            const content = fileContentEditor.textContent; // Get plain text for download
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

        clearButton.addEventListener('click', () => {
            clearMessageBox();
            fileInput.value = '';
            fileNameSpan.textContent = 'No file selected';
            fileContentEditor.textContent = ''; // Clear contenteditable div
            
            for (let i = 0; i < MAX_INPUT_PAIRS; i++) {
                findInputs[i].value = '';
                replaceInputs[i].value = '';
                if (i > 0) {
                    inputPairContainers[i].classList.add('hidden');
                }
            }
            currentFileName = 'edited_file.txt';
            showMessage('All fields cleared.', 'info');
            hasAppliedNextToolLogic = false;
            applyNextToolButton.classList.remove('hidden'); // Show button on clear
            applyNextToolButton.classList.remove('button-disabled');
            applyNextToolButton.disabled = false;
            hasHDCrossMatchErrors = false;
            updateDownloadButtonState();
            scanAndDisplayPatterns(); 
            currentFindInputIndex = 0;
        });

        // New toggle function
        togglePatternsButton.addEventListener('click', () => {
            detectedPatternsSection.classList.toggle('hidden');
            if (detectedPatternsSection.classList.contains('hidden')) {
                togglePatternsButton.textContent = 'Show Patterns';
            } else {
                togglePatternsButton.textContent = 'Hide Patterns';
            }
        });

        // Use 'input' event for contenteditable div
        fileContentEditor.addEventListener('input', () => {
            // Debounce to avoid excessive re-scans during typing
            clearTimeout(fileContentEditor._inputTimer);
            fileContentEditor._inputTimer = setTimeout(() => {
                scanAndReplaceAllLogic(false); // Re-scan and highlight errors, no replacements
            }, 300); // Adjust debounce time as needed
        });

        // Add event listeners for formula inputs to trigger immediate updates
        sFormulaInput.addEventListener('input', () => {
            clearTimeout(sFormulaInput._inputTimer);
            sFormulaInput._inputTimer = setTimeout(() => {
                scanAndReplaceAllLogic(true); // Apply formula changes immediately
            }, 200); // Debounce
        });

        fFormulaInput.addEventListener('input', () => {
            clearTimeout(fFormulaInput._inputTimer);
            fFormulaInput._inputTimer = setTimeout(() => {
                scanAndReplaceAllLogic(true); // Apply formula changes immediately
            }, 200); // Debounce
        });


        window.addEventListener('load', () => {
            createInputPairs();
            sFormulaInput.value = `S = (${sFormulaConstants.num1} * ${sFormulaConstants.num2}) / DIAMETER`;
            fFormulaInput.value = `F = S * ${fFormulaConstants.num1} * ${fFormulaConstants.num2}`;
            scanAndReplaceAllLogic(false); // Initial scan on load
        });
    </script>
</body>
</html>
