Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C840627F177;
	Thu, 10 Jul 2025 02:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752114259; cv=none; b=uvS3QA69HvOg6VmK8+oI2OeCk44fldhN+pAKe0iw/C/+8UolRsv5m40G/2DR1hRzIxb4r0UJSDo/DvhvGdPirDoPo+jeIke/ROtZYX6WFIlFbHU+7HpZpDH1LWLiR+gH3L2bWI6Q68W9dCLop12UQndix9f4xYGWvFWPZGYthO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752114259; c=relaxed/simple;
	bh=ivZC/XFatW2s4LOWzt6Q3Nl/+GkonjI1yVt9hS6OW0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eMG9geTeRNrvi0yUlasrdrNSZcteGzJojIwPSykIMFRg2JxTg9tRp6eYBEG/fvIGxYAbWeHmJciNNR6r9mq2z0/O5kdR/jHdlGcJCQ1j5Sxfypyj5P7GC2kUkLnkfeS6H6w+BvzkfX3TL99ZiPXAOQF1e7xiFQS12vQegb/ABbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0BUaHlV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0BUaHlV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7118C4CEF0;
	Thu, 10 Jul 2025 02:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752114259;
	bh=ivZC/XFatW2s4LOWzt6Q3Nl/+GkonjI1yVt9hS6OW0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W0BUaHlVxjEPkb70aq58V9T0hLd6SfF7qFvKwabvE+4OEh9koyYD6Wum3INMQl5ao
	 zA+wZPNju9vXnTXugo5EoGD9yxptjmTSxT+trOJyzAYuWbuqnqNfiBahdT/i5UoKlX
	 VZbUS/CYWUekprt0GggyTUbBAn38xd5D7ZC/GUxcW6ONUGmcc3vm0WEhNuQ8b2os79
	 WffiT88cwHGdwVDVWRelMem22j/LNqanOfa2EgrfcJPfNpZBX0PZOZm2KzB1IT0anN
	 MO2ZOnKy9fmyZHEVGjqbiowZH2UiSzqez95uJDhEbf5pyXY/TDKFZeIzp9rIoqOKkC
	 rY0R9Dui5Bw/g==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 3/3] tools/bootconfig: Cleanup bootconfig footer size calculations
Date: Thu, 10 Jul 2025 11:24:17 +0900
Message-ID:  <175211425693.2591046.16029516706923643510.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To:  <175211423307.2591046.14863142130524442068.stgit@mhiramat.tok.corp.google.com>
References:  <175211423307.2591046.14863142130524442068.stgit@mhiramat.tok.corp.google.com>
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

There are many same pattern of 8 + BOOTCONFIG_MAGIC_LEN for calculating
the size of bootconfig footer. Use BOOTCONFIG_FOOTER_SIZE macro to
clean up those magic numbers.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 tools/bootconfig/main.c |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 8a48cc2536f5..4988e23a1422 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -16,6 +16,10 @@
 
 #define pr_err(fmt, ...) fprintf(stderr, fmt, ##__VA_ARGS__)
 
+/* Bootconfig footer is [size][csum][BOOTCONFIG_MAGIC]. */
+#define BOOTCONFIG_FOOTER_SIZE	\
+	(sizeof(uint32_t) * 2 + BOOTCONFIG_MAGIC_LEN)
+
 static int xbc_show_value(struct xbc_node *node, bool semicolon)
 {
 	const char *val, *eol;
@@ -185,7 +189,7 @@ static int load_xbc_from_initrd(int fd, char **buf)
 	if (ret < 0)
 		return -errno;
 
-	if (stat.st_size < 8 + BOOTCONFIG_MAGIC_LEN)
+	if (stat.st_size < BOOTCONFIG_FOOTER_SIZE)
 		return 0;
 
 	if (lseek(fd, -BOOTCONFIG_MAGIC_LEN, SEEK_END) < 0)
@@ -198,7 +202,7 @@ static int load_xbc_from_initrd(int fd, char **buf)
 	if (memcmp(magic, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN) != 0)
 		return 0;
 
-	if (lseek(fd, -(8 + BOOTCONFIG_MAGIC_LEN), SEEK_END) < 0)
+	if (lseek(fd, -BOOTCONFIG_FOOTER_SIZE, SEEK_END) < 0)
 		return pr_errno("Failed to lseek for size", -errno);
 
 	if (read(fd, &size, sizeof(uint32_t)) < 0)
@@ -210,12 +214,12 @@ static int load_xbc_from_initrd(int fd, char **buf)
 	csum = le32toh(csum);
 
 	/* Wrong size error  */
-	if (stat.st_size < size + 8 + BOOTCONFIG_MAGIC_LEN) {
+	if (stat.st_size < size + BOOTCONFIG_FOOTER_SIZE) {
 		pr_err("bootconfig size is too big\n");
 		return -E2BIG;
 	}
 
-	if (lseek(fd, stat.st_size - (size + 8 + BOOTCONFIG_MAGIC_LEN),
+	if (lseek(fd, stat.st_size - (size + BOOTCONFIG_FOOTER_SIZE),
 		  SEEK_SET) < 0)
 		return pr_errno("Failed to lseek", -errno);
 
@@ -346,7 +350,7 @@ static int delete_xbc(const char *path)
 		ret = fstat(fd, &stat);
 		if (!ret)
 			ret = ftruncate(fd, stat.st_size
-					- size - 8 - BOOTCONFIG_MAGIC_LEN);
+					- size - BOOTCONFIG_FOOTER_SIZE);
 		if (ret)
 			ret = -errno;
 	} /* Ignore if there is no boot config in initrd */
@@ -376,8 +380,7 @@ static int apply_xbc(const char *path, const char *xbc_path)
 	csum = xbc_calc_checksum(buf, size);
 
 	/* Backup the bootconfig data */
-	data = calloc(size + BOOTCONFIG_ALIGN +
-		      sizeof(uint32_t) + sizeof(uint32_t) + BOOTCONFIG_MAGIC_LEN, 1);
+	data = calloc(size + BOOTCONFIG_ALIGN + BOOTCONFIG_FOOTER_SIZE, 1);
 	if (!data)
 		return -ENOMEM;
 	memcpy(data, buf, size);
@@ -425,7 +428,7 @@ static int apply_xbc(const char *path, const char *xbc_path)
 	}
 
 	/* To align up the total size to BOOTCONFIG_ALIGN, get padding size */
-	total_size = stat.st_size + size + sizeof(uint32_t) * 2 + BOOTCONFIG_MAGIC_LEN;
+	total_size = stat.st_size + size + BOOTCONFIG_FOOTER_SIZE;
 	pad = ((total_size + BOOTCONFIG_ALIGN - 1) & (~BOOTCONFIG_ALIGN_MASK)) - total_size;
 	size += pad;
 

