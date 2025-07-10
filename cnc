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
        textarea {
            min-height: 300px;
            resize: vertical;
            font-family: monospace;
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

        <textarea id="fileContent"
                  class="w-full p-4 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none"
                  placeholder="Upload a file or type content here..."
                  rows="15"></textarea>

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

        <button id="applyNextToolButton"
                class="bg-purple-600 hover:bg-purple-700 text-white font-bold py-2 px-4 rounded-lg transition duration-200 shadow-md mt-4">
            Apply Next Tool Logic
        </button>

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
        const fileContentTextArea = document.getElementById('fileContent');
        const replaceButton = document.getElementById('replaceButton');
        const applyNextToolButton = document.getElementById('applyNextToolButton');
        const downloadButton = document.getElementById('downloadButton');
        const clearButton = document.getElementById('clearButton');
        const messageBox = document.getElementById('messageBox');
        const patternListDiv = document.getElementById('patternList');
        const findReplaceInputsContainer = document.getElementById('findReplaceInputsContainer');
        const sFormulaInput = document.getElementById('sFormulaInput');
        const fFormulaInput = document.getElementById('fFormulaInput');

        let currentFileName = 'edited_file.txt';
        let currentFindInputIndex = 0;
        let hasAppliedNextToolLogic = false;

        const MAX_INPUT_PAIRS = 50;
        const findInputs = [];
        const replaceInputs = [];
        const inputPairContainers = [];

        let allDetectedTPatterns = [];

        let sFormulaConstants = { num1: 3.82, num2: 800 };
        let fFormulaConstants = { num1: 4, num2: 0.003 };

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
            // New regex for general DIAMETER comments
            const generalDiameterCommentRegex = /\(\s*DIAMETER\s*=\s*[^)]+\)/gi;

            const tPatterns = new Map();
            const hPatterns = new Map();
            const dPatterns = new Map();
            const sPatterns = new Map();
            const fPatterns = new Map();
            const g84Patterns = new Map();
            const toolDiaPatterns = new Map(); // Stores full string like "DIAMETER - 0.1"
            const fullDiameterPatterns = new Map(); // Stores full string like "DIAMETER - 0.1"
            const specialCommentDescriptions = new Map();
            const generalDiameterComments = new Map(); // New map for general DIAMETER comments

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

                // Find general DIAMETER comments
                generalDiameterCommentRegex.lastIndex = 0;
                while ((match = generalDiameterCommentRegex.exec(line)) !== null) {
                    const comment = match[0].trim();
                    if (comment) {
                        generalDiameterComments.set(comment, (generalDiameterComments.get(comment) || 0) + 1);
                    }
                }

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

                regexG84.lastIndex = 0;
                if (regexG84.test(cleanedLine)) {
                    const nMatch = cleanedLine.match(/N(\d+)/i);
                    const nValue = nMatch ? nMatch[0].toUpperCase() : 'N/A';
                    g84Patterns.set(nValue, (g84Patterns.get(nValue) || 0) + 1);
                }

                localRegexToolDia.lastIndex = 0;
                while ((match = localRegexToolDia.exec(cleanedLine)) !== null) {
                    const fullPattern = match[1]; // Capture the full matched string
                    toolDiaPatterns.set(fullPattern, (toolDiaPatterns.get(fullPattern) || 0) + 1);
                    fullDiameterPatterns.set(fullPattern, (fullDiameterPatterns.get(fullPattern) || 0) + 1); // Store full pattern
                }
            });

            return { tPatterns, hPatterns, dPatterns, sPatterns, fPatterns, g84Patterns, toolDiaPatterns, fullDiameterPatterns, specialCommentDescriptions, generalDiameterComments };
        }

        function scanAndDisplayPatterns() {
            const fullContent = fileContentTextArea.value;
            const lines = fullContent.split('\n');

            patternListDiv.innerHTML = '';
            allDetectedTPatterns = [];

            let patternsFoundOverall = false;
            let groupCounter = 0;
            let currentGroupContentLines = [];

            const blockTools = getBlockTools(fullContent);

            for (let i = 0; i < lines.length; i++) {
                const line = lines[i];
                const trimmedLine = line.trim();

                // Updated to check for both M1 and M01 as delimiters
                if (/\b(m1|m01)\b/.test(trimmedLine.toLowerCase()) && currentGroupContentLines.length > 0) {
                    groupCounter++;
                    const nMatchOnM01Line = trimmedLine.match(/N(\d+)/i);
                    const nValueForThisM01 = nMatchOnM01Line ? nMatchOnM01Line[0].toUpperCase() : null;

                    const { tPatterns, hPatterns, dPatterns, sPatterns, fPatterns, g84Patterns, toolDiaPatterns, fullDiameterPatterns, specialCommentDescriptions, generalDiameterComments } = findPatternsInSegment(currentGroupContentLines.join('\n'));

                    let nextToolForThisBlock = null;
                    if (blockTools.length > 0) {
                        const currentToolInBlock = Array.from(tPatterns.keys()).find(t => t.match(/T\d+/i));
                        const currentToolIndexInBlockTools = blockTools.indexOf(currentToolInBlock);
                        if (currentToolIndexInBlockTools !== -1) {
                            const nextBlockToolIndex = (currentToolIndexInBlockTools + 1) % blockTools.length;
                            nextToolForThisBlock = blockTools[nextBlockToolIndex];
                        }
                    }

                    tPatterns.forEach((count, pattern) => {
                        if (!allDetectedTPatterns.includes(pattern)) {
                            allDetectedTPatterns.push(pattern);
                        }
                    });

                    const g84DetailsForGroup = [];
                    let currentToolDiaForGroup = null;

                    currentGroupContentLines.forEach(segmentLine => {
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
                                if (suggestedF > 40) suggestedF = 40;
                            }
                            g84DetailsForGroup.push({ nValue, suggestedS, suggestedF });
                        }
                    });

                    renderGroupPatterns(groupCounter, tPatterns, hPatterns, dPatterns, sPatterns, fPatterns, g84DetailsForGroup, toolDiaPatterns, fullDiameterPatterns, specialCommentDescriptions, generalDiameterComments, nValueForThisM01, true, nextToolForThisBlock);
                    
                    if (tPatterns.size > 0 || hPatterns.size > 0 || dPatterns.size > 0 || sPatterns.size > 0 || fPatterns.size > 0 || g84Patterns.size > 0 || toolDiaPatterns.size > 0 || fullDiameterPatterns.size > 0 || specialCommentDescriptions.size > 0 || generalDiameterComments.size > 0 || nValueForThisM01) {
                        patternsFoundOverall = true;
                    }

                    currentGroupContentLines = [];
                } else {
                    currentGroupContentLines.push(line);
                }
            }

            if (currentGroupContentLines.length > 0) {
                groupCounter++;
                const { tPatterns, hPatterns, dPatterns, sPatterns, fPatterns, g84Patterns, toolDiaPatterns, fullDiameterPatterns, specialCommentDescriptions, generalDiameterComments } = findPatternsInSegment(currentGroupContentLines.join('\n'));

                let nextToolForThisBlock = null;
                if (blockTools.length > 0) {
                    const currentToolInBlock = Array.from(tPatterns.keys()).find(t => t.match(/T\d+/i));
                    const currentToolIndexInBlockTools = blockTools.indexOf(currentToolInBlock);
                    if (currentToolIndexInBlockTools !== -1) {
                        const nextBlockToolIndex = (currentToolIndexInBlockTools + 1) % blockTools.length;
                        nextToolForThisBlock = blockTools[nextBlockToolIndex];
                    }
                }

                tPatterns.forEach((count, pattern) => {
                    if (!allDetectedTPatterns.includes(pattern)) {
                        allDetectedTPatterns.push(pattern);
                    }
                });

                const g84DetailsForGroup = [];
                let currentToolDiaForGroup = null; 
                currentGroupContentLines.forEach(segmentLine => {
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
                            if (suggestedF > 40) suggestedF = 40;
                        }
                        g84DetailsForGroup.push({ nValue, suggestedS, suggestedF });
                    }
                });

                renderGroupPatterns(groupCounter, tPatterns, hPatterns, dPatterns, sPatterns, fPatterns, g84DetailsForGroup, toolDiaPatterns, fullDiameterPatterns, specialCommentDescriptions, generalDiameterComments, null, false, nextToolForThisBlock);
                if (tPatterns.size > 0 || hPatterns.size > 0 || dPatterns.size > 0 || sPatterns.size > 0 || fPatterns.size > 0 || g84Patterns.size > 0 || toolDiaPatterns.size > 0 || fullDiameterPatterns.size > 0 || specialCommentDescriptions.size > 0 || generalDiameterComments.size > 0) {
                    patternsFoundOverall = true;
                }
            }

            if (!patternsFoundOverall && groupCounter === 0) {
                const noPatterns = document.createElement('p');
                noPatterns.className = 'text-gray-500';
                noPatterns.textContent = 'No T, H, D, S, F, G84, DIAMETER., or special comment patterns with values found in any group.';
                patternListDiv.appendChild(noPatterns);
            }

            fillFindReplaceWithTPatterns();
        }

        function renderGroupPatterns(groupNumber, tPatterns, hPatterns, dPatterns, sPatterns, fPatterns, g84DetailsForGroup, toolDiaPatterns, fullDiameterPatterns, specialCommentDescriptions, generalDiameterComments, nValueAssociatedWithM01, hasM01Separator, nextToolForThisGroup) {
            const groupSection = document.createElement('div');
            groupSection.className = 'group-section';

            const groupHeader = document.createElement('h3');
            groupHeader.textContent = `Tool Path ${groupNumber}`; 
            groupSection.appendChild(groupHeader);

            const patternsInGroupDiv = document.createElement('div');
            patternsInGroupDiv.className = 'pattern-list';

            let patternsFoundInGroupContent = false;

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

            // New section for general DIAMETER comments
            if (generalDiameterComments.size > 0) {
                const patternRow = document.createElement('div');
                patternRow.className = 'pattern-row';

                const labelSpan = document.createElement('span');
                labelSpan.className = 'pattern-label';
                labelSpan.textContent = 'General Diameter Comments:';
                patternRow.appendChild(labelSpan);

                const valuesDiv = document.createElement('div');
                valuesDiv.className = 'pattern-values';
                generalDiameterComments.forEach((count, comment) => {
                    patternsFoundInGroupContent = true;
                    const item = document.createElement('span');
                    item.className = 'pattern-item';
                    item.textContent = comment;
                    item.title = `Click to add '${comment}' to a Find field`;
                    item.addEventListener('click', (event) => populateNextFindField(comment, event.target));
                    valuesDiv.appendChild(item);
                });
                patternRow.appendChild(valuesDiv);
                patternsInGroupDiv.appendChild(patternRow);
            }

            if (tPatterns.size > 0) {
                const patternRow = document.createElement('div');
                patternRow.className = 'pattern-row';

                const labelSpan = document.createElement('span');
                labelSpan.className = 'pattern-label';
                labelSpan.textContent = 'T Tool:';
                patternRow.appendChild(labelSpan);

                const valuesDiv = document.createElement('div');
                valuesDiv.className = 'pattern-values';
                // Only render the first T pattern
                const firstTPattern = tPatterns.keys().next().value;
                if (firstTPattern) {
                    patternsFoundInGroupContent = true;
                    const item = document.createElement('span');
                    item.className = 'pattern-item';
                    item.textContent = firstTPattern;
                    item.title = `Click to add '${firstTPattern}' to a Find field`;
                    item.addEventListener('click', (event) => populateNextFindField(firstTPattern, event.target));
                    valuesDiv.appendChild(item);
                }
                patternRow.appendChild(valuesDiv);
                patternsInGroupDiv.appendChild(patternRow);
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
                    item.className = 'non-clickable-pattern-item';
                    item.textContent = `${pattern} (${count})`;
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
                    item.className = 'non-clickable-pattern-item';
                    item.textContent = `${pattern} (${count})`;
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

            if (!patternsFoundInGroupContent && (!nValueAssociatedWithM01 || nValueAssociatedWithM01 === 'N220') && specialCommentDescriptions.size === 0 && generalDiameterComments.size === 0) { 
                const noPatterns = document.createElement('p');
                noPatterns.className = 'text-gray-500';
                noPatterns.textContent = 'No T, H, D, S, F, G84, DIAMETER., or special comment patterns with values found in any group.';
                patternListDiv.appendChild(noPatterns);
            }

            groupSection.appendChild(patternsInGroupDiv);
            patternListDiv.appendChild(groupSection);

            if (hasM01Separator) {
                const m01Separator = document.createElement('p');
                m01Separator.className = 'text-center text-gray-600 font-bold my-4';
                m01Separator.textContent = '--- M1 ---';
                patternListDiv.appendChild(m01Separator);
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

        let activeHighlightTempDiv = null;
        let originalTextAreaInitialParent = null;

        function highlightLineAndScroll(nValue, suggestedS = 'N/A', suggestedF = 'N/A') {
            const lines = fileContentTextArea.value.split('\n');
            let lineIndex = -1;
            let lineContent = '';

            if (activeHighlightTempDiv) {
                if (activeHighlightTempDiv.parentNode && originalTextAreaInitialParent) {
                    if (!originalTextAreaInitialParent.contains(fileContentTextArea)) {
                         activeHighlightTempDiv.parentNode.replaceChild(fileContentTextArea, activeHighlightTempDiv);
                         fileContentTextArea.scrollTop = activeHighlightTempDiv.scrollTop;
                    }
                }
                activeHighlightTempDiv = null;
                clearTimeout(fileContentTextArea._highlightTimeout);
            }

            for (let i = 0; i < lines.length; i++) {
                const cleanedLine = cleanLineFromComments(lines[i]);
                const nValueRegex = new RegExp(`\\b${nValue}\\b`, 'i'); 
                if (nValueRegex.test(cleanedLine)) {
                    lineIndex = i;
                    lineContent = lines[i];
                    break;
                }
            }

            if (lineIndex !== -1) {
                if (!originalTextAreaInitialParent) {
                    originalTextAreaInitialParent = fileContentTextArea.parentNode;
                }

                const tempDiv = document.createElement('div');
                const computedStyle = window.getComputedStyle(fileContentTextArea);
                for (const prop of computedStyle) {
                    tempDiv.style[prop] = computedStyle.getPropertyValue(prop);
                }
                tempDiv.style.overflow = 'auto';
                tempDiv.style.whiteSpace = 'pre-wrap';
                tempDiv.style.wordBreak = 'break-all';
                tempDiv.style.height = fileContentTextArea.clientHeight + 'px';
                tempDiv.style.width = fileContentTextArea.clientWidth + 'px';


                const preContent = lines.slice(0, lineIndex).join('\n');
                const postContent = lines.slice(lineIndex + 1).join('\n');

                const contentHtml = document.createElement('pre');
                contentHtml.style.margin = '0';
                contentHtml.style.padding = '0';
                contentHtml.style.fontFamily = 'inherit';
                contentHtml.style.fontSize = 'inherit';
                contentHtml.style.whiteSpace = 'pre-wrap';

                const highlightedSpan = document.createElement('span');
                highlightedSpan.className = 'highlighted-line';
                highlightedSpan.textContent = lineContent;

                contentHtml.appendChild(document.createTextNode(preContent));
                if (preContent.length > 0) {
                    contentHtml.appendChild(document.createTextNode('\n'));
                }
                contentHtml.appendChild(highlightedSpan);
                if (postContent.length > 0) {
                    contentHtml.appendChild(document.createTextNode('\n'));
                }
                contentHtml.appendChild(document.createTextNode(postContent));

                tempDiv.appendChild(contentHtml);

                if (fileContentTextArea.parentNode) {
                    fileContentTextArea.parentNode.replaceChild(tempDiv, fileContentTextArea);
                    activeHighlightTempDiv = tempDiv;
                } else {
                    showMessage("Error highlighting: Internal DOM issue.", 'error');
                    return;
                }

                tempDiv.scrollTop = highlightedSpan.offsetTop - tempDiv.clientHeight / 2 + highlightedSpan.clientHeight / 2;

                showMessage(`Line ${nValue} highlighted. Suggested S: ${suggestedS}, F: ${suggestedF}.`, 'info');

                fileContentTextArea._highlightTimeout = setTimeout(() => {
                    if (activeHighlightTempDiv && activeHighlightTempDiv.parentNode) {
                        const currentScrollTop = activeHighlightTempDiv.scrollTop;
                        activeHighlightTempDiv.parentNode.replaceChild(fileContentTextArea, activeHighlightTempDiv);
                        fileContentTextArea.scrollTop = currentScrollTop;
                    }
                    activeHighlightTempDiv = null;
                    fileContentTextArea._highlightTimeout = null;
                }, 3000);
            } else {
                showMessage(`Line with N-value '${nValue}' not found.`, 'error');
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
                    fileContentTextArea.value = e.target.result;
                    showMessage('File loaded successfully!', 'success');
                    hasAppliedNextToolLogic = false;
                    applyNextToolButton.classList.remove('button-disabled');
                    applyNextToolButton.disabled = false;
                    scanAndDisplayPatterns();
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
                hasAppliedNextToolLogic = false;
                applyNextToolButton.classList.remove('button-disabled');
                applyNextToolButton.disabled = false;
                scanAndDisplayPatterns();
            }
        });

        function getBlockTools(content) {
            const lines = content.split('\n');
            const blockTools = [];
            let currentBlockContentLines = [];

            for (let i = 0; i < lines.length; i++) {
                const line = lines[i];
                const trimmedLine = line.trim();

                // Updated to check for both M1 and M01 as delimiters
                if (/\b(m1|m01)\b/.test(trimmedLine.toLowerCase())) {
                    let tMatch = null;
                    for (const blockLine of currentBlockContentLines) {
                        const cleanedBlockLine = cleanLineFromComments(blockLine);
                        const tM6Match = cleanedBlockLine.match(/(T\d+)\s*M6/i);
                        if (tM6Match) {
                            tMatch = tM6Match[1].toUpperCase();
                            break;
                        }
                    }
                    if (tMatch) {
                        blockTools.push(tMatch);
                    }
                    currentBlockContentLines = [];
                } else {
                    currentBlockContentLines.push(line);
                }
            }

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
                if (tMatch) {
                    blockTools.push(tMatch);
                }
            }
            return blockTools;
        }

        replaceButton.addEventListener('click', () => {
            clearMessageBox();
            let fullContent = fileContentTextArea.value;
            let replacementsMade = 0;
            let validationPassed = true;

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
            for (let i = 0; i < MAX_INPUT_PAIRS; i++) {
                const findValue = findInputs[i].value.trim();
                let replaceValue = replaceInputs[i].value.trim();

                if (findValue === '' && replaceValue === '') {
                    continue;
                }

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

                const pair = {
                    find: findValue,
                    replace: replaceValue,
                    effectiveReplace: effectiveReplaceValue,
                    findLabel: `Find ${i + 1}`,
                    replaceLabel: `Replace ${i + 1}`,
                    originalTNumeric: findValue.toUpperCase().startsWith('T') && /\d+/.test(findValue) ? parseInt(findValue.match(/\d+/)[0], 10) : null,
                    newTNumeric: newTNumericForPair
                };
                replacementsToApply.push(pair);
            }

            if (!validationPassed) {
                return;
            }

            let propagateNewTNumericValue = null;
            let propagationStartNValue = -1; 
            let shouldPropagateHD = false;

            let propagateNewSNumericValue = null;
            let sPropagationOriginLineN = -1;
            let propagateNewFNumericValue = null;
            let fPropagationOriginLineN = -1;

            let currentGroupToolDiaValue = null; 
            let currentGroupSNumericValue = null; 

            const lines = fullContent.split('\n');
            const newLines = [];

            const specialCommentTRegex = /\(\s*T(\d+)\s*\|[^)]*\)/i;

            lines.forEach((line, index) => { 
                let processedLine = line;
                let nMatch = line.match(/N(\d+)/i);
                let currentLineNValue = nMatch ? parseInt(nMatch[1], 10) : -1;

                // Declare these variables at the beginning of the forEach loop for each line
                let sChangedOnThisLine = false; 
                let fChangedOnThisLine = false; 
                let toolDiaChangedOnThisLine = false; 

                let sNewNumericValueForCurrentLine = null; 
                let fNewNumericValueForCurrentLine = null; 
                let toolDiaNewNumericValueForCurrentLine = null; 

                const sFormulaMatch = processedLine.match(/S\s*=\s*\(\s*(\d+\.?\d*)\s*[\*x]\s*(\d+\.?\d*)\s*\)\s*\/\s*DIAMETER/i);
                if (sFormulaMatch) {
                    sFormulaConstants = { num1: parseFloat(sFormulaMatch[1]), num2: parseFloat(sFormulaMatch[2]) };
                }

                const fFormulaMatch = processedLine.match(/F\s*=\s*S\s*[\*x]\s*(\d+\.?\d*)\s*[\*x]\s*(\d+\.?\d*)/i);
                if (fFormulaMatch) {
                    fFormulaConstants = { num1: parseFloat(fFormulaMatch[1]), num2: parseFloat(fFormulaMatch[2]) };
                }

                const originalCleanedLine = cleanLineFromComments(line);

                const isM01Line = /\b(m1|m01)\b/.test(processedLine.toLowerCase());
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
                }

                const specialCommentTMatch = line.match(specialCommentTRegex);
                if (specialCommentTMatch) {
                    propagateNewTNumericValue = specialCommentTMatch[1];
                    propagationStartNValue = currentLineNValue;
                    shouldPropagateHD = true;
                } else {
                    const tM6OnOriginalLineMatch = originalCleanedLine.match(/(T(\d+))\s*M6/i);
                    if (tM6OnOriginalLineMatch) {
                        if (propagateNewTNumericValue === null) {
                            tValueFoundOnM6Line = true;
                            tNumericValueFromM6Line = tM6OnOriginalLineMatch[2];
                            propagateNewTNumericValue = tNumericValueFromM6Line;
                            propagationStartNValue = currentLineNValue;
                            shouldPropagateHD = true;
                        }
                    }
                }

                replacementsToApply.forEach(pair => {
                    const findValue = pair.find;
                    const effectiveReplaceValue = pair.effectiveReplace.toUpperCase();
                    const escapedFindValue = findValue.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
                    const regex = new RegExp(escapedFindValue, 'gi');

                    if (findValue.toUpperCase().startsWith('T') && /\d+/.test(findValue)) {
                        if (regex.test(processedLine)) {
                            propagateNewTNumericValue = String(pair.newTNumeric); 
                            tChangedByDirectReplaceOnThisLine = true; 
                        }
                    }

                    if (findValue.toUpperCase().startsWith('S') && /\d+\.?\d*/.test(findValue) && /\d+\.?\d*/.test(effectiveReplaceValue)) {
                        const originalSNumeric = parseFloat(findValue.match(/\d+\.?\d*/)[0]);
                        const newSNumeric = parseFloat(effectiveReplaceValue.match(/\d+\.?\d*/)[0]);
                        if (regex.test(processedLine) && originalSNumeric !== newSNumeric) {
                            sChangedOnThisLine = true;
                            sNewNumericValueForCurrentLine = newSNumeric;
                        }
                    }

                    if (findValue.toUpperCase().startsWith('F') && /\d+\.?\d*/.test(findValue) && /\d+\.?\d*/.test(effectiveReplaceValue)) {
                        const originalFNumeric = parseFloat(findValue.match(/\d+\.?\d*/)[0]);
                        const newFNumeric = parseFloat(effectiveReplaceValue.match(/\d+\.?\d*/)[0]);
                        if (regex.test(processedLine) && originalFNumeric !== newFNumeric) {
                            fChangedOnThisLine = true;
                            fNewNumericValueForCurrentLine = newFNumeric;
                        }
                    }

                    if (toolDiaPatternRegex.test(findValue) && toolDiaPatternRegex.test(effectiveReplaceValue)) {
                        const newToolDiaMatch = effectiveReplaceValue.match(/([+\-]?\d*\.?\d+)$/i);
                        if (newToolDiaMatch) {
                            const newToolDiaValue = parseFloat(newToolDiaMatch[1]);
                            if (regex.test(processedLine)) { 
                                toolDiaChangedOnThisLine = true;
                                toolDiaNewNumericValueForCurrentLine = newToolDiaValue;
                            }
                        }
                    }

                    processedLine = processedLine.replace(regex, (match) => {
                        replacementsMade++;
                        return effectiveReplaceValue;
                    });
                });

                const toolDiaMatchOnProcessedLine = processedLine.match(/DIAMETER\.?\s*[=\-]?\s*([+\-]?\d*\.?\d+)/i);
                if (toolDiaMatchOnProcessedLine) {
                    currentGroupToolDiaValue = parseFloat(toolDiaMatchOnProcessedLine[1]);
                }

                const sMatchOnProcessedLineForContext = processedLine.match(/S(\d+\.?\d*)/i);
                if (sMatchOnProcessedLineForContext) {
                    currentGroupSNumericValue = parseFloat(sMatchOnProcessedLineForContext[1]);
                }

                if (sChangedOnThisLine) {
                    propagateNewSNumericValue = sNewNumericValueForCurrentLine;
                    sPropagationOriginLineN = currentLineNValue;
                }
                if (fChangedOnThisLine) {
                    propagateNewFNumericValue = fNewNumericValueForCurrentLine;
                    fPropagationOriginLineN = currentLineNValue;
                }

                let calculatedSNumericFromToolDia = null;
                if (currentGroupToolDiaValue !== null && !isNaN(currentGroupToolDiaValue) && currentGroupToolDiaValue !== 0) {
                    calculatedSNumericFromToolDia = Math.round((sFormulaConstants.num1 * sFormulaConstants.num2) / currentGroupToolDiaValue);
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
                                return 'S' + newSNumericToApply;
                            }
                        }
                        return match;
                    });

                    const sMatchAfterSUpdate = processedLine.match(/S(\d+\.?\d*)/i);
                    if (sMatchAfterSUpdate) {
                        currentGroupSNumericValue = parseFloat(sMatchAfterSUpdate[1]);
                    }
                }

                let calculatedFNumericFromS = null;
                if (currentGroupSNumericValue !== null && !isNaN(currentGroupSNumericValue) && currentGroupToolDiaValue !== null && !isNaN(currentGroupToolDiaValue) && currentGroupToolDiaValue !== 0) {
                    calculatedFNumericFromS = currentGroupSNumericValue * fFormulaConstants.num1 * fFormulaConstants.num2;
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
                                return 'F' + newFNumericToApply.toFixed(3);
                            }
                        }
                        return match;
                    });
                }

                if (shouldPropagateHD && propagateNewTNumericValue !== null && currentLineNValue >= propagationStartNValue && propagationStartNValue !== -1) {
                    const targetNumericValue = parseInt(propagateNewTNumericValue, 10);

                    const regexH = /H(\d+)/gi;
                    processedLine = processedLine.replace(regexH, (match, p1) => {
                        const oldHNumericValue = parseInt(p1, 10);
                        if (oldHNumericValue !== targetNumericValue) { 
                            replacementsMade++;
                            return 'H' + propagateNewTNumericValue; 
                        }
                        return match;
                    });

                    const regexD = /D(\d+)/gi;
                    processedLine = processedLine.replace(regexD, (match, p1) => {
                        const oldDNumericValue = parseInt(p1, 10);
                        if (oldDNumericValue !== targetNumericValue) { 
                            replacementsMade++;
                            return 'D' + propagateNewTNumericValue; 
                        }
                        return match;
                    });
                }
                newLines.push(processedLine);
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

        // Refined function to parse the file into tool blocks with detailed info
        function parseToolBlocksDetailed(content) {
            const lines = content.split('\n');
            const blocks = [];
            let currentBlock = {
                lines: [],
                tM6LineIndexInBlock: -1, // Index of T#M6 line within currentBlock.lines
                toolChangeCommentIndexInBlock: -1, // Index of (TOOL CHANGE, TOOL #) within currentBlock.lines
                actualTool: null, // T# from T#M6
                nextToolValue: null // Calculated next tool
            };

            for (let i = 0; i < lines.length; i++) {
                const line = lines[i];
                const trimmedLine = line.trim();

                // Updated to check for both M1 and M01 as delimiters
                if (/\b(m1|m01)\b/.test(trimmedLine.toLowerCase()) && currentBlock.lines.length > 0) {
                    blocks.push({ ...currentBlock }); // Push a copy
                    currentBlock = { lines: [], tM6LineIndexInBlock: -1, toolChangeCommentIndexInBlock: -1, actualTool: null, nextToolValue: null };
                }

                // Add line to current block
                currentBlock.lines.push(line);

                // Check for T#M6 line
                const tM6Match = trimmedLine.match(/(T\d+)\s*M6/i);
                if (tM6Match) {
                    currentBlock.tM6LineIndexInBlock = currentBlock.lines.length - 1;
                    currentBlock.actualTool = tM6Match[1].toUpperCase();
                }

                // Check for ( TOOL CHANGE, TOOL T# ) comment line
                const toolChangeCommentMatch = trimmedLine.match(/^\(\s*TOOL CHANGE,\s*TOOL\s*(T\d+|#\d+)\s*\)/i);
                if (toolChangeCommentMatch) {
                    currentBlock.toolChangeCommentIndexInBlock = currentBlock.lines.length - 1;
                }
            }
            // Add the last block if it exists
            if (currentBlock.lines.length > 0) {
                blocks.push({ ...currentBlock });
            }
            return blocks;
        }

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

            // Parse blocks with detailed info
            let blocks = parseToolBlocksDetailed(fileContentTextArea.value);

            // Determine nextToolValue for each block
            const allToolsInOrder = [];
            blocks.forEach(block => {
                if (block.actualTool) {
                    allToolsInOrder.push(block.actualTool);
                }
            });

            for (let i = 0; i < blocks.length; i++) {
                const block = blocks[i];
                if (block.actualTool) {
                    const currentToolIndex = allToolsInOrder.indexOf(block.actualTool);
                    if (currentToolIndex !== -1 && currentToolIndex < allToolsInOrder.length - 1) {
                        block.nextToolValue = allToolsInOrder[currentToolIndex + 1];
                    } else {
                        block.nextToolValue = null; // Last tool, no next tool
                    }
                }
            }

            const finalLines = [];
            let changesMade = 0;

            blocks.forEach(block => {
                let tM6LineEncountered = false;
                let nakedTInsertedForBlock = false;

                block.lines.forEach((line, lineIndexInBlock) => {
                    const trimmedLine = line.trim();

                    // Handle existing tool change comment
                    if (lineIndexInBlock === block.toolChangeCommentIndexInBlock) {
                        if (block.nextToolValue) {
                            finalLines.push(`( TOOL CHANGE, TOOL ${block.nextToolValue} )`);
                            changesMade++;
                        } else {
                            // If it's the last tool, or no next tool, keep the original comment
                            finalLines.push(line);
                        }
                    } else {
                        finalLines.push(line); // Add the original line
                    }

                    // Check if the current line is the T#M6 line
                    if (lineIndexInBlock === block.tM6LineIndexInBlock) {
                        tM6LineEncountered = true;
                    }

                    // Insert naked T line after T#M6 if it hasn't been inserted for this block yet
                    // and if we've passed the T#M6 line, and there's a next tool
                    if (tM6LineEncountered && block.nextToolValue && !nakedTInsertedForBlock && lineIndexInBlock === block.tM6LineIndexInBlock) {
                        // Check if the next line in the original block is already the naked T-line
                        const nextLineInOriginalBlock = block.lines[lineIndexInBlock + 1];
                        if (!nextLineInOriginalBlock || nextLineInOriginalBlock.trim().toUpperCase() !== block.nextToolValue.toUpperCase()) {
                             finalLines.push(` ${block.nextToolValue}`);
                             changesMade++;
                        }
                        nakedTInsertedForBlock = true;
                    }
                });
            });

            // Re-index N values in finalLines
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

            fileContentTextArea.value = reIndexedLines.join('\n');

            if (changesMade > 0) {
                showMessage(`${changesMade} 'Next Tool' lines inserted/updated and N values re-indexed!`, 'success');
                hasAppliedNextToolLogic = true;
                applyNextToolButton.classList.add('button-disabled');
                applyNextToolButton.disabled = true;
            } else {
                showMessage('No "Next Tool" changes were needed or found.', 'info');
            }
            scanAndDisplayPatterns(); 
        });

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
            hasAppliedNextToolLogic = false;
            applyNextToolButton.classList.remove('button-disabled');
            applyNextToolButton.disabled = false;
            scanAndDisplayPatterns(); 
            currentFindInputIndex = 0;
        });

        fileContentTextArea.addEventListener('input', () => {
            scanAndDisplayPatterns(); 
        });

        window.addEventListener('load', () => {
            createInputPairs();
            sFormulaInput.value = `S = (${sFormulaConstants.num1} * ${sFormulaConstants.num2}) / DIAMETER`;
            fFormulaInput.value = `F = S * ${fFormulaConstants.num1} * ${fFormulaConstants.num2}`;
            scanAndDisplayPatterns(); 
        });
    </script>
