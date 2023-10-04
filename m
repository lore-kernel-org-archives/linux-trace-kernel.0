Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37931FD9
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Oct 2023 08:34:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018C5C433C8;
	Wed,  4 Oct 2023 08:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696408478;
	bh=MS6eVdU/ecL57/ElNUj1x5YXHRLiQNWPGabx9+f+Ksk=;
	h=From:To:Cc:Subject:Date:From;
	b=ImT0ZF/w6Vu7BVGrLdeMj7FeACfBWlEEc+wyyTgeP2pLRa24N8nyEtQ3DWJiDN35e
	 EV+2hZlKkxlNUz+gcHRwTaqFAW8dtUQ0uVYNN1bzKlHgwpHiy0S2EpW2YQKUWvvTzW
	 pnSnu9TwDF8nZWq69IHBRan2SWfm9WGx6F0dEB0cAunUqI0RFZWVWO5ItuL1ACrNXn
	 9wnlLxh6xZlQfUjyXf6lieKxLnQm6zZmcUaW+JLO3K8pWkzu9M96OzhpkYGgv/tL4y
	 RJyyrwzTcnkiwaRvG6Ccl4YyL2aArjXI341WuJ1MD3sdccsAF0uk5hmjNAskYedRsz
	 ajWLlwlFA/5hQ==
From: Daniel Bristot de Oliveira <bristot@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>,
	Xie XiuQi <xiexiuqi@huawei.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [GIT PULL] rtla: Fixes for 6.6
Date: Wed,  4 Oct 2023 10:34:28 +0200
Message-ID: <20231004083428.51747-1-bristot@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Steven,

Timerlat auto-analysis:

  - Timerlat is reporting thread interference time without thread noise
    events occurrence. It was caused because the thread interference variable
    was not reset after the analysis of a timerlat activation that did not
    hit the threshold.

  - The IRQ handler delay is estimated from the delta of the IRQ latency
    reported by timerlat, and the timestamp from IRQ handler start event.
    If the delta is near-zero, the drift from the external clock and the
    trace event and/or the overhead can cause the value to be negative.
    If the value is negative, print a zero-delay.

  - IRQ handlers happening after the timerlat thread event but before
    the stop tracing were being reported as IRQ that happened before the
    *current* IRQ occurrence. Ignore Previous IRQ noise in this condition
    because they are valid only for the *next* timerlat activation.

Timerlat user-space:

  - Timerlat is stopping all user-space thread if a CPU becomes
    offline. Do not stop the entire tool if a CPU is/become offline,
    but only the thread of the unavailable CPU. Stop the tool only,
    if all threads leave because the CPUs become/are offline.

man-pages:

  - Fix command line example in timerlat hist man page.


Please pull the latest rtla-v6.6-fixes tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/bristot/linux.git
rtla-v6.6-fixes

Tag SHA1: 6a0df51b5c0a075a553a5ad73b1fd421f559eb6b
Head SHA1: 81ec384b80ffbda752c230778d39ea620c7e3bcf


Daniel Bristot de Oliveira (4):
      rtla/timerlat_aa: Zero thread sum after every sample analysis
      rtla/timerlat_aa: Fix negative IRQ delay
      rtla/timerlat_aa: Fix previous IRQ delay for IRQs that happens after thread sample
      rtla/timerlat: Do not stop user-space if a cpu is offline

Xie XiuQi (1):
      rtla: fix a example in rtla-timerlat-hist.rst

----
 Documentation/tools/rtla/rtla-timerlat-hist.rst |  4 ++--
 tools/tracing/rtla/src/timerlat_aa.c            | 32 ++++++++++++++++++++-----
 tools/tracing/rtla/src/timerlat_u.c             |  6 +++--
 3 files changed, 32 insertions(+), 10 deletions(-)
---------------------------
diff --git a/Documentation/tools/rtla/rtla-timerlat-hist.rst b/Documentation/tools/rtla/rtla-timerlat-hist.rst
index 057db78d4095..03b7f3deb069 100644
--- a/Documentation/tools/rtla/rtla-timerlat-hist.rst
+++ b/Documentation/tools/rtla/rtla-timerlat-hist.rst
@@ -36,11 +36,11 @@ EXAMPLE
 In the example below, **rtla timerlat hist** is set to run for *10* minutes,
 in the cpus *0-4*, *skipping zero* only lines. Moreover, **rtla timerlat
 hist** will change the priority of the *timerlat* threads to run under
-*SCHED_DEADLINE* priority, with a *10us* runtime every *1ms* period. The
+*SCHED_DEADLINE* priority, with a *100us* runtime every *1ms* period. The
 *1ms* period is also passed to the *timerlat* tracer. Auto-analysis is disabled
 to reduce overhead ::
 
