# Checks if executable exists in current path
RUBY := $(shell command -v ruby 2>/dev/null)
HOMEBREW := $(shell command -v brew 2>/dev/null)
PODS_VERSION := 1.12.1
# cocoapods installed version 
INSTALLED_VERSION := $(shell gem list cocoapods -i -v $(PODS_VERSION))
# Check if SwiftLint is installed
SWIFTLINT_INSTALLED := $(shell command -v swiftlint 2> /dev/null)

# Default target, if no is provided
default: setup

# Steps for project environment setup
setup: \
				pre_setup \
				check_for_ruby \
				install_SwiftLint \
				install_cocoapods \
				install_pods \
				after_setup

# Pre-setup steps
pre_setup:
				$(info Starting Movies App setup ...)

# Check if Ruby is installed
check_for_ruby:
				$(info Checking for Ruby ...)

ifeq ($(RUBY),)
				$(error Ruby is not installed)
endif

# Check if Homebrew is available
check_for_Homebrew:
				$(info Checking for Homebrew ...)

ifeq ($(HOMEBREW),)
				$(error Homebrew is not installed)
endif

# Update SwiftLint
install_SwiftLint:
	           $(info install swiftLint ...)
	        @if [ -z "$(SWIFTLINT_INSTALLED)" ]; then \
	            echo "Installing SwiftLint..."; \
	            brew install swiftlint; \
	        else \
	            echo "SwiftLint is already installed."; \
            fi

# Install Cocoapods
install_cocoapods:
				@echo "Checking for CocoaPods version $(PODS_VERSION) ..."
		@if [ "$(INSTALLED_VERSION)" = "false" ]; then \
    		echo "Installing CocoaPods version $(PODS_VERSION) ..."; \
	    	sudo gem install cocoapods -v $(PODS_VERSION); \
		else \
	    	echo "CocoaPods version $(PODS_VERSION) is already installed."; \
	   fi

# Install Cocoapods dependencies
install_pods:
				$(info Install pods ...)
				pod install

# After-setup steps
after_setup:
				$(info Finished setup Movies App)
					@say "Finished setup Movies App"

