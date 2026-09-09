Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A11C58123D;
	Wed,  9 Sep 2026 15:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969238; cv=none; b=GoDNJAbnhQa6txGUyAn3l6+NdpteqVYQl7T9zU5DEcN5Gbi8Lc4Q2pBUm8SBCVdzYfqak/GAQRQrYnSZSFIPfi/no2xMun7m+BF2po/OTvGDiOhJUTJ5cfg0G8EDa5eOB6MNMglHZg/f2XjTzFWQtJbqsAkG6H/g7tWX2zHtlHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969238; c=relaxed/simple;
	bh=IpypP2UXfMQrqE7LCaYtWwmwQ2MQS6kVNgWvILji1o0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sWSQW3YGw4QzT6LhmHEYUX/wlxcb4ByBLW8LrPg7rnOztXJ1Ml0Bg/sLUsmFZH5aM55CRLNiaYRUlqWEIXVb7SCyiSOi9lyfLFmpwIX+gAZ1PaKuX+i9V9gJAV6eONV4A9l2tMhWXJ7l27NgI3tnoSJ7nGacLcXSgvUPUyZXTIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rg5HvFLF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rg5HvFLF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1024E1F00A3A;
	Wed,  9 Sep 2026 15:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788969237;
	bh=/8BAaxZyXXosOe7u2XcIyvstoN4X+pMzG1qOfmfe3A0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rg5HvFLF1EetVjlkYKD05Y/Lc4ShWCixbc10YPriVZPBjKuMwniw1foYEl2bkUPEW
	 KOf+46PLhrmIoQUDRGl5pdEoG0mnl8cNw1FyBi8gMZY9xr3UdOoQu1HHMlLRRJi9N7
	 QJoGPk+rZvN+tNQvb9IJ+jl44RQol3FZZ/r6V6TofT7gVPOkQQWdggsuSMTZulHnpl
	 mWAT44J9aLLL1i7pvjfw8YhV1qthlK8esg5ppYN+5novVdXjVREjfDdP6GVi+ziitR
	 EkeiJueaOm9nXBfPDpGJe9/L45EpWaCgWmzmjpR4oC2RCiQyZb99WQsW39gliX+OmW
	 Dvwvg+gTBoDMg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>
Subject: [PATCH 2/3] tools/bootconfig: Consolidate xbc_init() to error message wrapper
Date: Thu, 10 Sep 2026 00:53:53 +0900
Message-ID: <178896923375.177508.14682854552827605824.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178896921555.177508.434402948295885560.stgit@devnote2>
References: <178896921555.177508.434402948295885560.stgit@devnote2>
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

Use init_xbc_with_error() for all bootconfig initialization in the
bootconfig tool instead of showing errors in different way.

This simplifies the code logic and make it easy to maintain.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 tools/bootconfig/main.c |  108 ++++++++++++++++++++++-------------------------
 1 file changed, 51 insertions(+), 57 deletions(-)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 6035404733c3..7117aa9b2a83 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -21,6 +21,47 @@
 #define BOOTCONFIG_FOOTER_SIZE	\
 	(sizeof(uint32_t) * 2 + BOOTCONFIG_MAGIC_LEN)
 
+static void show_xbc_error(const char *data, const char *msg, int pos)
+{
+	int lin = 1, col, i;
+
+	if (pos < 0) {
+		pr_err("Error: %s.\n", msg);
+		return;
+	}
+
+	/* Note that pos starts from 0 but lin and col should start from 1. */
+	col = pos + 1;
+	for (i = 0; i < pos; i++) {
+		if (data[i] == '\n') {
+			lin++;
+			col = pos - i;
+		}
+	}
+	pr_err("Parse Error: %s at %d:%d\n", msg, lin, col);
+
+}
+
+static int init_xbc_with_error(char *buf, int len)
+{
+	char *copy = malloc(len);
+	const char *msg;
+	int ret, pos;
+
+	if (!copy)
+		return -ENOMEM;
+
+	memcpy(copy, buf, len);
+	/* We do not terminate the copy with \0 for sanity checking */
+
+	ret = xbc_init(buf, len, &msg, &pos);
+	if (ret < 0)
+		show_xbc_error(copy, msg, pos);
+	free(copy);
+
+	return ret;
+}
+
 static int xbc_show_value(struct xbc_node *node, bool semicolon)
 {
 	const char *val, *eol;
@@ -187,7 +228,6 @@ static int load_xbc_from_initrd(int fd, char **buf)
 	int ret;
 	uint32_t size = 0, csum = 0, rcsum;
 	char magic[BOOTCONFIG_MAGIC_LEN];
-	const char *msg;
 
 	ret = fstat(fd, &stat);
 	if (ret < 0)
@@ -238,52 +278,9 @@ static int load_xbc_from_initrd(int fd, char **buf)
 		return -EINVAL;
 	}
 
-	ret = xbc_init(*buf, size, &msg, NULL);
-	/* Wrong data */
-	if (ret < 0) {
-		pr_err("parse error: %s.\n", msg);
-		return ret;
-	}
+	ret = init_xbc_with_error(*buf, size);
 
-	return size;
-}
-
-static void show_xbc_error(const char *data, const char *msg, int pos)
-{
-	int lin = 1, col, i;
-
-	if (pos < 0) {
-		pr_err("Error: %s.\n", msg);
-		return;
-	}
-
-	/* Note that pos starts from 0 but lin and col should start from 1. */
-	col = pos + 1;
-	for (i = 0; i < pos; i++) {
-		if (data[i] == '\n') {
-			lin++;
-			col = pos - i;
-		}
-	}
-	pr_err("Parse Error: %s at %d:%d\n", msg, lin, col);
-
-}
-
-static int init_xbc_with_error(char *buf, int len)
-{
-	char *copy = strdup(buf);
-	const char *msg;
-	int ret, pos;
-
-	if (!copy)
-		return -ENOMEM;
-
-	ret = xbc_init(buf, len, &msg, &pos);
-	if (ret < 0)
-		show_xbc_error(copy, msg, pos);
-	free(copy);
-
-	return ret;
+	return ret < 0 ? ret : size;
 }
 
 static int show_xbc_kernel_cmdline(void)
@@ -412,9 +409,8 @@ static int apply_xbc(const char *path, const char *xbc_path)
 	char *buf, *data;
 	size_t total_size;
 	struct stat stat;
-	const char *msg;
 	uint32_t size, csum;
-	int pos, pad;
+	int pad;
 	int ret, fd;
 
 	ret = load_xbc_file(xbc_path, &buf);
@@ -427,6 +423,13 @@ static int apply_xbc(const char *path, const char *xbc_path)
 		size++;
 	csum = xbc_calc_checksum(buf, size);
 
+	/* Verify the data format */
+	ret = init_xbc_with_error(buf, size);
+	if (ret < 0) {
+		free(buf);
+		return ret;
+	}
+
 	/* Backup the bootconfig data */
 	data = calloc(size + BOOTCONFIG_ALIGN + BOOTCONFIG_FOOTER_SIZE, 1);
 	if (!data) {
@@ -435,15 +438,6 @@ static int apply_xbc(const char *path, const char *xbc_path)
 	}
 	memcpy(data, buf, size);
 
-	/* Check the data format */
-	ret = xbc_init(buf, size, &msg, &pos);
-	if (ret < 0) {
-		show_xbc_error(data, msg, pos);
-		free(data);
-		free(buf);
-
-		return ret;
-	}
 	printf("Apply %s to %s\n", xbc_path, path);
 	xbc_get_info(&ret, NULL);
 	printf("\tNumber of nodes: %d\n", ret);

