Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53BC3B961A;
	Tue, 14 Apr 2026 09:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776158091; cv=none; b=ip538h6qpGH+6sFInpCKSMVEb1ip0QidjCWOBQCdC5wPJ0yb8/rZY4uOWQVRax19wvXmYsaDz/S+ush6A2jQL8JCsBERJTQSJQhv+MWDJeCup4mBIsCjy779ZrwfQV78ZB1WqkmkCJyUlXrZ1Va2zXlpo8/ZEIwndA4/hGJScPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776158091; c=relaxed/simple;
	bh=rqs+M1PyAlmYt6BIh4c8u/Ci2zxPhYMYAfWmhLkdOIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GAEU6EYSVE6GmfrYYfhgplqL1VvkP4X4Y34bVj2b6ifdPhw8U6J0VH2Ohu8OqhjehWwCMQvsp0ICqCKjf3CwkjQW7MT3I34nUs70wu8tlp0pCYCDsijBhFefvXzShVvcuEa+EuONyY9ArIuoT6RCN8UxVsI/BHosDYXWSVB5s/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ti7Elztc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ti7Elztc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C0DC19425;
	Tue, 14 Apr 2026 09:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776158091;
	bh=rqs+M1PyAlmYt6BIh4c8u/Ci2zxPhYMYAfWmhLkdOIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ti7ElztcLtiIZag17zTXfv7rVzVDq+35nVrgRJcWdGweR9XSNUNhvZLthDHB57azv
	 fO5emaQ5afHS8nPcPnGBvpIuLRmUr+oCBz/9ROaJ0BnjdqRKCn0Wy1FMqyZjX2R+Fq
	 gwlgMHyBGKeCbeaSplbOUXrwU3uiPnvS5PNdEoFS+EA7+r708awvW1tC0iaWnjVkf+
	 WPqWUtX6ogAFw74VXYCO3OBxoQ6WrL2yiOf+kZUKVC2BYrKkyNxyJBGTcaxlFZHIjd
	 b+ZEZ++6UP9KcgFwm84/8Iq6ruQw+lWL5OVrSJta9lzeacfAN7AgPFvle8/bQZTvDv
	 vgJo5uY+uoHKg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v6 1/5] tracing/fprobe: Reject registration of a registered fprobe before init
Date: Tue, 14 Apr 2026 18:14:49 +0900
Message-ID:  <177615808886.1165997.1302205504890949839.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
In-Reply-To:  <177615807787.1165997.921227352050738693.stgit@mhiramat.tok.corp.google.com>
References:  <177615807787.1165997.921227352050738693.stgit@mhiramat.tok.corp.google.com>
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

Reject registration of a registered fprobe which is on the fprobe
hash table before initializing fprobe.
The add_fprobe_hash() checks this re-register fprobe, but since
fprobe_init() clears hlist_array field, it is too late to check it.
It has to check the re-registration before touncing fprobe.

Fixes: 4346ba160409 ("fprobe: Rewrite fprobe on function-graph tracer")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v6:
  - Newly added.
---
 kernel/trace/fprobe.c |   21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index dcadf1d23b8a..fc7018b28fdd 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -4,6 +4,7 @@
  */
 #define pr_fmt(fmt) "fprobe: " fmt
 
+#include <linux/cleanup.h>
 #include <linux/err.h>
 #include <linux/fprobe.h>
 #include <linux/kallsyms.h>
@@ -107,7 +108,7 @@ static bool delete_fprobe_node(struct fprobe_hlist_node *node)
 }
 
 /* Check existence of the fprobe */
-static bool is_fprobe_still_exist(struct fprobe *fp)
+static bool fprobe_registered(struct fprobe *fp)
 {
 	struct hlist_head *head;
 	struct fprobe_hlist *fph;
@@ -120,7 +121,7 @@ static bool is_fprobe_still_exist(struct fprobe *fp)
 	}
 	return false;
 }
-NOKPROBE_SYMBOL(is_fprobe_still_exist);
+NOKPROBE_SYMBOL(fprobe_registered);
 
 static int add_fprobe_hash(struct fprobe *fp)
 {
@@ -132,9 +133,6 @@ static int add_fprobe_hash(struct fprobe *fp)
 	if (WARN_ON_ONCE(!fph))
 		return -EINVAL;
 
-	if (is_fprobe_still_exist(fp))
-		return -EEXIST;
-
 	head = &fprobe_table[hash_ptr(fp, FPROBE_HASH_BITS)];
 	hlist_add_head_rcu(&fp->hlist_array->hlist, head);
 	return 0;
@@ -149,7 +147,7 @@ static int del_fprobe_hash(struct fprobe *fp)
 	if (WARN_ON_ONCE(!fph))
 		return -EINVAL;
 
-	if (!is_fprobe_still_exist(fp))
+	if (!fprobe_registered(fp))
 		return -ENOENT;
 
 	fph->fp = NULL;
@@ -482,7 +480,7 @@ static void fprobe_return(struct ftrace_graph_ret *trace,
 		if (!fp)
 			break;
 		curr += FPROBE_HEADER_SIZE_IN_LONG;
-		if (is_fprobe_still_exist(fp) && !fprobe_disabled(fp)) {
+		if (fprobe_registered(fp) && !fprobe_disabled(fp)) {
 			if (WARN_ON_ONCE(curr + size > size_words))
 				break;
 			fp->exit_handler(fp, trace->func, ret_ip, fregs,
@@ -841,12 +839,14 @@ int register_fprobe_ips(struct fprobe *fp, unsigned long *addrs, int num)
 	struct fprobe_hlist *hlist_array;
 	int ret, i;
 
+	guard(mutex)(&fprobe_mutex);
+	if (fprobe_registered(fp))
+		return -EEXIST;
+
 	ret = fprobe_init(fp, addrs, num);
 	if (ret)
 		return ret;
 
-	mutex_lock(&fprobe_mutex);
-
 	hlist_array = fp->hlist_array;
 	if (fprobe_is_ftrace(fp))
 		ret = fprobe_ftrace_add_ips(addrs, num);
@@ -866,7 +866,6 @@ int register_fprobe_ips(struct fprobe *fp, unsigned long *addrs, int num)
 				delete_fprobe_node(&hlist_array->array[i]);
 		}
 	}
-	mutex_unlock(&fprobe_mutex);
 
 	if (ret)
 		fprobe_fail_cleanup(fp);
@@ -928,7 +927,7 @@ int unregister_fprobe(struct fprobe *fp)
 	int ret = 0, i, count;
 
 	mutex_lock(&fprobe_mutex);
-	if (!fp || !is_fprobe_still_exist(fp)) {
+	if (!fp || !fprobe_registered(fp)) {
 		ret = -EINVAL;
 		goto out;
 	}

