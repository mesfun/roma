

=
O100( 39001.TAP )
( FORMAT: FANUC 11M [EMS] CJ08.16.7.PST )
( 4/30/12 AT 10:36 AM )
N1G0G28G61G91G99Z0.
N2G49
/( TOOL CHANGE, TOOL #1 )
/( DIAMETER = .25 ROUGH ENDMILL )
/( ROD STOP )
/( OPERATION 1: HOLES )
/( CS#1 - G54 )
/N3T1M6
/N4G0G17G54G61G90X-.325Y1.208
/N5G43Z1.H1
/N6Z.05
/N7Z-.1
/N8M0
/N9G0Z.05
/N10M9
/N11G0G28G91Z0.M5
/N12G49
/N13M1
( TOOL CHANGE, TOOL #2 )
( DIAMETER = 3.15 SHELL ENDMILL )
( OPERATION 2: ROUGHING )
( CS#1 - G54 )
N14T2M6
N15S4000M3
N16G0G17G54G61G90X6.5748Y-1.115M8
N17G43Z1.H2
N18Z.05
N19Z0.
N20G1X-2.2748F50.
N21Y1.535
N22X6.5748
N23G0Z.05
N24M9
N25G0G28G91Z0.M5
N26G49
N27M1
( TOOL CHANGE, TOOL #3 )
( DIAMETER = .25 SPOT DRILL )
( OPERATION 3: HOLES )
( CS#1 - G54 )
N28T3M6
N29S4000M3
N30G0G17G54G61G90X0.Y0.M8
N31G43Z1.H3
N32Z.05
N33G81G99R.05Z-.054F10.
N34X4.293
N35G80Z.05
N36M9
N37G0G28G91Z0.M5
N38G49
N39M1
( TOOL CHANGE, TOOL #4 )
( DIAMETER = .089 DRILL )
( OPERATION 4: HOLES )
( CS#1 - G54 )
N40T4M6
N41S4000M3
N42G0G17G54G61G90X0.Y0.M8
N43G43Z1.H4
N44Z.05
N45G83G99R.05Z-.4607Q.089F10.
N46X4.293
N47G80Z.05
N48M9
N49G0G28G91Z0.M5
N50G49
N51M1
( TOOL CHANGE, TOOL #5 )
( DIAMETER = .0938 ROUGH ENDMILL )
( OPERATION 5: HOLES )
( CS#1 - G54 )
N52T5M6
N53S4000M3
N54G0G17G54G61G90X0.Y0.M8
N55G43Z1.H5
N56Z.05
N57G83G99R.05Z-.435Q.15F10.
N58X4.293
N59G80Z.05
N60M9
N61G0G28G91Z0.M5
N62G49
N63M1
( TOOL CHANGE, TOOL #6 )
( DIAMETER = .098 REAMER )
( OPERATION 6: HOLES )
( CS#1 - G54 )
N64T6M6
N65S3500M3
N66G0G17G54G61G90X0.Y0.M8
N67G43Z1.H6
N68Z.05
N69G81G99R.05Z-.445F20.
N70X4.293
N71G80Z.05
N72M9
N73G0G28G91Z0.M5
N74G49
N75M1
( TOOL CHANGE, TOOL #7 )
( DIAMETER = .0625 BALL ENDMILL )
( BALL E-M ENGRAVING )
( OPERATION 7: CONTOUR )
( CS#1 - G54 )
N76T7M6
N77S4000M3
N78G0G17G54G61G90X1.573Y.0672M8
N79G43Z1.H7
N80Z.05
N81G1Z-.0025F5.
N82X1.5939Y.0884
N83Y-.0381
N84G0Z.05
N85X1.6151
N86G1Z-.0025
N87X1.573
N88G0Z.05
N89X1.7953Y.0672
N90G1Z-.0025
N91X1.8163Y.0884
N92Y-.0381
N93G0Z.05
N94X1.6632Y.0238
N95G1Z-.0025
N96Y-.0073
N97G3X1.6724Y-.0291I.031J.0003
N98X1.6943Y-.0384I.0221J.0217
N99G1X1.715
N100G3X1.7369Y-.0292I-.0001J.0311
N101X1.746Y-.0073I-.0219J.0219
N102G1X1.7465Y.0521
N103G3X1.7374Y.076I-.0379J-.0007
N104X1.715Y.0879I-.0238J-.018
N105G1X1.6943
N106G3X1.6724Y.0778I.0005J-.0298
N107X1.6632Y.0548I.0249J-.0234
N108G1Y.0238
N109G0Z.05
N110X1.8375Y-.0381
N111G1Z-.0025
N112X1.7953
N113G0Z.05
N114X1.9598Y.0775
N115G1Z-.0025
N116G3X1.9376Y.0866I-.0221J-.0222
N117G1X1.9169
N118G3X1.8948Y.0774I.0001J-.0312
N119X1.8856Y.0553I.022J-.0222
N120G1Y-.0071
N121G3X1.8948Y-.0291I.0312J.0002
N122X1.9169Y-.0384I.0222J.022
N123G1X1.9376
N124G3X1.9597Y-.0291I-.0001J.0313
N125X1.9689Y-.0071I-.022J.0222
N126G1Y.0137
N127G3X1.9595Y.0356I-.0312J-.0004
N128X1.9376Y.045I-.0222J-.0218
N129G1X1.9169
N130G3X1.8948Y.0357I.0001J-.0313
N131X1.8856Y.0137I.022J-.0222
N132G0Z.05
N133X2.071Y.0775
N134G1Z-.0025
N135G3X2.0488Y.0866I-.0221J-.0222
N136G1X2.0281
N137G3X2.006Y.0774I.0001J-.0312
N138X1.9968Y.0553I.022J-.0222
N139G1Y-.0071
N140G3X2.006Y-.0291I.0312J.0002
N141X2.0281Y-.0384I.0222J.022
N142G1X2.0488
N143G3X2.0709Y-.0291I-.0001J.0313
N144X2.0801Y-.0071I-.0221J.0222
N145G1Y.0137
N146G3X2.0707Y.0356I-.0312J-.0004
N147X2.0488Y.045I-.0222J-.0218
N148G1X2.0281
N149G3X2.006Y.0357I.0001J-.0313
N150X1.9968Y.0137I.022J-.0222
N151G0Z.05
N152X2.1171Y-.0292
N153G1Z-.0025
N154G3X2.1393Y-.0384I.0221J.0222
N155G1X2.16
N156G3X2.1821Y-.0291I-.0001J.0313
N157X2.1913Y-.0071I-.0221J.0222
N158G1Y.0553
N159G3X2.1819Y.0773I-.0312J-.0003
N160X2.16Y.0866I-.0223J-.0218
N161G1X2.1393
N162G3X2.1172Y.0774I.0001J-.0312
N163X2.108Y.0553I.022J-.0222
N164G1Y.0346
N165G3X2.1172Y.0125I.0312J.0001
N166X2.1393Y.0033I.0222J.0221
N167G1X2.16
N168G3X2.1821Y.0125I-.0001J.0313
N169X2.1913Y.0346I-.0221J.0222
N170G0Z.05
N171X2.2315Y.0785
N172G1Z-.0025
N173G2X2.2527Y.0879I.0215J-.02
N174G1X2.2727
N175G2X2.2939Y.0784I-.0002J-.0287
N176X2.3025Y.0563I-.0243J-.0222
N177X2.2939Y.0342I-.0329J.0001
N178X2.2727Y.0248I-.0214J.0193
N179X2.2939Y.0153I-.0002J-.0288
N180X2.3025Y-.0068I-.0243J-.0222
N181X2.2937Y-.0287I-.0322J.0001
N182X2.2727Y-.0381I-.0213J.0195
N183G1X2.2527
N184G2X2.2315Y-.029I.0002J.0297
N185G0Z.05
N186X2.3304Y.0866
N187G1Z-.0025
N188X2.4137
N189G0Z.05
N190X2.372Y-.0384
N191G1Z-.0025
N192Y.0866
N193G0Z.05
N194X2.4415Y.0876
N195G1Z-.0025
N196Y-.0384
N197X2.5249
N198G0Z.05
N199X2.5527Y.0144
N200G1Z-.0025
N201X2.6351
N202G0Z.05
N203X2.6849Y.0672
N204G1Z-.0025
N205X2.7058Y.0884
N206Y-.0381
N207G0Z.05
N208X2.727
N209G1Z-.0025
N210X2.6849
N211G0Z.05
N212M9
N213G0G28G91Z0.M5
N214G49
N215M1
( TOOL CHANGE, TOOL #8 )
( DIAMETER = .5 ROUGH ENDMILL )
( OPERATION 8: ROUGHING )
( CS#1 - G54 )
N216T8M6
N217S4000M3
N218G0G17G54G61G90X3.183Y1.0342M8
N219G43Z1.H8
N220Z.05
N221G1Z-.1217F10.
N222G41D58X3.233
N223Y1.408F20.
N224G2X3.493Y1.668I.26
N225G1X4.393
N226G2X4.653Y1.408J-.26
N227G1Y-.1
N228G2X4.5065Y-.3339I-.26
N229G1X2.6965Y-1.2121
N230G2X2.583Y-1.2381I-.1135J.234
N231G1X1.71
N232G2X1.5965Y-1.2121J.26
N233G1X-.2135Y-.3339
N234G2X-.36Y-.1I.1135J.2339
N235G1Y1.408
N236G2X-.1Y1.668I.26
N237G1X.8
N238G2X1.06Y1.408J-.26
N239G1Y.6605
N240X3.233
N241Y1.0342
N242Y1.0842
N243G40X3.183
N244G0Z.05
N245Y1.0342
N246Z-.0717
N247G1Z-.2433F10.
N248G41X3.233
N249Y1.408F20.
N250G2X3.493Y1.668I.26
N251G1X4.393
N252G2X4.653Y1.408J-.26
N253G1Y-.1
N254G2X4.5065Y-.3339I-.26
N255G1X2.6965Y-1.2121
N256G2X2.583Y-1.2381I-.1135J.234
N257G1X1.71
N258G2X1.5965Y-1.2121J.26
N259G1X-.2135Y-.3339
N260G2X-.36Y-.1I.1135J.2339
N261G1Y1.408
N262G2X-.1Y1.668I.26
N263G1X.8
N264G2X1.06Y1.408J-.26
N265G1Y.6605
N266X3.233
N267Y1.0342
N268Y1.0842
N269G40X3.183
N270G0Z.05
N271Y1.0342
N272Z-.1933
N273G1Z-.365F10.
N274G41X3.233
N275Y1.408F20.
N276G2X3.493Y1.668I.26
N277G1X4.393
N278G2X4.653Y1.408J-.26
N279G1Y-.1
N280G2X4.5065Y-.3339I-.26
N281G1X2.6965Y-1.2121
N282G2X2.583Y-1.2381I-.1135J.234
N283G1X1.71
N284G2X1.5965Y-1.2121J.26
N285G1X-.2135Y-.3339
N286G2X-.36Y-.1I.1135J.2339
N287G1Y1.408
N288G2X-.1Y1.668I.26
N289G1X.8
N290G2X1.06Y1.408J-.26
N291G1Y.6605
N292X3.233
N293Y1.0342
N294Y1.0842
N295G40X3.183
N296G0Z.05
( OPERATION 9: ROUGHING )
( CS#1 - G54 )
N297G0G90X2.6948Y.7005
N298G1Z-.1875F10.
N299G41D58Y.6505
N300X3.243F20.
N301Y1.408
N302G2X3.493Y1.658I.25
N303G1X4.393
N304G2X4.643Y1.408J-.25
N305G1Y-.1
N306G2X4.5021Y-.3249I-.25
N307G1X2.6921Y-1.2031
N308G2X2.583Y-1.2281I-.1091J.225
N309G1X1.71
N310G2X1.6009Y-1.2031J.25
N311G1X-.2091Y-.3249
N312G2X-.35Y-.1I.1091J.2249
N313G1Y1.408
N314G2X-.1Y1.658I.25
N315G1X.8
N316G2X1.05Y1.408J-.25
N317G1Y.6505
N318X2.6948
N319X2.7448
N320G40Y.7005
N321G0Z.05
N322X2.6948
N323Z-.1375
N324G1Z-.375F10.
N325G41Y.6505
N326X3.243F20.
N327Y1.408
N328G2X3.493Y1.658I.25
N329G1X4.393
N330G2X4.643Y1.408J-.25
N331G1Y-.1
N332G2X4.5021Y-.3249I-.25
N333G1X2.6921Y-1.2031
N334G2X2.583Y-1.2281I-.1091J.225
N335G1X1.71
N336G2X1.6009Y-1.2031J.25
N337G1X-.2091Y-.3249
N338G2X-.35Y-.1I.1091J.2249
N339G1Y1.408
N340G2X-.1Y1.658I.25
N341G1X.8
N342G2X1.05Y1.408J-.25
N343G1Y.6505
N344X2.6948
N345X2.7448
N346G40Y.7005
N347G0Z.05
N348M9
N349G0G28G91Z0.M5
N350G49
N351M1
( TOOL CHANGE, TOOL #9 )
( DIAMETER = .125 SPOT DRILL )
( V E-M  DEBURRING )
( OPERATION 10: ROUGHING )
( CS#1 - G54 )
N352T9M6
N353S4000M3
N354G0G17G54G61G90X2.6948Y.4555M8
N355G43Z1.H9
N356Z.05
N357Z-.04
N358G41D59G1Y.4355F20.
N359X3.243
N360G3X3.458Y.6505J.215
N361G1Y1.408
N362G2X3.493Y1.443I.035
N363G1X4.393
N364G2X4.428Y1.408J-.035
N365G1Y-.1
N366G2X4.4083Y-.1315I-.035
N367G1X2.5983Y-1.0096
N368G2X2.583Y-1.0131I-.0153J.0315
N369G1X1.71
N370G2X1.6947Y-1.0096J.035
N371G1X-.1153Y-.1315
N372G2X-.135Y-.1I.0153J.0315
N373G1Y1.408
N374G2X-.1Y1.443I.035
N375G1X.8
N376G2X.835Y1.408J-.035
N377G1Y.6505
N378G3X1.05Y.4355I.215
N379G1X2.6948
N380X2.7148
N381G40Y.4555
N382G0Z.05
N383M9
N384G0G28G91Z0.M5
N385G49
N386G28Y0.
N387M30
( FILE LENGTH: 7506 CHARACTERS )








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
