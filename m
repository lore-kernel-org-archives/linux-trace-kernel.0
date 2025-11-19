Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8181DDC1B;
	Wed, 19 Nov 2025 00:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763511702; cv=none; b=I5hCaFwIXZu9CQ1TTr5hVG4vmea+XDu4RK5ZmPcxLT+JUWEYapTD9tu8uGhxFqSxAiI57oxKeaXoKUMsVX71jFcO4pjSH4YmAzqYMmlI4opgQMyQBiz0KMt7oPhJaWYc6xc3fVW2CGnLg8vVlHL+mAOTYUA2ghlq8o3sQt/kfgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763511702; c=relaxed/simple;
	bh=Xamqltl9I93urByq8l6HdNFbrifOItmvbJjAoJlor/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JddAxe0RJdbdXGx+UoR9WBO4w9vdXVGPC6IthCV8dwruzZ9uvMEXuuU4OHV3YoofzVIW2n/4c6dAQS9LNZa60H/uSwQz06MQFHNGy8QN+q4p3MhvIvD2QJgXzRMxcGmVts3iYINqUIZHeu9fBzJP7gAih/pY/zKIQMbc9zNyVFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7TofsGg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7TofsGg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4E8C4CEF5;
	Wed, 19 Nov 2025 00:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763511701;
	bh=Xamqltl9I93urByq8l6HdNFbrifOItmvbJjAoJlor/U=;
	h=From:To:Cc:Subject:Date:From;
	b=W7TofsGgOvMhtJID2EPIWaUqGN9FmDzAOr6LQqHoPu1Cksdp4wUsIPMLOubOO2kd+
	 FohTWK/674jhm0XX32oAfgwOO8P0lPSUkJrTxGLLlrQHAzHQ8lRvmQ0Yp6w0lXzElg
	 9GqpdLYkkx9FiR23TkA3lA1WDIXV/Md8cfVEDSQx7wpbXE5+JqeX/6ChVgArJ+aBG9
	 8jP+YcOMlnAFFldR65XhYTP31oZfeE31vYjEoW7wbZv7AFp8k8nwq6os416RgLFIIq
	 BeBjPc+yZzpgFqulPHjoaTIeBHFEtiKSVKFHMlRkE6SkBjreqYalZ1j7t9DTsoluGj
	 75DzBPjGkSP1w==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2] tracing: Show the tracer options in boot-time created instance
Date: Wed, 19 Nov 2025 09:21:34 +0900
Message-ID:  <176351169375.1795430.7653862896005389480.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
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

Since tracer_init_tracefs_work_func() only updates the tracer options
for the global_trace, the instances created by the kernel cmdline
do not have those options.

Fix to update tracer options for those boot-time created instances
to show those options.

Fixes: 428add559b69 ("tracing: Have tracer option be instance specific")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
  Change in v2:
   - Fix update_tracer_options() to update all instances.
   - Update tracer_options_updated after update all instances.
---
 kernel/trace/trace.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8ae95800592d..4a6784057855 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -10231,11 +10231,16 @@ static __init int __update_tracer_options(struct trace_array *tr)
 	return ret;
 }
 
-static __init void update_tracer_options(struct trace_array *tr)
+static __init void update_tracer_options(void)
 {
+	struct trace_array *tr;
+
 	guard(mutex)(&trace_types_lock);
+
+	list_for_each_entry(tr, &ftrace_trace_arrays, list)
+		__update_tracer_options(tr);
+
 	tracer_options_updated = true;
-	__update_tracer_options(tr);
 }
 
 /* Must have trace_types_lock held */
@@ -10937,7 +10942,7 @@ static __init void tracer_init_tracefs_work_func(struct work_struct *work)
 
 	create_trace_instances(NULL);
 
-	update_tracer_options(&global_trace);
+	update_tracer_options();
 }
 
 static __init int tracer_init_tracefs(void)

