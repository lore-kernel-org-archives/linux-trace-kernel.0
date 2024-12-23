Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBE7185924;
	Mon, 23 Dec 2024 18:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734979730; cv=none; b=WxILBwY9rB1c29prtgb8SFk8GXOrMTNDROV9u7jvqFDmgshOMj4n3VagQRQzbVEbbSSjTvcCFgWLG1IOX5+rBjVT9SBCkN4nY74sC0n1k1pVYmH/Vr7mfPAdCHU1qRcYDnPirYVU5Q76YYhcI/5yxTxK8V+QFAOAZt/x2QUPpnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734979730; c=relaxed/simple;
	bh=YR6klxmOahfJtSWPr/93KtC/U9V99pYu7l3PSjNL69A=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=svN/lknRaHocvs4qaJKgwrtAYfYtuX1J4hw4yLOiyk/r2OctCwlgKoInSAVIb9KHw1ATN9Ek5kAhZZfShoY2FOj992ryAh5nB8r8DMLCsaIzASVH1ZLa6WSzsIxnR058mn6qrucUDHAe86J+3+lg/pzhNHMNAozC6iIZdyaFEJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1EB1C4CED4;
	Mon, 23 Dec 2024 18:48:49 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tPnUr-0000000Dcmm-2CNu;
	Mon, 23 Dec 2024 13:49:41 -0500
Message-ID: <20241223184941.373853944@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 23 Dec 2024 13:46:20 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2/4] ftrace: Do not disable interrupts in profiler
References: <20241223184618.176607694@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The function profiler disables interrupts before processing. This was
there since the profiler was introduced back in 2009 when there were
recursion issues to deal with. The function tracer is much more robust
today and has its own internal recursion protection. There's no reason to
disable interrupts in the function profiler.

Instead, just disable preemption and use the guard() infrastructure while
at it.

Before this change:

~# echo 1 > /sys/kernel/tracing/function_profile_enabled
~# perf stat -r 10 ./hackbench 10
Time: 3.099
Time: 2.556
Time: 2.500
Time: 2.705
Time: 2.985
Time: 2.959
Time: 2.859
Time: 2.621
Time: 2.742
Time: 2.631

 Performance counter stats for '/work/c/hackbench 10' (10 runs):

         23,156.77 msec task-clock                       #    6.951 CPUs utilized               ( +-  2.36% )
            18,306      context-switches                 #  790.525 /sec                        ( +-  5.95% )
               495      cpu-migrations                   #   21.376 /sec                        ( +-  8.61% )
            11,522      page-faults                      #  497.565 /sec                        ( +-  1.80% )
    47,967,124,606      cycles                           #    2.071 GHz                         ( +-  0.41% )
    80,009,078,371      instructions                     #    1.67  insn per cycle              ( +-  0.34% )
    16,389,249,798      branches                         #  707.752 M/sec                       ( +-  0.36% )
       139,943,109      branch-misses                    #    0.85% of all branches             ( +-  0.61% )

             3.332 +- 0.101 seconds time elapsed  ( +-  3.04% )

After this change:

~# echo 1 > /sys/kernel/tracing/function_profile_enabled
~# perf stat -r 10 ./hackbench 10
Time: 1.869
Time: 1.428
Time: 1.575
Time: 1.569
Time: 1.685
Time: 1.511
Time: 1.611
Time: 1.672
Time: 1.724
Time: 1.715

 Performance counter stats for '/work/c/hackbench 10' (10 runs):

         13,578.21 msec task-clock                       #    6.931 CPUs utilized               ( +-  2.23% )
            12,736      context-switches                 #  937.973 /sec                        ( +-  3.86% )
               341      cpu-migrations                   #   25.114 /sec                        ( +-  5.27% )
            11,378      page-faults                      #  837.960 /sec                        ( +-  1.74% )
    27,638,039,036      cycles                           #    2.035 GHz                         ( +-  0.27% )
    45,107,762,498      instructions                     #    1.63  insn per cycle              ( +-  0.23% )
     8,623,868,018      branches                         #  635.125 M/sec                       ( +-  0.27% )
       125,738,443      branch-misses                    #    1.46% of all branches             ( +-  0.32% )

            1.9590 +- 0.0484 seconds time elapsed  ( +-  2.47% )

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 9b17efb1a87d..63a9ffa65e17 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -789,27 +789,24 @@ function_profile_call(unsigned long ip, unsigned long parent_ip,
 {
 	struct ftrace_profile_stat *stat;
 	struct ftrace_profile *rec;
-	unsigned long flags;
 
 	if (!ftrace_profile_enabled)
 		return;
 
-	local_irq_save(flags);
+	guard(preempt_notrace)();
 
 	stat = this_cpu_ptr(&ftrace_profile_stats);
 	if (!stat->hash || !ftrace_profile_enabled)
-		goto out;
+		return;
 
 	rec = ftrace_find_profiled_func(stat, ip);
 	if (!rec) {
 		rec = ftrace_profile_alloc(stat, ip);
 		if (!rec)
-			goto out;
+			return;
 	}
 
 	rec->counter++;
- out:
-	local_irq_restore(flags);
 }
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
@@ -856,19 +853,19 @@ static void profile_graph_return(struct ftrace_graph_ret *trace,
 	unsigned long long calltime;
 	unsigned long long rettime = trace_clock_local();
 	struct ftrace_profile *rec;
-	unsigned long flags;
 	int size;
 
-	local_irq_save(flags);
+	guard(preempt_notrace)();
+
 	stat = this_cpu_ptr(&ftrace_profile_stats);
 	if (!stat->hash || !ftrace_profile_enabled)
-		goto out;
+		return;
 
 	profile_data = fgraph_retrieve_data(gops->idx, &size);
 
 	/* If the calltime was zero'd ignore it */
 	if (!profile_data || !profile_data->calltime)
-		goto out;
+		return;
 
 	calltime = rettime - profile_data->calltime;
 
@@ -896,9 +893,6 @@ static void profile_graph_return(struct ftrace_graph_ret *trace,
 		rec->time += calltime;
 		rec->time_squared += calltime * calltime;
 	}
-
- out:
-	local_irq_restore(flags);
 }
 
 static struct fgraph_ops fprofiler_ops = {
-- 
2.45.2


