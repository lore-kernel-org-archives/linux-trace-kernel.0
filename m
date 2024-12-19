Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2601D1724;
	Thu, 19 Dec 2024 20:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734639185; cv=none; b=oW/pSYRkSqR3LsACCfZoORu9mt/iNJZqjzJai98IxRoHVJCEPyQvvBxJWHbUAn0ycRQ0NsQn85hm8B88lEAdKK0PR3hVMpnb0WBCC3AVEi2o2vq6Krau8B/4Md3mLGBX7q3CfyStypvf8aopbwPQw6jC/QgvT9eIce2hGhjNbjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734639185; c=relaxed/simple;
	bh=mLbIMqzsYRPegXerOyfPjieV7rPOQUb8hQN+DoVBMgM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=VVJOdPwzFWXMlWSySLUxkRmCHu0cTZdk5w0JCcAQdIlcRxYGUp7ZZzhdNnHAiafCjP9X5GRhf21+eKmhiaCdg68xUJ92rwIzDdCQWZpq2pPP8cYWLGMh5AhF/2JW/t4qAIt36pgKjyibRWKfnPT5lKySrOFMZc8WBmDIyPDp3k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 207DCC4CEE2;
	Thu, 19 Dec 2024 20:13:05 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tOMu2-0000000AOMy-3You;
	Thu, 19 Dec 2024 15:13:46 -0500
Message-ID: <20241219201346.698598387@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 19 Dec 2024 15:12:11 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 13/14] tracing: Switch trace_stack.c code over to use guard()
References: <20241219201158.193821672@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The function stack_trace_sysctl() uses a goto on the error path to jump to
the mutex_unlock() code. Replace the logic to use guard() and let the
compiler worry about it.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_osnoise.c | 2 +-
 kernel/trace/trace_stack.c   | 6 ++----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index b8626892c66d..b25c30b05dd0 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2086,7 +2086,7 @@ static void osnoise_hotplug_workfn(struct work_struct *dummy)
 	guard(mutex)(&trace_types_lock);
 
 	if (!osnoise_has_registered_instances())
-		goto out_unlock_trace;
+		return;
 
 	guard(mutex)(&interface_lock);
 	guard(cpus_read_lock)();
diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index 7f9572a37333..14c6f272c4d8 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -520,20 +520,18 @@ stack_trace_sysctl(const struct ctl_table *table, int write, void *buffer,
 	int was_enabled;
 	int ret;
 
-	mutex_lock(&stack_sysctl_mutex);
+	guard(mutex)(&stack_sysctl_mutex);
 	was_enabled = !!stack_tracer_enabled;
 
 	ret = proc_dointvec(table, write, buffer, lenp, ppos);
 
 	if (ret || !write || (was_enabled == !!stack_tracer_enabled))
-		goto out;
+		return ret;
 
 	if (stack_tracer_enabled)
 		register_ftrace_function(&trace_ops);
 	else
 		unregister_ftrace_function(&trace_ops);
- out:
-	mutex_unlock(&stack_sysctl_mutex);
 	return ret;
 }
 
-- 
2.45.2


