# openv.fish - openv completions for fish shell
#
# To install the completions:
# mkdir -p ~/.config/fish/completions
# cp openv.fish ~/.config/fish/completions

function __fish_print_1password_vaults --description 'Print a list of 1password vaults'
  op list vaults | jq -r '.[].name'
end

function __openv_print_1password_items
  set arg (commandline -opc)
  op list items --vault $arg[2] | jq -r '.[].overview.title'
end

function __openv_current_arg_is_two
  set arg (commandline -opc)
  if [ (count $arg) -eq 2 ]
    return 0
  else
    return 1
  end
end

function __openv_arg_is_get
  set arg (commandline -poc)

  if [ (count $arg) -eq 3 ]
    if [ $arg[3] = 'get' ]
      return 0
    end
  end

  return 1
end

complete -f -c openv -n '__fish_use_subcommand' -a '(__fish_print_1password_vaults)'
complete -f -c openv -n '__openv_current_arg_is_two' -a create -d 'Create an item and save it as a Password category in specified vault.'
complete -f -c openv -n '__openv_current_arg_is_two' -a get -d 'Get for specified items in specified vault.'
complete -f -c openv -n '__openv_current_arg_is_two' -a list -d 'List for all items in specified vault.'

# get
complete -f -c openv -n '__openv_arg_is_get' -a '-n' -d 'Specify an item name one or more in the vault.'
complete -f -c openv -n '__fish_contains_opt -s n' -a '(__openv_print_1password_items)'
