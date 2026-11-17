Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794959246;
	b=bl8nZB+KIbkrbvpw2vF7fhz85PiOzv0WKA+fp/IqIuAjeuuTeZHwebW9S3R2oCuRa2yl
	 chqms/3tm8nDXDTBZPEGP7cnii30FvA//75wPnOXlxdYW/5jc5Oiz9JNHaERRJ7qcN940
	 EjbCKjABIcpttBHpyry5DLB6Vs4IlJQ2uQfGqhr/UlNXx26Vtt8tgvtbjQa7kpvsoQMfH
	 0FB7dcMHjn7NXkH3ny9oE4iDgN08Lf0PMK0cCQut32V9mCW8n4t/ZX9d0owSQZDzGuhUQ
	 +Rza+dU9hvJGy/UxVtsh+va7OtAENXO5GzqcHPedJISCIcOqXcvUIb8jJUmhnQTxP0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794959246;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Zbd+bvhenqAq4yISduEhcsN/8GpjIXQqW0OFaXgv7t0=;
	b=ctn8YnATv55mRjhkjo3Maxa30J4OMnP9q3038eR+mcKl6KnIL/OGlwM9LQkGCH0uwUZ5
	 U57VAGsAgtF4Eshb0fC3gXuZNpS4gRHGqLhvYR1RsDuzP8iPuk2CnoEIXtwCwXSF9nO0m
	 tWwfA2ngHv+9qZvXdqJCmLlIwP1dbR7d4Bybvo02E5NB6euErtiO7o/GeZNfJWwW9jx4u
	 ZYNIpNM6PrYD2jzr50K2MdnPAq5RKDlAhClgwDmhh/6oEaXuL6NP2FfFho4z3yFvxM4Pd
	 MghP6rWfGWYkEywt/idYhcOdtRaWp8TXab3ACXnbcCRC+/Nc8hGRGiRf44+MVQhCfFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CYFfr35O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA7A606A31C;
	Tue, 17 Nov 2026 23:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CYFfr35O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838CB1F000C4;
	Tue, 17 Nov 2026 23:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794959245;
	bh=Zbd+bvhenqAq4yISduEhcsN/8GpjIXQqW0OFaXgv7t0=;
	h=From:To:Cc:Subject:Date;
	b=CYFfr35OL+cl2rk8t5QwxK8yk5h6Opez0g8WK+eNWGVVU7VT8bMQWXSB3zuyp874J
	 E/DcCxA2ACBG5JuHR8rUd6WBDKl4obUzM7uyaFU4Bia4raCW/ngmzTzy/jWaHRgC6F
	 ohtvTbzkRSlxiHKZYUABL5qQdSM0XHPcAaoF6awrf4dzTBu6qlC4FHlu9eFqArl+Ot
	 nuofREFLFQ+O1FHrtDhfFHmf/bHd/Whn5NP9sgrFIS0F+/nZDoyO/ucJ9Y4wEcJARR
	 kLuTY/vx2+VSiwpGX7rBjOyyzm5s4ygQa2TmFTtASUxSOdG6qpg3uiNL02OMee+FVd
	 nKXMAHWNTF9Dg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Breno Leitao <leitao@debian.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 0/2] bootconfig: Fix max size padding and initrd memory leak
Date: Wed, 18 Nov 2026 08:47:20 +0900
Message-ID: <179495924003.237695.10973676765152260584.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
User-Agent: StGit/0.19
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

Here are 2 patches to fix pre-existing bootconfig issues around the
bootconfig attached to the initrd image.

[1/2] fixes the bootconfig loader in both the kernel and the bootconfig
tool to exclude the 4-byte alignment padding from the maximum bootconfig
size check. When attaching a bootconfig to an initrd image, the tool
appends 0-3 null padding bytes and includes them in the footer size
field. Although the documentation states that the maximum size (32767
bytes including the terminal null) does not include these padding null
bytes, both the kernel and the tool checked the raw footer size directly
against XBC_DATA_MAX, rejecting a maximum-size bootconfig depending on
the initrd size. This allows up to 3 trailing null padding bytes in the
footer size and strips them before checking XBC_DATA_MAX and parsing.

[2/2] fixes a memory leak of the initrd pages used by the bootconfig.
get_boot_config_from_initrd() trims the bootconfig by decrementing
initrd_end, but the initrd memory is freed with the trimmed initrd_end
while the whole initrd including the bootconfig has been reserved.
Thus the full pages used only by the bootconfig are never freed (up to
8 pages for a 32KB bootconfig). This saves the original initrd_end and
restores it before freeing the initrd memory. If the initrd is retained,
the trimmed initrd_end is kept so that /sys/firmware/initrd does not
expose the bootconfig.

Thank you,

---
base-commit: 381b391bfaa3f10d52da4740529804b0b6b8160d

Masami Hiramatsu (Google) (2):
      bootconfig: Exclude alignment padding from bootconfig max size
      bootconfig: Free the initrd memory used by bootconfig


 include/linux/bootconfig.h          |   24 ++++++++++++++++++++++++
 include/linux/initrd.h              |    2 ++
 init/initramfs.c                    |   10 ++++++++++
 init/main.c                         |   31 ++++++++++++++++++++++---------
 tools/bootconfig/main.c             |   14 ++++++++++----
 tools/bootconfig/test-bootconfig.sh |   17 +++++++++++++++--
 6 files changed, 83 insertions(+), 15 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
