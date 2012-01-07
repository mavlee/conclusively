UPSTART_DIR      = deploy
UPSTART_FILES    = $(wildcard $(UPSTART_DIR)/*.conf.template)

NODE_VERSION     = v0.6.6

upstart_prod:
	@sudo cp $(UPSTART_FILES) /etc/init
	@sudo sed 's/NODE_VERSION/$(NODE_VERSION)/' \
		$(UPSTART_DIR)/conclusively.conf.template > /etc/init/conclusively.conf
