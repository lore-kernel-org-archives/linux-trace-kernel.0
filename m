Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37BF3515C7;
	Fri, 11 Sep 2026 14:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789136019; cv=none; b=WTGNozFOyxTNiJTT3tpFi3Xyle0YPHfW+d6GNCQ2hAb2x2BjJzG78exEneXqn+P/skiV7qtOR8KrL/J9/J6312IR0TiGpm9R+tm/6dJQ+AJE4tm8MTek6xTP0ALYjFu/3nQfWGfRf90f9a0G/pPRxtoMlKQxmjDU9mADKb6D9kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789136019; c=relaxed/simple;
	bh=HjdMvu+amrfZ+Yjum6DNCwuv95VOPcYse8XIGVa3Hsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kS7Z9No4b4bxY9XtVpSvCExdKgMPJMtPgspHFrXVwSNCOl//8G76O/CBljdZ2h9hLlVsx9hlWdg10nSxWUCWL9HSI7i3hI+IsfyrUNeXlHpFX8zRD4jd8DHlTBAfWlteZI9o3QYKRXtYqIU1YnDbNngJpSSLPmlTgNrIjC445KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dW0jORBH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dW0jORBH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026651F008A2;
	Fri, 11 Sep 2026 14:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789136017;
	bh=5ITgpds4xl58Ygn2uPHYZZiX61DZ+QftRJbMlAz/1Js=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dW0jORBHvt7NTMCMA5myakN4a7nziqA5V2p5sdelKnBENyMAGL7ow5qQqtSyfN18B
	 1vOi3DrbZYYy0lCmWc52F5B8vRMw7J31ZJxxpBnLVEIar8f8NuqgWZIHXqiP3AKqiM
	 C1sAZHb0QcGDm4voSJGTWBTd3+k9SMQN0vyjdcUPWOnzuQ0R0VTcH3qxbl9OYtOHxg
	 SmYFH/38PhBxoz7J8/qquUy6CkCicLcEwfpRxkGx1mgGMCr2jWaVQC99MnzZ/zOqwh
	 gzKFiL9rKEKbrJAFAb48G48X3srNp/E9p9crYZYiv5T2J1TZftv5OgcW8ET7ma3GY5
	 i7elDyBhblsSA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>
Subject: [PATCH v2 4/4] bootconfig: Move BOOTCONFIG_FOOTER_SIZE to include/linux/bootconfig.h
Date: Fri, 11 Sep 2026 23:13:33 +0900
Message-ID: <178913601321.248794.4786502771058559887.stgit@devnote2>
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

BOOTCONFIG_FOOTER_SIZE was defined locally in tools/bootconfig/main.c.
Move it to include/linux/bootconfig.h so that it can be shared with
the kernel and user-space tools. Also, use it in init/main.c instead
of the hardcoded (BOOTCONFIG_MAGIC_LEN + 8) expression when checking
the initrd size.

Suggested-by: Sang-Heon Jeon <ekffu200098@gmail.com>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v2:
  - Newly added.
---
 include/linux/bootconfig.h |    4 ++++
 init/main.c                |    2 +-
 tools/bootconfig/main.c    |    4 ----
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index deda507500da..6f23ec11baab 100644
--- a/include/linux/bootconfig.h
+++ b/include/linux/bootconfig.h
@@ -27,6 +27,10 @@ bool __init cmdline_has_extra_options(void);
 #define BOOTCONFIG_ALIGN	(1 << BOOTCONFIG_ALIGN_SHIFT)
 #define BOOTCONFIG_ALIGN_MASK	(BOOTCONFIG_ALIGN - 1)
 
+/* Bootconfig footer is [size][csum][BOOTCONFIG_MAGIC]. */
+#define BOOTCONFIG_FOOTER_SIZE	\
+	(sizeof(uint32_t) * 2 + BOOTCONFIG_MAGIC_LEN)
+
 /**
  * xbc_calc_checksum() - Calculate checksum of bootconfig
  * @data: Bootconfig data.
diff --git a/init/main.c b/init/main.c
index 16749bb7a219..37168bd68126 100644
--- a/init/main.c
+++ b/init/main.c
@@ -278,7 +278,7 @@ static void * __init get_boot_config_from_initrd(size_t *_size)
 	int i;
 
 	if (!initrd_end || initrd_end < initrd_start ||
-	    initrd_end - initrd_start < BOOTCONFIG_MAGIC_LEN + 8)
+	    initrd_end - initrd_start < BOOTCONFIG_FOOTER_SIZE)
 		return NULL;
 
 	data = (char *)initrd_end - BOOTCONFIG_MAGIC_LEN;
diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 652e491b9c33..d4aa96da970e 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -17,10 +17,6 @@
 
 #define pr_err(fmt, ...) fprintf(stderr, fmt, ##__VA_ARGS__)
 
-/* Bootconfig footer is [size][csum][BOOTCONFIG_MAGIC]. */
-#define BOOTCONFIG_FOOTER_SIZE	\
-	(sizeof(uint32_t) * 2 + BOOTCONFIG_MAGIC_LEN)
-
 static void show_xbc_error(const char *data, const char *msg, int pos)
 {
 	int lin = 1, col, i;

