Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA431A76C9;
	Thu, 12 Sep 2024 11:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726140362; cv=none; b=r9XyV5vnX+2+B+nJSgmVA3fOY2EPwef6bdjJyFFkPLTm560bd7RtvCue5H37Jr9woZld7X7yxKZeRNBFWsPdcCaAf1SYsnT59IOPEmgRm6KMnE3YM54RL5gKcikjP7TjNWq8v+s5DjNPdzH5kr2G9vbDnJkQ+r041OMK7S70iF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726140362; c=relaxed/simple;
	bh=gWnTaDv2sYbLLHEDy9Budvd7mrKb1RwArh6HoJ2nEyA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ThESQ4T2TDrzGCrFUeizepWjQfF0gZnEsjaiY567/r8UnW4vzpXfJa3L2UIJdfuU/X/1Ff8yViL/QiGYcQYfjrExsEtNdzK75RGWqABwaogXwH/2s8xH89Tcf7dtYoY5iHrvdpX+99Casd4wJ8zNGerpUJU4g3OodO5Bo8YzdTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4X4FV71L6Lz1S9mk;
	Thu, 12 Sep 2024 19:25:19 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 6B5721A016C;
	Thu, 12 Sep 2024 19:25:50 +0800 (CST)
Received: from huawei.com (10.67.174.28) by kwepemd200013.china.huawei.com
 (7.221.188.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 12 Sep
 2024 19:25:49 +0800
From: Liao Chang <liaochang1@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>, <mark.rutland@arm.com>,
	<mathieu.desnoyers@efficios.com>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
Subject: [PATCH] function_graph: Simplify the initialization of fgraph LRU data
Date: Thu, 12 Sep 2024 11:15:50 +0000
Message-ID: <20240912111550.1752115-1-liaochang1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd200013.china.huawei.com (7.221.188.133)

This patch uses [first ... last] = value to initialize fgraph_array[].
And it declares all the callbacks in fgraph_stub as static, as they are
not called from external code.

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 include/linux/ftrace.h |  1 -
 kernel/trace/fgraph.c  | 54 +++++++++++++++++++++---------------------
 2 files changed, 27 insertions(+), 28 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index fd5e84d0ec47..76bfc5560b57 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1039,7 +1039,6 @@ typedef void (*trace_func_graph_ret_t)(struct ftrace_graph_ret *,
 typedef int (*trace_func_graph_ent_t)(struct ftrace_graph_ent *,
 				      struct fgraph_ops *); /* entry */
 
-extern int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace, struct fgraph_ops *gops);
 bool ftrace_pids_enabled(struct ftrace_ops *ops);
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index d7d4fb403f6f..41d14b455185 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -172,20 +172,41 @@ enum {
 DEFINE_STATIC_KEY_FALSE(kill_ftrace_graph);
 int ftrace_graph_active;
 
-static struct fgraph_ops *fgraph_array[FGRAPH_ARRAY_SIZE];
+static int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace,
+				   struct fgraph_ops *gops)
+{
+	return 0;
+}
+
+static void ftrace_graph_ret_stub(struct ftrace_graph_ret *trace,
+				  struct fgraph_ops *gops)
+{
+}
+
+static struct fgraph_ops fgraph_stub = {
+	.entryfunc = ftrace_graph_entry_stub,
+	.retfunc = ftrace_graph_ret_stub,
+};
+
+static struct fgraph_ops *fgraph_array[FGRAPH_ARRAY_SIZE] = {
+	[0 ... FGRAPH_ARRAY_SIZE - 1] = &fgraph_stub,
+};
 static unsigned long fgraph_array_bitmask;
 
 /* LRU index table for fgraph_array */
 static int fgraph_lru_table[FGRAPH_ARRAY_SIZE];
-static int fgraph_lru_next;
-static int fgraph_lru_last;
+static int fgraph_lru_next = -1;
+static int fgraph_lru_last = -1;
 
 /* Initialize fgraph_lru_table with unused index */
 static void fgraph_lru_init(void)
 {
-	int i;
+	if ((fgraph_lru_next >= 0) && (fgraph_lru_last >= 0))
+		return;
 
-	for (i = 0; i < FGRAPH_ARRAY_SIZE; i++)
+	fgraph_lru_next = fgraph_lru_last = 0;
+
+	for (int i = 0; i < FGRAPH_ARRAY_SIZE; i++)
 		fgraph_lru_table[i] = i;
 }
 
@@ -483,22 +504,6 @@ int __weak ftrace_disable_ftrace_graph_caller(void)
 }
 #endif
 
-int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace,
-			    struct fgraph_ops *gops)
-{
-	return 0;
-}
-
-static void ftrace_graph_ret_stub(struct ftrace_graph_ret *trace,
-				  struct fgraph_ops *gops)
-{
-}
-
-static struct fgraph_ops fgraph_stub = {
-	.entryfunc = ftrace_graph_entry_stub,
-	.retfunc = ftrace_graph_ret_stub,
-};
-
 static struct fgraph_ops *fgraph_direct_gops = &fgraph_stub;
 DEFINE_STATIC_CALL(fgraph_func, ftrace_graph_entry_stub);
 DEFINE_STATIC_CALL(fgraph_retfunc, ftrace_graph_ret_stub);
@@ -1250,12 +1255,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 
 	mutex_lock(&ftrace_lock);
 
-	if (!fgraph_array[0]) {
-		/* The array must always have real data on it */
-		for (i = 0; i < FGRAPH_ARRAY_SIZE; i++)
-			fgraph_array[i] = &fgraph_stub;
-		fgraph_lru_init();
-	}
+	fgraph_lru_init();
 
 	i = fgraph_lru_alloc_index();
 	if (i < 0 || WARN_ON_ONCE(fgraph_array[i] != &fgraph_stub)) {
-- 
2.34.1