</body>
</html>




=
O100( 41363.TAP )
( FORMAT: FANUC 11M [EMS] CJ08.16.7.PST )
( 11/24/2014 AT  8:11 AM )
N1 G0G28G61G91G99Z0.
N6 G49
( TOOL CHANGE, TOOL #2 )
( DIAMETER = .25 ROUGH ENDMILL )
( ROD STOP )
( OPERATION 1: HOLES )
( CS#2 - G54 )
N3T1M6
N4G0G17G54G61G90X-.64Y0.
N5G43Z1.H1
N6Z.05
N7Z-.05
N8M0
N9G0Z.05
N10M9
N11G0G28G91Z0.M5
N12G49
N13M01
( TOOL CHANGE, TOOL #4 )
( DIAMETER = .25 SPOT DRILL )
( OPERATION 2: HOLES )
( CS#2 - G54 )
N11 T2M06
N16 S60022M3
N21 G0G17G54G61G90X.14Y-4.78M8
N26 G43Z1.H2
N31 Z.05
N36 G83G99R.05Z-.0582Q.04F30.
N41 M98P101
N46 G80Z.05
( OPERATION 3: HOLES )
( CS#2 - G54 )
N51 G0G90X1.02Y-.19
N56 G83G99R.05Z-.0895Q.04F30.
N61 M98P102
N66 G80Z.05
N71 M9
N76 G0G28G91Z0.M5
N81 G49
N86 M01
( TOOL CHANGE, TOOL #8 )
( DIAMETER = .1065 DRILL )
( OPERATION 4: HOLES )
( CS#2 - G54 )
N91 T3M06
N96 S10000M3
N101 G0G17G54G61G90X.14Y-4.78M8
N106 G43Z1.H3
N111 Z.05
N116 G83G99R.05Z-.1207Q.1274F20.
N121 M98P101
N126 G80Z.05
N131 M9
N136 G0G28G91Z0.M5
N141 G49
N146 M01
( TOOL CHANGE, TOOL #484 )
( DIAMETER = .1695 DRILL )
( OPERATION 5: HOLES )
( CS#2 - G54 )
N151 T284M06
N156 S7000M3
N161 G0G17G54G61G90X1.02Y-.19M8
N166 G43Z1.H284
N171 Z.05
N176 G83G99R.05Z-.1439Q.2038F52.
N181 M98P102
N186 G80Z.05
N191 M9
N196 G0G28G91Z0.M5
N201 G49
N206 M01
( TOOL CHANGE, TOOL #585 )
( DIAMETER = .125 ROUGH ENDMILL )
( OPERATION 6: ROUGHING )
( CS#2 - G54 )
N211 T5M06
N216 S2222M3
N221 G0G17G54G61G90X1.5512Y.135M8
N226 G43Z1.H5
N231 Z.05
N236 G1Z-.055F18.
N241 Y.065
N246 X1.3588F89.
N251 X1.455Y-.0312
N256 X1.4249Y-.0612
N261 G41D5X1.4108Y-.0753
N266 X1.4277Y-.0923
N271 G2X1.4475Y-.14I-.0477J-.0477
N276 G1Y-1.24
N281 G2X1.4277Y-1.2877I-.0675
N286 G1X1.4108Y-1.3047
N291 X1.3896Y-1.3259
N296 G40X1.4037Y-1.34
N301 X1.455Y-1.3488
N306 X1.4108Y-1.393
N311 X1.455Y-1.4372
N316 X1.4372Y-1.455
N321 X1.455Y-1.4728
N326 X1.4728Y-1.455
N331 X1.455Y-1.4372
N336 X1.4108Y-1.393
N341 X1.3488Y-1.455
N346 X1.455Y-1.5612
N351 X1.5612Y-1.455
N356 X1.455Y-1.3488
N361 X1.4851Y-1.3188
N366 G41X1.4992Y-1.3047
N371 X1.4823Y-1.2877
N376 G2X1.4625Y-1.24I.0477J.0477
N381 G1Y-.14
N386 G2X1.4823Y-.0923I.0675
N391 G1X1.6223Y.0477
N396 G2X1.67Y.0675I.0477J-.0477
N401 G1X2.77
N406 G2X2.8177Y.0477J-.0675
N411 G1X2.8447Y.0208
N416 X2.8659Y-.0004
N421 G40X2.88Y.0137
N426 X2.8888Y.065
N431 X2.985Y-.0312
N436 X3.0812Y.065
N441 X2.8888
N446 X2.8588Y.0349
N451 G41X2.8447Y.0208
N456 X2.9577Y-.0923
N461 G2X2.9775Y-.14I-.0477J-.0477
N466 G1Y-1.24
N471 G2X2.9577Y-1.2877I-.0675
N476 G1X2.9408Y-1.3047
N481 X2.9196Y-1.3259
N486 G40X2.9337Y-1.34
N491 X2.985Y-1.3488
N496 X2.9408Y-1.393
N501 X2.985Y-1.4372
N506 X2.9672Y-1.455
N511 X2.985Y-1.4728
N516 X3.0028Y-1.455
N521 X2.985Y-1.4372
N526 X2.9408Y-1.393
N531 X2.8788Y-1.455
N536 X2.985Y-1.5612
N541 X3.0912Y-1.455
N546 X2.985Y-1.3488
N551 X3.0151Y-1.3188
N556 G41X3.0292Y-1.3047
N561 X3.0123Y-1.2877
N566 G2X2.9925Y-1.24I.0477J.0477
N571 G1Y-.14
N576 G2X3.0123Y-.0923I.0675
N581 G1X3.1523Y.0477
N586 G2X3.2Y.0675I.0477J-.0477
N591 G1X4.3
N596 G2X4.3477Y.0477J-.0675
N601 G1X4.3747Y.0208
N606 X4.3959Y-.0004
N611 G40X4.41Y.0137
N616 X4.4188Y.065
N621 X4.515Y-.0312
N626 X4.6112Y.065
N631 X4.4188
N636 X4.3888Y.0349
N641 G41X4.3747Y.0208
N646 X4.4877Y-.0923
N651 G2X4.5075Y-.14I-.0477J-.0477
N656 G1Y-1.24
N661 G2X4.4877Y-1.2877I-.0675
N666 G1X4.4708Y-1.3047
N671 X4.4496Y-1.3259
N676 G40X4.4637Y-1.34
N681 X4.515Y-1.3488
N686 X4.4708Y-1.393
N691 X4.515Y-1.4372
N696 X4.4972Y-1.455
N701 X4.515Y-1.4728
N706 X4.5328Y-1.455
N711 X4.515Y-1.4372
N716 X4.4708Y-1.393
N721 X4.4088Y-1.455
N726 X4.515Y-1.5612
N731 X4.4849Y-1.5912
N736 G41X4.4708Y-1.6053
N741 X4.4877Y-1.6223
N746 G2X4.5075Y-1.67I-.0477J-.0477
N751 G1Y-2.77
N756 G2X4.4877Y-2.8177I-.0675
N761 G1X4.3477Y-2.9577
N766 G2X4.3Y-2.9775I-.0477J.0477
N771 G1X3.2
N776 G2X3.1523Y-2.9577J.0675
N781 G1X3.0123Y-2.8177
N786 G2X2.9925Y-2.77I.0477J.0477
N791 G1Y-1.67
N796 G2X3.0123Y-1.6223I.0675
N801 G1X3.1523Y-1.4823
N806 G2X3.2Y-1.4625I.0477J-.0477
N811 G1X4.3
N816 G2X4.3477Y-1.4823J-.0675
N821 G1X4.4708Y-1.6053
N826 X4.4877Y-1.6223
N831 G2X4.4918Y-1.6267I-.0477J-.0477
N836 G40G1X4.5072Y-1.6139
N841 X4.515Y-1.5612
N846 X4.6212Y-1.455
N851 X4.515Y-1.3488
N856 X4.5451Y-1.3188
N861 G41X4.5592Y-1.3047
N866 X4.5423Y-1.2877
N871 G2X4.5225Y-1.24I.0477J.0477
N876 G1Y-.14
N881 G2X4.5423Y-.0923I.0675
N886 G1X4.6823Y.0477
N891 G2X4.73Y.0675I.0477J-.0477
N896 G1X5.83
N901 G2X5.8777Y.0477J-.0675
N906 G1X5.9047Y.0208
N911 X5.9259Y-.0004
N916 G40X5.94Y.0137
N921 X5.9488Y.065
N926 X6.035Y-.0212
N931 Y.065
N936 X5.9488
N941 X5.9188Y.0349
N946 G41X5.9047Y.0208
N951 X6.0177Y-.0923
N956 G2X6.0375Y-.14I-.0477J-.0477
N961 G1Y-1.24
N966 G2X6.0177Y-1.2877I-.0675
N971 G1X5.9908Y-1.3147
N976 X5.9696Y-1.3359
N981 G40X5.9837Y-1.35
N986 X6.035Y-1.3588
N991 X5.9388Y-1.455
N996 X6.035Y-1.5512
N1001 X6.0049Y-1.5812
N1006 G41X5.9908Y-1.5953
N1011 X6.0177Y-1.6223
N1016 G2X6.0375Y-1.67I-.0477J-.0477
N1021 G1Y-2.77
N1026 G2X6.0177Y-2.8177I-.0675
N1031 G1X5.8777Y-2.9577
N1036 G2X5.83Y-2.9775I-.0477J.0477
N1041 G1X4.73
N1046 G2X4.6823Y-2.9577J.0675
N1051 G1X4.5423Y-2.8177
N1056 G2X4.5225Y-2.77I.0477J.0477
N1061 G1Y-1.67
N1066 G2X4.5423Y-1.6223I.0675
N1071 G1X4.6823Y-1.4823
N1076 G2X4.73Y-1.4625I.0477J-.0477
N1081 G1X5.83
N1086 G2X5.8777Y-1.4823J-.0675
N1091 G1X5.9908Y-1.5953
N1096 X6.012Y-1.6166
N1101 G40X6.0262Y-1.6024
N1106 X6.035Y-1.5512
N1111 Y-1.3588
N1116 X6.0049Y-1.3288
N1121 G41X5.9908Y-1.3147
N1126 X5.8777Y-1.4277
N1131 G2X5.83Y-1.4475I-.0477J.0477
N1136 G1X4.73
N1141 G2X4.6823Y-1.4277J.0675
N1146 G1X4.5592Y-1.3047
N1151 X4.5423Y-1.2877
N1156 G2X4.5382Y-1.2833I.0477J.0477
N1161 G40G1X4.5228Y-1.2961
N1166 X4.515Y-1.3488
N1171 X4.4849Y-1.3188
N1176 G41X4.4708Y-1.3047
N1181 X4.3477Y-1.4277
N1186 G2X4.3Y-1.4475I-.0477J.0477
N1191 G1X3.2
N1196 G2X3.1523Y-1.4277J.0675
N1201 G1X3.0292Y-1.3047
N1206 X3.0123Y-1.2877
N1211 G2X3.0082Y-1.2833I.0477J.0477
N1216 G40G1X2.9928Y-1.2961
N1221 X2.985Y-1.3488
N1226 X2.9549Y-1.3188
N1231 G41X2.9408Y-1.3047
N1236 X2.8177Y-1.4277
N1241 G2X2.77Y-1.4475I-.0477J.0477
N1246 G1X1.67
N1251 G2X1.6223Y-1.4277J.0675
N1256 G1X1.4992Y-1.3047
N1261 X1.4823Y-1.2877
N1266 G2X1.4782Y-1.2833I.0477J.0477
N1271 G40G1X1.4628Y-1.2961
N1276 X1.455Y-1.3488
N1281 X1.4249Y-1.3188
N1286 G41X1.4108Y-1.3047
N1291 X1.2877Y-1.4277
N1296 G2X1.24Y-1.4475I-.0477J.0477
N1301 G1X.14
N1306 G2X.0923Y-1.4277J.0675
N1311 G1X.0753Y-1.4108
N1316 X.0541Y-1.3896
N1321 G40X.04Y-1.4037
N1326 X.0312Y-1.455
N1331 X-.065Y-1.3588
N1336 Y-1.5512
N1341 X.0312Y-1.455
N1346 X.0612Y-1.4851
N1351 G41X.0753Y-1.4992
N1356 X.0923Y-1.4823
N1361 G2X.14Y-1.4625I.0477J-.0477
N1366 G1X1.24
N1371 G2X1.2877Y-1.4823J-.0675
N1376 G1X1.4277Y-1.6223
N1381 G2X1.4475Y-1.67I-.0477J-.0477
N1386 G1Y-2.77
N1391 G2X1.4277Y-2.8177I-.0675
N1396 G1X1.4108Y-2.8347
N1401 X1.3896Y-2.8559
N1406 G40X1.4037Y-2.87
N1411 X1.455Y-2.8788
N1416 X1.4108Y-2.923
N1421 X1.455Y-2.9672
N1426 X1.4372Y-2.985
N1431 X1.455Y-3.0028
N1436 X1.4728Y-2.985
N1441 X1.455Y-2.9672
N1446 X1.4108Y-2.923
N1451 X1.3488Y-2.985
N1456 X1.455Y-3.0912
N1461 X1.5612Y-2.985
N1466 X1.455Y-2.8788
N1471 X1.4249Y-2.8488
N1476 G41X1.4108Y-2.8347
N1481 X1.2877Y-2.9577
N1486 G2X1.24Y-2.9775I-.0477J.0477
N1491 G1X.14
N1496 G2X.0923Y-2.9577J.0675
N1501 G1X.0753Y-2.9408
N1506 X.0541Y-2.9196
N1511 G40X.04Y-2.9337
N1516 X.0312Y-2.985
N1521 X-.065Y-2.8888
N1526 Y-3.0812
N1531 X.0312Y-2.985
N1536 X.0612Y-3.0151
N1541 G41X.0753Y-3.0292
N1546 X.0923Y-3.0123
N1551 G2X.14Y-2.9925I.0477J-.0477
N1556 G1X1.24
N1561 G2X1.2877Y-3.0123J-.0675
N1566 G1X1.4277Y-3.1523
N1571 G2X1.4475Y-3.2I-.0477J-.0477
N1576 G1Y-4.3
N1581 G2X1.4277Y-4.3477I-.0675
N1586 G1X1.4108Y-4.3647
N1591 X1.3896Y-4.3859
N1596 G40X1.4037Y-4.4
N1601 X1.455Y-4.4088
N1606 X1.4108Y-4.453
N1611 X1.455Y-4.4972
N1616 X1.4372Y-4.515
N1621 X1.455Y-4.5328
N1626 X1.4728Y-4.515
N1631 X1.455Y-4.4972
N1636 X1.4108Y-4.453
N1641 X1.3488Y-4.515
N1646 X1.455Y-4.6212
N1651 X1.5612Y-4.515
N1656 X1.5912Y-4.5451
N1661 G41X1.6053Y-4.5592
N1666 X1.6223Y-4.5423
N1671 G2X1.67Y-4.5225I.0477J-.0477
N1676 G1X2.77
N1681 G2X2.8177Y-4.5423J-.0675
N1686 G1X2.8347Y-4.5592
N1691 X2.8559Y-4.5804
N1696 G40X2.87Y-4.5663
N1701 X2.8788Y-4.515
N1706 X2.923Y-4.5592
N1711 X2.9672Y-4.515
N1716 X2.985Y-4.5328
N1721 X3.0028Y-4.515
N1726 X2.985Y-4.4972
N1731 X2.9672Y-4.515
N1736 X2.923Y-4.5592
N1741 X2.985Y-4.6212
N1746 X3.0912Y-4.515
N1751 X2.985Y-4.4088
N1756 X3.0151Y-4.3788
N1761 G41X3.0292Y-4.3647
N1766 X3.0123Y-4.3477
N1771 G2X2.9925Y-4.3I.0477J.0477
N1776 G1Y-3.2
N1781 G2X3.0123Y-3.1523I.0675
N1786 G1X3.0292Y-3.1353
N1791 X3.0504Y-3.1141
N1796 G40X3.0363Y-3.1
N1801 X2.985Y-3.0912
N1806 X3.0292Y-3.047
N1811 X2.985Y-3.0028
N1816 X3.0028Y-2.985
N1821 X2.985Y-2.9672
N1826 X2.9672Y-2.985
N1831 X2.985Y-3.0028
N1836 X3.0292Y-3.047
N1841 X3.0912Y-2.985
N1846 X2.985Y-2.8788
N1851 X2.8788Y-2.985
N1856 X2.8488Y-2.9549
N1861 G41X2.8347Y-2.9408
N1866 X2.8177Y-2.9577
N1871 G2X2.77Y-2.9775I-.0477J.0477
N1876 G1X1.67
N1881 G2X1.6223Y-2.9577J.0675
N1886 G1X1.4823Y-2.8177
N1891 G2X1.4625Y-2.77I.0477J.0477
N1896 G1Y-1.67
N1901 G2X1.4823Y-1.6223I.0675
N1906 G1X1.6223Y-1.4823
N1911 G2X1.67Y-1.4625I.0477J-.0477
N1916 G1X2.77
N1921 G2X2.8177Y-1.4823J-.0675
N1926 G1X2.9577Y-1.6223
N1931 G2X2.9775Y-1.67I-.0477J-.0477
N1936 G1Y-2.77
N1941 G2X2.9577Y-2.8177I-.0675
N1946 G1X2.8347Y-2.9408
N1951 X2.8177Y-2.9577
N1956 G2X2.8133Y-2.9618I-.0477J.0477
N1961 G40G1X2.8261Y-2.9772
N1966 X2.8788Y-2.985
N1971 X2.985Y-3.0912
N1976 X2.9549Y-3.1212
N1981 G41X2.9408Y-3.1353
N1986 X2.9577Y-3.1523
N1991 G2X2.9775Y-3.2I-.0477J-.0477
N1996 G1Y-4.3
N2001 G2X2.9577Y-4.3477I-.0675
N2006 G1X2.8177Y-4.4877
N2011 G2X2.77Y-4.5075I-.0477J.0477
N2016 G1X1.67
N2021 G2X1.6223Y-4.4877J.0675
N2026 G1X1.4823Y-4.3477
N2031 G2X1.4625Y-4.3I.0477J.0477
N2036 G1Y-3.2
N2041 G2X1.4823Y-3.1523I.0675
N2046 G1X1.6223Y-3.0123
N2051 G2X1.67Y-2.9925I.0477J-.0477
N2056 G1X2.77
N2061 G2X2.8177Y-3.0123J-.0675
N2066 G1X2.9408Y-3.1353
N2071 X2.9577Y-3.1523
N2076 G2X2.9618Y-3.1567I-.0477J-.0477
N2081 G40G1X2.9772Y-3.1439
N2086 X2.985Y-3.0912
N2091 X3.0151Y-3.1212
N2096 G41X3.0292Y-3.1353
N2101 X3.1523Y-3.0123
N2106 G2X3.2Y-2.9925I.0477J-.0477
N2111 G1X4.3
N2116 G2X4.3477Y-3.0123J-.0675
N2121 G1X4.3647Y-3.0292
N2126 X4.3859Y-3.0504
N2131 G40X4.4Y-3.0363
N2136 X4.4088Y-2.985
N2141 X4.453Y-3.0292
N2146 X4.4972Y-2.985
N2151 X4.515Y-3.0028
N2156 X4.5328Y-2.985
N2161 X4.515Y-2.9672
N2166 X4.4972Y-2.985
N2171 X4.453Y-3.0292
N2176 X4.515Y-3.0912
N2181 X4.6212Y-2.985
N2186 X4.515Y-2.8788
N2191 X4.4088Y-2.985
N2196 X4.3788Y-3.0151
N2201 G41X4.3647Y-3.0292
N2206 X4.4877Y-3.1523
N2211 G2X4.5075Y-3.2I-.0477J-.0477
N2216 G1Y-4.3
N2221 G2X4.4877Y-4.3477I-.0675
N2226 G1X4.4708Y-4.3647
N2231 X4.4496Y-4.3859
N2236 G40X4.4637Y-4.4
N2241 X4.515Y-4.4088
N2246 X4.4708Y-4.453
N2251 X4.515Y-4.4972
N2256 X4.4972Y-4.515
N2261 X4.515Y-4.5328
N2266 X4.5328Y-4.515
N2271 X4.515Y-4.4972
N2276 X4.4708Y-4.453
N2281 X4.4088Y-4.515
N2286 X4.515Y-4.6212
N2291 X4.4849Y-4.6512
N2296 G41X4.4708Y-4.6653
N2301 X4.4877Y-4.6823
N2306 G2X4.5075Y-4.73I-.0477J-.0477
N2311 G1Y-5.83
N2316 G2X4.4877Y-5.8777I-.0675
N2321 G1X4.4708Y-5.8947
N2326 X4.4496Y-5.9159
N2331 G40X4.4637Y-5.93
N2336 X4.515Y-5.9388
N2341 X4.4188Y-6.035
N2346 X4.6112
N2351 X4.515Y-5.9388
N2356 X4.4849Y-5.9088
N2361 G41X4.4708Y-5.8947
N2366 X4.3477Y-6.0177
N2371 G2X4.3Y-6.0375I-.0477J.0477
N2376 G1X3.2
N2381 G2X3.1523Y-6.0177J.0675
N2386 G1X3.0123Y-5.8777
N2391 G2X2.9925Y-5.83I.0477J.0477
N2396 G1Y-4.73
N2401 G2X3.0123Y-4.6823I.0675
N2406 G1X3.1523Y-4.5423
N2411 G2X3.2Y-4.5225I.0477J-.0477
N2416 G1X4.3
N2421 G2X4.3477Y-4.5423J-.0675
N2426 G1X4.4708Y-4.6653
N2431 X4.4877Y-4.6823
N2436 G2X4.4918Y-4.6867I-.0477J-.0477
N2441 G40G1X4.5072Y-4.6739
N2446 X4.515Y-4.6212
N2451 X4.6212Y-4.515
N2456 X4.515Y-4.4088
N2461 X4.5451Y-4.3788
N2466 G41X4.5592Y-4.3647
N2471 X4.5423Y-4.3477
N2476 G2X4.5225Y-4.3I.0477J.0477
N2481 G1Y-3.2
N2486 G2X4.5423Y-3.1523I.0675
N2491 G1X4.6823Y-3.0123
N2496 G2X4.73Y-2.9925I.0477J-.0477
N2501 G1X5.83
N2506 G2X5.8777Y-3.0123J-.0675
N2511 G1X5.8947Y-3.0292
N2516 X5.9159Y-3.0504
N2521 G40X5.93Y-3.0363
N2526 X5.9388Y-2.985
N2531 X6.035Y-3.0812
N2536 Y-2.8888
N2541 X5.9388Y-2.985
N2546 X5.9088Y-3.0151
N2551 G41X5.8947Y-3.0292
N2556 X6.0177Y-3.1523
N2561 G2X6.0375Y-3.2I-.0477J-.0477
N2566 G1Y-4.3
N2571 G2X6.0177Y-4.3477I-.0675
N2576 G1X5.9908Y-4.3747
N2581 X5.9696Y-4.3959
N2586 G40X5.9837Y-4.41
N2591 X6.035Y-4.4188
N2596 X5.9388Y-4.515
N2601 X6.035Y-4.6112
N2606 X6.0049Y-4.6412
N2611 G41X5.9908Y-4.6553
N2616 X6.0177Y-4.6823
N2621 G2X6.0375Y-4.73I-.0477J-.0477
N2626 G1Y-5.83
N2631 G2X6.0177Y-5.8777I-.0675
N2636 G1X5.9908Y-5.9047
N2641 X5.9696Y-5.9259
N2646 G40X5.9837Y-5.94
N2651 X6.035Y-5.9488
N2656 X5.9488Y-6.035
N2661 X6.035
N2666 Y-5.9488
N2671 X6.0049Y-5.9188
N2676 G41X5.9908Y-5.9047
N2681 X5.8777Y-6.0177
N2686 G2X5.83Y-6.0375I-.0477J.0477
N2691 G1X4.73
N2696 G2X4.6823Y-6.0177J.0675
N2701 G1X4.5423Y-5.8777
N2706 G2X4.5225Y-5.83I.0477J.0477
N2711 G1Y-4.73
N2716 G2X4.5423Y-4.6823I.0675
N2721 G1X4.6823Y-4.5423
N2726 G2X4.73Y-4.5225I.0477J-.0477
N2731 G1X5.83
N2736 G2X5.8777Y-4.5423J-.0675
N2741 G1X5.9908Y-4.6553
N2746 X6.012Y-4.6766
N2751 G40X6.0262Y-4.6624
N2756 X6.035Y-4.6112
N2761 Y-4.4188
N2766 X6.0049Y-4.3888
N2771 G41X5.9908Y-4.3747
N2776 X5.8777Y-4.4877
N2781 G2X5.83Y-4.5075I-.0477J.0477
N2786 G1X4.73
N2791 G2X4.6823Y-4.4877J.0675
N2796 G1X4.5592Y-4.3647
N2801 X4.5423Y-4.3477
N2806 G2X4.5382Y-4.3433I.0477J.0477
N2811 G40G1X4.5228Y-4.3561
N2816 X4.515Y-4.4088
N2821 X4.4849Y-4.3788
N2826 G41X4.4708Y-4.3647
N2831 X4.3477Y-4.4877
N2836 G2X4.3Y-4.5075I-.0477J.0477
N2841 G1X3.2
N2846 G2X3.1523Y-4.4877J.0675
N2851 G1X3.0292Y-4.3647
N2856 X3.0123Y-4.3477
N2861 G2X3.0082Y-4.3433I.0477J.0477
N2866 G40G1X2.9928Y-4.3561
N2871 X2.985Y-4.4088
N2876 X2.8788Y-4.515
N2881 X2.8488Y-4.5451
N2886 G41X2.8347Y-4.5592
N2891 X2.9577Y-4.6823
N2896 G2X2.9775Y-4.73I-.0477J-.0477
N2901 G1Y-5.83
N2906 G2X2.9577Y-5.8777I-.0675
N2911 G1X2.9408Y-5.8947
N2916 X2.9196Y-5.9159
N2921 G40X2.9337Y-5.93
N2926 X2.985Y-5.9388
N2931 X2.8888Y-6.035
N2936 X3.0812
N2941 X2.985Y-5.9388
N2946 X2.9549Y-5.9088
N2951 G41X2.9408Y-5.8947
N2956 X2.8177Y-6.0177
N2961 G2X2.77Y-6.0375I-.0477J.0477
N2966 G1X1.67
N2971 G2X1.6223Y-6.0177J.0675
N2976 G1X1.5953Y-5.9908
N2981 X1.5741Y-5.9696
N2986 G40X1.56Y-5.9837
N2991 X1.5512Y-6.035
N2996 X1.455Y-5.9388
N3001 X1.3588Y-6.035
N3006 X1.3288Y-6.0049
N3011 G41X1.3147Y-5.9908
N3016 X1.2877Y-6.0177
N3021 G2X1.24Y-6.0375I-.0477J.0477
N3026 G1X.14
N3031 G2X.0923Y-6.0177J.0675
N3036 G1X.0653Y-5.9908
N3041 X.0441Y-5.9696
N3046 G40X.03Y-5.9837
N3051 X.0212Y-6.035
N3056 X-.065Y-5.9488
N3061 Y-6.035
N3066 X.0212
N3071 X.0512Y-6.0049
N3076 G41X.0653Y-5.9908
N3081 X-.0477Y-5.8777
N3086 G2X-.0675Y-5.83I.0477J.0477
N3091 G1Y-4.73
N3096 G2X-.0477Y-4.6823I.0675
N3101 G1X.0923Y-4.5423
N3106 G2X.14Y-4.5225I.0477J-.0477
N3111 G1X1.24
N3116 G2X1.2877Y-4.5423J-.0675
N3121 G1X1.4277Y-4.6823
N3126 G2X1.4475Y-4.73I-.0477J-.0477
N3131 G1Y-5.83
N3136 G2X1.4277Y-5.8777I-.0675
N3141 G1X1.3147Y-5.9908
N3146 X1.2934Y-6.012
N3151 G40X1.3076Y-6.0262
N3156 X1.3588Y-6.035
N3161 X1.5512
N3166 X1.5812Y-6.0049
N3171 G41X1.5953Y-5.9908
N3176 X1.4823Y-5.8777
N3181 G2X1.4625Y-5.83I.0477J.0477
N3186 G1Y-4.73
N3191 G2X1.4823Y-4.6823I.0675
N3196 G1X1.6053Y-4.5592
N3201 X1.6223Y-4.5423
N3206 G2X1.6267Y-4.5382I.0477J-.0477
N3211 G40G1X1.6139Y-4.5228
N3216 X1.5612Y-4.515
N3221 X1.455Y-4.4088
N3226 X1.4249Y-4.3788
N3231 G41X1.4108Y-4.3647
N3236 X1.2877Y-4.4877
N3241 G2X1.24Y-4.5075I-.0477J.0477
N3246 G1X.14
N3251 G2X.0923Y-4.4877J.0675
N3256 G1X.0753Y-4.4708
N3261 X.0541Y-4.4496
N3266 G40X.04Y-4.4637
N3271 X.0312Y-4.515
N3276 X-.065Y-4.4188
N3281 Y-4.6112
N3286 X.0312Y-4.515
N3291 X.0612Y-4.4849
N3296 G41X.0753Y-4.4708
N3301 X-.0477Y-4.3477
N3306 G2X-.0675Y-4.3I.0477J.0477
N3311 G1Y-3.2
N3316 G2X-.0477Y-3.1523I.0675
N3321 G1X.0753Y-3.0292
N3326 X.0923Y-3.0123
N3331 G2X.0967Y-3.0082I.0477J-.0477
N3336 G40G1X.0839Y-2.9928
N3341 X.0312Y-2.985
N3346 X.0612Y-2.9549
N3351 G41X.0753Y-2.9408
N3356 X-.0477Y-2.8177
N3361 G2X-.0675Y-2.77I.0477J.0477
N3366 G1Y-1.67
N3371 G2X-.0477Y-1.6223I.0675
N3376 G1X.0753Y-1.4992
N3381 X.0923Y-1.4823
N3386 G2X.0967Y-1.4782I.0477J-.0477
N3391 G40G1X.0839Y-1.4628
N3396 X.0312Y-1.455
N3401 X.0612Y-1.4249
N3406 G41X.0753Y-1.4108
N3411 X-.0477Y-1.2877
N3416 G2X-.0675Y-1.24I.0477J.0477
N3421 G1Y-.14
N3426 G2X-.0477Y-.0923I.0675
N3431 G1X-.0208Y-.0653
N3436 X.0004Y-.0441
N3441 G40X-.0137Y-.03
N3446 X-.065Y-.0212
N3451 X.0212Y.065
N3456 X-.065
N3461 Y-.0212
N3466 X-.0349Y-.0512
N3471 G41X-.0208Y-.0653
N3476 X.0923Y.0477
N3481 G2X.14Y.0675I.0477J-.0477
N3486 G1X1.24
N3491 G2X1.2877Y.0477J-.0675
N3496 G1X1.4108Y-.0753
N3501 X1.4277Y-.0923
N3506 G2X1.4318Y-.0967I-.0477J-.0477
N3511 G40G1X1.4472Y-.0839
N3516 X1.455Y-.0312
N3521 X1.5512Y.065
N3526 G0Z.05
( OPERATION 7: ROUGHING )
( CS#2 - G54 )
N3531 G0G90X.415Y-1.4625
N3536 G1Z-.065F18.
N3541 G41D5Y-1.4425
N3546 X.14F30.
N3551 G2X.0958Y-1.4242J.0625
N3556 G1X-.0442Y-1.2842
N3561 G2X-.0625Y-1.24I.0442J.0442
N3566 G1Y-.14
N3571 G2X-.0442Y-.0958I.0625
N3576 G1X.0958Y.0442
N3581 G2X.14Y.0625I.0442J-.0442
N3586 G1X1.24
N3591 G2X1.2842Y.0442J-.0625
N3596 G1X1.4242Y-.0958
N3601 G2X1.4425Y-.14I-.0442J-.0442
N3606 G1Y-1.24
N3611 G2X1.4242Y-1.2842I-.0625
N3616 G1X1.2842Y-1.4242
N3621 G2X1.24Y-1.4425I-.0442J.0442
N3626 G1X.415
N3631 X.385
N3636 G40Y-1.4625
N3641 G0Z.05
( OPERATION 8: ROUGHING )
( CS#2 - G54 )
N3646 G0G90X1.945Y-1.4625
N3651 G1Z-.065F18.
N3656 G41D5Y-1.4425
N3661 X1.67F30.
N3666 G2X1.6258Y-1.4242J.0625
N3671 G1X1.4858Y-1.2842
N3676 G2X1.4675Y-1.24I.0442J.0442
N3681 G1Y-.14
N3686 G2X1.4858Y-.0958I.0625
N3691 G1X1.6258Y.0442
N3696 G2X1.67Y.0625I.0442J-.0442
N3701 G1X2.77
N3706 G2X2.8142Y.0442J-.0625
N3711 G1X2.9542Y-.0958
N3716 G2X2.9725Y-.14I-.0442J-.0442
N3721 G1Y-1.24
N3726 G2X2.9542Y-1.2842I-.0625
N3731 G1X2.8142Y-1.4242
N3736 G2X2.77Y-1.4425I-.0442J.0442
N3741 G1X1.945
N3746 X1.915
N3751 G40Y-1.4625
N3756 G0Z.05
( OPERATION 9: ROUGHING )
( CS#2 - G54 )
N3761 G0G90X1.945Y-2.9925
N3766 G1Z-.065F18.
N3771 G41D5Y-2.9725
N3776 X1.67F30.
N3781 G2X1.6258Y-2.9542J.0625
N3786 G1X1.4858Y-2.8142
N3791 G2X1.4675Y-2.77I.0442J.0442
N3796 G1Y-1.67
N3801 G2X1.4858Y-1.6258I.0625
N3806 G1X1.6258Y-1.4858
N3811 G2X1.67Y-1.4675I.0442J-.0442
N3816 G1X2.77
N3821 G2X2.8142Y-1.4858J-.0625
N3826 G1X2.9542Y-1.6258
N3831 G2X2.9725Y-1.67I-.0442J-.0442
N3836 G1Y-2.77
N3841 G2X2.9542Y-2.8142I-.0625
N3846 G1X2.8142Y-2.9542
N3851 G2X2.77Y-2.9725I-.0442J.0442
N3856 G1X1.945
N3861 X1.915
N3866 G40Y-2.9925
N3871 G0Z.05
( OPERATION 10: ROUGHING )
( CS#2 - G54 )
N3876 G0G90X1.945Y-4.5225
N3881 G1Z-.065F18.
N3886 G41D5Y-4.5025
N3891 X1.67F30.
N3896 G2X1.6258Y-4.4842J.0625
N3901 G1X1.4858Y-4.3442
N3906 G2X1.4675Y-4.3I.0442J.0442
N3911 G1Y-3.2
N3916 G2X1.4858Y-3.1558I.0625
N3921 G1X1.6258Y-3.0158
N3926 G2X1.67Y-2.9975I.0442J-.0442
N3931 G1X2.77
N3936 G2X2.8142Y-3.0158J-.0625
N3941 G1X2.9542Y-3.1558
N3946 G2X2.9725Y-3.2I-.0442J-.0442
N3951 G1Y-4.3
N3956 G2X2.9542Y-4.3442I-.0625
N3961 G1X2.8142Y-4.4842
N3966 G2X2.77Y-4.5025I-.0442J.0442
N3971 G1X1.945
N3976 X1.915
N3981 G40Y-4.5225
N3986 G0Z.05
( OPERATION 11: ROUGHING )
( CS#2 - G54 )
N3991 G0G90X.415Y-4.5225
N3996 G1Z-.065F18.
N4001 G41D5Y-4.5025
N4006 X.14F30.
N4011 G2X.0958Y-4.4842J.0625
N4016 G1X-.0442Y-4.3442
N4021 G2X-.0625Y-4.3I.0442J.0442
N4026 G1Y-3.2
N4031 G2X-.0442Y-3.1558I.0625
N4036 G1X.0958Y-3.0158
N4041 G2X.14Y-2.9975I.0442J-.0442
N4046 G1X1.24
N4051 G2X1.2842Y-3.0158J-.0625
N4056 G1X1.4242Y-3.1558
N4061 G2X1.4425Y-3.2I-.0442J-.0442
N4066 G1Y-4.3
N4071 G2X1.4242Y-4.3442I-.0625
N4076 G1X1.2842Y-4.4842
N4081 G2X1.24Y-4.5025I-.0442J.0442
N4086 G1X.415
N4091 X.385
N4096 G40Y-4.5225
N4101 G0Z.05
( OPERATION 12: ROUGHING )
( CS#2 - G54 )
N4106 G0G90X.415Y-2.9925
N4111 G1Z-.065F18.
N4116 G41D5Y-2.9725
N4121 X.14F30.
N4126 G2X.0958Y-2.9542J.0625
N4131 G1X-.0442Y-2.8142
N4136 G2X-.0625Y-2.77I.0442J.0442
N4141 G1Y-1.67
N4146 G2X-.0442Y-1.6258I.0625
N4151 G1X.0958Y-1.4858
N4156 G2X.14Y-1.4675I.0442J-.0442
N4161 G1X1.24
N4166 G2X1.2842Y-1.4858J-.0625
N4171 G1X1.4242Y-1.6258
N4176 G2X1.4425Y-1.67I-.0442J-.0442
N4181 G1Y-2.77
N4186 G2X1.4242Y-2.8142I-.0625
N4191 G1X1.2842Y-2.9542
N4196 G2X1.24Y-2.9725I-.0442J.0442
N4201 G1X.415
N4206 X.385
N4211 G40Y-2.9925
N4216 G0Z.05
( OPERATION 13: ROUGHING )
( CS#2 - G54 )
N4221 G0G90X.415Y-6.0525
N4226 G1Z-.065F18.
N4231 G41D5Y-6.0325
N4236 X.14F30.
N4241 G2X.0958Y-6.0142J.0625
N4246 G1X-.0442Y-5.8742
N4251 G2X-.0625Y-5.83I.0442J.0442
N4256 G1Y-4.73
N4261 G2X-.0442Y-4.6858I.0625
N4266 G1X.0958Y-4.5458
N4271 G2X.14Y-4.5275I.0442J-.0442
N4276 G1X1.24
N4281 G2X1.2842Y-4.5458J-.0625
N4286 G1X1.4242Y-4.6858
N4291 G2X1.4425Y-4.73I-.0442J-.0442
N4296 G1Y-5.83
N4301 G2X1.4242Y-5.8742I-.0625
N4306 G1X1.2842Y-6.0142
N4311 G2X1.24Y-6.0325I-.0442J.0442
N4316 G1X.415
N4321 X.385
N4326 G40Y-6.0525
N4331 G0Z.05
( OPERATION 14: ROUGHING )
( CS#2 - G54 )
N4336 G0G90X1.945Y-6.0525
N4341 G1Z-.065F18.
N4346 G41D5Y-6.0325
N4351 X1.67F30.
N4356 G2X1.6258Y-6.0142J.0625
N4361 G1X1.4858Y-5.8742
N4366 G2X1.4675Y-5.83I.0442J.0442
N4371 G1Y-4.73
N4376 G2X1.4858Y-4.6858I.0625
N4381 G1X1.6258Y-4.5458
N4386 G2X1.67Y-4.5275I.0442J-.0442
N4391 G1X2.77
N4396 G2X2.8142Y-4.5458J-.0625
N4401 G1X2.9542Y-4.6858
N4406 G2X2.9725Y-4.73I-.0442J-.0442
N4411 G1Y-5.83
N4416 G2X2.9542Y-5.8742I-.0625
N4421 G1X2.8142Y-6.0142
N4426 G2X2.77Y-6.0325I-.0442J.0442
N4431 G1X1.945
N4436 X1.915
N4441 G40Y-6.0525
N4446 G0Z.05
( OPERATION 15: ROUGHING )
( CS#2 - G54 )
N4451 G0G90X3.475Y-6.0525
N4456 G1Z-.065F18.
N4461 G41D5Y-6.0325
N4466 X3.2F30.
N4471 G2X3.1558Y-6.0142J.0625
N4476 G1X3.0158Y-5.8742
N4481 G2X2.9975Y-5.83I.0442J.0442
N4486 G1Y-4.73
N4491 G2X3.0158Y-4.6858I.0625
N4496 G1X3.1558Y-4.5458
N4501 G2X3.2Y-4.5275I.0442J-.0442
N4506 G1X4.3
N4511 G2X4.3442Y-4.5458J-.0625
N4516 G1X4.4842Y-4.6858
N4521 G2X4.5025Y-4.73I-.0442J-.0442
N4526 G1Y-5.83
N4531 G2X4.4842Y-5.8742I-.0625
N4536 G1X4.3442Y-6.0142
N4541 G2X4.3Y-6.0325I-.0442J.0442
N4546 G1X3.475
N4551 X3.445
N4556 G40Y-6.0525
N4561 G0Z.05
( OPERATION 16: ROUGHING )
( CS#2 - G54 )
N4566 G0G90X3.475Y-4.5225
N4571 G1Z-.065F18.
N4576 G41D5Y-4.5025
N4581 X3.2F30.
N4586 G2X3.1558Y-4.4842J.0625
N4591 G1X3.0158Y-4.3442
N4596 G2X2.9975Y-4.3I.0442J.0442
N4601 G1Y-3.2
N4606 G2X3.0158Y-3.1558I.0625
N4611 G1X3.1558Y-3.0158
N4616 G2X3.2Y-2.9975I.0442J-.0442
N4621 G1X4.3
N4626 G2X4.3442Y-3.0158J-.0625
N4631 G1X4.4842Y-3.1558
N4636 G2X4.5025Y-3.2I-.0442J-.0442
N4641 G1Y-4.3
N4646 G2X4.4842Y-4.3442I-.0625
N4651 G1X4.3442Y-4.4842
N4656 G2X4.3Y-4.5025I-.0442J.0442
N4661 G1X3.475
N4666 X3.445
N4671 G40Y-4.5225
N4676 G0Z.05
( OPERATION 17: ROUGHING )
( CS#2 - G54 )
N4681 G0G90X3.475Y-2.9925
N4686 G1Z-.065F18.
N4691 G41D5Y-2.9725
N4696 X3.2F30.
N4701 G2X3.1558Y-2.9542J.0625
N4706 G1X3.0158Y-2.8142
N4711 G2X2.9975Y-2.77I.0442J.0442
N4716 G1Y-1.67
N4721 G2X3.0158Y-1.6258I.0625
N4726 G1X3.1558Y-1.4858
N4731 G2X3.2Y-1.4675I.0442J-.0442
N4736 G1X4.3
N4741 G2X4.3442Y-1.4858J-.0625
N4746 G1X4.4842Y-1.6258
N4751 G2X4.5025Y-1.67I-.0442J-.0442
N4756 G1Y-2.77
N4761 G2X4.4842Y-2.8142I-.0625
N4766 G1X4.3442Y-2.9542
N4771 G2X4.3Y-2.9725I-.0442J.0442
N4776 G1X3.475
N4781 X3.445
N4786 G40Y-2.9925
N4791 G0Z.05
( OPERATION 18: ROUGHING )
( CS#2 - G54 )
N4796 G0G90X3.475Y-1.4625
N4801 G1Z-.065F18.
N4806 G41D5Y-1.4425
N4811 X3.2F30.
N4816 G2X3.1558Y-1.4242J.0625
N4821 G1X3.0158Y-1.2842
N4826 G2X2.9975Y-1.24I.0442J.0442
N4831 G1Y-.14
N4836 G2X3.0158Y-.0958I.0625
N4841 G1X3.1558Y.0442
N4846 G2X3.2Y.0625I.0442J-.0442
N4851 G1X4.3
N4856 G2X4.3442Y.0442J-.0625
N4861 G1X4.4842Y-.0958
N4866 G2X4.5025Y-.14I-.0442J-.0442
N4871 G1Y-1.24
N4876 G2X4.4842Y-1.2842I-.0625
N4881 G1X4.3442Y-1.4242
N4886 G2X4.3Y-1.4425I-.0442J.0442
N4891 G1X3.475
N4896 X3.445
N4901 G40Y-1.4625
N4906 G0Z.05
( OPERATION 19: ROUGHING )
( CS#2 - G54 )
N4911 G0G90X5.005Y-1.4625
N4916 G1Z-.065F18.
N4921 G41D5Y-1.4425
N4926 X4.73F30.
N4931 G2X4.6858Y-1.4242J.0625
N4936 G1X4.5458Y-1.2842
N4941 G2X4.5275Y-1.24I.0442J.0442
N4946 G1Y-.14
N4951 G2X4.5458Y-.0958I.0625
N4956 G1X4.6858Y.0442
N4961 G2X4.73Y.0625I.0442J-.0442
N4966 G1X5.83
N4971 G2X5.8742Y.0442J-.0625
N4976 G1X6.0142Y-.0958
N4981 G2X6.0325Y-.14I-.0442J-.0442
N4986 G1Y-1.24
N4991 G2X6.0142Y-1.2842I-.0625
N4996 G1X5.8742Y-1.4242
N5001 G2X5.83Y-1.4425I-.0442J.0442
N5006 G1X5.005
N5011 X4.975
N5016 G40Y-1.4625
N5021 G0Z.05
( OPERATION 20: ROUGHING )
( CS#2 - G54 )
N5026 G0G90X5.005Y-2.9925
N5031 G1Z-.065F18.
N5036 G41D5Y-2.9725
N5041 X4.73F30.
N5046 G2X4.6858Y-2.9542J.0625
N5051 G1X4.5458Y-2.8142
N5056 G2X4.5275Y-2.77I.0442J.0442
N5061 G1Y-1.67
N5066 G2X4.5458Y-1.6258I.0625
N5071 G1X4.6858Y-1.4858
N5076 G2X4.73Y-1.4675I.0442J-.0442
N5081 G1X5.83
N5086 G2X5.8742Y-1.4858J-.0625
N5091 G1X6.0142Y-1.6258
N5096 G2X6.0325Y-1.67I-.0442J-.0442
N5101 G1Y-2.77
N5106 G2X6.0142Y-2.8142I-.0625
N5111 G1X5.8742Y-2.9542
N5116 G2X5.83Y-2.9725I-.0442J.0442
N5121 G1X5.005
N5126 X4.975
N5131 G40Y-2.9925
N5136 G0Z.05
( OPERATION 21: ROUGHING )
( CS#2 - G54 )
N5141 G0G90X5.005Y-4.5225
N5146 G1Z-.065F18.
N5151 G41D5Y-4.5025
N5156 X4.73F30.
N5161 G2X4.6858Y-4.4842J.0625
N5166 G1X4.5458Y-4.3442
N5171 G2X4.5275Y-4.3I.0442J.0442
N5176 G1Y-3.2
N5181 G2X4.5458Y-3.1558I.0625
N5186 G1X4.6858Y-3.0158
N5191 G2X4.73Y-2.9975I.0442J-.0442
N5196 G1X5.83
N5201 G2X5.8742Y-3.0158J-.0625
N5206 G1X6.0142Y-3.1558
N5211 G2X6.0325Y-3.2I-.0442J-.0442
N5216 G1Y-4.3
N5221 G2X6.0142Y-4.3442I-.0625
N5226 G1X5.8742Y-4.4842
N5231 G2X5.83Y-4.5025I-.0442J.0442
N5236 G1X5.005
N5241 X4.975
N5246 G40Y-4.5225
N5251 G0Z.05
( OPERATION 22: ROUGHING )
( CS#2 - G54 )
N5256 G0G90X5.005Y-6.0525
N5261 G1Z-.065F18.
N5266 G41D5Y-6.0325
N5271 X4.73F30.
N5276 G2X4.6858Y-6.0142J.0625
N5281 G1X4.5458Y-5.8742
N5286 G2X4.5275Y-5.83I.0442J.0442
N5291 G1Y-4.73
N5296 G2X4.5458Y-4.6858I.0625
N5301 G1X4.6858Y-4.5458
N5306 G2X4.73Y-4.5275I.0442J-.0442
N5311 G1X5.83
N5316 G2X5.8742Y-4.5458J-.0625
N5321 G1X6.0142Y-4.6858
N5326 G2X6.0325Y-4.73I-.0442J-.0442
N5331 G1Y-5.83
N5336 G2X6.0142Y-5.8742I-.0625
N5341 G1X5.8742Y-6.0142
N5346 G2X5.83Y-6.0325I-.0442J.0442
N5351 G1X5.005
N5356 X4.975
N5361 G40Y-6.0525
N5366 G0Z.05
N5371 M9
N5376 G0G28G91Z0.M5
N5381 G49
N5386 M1
( TOOL CHANGE, TOOL #686 )
( DIAMETER = .125 SPOT DRILL )
( V E-M  DEBURRING )
( OPERATION 23: ROUGHING )
( CS#2 - G54 )
N5391 T6M6
N5396 S10000M3
N5401 G0G17G54G61G90X.4078Y-1.435M8
N5406 G43Z1.H6
N5411 Z.05
N5416 Z-.04
N5421 G41D6G1Y-1.415F23.
N5426 X.1255F30.
N5431 X-.035Y-1.2545
N5436 Y-.1255
N5441 X.1255Y.035
N5446 X1.2545
N5451 X1.415Y-.1255
N5456 Y-1.2545
N5461 X1.2545Y-1.415
N5466 X.4078
N5471 X.3878
N5476 G40Y-1.435
N5481 G0Z.05
( OPERATION 24: ROUGHING )
( CS#2 - G54 )
N5486 G0G90X.4078Y-2.965
N5491 Z-.04
N5496 G41D6G1Y-2.945F23.
N5501 X.1255F30.
N5506 X-.035Y-2.7845
N5511 Y-1.6555
N5516 X.1255Y-1.495
N5521 X1.2545
N5526 X1.415Y-1.6555
N5531 Y-2.7845
N5536 X1.2545Y-2.945
N5541 X.4078
N5546 X.3878
N5551 G40Y-2.965
N5556 G0Z.05
( OPERATION 25: ROUGHING )
( CS#2 - G54 )
N5561 G0G90X.4078Y-4.495
N5566 Z-.04
N5571 G41D6G1Y-4.475F23.
N5576 X.1255F30.
N5581 X-.035Y-4.3145
N5586 Y-3.1855
N5591 X.1255Y-3.025
N5596 X1.2545
N5601 X1.415Y-3.1855
N5606 Y-4.3145
N5611 X1.2545Y-4.475
N5616 X.4078
N5621 X.3878
N5626 G40Y-4.495
N5631 G0Z.05
( OPERATION 26: ROUGHING )
( CS#2 - G54 )
N5636 G0G90X.4078Y-6.025
N5641 Z-.04
N5646 G41D6G1Y-6.005F23.
N5651 X.1255F30.
N5656 X-.035Y-5.8445
N5661 Y-4.7155
N5666 X.1255Y-4.555
N5671 X1.2545
N5676 X1.415Y-4.7155
N5681 Y-5.8445
N5686 X1.2545Y-6.005
N5691 X.4078
N5696 X.3878
N5701 G40Y-6.025
N5706 G0Z.05
( OPERATION 27: ROUGHING )
( CS#2 - G54 )
N5711 G0G90X1.9378Y-6.025
N5716 Z-.04
N5721 G41D6G1Y-6.005F23.
N5726 X1.6555F30.
N5731 X1.495Y-5.8445
N5736 Y-4.7155
N5741 X1.6555Y-4.555
N5746 X2.7845
N5751 X2.945Y-4.7155
N5756 Y-5.8445
N5761 X2.7845Y-6.005
N5766 X1.9378
N5771 X1.9178
N5776 G40Y-6.025
N5781 G0Z.05
( OPERATION 28: ROUGHING )
( CS#2 - G54 )
N5786 G0G90X3.4678Y-6.025
N5791 Z-.04
N5796 G41D6G1Y-6.005F23.
N5801 X3.1855F30.
N5806 X3.025Y-5.8445
N5811 Y-4.7155
N5816 X3.1855Y-4.555
N5821 X4.3145
N5826 X4.475Y-4.7155
N5831 Y-5.8445
N5836 X4.3145Y-6.005
N5841 X3.4678
N5846 X3.4478
N5851 G40Y-6.025
N5856 G0Z.05
( OPERATION 29: ROUGHING )
( CS#2 - G54 )
N5861 G0G90X3.4678Y-4.495
N5866 Z-.04
N5871 G41D6G1Y-4.475F23.
N5876 X3.1855F30.
N5881 X3.025Y-4.3145
N5886 Y-3.1855
N5891 X3.1855Y-3.025
N5896 X4.3145
N5901 X4.475Y-3.1855
N5906 Y-4.3145
N5911 X4.3145Y-4.475
N5916 X3.4678
N5921 X3.4478
N5926 G40Y-4.495
N5931 G0Z.05
( OPERATION 30: ROUGHING )
( CS#2 - G54 )
N5936 G0G90X1.9378Y-4.495
N5941 Z-.04
N5946 G41D6G1Y-4.475F23.
N5951 X1.6555F30.
N5956 X1.495Y-4.3145
N5961 Y-3.1855
N5966 X1.6555Y-3.025
N5971 X2.7845
N5976 X2.945Y-3.1855
N5981 Y-4.3145
N5986 X2.7845Y-4.475
N5991 X1.9378
N5996 X1.9178
N6001 G40Y-4.495
N6006 G0Z.05
( OPERATION 31: ROUGHING )
( CS#2 - G54 )
N6011 G0G90X1.9378Y-2.965
N6016 Z-.04
N6021 G41D6G1Y-2.945F23.
N6026 X1.6555F30.
N6031 X1.495Y-2.7845
N6036 Y-1.6555
N6041 X1.6555Y-1.495
N6046 X2.7845
N6051 X2.945Y-1.6555
N6056 Y-2.7845
N6061 X2.7845Y-2.945
N6066 X1.9378
N6071 X1.9178
N6076 G40Y-2.965
N6081 G0Z.05
( OPERATION 32: ROUGHING )
( CS#2 - G54 )
N6086 G0G90X3.4678Y-2.965
N6091 Z-.04
N6096 G41D6G1Y-2.945F23.
N6101 X3.1855F30.
N6106 X3.025Y-2.7845
N6111 Y-1.6555
N6116 X3.1855Y-1.495
N6121 X4.3145
N6126 X4.475Y-1.6555
N6131 Y-2.7845
N6136 X4.3145Y-2.945
N6141 X3.4678
N6146 X3.4478
N6151 G40Y-2.965
N6156 G0Z.05
( OPERATION 33: ROUGHING )
( CS#2 - G54 )
N6161 G0G90X3.4678Y-1.435
N6166 Z-.04
N6171 G41D6G1Y-1.415F23.
N6176 X3.1855F30.
N6181 X3.025Y-1.2545
N6186 Y-.1255
N6191 X3.1855Y.035
N6196 X4.3145
N6201 X4.475Y-.1255
N6206 Y-1.2545
N6211 X4.3145Y-1.415
N6216 X3.4678
N6221 X3.4478
N6226 G40Y-1.435
N6231 G0Z.05
( OPERATION 34: ROUGHING )
( CS#2 - G54 )
N6236 G0G90X1.9378Y-1.435
N6241 Z-.04
N6246 G41D6G1Y-1.415F23.
N6251 X1.6555F30.
N6256 X1.495Y-1.2545
N6261 Y-.1255
N6266 X1.6555Y.035
N6271 X2.7845
N6276 X2.945Y-.1255
N6281 Y-1.2545
N6286 X2.7845Y-1.415
N6291 X1.9378
N6296 X1.9178
N6301 G40Y-1.435
N6306 G0Z.05
( OPERATION 35: ROUGHING )
( CS#2 - G54 )
N6311 G0G90X4.9978Y-1.435
N6316 Z-.04
N6321 G41D6G1Y-1.415F23.
N6326 X4.7155F30.
N6331 X4.555Y-1.2545
N6336 Y-.1255
N6341 X4.7155Y.035
N6346 X5.8445
N6351 X6.005Y-.1255
N6356 Y-1.2545
N6361 X5.8445Y-1.415
N6366 X4.9978
N6371 X4.9778
N6376 G40Y-1.435
N6381 G0Z.05
( OPERATION 36: ROUGHING )
( CS#2 - G54 )
N6386 G0G90X4.9978Y-2.965
N6391 Z-.04
N6396 G41D6G1Y-2.945F23.
N6401 X4.7155F30.
N6406 X4.555Y-2.7845
N6411 Y-1.6555
N6416 X4.7155Y-1.495
N6421 X5.8445
N6426 X6.005Y-1.6555
N6431 Y-2.7845
N6436 X5.8445Y-2.945
N6441 X4.9978
N6446 X4.9778
N6451 G40Y-2.965
N6456 G0Z.05
( OPERATION 37: ROUGHING )
( CS#2 - G54 )
N6461 G0G90X4.9978Y-4.495
N6466 Z-.04
N6471 G41D6G1Y-4.475F23.
N6476 X4.7155F30.
N6481 X4.555Y-4.3145
N6486 Y-3.1855
N6491 X4.7155Y-3.025
N6496 X5.8445
N6501 X6.005Y-3.1855
N6506 Y-4.3145
N6511 X5.8445Y-4.475
N6516 X4.9978
N6521 X4.9778
N6526 G40Y-4.495
N6531 G0Z.05
( OPERATION 38: ROUGHING )
( CS#2 - G54 )
N6536 G0G90X4.9978Y-6.025
N6541 Z-.04
N6546 G41D6G1Y-6.005F23.
N6551 X4.7155F30.
N6556 X4.555Y-5.8445
N6561 Y-4.7155
N6566 X4.7155Y-4.555
N6571 X5.8445
N6576 X6.005Y-4.7155
N6581 Y-5.8445
N6586 X5.8445Y-6.005
N6591 X4.9978
N6596 X4.9778
N6601 G40Y-6.025
N6606 G0Z.05
N6611 M9
N6616 G0G28G91Z0.M5
N6621 G49
N6626 G28Y0.
N6631 M30
O101
N6636 X1.24Y-4.25
N6641 X1.67Y-4.78
N6646 X1.24Y-5.78
N6651 X2.77
N6656 X3.2Y-4.78
N6661 X2.77Y-4.25
N6666 X3.2Y-3.25
N6671 X2.77Y-2.72
N6676 X3.2Y-1.72
N6681 X2.77Y-1.19
N6686 X3.2Y-.19
N6691 X4.3Y-1.19
N6696 X4.73Y-1.72
N6701 X4.3Y-2.72
N6706 X4.73Y-3.25
N6711 X4.3Y-4.25
N6716 X4.73Y-4.78
N6721 X4.3Y-5.78
N6726 X5.83
N6731 Y-4.25
N6736 Y-2.72
N6741 Y-1.19
N6746 X4.73Y-.19
N6751 X1.67
N6756 X1.24Y-1.19
N6761 X1.67Y-1.72
N6766 X1.24Y-2.72
N6771 X1.67Y-3.25
N6776 X.14
N6781 Y-1.72
N6786 Y-.19
N6791 M99
O102
N6796 X.36Y-1.19
N6801 X1.02Y-1.72
N6806 X.36Y-2.72
N6811 X1.02Y-3.25
N6816 X.36Y-4.25
N6821 X1.02Y-4.78
N6826 X.36Y-5.78
N6831 X2.55Y-.19
N6836 X1.89Y-1.19
N6841 X2.55Y-1.72
N6846 X1.89Y-2.72
N6851 X2.55Y-3.25
N6856 X1.89Y-4.25
N6861 X2.55Y-4.78
N6866 X1.89Y-5.78
N6871 X4.08Y-.19
N6876 X3.42Y-1.19
N6881 X4.08Y-1.72
N6886 X3.42Y-2.72
N6891 X4.08Y-3.25
N6896 X3.42Y-4.25
N6901 X4.08Y-4.78
N6906 X3.42Y-5.78
N6911 X5.61Y-.19
N6916 X4.95Y-1.19
N6921 X5.61Y-1.72
N6926 X4.95Y-2.72
N6931 X5.61Y-3.25
N6936 X4.95Y-4.25
N6941 X5.61Y-4.78
N6946 X4.95Y-5.78
N6951 M99
( FILE LENGTH: 28338 CHARACTERS )

