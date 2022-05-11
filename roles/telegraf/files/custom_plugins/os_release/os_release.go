// Mostly an InfluxDB line protocol implementation of:
// https://github.com/prometheus/node_exporter/blob/da8b0f694ceadd3013096f6e8671cdd70a98da24/collector/os_release.go
package main

import (
	"fmt"
	"io"
	"os"
	"regexp"
	"strconv"
	"strings"

	envparse "github.com/hashicorp/go-envparse"
)

const osReleaseFilePath = "/etc/os-release"

var (
	versionRegex = regexp.MustCompile(`^[0-9]+\.?[0-9]*`)
)

type osRelease struct {
	BuildID         string
	ID              string
	IDLike          string
	ImageID         string
	ImageVersion    string
	Name            string
	PrettyName      string
	Variant         string
	VariantID       string
	Version         string
	VersionCodename string
	VersionID       string
}

func parseOSRelease(r io.Reader) (*osRelease, error) {
	env, err := envparse.Parse(r)
	return &osRelease{
		BuildID:         env["BUILD_ID"],
		ID:              env["ID"],
		IDLike:          env["ID_LIKE"],
		ImageID:         env["IMAGE_ID"],
		ImageVersion:    env["IMAGE_VERSION"],
		Name:            env["NAME"],
		PrettyName:      env["PRETTY_NAME"],
		Variant:         env["VARIANT"],
		VariantID:       env["VARIANT_ID"],
		Version:         env["VERSION"],
		VersionCodename: env["VERSION_CODENAME"],
		VersionID:       env["VERSION_ID"],
	}, err
}

func main() {
	releaseFile, err := os.Open(osReleaseFilePath)
	if err != nil {
		fmt.Errorf("error opening os-release file: %s", err)
	}
	defer releaseFile.Close()

	info, err := parseOSRelease(releaseFile)
	if err != nil {
		fmt.Errorf("error parsing os-release file: %s", err)
	}

	name := strings.ReplaceAll(info.Name, " ", "\\ ")

	var version float64
	majorMinor := versionRegex.FindString(info.VersionID)
	if majorMinor != "" {
		version, err = strconv.ParseFloat(majorMinor, 64)
		if err != nil {
			fmt.Errorf("error parsing VERSION_ID: %s", err)
		}
	} else {
		version = 0
	}

	if info.IDLike != "" {
		fmt.Printf("os_release,name=%s,version_codename=%s,id=%s,id_like=%s version=%.2f\n", name, info.VersionCodename, info.ID, info.IDLike, version)
	} else {
		fmt.Printf("os_release,name=%s,version_codename=%s,id=%s version=%.2f\n", name, info.VersionCodename, info.ID, version)
	}
}