-  [root@alien ~]# timerlat hist -d 10m -c 0-4 -P d:100us:1ms -p 1ms --no-aa
+  [root@alien ~]# timerlat hist -d 10m -c 0-4 -P d:100us:1ms -p 1000 --no-aa
   # RTLA timerlat histogram
   # Time unit is microseconds (us)
   # Duration:   0 00:10:00
diff --git a/tools/tracing/rtla/src/timerlat_aa.c b/tools/tracing/rtla/src/timerlat_aa.c
index e0ffe69c271c..7093fd5333be 100644
--- a/tools/tracing/rtla/src/timerlat_aa.c
+++ b/tools/tracing/rtla/src/timerlat_aa.c
@@ -159,6 +159,7 @@ static int timerlat_aa_irq_latency(struct timerlat_aa_data *taa_data,
 	taa_data->thread_nmi_sum = 0;
 	taa_data->thread_irq_sum = 0;
 	taa_data->thread_softirq_sum = 0;
+	taa_data->thread_thread_sum = 0;
 	taa_data->thread_blocking_duration = 0;
 	taa_data->timer_irq_start_time = 0;
 	taa_data->timer_irq_duration = 0;
@@ -337,7 +338,23 @@ static int timerlat_aa_irq_handler(struct trace_seq *s, struct tep_record *recor
 		taa_data->timer_irq_start_time = start;
 		taa_data->timer_irq_duration = duration;
 
-		taa_data->timer_irq_start_delay = taa_data->timer_irq_start_time - expected_start;
+		/*
+		 * We are dealing with two different clock sources: the
+		 * external clock source that timerlat uses as a reference
+		 * and the clock used by the tracer. There are also two
+		 * moments: the time reading the clock and the timer in
+		 * which the event is placed in the buffer (the trace
+		 * event timestamp). If the processor is slow or there
+		 * is some hardware noise, the difference between the
+		 * timestamp and the external clock read can be longer
+		 * than the IRQ handler delay, resulting in a negative
+		 * time. If so, set IRQ start delay as 0. In the end,
+		 * it is less relevant than the noise.
+		 */
+		if (expected_start < taa_data->timer_irq_start_time)
+			taa_data->timer_irq_start_delay = taa_data->timer_irq_start_time - expected_start;
+		else
+			taa_data->timer_irq_start_delay = 0;
 
 		/*
 		 * not exit from idle.
@@ -528,7 +545,7 @@ static int timerlat_aa_kworker_start_handler(struct trace_seq *s, struct tep_rec
 static void timerlat_thread_analysis(struct timerlat_aa_data *taa_data, int cpu,
 				     int irq_thresh, int thread_thresh)
 {
-	unsigned long long exp_irq_ts;
+	long long exp_irq_ts;
 	int total;
 	int irq;
 
@@ -545,12 +562,15 @@ static void timerlat_thread_analysis(struct timerlat_aa_data *taa_data, int cpu,
 
 	/*
 	 * Expected IRQ arrival time using the trace clock as the base.
+	 *
+	 * TODO: Add a list of previous IRQ, and then run the list backwards.
 	 */
 	exp_irq_ts = taa_data->timer_irq_start_time - taa_data->timer_irq_start_delay;
-
-	if (exp_irq_ts < taa_data->prev_irq_timstamp + taa_data->prev_irq_duration)
-		printf("  Previous IRQ interference:	\t\t up to  %9.2f us\n",
-			ns_to_usf(taa_data->prev_irq_duration));
+	if (exp_irq_ts < taa_data->prev_irq_timstamp + taa_data->prev_irq_duration) {
+		if (taa_data->prev_irq_timstamp < taa_data->timer_irq_start_time)
+			printf("  Previous IRQ interference:	\t\t up to  %9.2f us\n",
+				ns_to_usf(taa_data->prev_irq_duration));
+	}
 
 	/*
 	 * The delay that the IRQ suffered before starting.
diff --git a/tools/tracing/rtla/src/timerlat_u.c b/tools/tracing/rtla/src/timerlat_u.c
index 05e310696dd5..01dbf9a6b5a5 100644
--- a/tools/tracing/rtla/src/timerlat_u.c
+++ b/tools/tracing/rtla/src/timerlat_u.c
@@ -45,7 +45,7 @@ static int timerlat_u_main(int cpu, struct timerlat_u_params *params)
 
 	retval = sched_setaffinity(gettid(), sizeof(set), &set);
 	if (retval == -1) {
-		err_msg("Error setting user thread affinity\n");
+		debug_msg("Error setting user thread affinity %d, is the CPU online?\n", cpu);
 		exit(1);
 	}
 
@@ -193,7 +193,9 @@ void *timerlat_u_dispatcher(void *data)
 					procs_count--;
 				}
 			}
-			break;
+
+			if (!procs_count)
+				break;
 		}
 
 		sleep(1);
