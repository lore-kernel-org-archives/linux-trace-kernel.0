Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9D11FFC67;
	Fri,  2 May 2025 20:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746219229; cv=none; b=E+1iY37GiwXR3fFMTFnxIrFttxtW68lz8dUjYw3CteSagEFJPUhQrRvXq06DB5iW61DxfsjAXz6X89q7TMxhGe5VbNTr3mCvqE5BOIj8JLJqf/UKUvRvQuQf6R2arJy5Dxu9AIG0AbkdPg42CLrQfCx+jzXKocIRIeKwUtEC+Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746219229; c=relaxed/simple;
	bh=RD0ncGsvrCJ0pZLeWa6ErfBpjmRnol++5MfNHvNqgks=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Uaov5Rkz7nJkt6v2AavEDVLhYUtuvPGTtJgllZE+mhCbDeLD5YFYuTh12wh7onkn2UPveFVmFUgkBET+NA0y9DpIj85gU2S3EvnL9+9QfvKFQYi6rizsvTtVudeL079l71xecDLABFDojk/m4ZiPs0EEdSggDoJDBl7ADsHJX+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D19CAC4CEED;
	Fri,  2 May 2025 20:53:48 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uAxOG-000000006B6-2bsw;
	Fri, 02 May 2025 16:53:48 -0400
Message-ID: <20250502205348.472044554@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 02 May 2025 16:51:51 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 04/12] tracing: Just use this_cpu_read() to access ignore_pid
References: <20250502205147.283272733@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The ignore_pid boolean on the per CPU data descriptor is updated at
sched_switch when a new task is scheduled in. If the new task is to be
ignored, it is set to true, otherwise it is set to false. The current task
should always have the correct value as it is updated when the task is
scheduled in.

Instead of breaking up the read of this value, which requires preemption
to be disabled, just use this_cpu_read() which gives a snapshot of the
value. Since the value will always be correct for a given task (because
it's updated at sched switch) it doesn't need preemption disabled.

This will also allow trace events to be called with preemption enabled.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 069e92856bda..fe0ea14d809e 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -622,7 +622,6 @@ EXPORT_SYMBOL_GPL(trace_event_raw_init);
 bool trace_event_ignore_this_pid(struct trace_event_file *trace_file)
 {
 	struct trace_array *tr = trace_file->tr;
-	struct trace_array_cpu *data;
 	struct trace_pid_list *no_pid_list;
 	struct trace_pid_list *pid_list;
 
@@ -632,9 +631,11 @@ bool trace_event_ignore_this_pid(struct trace_event_file *trace_file)
 	if (!pid_list && !no_pid_list)
 		return false;
 
-	data = this_cpu_ptr(tr->array_buffer.data);
-
-	return data->ignore_pid;
+	/*
+	 * This is recorded at every sched_switch for this task.
+	 * Thus, even if the task migrates the ignore value will be the same.
+	 */
+	return this_cpu_read(tr->array_buffer.data->ignore_pid) != 0;
 }
 EXPORT_SYMBOL_GPL(trace_event_ignore_this_pid);
 
-- 
2.47.2


