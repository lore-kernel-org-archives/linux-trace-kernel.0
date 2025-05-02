Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A78926A09E;
	Fri,  2 May 2025 16:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746204611; cv=none; b=TSQxTLL604r2zC9TTqrnO5pUurPrM433x/0pR1bMX4Uq91huqOvbNTJ1ag8Q8c7oHvDe+Z4ZusJaD3axjPw5M9yP54xHppQuDqry3SjGK5LJZdriEuYFV493u9/OqoHHisKab+rdZeCmUegrAATEjG3c8fwV7lOLoXpC2mjNNA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746204611; c=relaxed/simple;
	bh=kJ1lRlKcjudXfNQvt0hTUNRiwuzXdk/8XeV3RVZQ1LI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=C2Wl6O1QZOpg5rpY52tRUirYE8KD/3gI64W5yPGCmfTf+/xnzNI3SyBE/4lSFNE9W/PIRb0/kJFuhaIjnEptMT9CIX7fGcVbW4695qb0C+OPQgIfTk6tXWzSVd3GxLKsu+rvhZb+nxeD4UYXln3rSt5G3BEbf5+v+WDsJRFKp3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06329C4CEE9;
	Fri,  2 May 2025 16:50:11 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uAtaU-0000000037m-1gOA;
	Fri, 02 May 2025 12:50:10 -0400
Message-ID: <20250502165010.249866358@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 02 May 2025 12:48:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 x86@kernel.org,
 Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v7 17/17] perf: Skip user unwind if the task is a kernel thread.
References: <20250502164746.178864972@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Josh Poimboeuf <jpoimboe@kernel.org>

If the task is not a user thread, there's no user stack to unwind.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/events/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7c7d5a27c568..02e52df7a02e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8101,7 +8101,8 @@ struct perf_callchain_entry *
 perf_callchain(struct perf_event *event, struct pt_regs *regs)
 {
 	bool kernel = !event->attr.exclude_callchain_kernel;
-	bool user   = !event->attr.exclude_callchain_user;
+	bool user   = !event->attr.exclude_callchain_user &&
+		!(current->flags & PF_KTHREAD);
 	/* Disallow cross-task user callchains. */
 	bool crosstask = event->ctx->task && event->ctx->task != current;
 	const u32 max_stack = event->attr.sample_max_stack;
-- 
2.47.2


