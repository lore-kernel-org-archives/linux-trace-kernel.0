Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F241D529;
	Thu,  5 Sep 2024 15:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725550378; cv=none; b=CYhevXBgb1Zr/Js1jGnuQWWwsGSnNzLaWQ3KOM1tSm0p9I98tuwj+w/1kET7Wnw4wM3djrn41fwSTJ55G1K6V25GM+ZINYTcJ3gypLR/vKQ+f8Pq5LB34abJWBhmjpM6SWDw1og+7VNysc2zWNOMG2NGNM5v7S2u9S4AritwVr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725550378; c=relaxed/simple;
	bh=xD7MNg+tgLlZMUiUnfeZq+0qhrLx2Q27iIlkruJ7OtM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Grdb3Rcwv6kQPINopgTbACqwkdmvKNPBPO4mthufl3NeQkGN4oN7SqSLvcT7mra3NZqpLCCOhOzupIZc8WUdICT221rr2Exa8yJ0jEy/8i1bbE8U2hFZrsUwcc41veSAmWqCfehY8CRxQHeCguUDIY6IJpn8K6ZFHQH69OkOEe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA42C4CEC5;
	Thu,  5 Sep 2024 15:32:57 +0000 (UTC)
Date: Thu, 5 Sep 2024 11:33:59 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Tomas Glozar <tglozar@redhat.com>, John
 Kacur <jkacur@redhat.com>, "Luis Claudio R. Goncalves"
 <lgoncalv@redhat.com>
Subject: [PATCH] tracing/timerlat: Add interface_lock around clearing of
 kthread in stop_kthread()
Message-ID: <20240905113359.2b934242@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

The timerlat interface will get and put the task that is part of the
"kthread" field of the osn_var to keep it around until all references are
released. But here's a race in the "stop_kthread()" code that will call
put_task_struct() on the kthread if it is not a kernel thread. This can
race with the releasing of the references to that task struct and the
put_task_struct() can be called twice when it should have been called just
once.

Take the interface_lock() in stop_kthread() to synchronize this change.
But to do so, the function stop_per_cpu_kthreads() needs to change the
loop from for_each_online_cpu() to for_each_possible_cpu() and remove the
cpu_read_lock(), as the interface_lock can not be taken while the cpu
locks are held. The only side effect of this change is that it may do some
extra work, as the per_cpu variables of the offline CPUs would not be set
anyway, and would simply be skipped in the loop.

Remove unneeded "return;" in stop_kthread().

Cc: stable@vger.kernel.org
Fixes: e88ed227f639e ("tracing/timerlat: Add user-space interface")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_osnoise.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 48e5014dd4ab..bbe47781617e 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1953,8 +1953,12 @@ static void stop_kthread(unsigned int cpu)
 {
 	struct task_struct *kthread;
 
+	mutex_lock(&interface_lock);
 	kthread = per_cpu(per_cpu_osnoise_var, cpu).kthread;
 	if (kthread) {
+		per_cpu(per_cpu_osnoise_var, cpu).kthread = NULL;
+		mutex_unlock(&interface_lock);
+
 		if (cpumask_test_and_clear_cpu(cpu, &kthread_cpumask) &&
 		    !WARN_ON(!test_bit(OSN_WORKLOAD, &osnoise_options))) {
 			kthread_stop(kthread);
@@ -1967,8 +1971,8 @@ static void stop_kthread(unsigned int cpu)
 			kill_pid(kthread->thread_pid, SIGKILL, 1);
 			put_task_struct(kthread);
 		}
-		per_cpu(per_cpu_osnoise_var, cpu).kthread = NULL;
 	} else {
+		mutex_unlock(&interface_lock);
 		/* if no workload, just return */
 		if (!test_bit(OSN_WORKLOAD, &osnoise_options)) {
 			/*
@@ -1976,7 +1980,6 @@ static void stop_kthread(unsigned int cpu)
 			 */
 			per_cpu(per_cpu_osnoise_var, cpu).sampling = false;
 			barrier();
-			return;
 		}
 	}
 }
@@ -1991,12 +1994,8 @@ static void stop_per_cpu_kthreads(void)
 {
 	int cpu;
 
-	cpus_read_lock();
-
-	for_each_online_cpu(cpu)
+	for_each_possible_cpu(cpu)
 		stop_kthread(cpu);
-
-	cpus_read_unlock();
 }
 
 /*
-- 
2.43.0

