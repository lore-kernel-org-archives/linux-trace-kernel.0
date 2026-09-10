Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664FA35BDCE;
	Thu, 10 Sep 2026 01:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789005581; cv=none; b=BO1h/BOO8hLhqhZi8lJZupnFQDtHhKPPKiBzcEnt7YUGtKufpcSk3AoYMaAgXsll1Y12MX3k/ZJlyKHjo+JYB+MvFdvfpf9rGGj+QEYG/01/4AnSJYkg6fl3Cc0mPhdUR+ERyI4hCY8z+jzYhChnqThKECexx5jyLmrGJ1qIF/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789005581; c=relaxed/simple;
	bh=tuLFy4CnFI1sLpDBfq2qp1sYyUC6/gLpKHNZk+/u8Oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QvD77k+il11GIAQhlcoopemISbeKz3C4wZU0Ui4iZsDe/lGHW5m4W+Vuql+VXHjoLm0RUifkjRWC69R8WiypYajCZoAyL+tNa0Tbyrb8mQiQdUrYZoQe22b4rUiFihftaU5L5h1PmoC2pNRx+YzFszKz7ZSZ+h/ZzFsTrqvEn2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nABiD3E5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nABiD3E5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE351F000FF;
	Thu, 10 Sep 2026 01:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789005580;
	bh=uL8G2pB2hpIG7cQhF+3FBqt0SSnfDbuFBozzmXA2QYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nABiD3E5I9XqRQhEEtFF0FVhc5E6sxnu0vHOUSHllko6zUubhb6DbDLs4Y3GHCO30
	 YuoI0mBH8IU2JL+IFO8u1xe3RDk+JhuNHnKPkUtHfzdYi6EmwO3lc+eZVpHqzvoAED
	 eUcQNePEOl+i12/Sja5D9wVis8+5vIzBrqNr+hgWYdE4scDfQxptN7fDt6oSWuh+CP
	 SDJ8UV0ZIh+Mz1sRwQ7WshgrWWszweyV0BF0pVI0a92MPmVWfSgAV4D89FLZOaMRkf
	 H+6Y/Tw0iCO6NPaLJu1j38rQMZmgO2fLdaH9OFMV/+kJZwAxsksNDwbux2PGzbcHHm
	 6pVhoqfZ0wf+A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Breno Leitao <leitao@debian.org>,
	Christian Brauner <brauner@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Douglas Anderson <dianders@chromium.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>
Subject: [PATCH v3 2/2] bootconfig: Fix integer overflow in initrd size check
Date: Thu, 10 Sep 2026 10:59:35 +0900
Message-ID: <178900557529.200943.11099215789605267709.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178900555453.200943.4719889510443114485.stgit@devnote2>
References: <178900555453.200943.4719889510443114485.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko reported that in get_boot_config_from_initrd(), a crafted initrd
with a huge bootconfig size (such as 0xFFFFFFFF) can cause the pointer
arithmetic:

    data = ((void *)hdr) - size;

to wrap around on 32-bit systems (or when pointer subtraction overflows).
Because data wraps around, the subsequent bounds check:

    if ((unsigned long)data < initrd_start)

evaluates to false, bypassing the check. The kernel then calls
xbc_calc_checksum(data, size), which attempts to read 4GB of memory,
hitting unmapped pages and triggering a fatal kernel page fault during
early boot. Furthermore, on 64-bit systems with an initrd > 4.29 GB, an
unbounded 32-bit size can similarly bypass the initrd_start check.

Fix this by:
1. Ensuring the initrd is at least large enough to contain the bootconfig
   footer and verifying hdr is within the initrd bounds.
2. Checking that size does not exceed XBC_DATA_MAX and does not exceed
   the available space between initrd_start and hdr before performing
   pointer subtraction.

Fixes: de462e5f1071 ("bootconfig: Fix to remove bootconfig data from initrd while boot")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260910010137.EE0431F000FF@smtp.kernel.org/
Assisted-by: Antigravity:gemini-3.8-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 init/main.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/init/main.c b/init/main.c
index 2613d3f9b3ce..60c27d5f2bce 100644
--- a/init/main.c
+++ b/init/main.c
@@ -277,7 +277,8 @@ static void * __init get_boot_config_from_initrd(size_t *_size)
 	u8 *hdr;
 	int i;
 
-	if (!initrd_end)
+	if (!initrd_end || initrd_end < initrd_start ||
+	    initrd_end - initrd_start < BOOTCONFIG_MAGIC_LEN + 8)
 		return NULL;
 
 	data = (char *)initrd_end - BOOTCONFIG_MAGIC_LEN;
@@ -294,16 +295,21 @@ static void * __init get_boot_config_from_initrd(size_t *_size)
 
 found:
 	hdr = (u8 *)(data - 8);
+	if ((unsigned long)hdr < initrd_start)
+		return NULL;
+
 	size = get_unaligned_le32(hdr);
 	csum = get_unaligned_le32(hdr + 4);
 
-	data = ((void *)hdr) - size;
-	if ((unsigned long)data < initrd_start) {
-		pr_err("bootconfig size %d is greater than initrd size %ld\n",
+	if (size > XBC_DATA_MAX ||
+	    size > ((unsigned long)hdr - initrd_start)) {
+		pr_err("bootconfig size %u is greater than initrd size %lu\n",
 			size, initrd_end - initrd_start);
 		return NULL;
 	}
 
+	data = ((void *)hdr) - size;
+
 	if (xbc_calc_checksum(data, size) != csum) {
 		pr_err("bootconfig checksum failed\n");
 		return NULL;

