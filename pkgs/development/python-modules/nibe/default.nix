{ lib
, aiohttp
, aresponses
, async-modbus
, async-timeout
, buildPythonPackage
, construct
, exceptiongroup
, fetchFromGitHub
, pytest-asyncio
, pytestCheckHook
, pythonOlder
, setuptools
, tenacity
}:

buildPythonPackage rec {
  pname = "nibe";
  version = "2.5.1";
  pyproject = true;

  disabled = pythonOlder "3.9";

  src = fetchFromGitHub {
    owner = "yozik04";
    repo = "nibe";
    rev = "refs/tags/${version}";
    hash = "sha256-9pnY3ssDLxPmMMRT6TexkGcYDTzuB5dAP8VHCTAwD7I=";
  };

  nativeBuildInputs = [
    setuptools
  ];

  propagatedBuildInputs = [
    async-modbus
    async-timeout
    construct
    exceptiongroup
    tenacity
  ];

  nativeCheckInputs = [
    aresponses
    pytest-asyncio
    pytestCheckHook
  ];

  pythonImportsCheck = [
    "nibe"
  ];

  meta = with lib; {
    description = "Library for the communication with Nibe heatpumps";
    homepage = "https://github.com/yozik04/nibe";
    changelog = "https://github.com/yozik04/nibe/releases/tag/${version}";
    license = with licenses; [ gpl3Plus ];
    maintainers = with maintainers; [ fab ];
  };
}
