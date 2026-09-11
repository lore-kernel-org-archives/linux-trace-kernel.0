Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BE7345EB5;
	Fri, 11 Sep 2026 14:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789136001; cv=none; b=tH8dV7IeWTgGnC0zXUjfo1+YJsGUE2YJiyic8AGE8XmmGyDpkylYrVtBrosgKM+B+iaA6rf9vHOXRtspxKoSdax16HP5gYosT6Ap12nzNLENQksw6UNGl6yenuwD2gbmI3AnGMjxDj/BFhdRRvtJ3/EYAYJlFIcgCut5Yqppb5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789136001; c=relaxed/simple;
	bh=RpGhfmje8DtH4utSvgsNEPl0BOr3tnmw3jdfbnBUi28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ON4GayGaTTIzUJ2PpcbGz8wxGm/nNm3iKQrDaCAxXp2BmicRmXJGM97ci+9AtqZhGrljJ4ipCTNQZiybjKFAwOx6J99ixXdk7a5xkn1QbYYn7v0N2uAJnZZvxToTDDuGwcFmpveipE/PWybNx9+P/DIueHypVMWxla/g3q+/iYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKJIR5/n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKJIR5/n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BFEF1F008A2;
	Fri, 11 Sep 2026 14:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789135998;
	bh=fl2Id8u8e/0eGxzUx0pnL/Xk1CZne/k9PIjfKtGd7ZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NKJIR5/nl8HqQcWp9JTQSFX/afUCf3z+Foj/JuOuONreSrbSlcfvpIMOZbdoK/ENA
	 nZKiLIiT8rYbrePcZNHSqieUsemRcfpGSbBUU03qyR/YbfgU2Jrh0w27pAM8byT41I
	 fhtQ3cfZDapKcTxDBRNXPjLO91QeKp3W0JlGlWwkLkrMFMWQIADmKam7EYcOSdtAYm
	 C3Y5bapNJym35vSsfn7dfSXZJy/LiQ+HJqzz3LixZrmjGIwR1qxj1+zRfrGU5EpWtv
	 qkAxl4eBmk5TEGqCjaB6AqXC6N2QL3PZYFRG71heW1vBfLrNwC81+mx4ZqpJ8ON2nY
	 yjcmrB5q830Hw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>
Subject: [PATCH v2 2/4] tools/bootconfig: Consolidate xbc_init() to error message wrapper
Date: Fri, 11 Sep 2026 23:13:15 +0900
Message-ID: <178913599508.248794.10388592925402087434.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178913597653.248794.1237187523153227751.stgit@devnote2>
References: <178913597653.248794.1237187523153227751.stgit@devnote2>
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
Changes in v2:
 - Remove redundant buffer copy in init_xbc_with_error().
---
 tools/bootconfig/main.c |  100 ++++++++++++++++++++---------------------------
 1 file changed, 43 insertions(+), 57 deletions(-)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index aff169ba75b8..652e491b9c33 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -21,6 +21,39 @@
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
+	const char *msg;
+	int ret, pos;
+
+	ret = xbc_init(buf, len, &msg, &pos);
+	if (ret < 0)
+		show_xbc_error(buf, msg, pos);
+
+	return ret;
+}
+
 static int xbc_show_value(struct xbc_node *node, bool semicolon)
 {
 	const char *val, *eol;
@@ -197,7 +230,6 @@ static int load_xbc_from_initrd(int fd, char **buf)
 	int ret;
 	uint32_t size = 0, csum = 0, rcsum;
 	char magic[BOOTCONFIG_MAGIC_LEN];
-	const char *msg;
 
 	ret = fstat(fd, &stat);
 	if (ret < 0)
@@ -249,52 +281,9 @@ static int load_xbc_from_initrd(int fd, char **buf)
 		return -EINVAL;
 	}
 
-	ret = xbc_init(*buf, size, &msg, NULL);
-	/* Wrong data */
-	if (ret < 0) {
-		pr_err("parse error: %s.\n", msg);
-		return ret;
-	}
-
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
+	ret = init_xbc_with_error(*buf, size);
 
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
@@ -423,9 +412,8 @@ static int apply_xbc(const char *path, const char *xbc_path)
 	char *buf, *data;
 	size_t total_size;
 	struct stat stat;
-	const char *msg;
 	uint32_t size, csum;
-	int pos, pad;
+	int pad;
 	int ret, fd;
 
 	ret = load_xbc_file(xbc_path, &buf);
@@ -438,6 +426,13 @@ static int apply_xbc(const char *path, const char *xbc_path)
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
@@ -446,15 +441,6 @@ static int apply_xbc(const char *path, const char *xbc_path)
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

