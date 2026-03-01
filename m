Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451912517AF;
	Sun,  1 Mar 2026 01:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329634; cv=none; b=PvNzKr7c+nw2KtsjF8QbLAb+wMMQ/SYGv3yMTcoLOpePrpY9VVOgLh5rlcnmgTO1ph6P58AF6kaV+Fy9T+q1rGIrlFQz7CSEDZsaT24DaD8XpFfH4yalsVQc/gpEF7roWzYQ0Pk65qFr9PgKSPwhc908YuaLDfkG7aqWBvhEjzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329634; c=relaxed/simple;
	bh=aZ0xJ7vnl4FQmSrJ8wmABECLbXC2iOS4uKUFn87ny4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ALJUOnVwEIkeg5c4WOA1vwMAQUosZqlNt/nndQNFBb6iYzCR2fPylB2KyZpTOd1JZSUKttZaTGhO+FkBUsloCsuJITyI4ekffMXqLVW+R6agBcaGGy324Y++UNo10glF01OjbpQkdTrjX8LMdMBm4DitRd42SbS0XFUs6OhLCn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJfUGR5G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJfUGR5G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C7BC19421;
	Sun,  1 Mar 2026 01:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329634;
	bh=aZ0xJ7vnl4FQmSrJ8wmABECLbXC2iOS4uKUFn87ny4g=;
	h=From:To:Cc:Subject:Date:From;
	b=qJfUGR5GUV9dOwqJ/cEL9oKssq6M7Of37fyOJA4sVWAO3aiFN90N8SjX4yrhL8ix9
	 bJh/9nP3ju9buuBdYGSZOBkIS8GrZbEp+Udub6fzXLbh5aP7TCvJAa/6wB7derWXiV
	 s8/QZO6w9Hi0m3DpPtE00bILMvPyAIVGO+GKRKdboETfmvDIi3akse/cWjhpIfvBRz
	 ddsSuWjh531AB6wNEq1wgvXsk0BoPj5DyeKJ++8XFIjTZ1H2Rs4+IuoSnDKP3eTgns
	 avZci/GL+NsIqEjIixUYLi38bRmYOaazKYECMUN04C3T6S2DsKhKgp/iAZV6f8gm23
	 qdiJSz48+05HA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	mhiramat@kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Subject: FAILED: Patch "tracing: Fix to set write permission to per-cpu buffer_size_kb" failed to apply to 6.1-stable tree
Date: Sat, 28 Feb 2026 20:47:12 -0500
Message-ID: <20260301014712.1711100-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From f844282deed7481cf2f813933229261e27306551 Mon Sep 17 00:00:00 2001
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Date: Tue, 10 Feb 2026 17:43:36 +0900
Subject: [PATCH] tracing: Fix to set write permission to per-cpu
 buffer_size_kb

Since the per-cpu buffer_size_kb file is writable for changing
per-cpu ring buffer size, the file should have the write access
permission.

Cc: stable@vger.kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/177071301597.2293046.11683339475076917920.stgit@mhiramat.tok.corp.google.com
Fixes: 21ccc9cd7211 ("tracing: Disable "other" permission bits in the tracefs files")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 845b8a165daf3..fd470675809b3 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8613,7 +8613,7 @@ tracing_init_tracefs_percpu(struct trace_array *tr, long cpu)
 	trace_create_cpu_file("stats", TRACE_MODE_READ, d_cpu,
 				tr, cpu, &tracing_stats_fops);
 
-	trace_create_cpu_file("buffer_size_kb", TRACE_MODE_READ, d_cpu,
+	trace_create_cpu_file("buffer_size_kb", TRACE_MODE_WRITE, d_cpu,
 				tr, cpu, &tracing_entries_fops);
 
 	if (tr->range_addr_start)
-- 
2.51.0




