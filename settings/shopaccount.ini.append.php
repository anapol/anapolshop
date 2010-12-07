<?php /*#?ini charset="iso-8859-1"?

[HandlerSettings]
Repositories[]=kernel/classes
ExtensionRepositories[]=anapolshop

[AccountSettings]
Handler=ezuser
Alias[]
Alias[ezuser]=aa

# Settings for how order emails should be handled in the shop/checkout
# default is to send confirmation emails to both customer and admin.
[ConfirmOrderSettings]
Handler=ezdefault
# Allows for overriding a handler with another
Alias[ezdefault]=aacustom



*/ ?>