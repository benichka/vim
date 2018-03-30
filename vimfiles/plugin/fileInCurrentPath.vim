" facilitation de la navigation depuis le fichier courant

cnoremap %% <C-R>=fnameescape(expand('%:h')).'\'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%
