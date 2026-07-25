Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DE62264A8;
	Sat, 25 Jul 2026 02:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784947663; cv=none; b=WCtVBwJEzph/Hs/dI/kwrzrSma7lgG1Y+9ajPYOns1+T8o+4Zyh5pXFarb/HBDHay4xhNAlPztyFI+hCNHgwhCbggw/BE9jmg/yRJ6SYF2LQDs1sEf8zjgh27JilDVfCbFoBMzagAK6+0Srg2HGPJrNMn6l7wmE96IQYE1SWPlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784947663; c=relaxed/simple;
	bh=XIIdNws047J/ip0u66j9QMG6eMCHgPn5azaVs+PNon0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=by7s5bcaIdjHC7nUsDcCXE3zVkEJWzOd0kZojNeUOg9NOE+qxbQ4xdMpRXCdfUur2VV2JBnerN0Y0KYFsH4byIwR/y5rkCy3onrEzxvR2r/NCTH3SdtpREyc393VC2eQTIJYRHbjX1AEKIW2pyxVSWjAwmaxHdpzP+4u/zCiY5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h6Tlp07tVzYQtr4;
	Sat, 25 Jul 2026 10:47:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 77CCB40592;
	Sat, 25 Jul 2026 10:47:35 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgAH7SjDI2RqhLbYCQ--.3539S2;
	Sat, 25 Jul 2026 10:47:35 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tengda Wu <wutengda@huaweicloud.com>
Subject: [PATCH v4] ftrace: Add global mutex to serialize trace_parser access
Date: Sat, 25 Jul 2026 02:47:21 +0000
Message-Id: <20260725024721.1983675-1-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAH7SjDI2RqhLbYCQ--.3539S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF45Zw4DWr45JFykCrykZrb_yoW5try5pF
	y5Krs2kr47tF40krsF9a18ZF10q345try5GFn5J34ftFsrJF129ry29FWa9F1Utry7JrW3
	tr4F9r1UKr47Z3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
	W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUBVb
	kUUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

In ftrace, the trace_parser structure is allocated and initialized when
a trace file is opened, and is subsequently used across write and release
handlers to parse user input.

The affected handler paths and their specific functions are:
  - Open paths: ftrace_regex_open(), ftrace_graph_open()
  - Write paths: ftrace_regex_write(), ftrace_graph_write()
  - Release paths: ftrace_regex_release(), ftrace_graph_release()

If userspace opens a trace file descriptor and shares it across multiple
threads, concurrent write calls will race on the parser's internal state,
specifically the 'idx', 'cont', and 'buffer' fields, leading to corrupted
input or undefined behavior.

Fix this by adding a global mutex, parser_lock, to serialize all access
to trace_parser across write and release paths, preventing concurrent
corruption of parser state.

Fixes: e704eff3ff51 ("ftrace: Have set_graph_function handle multiple functions in one write")
Fixes: 689fd8b65d66 ("tracing: trace parser support for function and graph")
Cc: stable@vger.kernel.org
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
v4: Add static modifier to parser_lock. (Steven)
v3: https://lore.kernel.org/all/20260723133404.1926732-1-wutengda@huaweicloud.com/
v2: https://lore.kernel.org/all/20260715081937.1469757-1-wutengda@huaweicloud.com/
v1: https://lore.kernel.org/all/20260713134640.708323-1-wutengda@huaweicloud.com/

 kernel/trace/ftrace.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index f93e34dd2328..6c47a94f5924 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1097,6 +1097,12 @@ struct ftrace_ops global_ops = {
 					  FTRACE_OPS_FL_PID,
 };
 
+/*
+ * parser_lock - Protects trace_parser state against concurrent operations.
+ * Held across trace_get_user() and subsequent buffer parsing to prevent races.
+ */
+static DEFINE_MUTEX(parser_lock);
+
 /*
  * Used by the stack unwinder to know about dynamic ftrace trampolines.
  */
@@ -5842,6 +5848,8 @@ ftrace_regex_write(struct file *file, const char __user *ubuf,
 	/* iter->hash is a local copy, so we don't need regex_lock */
 
 	parser = &iter->parser;
+
+	guard(mutex)(&parser_lock);
 	read = trace_get_user(parser, ubuf, cnt, ppos);
 
 	if (read >= 0 && trace_parser_loaded(parser) &&
@@ -6984,12 +6992,14 @@ int ftrace_regex_release(struct inode *inode, struct file *file)
 		iter = file->private_data;
 
 	parser = &iter->parser;
+	mutex_lock(&parser_lock);
 	if (trace_parser_loaded(parser)) {
 		int enable = !(iter->flags & FTRACE_ITER_NOTRACE);
 
 		ftrace_process_regex(iter, parser->buffer,
 				     parser->idx, enable);
 	}
+	mutex_unlock(&parser_lock);
 
 	trace_parser_put(parser);
 
@@ -7321,10 +7331,12 @@ ftrace_graph_release(struct inode *inode, struct file *file)
 
 		parser = &fgd->parser;
 
+		mutex_lock(&parser_lock);
 		if (trace_parser_loaded((parser))) {
 			ret = ftrace_graph_set_hash(fgd->new_hash,
 						    parser->buffer);
 		}
+		mutex_unlock(&parser_lock);
 
 		trace_parser_put(parser);
 
@@ -7437,6 +7449,7 @@ ftrace_graph_write(struct file *file, const char __user *ubuf,
 
 	parser = &fgd->parser;
 
+	guard(mutex)(&parser_lock);
 	read = trace_get_user(parser, ubuf, cnt, ppos);
 
 	if (read >= 0 && trace_parser_loaded(parser) &&
-- 
2.34.1

