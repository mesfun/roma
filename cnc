<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>G-Code Editor</title>
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
      .button-group button,
      .button-group label {
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
        from {
          background-color: rgba(255, 0, 0, 0.3);
        }
        to {
          background-color: transparent;
        }
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
      <h1 class="text-3xl font-bold text-center text-gray-800 mb-4">
        G-Code Editor
      </h1>

      <div class="flex flex-col items-center gap-4">
        <label for="fileInput" class="file-input-label">
          Upload File
          <input
            type="file"
            id="fileInput"
            accept=".txt, .nc"
          />
        </label>
        <span id="fileName" class="text-gray-600 text-sm"
          >No file selected</span
        >
      </div>

      <textarea
        id="fileContent"
        class="w-full p-4 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none"
        placeholder="Upload a file or type G-code here..."
        rows="15"
      ></textarea>

      <div class="input-group" id="findReplaceInputsContainer">
        <h2 class="text-xl font-semibold text-gray-700 mb-2">
          Find and Replace Values
        </h2>
        <div class="input-pair" id="inputPair1">
          <label for="find1">Find 1:</label>
          <input
            type="text"
            id="find1"
            class="p-2 border border-gray-300 rounded-md focus:ring-1 focus:ring-blue-400 outline-none"
            placeholder="e.g., T10"
          />
          <label for="replace1">Replace 1:</label>
          <input
            type="text"
            id="replace1"
            class="p-2 border border-gray-300 rounded-md focus:ring-1 focus:ring-blue-400 outline-none"
            placeholder="e.g., TempValue"
          />
        </div>
        <button
          id="replaceButton"
          class="bg-green-500 hover:bg-green-600 text-white font-bold py-2 px-4 rounded-lg transition duration-200 shadow-md"
        >
          Scan & Replace All
        </button>
        <div id="messageBox" class="message-box hidden"></div>
      </div>

      <div id="detectedPatternsSection" class="detected-patterns-section">
        <h2 class="text-xl font-semibold text-gray-700">
          Detected Patterns (Click to use in Find fields)
        </h2>
        <div id="patternList">
          <p class="text-gray-500">Upload a file to detect patterns.</p>
        </div>
      </div>

      <div class="button-group">
        <button
          id="downloadButton"
          class="bg-indigo-500 hover:bg-indigo-600 text-white font-bold py-2 px-4 rounded-lg transition duration-200 shadow-md"
        >
          Download Edited File
        </button>
        <button
          id="clearButton"
          class="bg-gray-400 hover:bg-gray-500 text-white font-bold py-2 px-4 rounded-lg transition duration-200 shadow-md"
        >
          Clear All
        </button>
      </div>
    </div>

    <script>
      const fileInput = document.getElementById("fileInput");
      const fileNameSpan = document.getElementById("fileName");
      const fileContentTextArea = document.getElementById("fileContent");
      const replaceButton = document.getElementById("replaceButton");
      const downloadButton = document.getElementById("downloadButton");
      const clearButton = document.getElementById("clearButton");
      const messageBox = document.getElementById("messageBox");
      const patternListDiv = document.getElementById("patternList");
      const findReplaceInputsContainer = document.getElementById(
        "findReplaceInputsContainer"
      );
      
      let currentFileName = "edited_file.nc";
      let currentFindInputIndex = 0;

      const MAX_INPUT_PAIRS = 50;
      const findInputs = [];
      const replaceInputs = [];
      const inputPairContainers = [];

      let allDetectedTPatterns = [];

      function createInputPairs() {
        findInputs.push(document.getElementById("find1"));
        replaceInputs.push(document.getElementById("replace1"));
        inputPairContainers.push(document.getElementById("inputPair1"));

        for (let i = 2; i <= MAX_INPUT_PAIRS; i++) {
          const inputPairDiv = document.createElement("div");
          inputPairDiv.className = "input-pair hidden";
          inputPairDiv.id = `inputPair${i}`;

          const findLabel = document.createElement("label");
          findLabel.htmlFor = `find${i}`;
          findLabel.textContent = `Find ${i}:`;
          inputPairDiv.appendChild(findLabel);

          const findInput = document.createElement("input");
          findInput.type = "text";
          findInput.id = `find${i}`;
          findInput.className =
            "p-2 border border-gray-300 rounded-md focus:ring-1 focus:ring-blue-400 outline-none";
          findInput.placeholder = `e.g., T${i}`;
          findInputs.push(findInput);
          inputPairDiv.appendChild(findInput);

          const replaceLabel = document.createElement("label");
          replaceLabel.htmlFor = `replace${i}`;
          replaceLabel.textContent = `Replace ${i}:`;
          inputPairDiv.appendChild(replaceLabel);

          const replaceInput = document.createElement("input");
          replaceInput.type = "text";
          replaceInput.id = `replace${i}`;
          replaceInput.className =
            "p-2 border border-gray-300 rounded-md focus:ring-1 focus:ring-blue-400 outline-none";
          replaceInputs.push(replaceInput);
          inputPairDiv.appendChild(replaceInput);

          findReplaceInputsContainer.insertBefore(inputPairDiv, replaceButton);
          inputPairContainers.push(inputPairDiv);
        }
      }

      function clearMessageBox() {
        messageBox.textContent = "";
        messageBox.classList.add("hidden");
        messageBox.className = "message-box hidden";
      }

      function showMessage(message, type) {
        clearMessageBox();
        messageBox.textContent = message;
        messageBox.className = `message-box ${type}`;
        messageBox.classList.remove("hidden");

        if (type === "success" || type === "info") {
          setTimeout(() => {
            clearMessageBox();
          }, 5000);
        }
      }

      function populateNextFindField(pattern, clickedItem) {
        clearMessageBox();

        if (
          currentFindInputIndex < inputPairContainers.length &&
          inputPairContainers[currentFindInputIndex].classList.contains(
            "hidden"
          )
        ) {
          inputPairContainers[currentFindInputIndex].classList.remove("hidden");
        }

        const targetFindInput = findInputs[currentFindInputIndex];
        const targetReplaceInput = replaceInputs[currentFindInputIndex];

        targetFindInput.value = pattern;

        if (pattern.toUpperCase().startsWith("T") && /\d+/.test(pattern)) {
          targetReplaceInput.value = "T";
        } else {
          targetReplaceInput.value = pattern;
        }

        targetFindInput.focus();

        if (clickedItem) {
          clickedItem.classList.add("hidden");
        }

        showMessage(
          `'${pattern}' copied to Find ${currentFindInputIndex + 1}.`,
          "info"
        );

        currentFindInputIndex = (currentFindInputIndex + 1) % MAX_INPUT_PAIRS;
      }

      function cleanLineFromComments(line) {
        let cleanedLine = line.replace(/\([^)]*\)/g, "");
        cleanedLine = cleanedLine.split(";")[0];
        return cleanedLine.trim();
      }

      function findPatternsInSegment(segmentContent) {
        const regexT = /T(\d+)/gi;
        const regexH = /H(\d+)/gi;
        const regexD = /D(\d+)/gi;
        const regexS = /S(\d+)/gi;
        const regexF = /F(\d+\.?\d*)/gi;
        const regexG84 = /G84/gi;
        const regexToolDia = /TOOL DIA\.?\s*[=\-]?\s*([+\-]?\d*\.?\d+)/gi;
        const specialCommentRegex =
          /\(\s*T\d+\s*\|\s*([^|]+?)\s*\|\s*H\d+\s*\|\s*D\d+\s*\|\s*WEAR COMP\s*\|\s*TOOL DIA\.?\s*-\s*\d*\.?\d+\s*\)/gi;

        const tPatterns = new Map();
        const hPatterns = new Map();
        const dPatterns = new Map();
        const sPatterns = new Map();
        const fPatterns = new Map();
        const g84Patterns = new Map();
        const toolDiaPatterns = new Map();
        const specialCommentDescriptions = new Map();

        const lines = segmentContent.split("\n");

        lines.forEach((line) => {
          let match;

          specialCommentRegex.lastIndex = 0;
          while ((match = specialCommentRegex.exec(line)) !== null) {
            const description = match[1].trim();
            if (description) {
              specialCommentDescriptions.set(
                description,
                (specialCommentDescriptions.get(description) || 0) + 1
              );
            }
          }

          const cleanedLine = cleanLineFromComments(line);

          if (cleanedLine === "") {
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
            const nValue = nMatch ? nMatch[0].toUpperCase() : "N/A";
            g84Patterns.set(nValue, (g84Patterns.get(nValue) || 0) + 1);
          }

          regexToolDia.lastIndex = 0;
          while ((match = regexToolDia.exec(cleanedLine)) !== null) {
            const pattern = match[0];
            toolDiaPatterns.set(
              pattern,
              (toolDiaPatterns.get(pattern) || 0) + 1
            );
          }
        });

        return {
          tPatterns,
          hPatterns,
          dPatterns,
          sPatterns,
          fPatterns,
          g84Patterns,
          toolDiaPatterns,
          specialCommentDescriptions,
        };
      }

      function scanAndDisplayPatterns() {
        const fullContent = fileContentTextArea.value;
        const lines = fullContent.split("\n");

        patternListDiv.innerHTML = "";
        allDetectedTPatterns = [];

        let patternsFoundOverall = false;
        let groupCounter = 0;
        let currentGroupContentLines = [];

        const blockTools = getBlockTools(fullContent);

        for (let i = 0; i < lines.length; i++) {
          const line = lines[i];
          const trimmedLine = line.trim();

          const isSeparator = trimmedLine.toLowerCase().includes("m01") || trimmedLine.toLowerCase().includes("m30");

          if (isSeparator) {
            groupCounter++;
            const nMatchOnM01Line = trimmedLine.match(/N(\d+)/i);
            const nValueForThisM01 = nMatchOnM01Line
              ? nMatchOnM01Line[0].toUpperCase()
              : null;

            const {
              tPatterns,
              hPatterns,
              dPatterns,
              sPatterns,
              fPatterns,
              g84Patterns,
              toolDiaPatterns,
              specialCommentDescriptions,
            } = findPatternsInSegment(currentGroupContentLines.join("\n"));

            let nextToolForThisBlock = null;
            if (blockTools.length > 0) {
              const currentToolInBlock = Array.from(tPatterns.keys()).find(
                (t) => t.match(/T\d+/i)
              );
              const currentToolIndexInBlockTools =
                blockTools.indexOf(currentToolInBlock);
              if (currentToolIndexInBlockTools !== -1) {
                const nextBlockToolIndex =
                  (currentToolIndexInBlockTools + 1) % blockTools.length;
                nextToolForThisBlock = blockTools[nextBlockToolIndex];
              }
            }

            tPatterns.forEach((count, pattern) => {
              if (!allDetectedTPatterns.includes(pattern)) {
                allDetectedTPatterns.push(pattern);
              }
            });

            const g84DetailsForGroup = [];
            
            renderGroupPatterns(
              groupCounter,
              tPatterns,
              hPatterns,
              dPatterns,
              sPatterns,
              fPatterns,
              g84DetailsForGroup,
              toolDiaPatterns,
              specialCommentDescriptions,
              nValueForThisM01,
              true,
              nextToolForThisBlock
            );

            if (
              tPatterns.size > 0 ||
              hPatterns.size > 0 ||
              dPatterns.size > 0 ||
              sPatterns.size > 0 ||
              fPatterns.size > 0 ||
              g84Patterns.size > 0 ||
              toolDiaPatterns.size > 0 ||
              specialCommentDescriptions.size > 0 ||
              nValueForThisM01
            ) {
              patternsFoundOverall = true;
            }

            currentGroupContentLines = [];
          } else {
            currentGroupContentLines.push(line);
          }
        }

        if (currentGroupContentLines.length > 0) {
          groupCounter++;
          const {
            tPatterns,
            hPatterns,
            dPatterns,
            sPatterns,
            fPatterns,
            g84Patterns,
            toolDiaPatterns,
            specialCommentDescriptions,
          } = findPatternsInSegment(currentGroupContentLines.join("\n"));

          let nextToolForThisBlock = null;
          if (blockTools.length > 0) {
            const currentToolInBlock = Array.from(tPatterns.keys()).find((t) =>
              t.match(/T\d+/i)
            );
            const currentToolIndexInBlockTools =
              blockTools.indexOf(currentToolInBlock);
            if (currentToolIndexInBlockTools !== -1) {
              const nextBlockToolIndex =
                (currentToolIndexInBlockTools + 1) % blockTools.length;
              nextToolForThisBlock = blockTools[nextBlockToolIndex];
            }
          }

          tPatterns.forEach((count, pattern) => {
            if (!allDetectedTPatterns.includes(pattern)) {
              allDetectedTPatterns.push(pattern);
            }
          });
          
          const g84DetailsForGroup = [];

          renderGroupPatterns(
            groupCounter,
            tPatterns,
            hPatterns,
            dPatterns,
            sPatterns,
            fPatterns,
            g84DetailsForGroup,
            toolDiaPatterns,
            specialCommentDescriptions,
            null,
            false,
            nextToolForThisBlock
          );
          if (
            tPatterns.size > 0 ||
            hPatterns.size > 0 ||
            dPatterns.size > 0 ||
            sPatterns.size > 0 ||
            fPatterns.size > 0 ||
            g84Patterns.size > 0 ||
            toolDiaPatterns.size > 0 ||
            specialCommentDescriptions.size > 0
          ) {
            patternsFoundOverall = true;
          }
        }

        if (!patternsFoundOverall && groupCounter === 0) {
          const noPatterns = document.createElement("p");
          noPatterns.className = "text-gray-500";
          noPatterns.textContent =
            "No T, H, D, S, F, G84, TOOL DIA., or special comment patterns with values found in any group.";
          patternListDiv.appendChild(noPatterns);
        }

        fillFindReplaceWithTPatterns();
      }

      function renderGroupPatterns(
        groupNumber,
        tPatterns,
        hPatterns,
        dPatterns,
        sPatterns,
        fPatterns,
        g84DetailsForGroup,
        toolDiaPatterns,
        specialCommentDescriptions,
        nValueAssociatedWithM01,
        hasM01Separator,
        nextToolForThisGroup
      ) {
        const groupSection = document.createElement("div");
        groupSection.className = "group-section";

        const groupHeader = document.createElement("h3");
        groupHeader.textContent = `Tool Path ${groupNumber}`;
        groupSection.appendChild(groupHeader);

        const patternsInGroupDiv = document.createElement("div");
        patternsInGroupDiv.className = "pattern-list";

        let patternsFoundInGroupContent = false;

        if (specialCommentDescriptions.size > 0) {
          const patternRow = document.createElement("div");
          patternRow.className = "pattern-row";

          const labelSpan = document.createElement("span");
          labelSpan.className = "pattern-label";
          labelSpan.textContent = "Comment Descriptions:";
          patternRow.appendChild(labelSpan);

          const valuesDiv = document.createElement("div");
          valuesDiv.className = "pattern-values";
          specialCommentDescriptions.forEach((count, description) => {
            patternsFoundInGroupContent = true;
            const item = document.createElement("span");
            item.className = "pattern-item";
            item.textContent = description;
            item.title = `Click to add '${description}' to a Find field`;
            item.addEventListener("click", (event) =>
              populateNextFindField(description, event.target)
            );
            valuesDiv.appendChild(item);
          });
          patternRow.appendChild(valuesDiv);
          patternsInGroupDiv.appendChild(patternRow);
        }

        if (tPatterns.size > 0) {
          const patternRow = document.createElement("div");
          patternRow.className = "pattern-row";

          const labelSpan = document.createElement("span");
          labelSpan.className = "pattern-label";
          labelSpan.textContent = "T Tool:";
          patternRow.appendChild(labelSpan);

          const valuesDiv = document.createElement("div");
          valuesDiv.className = "pattern-values";
          tPatterns.forEach((count, pattern) => {
            patternsFoundInGroupContent = true;
            const item = document.createElement("span");
            item.className = "pattern-item";
            item.textContent = pattern;
            item.title = `Click to add '${pattern}' to a Find field`;
            item.addEventListener("click", (event) =>
              populateNextFindField(pattern, event.target)
            );
            valuesDiv.appendChild(item);
          });
          patternRow.appendChild(valuesDiv);
          patternsInGroupDiv.appendChild(patternRow);
        }

        if (nextToolForThisGroup) {
          const patternRow = document.createElement("div");
          patternRow.className = "pattern-row";

          const labelSpan = document.createElement("span");
          labelSpan.className = "pattern-label";
          labelSpan.textContent = "Next Tool (Calculated):";
          patternRow.appendChild(labelSpan);

          const valuesDiv = document.createElement("div");
          valuesDiv.className = "pattern-values";
          const item = document.createElement("span");
          item.className = "non-clickable-pattern-item";
          item.textContent = nextToolForThisGroup;
          item.title = `This is the next tool in sequence: ${nextToolForThisGroup}`;
          valuesDiv.appendChild(item);
          patternRow.appendChild(valuesDiv);
          patternsInGroupDiv.appendChild(patternRow);
          patternsFoundInGroupContent = true;
        }

        if (hPatterns.size > 0) {
          const patternRow = document.createElement("div");
          patternRow.className = "pattern-row";

          const labelSpan = document.createElement("span");
          labelSpan.className = "pattern-label";
          labelSpan.textContent = "H Height:";
          patternRow.appendChild(labelSpan);

          const valuesDiv = document.createElement("div");
          valuesDiv.className = "pattern-values";
          hPatterns.forEach((count, pattern) => {
            patternsFoundInGroupContent = true;
            const item = document.createElement("span");
            item.className = "non-clickable-pattern-item";
            item.textContent = `${pattern} (${count})`;
            item.title = `H value: ${pattern}`;
            valuesDiv.appendChild(item);
          });
          patternRow.appendChild(valuesDiv);
          patternsInGroupDiv.appendChild(patternRow);
        }

        if (dPatterns.size > 0) {
          const patternRow = document.createElement("div");
          patternRow.className = "pattern-row";

          const labelSpan = document.createElement("span");
          labelSpan.className = "pattern-label";
          labelSpan.textContent = "D Diameter:";
          patternRow.appendChild(labelSpan);

          const valuesDiv = document.createElement("div");
          valuesDiv.className = "pattern-values";
          dPatterns.forEach((count, pattern) => {
            patternsFoundInGroupContent = true;
            const item = document.createElement("span");
            item.className = "non-clickable-pattern-item";
            item.textContent = `${pattern} (${count})`;
            item.title = `D value: ${pattern}`;
            valuesDiv.appendChild(item);
          });
          patternRow.appendChild(valuesDiv);
          patternsInGroupDiv.appendChild(patternRow);
        }

        if (sPatterns.size > 0) {
          const patternRow = document.createElement("div");
          patternRow.className = "pattern-row";

          const labelSpan = document.createElement("span");
          labelSpan.className = "pattern-label";
          labelSpan.textContent = "S Speed:";
          patternRow.appendChild(labelSpan);

          const valuesDiv = document.createElement("div");
          valuesDiv.className = "pattern-values";
          sPatterns.forEach((count, pattern) => {
            patternsFoundInGroupContent = true;
            const item = document.createElement("span");
            item.className = "pattern-item";
            item.textContent = `${pattern} (${count})`;
            item.title = `Click to add '${pattern}' to a Find field`;
            item.addEventListener("click", (event) =>
              populateNextFindField(pattern, event.target)
            );
            valuesDiv.appendChild(item);
          });
          patternRow.appendChild(valuesDiv);
          patternsInGroupDiv.appendChild(patternRow);
        }

        if (fPatterns.size > 0) {
          const patternRow = document.createElement("div");
          patternRow.className = "pattern-row";

          const labelSpan = document.createElement("span");
          labelSpan.className = "pattern-label";
          labelSpan.textContent = "F Feed:";
          patternRow.appendChild(labelSpan);

          const valuesDiv = document.createElement("div");
          valuesDiv.className = "pattern-values";
          fPatterns.forEach((count, pattern) => {
            patternsFoundInGroupContent = true;
            const item = document.createElement("span");
            item.className = "pattern-item";
            item.textContent = `${pattern} (${count})`;
            item.title = `Click to add '${pattern}' to a Find field`;
            item.addEventListener("click", (event) =>
              populateNextFindField(pattern, event.target)
            );
            valuesDiv.appendChild(item);
          });
          patternRow.appendChild(valuesDiv);
          patternsInGroupDiv.appendChild(patternRow);
        }

        if (toolDiaPatterns.size > 0) {
          const patternRow = document.createElement("div");
          patternRow.className = "pattern-row";

          const labelSpan = document.createElement("span");
          labelSpan.className = "pattern-label";
          labelSpan.textContent = "Tool Diameter Values:";
          patternRow.appendChild(labelSpan);

          const valuesDiv = document.createElement("div");
          valuesDiv.className = "pattern-values";
          toolDiaPatterns.forEach((count, pattern) => {
            patternsFoundInGroupContent = true;
            const item = document.createElement("span");
            item.className = "pattern-item";

            const numericValueMatch = pattern.match(/([+\-]?\d*\.?\d+)$/);
            const displayValue = numericValueMatch
              ? parseFloat(numericValueMatch[1])
              : "N/A";
            item.textContent = `Dia: ${displayValue}`;

            item.title = `Click to add '${pattern}' to a Find field`;
            item.addEventListener("click", (event) =>
              populateNextFindField(pattern, event.target)
            );
            valuesDiv.appendChild(item);
          });
          patternRow.appendChild(valuesDiv);
          patternsInGroupDiv.appendChild(patternRow);
        }

        if (g84DetailsForGroup.length > 0) {
          const patternRow = document.createElement("div");
          patternRow.className = "pattern-row";

          const labelSpan = document.createElement("span");
          labelSpan.className = "pattern-label";
          labelSpan.textContent = "G84 Operations:";
          patternRow.appendChild(labelSpan);

          const valuesDiv = document.createElement("div");
          valuesDiv.className = "pattern-values";
          g84DetailsForGroup.forEach((detail) => {
            patternsFoundInGroupContent = true;
            const item = document.createElement("span");
            item.className = "pattern-item g84-pattern-item";
            item.textContent = `${detail.nValue}: S${detail.suggestedS} F${detail.suggestedF}`;
            item.title = `Click to highlight line ${detail.nValue} and scroll to it`;
            item.addEventListener("click", () =>
              highlightLineAndScroll(
                detail.nValue,
                detail.suggestedS,
                detail.suggestedF
              )
            );
            valuesDiv.appendChild(item);
          });
          patternRow.appendChild(valuesDiv);
          patternsInGroupDiv.appendChild(patternRow);
        }

        if (
          !patternsFoundInGroupContent &&
          (!nValueAssociatedWithM01 || nValueAssociatedWithM01 === "N220") &&
          specialCommentDescriptions.size === 0
        ) {
          const noPatterns = document.createElement("p");
          noPatterns.className = "text-gray-500";
          noPatterns.textContent =
            "No T, H, D, S, F, G84, TOOL DIA., or special comment patterns with values found in any group.";
          patternListDiv.appendChild(noPatterns);
        }

        groupSection.appendChild(patternsInGroupDiv);
        patternListDiv.appendChild(groupSection);

        if (hasM01Separator) {
          const m01Separator = document.createElement("p");
          m01Separator.className = "text-center text-gray-600 font-bold my-4";
          m01Separator.textContent = "--- M01 ---";
          patternListDiv.appendChild(m01Separator);
        }
      }

      function fillFindReplaceWithTPatterns() {
        for (let i = 0; i < MAX_INPUT_PAIRS; i++) {
          findInputs[i].value = "";
          replaceInputs[i].value = "";
          if (i > 0) {
            inputPairContainers[i].classList.add("hidden");
          }
        }

        let populatedCount = 0;
        for (
          let i = 0;
          i < allDetectedTPatterns.length && populatedCount < MAX_INPUT_PAIRS;
          i++
        ) {
          const tPattern = allDetectedTPatterns[i];

          if (
            inputPairContainers[populatedCount].classList.contains("hidden")
          ) {
            inputPairContainers[populatedCount].classList.remove("hidden");
          }

          findInputs[populatedCount].value = tPattern;
          replaceInputs[populatedCount].value = "T";
          populatedCount++;
        }

        currentFindInputIndex = populatedCount;

        if (populatedCount > 0) {
          showMessage(
            `${populatedCount} T-patterns automatically populated into Find/Replace fields.`,
            "info"
          );
        } else {
          showMessage("No T-patterns found to auto-populate.", "info");
        }
      }

      let activeHighlightTempDiv = null;
      let originalTextAreaInitialParent = null;

      function highlightLineAndScroll(
        nValue,
        suggestedS = "N/A",
        suggestedF = "N/A"
      ) {
        const lines = fileContentTextArea.value.split("\n");
        let lineIndex = -1;
        let lineContent = "";

        if (activeHighlightTempDiv) {
          if (
            activeHighlightTempDiv.parentNode &&
            originalTextAreaInitialParent
          ) {
            if (!originalTextAreaInitialParent.contains(fileContentTextArea)) {
              activeHighlightTempDiv.parentNode.replaceChild(
                fileContentTextArea,
                activeHighlightTempDiv
              );
              fileContentTextArea.scrollTop = activeHighlightTempDiv.scrollTop;
            }
          }
          activeHighlightTempDiv = null;
          clearTimeout(fileContentTextArea._highlightTimeout);
        }

        for (let i = 0; i < lines.length; i++) {
          const cleanedLine = cleanLineFromComments(lines[i]);
          const nValueRegex = new RegExp(`\\b${nValue}\\b`, "i");
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

          const tempDiv = document.createElement("div");
          const computedStyle = window.getComputedStyle(fileContentTextArea);
          for (const prop of computedStyle) {
            tempDiv.style[prop] = computedStyle.getPropertyValue(prop);
          }
          tempDiv.style.overflow = "auto";
          tempDiv.style.whiteSpace = "pre-wrap";
          tempDiv.style.wordBreak = "break-all";
          tempDiv.style.height = fileContentTextArea.clientHeight + "px";
          tempDiv.style.width = fileContentTextArea.clientWidth + "px";

          const preContent = lines.slice(0, lineIndex).join("\n");
          const postContent = lines.slice(lineIndex + 1).join("\n");

          const contentHtml = document.createElement("pre");
          contentHtml.style.margin = "0";
          contentHtml.style.padding = "0";
          contentHtml.style.fontFamily = "inherit";
          contentHtml.style.fontSize = "inherit";
          contentHtml.style.whiteSpace = "pre-wrap";

          const highlightedSpan = document.createElement("span");
          highlightedSpan.className = "highlighted-line";
          highlightedSpan.textContent = lineContent;

          contentHtml.appendChild(document.createTextNode(preContent));
          if (preContent.length > 0) {
            contentHtml.appendChild(document.createTextNode("\n"));
          }
          contentHtml.appendChild(highlightedSpan);
          if (postContent.length > 0) {
            contentHtml.appendChild(document.createTextNode("\n"));
          }
          contentHtml.appendChild(document.createTextNode(postContent));

          tempDiv.appendChild(contentHtml);

          if (fileContentTextArea.parentNode) {
            fileContentTextArea.parentNode.replaceChild(
              tempDiv,
              fileContentTextArea
            );
            activeHighlightTempDiv = tempDiv;
          } else {
            showMessage("Error highlighting: Internal DOM issue.", "error");
            return;
          }

          tempDiv.scrollTop =
            highlightedSpan.offsetTop -
            tempDiv.clientHeight / 2 +
            highlightedSpan.clientHeight / 2;

          showMessage(
            `Line ${nValue} highlighted. Suggested S: ${suggestedS}, F: ${suggestedF}.`,
            "info"
          );

          fileContentTextArea._highlightTimeout = setTimeout(() => {
            if (activeHighlightTempDiv && activeHighlightTempDiv.parentNode) {
              const currentScrollTop = activeHighlightTempDiv.scrollTop;
              activeHighlightTempDiv.parentNode.replaceChild(
                fileContentTextArea,
                activeHighlightTempDiv
              );
              fileContentTextArea.scrollTop = currentScrollTop;
            }
            activeHighlightTempDiv = null;
            fileContentTextArea._highlightTimeout = null;
          }, 3000);
        } else {
          showMessage(`Line with N-value '${nValue}' not found.`, "error");
        }
      }

      fileInput.addEventListener("change", (event) => {
        clearMessageBox();
        const file = event.target.files[0];
        if (file) {
          currentFileName =
            file.name.split(".").slice(0, -1).join(".") +
            "_edited." +
            file.name.split(".").pop();
          fileNameSpan.textContent = `Selected: ${file.name}`;
          const reader = new FileReader();

          reader.onload = (e) => {
            fileContentTextArea.value = e.target.result;
            showMessage("File loaded successfully!", "success");
            scanAndDisplayPatterns();
          };

          reader.onerror = () => {
            showMessage("Error reading file!", "error");
            fileContentTextArea.value = "";
            fileNameSpan.textContent = "No file selected";
          };

          reader.readAsText(file);
        } else {
          fileContentTextArea.value = "";
          fileNameSpan.textContent = "No file selected";
          currentFileName = "edited_file.nc";
          showMessage("No file selected.", "info");
          scanAndDisplayPatterns();
        }
      });

      function getBlockTools(content) {
        const lines = content.split('\n');
        const toolNumbers = new Set();
        let lastSeenTool = null;
        
        for (const line of lines) {
          const cleanedLine = cleanLineFromComments(line);
          const tMatch = cleanedLine.match(/T(\d+)/i);
          const isM6 = cleanedLine.toLowerCase().includes("m6");
          const isM1 = cleanedLine.toLowerCase().includes("m1");
          const isM30 = cleanedLine.toLowerCase().includes("m30");

          if (tMatch) {
            lastSeenTool = tMatch[0].toUpperCase();
          }
          if (lastSeenTool && (isM6 || isM1 || isM30)) {
            toolNumbers.add(lastSeenTool);
            lastSeenTool = null;
          }
        }
        return Array.from(toolNumbers);
      }
      
      replaceButton.addEventListener("click", () => {
        console.log("--- Starting 'Scan & Replace All' process ---");
        clearMessageBox();
        let fullContent = fileContentTextArea.value;
        let replacementsMade = 0;
        let validationPassed = true;

        const replacementsToApply = [];
        for (let i = 0; i < MAX_INPUT_PAIRS; i++) {
          const findValue = findInputs[i].value.trim();
          let replaceValue = replaceInputs[i].value.trim();

          if (findValue === "" && replaceValue === "") {
            continue;
          }

          if (
            (findValue === "" && replaceValue !== "") ||
            (findValue !== "" && replaceValue === "")
          ) {
            showMessage(
              `Error: Both Find ${i + 1} and Replace ${
                i + 1
              } must be filled or both left empty.`,
              "error"
            );
            validationPassed = false;
            break;
          }

          let effectiveReplaceValue = replaceValue;
          let newTNumericForPair = null;

          if (
            findValue.toUpperCase().startsWith("T") &&
            /\d+/.test(findValue)
          ) {
            const originalTNumeric = parseInt(findValue.match(/\d+/)[0], 10);

            if (replaceValue === "" || replaceValue.toLowerCase() === "t") {
              effectiveReplaceValue = findValue;
              newTNumericForPair = originalTNumeric;
            } else if (/^\d+$/.test(replaceValue)) {
              effectiveReplaceValue = "T" + replaceValue;
              newTNumericForPair = parseInt(replaceValue, 10);
            } else if (
              replaceValue.toUpperCase().startsWith("T") &&
              /\d+/.test(replaceValue)
            ) {
              effectiveReplaceValue = replaceValue;
              newTNumericForPair = parseInt(replaceValue.match(/\d+/)[0], 10);
            } else {
              showMessage(
                `Error: For T-pattern '${findValue}', Replace ${
                  i + 1
                } must be empty, 'T', a number (e.g., '25'), or a full T-pattern (e.g., 'T25').`,
                "error"
              );
              validationPassed = false;
              break;
            }
          } else {
            if (replaceValue === "") {
              effectiveReplaceValue = findValue;
            }
          }

          const pair = {
            find: findValue,
            replace: replaceValue,
            effectiveReplace: effectiveReplaceValue,
            findLabel: `Find ${i + 1}`,
            replaceLabel: `Replace ${i + 1}`,
            originalTNumeric:
              findValue.toUpperCase().startsWith("T") && /\d+/.test(findValue)
                ? parseInt(findValue.match(/\d+/)[0], 10)
                : null,
            newTNumeric: newTNumericForPair,
          };
          replacementsToApply.push(pair);
        }

        if (!validationPassed) {
          return;
        }

        console.log("Replacements to apply:", replacementsToApply);

        const lines = fullContent.split("\n");
        const newLines = [];

        lines.forEach((line) => {
          let processedLine = line;
          
          if (processedLine.toUpperCase().includes("M06")) {
              const tMatch = processedLine.match(/T(\d+)/i);
              if (tMatch) {
                  const tValue = tMatch[1];
                  const newH = `H${tValue}`;
                  const newD = `D${tValue}`;

                  // Regex to replace existing H and D values with the new ones.
                  // It looks for a word that starts with H or D and is followed by a number.
                  const hRegex = /H\d+(\.\d+)?/i;
                  const dRegex = /D\d+(\.\d+)?/i;

                  if (hRegex.test(processedLine)) {
                      processedLine = processedLine.replace(hRegex, newH);
                      replacementsMade++;
                  }
                  
                  if (dRegex.test(processedLine)) {
                      processedLine = processedLine.replace(dRegex, newD);
                      replacementsMade++;
                  }
              }
          } else {
              // If the line doesn't have an M06, apply standard find/replace rules
              replacementsToApply.forEach((pair) => {
                  const findValue = pair.find;
                  const effectiveReplaceValue = pair.effectiveReplace;
                  const escapedFindValue = findValue.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
                  const regex = new RegExp(`\\b${escapedFindValue}\\b`, "gi");

                  if (regex.test(processedLine)) {
                      const initialLine = processedLine;
                      processedLine = processedLine.replace(regex, effectiveReplaceValue);
                      if (initialLine !== processedLine) {
                          replacementsMade++;
                      }
                  }
              });
          }

          newLines.push(processedLine);
        });

        fileContentTextArea.value = newLines.join("\n");
        if (replacementsMade > 0) {
            showMessage(`${replacementsMade} replacements made!`, "success");
        } else {
            showMessage("No replacements made or nothing to replace.", "info");
        }
        console.log(`--- Finished process. Total replacements made: ${replacementsMade} ---`);
        scanAndDisplayPatterns();

        for (let i = 0; i < MAX_INPUT_PAIRS; i++) {
            findInputs[i].value = "";
            replaceInputs[i].value = "";
            if (i > 0) {
                inputPairContainers[i].classList.add("hidden");
            }
        }
        currentFindInputIndex = 0;
      });

      downloadButton.addEventListener("click", () => {
        clearMessageBox();
        const content = fileContentTextArea.value;
        if (!content) {
          showMessage("No content to download!", "error");
          return;
        }

        const blob = new Blob([content], { type: "text/plain" });
        const url = URL.createObjectURL(blob);
        const a = document.createElement("a");
        a.href = url;
        a.download = currentFileName;
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);
        URL.revokeObjectURL(url);

        showMessage("File downloaded successfully!", "success");
      });

      clearButton.addEventListener("click", () => {
        clearMessageBox();
        fileInput.value = "";
        fileNameSpan.textContent = "No file selected";
        fileContentTextArea.value = "";

        for (let i = 0; i < MAX_INPUT_PAIRS; i++) {
          findInputs[i].value = "";
          replaceInputs[i].value = "";
          if (i > 0) {
            inputPairContainers[i].classList.add("hidden");
          }
        }
        currentFileName = "edited_file.nc";
        showMessage("All fields cleared.", "info");
        scanAndDisplayPatterns();
        currentFindInputIndex = 0;
      });

      fileContentTextArea.addEventListener("input", () => {
        scanAndDisplayPatterns();
      });

      window.addEventListener("load", () => {
        createInputPairs();
        scanAndDisplayPatterns();
      });
    </script>
  </body>
</html>
