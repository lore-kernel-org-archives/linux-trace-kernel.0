Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75D5576EB8;
	Wed,  9 Sep 2026 15:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969230; cv=none; b=KdWGVl6W9gQZ/NGmbesk2mi+d13v58bpAAD/2ZHEzoFhhf7qv/mroe0DrdB44xYXFyyuy+1yrDKBxbM4BaGV5wpKSQ7GeU5oPZGEmfRanRPNofQEortLS2n9LKrH5oXV4xGHbb7TYGVuNvCgP+2vOXCZJqTZi28m564CM/DHCp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969230; c=relaxed/simple;
	bh=Lw23bxYF2SeVxe2c2uvX0H1QkXIsH944jUEI8MagQVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fU8l64p+txa2nCUXhgBhv4/7yOZI1q/lcMYyV/GKG7Aj5BRm9YGO1dwke6IghiATLSfQUv30tbhJTQWYZgXjp4Wr+eHba4XNi0cBtjCP5pelVy2HbeAQ5gTxYnaq78z/zuhNTutVBRq4sW+DhgJ3q7md77gV3DgmCD3F4doqcsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlqiTQX+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlqiTQX+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F9701F00A3D;
	Wed,  9 Sep 2026 15:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788969228;
	bh=d6P8nm47c75PBnxXGfDXABoraSULENG6UjLUERO0Rq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dlqiTQX+iMDMb1qXIXZYay9dfUlyORepD3vScebEO37aWVzwCkzCDyMAqxf+d/Yhe
	 JYMtlmqPlcM5T73uAZF0iAA8cNO4s79GLzTFEsc5QcIjoSXK93um942NhlK+O5+qDU
	 ErXMZo7H8Igu/mrMs5U0N8JAkPSKVTIScvIzUy1x6BJrmVltcVM1kyl+aQm06lI2Dn
	 1qjzk8KKcpkHTzEj9Ie5amDCq73rxHeY47gRNhMJqej7v/q94/lbyZY0AsRZVzaP0f
	 zU87RqdgUwFcWHOZydhE/DErioLnsZk6mLON4waRp7Ag0M0r8+urlx9Fa1aOWHj1wF
	 JM5aAGwQf7PCQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>
Subject: [PATCH 1/3] bootconfig: Reject unexpected data after null character
Date: Thu, 10 Sep 2026 00:53:45 +0900
Message-ID: <178896922501.177508.6894964926791268965.stgit@devnote2>
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
---
 lib/bootconfig.c                    |    7 +++++++
 tools/bootconfig/main.c             |    4 +++-
 tools/bootconfig/test-bootconfig.sh |   12 ++++++++++++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index aba11caf6903..0ec2874db9c7 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -1116,6 +1116,13 @@ static int __init xbc_parse_tree(void)
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
index 7dc9fff9b637..6035404733c3 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -422,7 +422,9 @@ static int apply_xbc(const char *path, const char *xbc_path)
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

