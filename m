Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1F24AA572;
	Thu, 10 Sep 2026 15:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789053334; cv=none; b=ktcWM8F9715vGLVOP0+N5oCOkT1dOiRkZ2P11MvGpy9LXdBUYTTIs43vR6TtYiBvDp3wuolt6QlOjLMfrQ+X39NMa1BRmoLi8cXDfpQQjBe58o1qNZtPZHT+azsYxbNBLUR/eJdM28xEBs2XZlT/x2FUSpTpWtE1d5oNqFL5vGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789053334; c=relaxed/simple;
	bh=JLOuAk5tl3QZRZux1cWV0A6sqt+w4ImTvKCs0+yKnK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fSSUN46ZIED6iANfcQ8l62KOolwOCXHuLUZDHRAMks+srCkUbrOhUH9IZ9Ph87hb4v0D+Ty7SngZwCb27M1x4DY1yREr28FxLbN/OV1+F5VfYGicrkrYO0RBtp+Doz2vXXHBAWB6+ywEzoTsxgZfy+LQww8olSfC7fwVUx03XKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXY3/T+Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXY3/T+Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732FA1F00898;
	Thu, 10 Sep 2026 15:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789053329;
	bh=zdTTFikfWrYdC44mS2BXIE3fNsajuaVWVur6OX38iBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HXY3/T+Y6UX6bXebxHekTnO45aZV3GuIKKiVH8UkEVFvM1X+DvEuSZnm+7n3/dRtA
	 D/4IxwgMhxwbC3jr3dux4gnQcQMj5vmHomMtETi4iQU6DowEwgXJ7iRb1yVUgM96sJ
	 v/6dAestcxjTZTrzXxkBfY6B8DESPTlT56BnQu92MBDuw3NnIUslINpiFXxci7ecu4
	 isqM+4YW9TJLm3BWmhjuH71tYKPV7qOuxbGO/4bLyYYdXzx++XUrvcMcaC5Dx3mAPN
	 0QpLZ2fd86pm9vRpwfG1+5Ov9qOcsQbl0WZOkMUWw86cyfU5XqrUsi37thcxuMxYNn
	 Gz4kGt9V2KfrA==
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
Subject: [PATCH v4 1/2] tools/bootconfig: Fix integer overflow and truncation in size checks
Date: Fri, 11 Sep 2026 00:15:24 +0900
Message-ID: <178905332413.213925.3179977110281463499.stgit@devnote2>
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

Sashiko reported that on 32-bit systems, if an attacker crafts size in
the bootconfig footer such that adding BOOTCONFIG_FOOTER_SIZE wraps around
(for instance, if size is 0xFFFFFFFF), the size check in
load_xbc_from_initrd() can be bypassed:

    if (stat.st_size < size + BOOTCONFIG_FOOTER_SIZE) {
        pr_err("bootconfig size is too big\n");
        return -E2BIG;
    }

Furthermore, on 64-bit systems with an initrd > 4.29 GB, comparing a
corrupted 32-bit size (e.g. 0xFFFFFFFF) against
stat.st_size - BOOTCONFIG_FOOTER_SIZE can also bypass the check if
size is not bounded. Similarly, load_xbc_file() passes 64-bit stat.st_size
directly into the 32-bit int size parameter of load_xbc_fd(), truncating
large standalone files (>= 2GB).

In both cases, passing 0xFFFFFFFF to load_xbc_fd() truncates to -1,
resulting in malloc(0), an integer overflow in read(), and an
out-of-bounds null-byte write.

Fix this by:
1. Rejecting size > XBC_DATA_MAX or
   size > stat.st_size - BOOTCONFIG_FOOTER_SIZE in load_xbc_from_initrd().
2. Rejecting stat.st_size > XBC_DATA_MAX in load_xbc_file() before passing
   it to load_xbc_fd().
3. Checking size < 0 || size > XBC_DATA_MAX defensively in load_xbc_fd().

Fixes: 950313ebf79c ("tools: bootconfig: Add bootconfig command")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260909161113.16C691F00A3A@smtp.kernel.org/
Closes: https://lore.kernel.org/all/20260910010137.EE0431F000FF@smtp.kernel.org/
Assisted-by: Antigravity:gemini-3.8-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v3:
 - Reject size > XBC_DATA_MAX and
   size > stat.st_size - BOOTCONFIG_FOOTER_SIZE in load_xbc_from_initrd()
   to prevent bypass on initrd > 4.29 GB.
 - Check stat.st_size > XBC_DATA_MAX in load_xbc_file() to prevent
   truncation on large standalone files.
 - Check size < 0 || size > XBC_DATA_MAX defensively in load_xbc_fd().
Changes in v2:
  - Add Cc: stable.
  - Also reject if "size > XBC_DATA_MAX", that is obviously wrong.
---
 tools/bootconfig/main.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 7dc9fff9b637..17d971d47f87 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -140,6 +140,9 @@ static int load_xbc_fd(int fd, char **buf, int size)
 {
 	int ret;
 
+	if (size < 0 || size > XBC_DATA_MAX)
+		return -EINVAL;
+
 	*buf = malloc(size + 1);
 	if (!*buf)
 		return -ENOMEM;
@@ -168,6 +171,13 @@ static int load_xbc_file(const char *path, char **buf)
 		return ret;
 	}
 
+	if (stat.st_size > XBC_DATA_MAX) {
+		pr_err("%s size is too big\n", path);
+		ret = -E2BIG;
+		close(fd);
+		return ret;
+	}
+
 	ret = load_xbc_fd(fd, buf, stat.st_size);
 
 	close(fd);
@@ -218,7 +228,8 @@ static int load_xbc_from_initrd(int fd, char **buf)
 	csum = le32toh(csum);
 
 	/* Wrong size error  */
-	if (stat.st_size < size + BOOTCONFIG_FOOTER_SIZE) {
+	if (size > XBC_DATA_MAX ||
+	    size > stat.st_size - BOOTCONFIG_FOOTER_SIZE) {
 		pr_err("bootconfig size is too big\n");
 		return -E2BIG;
 	}

