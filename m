Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD5A2D73B9;
	Sun,  1 Mar 2026 01:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329103; cv=none; b=lxgLrl7WS9CRrZxOcwFw+nA1MU4E2enoRuRx3bM3osJpG7P0efK/n+v7YX3vbgPinTZktpmV2DkO87X+a72NqIVLxNsBeFtfb4WXsA5dpHBU6lFv0pTlr/KvzorgOgB2wBtnG93ii7BU0lUQmmMHqsttYFqD9d+9y9OUADt9Bz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329103; c=relaxed/simple;
	bh=O/3DcdvvN7+KnCHbqZ3OAkyMMySeF3Ri6rNVMol3vvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QFuClWNMf6Em0YaSC8xtLrEDA3V0ePoQcJTKGeIBY2QIWU8QHHXmJ9h6OdXPhxJQp/86zeav9UZbd2/vj7Hti9NzLJENEMCKAbg+RcWty8NYNCh0+BO5VoK+vtgY0EaLsYYg9h1PUuYvarmXqCe4RU8iUmVyyUPG6xJsdd+/Beo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNbFDsEA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNbFDsEA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02845C19421;
	Sun,  1 Mar 2026 01:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329103;
	bh=O/3DcdvvN7+KnCHbqZ3OAkyMMySeF3Ri6rNVMol3vvQ=;
	h=From:To:Cc:Subject:Date:From;
	b=tNbFDsEAXekkV1kn1Qkf8IO1zK0iejiDV7DerAarcJ+rjNGMu+MEPnl7W0GQ2X9Vz
	 6TBfLbxIdHs8pQgd6XhR84yUlJNg1v5vjKYAFDEyYfG+IvPjjfRIBimLds+TRTY2jD
	 mMwfuyCTR8QIBkfS7k37I5srYyOAnfFjVj4Emvide4P19dlySUmP1WE0VMp2hppBDo
	 EJYvtnxeD0EZqsV+p7kGMHRHMq1UMi+NYaypmMzVceYRzH54hl8tDDSMrocFMwzeps
	 8UGMgJxetig5DUNOQSz1HnynK+DCT6JruvRyPmDbWM74EDyyIn/bviS2pjwFlPwjlr
	 91gnjoML0oREQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	mhiramat@kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Subject: FAILED: Patch "tracing: Fix to set write permission to per-cpu buffer_size_kb" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:38:21 -0500
Message-ID: <20260301013821.1698769-1-sashal@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
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




