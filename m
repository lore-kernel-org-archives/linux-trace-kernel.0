Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0181F429827;
	Mon, 13 Jul 2026 13:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783950413; cv=none; b=lMZHmpMbYwSdJ7rxdrzq5LGckccgUEIhYGKi+VjgqvyRdv2AdujupfjqZWMb32xOuqI1mOEtYRDj2iPSBCo6J0xwGmRiMSlyP2lTGSVMUgsO68QN6ZOZPsrHyF0CJW++R5weqeFaQjq6LtE3VzR6m5PoZ41o7rc3vw6ECfqriLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783950413; c=relaxed/simple;
	bh=l+Pf02dk04mwVmN5/wE94fWDU98qCHOFoLEQZxZsNKo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=goFi+Ogkv7OYJZddqFUC6e2HV4k118xmIUU+LJGMjrRyuSsStzpk5HnaiIkgUIR8oxpAgmXVDOjkEYBFg1xm4ykTn9d+dSb1jifTs47cCcueTRSujqG68WK1OkBn8mC2T9m9MePDsitfnigvLpzjYXtUdzwsWzbGAArk2Jy3+mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gzNyK2S8BzYQthf;
	Mon, 13 Jul 2026 21:46:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 076864058D;
	Mon, 13 Jul 2026 21:46:47 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgDHrSlB7FRq0KpfBA--.16358S2;
	Mon, 13 Jul 2026 21:46:46 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tengda Wu <wutengda@huaweicloud.com>
Subject: [PATCH] tracing: Add mutex to trace_parser to fix concurrent write races
Date: Mon, 13 Jul 2026 13:46:40 +0000
Message-Id: <20260713134640.708323-1-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgDHrSlB7FRq0KpfBA--.16358S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF48Zw4UJrWUXFW3ur4DJwb_yoWrGF4rpF
	y3Krs7Jr47tF4Iyr4kur48uF48Xw15JryUG3Z5J3yftF9rJF17Wr9ruF9xuw1rtryxJrZI
	yF4Y9r4UKr17Zw7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUonmRUU
	UUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

The trace_parser structure is allocated and initialized when a trace
file is opened, and is subsequently used in the write handler to parse
user input. If userspace opens a trace file descriptor and shares it
across multiple threads, concurrent write calls will race on the
parser's internal state, specifically the idx, cont, and buffer fields,
leading to corrupted input or undefined behavior.

Fix this by embedding a mutex directly in struct trace_parser. The mutex
is initialized in trace_parser_get_init() and destroyed in
trace_parser_put(). All write-side users that access parser state
(trace_get_user() followed by checking trace_parser_loaded() /
trace_parser_cont() against the buffer) now hold the mutex across the
full critical section, avoiding any TOCTOU gap between the parse and the
subsequent consumption of parser->buffer.

Affected write paths:
  - ftrace_graph_write / ftrace_graph_release
  - ftrace_regex_write / ftrace_regex_release

Fixes: e704eff3ff51 ("ftrace: Have set_graph_function handle multiple functions in one write")
Fixes: 689fd8b65d66 ("tracing: trace parser support for function and graph")
Cc: stable@vger.kernel.org
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 kernel/trace/ftrace.c | 7 +++++++
 kernel/trace/trace.c  | 2 ++
 kernel/trace/trace.h  | 1 +
 3 files changed, 10 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index f93e34dd2328..ef47e5659283 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5842,6 +5842,8 @@ ftrace_regex_write(struct file *file, const char __user *ubuf,
 	/* iter->hash is a local copy, so we don't need regex_lock */
 
 	parser = &iter->parser;
+
+	guard(mutex)(&parser->lock);
 	read = trace_get_user(parser, ubuf, cnt, ppos);
 
 	if (read >= 0 && trace_parser_loaded(parser) &&
@@ -6984,12 +6986,14 @@ int ftrace_regex_release(struct inode *inode, struct file *file)
 		iter = file->private_data;
 
 	parser = &iter->parser;
+	mutex_lock(&parser->lock);
 	if (trace_parser_loaded(parser)) {
 		int enable = !(iter->flags & FTRACE_ITER_NOTRACE);
 
 		ftrace_process_regex(iter, parser->buffer,
 				     parser->idx, enable);
 	}
+	mutex_unlock(&parser->lock);
 
 	trace_parser_put(parser);
 
@@ -7321,10 +7325,12 @@ ftrace_graph_release(struct inode *inode, struct file *file)
 
 		parser = &fgd->parser;
 
+		mutex_lock(&parser->lock);
 		if (trace_parser_loaded((parser))) {
 			ret = ftrace_graph_set_hash(fgd->new_hash,
 						    parser->buffer);
 		}
+		mutex_unlock(&parser->lock);
 
 		trace_parser_put(parser);
 
@@ -7437,6 +7443,7 @@ ftrace_graph_write(struct file *file, const char __user *ubuf,
 
 	parser = &fgd->parser;
 
+	guard(mutex)(&parser->lock);
 	read = trace_get_user(parser, ubuf, cnt, ppos);
 
 	if (read >= 0 && trace_parser_loaded(parser) &&
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 1146b83b711a..fbf5f220d580 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1100,6 +1100,7 @@ int trace_parser_get_init(struct trace_parser *parser, int size)
 		return 1;
 
 	parser->size = size;
+	mutex_init(&parser->lock);
 	return 0;
 }
 
@@ -1108,6 +1109,7 @@ int trace_parser_get_init(struct trace_parser *parser, int size)
  */
 void trace_parser_put(struct trace_parser *parser)
 {
+	mutex_destroy(&parser->lock);
 	kfree(parser->buffer);
 	parser->buffer = NULL;
 }
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 2537c33ddd49..f643842d2ffd 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1387,6 +1387,7 @@ struct trace_parser {
 	char		*buffer;
 	unsigned	idx;
 	unsigned	size;
+	struct mutex	lock;
 };
 
 static inline bool trace_parser_loaded(struct trace_parser *parser)
-- 
2.34.1

