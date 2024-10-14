vim.api.nvim_create_user_command('Bitbucket', function(opts)
    local function open_in_bitbucket(lines)
        local file_path = vim.fn.expand('%:p')

        if not lines then
            vim.cmd('!open_in_bitbucket.py ' .. file_path)
        else
            vim.cmd('!open_in_bitbucket.py ' .. file_path .. ' --lines ' .. lines)
        end
    end

    if opts.range == 0 then
        open_in_bitbucket()
    elseif opts.line1 == opts.line2 then
        open_in_bitbucket(opts.line1)
    else
        open_in_bitbucket(opts.line1 .. '-' .. opts.line2)
    end
end, { range = true })
