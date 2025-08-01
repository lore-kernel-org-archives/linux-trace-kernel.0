Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B299B2472BD;
	Fri,  1 Aug 2025 14:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754058305; cv=none; b=lhDCXVU6qzAfAoAmsQQttLncPXkM2bC6uO0ZznZMgfj3WsyvM7oJ+p1+dpmAKOgyNhEUxX+AzgaTiMskk/T44EDk4PTf73XhRYeHZEUg+W/Z4B88G//EFyddShp7B0DJ2jWAxcuvMwlQ/VftPTT8+9OvqLrTfzktlnJdSj7XDmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754058305; c=relaxed/simple;
	bh=5vo5nx9SFtWUoShcEz3+vT4OCwsILlL6rhdrqsLDQ20=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=HUSvPLSXd45Fr4I7velo1petTkhCZQphLgvZqhaL1emkR5GGjbWw0vUQdJatR7hQLrWmFmWYSvj+tD4Z98CXnC7NvvrNlseW3pA8aNWQCTCnjSb11PxE0h+/L3Cpx3rYe6rxcMLOwkG0xrpOkfWNffT3s/i4699wSBZ8eYeUBZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IyPJspmt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IyPJspmt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC91C4CEF6;
	Fri,  1 Aug 2025 14:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754058305;
	bh=5vo5nx9SFtWUoShcEz3+vT4OCwsILlL6rhdrqsLDQ20=;
	h=Date:From:To:Cc:Subject:References:From;
	b=IyPJspmtwhAkCDnHkiVIijKdldIQJzDqp4wGNR5h4+YPEqc/Ggu582UPSkCO3Ys8Y
	 /18Nzbvloh07UPPMxK+Fo+dpC1uy+scwwAAUBFTPf3NRi8wwW+3eBwdey2pZXwNC2f
	 Aijd3RJJvLn7OaVmGH+uIJCNhb9/yVEduk0FknIqwTgJ4Te/4FxKxg5vD+QPr1N3AS
	 yjRJo5K4osEDZhdZjrSLfOpwGzTWvvfU8Rno+UK7jcPGwuw2oBY0bgkfEMN/bRnFTk
	 KAJz2ug6sEGYCWZN2NyWKBR98sCjj3c+5X7DIEEhRW9Vi07hCGLy5O7tRLMJ6Nxt5K
	 7xSv3Siiy7otw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uhqhK-00000007Uu7-1wTP;
	Fri, 01 Aug 2025 10:25:26 -0400
Message-ID: <20250801142526.312104819@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 01 Aug 2025 10:25:07 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/5] tracing: Remove unneeded goto out logic
References: <20250801142506.431659758@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Several places in the trace.c file there's a goto out where the out is
simply a return. There's no reason to jump to the out label if it's not
doing any more logic but simply returning from the function.

Replace the goto outs with a return and remove the out labels.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 38 +++++++++++++++-----------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 945a8ecf2c62..0ec9cab9a812 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1841,7 +1841,7 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 
 	ret = get_user(ch, ubuf++);
 	if (ret)
-		goto out;
+		return ret;
 
 	read++;
 	cnt--;
@@ -1855,7 +1855,7 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		while (cnt && isspace(ch)) {
 			ret = get_user(ch, ubuf++);
 			if (ret)
-				goto out;
+				return ret;
 			read++;
 			cnt--;
 		}
@@ -1865,8 +1865,7 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		/* only spaces were written */
 		if (isspace(ch) || !ch) {
 			*ppos += read;
-			ret = read;
-			goto out;
+			return read;
 		}
 	}
 
@@ -1874,13 +1873,12 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 	while (cnt && !isspace(ch) && ch) {
 		if (parser->idx < parser->size - 1)
 			parser->buffer[parser->idx++] = ch;
-		else {
-			ret = -EINVAL;
-			goto out;
-		}
+		else
+			return -EINVAL;
+
 		ret = get_user(ch, ubuf++);
 		if (ret)
-			goto out;
+			return ret;
 		read++;
 		cnt--;
 	}
@@ -1895,15 +1893,11 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		/* Make sure the parsed string always terminates with '\0'. */
 		parser->buffer[parser->idx] = 0;
 	} else {
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	*ppos += read;
-	ret = read;
-
-out:
-	return ret;
+	return read;
 }
 
 /* TODO add a seq_buf_to_buffer() */
@@ -2405,10 +2399,10 @@ int __init register_tracer(struct tracer *type)
 	mutex_unlock(&trace_types_lock);
 
 	if (ret || !default_bootup_tracer)
-		goto out_unlock;
+		return ret;
 
 	if (strncmp(default_bootup_tracer, type->name, MAX_TRACER_SIZE))
-		goto out_unlock;
+		return 0;
 
 	printk(KERN_INFO "Starting tracer '%s'\n", type->name);
 	/* Do we want this tracer to start on bootup? */
@@ -2420,8 +2414,7 @@ int __init register_tracer(struct tracer *type)
 	/* disable other selftests, since this will break it. */
 	disable_tracing_selftest("running a tracer");
 
- out_unlock:
-	return ret;
+	return 0;
 }
 
 static void tracing_reset_cpu(struct array_buffer *buf, int cpu)
@@ -8963,12 +8956,12 @@ ftrace_trace_snapshot_callback(struct trace_array *tr, struct ftrace_hash *hash,
  out_reg:
 	ret = tracing_arm_snapshot(tr);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	ret = register_ftrace_function_probe(glob, tr, ops, count);
 	if (ret < 0)
 		tracing_disarm_snapshot(tr);
- out:
+
 	return ret < 0 ? ret : 0;
 }
 
@@ -11070,7 +11063,7 @@ __init static int tracer_alloc_buffers(void)
 	BUILD_BUG_ON(TRACE_ITER_LAST_BIT > TRACE_FLAGS_MAX_SIZE);
 
 	if (!alloc_cpumask_var(&tracing_buffer_mask, GFP_KERNEL))
-		goto out;
+		return -ENOMEM;
 
 	if (!alloc_cpumask_var(&global_trace.tracing_cpumask, GFP_KERNEL))
 		goto out_free_buffer_mask;
@@ -11188,7 +11181,6 @@ __init static int tracer_alloc_buffers(void)
 	free_cpumask_var(global_trace.tracing_cpumask);
 out_free_buffer_mask:
 	free_cpumask_var(tracing_buffer_mask);
-out:
 	return ret;
 }
 
-- 
2.47.2


