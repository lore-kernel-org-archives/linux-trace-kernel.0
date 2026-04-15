Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB95314A60;
	Wed, 15 Apr 2026 10:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776247725; cv=none; b=ojJ/qblKxkb3VhijlPMFawq9pzHQq5CTEDtIcGmsmcyzXsPfCX/dizLMVdfmPp9Q8xHAJyWrHtSIzXUx34eu+tdADTzMRzwMa9eqAckCOBPr+4pgawbxI9p6YGVf7/PUX4Nzqn5G/tHGbZM9SgH9ThldDKN3ePleR/PKFySojpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776247725; c=relaxed/simple;
	bh=rqs+M1PyAlmYt6BIh4c8u/Ci2zxPhYMYAfWmhLkdOIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cNMcQ0YdORciIsblnxPYg0UWsmToX0tKJZSStrxSX7wYT16TGfCilttsGy9G1ALe0IUowMUe7phlob825ZqOIB3QpOzq33Yezi1rYbnSKHUMuIuuNQUmI8huvx6PDmVyeZW5+r8hJ27dTSKJRuTRScblvQBKj1w0JTkf3vg1ogA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKNjs56O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKNjs56O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F80C19424;
	Wed, 15 Apr 2026 10:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776247724;
	bh=rqs+M1PyAlmYt6BIh4c8u/Ci2zxPhYMYAfWmhLkdOIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iKNjs56OdDhf14GyqgobValCarJnw8OJ2FwxfnnOPoTyNHLiWO2Og4ZQAZnohPqqP
	 YEHONAh3YQLd22c3G49s9vHlcZ+QDRJsVVqBvto0HeBwIOGPIFhld5NnBTwgC8Nejn
	 Qj5Gngh72VEFMFm6ctOtI7mMiann8MfN7vUhGvkuskMLfWooyCYE13ZZ/Dx6I7/gDp
	 FBqGB5nS2hoPWjG2K/3ATOTgUcw8UCs3q6PbYgAHM/MDCXKAHUIF2Ofz+BTegen5AU
	 WPp95ukB+Bc9bcPOmbkY7I+KgnHL/zZF2yS6xIeBnwiUxqynpiaptHQld9GSvq3NQ4
	 kEpbhvd7G3fbw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v7 1/6] tracing/fprobe: Reject registration of a registered fprobe before init
Date: Wed, 15 Apr 2026 19:08:42 +0900
Message-ID:  <177624772205.2407691.8530954581518787436.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
In-Reply-To:  <177624771150.2407691.15764846647014540969.stgit@mhiramat.tok.corp.google.com>
References:  <177624771150.2407691.15764846647014540969.stgit@mhiramat.tok.corp.google.com>
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

