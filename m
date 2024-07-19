Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528EF13CA9C;
	Fri, 19 Jul 2024 14:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721398395; cv=none; b=hmESbePa4HkfFh3hRQ6ec2GykL0/2+jzxwSvmb1l0BP2WfGWy/qXEmnFeH69mKfqD/Qu+X693SsnIaPHANCP5rEvZtvZRQpThivcUxN4lyD8AenAsb9zrr8vCNfxraLV6TprdD3HaasV9Y9M3WL+qaRp7WCZYwObQpTTkyTJQUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721398395; c=relaxed/simple;
	bh=Fm5FwjE1IPVyXARPFsWdl0vxOF7VJrQHAAYiRzKjx20=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=HmJelYSaW0VgcNlTICtbkbLlkUpwNbRT29m4QgA10vFEIX0+FD2Bj5eTEv7+ziCtPWjTeGNHtPRI4M2kdvR5MPaszT4VV7modS+vf4WiYjIpjET5z9cKtutrLWBpd2OYZeavy0B61fJM5uGKOFG+XGautlejAavsd+rVhkYd8D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D28C32782;
	Fri, 19 Jul 2024 14:13:13 +0000 (UTC)
Date: Fri, 19 Jul 2024 10:13:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH] tracing: Fix ifdef of snapshots to not prevent
 last_boot_info file
Message-ID: <20240719101312.3d4ac707@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

The mapping of the ring buffer to memory allocated at boot up will also
expose a "last_boot_info" to help tooling to read the raw data from the
last boot. As instances that have their ring buffer mapped to fixed
memory cannot perform snapshots, they can either have the "snapshot" file
or the "last_boot_info" file, but not both.

The code that added the "last_boot_info" file failed to notice that the
"snapshot" creation was inside a "#ifdef CONFIG_TRACER_SNAPSHOT" and
incorrectly placed the creation of the "last_boot_info" file within the
ifdef block. Not only does it cause a warning when CONFIG_TRACER_SNAPSHOT
is not enabled, it also incorrectly prevents the file from appearing.

Link: https://lore.kernel.org/all/20240719102640.718554-1-arnd@kernel.org/

Reported-by: Arnd Bergmann <arnd@kernel.org>
Fixes: 7a1d1e4b9639 ("tracing/ring-buffer: Add last_boot_info file to boot instance")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 5462fb10ff64..0d1841b3363e 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9828,15 +9828,15 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 	if (ftrace_create_function_files(tr, d_tracer))
 		MEM_FAIL(1, "Could not allocate function filter files");
 
-#ifdef CONFIG_TRACER_SNAPSHOT
 	if (tr->range_addr_start) {
 		trace_create_file("last_boot_info", TRACE_MODE_READ, d_tracer,
 				  tr, &last_boot_fops);
+#ifdef CONFIG_TRACER_SNAPSHOT
 	} else {
 		trace_create_file("snapshot", TRACE_MODE_WRITE, d_tracer,
 				  tr, &snapshot_fops);
-	}
 #endif
+	}
 
 	trace_create_file("error_log", TRACE_MODE_WRITE, d_tracer,
 			  tr, &tracing_err_log_fops);
-- 
2.43.0

