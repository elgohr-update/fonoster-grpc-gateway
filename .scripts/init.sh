#!/usr/bin/env sh

BRANCH=master

npx wget https://raw.githubusercontent.com/fonoster/fonoster/$BRANCH/mods/core/src/protos/common.proto -O protos/common.proto
npx wget https://raw.githubusercontent.com/fonoster/fonoster/$BRANCH/mods/users/src/protos/users.proto -O protos/users.proto
npx wget https://raw.githubusercontent.com/fonoster/fonoster/$BRANCH/mods/projects/src/protos/projects.proto -O protos/projects.proto
npx wget https://raw.githubusercontent.com/fonoster/fonoster/$BRANCH/mods/agents/src/protos/agents.proto -O protos/agents.proto
npx wget https://raw.githubusercontent.com/fonoster/fonoster/$BRANCH/mods/domains/src/protos/domains.proto -O protos/domains.proto
npx wget https://raw.githubusercontent.com/fonoster/fonoster/$BRANCH/mods/providers/src/protos/providers.proto -O protos/providers.proto
npx wget https://raw.githubusercontent.com/fonoster/fonoster/$BRANCH/mods/numbers/src/protos/numbers.proto -O protos/numbers.proto
npx wget https://raw.githubusercontent.com/fonoster/fonoster/$BRANCH/mods/callmanager/src/protos/callmanager.proto -O protos/callmanager.proto
npx wget https://raw.githubusercontent.com/fonoster/fonoster/$BRANCH/mods/auth/src/protos/auth.proto -O protos/auth.proto
npx wget https://raw.githubusercontent.com/fonoster/fonoster/$BRANCH/mods/funcs/src/protos/funcs.proto -O protos/funcs.proto
npx wget https://raw.githubusercontent.com/fonoster/fonoster/$BRANCH/mods/secrets/src/protos/secrets.proto -O protos/secrets.proto
npx wget https://raw.githubusercontent.com/fonoster/fonoster/$BRANCH/mods/storage/src/protos/storage.proto -O protos/storage.proto