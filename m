Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2806633BBC0;
	Fri, 11 Sep 2026 14:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789135991; cv=none; b=QwMOF8LtqFN6dquyB4ZdiXtJs0NZE22SSnqkYpGVbWCP7hpqDXH6TB+hrZP1qrq+Qjatfi2Y+p3lx92ap4Jq33Nb6XiTSIKOvynnDmN6+//WEeJ09nyd0L8Bo1YwCHKmWCAHbjdGBP4FvuaXJHl62Q7qs22KB2UMsYgkC8Hh1EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789135991; c=relaxed/simple;
	bh=VmLDgc8FVwCH7jfA1bK7WOgcB3UTbmunEsoUbXc5vCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e2xvSHGdTtXsF+7N9NNas3wUisYhwg49CWdv4V+LsMShfe+3NKPBDgkvFh6pVdCNSxidhf28DgUJBlGbrtWH9nnrcg/LPKzWtA43OBZ/w9NlpRXq5TpV+eGoLNLKPM/dW9QkZmbnBaQE+ipIznonnkbUzefBMyPaISYuR/T+yQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h96ZLCnX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h96ZLCnX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717BB1F008A2;
	Fri, 11 Sep 2026 14:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789135989;
	bh=mSgtp3Oo1RMv/XNAhQwl71O3GqsJP7J7NxfICduxt3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h96ZLCnXcBiPd3a7J4hu9EhKZIH5/dyEAi9sA0WhjI/Ccti0br7B08lqrLgSwhzJb
	 CgEshrwBgNGdiU8xHAm3t/T50vik4Za9TaBhEuapxu+uDJro6Gd+Hhig7Jn7h1xavo
	 pjo4At2NcAHKDqJuLiLjQ0O+a2hlu+C5T2SEEYV6x+vsI4ZIp49UVP/4rXPh/dklL/
	 Bgp85ljH1RvUA4ICYtdrC1omTMncbseNh5vG0b7Q67JkaGLjWRiH8k3l8hRPNPU51h
	 0udvn9ZMgmv+B/4sw96rM/34f5ZFuy50w5QyyhRpqYZnOgb3cQJq1zFzXvE47V/WEX
	 2aaMHceYra4aw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>
Subject: [PATCH v2 1/4] bootconfig: Reject unexpected data after null character
Date: Fri, 11 Sep 2026 23:13:06 +0900
Message-ID: <178913598628.248794.1048773774471250986.stgit@devnote2>
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

If a bootconfig buffer contains an intermediate null character in the
middle of the configuration, xbc_parse_tree() stops at the null character
because string delimiter searches (e.g. strpbrk()) stop at '\0', and
cleanly breaks out of the loop without error. As a result, any
configuration data following the intermediate null character is silently
ignored, allowing unparsed or potentially malicious data to be hidden
after an early termination.

Fix this in xbc_parse_tree() by checking that no non-null data remains
between the parser termination point and the end of the input buffer.
Trailing null characters (such as alignment padding in initrd) continue
to be accepted as valid.

Also update apply_xbc() in tools/bootconfig/main.c to calculate the
buffer size based on the loaded file size rather than strlen(), so that
files with intermediate null characters are not truncated before
validation.

Assisted-by: Antigravity:gemini-3.8-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 lib/bootconfig.c                    |    7 +++++++
 tools/bootconfig/main.c             |    4 +++-
 tools/bootconfig/test-bootconfig.sh |   12 ++++++++++++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 89c88e359179..61cae6d6e3f8 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -1119,6 +1119,13 @@ static int __init xbc_parse_tree(void)
 		}
 	} while (!ret);
 
+	if (!ret) {
+		while (p < xbc_data + xbc_data_size - 1 && *p == '\0')
+			p++;
+		if (p < xbc_data + xbc_data_size - 1)
+			ret = xbc_parse_error("Unexpected data after null character", p);
+	}
+
 	return ret;
 }
 
diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 17d971d47f87..aff169ba75b8 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -433,7 +433,9 @@ static int apply_xbc(const char *path, const char *xbc_path)
 		pr_err("Failed to load %s : %d\n", xbc_path, ret);
 		return ret;
 	}
-	size = strlen(buf) + 1;
+	size = ret;
+	if (size == 0 || buf[size - 1] != '\0')
+		size++;
 	csum = xbc_calc_checksum(buf, size);
 
 	/* Backup the bootconfig data */
diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-bootconfig.sh
index fc69f815ce4a..530ce7e28d63 100755
--- a/tools/bootconfig/test-bootconfig.sh
+++ b/tools/bootconfig/test-bootconfig.sh
@@ -180,6 +180,18 @@ EOF
 $BOOTCONF -a $TEMPCONF $INITRD 2> $OUTFILE
 xpass grep -q "1:1" $OUTFILE
 
+echo "Intermediate null character test"
+printf "key = value\n\0extra = data\n" > $TEMPCONF
+xfail $BOOTCONF -a $TEMPCONF $INITRD
+$BOOTCONF -a $TEMPCONF $INITRD 2> $OUTFILE
+xpass grep -q "Unexpected" $OUTFILE
+
+echo "Trailing null character test"
+printf "key = value\n\0" > $TEMPCONF
+xpass $BOOTCONF -a $TEMPCONF $INITRD
+$BOOTCONF $INITRD > $OUTFILE
+xpass grep -q "value" $OUTFILE
+
 echo "=== expected failure cases ==="
 for i in samples/bad-* ; do
   xfail $BOOTCONF -a $i $INITRD

