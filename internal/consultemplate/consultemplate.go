package consultemplate

import (
	"os"
)

// Run executes the bundled consul-template CLI with the provided argv.
func Run(args []string) int {
	cli := NewCLI(os.Stdout, os.Stderr)
	return cli.Run(args)
}
