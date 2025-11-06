Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93AE335072;
	Thu,  6 Nov 2025 16:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762447939; cv=none; b=o9hZwXWDE6WldhoyaLMYyBbI5JnVkVQZYVosdP6Zx5tAPYSq4Ne3VUkTjZpGYpfPc8bONiu9G+RdC68xPgLWM6y6x+AEalkYegFPR7UnZUEHeKWcpwrsnAhCzc25fySN9rkr0IFzaVTz5sEcWR3maWUdMOoCYNxEcpWtuQxaHDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762447939; c=relaxed/simple;
	bh=472UOJKu5GXoPgemwYsZIiYyM1CqbpY9DUFA/iowFxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e91zdMpS9sbjOUbnyyaRjwHTEBoL53fI8mf0W9Xx1LbERevGhfLUI/FFzhPYuBBEM1h9KFY3tIzFJDIFvhnS7577Wt9V5HfYVBPdquj8UzCYAc+bmvwniELwghtdBV110D4KcAchzwYqKjPZ53ZjeGNvKPndbG5YqBdoXTBnVCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aACoxV1e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aACoxV1e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0340C4CEF7;
	Thu,  6 Nov 2025 16:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762447939;
	bh=472UOJKu5GXoPgemwYsZIiYyM1CqbpY9DUFA/iowFxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aACoxV1eEOq90/YUpnuAF5wAM8Ktvz7Ecfmrjb/xwcUnON1cxAVNKAOBQhNnFccfm
	 DD13bvf9ol8vSr2X8PD+w+HCYUGCL55kwa/yHqNB5VF2eyzlkH6Hby6kRd9a93Ied4
	 JAU52OHfOy9h4jkrH76r/q+gxhmLJFI4DoPosearywZQYS+9ICzfPGGWWTbBLp3NIZ
	 cHJBusaXa/Lw/PUlIulCGRA6lMQA9VPbYNUt5FdhdBmIqoaxzAPVzPMyv5x1v38+U2
	 P1U/9/6xZP/eW9xVV6fIaJ5fNn7aes0tTJycgKGz7QYSAqMdlRWD85KnSJa2BIlZwF
	 DNy/MUT/SQkKA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Beau Belgrave <beaub@linux.microsoft.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 1/2] tracing: tprobe-events: Fix to register tracepoint correctly
Date: Fri,  7 Nov 2025 01:52:15 +0900
Message-ID: <176244793514.155515.6466348656998627773.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <176244792552.155515.3285089581362758469.stgit@devnote2>
References: <176244792552.155515.3285089581362758469.stgit@devnote2>
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

Since __tracepoint_user_init() calls tracepoint_user_register() without
initializing tuser->tpoint with given tracpoint, it does not register
tracepoint stub function as callback correctly, and tprobe does not work.

Initializing tuser->tpoint correctly before tracepoint_user_register()
so that it sets up tracepoint callback.

I confirmed below example works fine again.

echo "t sched_switch preempt prev_pid=prev->pid next_pid=next->pid" > /sys/kernel/tracing/dynamic_events
echo 1 > /sys/kernel/tracing/events/tracepoints/sched_switch/enable
cat /sys/kernel/tracing/trace_pipe

Fixes: 2867495dea86 ("tracing: tprobe-events: Register tracepoint when enable tprobe event")
Reported-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_fprobe.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index b36ade43d4b3..d4e78d1ace12 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -106,13 +106,14 @@ static struct tracepoint_user *__tracepoint_user_init(const char *name, struct t
 	if (!tuser->name)
 		return NULL;
 
+	/* Register tracepoint if it is loaded. */
 	if (tpoint) {
+		tuser->tpoint = tpoint;
 		ret = tracepoint_user_register(tuser);
 		if (ret)
 			return ERR_PTR(ret);
 	}
 
-	tuser->tpoint = tpoint;
 	tuser->refcount = 1;
 	INIT_LIST_HEAD(&tuser->list);
 	list_add(&tuser->list, &tracepoint_user_list);

