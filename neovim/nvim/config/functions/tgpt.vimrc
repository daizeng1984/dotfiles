if has('nvim')
" tgpt
lua <<EOF
    local result = vim.fn.executable("tgpt")
    if result == 1 then
        -- Function to replace selected text with AI result from `tgpt`
        function ReplaceWithAIResult()
            -- Get the current visual selection range
            local start_line, start_col = unpack(vim.api.nvim_buf_get_mark(0, '<'))
            local end_line, end_col = unpack(vim.api.nvim_buf_get_mark(0, '>'))
            if start_line == 0 and start_col == 0 then
                return
            end
            if end_line == 0 and end_col == 0 then
                return
            end

            -- Get the selected text
            local lines = vim.fn.getline(start_line, end_line)

            -- Adjust for single-line selection (column range)
            if #lines == 1 then
                lines[1] = string.sub(lines[1], start_col, end_col)
            else
                -- For multiline selections, adjust `end_col` to the length of the last line
                lines[1] = string.sub(lines[1], start_col)
                lines[#lines] = string.sub(lines[#lines], 1, end_col)
            end
            local selected_text = table.concat(lines, "\n")

            -- Prepare the shell command that will pass the selected text to `tgpt`
            local cmd = "cat <<EOF | tgpt --provider duckduckgo --preprompt 'You are an English expert. Please edit following to make it better English. From now, you just return the edited text (no quote or unrelated sentence). The following is the text to edit: ' -w\n" .. selected_text .. "\nEOF\n"

            -- print(cmd)

            local result = vim.fn.system(cmd)
            -- print(result)

            -- vim.api.nvim_buf_set_text(0, start_line - 1, start_col, end_line - 1, end_col, { result })
            local output_lines = vim.split(result, "\n", { plain = true, trimempty = true })
            vim.api.nvim_buf_set_lines(0, end_line, end_line, false, output_lines)
        end

        vim.api.nvim_create_user_command("AIEdit", ReplaceWithAIResult, { nargs = 0, range = true })
    else
        print("tgpt not installed")
    

    end
EOF
endif

