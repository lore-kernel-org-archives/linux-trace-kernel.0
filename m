Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FDE25A2DD;
	Thu, 16 Apr 2026 10:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776334622; cv=none; b=MMKFcjXn/Be3/mi3kp6KaBdEXR0S1z+xWzddZW334ndsRIVuMLEkBRGz+zzyYOUAKYuAZDyNdCKN3EBLmLuXav/jMzT3BKcyQ4VSHST+WNkLZ7ntYVhQ91eKI6qHYT3uhP5ka3o4ELaOeRxs7o8Ejbi43rVuZ4VW/GfSzEnywPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776334622; c=relaxed/simple;
	bh=gN1BRrqXMRbChB0x61xF2kukdXPqZcRjnyQOsPmr+Ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q3D1yesJDI6FEgrSuMev5E6KF4+2woX6W6Rzd6iqnQDjCfDFW20FrwtmDAMghgCyOoBB02MKmYj+zYCfmrsBqLt19hQSIzoSSnsXH13aDvX4/HEdOkuS8tcnF2ty6zMWz5BDSFIVBPSBUMxyyaMi/gAt+qwWcULicmLvM9MUhlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/P1Rj7X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/P1Rj7X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C10C2BCAF;
	Thu, 16 Apr 2026 10:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776334622;
	bh=gN1BRrqXMRbChB0x61xF2kukdXPqZcRjnyQOsPmr+Ig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q/P1Rj7Xhn+MeFvOqiaea+KFyNLiW5Jtk1ZP6NYXn4xf+ym8ElOH5+PSbRx7SQ2z2
	 Bs0hNN5hx7KobjWMU55gxNqBupWDeZCevhVnqTi6zHEjrI0TsaXsB0KRi1o7Us9dY8
	 mn4Me+pQgA2Zah2uFPy/dXd0wN6yqsZxdaSjYNP8vns7Ev//7cFrJdLO6fQ+UMRJeF
	 q0wUVO/x0/Oq63r9X7lQ5FwkzGpNoVCRRb+P5q3Jf/TtSpwSB08iZcI6T4UxKd9ygG
	 7aRTsv8tmjz5dejw4Dnhh4UNSk/vrcOGzfcSrxh7+xpzRbJatl6pycbdGd+9r3smC/
	 swkxhxAUh6ppg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v8 2/8] tracing/fprobe: Unregister fprobe even if memory allocation fails
Date: Thu, 16 Apr 2026 19:16:59 +0900
Message-ID:  <177633461941.3479617.12152733686320498504.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
In-Reply-To:  <177633460058.3479617.11868368413034643565.stgit@mhiramat.tok.corp.google.com>
References:  <177633460058.3479617.11868368413034643565.stgit@mhiramat.tok.corp.google.com>
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

unregister_fprobe() can fail under memory pressure because of memory
allocation failure, but this maybe called from module unloading, and
usually there is no way to retry it. Moreover. trace_fprobe does not
check the return value.

To fix this problem, unregister fprobe and fprobe_hash_node even if
working memory allocation fails.
Anyway, if the last fprobe is removed, the filter will be freed.

Fixes: 4346ba160409 ("fprobe: Rewrite fprobe on function-graph tracer")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v7:
  - Newly added.
---
 kernel/trace/fprobe.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index fc7018b28fdd..d634eb8e8b9e 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -934,15 +934,19 @@ int unregister_fprobe(struct fprobe *fp)
 
 	hlist_array = fp->hlist_array;
 	addrs = kcalloc(hlist_array->size, sizeof(unsigned long), GFP_KERNEL);
-	if (!addrs) {
-		ret = -ENOMEM;	/* TODO: Fallback to one-by-one loop */
-		goto out;
-	}
+	/*
+	 * This will remove fprobe_hash_node from the hash table even if
+	 * memory allocation fails. However, ftrace_ops will not be updated.
+	 * Anyway, when the last fprobe is unregistered, ftrace_ops is also
+	 * unregistered.
+	 */
+	if (!addrs)
+		pr_warn("Failed to allocate working array. ftrace_ops may not sync.\n");
 
 	/* Remove non-synonim ips from table and hash */
 	count = 0;
 	for (i = 0; i < hlist_array->size; i++) {
-		if (!delete_fprobe_node(&hlist_array->array[i]))
+		if (!delete_fprobe_node(&hlist_array->array[i]) && addrs)
 			addrs[count++] = hlist_array->array[i].addr;
 	}
 	del_fprobe_hash(fp);

