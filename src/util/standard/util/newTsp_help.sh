#!/bin/bash
newTsp_help() {
  # Define color codes
  local RED='\033[0;31m'
  local GREEN='\033[0;32m'
  local YELLOW='\033[0;33m'
  local BLUE='\033[0;34m'
  local MAGENTA='\033[0;35m'
  local CYAN='\033[0;36m'
  local BOLD='\033[1m'
  local UNDERLINE='\033[4m'
  local NC='\033[0m' # No Color

  echo ""
  echo -e "${BOLD}${CYAN}newTsp${NC} - ${GREEN}TypeScript Project Initializer${NC}"
  echo ""
  echo -e "${BOLD}${YELLOW}USAGE:${NC}"
  echo -e "  ${BLUE}newTsp${NC} ${MAGENTA}<project-name>${NC} [options]"
  echo ""
  echo -e "${BOLD}${YELLOW}ARGUMENTS:${NC}"
  echo -e "  ${MAGENTA}project-name${NC}             Name of the project to create ${RED}(required)${NC}"
  echo ""
  echo -e "${BOLD}${YELLOW}OPTIONS:${NC}"
  echo -e "  ${GREEN}-h, --help${NC}               Display this help message"
  echo -e "  ${GREEN}-n, --node${NC}               Initialize a Node.js backend project"
  echo -e "  ${GREEN}-f, --frontend${NC}           Initialize a frontend project"
  echo -e "  ${GREEN}--typezero${NC}               Initialize using TypeZero template"
  echo ""
  echo -e "  ${CYAN}Combined flags are supported:${NC} ${GREEN}-nf${NC} or ${GREEN}-fn${NC} for Node.js + frontend project"
  echo ""
  echo -e "${BOLD}${YELLOW}PROJECT TYPES:${NC}"
  echo -e "  ${UNDERLINE}${BLUE}Node.js Backend${NC}          Standard TypeScript Node.js backend project with Jest testing"
  echo -e "  ${UNDERLINE}${BLUE}Frontend${NC}                 TypeScript frontend project"
  echo -e "  ${UNDERLINE}${BLUE}Full-Stack${NC}               Combined TypeScript frontend and backend project"
  echo ""
  echo -e "${BOLD}${YELLOW}EXAMPLES:${NC}"
  echo -e "  ${CYAN}# Create a project with interactive type selection${NC}"
  echo -e "  ${BLUE}newTsp${NC} ${MAGENTA}my-project${NC}"
  echo ""
  echo -e "  ${CYAN}# Create a Node.js backend project directly${NC}"
  echo -e "  ${BLUE}newTsp${NC} ${MAGENTA}my-backend${NC} ${GREEN}--node${NC}"
  echo -e "  ${CYAN}# or with shorthand${NC}"
  echo -e "  ${BLUE}newTsp${NC} ${MAGENTA}my-backend${NC} ${GREEN}-n${NC}"
  echo ""
  echo -e "  ${CYAN}# Create a frontend project${NC}"
  echo -e "  ${BLUE}newTsp${NC} ${MAGENTA}my-frontend${NC} ${GREEN}--frontend${NC}"
  echo -e "  ${CYAN}# or with shorthand${NC}"
  echo -e "  ${BLUE}newTsp${NC} ${MAGENTA}my-frontend${NC} ${GREEN}-f${NC}"
  echo ""
  echo -e "  ${CYAN}# Create a full-stack project (Node.js + frontend)${NC}"
  echo -e "  ${BLUE}newTsp${NC} ${MAGENTA}my-fullstack${NC} ${GREEN}--node --frontend${NC}"
  echo -e "  ${CYAN}# or with combined shorthand${NC}"
  echo -e "  ${BLUE}newTsp${NC} ${MAGENTA}my-fullstack${NC} ${GREEN}-nf${NC}"
  echo ""
  echo -e "  ${CYAN}# Create a project using TypeZero template${NC}"
  echo -e "  ${BLUE}newTsp${NC} ${MAGENTA}my-typezero-project${NC} ${GREEN}--typezero${NC}"
  echo ""
  echo -e "${BOLD}${YELLOW}NOTES:${NC}"
  echo -e "  ${CYAN}- If no project type is specified, you will be prompted to select one.${NC}"
  echo -e "  ${CYAN}- The ${GREEN}--typezero${NC} ${CYAN}flag takes precedence over other project type options.${NC}"
  echo -e "  ${CYAN}- All projects are initialized with TypeScript, Jest, and standard configurations.${NC}"
  echo ""
}