Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687EC346E66;
	Mon, 20 Apr 2026 14:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776693651; cv=none; b=klr7X+PfMM+QZokNJ4aQ69LVNm9E2kQgY4u4cxxjqbyEE09z3xK4oN8nNuKZrd0d2yU4nTATN3NpVw7TtuaZdKH7OmsoFI0pDe5LRRJMBqNPutvcMzvtyhY+Wu3EYC7FCvm5lNoIfcu5d4GIl8kUywlYmT4TRAXXttdnLxn96xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776693651; c=relaxed/simple;
	bh=O73fWV9BDB514QImUXrNixIWJt61Gq+Vakfsm1Ay7I0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D1SCJEV4uMHdCzZ18eoZQzcPxNCTzr9b2+HTOkW2+dqEmJ6PAeVFyWUfx4mMqj+P5RwQH4n7iSlLwtuSnGFHRKrW7H3hbOZr1NDgR1Kft/SSpGw6LFVebrU0f/zlKSEua9WNBXA85imc1K8KHGUCgHlNWQSH0ph3FkYDZ0yU5fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GwWaxxVa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwWaxxVa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 186C2C19425;
	Mon, 20 Apr 2026 14:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776693651;
	bh=O73fWV9BDB514QImUXrNixIWJt61Gq+Vakfsm1Ay7I0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GwWaxxVaeeLqQ5SPdtOr7QjyVSyDZQnPePGsTHToeBTQpmDWHh8RJMu8FskmirRcE
	 81YAn+PxucBVHR7KPT+j6EbcUVWnMq3SNDBbFZupxoGlLdBWdo+tfEHswcCVg0/fFp
	 V76tbQ1weTlxRKHc3A2f5CIWFjupCJkMjh6YcmHFDys/5Cw44TwvBRqm3fDV2R/WL1
	 Ffm3FrJRTQ+Ad9GqVSLCl+1rx2IZ66hy5UzAH5HzFwJT3wo5f4EC5l6Sx1xdtgmM/Z
	 WY6IYaUSF3BRmHh75mQBB1XpSiFL4a1DGnqahbN7AzsXeq/CUi1Dq53beVHaKjoXJW
	 EQWGavZX5R/ZQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v10 1/8] tracing/fprobe: Reject registration of a registered fprobe before init
Date: Mon, 20 Apr 2026 23:00:48 +0900
Message-ID:  <177669364845.132053.18375367916162315835.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
In-Reply-To:  <177669363667.132053.12454670015890859277.stgit@mhiramat.tok.corp.google.com>
References:  <177669363667.132053.12454670015890859277.stgit@mhiramat.tok.corp.google.com>
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
index 56d145017902..af9ba7250874 100644
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
@@ -480,7 +478,7 @@ static void fprobe_return(struct ftrace_graph_ret *trace,
 		if (!fp)
 			break;
 		curr += FPROBE_HEADER_SIZE_IN_LONG;
-		if (is_fprobe_still_exist(fp) && !fprobe_disabled(fp)) {
+		if (fprobe_registered(fp) && !fprobe_disabled(fp)) {
 			if (WARN_ON_ONCE(curr + size > size_words))
 				break;
 			fp->exit_handler(fp, trace->func, ret_ip, fregs,
@@ -839,12 +837,14 @@ int register_fprobe_ips(struct fprobe *fp, unsigned long *addrs, int num)
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
@@ -864,7 +864,6 @@ int register_fprobe_ips(struct fprobe *fp, unsigned long *addrs, int num)
 				delete_fprobe_node(&hlist_array->array[i]);
 		}
 	}
-	mutex_unlock(&fprobe_mutex);
 
 	if (ret)
 		fprobe_fail_cleanup(fp);
@@ -926,7 +925,7 @@ int unregister_fprobe(struct fprobe *fp)
 	int ret = 0, i, count;
 
 	mutex_lock(&fprobe_mutex);
-	if (!fp || !is_fprobe_still_exist(fp)) {
+	if (!fp || !fprobe_registered(fp)) {
 		ret = -EINVAL;
 		goto out;
 	}

