Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8D32BEFFD;
	Tue, 18 Aug 2026 01:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787018010; cv=none; b=fZQX2xBQ5Iu5sTrj/d5sS/WoKYP/Q3q7tA/PKZAUZ+fW5pEowEgH1Oy8eddkfmL+kQrqtxh12vGJdcfFPqZBWlFxZn8w7dUWGsjdNMEmifFAQ0+2oeVjDO2KjyZ5mwmebBpcWAl9Ufa8UXLBRyQAxkOZiQ+zjyl1NA036HnP59Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787018010; c=relaxed/simple;
	bh=FLG6R+kLr4hsyuo1Kep15Oic3sdgmGltpTtPT6u1ZHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rPQ5zFidlUqhkOBFkbZo1dI4j6zmbyXEz4AfVwwz+cX1Mcyd6Iw1p8OyY8grkjVdiNGyDnECchaBtbTxj5MWzus0XDS8hFn/LTmhvZAeLSjoBD7u30NcWr8hJHClv3dQShr013vHd0Ck+aNAVKhkR4QFhCSH9eeOhU+aTLL5cLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=raPsoM7T; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="raPsoM7T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1787017998;
	bh=GJmUpksao1Sv6uYL7I5hs2EQUNBvO+WsMG2klFFd1gY=;
	h=From:To:Cc:Subject:Date:From;
	b=raPsoM7TS0sLAWB0Djw9C4TS6mym4paAdLagC/Ea70D5semspumvTRd/eAkUG72LY
	 EOQZKkh0dC9exn8lcUX4O94+MzWDxr7LFPSJG7/RyMD/UpQFMLrUzswM4YACwXemLA
	 n9IjdUZT2LhT2IpeGsbrM9HnyhhURFSXbauIQH7w=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with UTF8SMTP id 4hPCQk6vR4z10rt;
	Tue, 18 Aug 2026 01:53:18 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4hPCQk4fJvz10rZ;
	Tue, 18 Aug 2026 01:53:18 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: Naveen N Rao <naveen@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2] kprobes: use DEFINE_DEBUGFS_ATTRIBUTE for the enabled knob
Date: Tue, 18 Aug 2026 01:53:18 +0000
Message-ID: <20260818015318.24103-1-include@grrlz.net>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This enabled knob is a disgusting terrible hack. It has rolled its
own read/write pair since 2007, writing '1' or '0' into a three byte
buffer by hand just to print a single character, with an XXX comment
begging debugfs for write callbacks on bool files.
DEFINE_DEBUGFS_ATTRIBUTE showed up in 2016 and does exactly that, so
the disgusting terrible hack has outlived its excuse for nine years.
Kill it, and the stale comment with it.

The behavior does not change, except the write only accepts 0/1 now
instead of y/n/on/off, and nothing uses anything else.

Signed-off-by: Bradley Morgan <include@grrlz.net>
---
Changes since v1:
 - Added the missing Signed-off-by, sorry.

 kernel/kprobes.c | 43 +++++++++----------------------------------
 1 file changed, 9 insertions(+), 34 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index bfc89083daa9..044c6b5fd2aa 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -3013,47 +3013,22 @@ static int disarm_all_kprobes(void)
 	return ret;
 }
 
-/*
- * XXX: The debugfs bool file interface doesn't allow for callbacks
- * when the bool state is switched. We can reuse that facility when
- * available
- */
-static ssize_t read_enabled_file_bool(struct file *file,
-	       char __user *user_buf, size_t count, loff_t *ppos)
+static int kprobes_enabled_set(void *data, u64 val)
 {
-	char buf[3];
+	if (val)
+		return arm_all_kprobes();
 
-	if (!kprobes_all_disarmed)
-		buf[0] = '1';
-	else
-		buf[0] = '0';
-	buf[1] = '\n';
-	buf[2] = 0x00;
-	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+	return disarm_all_kprobes();
 }
 
-static ssize_t write_enabled_file_bool(struct file *file,
-	       const char __user *user_buf, size_t count, loff_t *ppos)
+static int kprobes_enabled_get(void *data, u64 *val)
 {
-	bool enable;
-	int ret;
-
-	ret = kstrtobool_from_user(user_buf, count, &enable);
-	if (ret)
-		return ret;
-
-	ret = enable ? arm_all_kprobes() : disarm_all_kprobes();
-	if (ret)
-		return ret;
-
-	return count;
+	*val = !kprobes_all_disarmed;
+	return 0;
 }
 
-static const struct file_operations fops_kp = {
-	.read =         read_enabled_file_bool,
-	.write =        write_enabled_file_bool,
-	.llseek =	default_llseek,
-};
+DEFINE_DEBUGFS_ATTRIBUTE(fops_kp, kprobes_enabled_get,
+			 kprobes_enabled_set, "%llu\n");
 
 static int __init debugfs_kprobe_init(void)
 {
-- 
2.47.3

