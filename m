Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54B52288CB;
	Wed, 15 Apr 2026 10:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776247733; cv=none; b=dIJI3e+acLxYa/WEv3iPVG/TSGf5Qix+mdbhB81V3Q9k9YxXKTr7/9m4GYv+wqVUCfxijDzr+O0yz9XsMUS6tDrSZ4gtDn8T8zFWJnWEcqURTPoUQVRp+3pppZh83HvF2CJdCM8sH8ZtexhN46fhCyYASWzZeW4+2cbjRWzYrVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776247733; c=relaxed/simple;
	bh=gN1BRrqXMRbChB0x61xF2kukdXPqZcRjnyQOsPmr+Ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OghIwFtaQKik+XRC9ZpFf7sOUc97+8ntJULaxKcUhEDwHsi8MpB0Bq4RzejfeRlw7kNvBIHwpGnvfydRPuYZ9r0Vgc5l9re+4ZQpl7rt3Dx+U1Z+Qz+c2dOQRbjybNK8e5ZznHFztAFrpoHWphUEJBntcARce8PzkV2ahxLbnaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPql3u9U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPql3u9U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FAF8C19424;
	Wed, 15 Apr 2026 10:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776247732;
	bh=gN1BRrqXMRbChB0x61xF2kukdXPqZcRjnyQOsPmr+Ig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oPql3u9UYGsOEhgsQcyl3pPSgsnSw4qLHQ3kp94Fq7YI2djUg6fVLMcDQQDHtH3wZ
	 qMYvJvyvFJLdIZeTDsLzEfvY8hMkGSKrBUutD/Ips3tbCpxognxYQPfQgvqDZUtUw9
	 +LpPw80kMaTUkSVnUmzL5JyDJTQy5p3OVz2h8i+2nEdSNKVQRvKGWbNP0CVcDEAkFK
	 rgUpNtHoHegetfwGj6TLDuHJ0iEdOMIYtEx4FYP1WTkI3Mndtos/8+SD7aIv1eCnwh
	 x4aLZsTEuo3x7GHa5Wa/D0g+zFlpheufj2AzNvcBiOQRjwFgEdw8y4EMn+DAuokIZq
	 OsEWXTNKMpKuw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v7 2/6] tracing/fprobe: Unregister fprobe even if memory allocation fails
Date: Wed, 15 Apr 2026 19:08:50 +0900
Message-ID:  <177624772989.2407691.17449580584634294999.stgit@mhiramat.tok.corp.google.com>
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

