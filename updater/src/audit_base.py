class PlatformDownloadJSON:
    def __init__(self, name: str, release_url: str, checksum: str) -> None:
        self.name = name
        self.release_url = release_url
        self.checksum = checksum

    def __str__(self) -> str:
        return f"{self.name}:[ReleaseUrl={self.release_url},Checksum={self.checksum}]"


class AuditJSON:
    def __init__(
        self,
        iteration: int,
        version_tag: str,
        source_download: str,
        platform: list[PlatformDownloadJSON],
    ) -> None:
        self.iteration = iteration
        self.version_tag = version_tag
        self.source_download = source_download
        self.platform = platform

    def __str__(self) -> str:
        platform_str = ""
        for plat in self.platform:
            platform_str += str(plat) + " "
        return f"Iteration={self.iteration}\nVersionTag={self.version_tag}\nSrcDownloadURL={self.source_download}\nPlatforms=[ {platform_str} ]"
