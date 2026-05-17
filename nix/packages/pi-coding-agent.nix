{ lib, buildNpmPackage, fetchurl }:

buildNpmPackage {
  pname = "pi-coding-agent";
  version = "0.70.2";

  src = fetchurl {
    url = "https://registry.npmjs.org/@mariozechner/pi-coding-agent/-/pi-coding-agent-0.70.2.tgz";
    hash = "sha256-bv+JqGQb0tIUXkm4B7f874y9VUzxlP/DHRq+DjYGddU=";
  };

  # The npm tarball has no package-lock.json; use the one generated from the published package.json
  postPatch = ''
    cp ${./pi-coding-agent-lock.json} package-lock.json
  '';

  npmDepsHash = "sha256-bG1Hg8sH8kY0IEkL2CWdscrVLMVL6PDfDkTS5RviPDg=";
  dontNpmBuild = true;

  meta = with lib; {
    description = "Coding agent CLI with read, bash, edit, write tools and session management";
    homepage = "https://www.npmjs.com/package/@mariozechner/pi-coding-agent";
    license = licenses.mit;
    mainProgram = "pi";
  };
}
