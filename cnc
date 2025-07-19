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
=
O200( 43224.TAP )
( FORMAT: FANUC 11M [EMS] CJ08.16.8.PST )
( 1/8/2025 AT 8:28 AM )
N1G0G28G61G91G99Z0.
N2G49
( TOOL CHANGE, TOOL #1 )
( DIAMETER = 3.15 SHELL ENDMILL )
( 3.15 SHELL MILL )
( OPERATION 1: ROUGHING )
( CS#2 - G55 )
( G55 = X0. Y0. Z0. )
N3T1M6
N4S6000M3
N5G0G17G55G61G90X-.8007Y2.89M8
N6G43Z1.H1
N7Z.15
N8Z.01
N9G1Y-8.26F40.
N10G0X-5.9503
N11G1Y2.89
N12G0X-3.3003
N13G1Y-8.26
N14G0Z.15
N15X-.8007Y2.89
N16Z0.
N17G1Y-8.26
N18G0X-5.9503
N19G1Y2.89
N20G0X-3.3003
N21G1Y-8.26
N22G0Z.15
N23M9
N24G0G28G91Z0.M5
N25G49
N26M1
( TOOL CHANGE, TOOL #2 )
( DIAMETER = .5 ROUGH ENDMILL )
( OPERATION 2: ROUGHING )
( CS#2 - G55 )
( G55 = X0. Y0. Z0. )
N27T2M6
N28S10000M3
N29G0G17G55G61G90X-7.2849Y-4.91M8
N30G43Z1.H2
N31Z.05
N32G1Z-.1497F60.
N33X-5.875
N34Y-5.185
N35X-.876
N36Y-4.91
N37X-5.875
N38X-6.125
N39Y-5.435
N40X-.626
N41Y-4.66
N42X-6.125
N43Y-4.91
N44X-6.375
N45Y-5.685
N46X-.376
N47Y-4.41
N48X-6.375
N49Y-4.91
N50X-6.625
N51Y-5.935
N52X-.126
N53Y-4.16
N54X-6.625
N55Y-4.91
N56X-6.875
N57Y-6.185
N58X.124
N59Y-3.8936
N60G2X-.005Y-3.91I-.129J.4986
N61G1X-6.745
N62G2X-6.875Y-3.8933J.515
N63G1X-6.8245Y-3.6998
N64G41D52X-6.8119Y-3.6514
N65G2X-7.01Y-3.395I.0669J.2564
N66G1Y-3.02
N67G2X-6.8119Y-2.7636I.265
N68X-6.7626Y-2.7556I.0669J-.2564
N69G40G1X-6.7659Y-2.7057
N70X-6.875Y-2.5217
N71G2X-6.745Y-2.505I.13J-.4983
N72G1X-6.625
N73Y-2.255
N74X-6.375
N75Y-2.005
N76X-6.125
N77Y-1.755
N78X-.626
N79Y-1.26
N80X-6.125
N81Y-1.755
N82Y-2.005
N83X-.376
N84Y-1.01
N85X-6.375
N86Y-2.005
N87Y-2.255
N88X-.126
N89Y-.76
N90X-6.625
N91Y-2.255
N92Y-2.505
N93X-.005
N94G2X.124Y-2.5214J-.515
N95G1Y-.4936
N96G2X-.005Y-.51I-.129J.4986
N97G1X-6.745
N98G2X-6.875Y-.4933J.515
N99G1X-6.8245Y-.2998
N100G41X-6.8119Y-.2514
N101G2X-7.01Y.005I.0669J.2564
N102G1Y.38
N103G2X-6.745Y.645I.265
N104G1X-.005
N105G2X.26Y.38J-.265
N106G1Y.005
N107G2X-.005Y-.26I-.265
N108G1X-6.745
N109G2X-6.8119Y-.2514J.265
N110X-6.8588Y-.2343I.0669J.2564
N111G40G1X-6.8803Y-.2795
N112X-6.875Y-.4933
N113Y-2.5217
N114X-6.8245Y-2.7152
N115G41X-6.8119Y-2.7636
N116G2X-6.745Y-2.755I.0669J-.2564
N117G1X-.005
N118G2X.26Y-3.02J-.265
N119G1Y-3.395
N120G2X-.005Y-3.66I-.265
N121G1X-6.745
N122G2X-6.8119Y-3.6514J.265
N123X-6.8588Y-3.6343I.0669J.2564
N124G40G1X-6.8803Y-3.6795
N125X-6.875Y-3.8933
N126Y-4.91
N127G0Z.05
N128X-7.2849
N129Z-.0997
N130G1Z-.2994
N131X-5.875
N132Y-5.185
N133X-.876
N134Y-4.91
N135X-5.875
N136X-6.125
N137Y-5.435
N138X-.626
N139Y-4.66
N140X-6.125
N141Y-4.91
N142X-6.375
N143Y-5.685
N144X-.376
N145Y-4.41
N146X-6.375
N147Y-4.91
N148X-6.625
N149Y-5.935
N150X-.126
N151Y-4.16
N152X-6.625
N153Y-4.91
N154X-6.875
N155Y-6.185
N156X.124
N157Y-3.8936
N158G2X-.005Y-3.91I-.129J.4986
N159G1X-6.745
N160G2X-6.875Y-3.8933J.515
N161G1X-6.8245Y-3.6998
N162G41X-6.8119Y-3.6514
N163G2X-7.01Y-3.395I.0669J.2564
N164G1Y-3.02
N165G2X-6.8119Y-2.7636I.265
N166X-6.7626Y-2.7556I.0669J-.2564
N167G40G1X-6.7659Y-2.7057
N168X-6.875Y-2.5217
N169G2X-6.745Y-2.505I.13J-.4983
N170G1X-6.625
N171Y-2.255
N172X-6.375
N173Y-2.005
N174X-6.125
N175Y-1.755
N176X-.626
N177Y-1.26
N178X-6.125
N179Y-1.755
N180Y-2.005
N181X-.376
N182Y-1.01
N183X-6.375
N184Y-2.005
N185Y-2.255
N186X-.126
N187Y-.76
N188X-6.625
N189Y-2.255
N190Y-2.505
N191X-.005
N192G2X.124Y-2.5214J-.515
N193G1Y-.4936
N194G2X-.005Y-.51I-.129J.4986
N195G1X-6.745
N196G2X-6.875Y-.4933J.515
N197G1X-6.8245Y-.2998
N198G41X-6.8119Y-.2514
N199G2X-7.01Y.005I.0669J.2564
N200G1Y.38
N201G2X-6.745Y.645I.265
N202G1X-.005
N203G2X.26Y.38J-.265
N204G1Y.005
N205G2X-.005Y-.26I-.265
N206G1X-6.745
N207G2X-6.8119Y-.2514J.265
N208X-6.8588Y-.2343I.0669J.2564
N209G40G1X-6.8803Y-.2795
N210X-6.875Y-.4933
N211Y-2.5217
N212X-6.8245Y-2.7152
N213G41X-6.8119Y-2.7636
N214G2X-6.745Y-2.755I.0669J-.2564
N215G1X-.005
N216G2X.26Y-3.02J-.265
N217G1Y-3.395
N218G2X-.005Y-3.66I-.265
N219G1X-6.745
N220G2X-6.8119Y-3.6514J.265
N221X-6.8588Y-3.6343I.0669J.2564
N222G40G1X-6.8803Y-3.6795
N223X-6.875Y-3.8933
N224Y-4.91
N225G0Z.05
N226X-7.2849
N227Z-.2494
N228G1Z-.4491
N229X-5.875
N230Y-5.185
N231X-.876
N232Y-4.91
N233X-5.875
N234X-6.125
N235Y-5.435
N236X-.626
N237Y-4.66
N238X-6.125
N239Y-4.91
N240X-6.375
N241Y-5.685
N242X-.376
N243Y-4.41
N244X-6.375
N245Y-4.91
N246X-6.625
N247Y-5.935
N248X-.126
N249Y-4.16
N250X-6.625
N251Y-4.91
N252X-6.875
N253Y-6.185
N254X.124
N255Y-3.8936
N256G2X-.005Y-3.91I-.129J.4986
N257G1X-6.745
N258G2X-6.875Y-3.8933J.515
N259G1X-6.8245Y-3.6998
N260G41X-6.8119Y-3.6514
N261G2X-7.01Y-3.395I.0669J.2564
N262G1Y-3.02
N263G2X-6.8119Y-2.7636I.265
N264X-6.7626Y-2.7556I.0669J-.2564
N265G40G1X-6.7659Y-2.7057
N266X-6.875Y-2.5217
N267G2X-6.745Y-2.505I.13J-.4983
N268G1X-6.625
N269Y-2.255
N270X-6.375
N271Y-2.005
N272X-6.125
N273Y-1.755
N274X-.626
N275Y-1.26
N276X-6.125
N277Y-1.755
N278Y-2.005
N279X-.376
N280Y-1.01
N281X-6.375
N282Y-2.005
N283Y-2.255
N284X-.126
N285Y-.76
N286X-6.625
N287Y-2.255
N288Y-2.505
N289X-.005
N290G2X.124Y-2.5214J-.515
N291G1Y-.4936
N292G2X-.005Y-.51I-.129J.4986
N293G1X-6.745
N294G2X-6.875Y-.4933J.515
N295G1X-6.8245Y-.2998
N296G41X-6.8119Y-.2514
N297G2X-7.01Y.005I.0669J.2564
N298G1Y.38
N299G2X-6.745Y.645I.265
N300G1X-.005
N301G2X.26Y.38J-.265
N302G1Y.005
N303G2X-.005Y-.26I-.265
N304G1X-6.745
N305G2X-6.8119Y-.2514J.265
N306X-6.8588Y-.2343I.0669J.2564
N307G40G1X-6.8803Y-.2795
N308X-6.875Y-.4933
N309Y-2.5217
N310X-6.8245Y-2.7152
N311G41X-6.8119Y-2.7636
N312G2X-6.745Y-2.755I.0669J-.2564
N313G1X-.005
N314G2X.26Y-3.02J-.265
N315G1Y-3.395
N316G2X-.005Y-3.66I-.265
N317G1X-6.745
N318G2X-6.8119Y-3.6514J.265
N319X-6.8588Y-3.6343I.0669J.2564
N320G40G1X-6.8803Y-3.6795
N321X-6.875Y-3.8933
N322Y-4.91
N323G0Z.05
N324X-7.2849
N325Z-.3991
N326G1Z-.5987
N327X-5.875
N328Y-5.185
N329X-.876
N330Y-4.91
N331X-5.875
N332X-6.125
N333Y-5.435
N334X-.626
N335Y-4.66
N336X-6.125
N337Y-4.91
N338X-6.375
N339Y-5.685
N340X-.376
N341Y-4.41
N342X-6.375
N343Y-4.91
N344X-6.625
N345Y-5.935
N346X-.126
N347Y-4.16
N348X-6.625
N349Y-4.91
N350X-6.875
N351Y-6.185
N352X.124
N353Y-3.8936
N354G2X-.005Y-3.91I-.129J.4986
N355G1X-6.745
N356G2X-6.875Y-3.8933J.515
N357G1X-6.8245Y-3.6998
N358G41X-6.8119Y-3.6514
N359G2X-7.01Y-3.395I.0669J.2564
N360G1Y-3.02
N361G2X-6.8119Y-2.7636I.265
N362X-6.7626Y-2.7556I.0669J-.2564
N363G40G1X-6.7659Y-2.7057
N364X-6.875Y-2.5217
N365G2X-6.745Y-2.505I.13J-.4983
N366G1X-6.625
N367Y-2.255
N368X-6.375
N369Y-2.005
N370X-6.125
N371Y-1.755
N372X-.626
N373Y-1.26
N374X-6.125
N375Y-1.755
N376Y-2.005
N377X-.376
N378Y-1.01
N379X-6.375
N380Y-2.005
N381Y-2.255
N382X-.126
N383Y-.76
N384X-6.625
N385Y-2.255
N386Y-2.505
N387X-.005
N388G2X.124Y-2.5214J-.515
N389G1Y-.4936
N390G2X-.005Y-.51I-.129J.4986
N391G1X-6.745
N392G2X-6.875Y-.4933J.515
N393G1X-6.8245Y-.2998
N394G41X-6.8119Y-.2514
N395G2X-7.01Y.005I.0669J.2564
N396G1Y.38
N397G2X-6.745Y.645I.265
N398G1X-.005
N399G2X.26Y.38J-.265
N400G1Y.005
N401G2X-.005Y-.26I-.265
N402G1X-6.745
N403G2X-6.8119Y-.2514J.265
N404X-6.8588Y-.2343I.0669J.2564
N405G40G1X-6.8803Y-.2795
N406X-6.875Y-.4933
N407Y-2.5217
N408X-6.8245Y-2.7152
N409G41X-6.8119Y-2.7636
N410G2X-6.745Y-2.755I.0669J-.2564
N411G1X-.005
N412G2X.26Y-3.02J-.265
N413G1Y-3.395
N414G2X-.005Y-3.66I-.265
N415G1X-6.745
N416G2X-6.8119Y-3.6514J.265
N417X-6.8588Y-3.6343I.0669J.2564
N418G40G1X-6.8803Y-3.6795
N419X-6.875Y-3.8933
N420Y-4.91
N421G0Z.05
( OPERATION 3: ROUGHING )
( CS#2 - G55 )
N422G0G90X-7.2849Y-5.0412
N423Z-.55
N424G1Z-.63
N425X-5.75
N426Y-5.06
N427X-1.001
N428Y-5.0412
N429X-5.75
N430X-5.975
N431Y-5.285
N432X-.776
N433Y-4.8162
N434X-5.975
N435Y-5.0412
N436X-6.2
N437Y-5.51
N438X-.551
N439Y-4.5912
N440X-6.2
N441Y-5.0412
N442X-6.425
N443Y-5.735
N444X-.326
N445Y-4.3662
N446X-6.425
N447Y-5.0412
N448X-6.65
N449Y-5.96
N450X-.101
N451Y-4.1412
N452X-6.65
N453Y-5.0412
N454X-6.875
N455Y-6.185
N456X.124
N457Y-3.899
N458G2X-.005Y-3.9162I-.129J.4728
N459G1X-6.745
N460G2X-6.875Y-3.8987J.49
N461G1X-6.8286Y-3.73
N462G41D52X-6.8153Y-3.6818
N463G2X-7.01Y-3.4262I.0703J.2556
N464G1Y-3.02
N465G2X-6.8153Y-2.7645I.265
N466X-6.7661Y-2.7558I.0703J-.2555
N467G40G1X-6.7701Y-2.706
N468X-6.875Y-2.5476
N469G2X-6.745Y-2.53I.13J-.4724
N470G1X-6.65
N471Y-2.305
N472X-6.425
N473Y-2.08
N474X-6.2
N475Y-1.855
N476X-5.975
N477Y-1.63
N478X-.776
N479Y-1.4162
N480X-5.975
N481Y-1.63
N482Y-1.855
N483X-.551
N484Y-1.1912
N485X-6.2
N486Y-1.855
N487Y-2.08
N488X-.326
N489Y-.9662
N490X-6.425
N491Y-2.08
N492Y-2.305
N493X-.101
N494Y-.7412
N495X-6.65
N496Y-2.305
N497Y-2.53
N498X-.005
N499G2X.124Y-2.5473J-.49
N500G1Y-.499
N501G2X-.005Y-.5162I-.129J.4728
N502G1X-6.745
N503G2X-6.875Y-.4987J.49
N504G1X-6.8286Y-.33
N505G41X-6.8153Y-.2818
N506G2X-7.01Y-.0262I.0703J.2556
N507G1Y.38
N508G2X-6.745Y.645I.265
N509G1X-.005
N510G2X.26Y.38J-.265
N511G1Y-.0262
N512G2X-.005Y-.2912I-.265
N513G1X-6.745
N514G2X-6.8153Y-.2818J.265
N515X-6.862Y-.264I.0703J.2556
N516G40G1X-6.8841Y-.3089
N517X-6.875Y-.4987
N518Y-2.5476
N519X-6.8286Y-2.7163
N520G41X-6.8153Y-2.7645
N521G2X-6.745Y-2.755I.0703J-.2555
N522G1X-.005
N523G2X.26Y-3.02J-.265
N524G1Y-3.4262
N525G2X-.005Y-3.6912I-.265
N526G1X-6.745
N527G2X-6.8153Y-3.6818J.265
N528X-6.862Y-3.664I.0703J.2556
N529G40G1X-6.8841Y-3.7089
N530X-6.875Y-3.8987
N531Y-5.0412
N532G0Z.05
( OPERATION 4: ROUGHING )
( CS#2 - G55 )
N533G0G90X-.0536Y-6.5949
N534Z-.59
N535G1Z-.7843
N536Y-6.185
N537X.124
N538Y-6.0539
N539X.0944Y-6.0835
N540G2X-.0536Y-6.185I-.3465J.3465
N541G1X-.1245Y-6.025
N542G41D52X-.1447Y-5.9793
N543G2X-.2521Y-6.002I-.1074J.2423
N544G1X-6.4979
N545G2X-6.6053Y-5.9793J.265
N546X-6.6488Y-5.9549I.1074J.2423
N547G40G1X-6.6773Y-5.996
N548X-6.6964Y-6.185
N549G2X-6.8444Y-6.0835I.1985J.448
N550G1X-6.875Y-6.0529
N551Y-6.185
N552X-6.6964
N553X-6.6255Y-6.025
N554G41X-6.6053Y-5.9793
N555G2X-6.6853Y-5.9244I.1074J.2423
N556G1X-6.9324Y-5.6773
N557G2X-7.01Y-5.4899I.1874J.1874
N558G1Y-3.02
N559G2X-6.745Y-2.755I.265
N560G1X-.0789
N561X-.0289
N562G40Y-2.705
N563X-.1315Y-2.628
N564G41X-.1507Y-2.5818
N565G2X-.2521Y-2.602I-.1014J.2448
N566G1X-6.4979
N567G2X-6.6853Y-2.5244J.265
N568G1X-6.9324Y-2.2773
N569G2X-7.01Y-2.0899I.1874J.1874
N570G1Y.38
N571G2X-6.745Y.645I.265
N572G1X-.005
N573G2X.26Y.38J-.265
N574G1Y-2.0899
N575G2X.1824Y-2.2773I-.265
N576G1X-.0647Y-2.5244
N577G2X-.1507Y-2.5818I-.1874J.1874
N578X-.1984Y-2.5965I-.1014J.2448
N579G40G1X-.1882Y-2.6455
N580X-.0789Y-2.705
N581G41Y-2.755
N582X-.005
N583G2X.26Y-3.02J-.265
N584G1Y-5.4899
N585G2X.1824Y-5.6773I-.265
N586G1X-.0647Y-5.9244
N587G2X-.1447Y-5.9793I-.1874J.1874
N588X-.1921Y-5.9951I-.1074J.2423
N589G40G1X-.1808Y-6.0438
N590G0Z.05
N591X-.0536Y-6.5949
N592Z-.7343
N593G1Z-.9287
N594Y-6.185
N595X.124
N596Y-6.0539
N597X.0944Y-6.0835
N598G2X-.0536Y-6.185I-.3465J.3465
N599G1X-.1245Y-6.025
N600G41X-.1447Y-5.9793
N601G2X-.2521Y-6.002I-.1074J.2423
N602G1X-6.4979
N603G2X-6.6053Y-5.9793J.265
N604X-6.6488Y-5.9549I.1074J.2423
N605G40G1X-6.6773Y-5.996
N606X-6.6964Y-6.185
N607G2X-6.8444Y-6.0835I.1985J.448
N608G1X-6.875Y-6.0529
N609Y-6.185
N610X-6.6964
N611X-6.6255Y-6.025
N612G41X-6.6053Y-5.9793
N613G2X-6.6853Y-5.9244I.1074J.2423
N614G1X-6.9324Y-5.6773
N615G2X-7.01Y-5.4899I.1874J.1874
N616G1Y-3.02
N617G2X-6.745Y-2.755I.265
N618G1X-.0789
N619X-.0289
N620G40Y-2.705
N621X-.1315Y-2.628
N622G41X-.1507Y-2.5818
N623G2X-.2521Y-2.602I-.1014J.2448
N624G1X-6.4979
N625G2X-6.6853Y-2.5244J.265
N626G1X-6.9324Y-2.2773
N627G2X-7.01Y-2.0899I.1874J.1874
N628G1Y.38
N629G2X-6.745Y.645I.265
N630G1X-.005
N631G2X.26Y.38J-.265
N632G1Y-2.0899
N633G2X.1824Y-2.2773I-.265
N634G1X-.0647Y-2.5244
N635G2X-.1507Y-2.5818I-.1874J.1874
N636X-.1984Y-2.5965I-.1014J.2448
N637G40G1X-.1882Y-2.6455
N638X-.0789Y-2.705
N639G41Y-2.755
N640X-.005
N641G2X.26Y-3.02J-.265
N642G1Y-5.4899
N643G2X.1824Y-5.6773I-.265
N644G1X-.0647Y-5.9244
N645G2X-.1447Y-5.9793I-.1874J.1874
N646X-.1921Y-5.9951I-.1074J.2423
N647G40G1X-.1808Y-6.0438
N648G0Z.05
N649X-.0536Y-6.5949
N650Z-.8787
N651G1Z-1.073
N652Y-6.185
N653X.124
N654Y-6.0539
N655X.0944Y-6.0835
N656G2X-.0536Y-6.185I-.3465J.3465
N657G1X-.1245Y-6.025
N658G41X-.1447Y-5.9793
N659G2X-.2521Y-6.002I-.1074J.2423
N660G1X-6.4979
N661G2X-6.6053Y-5.9793J.265
N662X-6.6488Y-5.9549I.1074J.2423
N663G40G1X-6.6773Y-5.996
N664X-6.6964Y-6.185
N665G2X-6.8444Y-6.0835I.1985J.448
N666G1X-6.875Y-6.0529
N667Y-6.185
N668X-6.6964
N669X-6.6255Y-6.025
N670G41X-6.6053Y-5.9793
N671G2X-6.6853Y-5.9244I.1074J.2423
N672G1X-6.9324Y-5.6773
N673G2X-7.01Y-5.4899I.1874J.1874
N674G1Y-3.02
N675G2X-6.745Y-2.755I.265
N676G1X-.0789
N677X-.0289
N678G40Y-2.705
N679X-.1315Y-2.628
N680G41X-.1507Y-2.5818
N681G2X-.2521Y-2.602I-.1014J.2448
N682G1X-6.4979
N683G2X-6.6853Y-2.5244J.265
N684G1X-6.9324Y-2.2773
N685G2X-7.01Y-2.0899I.1874J.1874
N686G1Y.38
N687G2X-6.745Y.645I.265
N688G1X-.005
N689G2X.26Y.38J-.265
N690G1Y-2.0899
N691G2X.1824Y-2.2773I-.265
N692G1X-.0647Y-2.5244
N693G2X-.1507Y-2.5818I-.1874J.1874
N694X-.1984Y-2.5965I-.1014J.2448
N695G40G1X-.1882Y-2.6455
N696X-.0789Y-2.705
N697G41Y-2.755
N698X-.005
N699G2X.26Y-3.02J-.265
N700G1Y-5.4899
N701G2X.1824Y-5.6773I-.265
N702G1X-.0647Y-5.9244
N703G2X-.1447Y-5.9793I-.1874J.1874
N704X-.1921Y-5.9951I-.1074J.2423
N705G40G1X-.1808Y-6.0438
N706G0Z.05
( OPERATION 5: ROUGHING )
( CS#2 - G55 )
N707G0G90X-5.06Y-.42
N708G1Z-.1217
N709Y-.3
N710G41D52Y-.25
N711X-6.745
N712G2X-7.Y.005J.255
N713G1Y.38
N714G2X-6.745Y.635I.255
N715G1X-.005
N716G2X.25Y.38J-.255
N717G1Y.005
N718G2X-.005Y-.25I-.255
N719G1X-5.06
N720X-5.11
N721G40Y-.3
N722G0Z.05
N723X-5.06Y-.42
N724G1Z-.2435
N725Y-.3
N726G41Y-.25
N727X-6.745
N728G2X-7.Y.005J.255
N729G1Y.38
N730G2X-6.745Y.635I.255
N731G1X-.005
N732G2X.25Y.38J-.255
N733G1Y.005
N734G2X-.005Y-.25I-.255
N735G1X-5.06
N736X-5.11
N737G40Y-.3
N738G0Z.05
N739X-5.06Y-.42
N740G1Z-.3652
N741Y-.3
N742G41Y-.25
N743X-6.745
N744G2X-7.Y.005J.255
N745G1Y.38
N746G2X-6.745Y.635I.255
N747G1X-.005
N748G2X.25Y.38J-.255
N749G1Y.005
N750G2X-.005Y-.25I-.255
N751G1X-5.06
N752X-5.11
N753G40Y-.3
N754G0Z.05
N755X-5.06Y-.42
N756G1Z-.487
N757Y-.3
N758G41Y-.25
N759X-6.745
N760G2X-7.Y.005J.255
N761G1Y.38
N762G2X-6.745Y.635I.255
N763G1X-.005
N764G2X.25Y.38J-.255
N765G1Y.005
N766G2X-.005Y-.25I-.255
N767G1X-5.06
N768X-5.11
N769G40Y-.3
N770G0Z.05
N771X-5.06Y-.4512
N772G1Z-.6087
N773Y-.3
N774G41Y-.25
N775X-6.745
N776G2X-7.Y.005J.255
N777G1Y.38
N778G2X-6.745Y.635I.255
N779G1X-.005
N780G2X.25Y.38J-.255
N781G1Y.005
N782G2X-.005Y-.25I-.255
N783G1X-5.06
N784X-5.11
N785G40Y-.3
N786G0Z.05
( OPERATION 6: ROUGHING )
( CS#2 - G55 )
N787G0G90X-5.06Y-3.82
N788G1Z-.1217
N789Y-3.7
N790G41D52Y-3.65
N791X-6.745
N792G2X-7.Y-3.395J.255
N793G1Y-3.02
N794G2X-6.745Y-2.765I.255
N795G1X-.005
N796G2X.25Y-3.02J-.255
N797G1Y-3.395
N798G2X-.005Y-3.65I-.255
N799G1X-5.06
N800X-5.11
N801G40Y-3.7
N802G0Z.05
N803X-5.06Y-3.82
N804G1Z-.2435
N805Y-3.7
N806G41Y-3.65
N807X-6.745
N808G2X-7.Y-3.395J.255
N809G1Y-3.02
N810G2X-6.745Y-2.765I.255
N811G1X-.005
N812G2X.25Y-3.02J-.255
N813G1Y-3.395
N814G2X-.005Y-3.65I-.255
N815G1X-5.06
N816X-5.11
N817G40Y-3.7
N818G0Z.05
N819X-5.06Y-3.82
N820G1Z-.3652
N821Y-3.7
N822G41Y-3.65
N823X-6.745
N824G2X-7.Y-3.395J.255
N825G1Y-3.02
N826G2X-6.745Y-2.765I.255
N827G1X-.005
N828G2X.25Y-3.02J-.255
N829G1Y-3.395
N830G2X-.005Y-3.65I-.255
N831G1X-5.06
N832X-5.11
N833G40Y-3.7
N834G0Z.05
N835X-5.06Y-3.82
N836G1Z-.487
N837Y-3.7
N838G41Y-3.65
N839X-6.745
N840G2X-7.Y-3.395J.255
N841G1Y-3.02
N842G2X-6.745Y-2.765I.255
N843G1X-.005
N844G2X.25Y-3.02J-.255
N845G1Y-3.395
N846G2X-.005Y-3.65I-.255
N847G1X-5.06
N848X-5.11
N849G40Y-3.7
N850G0Z.05
N851X-5.06Y-3.8512
N852G1Z-.6087
N853Y-3.7
N854G41Y-3.65
N855X-6.745
N856G2X-7.Y-3.395J.255
N857G1Y-3.02
N858G2X-6.745Y-2.765I.255
N859G1X-.005
N860G2X.25Y-3.02J-.255
N861G1Y-3.395
N862G2X-.005Y-3.65I-.255
N863G1X-5.06
N864X-5.11
N865G40Y-3.7
N866G0Z.05
( OPERATION 7: ROUGHING )
( CS#2 - G55 )
N867G0G90X-7.17Y-1.4062
N868Z-.55
N869G1Z-.64
N870X-5.8601
N871Y-1.452
N872X-.8899
N873Y-1.4062
N874X-5.8601
N875X-6.0851
N876Y-1.677
N877X-.6649
N878Y-1.1812
N879X-6.0851
N880Y-1.4062
N881X-6.31
N882Y-1.902
N883X-.4399
N884Y-.9562
N885X-6.31
N886Y-1.4062
N887X-6.535
N888Y-2.003
N889X-6.411Y-2.127
N890X-.339
N891X-.2149Y-2.003
N892Y-.7312
N893X-6.535
N894Y-.8505
N895X-6.5351Y-.852
N896X-6.535Y-.8535
N897Y-1.4062
N898X-6.76
N899Y-2.0899
N900G3X-6.7556Y-2.1006I.015
N901G1X-6.5086Y-2.3476
N902G3X-6.4979Y-2.352I.0107J.0106
N903G1X-.2521
N904G3X-.2414Y-2.3476J.015
N905G1X.0056Y-2.1006
N906G3X.0101Y-2.0899I-.0106J.0107
N907G1Y-.506
N908X-.005Y-.5062
N909X-6.745
N910X-6.76Y-.506
N911X-6.7546Y-.3311
N912G41D52X-6.753Y-.2811
N913G2X-7.Y-.0262I.008J.2549
N914G1Y.38
N915G2X-6.745Y.635I.255
N916G1X-.005
N917G2X.25Y.38J-.255
N918G1Y-.0262
N919G2X-.005Y-.2812I-.255
N920G1X-6.745
N921X-6.753Y-.2811
N922G2X-6.8025Y-.2747I.008J.2549
N923G40G1X-6.8138Y-.3234
N924X-6.76Y-.506
N925Y-.8505
N926X-6.7601Y-.852
N927X-6.76Y-.8535
N928Y-1.4062
N929G0Z.05
( OPERATION 8: ROUGHING )
( CS#2 - G55 )
N930G0G90X-5.86Y-6.162
N931Z-.55
N932G1Z-.64
N933Y-4.852
N934X-3.378
N935X-3.3765Y-4.8521
N936X-3.375Y-4.852
N937X-.8899
N938Y-4.8062
N939X-5.86
N940Y-4.852
N941Y-5.077
N942X-3.378
N943X-3.3765Y-5.0771
N944X-3.375Y-5.077
N945X-.6649
N946Y-4.5812
N947X-6.0851
N948Y-5.077
N949X-5.86
N950Y-5.302
N951X-3.378
N952X-3.3765Y-5.3021
N953X-3.375Y-5.302
N954X-.4399
N955Y-4.3562
N956X-6.3101
N957X-6.31Y-5.302
N958X-5.86
N959Y-5.527
N960X-3.378
N961X-3.3765Y-5.5271
N962X-3.375Y-5.527
N963X-.339
N964X-.2149Y-5.403
N965Y-4.1312
N966X-6.535
N967Y-5.403
N968X-6.411Y-5.527
N969X-5.86
N970Y-5.752
N971X-3.378
N972X-3.3765Y-5.7521
N973X-3.375Y-5.752
N974X-.2521
N975G3X-.2414Y-5.7476J.015
N976G1X.0056Y-5.5006
N977G3X.0101Y-5.4899I-.0106J.0107
N978G1Y-3.906
N979X-.005Y-3.9062
N980X-6.745
N981X-6.76Y-3.906
N982X-6.7546Y-3.7311
N983G41D52X-6.753Y-3.6811
N984G2X-7.Y-3.4262I.008J.2549
N985G1Y-3.02
N986G2X-6.745Y-2.765I.255
N987G1X-.005
N988G2X.25Y-3.02J-.255
N989G1Y-3.4262
N990G2X-.005Y-3.6812I-.255
N991G1X-6.745
N992X-6.753Y-3.6811
N993G2X-6.8025Y-3.6747I.008J.2549
N994G40G1X-6.8138Y-3.7234
N995X-6.76Y-3.906
N996Y-5.4899
N997G3X-6.7556Y-5.5006I.015
N998G1X-6.5086Y-5.7476
N999G3X-6.4979Y-5.752I.0107J.0106
N1000G1X-5.86
N1001G0Z.05
( OPERATION 9: ROUGHING )
( CS#2 - G55 )
N1002G0G90X-7.05Y-.2367
N1003Z-.59
N1004G1Z-.7877
N1005G41D52X-7.
N1006Y.38
N1007G2X-6.745Y.635I.255
N1008G1X-.005
N1009G2X.25Y.38J-.255
N1010G1Y-2.0899
N1011G2X.1753Y-2.2702I-.255
N1012G1X-.0718Y-2.5173
N1013G2X-.2521Y-2.592I-.1803J.1803
N1014G1X-6.4979
N1015G2X-6.6782Y-2.5173J.255
N1016G1X-6.9253Y-2.2702
N1017G2X-7.Y-2.0899I.1803J.1803
N1018G1Y-.2367
N1019Y-.1867
N1020G40X-7.05
N1021G0Z.05
N1022Y-.2367
N1023Z-.7377
N1024G1Z-.9353
N1025G41X-7.
N1026Y.38
N1027G2X-6.745Y.635I.255
N1028G1X-.005
N1029G2X.25Y.38J-.255
N1030G1Y-2.0899
N1031G2X.1753Y-2.2702I-.255
N1032G1X-.0718Y-2.5173
N1033G2X-.2521Y-2.592I-.1803J.1803
N1034G1X-6.4979
N1035G2X-6.6782Y-2.5173J.255
N1036G1X-6.9253Y-2.2702
N1037G2X-7.Y-2.0899I.1803J.1803
N1038G1Y-.2367
N1039Y-.1867
N1040G40X-7.05
N1041G0Z.05
N1042Y-.2367
N1043Z-.8853
N1044G1Z-1.083
N1045G41X-7.
N1046Y.38
N1047G2X-6.745Y.635I.255
N1048G1X-.005
N1049G2X.25Y.38J-.255
N1050G1Y-2.0899
N1051G2X.1753Y-2.2702I-.255
N1052G1X-.0718Y-2.5173
N1053G2X-.2521Y-2.592I-.1803J.1803
N1054G1X-6.4979
N1055G2X-6.6782Y-2.5173J.255
N1056G1X-6.9253Y-2.2702
N1057G2X-7.Y-2.0899I.1803J.1803
N1058G1Y-.2367
N1059Y-.1867
N1060G40X-7.05
N1061G0Z.05
( OPERATION 10: ROUGHING )
( CS#2 - G55 )
N1062G0G90X-4.9365Y-6.042
N1063Z-.59
N1064G1Z-.7877
N1065G41D52Y-5.992
N1066X-6.4979
N1067G2X-6.6782Y-5.9173J.255
N1068G1X-6.9253Y-5.6702
N1069G2X-7.Y-5.4899I.1803J.1803
N1070G1Y-3.02
N1071G2X-6.745Y-2.765I.255
N1072G1X-.005
N1073G2X.25Y-3.02J-.255
N1074G1Y-5.4899
N1075G2X.1753Y-5.6702I-.255
N1076G1X-.0718Y-5.9173
N1077G2X-.2521Y-5.992I-.1803J.1803
N1078G1X-4.9365
N1079X-4.9865
N1080G40Y-6.042
N1081G0Z.05
N1082X-4.9365
N1083Z-.7377
N1084G1Z-.9353
N1085G41Y-5.992
N1086X-6.4979
N1087G2X-6.6782Y-5.9173J.255
N1088G1X-6.9253Y-5.6702
N1089G2X-7.Y-5.4899I.1803J.1803
N1090G1Y-3.02
N1091G2X-6.745Y-2.765I.255
N1092G1X-.005
N1093G2X.25Y-3.02J-.255
N1094G1Y-5.4899
N1095G2X.1753Y-5.6702I-.255
N1096G1X-.0718Y-5.9173
N1097G2X-.2521Y-5.992I-.1803J.1803
N1098G1X-4.9365
N1099X-4.9865
N1100G40Y-6.042
N1101G0Z.05
N1102X-4.9365
N1103Z-.8853
N1104G1Z-1.083
N1105G41Y-5.992
N1106X-6.4979
N1107G2X-6.6782Y-5.9173J.255
N1108G1X-6.9253Y-5.6702
N1109G2X-7.Y-5.4899I.1803J.1803
N1110G1Y-3.02
N1111G2X-6.745Y-2.765I.255
N1112G1X-.005
N1113G2X.25Y-3.02J-.255
N1114G1Y-5.4899
N1115G2X.1753Y-5.6702I-.255
N1116G1X-.0718Y-5.9173
N1117G2X-.2521Y-5.992I-.1803J.1803
N1118G1X-4.9365
N1119X-4.9865
N1120G40Y-6.042
N1121G0Z.05
N1122M9
N1123G0G28G91Z0.M5
N1124G49
N1125M1
( TOOL CHANGE, TOOL #3 )
( DIAMETER = .0625 BALL ENDMILL )
( OPERATION 11: CONTOUR )
( CS#2 - G55 )
( G55 = X0. Y0. Z0. )
N1126T3M6
N1127S10000M3
N1128G0G17G55G61G90X.09Y-.062M8
N1129G43Z1.H3
N1130Z-.56
N1131G1Z-.637F10.
N1132G41D53Y-.032
N1133X-6.84
N1134G40Y-.062
N1135G0Z.05
( OPERATION 12: CONTOUR )
( CS#2 - G55 )
N1136G0G90X.09Y-.0612
N1137Z-.56
N1138G1Z-.64
N1139G41D53Y-.0312
N1140X-6.84
N1141G40Y-.0612
N1142G0Z.05
( OPERATION 13: CONTOUR )
( CS#2 - G55 )
N1143G0G90X.09Y-3.462
N1144Z-.56
N1145G1Z-.637
N1146G41D53Y-3.432
N1147X-6.84
N1148G40Y-3.462
N1149G0Z.05
( OPERATION 14: CONTOUR )
( CS#2 - G55 )
N1150G0G90X.09Y-3.4612
N1151Z-.56
N1152G1Z-.64
N1153G41D53Y-3.4312
N1154X-6.84
N1155G40Y-3.4612
N1156G0Z.05
N1157M9
N1158G0G28G91Z0.M5
N1159G49
N1160M1
( TOOL CHANGE, TOOL #4 )
( DIAMETER = .5 SPOT DRILL )
( OPERATION 15: HOLES )
( CS#2 - G55 )
( G55 = X0. Y0. Z0. )
N1161T4M6
N1162S3000M3
N1163G0G17G55G61G90X-6.375Y-5.456M8
N1164G43Z1.H4
N1165Z.05
N1166G83G98R-.59Z-.7285Q.04F20.
N1167X-5.375
N1168X-5.275Y-3.725
N1169X-6.375
N1170Y-2.056
N1171X-5.375
N1172X-5.275Y-.325
N1173X-6.375
N1174X-1.475
N1175X-.375
N1176X-.875Y-1.375
N1177X-.375Y-2.056
N1178Y-3.725
N1179X-1.475
N1180X-.875Y-4.775
N1181X-.375Y-5.456
N1182G80Z.05
( OPERATION 16: HOLES )
( CS#2 - G55 )
N1183G0G90X-3.375Y-1.305
N1184G83G98R-.59Z-.77Q.04F20.
N1185Y-4.705
N1186G80Z.05
( OPERATION 17: HOLES )
( CS#2 - G55 )
N1187G0G90X-1.1248Y-.6215
N1188G83G98R-.59Z-.8225Q.04F20.
N1189Y-4.0215
N1190X-2.7783
N1191X-4.0185
N1192X-5.672
N1193X-2.7783Y-.6215
N1194X-4.0185
N1195X-5.672
N1196G80Z.05
( OPERATION 18: HOLES )
( CS#2 - G55 )
N1197G0G90X-1.3295Y-2.0563
N1198G83G98R-.59Z-.864Q.04F20.
N1199X-2.4713
N1200X-4.1248
N1201X-5.8177
N1202X-1.3295Y-5.4563
N1203X-2.4713
N1204X-4.1248
N1205X-5.8177
N1206G80Z.05
N1207M9
N1208G0G28G91Z0.M5
N1209G49
N1210M1
( TOOL CHANGE, TOOL #5 )
( DIAMETER = .177 DRILL )
( 8-32 HELICOIL TAP DRILL )
( OPERATION 19: HOLES )
( CS#2 - G55 )
( G55 = X0. Y0. Z0. )
N1211T5M6
N1212S4000M3
N1213G0G17G55G61G90X-6.375Y-5.456M8
N1214G43Z1.H5
N1215Z.05
N1216G83G98R-.59Z-1.27Q.1F25.
N1217X-5.375
N1218X-5.275Y-3.725
N1219X-6.375
N1220Y-2.056
N1221X-5.375
N1222X-5.275Y-.325
N1223X-6.375
N1224X-1.475
N1225X-.375
N1226X-.875Y-1.375
N1227X-.375Y-2.056
N1228Y-3.725
N1229X-1.475
N1230X-.875Y-4.775
N1231X-.375Y-5.456
N1232G80Z.05
N1233M9
N1234G0G28G91Z0.M5
N1235G49
N1236M1
( TOOL CHANGE, TOOL #6 )
( DIAMETER = .375 COUNTERSINK )
( OPERATION 20: HOLES )
( CS#2 - G55 )
( G55 = X0. Y0. Z0. )
N1237T6M6
N1238S3000M3
N1239G0G17G55G61G90X-6.375Y-5.456M8
N1240G43Z1.H6
N1241Z.05
N1242G81G98R-.59Z-.7049F20.
N1243X-5.375
N1244X-5.275Y-3.725
N1245X-6.375
N1246Y-2.056
N1247X-5.375
N1248X-5.275Y-.325
N1249X-6.375
N1250X-1.475
N1251X-.375
N1252X-.875Y-1.375
N1253X-.375Y-2.056
N1254Y-3.725
N1255X-1.475
N1256X-.875Y-4.775
N1257X-.375Y-5.456
N1258G80Z.05
N1259M9
N1260G0G28G91Z0.M5
N1261G49
N1262M1
( TOOL CHANGE, TOOL #7 )
( DIAMETER = .207 TAP )
( 8-32 HELICOIL TAP )
( OPERATION 21: HOLES )
( CS#2 - G55 )
( G55 = X0. Y0. Z0. )
N1263T7M6
N1264S320M3
N1265G0G17G55G61G90X-6.375Y-5.456M8
N1266G43Z1.H7
N1267Z.15
N1268G84G98R-.49Z-1.18F10.
N1269X-5.375
N1270X-5.275Y-3.725
N1271X-6.375
N1272Y-2.056
N1273X-5.375
N1274X-5.275Y-.325
N1275X-6.375
N1276X-1.475
N1277X-.375
N1278X-.875Y-1.375
N1279X-.375Y-2.056
N1280Y-3.725
N1281X-1.475
N1282X-.875Y-4.775
N1283X-.375Y-5.456
N1284G80Z.15
N1285M9
N1286G0G28G91Z0.M5
N1287G49
N1288M1
( TOOL CHANGE, TOOL #8 )
( DIAMETER = .25 DRILL )
( OPERATION 22: HOLES )
( CS#2 - G55 )
( G55 = X0. Y0. Z0. )
N1289T8M6
N1290S3000M3
N1291G0G17G55G61G90X-3.375Y-1.305M8
N1292G43Z1.H8
N1293Z.05
N1294G83G98R-.59Z-1.18Q.15F20.
N1295Y-4.705
N1296G80Z.05
N1297M9
N1298G0G28G91Z0.M5
N1299G49
N1300M1
( TOOL CHANGE, TOOL #9 )
( DIAMETER = .196 DRILL )
( OPERATION 23: HOLES )
( CS#2 - G55 )
( G55 = X0. Y0. Z0. )
N1301T9M6
N1302S4000M3
N1303G0G17G55G61G90X-1.1248Y-.6215M8
N1304G43Z1.H9
N1305Z.05
N1306G83G98R-.59Z-1.16Q.13F30.
N1307Y-4.0215
N1308X-2.7783
N1309X-4.0185
N1310X-5.672
N1311X-2.7783Y-.6215
N1312X-4.0185
N1313X-5.672
N1314G80Z.05
N1315M9
N1316G0G28G91Z0.M5
N1317G49
N1318M1
( TOOL CHANGE, TOOL #10 )
( DIAMETER = .209 DRILL )
( OPERATION 24: HOLES )
( CS#2 - G55 )
( G55 = X0. Y0. Z0. )
N1319T10M6
N1320S3500M3
N1321G0G17G55G61G90X-1.3295Y-2.0563M8
N1322G43Z1.H10
N1323Z.05
N1324G83G98R-.59Z-1.165Q.18F30.
N1325X-2.4713
N1326X-4.1248
N1327X-5.8177
N1328X-1.3295Y-5.4563
N1329X-2.4713
N1330X-4.1248
N1331X-5.8177
N1332G80Z.05
N1333M9
N1334G0G28G91Z0.M5
N1335G49
N1336M1
( TOOL CHANGE, TOOL #11 )
( DIAMETER = .4375 ROUGH ENDMILL )
( OPERATION 25: HOLES )
( CS#2 - G55 )
( G55 = X0. Y0. Z0. )
N1337T11M6
N1338S3000M3
N1339G0G17G55G61G90X-1.3295Y-2.0563M8
N1340G43Z1.H11
N1341Z.05
N1342G83G98R-.59Z-.99Q.09F10.
N1343X-2.4713
N1344X-4.1248
N1345X-5.8177
N1346X-1.3295Y-5.4563
N1347X-2.4713
N1348X-4.1248
N1349X-5.8177
N1350G80Z.05
N1351M9
N1352G0G28G91Z0.M5
N1353G49
N1354M1
( TOOL CHANGE, TOOL #12 )
( DIAMETER = .25 FINISH ENDMILL )
( OPERATION 26: ROUGHING )
( CS#2 - G55 )
( G55 = X0. Y0. Z0. )
N1355T12M6
N1356S10000M3
N1357G0G17G55G61G90X-5.672Y-.6215M8
N1358G43Z1.H12
N1359Z-.59
N1360G1Z-.7485F5.
N1361G41D62Y-.671
N1362G3J.0495
N1363X-5.6526Y-.667J.0495
N1364G40G1X-5.672Y-.6215
N1365G0Z.05
N1366Z-.6985
N1367G1Z-.857
N1368G41Y-.671
N1369G3J.0495
N1370X-5.6526Y-.667J.0495
N1371G40G1X-5.672Y-.6215
N1372G0Z.05
( OPERATION 27: ROUGHING )
( CS#2 - G55 )
N1373G0G90X-4.0185Y-.6215
N1374Z-.59
N1375G1Z-.7485
N1376G41D62Y-.671
N1377G3J.0495
N1378X-3.999Y-.667J.0495
N1379G40G1X-4.0185Y-.6215
N1380G0Z.05
N1381Z-.6985
N1382G1Z-.857
N1383G41Y-.671
N1384G3J.0495
N1385X-3.999Y-.667J.0495
N1386G40G1X-4.0185Y-.6215
N1387G0Z.05
( OPERATION 28: ROUGHING )
( CS#2 - G55 )
N1388G0G90X-2.7783Y-.6215
N1389Z-.59
N1390G1Z-.7485
N1391G41D62Y-.671
N1392G3J.0495
N1393X-2.7589Y-.667J.0495
N1394G40G1X-2.7783Y-.6215
N1395G0Z.05
N1396Z-.6985
N1397G1Z-.857
N1398G41Y-.671
N1399G3J.0495
N1400X-2.7589Y-.667J.0495
N1401G40G1X-2.7783Y-.6215
N1402G0Z.05
( OPERATION 29: ROUGHING )
( CS#2 - G55 )
N1403G0G90X-1.1248Y-.6215
N1404Z-.59
N1405G1Z-.7485
N1406G41D62Y-.671
N1407G3J.0495
N1408X-1.1053Y-.667J.0495
N1409G40G1X-1.1248Y-.6215
N1410G0Z.05
N1411Z-.6985
N1412G1Z-.857
N1413G41Y-.671
N1414G3J.0495
N1415X-1.1053Y-.667J.0495
N1416G40G1X-1.1248Y-.6215
N1417G0Z.05
( OPERATION 30: ROUGHING )
( CS#2 - G55 )
N1418G0G90X-1.1248Y-4.0215
N1419Z-.59
N1420G1Z-.7485
N1421G41D62Y-4.071
N1422G3J.0495
N1423X-1.1053Y-4.067J.0495
N1424G40G1X-1.1248Y-4.0215
N1425G0Z.05
N1426Z-.6985
N1427G1Z-.857
N1428G41Y-4.071
N1429G3J.0495
N1430X-1.1053Y-4.067J.0495
N1431G40G1X-1.1248Y-4.0215
N1432G0Z.05
( OPERATION 31: ROUGHING )
( CS#2 - G55 )
N1433G0G90X-2.7783Y-4.0215
N1434Z-.59
N1435G1Z-.7485
N1436G41D62Y-4.071
N1437G3J.0495
N1438X-2.7589Y-4.067J.0495
N1439G40G1X-2.7783Y-4.0215
N1440G0Z.05
N1441Z-.6985
N1442G1Z-.857
N1443G41Y-4.071
N1444G3J.0495
N1445X-2.7589Y-4.067J.0495
N1446G40G1X-2.7783Y-4.0215
N1447G0Z.05
( OPERATION 32: ROUGHING )
( CS#2 - G55 )
N1448G0G90X-4.0185Y-4.0215
N1449Z-.59
N1450G1Z-.7485
N1451G41D62Y-4.071
N1452G3J.0495
N1453X-3.999Y-4.067J.0495
N1454G40G1X-4.0185Y-4.0215
N1455G0Z.05
N1456Z-.6985
N1457G1Z-.857
N1458G41Y-4.071
N1459G3J.0495
N1460X-3.999Y-4.067J.0495
N1461G40G1X-4.0185Y-4.0215
N1462G0Z.05
( OPERATION 33: ROUGHING )
( CS#2 - G55 )
N1463G0G90X-5.672Y-4.0215
N1464Z-.59
N1465G1Z-.7485
N1466G41D62Y-4.071
N1467G3J.0495
N1468X-5.6526Y-4.067J.0495
N1469G40G1X-5.672Y-4.0215
N1470G0Z.05
N1471Z-.6985
N1472G1Z-.857
N1473G41Y-4.071
N1474G3J.0495
N1475X-5.6526Y-4.067J.0495
N1476G40G1X-5.672Y-4.0215
N1477G0Z.05
( OPERATION 34: ROUGHING )
( CS#2 - G55 )
N1478G0G90X-5.672Y-.6215
N1479Z-.59
N1480G1Z-.86
N1481G41D62Y-.674
N1482G3J.0525
N1483X-5.6525Y-.6702J.0525
N1484G40G1X-5.672Y-.6215
N1485G0Z.05
( OPERATION 35: ROUGHING )
( CS#2 - G55 )
N1486G0G90X-4.0185Y-.6215
N1487Z-.59
N1488G1Z-.86
N1489G41D62Y-.674
N1490G3J.0525
N1491X-3.999Y-.6702J.0525
N1492G40G1X-4.0185Y-.6215
N1493G0Z.05
( OPERATION 36: ROUGHING )
( CS#2 - G55 )
N1494G0G90X-2.7783Y-.6215
N1495Z-.59
N1496G1Z-.86
N1497G41D62Y-.674
N1498G3J.0525
N1499X-2.7588Y-.6702J.0525
N1500G40G1X-2.7783Y-.6215
N1501G0Z.05
( OPERATION 37: ROUGHING )
( CS#2 - G55 )
N1502G0G90X-1.1248Y-.6215
N1503Z-.59
N1504G1Z-.86
N1505G41D62Y-.674
N1506G3J.0525
N1507X-1.1053Y-.6702J.0525
N1508G40G1X-1.1248Y-.6215
N1509G0Z.05
( OPERATION 38: ROUGHING )
( CS#2 - G55 )
N1510G0G90X-1.1248Y-4.0215
N1511Z-.59
N1512G1Z-.86
N1513G41D62Y-4.074
N1514G3J.0525
N1515X-1.1053Y-4.0702J.0525
N1516G40G1X-1.1248Y-4.0215
N1517G0Z.05
( OPERATION 39: ROUGHING )
( CS#2 - G55 )
N1518G0G90X-2.7783Y-4.0215
N1519Z-.59
N1520G1Z-.86
N1521G41D62Y-4.074
N1522G3J.0525
N1523X-2.7588Y-4.0702J.0525
N1524G40G1X-2.7783Y-4.0215
N1525G0Z.05
( OPERATION 40: ROUGHING )
( CS#2 - G55 )
N1526G0G90X-4.0185Y-4.0215
N1527Z-.59
N1528G1Z-.86
N1529G41D62Y-4.074
N1530G3J.0525
N1531X-3.999Y-4.0702J.0525
N1532G40G1X-4.0185Y-4.0215
N1533G0Z.05
( OPERATION 41: ROUGHING )
( CS#2 - G55 )
N1534G0G90X-5.672Y-4.0215
N1535Z-.59
N1536G1Z-.86
N1537G41D62Y-4.074
N1538G3J.0525
N1539X-5.6525Y-4.0702J.0525
N1540G40G1X-5.672Y-4.0215
N1541G0Z.05
N1542M9
N1543G0G28G91Z0.M5
N1544G49
N1545M1
( TOOL CHANGE, TOOL #13 )
( DIAMETER = .355 COUNTERSINK )
( OPERATION 42: HOLES )
( CS#2 - G55 )
( G55 = X0. Y0. Z0. )
N1546T13M6
N1547S1500M3
N1548G0G17G55G61G90X-1.1248Y-.6215M8
N1549G43Z1.H13
N1550Z.05
N1551G83G98R-.79Z-1.0089Q.03F10.
N1552Y-4.0215
N1553X-2.7783
N1554X-4.0185
N1555X-5.672
N1556X-2.7783Y-.6215
N1557X-4.0185
N1558X-5.672
N1559G80Z.05
N1560M9
N1561G0G28G91Z0.M5
N1562G49
N1563M1
( TOOL CHANGE, TOOL #14 )
( DIAMETER = .125 SPOT DRILL )
( V E-M  DEBURRING )
( OPERATION 43: CONTOUR )
( CS#2 - G55 )
( G55 = X0. Y0. Z0. )
N1564T14M6
N1565S10000M3
N1566G0G17G55G61G90X-6.805Y.1987M8
N1567G43Z1.H14
N1568Z.05
N1569Z-.04
N1570G41D64G1X-6.785F30.
N1571Y.385
N1572G2X-6.75Y.42I.035
N1573G1X0.
N1574G2X.035Y.385J-.035
N1575G1Y0.
N1576G2X0.Y-.035I-.035
N1577G1X-6.75
N1578G2X-6.785Y0.J.035
N1579G1Y.1987
N1580Y.2187
N1581G40X-6.805
N1582G0Z.05
( OPERATION 44: CONTOUR )
( CS#2 - G55 )
N1583G0G90X-6.805Y-3.2375
N1584Z-.04
N1585G41D64G1X-6.785
N1586Y-3.015
N1587G2X-6.75Y-2.98I.035
N1588G1X0.
N1589G2X.035Y-3.015J-.035
N1590G1Y-3.4
N1591G2X0.Y-3.435I-.035
N1592G1X-6.75
N1593G2X-6.785Y-3.4J.035
N1594G1Y-3.2375
N1595Y-3.2175
N1596G40X-6.805
N1597G0Z.05
( OPERATION 45: CONTOUR )
( CS#2 - G55 )
N1598G0G90X.055Y-3.465
N1599Z-.59
N1600Z-.68
N1601G41D64G1X.035
N1602Y-5.492
N1603G2X.0247Y-5.5167I-.035
N1604G1X-.2253Y-5.7667
N1605G2X-.25Y-5.777I-.0247J.0247
N1606G1X-6.5
N1607G2X-6.5247Y-5.7667J.035
N1608G1X-6.7747Y-5.5167
N1609G2X-6.785Y-5.492I.0247J.0247
N1610G1Y-3.465
N1611G40X-6.805
N1612G0Z.05
( OPERATION 46: CONTOUR )
( CS#2 - G55 )
N1613G0G90X.055Y-.065
N1614Z-.59
N1615Z-.68
N1616G41D64G1X.035
N1617Y-2.092
N1618G2X.0247Y-2.1167I-.035
N1619G1X-.2253Y-2.3667
N1620G2X-.25Y-2.377I-.0247J.0247
N1621G1X-6.5
N1622G2X-6.5247Y-2.3667J.035
N1623G1X-6.7747Y-2.1167
N1624G2X-6.785Y-2.092I.0247J.0247
N1625G1Y-.065
N1626G40X-6.805
N1627G0Z.05
( OPERATION 47: ROUGHING )
( CS#2 - G55 )
N1628G0G90X-5.8177Y-2.1058
N1629Z-.94
N1630G1Z-1.03F5.
N1631G41D64Y-2.1258
N1632G3J.0695
N1633X-5.798Y-2.1229J.0695
N1634G40G1X-5.8037Y-2.1037
N1635G0Z.05
( OPERATION 48: ROUGHING )
( CS#2 - G55 )
N1636G0G90X-4.1248Y-2.1058
N1637Z-.94
N1638G1Z-1.03
N1639G41D64Y-2.1258
N1640G3J.0695
N1641X-4.1051Y-2.1229J.0695
N1642G40G1X-4.1108Y-2.1037
N1643G0Z.05
( OPERATION 49: ROUGHING )
( CS#2 - G55 )
N1644G0G90X-2.4713Y-2.1058
N1645Z-.94
N1646G1Z-1.03
N1647G41D64Y-2.1258
N1648G3J.0695
N1649X-2.4515Y-2.1229J.0695
N1650G40G1X-2.4572Y-2.1037
N1651G0Z.05
( OPERATION 50: ROUGHING )
( CS#2 - G55 )
N1652G0G90X-1.3295Y-2.1058
N1653Z-.94
N1654G1Z-1.03
N1655G41D64Y-2.1258
N1656G3J.0695
N1657X-1.3098Y-2.1229J.0695
N1658G40G1X-1.3155Y-2.1037
N1659G0Z.05
( OPERATION 51: ROUGHING )
( CS#2 - G55 )
N1660G0G90X-1.3295Y-5.5058
N1661Z-.94
N1662G1Z-1.03
N1663G41D64Y-5.5258
N1664G3J.0695
N1665X-1.3098Y-5.5229J.0695
N1666G40G1X-1.3155Y-5.5037
N1667G0Z.05
( OPERATION 52: ROUGHING )
( CS#2 - G55 )
N1668G0G90X-2.4713Y-5.5058
N1669Z-.94
N1670G1Z-1.03
N1671G41D64Y-5.5258
N1672G3J.0695
N1673X-2.4515Y-5.5229J.0695
N1674G40G1X-2.4572Y-5.5037
N1675G0Z.05
( OPERATION 53: ROUGHING )
( CS#2 - G55 )
N1676G0G90X-4.1248Y-5.5058
N1677Z-.94
N1678G1Z-1.03
N1679G41D64Y-5.5258
N1680G3J.0695
N1681X-4.1051Y-5.5229J.0695
N1682G40G1X-4.1108Y-5.5037
N1683G0Z.05
( OPERATION 54: ROUGHING )
( CS#2 - G55 )
N1684G0G90X-5.8177Y-5.5058
N1685Z-.94
N1686G1Z-1.03
N1687G41D64Y-5.5258
N1688G3J.0695
N1689X-5.798Y-5.5229J.0695
N1690G40G1X-5.8037Y-5.5037
N1691G0Z.05
N1692M9
N1693G0G28G91Z0.M5
N1694G49
N1695G28Y0.
N1696M30
( FILE LENGTH: 30670 CHARACTERS )
