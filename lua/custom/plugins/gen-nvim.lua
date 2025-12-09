return {
  'David-Kunz/gen.nvim',
  config = function()
    require('gen').prompts['Change'] = {
      prompt = 'Change the following text, $input, just output the final text without additional quotes around it:\n$text',
      replace = false,
      model = 'gemma3:12b',
    }
    require('gen').prompts['Enhance_Grammar_Spelling'] = {
      prompt = 'Modify the following text to improve grammar and spelling, just output the final text without additional quotes around it:\n$text',
      replace = false,
      model = 'gemma3:12b',
    }
    require('gen').prompts['Enhance_Wording'] = {
      prompt = 'Modify the following text to use better wording, just output the final text without additional quotes around it:\n$text',
      replace = false,
      model = 'gemma3:12b',
    }
    require('gen').prompts['Make_Concise'] = {
      prompt = 'Modify the following text to make it as simple and concise as possible, just output the final text without additional quotes around it:\n$text',
      replace = false,
      model = 'gemma3:12b',
    }
    require('gen').prompts['Make_List'] = {
      prompt = 'Render the following text as a markdown list:\n$text',
      replace = false,
      model = 'mistral',
    }
    require('gen').prompts['Make_Table'] = {
      prompt = 'Render the following text as a markdown table:\n$text',
      replace = false,
      model = 'mistral',
    }
    require('gen').prompts['Enhance_Code'] = {
      prompt = 'Enhance the following code, only output the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```',
      replace = false,
      extract = '```$filetype\n(.-)```',
      model = 'deepseek-r1:14b',
    }
    require('gen').prompts['Change_Code'] = {
      prompt = 'Regarding the following code, $input, only output the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```',
      replace = false,
      extract = '```$filetype\n(.-)```',
      model = 'deepseek-r1:14b',
    }
  end,
  opts = {
    model = 'qwen2.5-coder:14b', -- The default model to use.
    quit_map = 'q', -- set keymap to close the response window
    retry_map = '<c-r>', -- set keymap to re-send the current prompt
    accept_map = '<c-cr>', -- set keymap to replace the previous selection with the last result
    host = 'localhost', -- The host running the Ollama service.
    port = '11434', -- The port on which the Ollama service is listening.
    display_mode = 'vertical-split', -- The display mode. Can be "float" or "split" or "horizontal-split" or "vertical-split".
    show_prompt = true, -- Shows the prompt submitted to Ollama. Can be true (3 lines) or "full".
    show_model = true, -- Displays which model you are using at the beginning of your chat session.
    no_auto_close = true, -- Never closes the window automatically.
    file = true, -- Write the payload to a temporary file to keep the command short.
    hidden = false, -- Hide the generation window (if true, will implicitly set `prompt.replace = true`), requires Neovim >= 0.10
    init = function(options)
      pcall(io.popen, 'ollama serve > /dev/null 2>&1 &')
    end,
    -- Function to initialize Ollama
    command = function(options)
      local body = { model = options.model, stream = true }
      return 'curl --silent --no-buffer -X POST http://' .. options.host .. ':' .. options.port .. '/api/chat -d $body'
    end,
    -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
    -- This can also be a command string.
    -- The executed command must return a JSON object with { response, context }
    -- (context property is optional).
    -- list_models = '<omitted lua function>', -- Retrieves a list of model names
    result_filetype = 'markdown', -- Configure filetype of the result buffer
    debug = false, -- Prints errors and the command which is run.
  },
  keys = {
    {
      '<leader>gsm',
      function()
        require('gen').select_model()
      end,
      desc = '[G]en [S]elect [M]odel',
    },
    {
      '<leader>gq',
      '<cmd>Gen Chat<cr>',
      desc = '[G]en Chat / [Q]uery: prompt only',
    },
    {
      '<leader>ga',
      '<cmd>Gen Ask<cr>',
      mode = { 'n' },
      desc = '[G]en [A]sk: prompt + file content',
    },
    {
      '<leader>ga',
      ":'<,'>Gen Ask<cr>",
      mode = { 'v' },
      desc = '[G]en [A]sk: prompt + file content',
    },
    {
      '<leader>gw',
      '<cmd>Gen Enhance_Wording<cr>',
      mode = { 'n' },
      desc = '[G]en Enhance [W]ording: file content',
    },
    {
      '<leader>gw',
      ":'<,'>Gen Enhance_Wording<cr>",
      mode = { 'v' },
      desc = '[G]en Enhance [W]ording: file content',
    },
    {
      '<leader>gc',
      '<cmd>Gen Change_Code<cr>',
      mode = { 'n' },
      desc = '[G]en Change [C]ode: prompt + file content',
    },
    {
      '<leader>gc',
      ":'<,'>Gen Change_Code<cr>",
      mode = { 'v' },
      desc = '[G]en Change [C]ode: prompt + file content',
    },
  },
}
