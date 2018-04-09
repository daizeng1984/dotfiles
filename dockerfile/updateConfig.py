import os
import json

docker_config_file = os.path.expanduser("~/.docker/config.json")

docker_config = json.load(open(docker_config_file))

print('Processing config file [{0}]. and its current config is: \n {1}'.format(docker_config_file, docker_config))

docker_config['detachKeys'] = 'ctrl-b,x'

print('Changed config to: \n {0}'.format(docker_config))

json.dump(docker_config, open(docker_config_file, 'w'))
