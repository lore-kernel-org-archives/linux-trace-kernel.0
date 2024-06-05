Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824D417555;
	Wed,  5 Jun 2024 18:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717610646; cv=none; b=TOLWk7UqK97BBtnwmVCTZ/tlhkMuinuQA0UHDdwNqNaSa0aTnroJnGxTv/MxY02dSytwvjL06kgslKyRx5ZHJiZs490HtNfjMjvSO3L6RsxlT0+vH/d6qke0j13CyuCdKFddzKsmGvRrCZAFxSWsQpwyMWQF92G0yBozvc9O/Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717610646; c=relaxed/simple;
	bh=cdBdOczOngRrZ9Kw7qfB8SrE8MYIlrw/6XETUzaMEo0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=aZ5fPoKMbrbFuiPd75OidvS5xFgH20AO5FqgstmEoYINLJR3rrcYrTPBCcZF/6DXmKUUJzME2QpYChTuVP5rcLiF1n4sxhjQ+Sai5vJqfbBbXRrm7gMv7kcJtQgipDqTjqE7ClSoJP7nJ68sR1vj8zc69YFH9jnKUVHgAkV6Cy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EDFEC4AF0B;
	Wed,  5 Jun 2024 18:04:06 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sEuzY-00000000hY0-4C34;
	Wed, 05 Jun 2024 14:04:09 -0400
Message-ID: <20240605180408.857333430@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 05 Jun 2024 14:03:37 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 3/5] ftrace: Add comments to ftrace_hash_rec_disable/enable()
References: <20240605180334.090848865@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Add comments to describe what the functions ftrace_hash_rec_disable() and
ftrace_hash_rec_enable() do. Also change the passing of the "inc" variable
to __ftrace_hash_rec_update() to a boolean value as that is what it is
supposed to take.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index f8d8de7adade..1a2444199740 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1862,14 +1862,24 @@ static bool __ftrace_hash_rec_update(struct ftrace_ops *ops,
 	return update;
 }
 
+/*
+ * This is called when an ops is removed from tracing. It will decrement
+ * the counters of the dyn_ftrace records for all the functions that
+ * the @ops attached to.
+ */
 static bool ftrace_hash_rec_disable(struct ftrace_ops *ops)
 {
-	return __ftrace_hash_rec_update(ops, 0);
+	return __ftrace_hash_rec_update(ops, false);
 }
 
+/*
+ * This is called when an ops is added to tracing. It will increment
+ * the counters of the dyn_ftrace records for all the functions that
+ * the @ops attached to.
+ */
 static bool ftrace_hash_rec_enable(struct ftrace_ops *ops)
 {
-	return __ftrace_hash_rec_update(ops, 1);
+	return __ftrace_hash_rec_update(ops, true);
 }
 
 static void ftrace_hash_rec_update_modify(struct ftrace_ops *ops, int inc)
-- 
2.43.0


