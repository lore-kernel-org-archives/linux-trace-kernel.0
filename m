Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176854AB1A6;
	Thu, 10 Sep 2026 15:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789053348; cv=none; b=UTm/9r0a5e0ozAJQXMU7P+15gihtSXBDoUPuQVhhxWqnn4GxjQudMG//PRowjz2byWNeSkHuU2vElWFssEKshZfs+kymSBHQes5SeKdznWKBolTaGj5834qXdgOkLrynFn8Icv56X0Rl6lo/iZDknaaJAwQ4xtrgxhzwcOJvzz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789053348; c=relaxed/simple;
	bh=AGGTo8x6LltFZhyG3DBF2Ux8tH6OAROqJsckgOxCd+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UySgINxhkU6R/v/3e/m7Yxm0xEfDVwRppUup9Sj+0sFmptg8JQQknXyNXHNqeBh8E/QLvnRrFXwv/I5W6o5rWT5pXJQJZWH1t3cGLP24+kPlwIXtEXupqxsbAjs6hzYhoZuVmRj9fUK2SdeTKiLyVLTCweJUD7ne7lWO0Wo9yEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDBCL2tH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDBCL2tH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052FA1F000FF;
	Thu, 10 Sep 2026 15:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789053339;
	bh=tA/ppFhQxULDYYeN7C/s9VujISrGiMIKSwQKZxHHjbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FDBCL2tHqsW9oRjEpTEy+uXVu3ZDkIJp0lI5+6ory7rtBb1FElTVIodOtuQ3qxSNN
	 MqCHnhR0HwabviMf7YDef7IXy5mIyRRG9ZAuwjyTm86J+89Y/H2/oMwe1DwTbe71I2
	 tzDLFM+VLY11vL9NerNXciDimCbLRzc1kfSsSG4MqNQ8b/P9As/IZr5vRgWtGiDrZv
	 SUjN2pqb3VrlYdJfH7r5ub2Dtj8borepDm/yZ6pEwGbvVkOhQAp7GiApesiEuVtMrZ
	 XuueTVgLjpT2pET+b1EJ04KUx1hQL92G0cXTiePoah+C+0zoSrGpDTpGd1NJlnaJhU
	 COUc4TeB1Jriw==
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
Subject: [PATCH v4 2/2] bootconfig: Fix integer overflow in initrd size check
Date: Fri, 11 Sep 2026 00:15:34 +0900
Message-ID: <178905333479.213925.1358412668943562406.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178905331374.213925.295025394754459843.stgit@devnote2>
References: <178905331374.213925.295025394754459843.stgit@devnote2>
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
 Changes in v4:
  - Accurate the error message for size > XBC_DATA_MAX in
    get_boot_config_from_initrd().
  - Remove redundant (and wrong) size >= XBC_DATA_MAX check from
    setup_boot_config().
---
 init/main.c |   25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/init/main.c b/init/main.c
index 2613d3f9b3ce..16749bb7a219 100644
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
@@ -294,16 +295,26 @@ static void * __init get_boot_config_from_initrd(size_t *_size)
 
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
+	if (size > XBC_DATA_MAX) {
+		pr_err("bootconfig size %u is greater than max size %d\n",
+			size, XBC_DATA_MAX);
+		return NULL;
+	}
+
+	if (size > ((unsigned long)hdr - initrd_start)) {
+		pr_err("bootconfig size %u is greater than initrd size %lu\n",
 			size, initrd_end - initrd_start);
 		return NULL;
 	}
 
+	data = ((void *)hdr) - size;
+
 	if (xbc_calc_checksum(data, size) != csum) {
 		pr_err("bootconfig checksum failed\n");
 		return NULL;
@@ -394,12 +405,6 @@ static void __init setup_boot_config(void)
 		return;
 	}
 
-	if (size >= XBC_DATA_MAX) {
-		pr_err("bootconfig size %ld greater than max size %d\n",
-			(long)size, XBC_DATA_MAX);
-		return;
-	}
-
 	ret = xbc_init(data, size, &msg, &pos);
 	if (ret < 0) {
 		if (pos < 0)

