Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F87014EC73;
	Wed, 25 Dec 2024 22:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735165715; cv=none; b=RGLtUlEPDZLZVYY/QxF99KesIE9n8tesYh0kXCHZHo35NlY4tNtd5ZpAL26Rms36ZYs/pykyE2c+LyhInPkDpcpmJO1FgHAO0X65Qj8UsOGISL4GPwIGRLKeDEqvKhmA1KlCGXL050Vup4L1N2Z0ZE6deWKsS9kgCUah/mlppM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735165715; c=relaxed/simple;
	bh=1oP38WsUfGdzdO3EGNMFrvWyXUISJYNjtJIXYLpH7Yw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=e52tfwYIFA4Ysngr4DAKxfxKXEx604ZhEbOWJcMph0REYoUJgfEUyajWwCDn+nXFiYoK+quqlW5NeVlGxU6WMwUeiy37bCJU6QnZpkIBD06us5XTrRjXZzBnvzmRP6DHNakYAEyq4gNtp6xEYeVhRGILhZFUmYtEH4liCygkBpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF6C2C4CED7;
	Wed, 25 Dec 2024 22:28:34 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tQZsh-0000000FS3G-3UKm;
	Wed, 25 Dec 2024 17:29:31 -0500
Message-ID: <20241225222931.684913592@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 25 Dec 2024 17:25:42 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 2/2] [PATCH] tracing: Switch trace_stack.c code over to use guard()
References: <20241225222540.685602520@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

The function stack_trace_sysctl() uses a goto on the error path to jump to
the mutex_unlock() code. Replace the logic to use guard() and let the
compiler worry about it.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/20241219201346.698598387@goodmis.org

- Removed fix to osnoise tracer that did not belong in this patch

 kernel/trace/trace_stack.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

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


