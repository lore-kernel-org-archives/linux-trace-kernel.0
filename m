Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CAFEEC0;
	Fri, 19 Jul 2024 10:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721384806; cv=none; b=U/NFeqRczSBtWe4BQlppegPmwuRUQoaPQ8k/59pp6rzN6hjM7FOVvo0MYxS5TjwDq9DtkJKXpcRtTInlkVGmDja9t9papCVLBIG/BZXQ/EIycLpRjN4C3aL7bIRZ69HYPUWOepsQ0yr7uaHeLoWeu6wTLlH6hlm/E9gVEerhrCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721384806; c=relaxed/simple;
	bh=aNwTxU96+ZwmKiLWvRO7l2ZzPLTFWz/5G7HpgjGUAOg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=feTQy4VI0j01BGyvZw4NhogNdteVQEOKoDPKKlBm8BhQ+3kXnO/xIriIa92xUqho5dJKhW81ZOL4uAUd4HHQZ4XP6GPHWsMmHT00aZVCwtsd1mcoTKbebgn44N3XTIl57w3I0TC1OlIO4Y9Fw8yhJfxTvdn0MAomegwSV6fMsSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9SW12+9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9SW12+9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7EECC32782;
	Fri, 19 Jul 2024 10:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721384806;
	bh=aNwTxU96+ZwmKiLWvRO7l2ZzPLTFWz/5G7HpgjGUAOg=;
	h=From:To:Cc:Subject:Date:From;
	b=I9SW12+9YDrCMpPaq6rlUHRg2C23GG743yfeXQ794uc0qsrckBrHZrVKDQtqHDbxp
	 Sm7hXiMPXxtCO4OgT0cNi5YhQvC2vXljrM3xSXmL0lvUNrRNxK7FurYZx/XZjjgP/p
	 VBV3AxRXwGpY8QO7+nEMcRbFHayiRTOKDQRJojShaVTgb2PRHVBVIsg3+7uwfygJyO
	 uxcaXpMSj0+04twMUaWtx2yfFNXwPbD05pF+4yE9FyAJWJ0crnC0ikgRDEdTvP2tuA
	 4GIRiOuuUdf/9OkLrXl/72UaCwyh+9gKzoAwTmqnu891sNlTRravbeyuv3lna4Bu8d
	 JPz6+YSpFxo9w==
From: Arnd Bergmann <arnd@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Zheng Yejian <zhengyejian1@huawei.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Huang Yiwei <quic_hyiwei@quicinc.com>,
	"Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing/ring-buffer: hide unused last_boot_fops
Date: Fri, 19 Jul 2024 12:26:33 +0200
Message-Id: <20240719102640.718554-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

This variable is used only in an #ifdef, which causes a W=1 warning
with some compilers:

kernel/trace/trace.c:7570:37: error: 'last_boot_fops' defined but not used [-Werror=unused-const-variable=]
 7570 | static const struct file_operations last_boot_fops = {

Guard this one with the same #ifdef.

Fixes: 7a1d1e4b9639 ("tracing/ring-buffer: Add last_boot_info file to boot instance")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Alternatively it could be marked as __maybe_unused, but I tried to follow
the style used in this file.
---
 kernel/trace/trace.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 5462fb10ff64..6ab24213d496 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6913,6 +6913,7 @@ tracing_total_entries_read(struct file *filp, char __user *ubuf,
 	return simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
 }
 
+#ifdef CONFIG_TRACER_SNAPSHOT
 static ssize_t
 tracing_last_boot_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
 {
@@ -6927,6 +6928,7 @@ tracing_last_boot_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t
 
 	return simple_read_from_buffer(ubuf, cnt, ppos, buf, seq_buf_used(&seq));
 }
+#endif
 
 static int tracing_buffer_meta_open(struct inode *inode, struct file *filp)
 {
@@ -7567,12 +7569,14 @@ static const struct file_operations trace_time_stamp_mode_fops = {
 	.release	= tracing_single_release_tr,
 };
 
+#ifdef CONFIG_TRACER_SNAPSHOT
 static const struct file_operations last_boot_fops = {
 	.open		= tracing_open_generic_tr,
 	.read		= tracing_last_boot_read,
 	.llseek		= generic_file_llseek,
 	.release	= tracing_release_generic_tr,
 };
+#endif
 
 #ifdef CONFIG_TRACER_SNAPSHOT
 static const struct file_operations snapshot_fops = {
-- 
2.39.2

