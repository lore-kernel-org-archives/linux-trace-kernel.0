Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E38C15445B
	for <linux-trace-kernel@vger.kernel.org>; Mon, 30 Sep 2024 07:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727680870; cv=none; b=fkKEmuJJIdkRaNn7QQMHEtKjIdxnf6KXw9njA0CU+ErLY7CU/GJvu38rwPSiHEgeMVHEtnGm2j9wU7+LnKvmAL4ytYYie6KSR316/VWuN4CYfxHskXmxxxS0Y7FqDVj+p8T/L2ONwnRc2xF6HI14xJ8ZoVqYg3F6/PqIQ56I/4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727680870; c=relaxed/simple;
	bh=6gadjSg9Q11+9R2pCYsg7T8zdLXg7ykldAfBEPwgh1w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CNqPepZrdSficzlyFpY+cCEXu1RcGYrgkbMbmb1ZnKlRTa47lvU396MyQMfmRRlC+pQ1uBbvTlVn6iwzlhbr+gaCundn5meQiVYGkmN52dVOn/6jvorvllxjRBKvT48ZvE+QtEbVTUbqdPzG+L6a5ekvAtfl8Tvc33zMrVLCGc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XHCCP0XKhz20pkL;
	Mon, 30 Sep 2024 15:20:33 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id A5A6E18001B;
	Mon, 30 Sep 2024 15:20:59 +0800 (CST)
Received: from huawei.com (10.67.174.28) by kwepemd200013.china.huawei.com
 (7.221.188.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Mon, 30 Sep
 2024 15:20:57 +0800
From: Liao Chang <liaochang1@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>, <mark.rutland@arm.com>,
	<mathieu.desnoyers@efficios.com>
CC: <linux-trace-kernel@vger.kernel.org>
Subject: [PATCH v2] function_graph: Improve fgraph LRU data initialization
Date: Mon, 30 Sep 2024 07:10:31 +0000
Message-ID: <20240930071031.3694979-1-liaochang1@huawei.com>
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
And use fgraph_lru_next and fgraph_lru_last as the indicator of
initialization.

v2->v1:
Fixup the build error reported by kernel test robot <lkp@intel.com>.
Since some architectures use ftrace_graph_entry_stub() for the static
ftrace scenario, then restore the definition without static keyword in
the original patch [1]. And rebasing patch to next-20240927.

[1] https://lore.kernel.org/all/20240912111550.1752115-1-liaochang1@huawei.com

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 kernel/trace/fgraph.c | 54 +++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index d7d4fb403f6f..eb2fbc0338c7 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -172,20 +172,41 @@ enum {
 DEFINE_STATIC_KEY_FALSE(kill_ftrace_graph);
 int ftrace_graph_active;
 
-static struct fgraph_ops *fgraph_array[FGRAPH_ARRAY_SIZE];
+int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace,
+			    struct fgraph_ops *gops)
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

