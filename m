Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCC613BC0C;
	Wed, 24 Sep 2025 00:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758673602; cv=none; b=gD4gKeRevPp/fxgTCG33pfPH9WozQ8TujA1q4iVQeUnA4dbwAab857M4xAWVClY/bQncDSDbRe6tYxmnrhrcDtOsPr83Rn/B4D6r6M5PogmNet9ubBUVwahiilG7Hhfr9IdTAb2nut7h6+Zgq2kEMwwzjjwOH22bAsbCaqSZjyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758673602; c=relaxed/simple;
	bh=H2cO+VI0kYzohk6MO5jSBgkUZI2Z06PuktWSSlgY5sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HDr1lbCmBsd5TZTjWHREuMfGZpoDtfmbzgO5DOcL+IBwIyj6vQFQC9oFGFQSEAgO9xmeLBjkoWpBOcOEcvzlTyorrbzzPjuCBQF5nHvrGOxVjhEnoM5EVpyqsamCTQuS4BK4DLguxPB8tOirsgC8pyBowTmccahtsm1e192BLio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2UPziGH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2UPziGH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB844C4CEF5;
	Wed, 24 Sep 2025 00:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758673602;
	bh=H2cO+VI0kYzohk6MO5jSBgkUZI2Z06PuktWSSlgY5sk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R2UPziGHw5VCkZMTX8KIkTxFdtENLtcorFWvT9GStVqEIfC2U+0ehxJtrp2VevANX
	 4soeDkYnMVo76TEvMUgoPgI2eyn/CHexnTHB3lRii6GHAip/h7ZjKg9vpqFYUApPYx
	 s228M5ZBw3RSqNAc84JMNT79eoSt02WiId6sETzF8LDoTSo/LoUrt/HeDvga6aPl6g
	 U3dKvOlaY7K2BOhztmFpoC79RB4fSTVo3h45Rnc05KLJPnKAADd4UHT04JR9fX6hL+
	 5/QU3kyx4CmiOseZtygfBmeKnB+rJEIX49ghTvGQ2bzXiA8nJsV/p9my++4fr7/GWo
	 Ry01qeilwjvdA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
	Menglong Dong <dongml2@chinatelecom.cn>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 2/2] tracing: fprobe: Fix to remove recorded module addresses from filter
Date: Wed, 24 Sep 2025 09:26:39 +0900
Message-ID: <175867359903.600222.10400702167171128567.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <175867358989.600222.6175459620045800878.stgit@devnote2>
References: <175867358989.600222.6175459620045800878.stgit@devnote2>
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

Even if there is a memory allocation failure in fprobe_addr_list_add(),
there is a partial list of module addresses. So remove the recorded
addresses from filter if exists.
This also removes the redundant ret local variable.

Fixes: a3dc2983ca7b ("tracing: fprobe: Cleanup fprobe hash when module unloading")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/fprobe.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 12ec194fdfed..95e43814b85b 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -434,8 +434,9 @@ static int fprobe_addr_list_add(struct fprobe_addr_list *alist, unsigned long ad
 {
 	unsigned long *addrs;
 
-	if (alist->index >= alist->size)
-		return -ENOMEM;
+	/* Previously we failed to expand the list. */
+	if (alist->index == alist->size)
+		return -ENOSPC;
 
 	alist->addrs[alist->index++] = addr;
 	if (alist->index < alist->size)
@@ -497,7 +498,7 @@ static int fprobe_module_callback(struct notifier_block *nb,
 	} while (node == ERR_PTR(-EAGAIN));
 	rhashtable_walk_exit(&iter);
 
-	if (alist.index < alist.size && alist.index > 0)
+	if (alist.index > 0)
 		ftrace_set_filter_ips(&fprobe_graph_ops.ops,
 				      alist.addrs, alist.index, 1, 0);
 	mutex_unlock(&fprobe_mutex);

