Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210F131F9A7;
	Fri, 17 Apr 2026 16:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776442675; cv=none; b=IcoODeIdCVOk1IAaJNimmzcUfp+g54NMK4dRmAx4Q6asoBr1ctqkjf0UtPH+5CSFQ32JT6wibq8BZ10uxImRryeNtnTQbRlXtB9RgXl2zR02rzXmOQPGe/xeG6b71IcRQBjI3zFJHSFgm1x2ShxwgXuVtfclN8Dby3Zwrh7BU30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776442675; c=relaxed/simple;
	bh=O73fWV9BDB514QImUXrNixIWJt61Gq+Vakfsm1Ay7I0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qqqTG+3t/1SlsJ0J6b34C0IIyodVMvxiWKF7VfVzfQv2aSNG/N8OLjENg2c1E9/uSmU25Yir2B02wYNmOrHrISes2JWY3pGyqbrJzfHG2m/91nZcmYsu9yXKk3KoZCW4cUbo2JW3wL0UZeggVmyGueB1BckWZC5gU0fVGRLDZU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yo8awadf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yo8awadf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC22C19425;
	Fri, 17 Apr 2026 16:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776442675;
	bh=O73fWV9BDB514QImUXrNixIWJt61Gq+Vakfsm1Ay7I0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yo8awadfTJCENRj7E5/NQn2oAexES/lSk5X01HhNYcRr84qNydDXOfKCYVr4kYfjC
	 dD9VMAaiqhoKYYXenfHfhu5TTpsUP2c/Uv+YrX6zqs060bKXQS0QAUYsclqtXzBeGB
	 aE80qrSxTU4EOZW6izhPB99w1zqOLCSKV11Gqq902AouHaAPIpAuNKV89fxYe/Tkq1
	 42iSXCH2R2isLggknPw83zw6ScC0Ik1o9jhQ66KkO6l5W4leAsUsKmxPeReCJBqEuw
	 /UMz4ZmyMDhC2TpMX3muE6rcLD6clOtExAOYjzwFqszCfdMBVyF4iopzHiXDjETU9+
	 Tmt+zO85V4ACQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v9 1/8] tracing/fprobe: Reject registration of a registered fprobe before init
Date: Sat, 18 Apr 2026 01:17:52 +0900
Message-ID:  <177644267234.584467.13912302304022705772.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
In-Reply-To:  <177644266147.584467.8179035927318998910.stgit@mhiramat.tok.corp.google.com>
References:  <177644266147.584467.8179035927318998910.stgit@mhiramat.tok.corp.google.com>
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

