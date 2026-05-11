Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF62D3242B2;
	Mon, 11 May 2026 10:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778493836; cv=none; b=AX7tTLX3VeVsD7mNwy5Wvhhro0sXzcXdlMxxmpINPwY1fbw9Vo0NhSwFIrF1Ud4ZcjAxIrT/tKEbMaJ6grWQZl2wwPtDGF/onJGfFJG6zIVkMHPEKuyRwRrHFb8xql/790sUQs0PdsqspgT3EXUfJXkT6An/f7jkkWYSjessFe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778493836; c=relaxed/simple;
	bh=XmvQcE042Vhn0lpzYlIh9f2Zy0a0UeeqjxWYlJC+skM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZiNKApnNCcExgSZaCn0ikFanSPdzH4hRYMQc0kvRBa9Ja1F1cccfMFMhmp660Qc+58lA7eBH2t4YkyWxQdYot/fghgasUr/8UMbOlS8q8/mMGcOv2jBkLy7FVtE04ucQLJZxJNyLANcKjkoY2lZZNF0PJFBsbdkfJi0ICUD8vrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0t5PrkP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0t5PrkP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A6D1C2BCB0;
	Mon, 11 May 2026 10:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778493835;
	bh=XmvQcE042Vhn0lpzYlIh9f2Zy0a0UeeqjxWYlJC+skM=;
	h=From:To:Cc:Subject:Date:From;
	b=T0t5PrkPVIlGBuNL++lSkza+N5BgGVPB9lTG3PLEiudYr1W1M1MpRfxuPwEkNHCC/
	 qPnQ10vg3oPi/Ta4kEWxjfwLWKTo/RoyLyFOFs5D0EazvC0neJBA1hNimCOMlYeUG/
	 Gn2Z0Wnlh9sj/+LG+wWsFyUL92nyBQI5aaELt2uskg+iPYm8ntfI5aXPHN40Jr/QU7
	 RKeH9s/pFQjPlFIrDoF9Ob8JMTHpcbqpi7qRg1D5hKiSbMcaV4KGCKPugDJ9jCSSqW
	 plhE+3k1X14nMqhRIs1Mqq35jjXFHZcV2DivtiXT1YQDjjZgVJFajCEsMjkpF+Ke2T
	 /ZMwus9j7cH/Q==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing/probes: Ensure the uprobe buffer size is bigger than event size
Date: Mon, 11 May 2026 19:03:52 +0900
Message-ID: <177849383209.8038.1902170479780501237.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
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

Add BUILD_BUG_ON() to ensure the uprobe per-CPU working buffer
size is bigger than the event size.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_uprobe.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 2cabf8a23ec5..c5ee7920dec6 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -979,6 +979,7 @@ static struct uprobe_cpu_buffer *prepare_uprobe_buffer(struct trace_uprobe *tu,
 	ucb = uprobe_buffer_get();
 	ucb->dsize = tu->tp.size + dsize;
 
+	BUILD_BUG_ON(MAX_UCB_BUFFER_SIZE < MAX_PROBE_EVENT_SIZE);
 	if (WARN_ON_ONCE(ucb->dsize > MAX_UCB_BUFFER_SIZE)) {
 		ucb->dsize = MAX_UCB_BUFFER_SIZE;
 		dsize = MAX_UCB_BUFFER_SIZE - tu->tp.size;

