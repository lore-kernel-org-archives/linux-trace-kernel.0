Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC8036197F;
	Tue, 18 Aug 2026 01:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.167.222.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787017767; cv=none; b=IRybAUbY3/BbfgIGXmpfjM0hDTJkHNq0i7btFTDmTXH8VcNkE5DW7Wkr56ZxiChEu2w/B9iAZoXKyfqni1xlj9GFKe3V/ILftGV4DsQ5neTzLt7vKO6TFwhHAcSfzNAWmxLaKRpmwkLOJjqS+taZ4D66R50I6PbNlLub3uwluUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787017767; c=relaxed/simple;
	bh=bwhWo0hek5rBhE1m0hibdd5mIgRosMqhyVy2zNv6gTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nS/I/J3J4Acj5pGODrm4apDCLnOQoXAQKzPpTlF9ohPGbTZkOw3AAPPnXHScFPCBi494LdRz2MYHQTjEtLfIjCw0dhg4QttR2QEWOu3Azlj9m44lpsQS2Rwr786B+ylm48UsRC8ME5fWNYLohgqo12FdmMoRfE/hKmcNGWcKLgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=nWtZw8AX; arc=none smtp.client-ip=198.167.222.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="nWtZw8AX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1787017761;
	bh=D1VLsZxHNhJ3v+xdlRBBnkDRdhvXFPEoQH3K6UtYqW0=;
	h=From:To:Cc:Subject:Date:From;
	b=nWtZw8AXAE3AjbEPg+dSjN3gBPPzjVNDsMyMnrFJEs7/9vDIWUm2wzkXBvlFM7wnT
	 Zthtt6owTFS6vYLGrNk2QutISDlmY4w5GEDkFao2yplI205yR9BSJ5V52cvy+9pMNI
	 pt5gr5A2Mv1Di2EXmPwYMpLtDtrvbXSo/sUF75VM=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with UTF8SMTP id 4hPCL914CZz6vNR;
	Tue, 18 Aug 2026 01:49:21 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4hPCL85kZPz4y6W;
	Tue, 18 Aug 2026 01:49:20 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: Naveen N Rao <naveen@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] kprobes: use DEFINE_DEBUGFS_ATTRIBUTE for the enabled knob
Date: Tue, 18 Aug 2026 01:49:20 +0000
Message-ID: <20260818014920.23870-1-include@grrlz.net>
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
---
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

