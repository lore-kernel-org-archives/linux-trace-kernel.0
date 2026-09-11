Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AD43D8107;
	Fri, 11 Sep 2026 22:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789167553; cv=none; b=Qe+rjO4E2X7ODPvDN91DoSX14xU/73FMY9USVEQRxi2JpUPnMdmA3XE9pPsqYHSdunPwNyhR6Mo8A2nR+KiUDZS+3fNf8OpIeVIH6/PfiDpW9adp89/qqYnX2mUf8cN6fwVwHVCx/1hofMjUGoEUJeaVH7nCCKYkIOMv0chmCRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789167553; c=relaxed/simple;
	bh=ifRCjs3PH652jLbyOuCHtqUqbYgTkGoi+j+DH4gUOFc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WmGn4uNixTWlQlAahu/iyAE3h6L5qMkXhKM8mQbYpE8xai4Z8BwaBrgYYdtttKVrNmnR2oRqfE5FgXLMWLGapJc+i1Oz096SntYQwcG3yySYHcbmZw5E+xX5KNy75+Rv857YOSFOrOUF5F6EPc/UZ1WBEWodbZ9IPNHGBOCgP1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dvHTofRr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dvHTofRr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986C21F000FF;
	Fri, 11 Sep 2026 22:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1789167551;
	bh=t2S/m2h7UEB/CuumUnvTIa59is7Da5KmNcWpzEuJtu4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dvHTofRrArBU1ooBY0qjprP0moPGMOQvfmyw3bctxWRnvnPYxKgQePr1matk2uZib
	 CRmfPv2wQVEp7/uPCHczMScRzLYQoFUNwE+eAgoUDDwnMbCEc3+qnD6S1skgbnZz8O
	 wWSL/P5u6uKIxWkGG+zbpD2cUmZbkXHq5keiODMg=
Date: Fri, 11 Sep 2026 15:59:11 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Sang-Heon Jeon <ekffu200098@gmail.com>
Subject: Re: [PATCH v2 0/4] bootconfig: Reject unexpected data after null
 character and cleanups
Message-Id: <20260911155911.1cccfa39dd2e3c6e3a84e03f@linux-foundation.org>
In-Reply-To: <178913597653.248794.1237187523153227751.stgit@devnote2>
References: <178913597653.248794.1237187523153227751.stgit@devnote2>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Sep 2026 23:12:56 +0900 "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> Hi,
> 
> Here are v2 patches for bootconfig to rejects unexpected config data after
> null character and other cleanups including tools/bootconfig to consolidate
> bootconfig initialization with errors, and skipping internal tree sanity
> check in kernel.
> 
> ...
>

Thanks, I've updateed mm.git's mm-nonmm-unstable branch to this version,

> This version removes redundant buffer copy in init_xbc_with_error() [2/4]
> and moves BOOTCONFIG_FOOTER_SIZE to include/linux/bootconfig.h[4/4].

Here's how v2 altered mm.git:


 include/linux/bootconfig.h |    4 ++++
 init/main.c                |    2 +-
 tools/bootconfig/main.c    |   14 +-------------
 3 files changed, 6 insertions(+), 14 deletions(-)

--- a/include/linux/bootconfig.h~b
+++ a/include/linux/bootconfig.h
@@ -27,6 +27,10 @@ bool __init cmdline_has_extra_options(vo
 #define BOOTCONFIG_ALIGN	(1 << BOOTCONFIG_ALIGN_SHIFT)
 #define BOOTCONFIG_ALIGN_MASK	(BOOTCONFIG_ALIGN - 1)
 
+/* Bootconfig footer is [size][csum][BOOTCONFIG_MAGIC]. */
+#define BOOTCONFIG_FOOTER_SIZE	\
+	(sizeof(uint32_t) * 2 + BOOTCONFIG_MAGIC_LEN)
+
 /**
  * xbc_calc_checksum() - Calculate checksum of bootconfig
  * @data: Bootconfig data.
--- a/init/main.c~b
+++ a/init/main.c
@@ -278,7 +278,7 @@ static void * __init get_boot_config_fro
 	int i;
 
 	if (!initrd_end || initrd_end < initrd_start ||
-	    initrd_end - initrd_start < BOOTCONFIG_MAGIC_LEN + 8)
+	    initrd_end - initrd_start < BOOTCONFIG_FOOTER_SIZE)
 		return NULL;
 
 	data = (char *)initrd_end - BOOTCONFIG_MAGIC_LEN;
--- a/tools/bootconfig/main.c~b
+++ a/tools/bootconfig/main.c
@@ -17,10 +17,6 @@
 
 #define pr_err(fmt, ...) fprintf(stderr, fmt, ##__VA_ARGS__)
 
-/* Bootconfig footer is [size][csum][BOOTCONFIG_MAGIC]. */
-#define BOOTCONFIG_FOOTER_SIZE	\
-	(sizeof(uint32_t) * 2 + BOOTCONFIG_MAGIC_LEN)
-
 static void show_xbc_error(const char *data, const char *msg, int pos)
 {
 	int lin = 1, col, i;
@@ -44,20 +40,12 @@ static void show_xbc_error(const char *d
 
 static int init_xbc_with_error(char *buf, int len)
 {
-	char *copy = malloc(len);
 	const char *msg;
 	int ret, pos;
 
-	if (!copy)
-		return -ENOMEM;
-
-	memcpy(copy, buf, len);
-	/* We do not terminate the copy with \0 for sanity checking */
-
 	ret = xbc_init(buf, len, &msg, &pos);
 	if (ret < 0)
-		show_xbc_error(copy, msg, pos);
-	free(copy);
+		show_xbc_error(buf, msg, pos);
 
 	return ret;
 }
_

