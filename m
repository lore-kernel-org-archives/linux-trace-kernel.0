Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292DE1FA267;
	Wed, 19 Feb 2025 18:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739989265; cv=none; b=Mhily7fqJKT5B333tjcPjS/Sr1MygbA27hDGdcNUAqFNtFUTSaiOdEg9OIoo+Y6GpzTOl+MpSbCykTGwM8gcbmTs2HIkI5RHWSQCFbWgj65j0noI7or4/d2V/0Um/brXLqixR/831+kC8hJgkk54WlytH4R0J2tL4hoe1cMZZe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739989265; c=relaxed/simple;
	bh=whdSPqxI3W/5RHd9dMin6POSlQqx2HO+bqyNRvPLY78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pdbqM4MSDavZzMBh6scdEt5/eVtVhz8HJLbj4mUobkqP3Pr965VysksL7b/HZfryx/bDG3z0CtBh6/zlZn66/bYsXzq6PMOHO98U/yzrDiT9WUe3uD68GRoI05lgHYDAHKWwPkO8yq2jUX90jrP1GhNLlwsqqOBpQ20VzY7bD60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtaOhjXk; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtaOhjXk"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-220e83d65e5so425885ad.1;
        Wed, 19 Feb 2025 10:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739989261; x=1740594061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4aJ64amYBvA7xcig3pdWnxDJf9R5zGOuhx8YpHkzkEY=;
        b=GtaOhjXknenTzSLlbUC8t0pYzywDHth1ZNC+sOYsNHqY0e/rbIxggKOV+xQIOSwO+n
         6P2ROxy/leLNIliGXNW5TF458obI7oqWWX/Ak/uNTUGg+KFMr4xV1r/XwI+NpDIX6I8I
         2FBbIhz5AbH6PylLgpqTLUmjLK5RciVpvgMZLiagGuUB9h7e1o/OtpQ5jSekz2Yn9DTK
         4gIqaKqCxuo0tBQkbVyz3EuqtSbTb/Ep8koyktGflAqw7ZtIl/mLBUiFKWI85VWMavMs
         2Lln9WDbYrIhETxNyS+WKratDTy8vUjWA2JXe20NA72ZL5iVHao7KT9D3PdlvK7GNfBe
         T1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739989261; x=1740594061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4aJ64amYBvA7xcig3pdWnxDJf9R5zGOuhx8YpHkzkEY=;
        b=JoFEaFud+RRJh0S8t4hl5tI0VUWsdbMf5R6bre8oDRbSD/5uRWVT08lZ0ZGco0etWr
         /eRQjvJKQM9myJ+3TrvwtsrRlu/oV//miOnqIUPDMv63tohVA2dPlJAKL6HKl+16VOTt
         vBfw6XRS4ug8UDkxvM6uwcSrFy6DNi5gE3zkjjgU/q58UIkbPq4dZMQvewB3wiIQ/rFu
         l1sSJ7csH8O/dBhTnLRTrHepQobvoQnwOXZ1d9+1puyrGbfKh4/AzVJVrD29iO8yxX34
         YcpaPiWofOgqvIukSen+WFmn917YZ5g8pLlBohk/l85i+uk1Fk7V9Uoyabc/t8jjQLwc
         CI5g==
X-Forwarded-Encrypted: i=1; AJvYcCUjrPYZTRQb2MPJhlR34xtoD9sJCvj+5CVkrM5+MUyfXSUjo9cIUW27ZG4XZ9rm4O/TgZOInc40PxLJWlcr3n4hBdd7@vger.kernel.org, AJvYcCWv2As+3Qc53/8dHoYIlCL1yqhMjibc1LSPhuyDRtuRTDIZf1J6rpyYvlm5h3K657dPqtl7bRN/zUg=@vger.kernel.org, AJvYcCXqBFlcCLEJ4G72uolahAUT7MTolHDwBIqr9gnvTvpUviqOWVNmjzeitk+d/8CbPIy99R7BXpZLu+FobV3O@vger.kernel.org
X-Gm-Message-State: AOJu0YxF8mudTauIOOzryks9pKWDl9KdS3nNxQzEP+hOn24D+J9nmjWM
	eVZYY7qJpozFYxA09WnbVaLRkFZ5+u3vvP2QjpHDA72J2bZXoxST
X-Gm-Gg: ASbGncsGMr5ppqAp8wk5DwiTGfVO+PwiSNt8uecdPJo5aRKWSCl8OEKNPgdUrjuYQ+A
	UbfKWv5XB/2QoL47wKiKu0aewwYhFumtuvq5Q+1H6eczE/0smjSSqINL1Fj6P30mUN+tSAbxBGK
	hIUuFgR/FPN92bp2cbEF5mUuNoxFSFL6NSzYqfPiAUfq1Xfz5Yxr7BhkuzhJNnyA0LQtTTtBy0q
	riLD4nFfxMBGplpWhGszWWfIjDba0pS3kF1E+EuTKUE/r8TzcsiTc9MEourj3y2oxV5OkeKMl4N
	bW2Wa7UmmzEUoA==
X-Google-Smtp-Source: AGHT+IH80uRHdl5TV8EIe05fztL0ELuh8SuRIVhEnwOABMhgmwW8JfG6o1lZYt0rKEt+7l0pmOwuXQ==
X-Received: by 2002:a17:903:98c:b0:211:e812:3948 with SMTP id d9443c01a7336-2216f439398mr79877155ad.0.1739989261002;
        Wed, 19 Feb 2025 10:21:01 -0800 (PST)
Received: from jemmy.. ([47.116.124.190])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ade083277b3sm7753218a12.27.2025.02.19.10.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 10:21:00 -0800 (PST)
From: Jemmy Wong <jemmywong512@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Jemmy Wong <Jemmywong512@gmail.com>
Subject: [PATCH 2/2] sched: Refine sched_avg naming for clarity and specificity
Date: Thu, 20 Feb 2025 02:20:20 +0800
Message-ID: <20250219182020.393006-3-jemmywong512@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250219182020.393006-1-jemmywong512@gmail.com>
References: <20250219182020.393006-1-jemmywong512@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Rename struct sched_avg to struct sched_pelt:
    - This structure includes not just average statistics
        but also sums like <load, runnable, util>_sum,
        all of which are PELT (Per-Entity Load Tracking) metrics.

- Rename init_entity_runnable_average to init_entity_pelt

Signed-off-by: Jemmy Wong <Jemmywong512@gmail.com>
---
 include/linux/sched.h |   4 +-
 kernel/sched/core.c   |   2 +-
 kernel/sched/debug.c  |  30 ++--
 kernel/sched/fair.c   | 352 +++++++++++++++++++++---------------------
 kernel/sched/pelt.c   |  94 +++++------
 kernel/sched/pelt.h   |  16 +-
 kernel/sched/rt.c     |   2 +-
 kernel/sched/sched.h  |  18 +--
 8 files changed, 258 insertions(+), 260 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4b3765ca3e00..37c243a24608 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -479,7 +479,7 @@ struct load_weight {
  * Then it is the load_weight's responsibility to consider overflow
  * issues.
  */
-struct sched_avg {
+struct sched_pelt {
 	u64				last_update_time;
 	u64				load_sum;
 	u64				runnable_sum;
@@ -586,7 +586,7 @@ struct sched_entity {
 	 * Put into separate cache line so it does not
 	 * collide with read-mostly values above.
 	 */
-	struct sched_avg		avg;
+	struct sched_pelt		pelt;
 #endif
 };
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f16f814f9e4c..80cec2498fbc 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4768,7 +4768,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 		p->sched_class = &fair_sched_class;
 	}
 
-	init_entity_runnable_average(&p->se);
+	init_entity_pelt(&p->se);
 
 
 #ifdef CONFIG_SCHED_INFO
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index e446c16f839e..2420efc197d9 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -685,9 +685,9 @@ static void print_cfs_group_stats(struct seq_file *m, int cpu, struct task_group
 
 	P(se->lw.weight);
 #ifdef CONFIG_SMP
-	P(se->avg.load_avg);
-	P(se->avg.util_avg);
-	P(se->avg.runnable_avg);
+	P(se->pelt.load_avg);
+	P(se->pelt.util_avg);
+	P(se->pelt.runnable_avg);
 #endif
 
 #undef PN_SCHEDSTAT
@@ -850,13 +850,13 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 	SEQ_printf(m, "  .%-30s: %ld\n", "load", cfs_rq->lw.weight);
 #ifdef CONFIG_SMP
 	SEQ_printf(m, "  .%-30s: %lu\n", "load_avg",
-			cfs_rq->avg.load_avg);
+			cfs_rq->pelt.load_avg);
 	SEQ_printf(m, "  .%-30s: %lu\n", "runnable_avg",
-			cfs_rq->avg.runnable_avg);
+			cfs_rq->pelt.runnable_avg);
 	SEQ_printf(m, "  .%-30s: %lu\n", "util_avg",
-			cfs_rq->avg.util_avg);
+			cfs_rq->pelt.util_avg);
 	SEQ_printf(m, "  .%-30s: %u\n", "util_est",
-			cfs_rq->avg.util_est);
+			cfs_rq->pelt.util_est);
 	SEQ_printf(m, "  .%-30s: %ld\n", "removed.load_avg",
 			cfs_rq->removed.load_avg);
 	SEQ_printf(m, "  .%-30s: %ld\n", "removed.util_avg",
@@ -1242,14 +1242,14 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 
 	P(se.lw.weight);
 #ifdef CONFIG_SMP
-	P(se.avg.load_sum);
-	P(se.avg.runnable_sum);
-	P(se.avg.util_sum);
-	P(se.avg.load_avg);
-	P(se.avg.runnable_avg);
-	P(se.avg.util_avg);
-	P(se.avg.last_update_time);
-	PM(se.avg.util_est, ~UTIL_AVG_UNCHANGED);
+	P(se.pelt.load_sum);
+	P(se.pelt.runnable_sum);
+	P(se.pelt.util_sum);
+	P(se.pelt.load_avg);
+	P(se.pelt.runnable_avg);
+	P(se.pelt.util_avg);
+	P(se.pelt.last_update_time);
+	PM(se.pelt.util_est, ~UTIL_AVG_UNCHANGED);
 #endif
 #ifdef CONFIG_UCLAMP_TASK
 	__PS("uclamp.min", p->uclamp_req[UCLAMP_MIN].value);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2644d6c9234a..73d3e964b8d8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1033,12 +1033,12 @@ static int select_idle_sibling(struct task_struct *p, int prev_cpu, int cpu);
 static unsigned long task_h_load(struct task_struct *p);
 static unsigned long capacity_of(int cpu);
 
-/* Give new sched_entity start runnable values to heavy its load in infant time */
-void init_entity_runnable_average(struct sched_entity *se)
+/* Give new sched_entity start PELT values to heavy its load in infant time */
+void init_entity_pelt(struct sched_entity *se)
 {
-	struct sched_avg *sa = &se->avg;
+	struct sched_pelt *pelt = &se->pelt;
 
-	memset(sa, 0, sizeof(*sa));
+	memset(pelt, 0, sizeof(*pelt));
 
 	/*
 	 * Tasks are initialized with full load to be seen as heavy tasks until
@@ -1047,7 +1047,7 @@ void init_entity_runnable_average(struct sched_entity *se)
 	 * nothing has been attached to the task group yet.
 	 */
 	if (entity_is_task(se))
-		sa->load_avg = scale_load_down(se->lw.weight);
+		pelt->load_avg = scale_load_down(se->lw.weight);
 
 	/* when this task is enqueued, it will contribute to its cfs_rq's load_avg */
 }
@@ -1056,7 +1056,7 @@ void init_entity_runnable_average(struct sched_entity *se)
  * With new tasks being created, their initial util_avgs are extrapolated
  * based on the cfs_rq's current util_avg:
  *
- *   util_avg = cfs_rq->avg.util_avg / (cfs_rq->avg.load_avg + 1)
+ *   util_avg = cfs_rq->pelt.util_avg / (cfs_rq->pelt.load_avg + 1)
  *		* se_weight(se)
  *
  * However, in many cases, the above util_avg does not give a desired
@@ -1066,7 +1066,7 @@ void init_entity_runnable_average(struct sched_entity *se)
  * To solve this problem, we also cap the util_avg of successive tasks to
  * only 1/2 of the left utilization budget:
  *
- *   util_avg_cap = (cpu_scale - cfs_rq->avg.util_avg) / 2^n
+ *   util_avg_cap = (cpu_scale - cfs_rq->pelt.util_avg) / 2^n
  *
  * where n denotes the nth task and cpu_scale the CPU capacity.
  *
@@ -1083,9 +1083,9 @@ void post_init_entity_util_avg(struct task_struct *p)
 {
 	struct sched_entity *se = &p->se;
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
-	struct sched_avg *sa = &se->avg;
+	struct sched_pelt *pelt = &se->pelt;
 	long cpu_scale = arch_scale_cpu_capacity(cpu_of(rq_of(cfs_rq)));
-	long cap = (long)(cpu_scale - cfs_rq->avg.util_avg) / 2;
+	long cap = (long)(cpu_scale - cfs_rq->pelt.util_avg) / 2;
 
 	if (p->sched_class != &fair_sched_class) {
 		/*
@@ -1098,27 +1098,27 @@ void post_init_entity_util_avg(struct task_struct *p)
 		 * such that the next switched_to_fair() has the
 		 * expected state.
 		 */
-		se->avg.last_update_time = cfs_rq_clock_pelt(cfs_rq);
+		se->pelt.last_update_time = cfs_rq_clock_pelt(cfs_rq);
 		return;
 	}
 
 	if (cap > 0) {
-		if (cfs_rq->avg.util_avg != 0) {
-			sa->util_avg  = cfs_rq->avg.util_avg * se_weight(se);
-			sa->util_avg /= (cfs_rq->avg.load_avg + 1);
+		if (cfs_rq->pelt.util_avg != 0) {
+			pelt->util_avg  = cfs_rq->pelt.util_avg * se_weight(se);
+			pelt->util_avg /= (cfs_rq->pelt.load_avg + 1);
 
-			if (sa->util_avg > cap)
-				sa->util_avg = cap;
+			if (pelt->util_avg > cap)
+				pelt->util_avg = cap;
 		} else {
-			sa->util_avg = cap;
+			pelt->util_avg = cap;
 		}
 	}
 
-	sa->runnable_avg = sa->util_avg;
+	pelt->runnable_avg = pelt->util_avg;
 }
 
 #else /* !CONFIG_SMP */
-void init_entity_runnable_average(struct sched_entity *se)
+void init_entity_pelt(struct sched_entity *se)
 {
 }
 void post_init_entity_util_avg(struct task_struct *p)
@@ -2779,7 +2779,7 @@ static u64 numa_get_avg_runtime(struct task_struct *p, u64 *period)
 		if (unlikely((s64)*period < 0))
 			*period = 0;
 	} else {
-		delta = p->se.avg.load_sum;
+		delta = p->se.pelt.load_sum;
 		*period = LOAD_AVG_MAX;
 	}
 
@@ -3748,18 +3748,18 @@ account_entity_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 static inline void
 enqueue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	cfs_rq->avg.load_avg += se->avg.load_avg;
-	cfs_rq->avg.load_sum += se_weight(se) * se->avg.load_sum;
+	cfs_rq->pelt.load_avg += se->pelt.load_avg;
+	cfs_rq->pelt.load_sum += se_weight(se) * se->pelt.load_sum;
 }
 
 static inline void
 dequeue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	sub_positive(&cfs_rq->avg.load_avg, se->avg.load_avg);
-	sub_positive(&cfs_rq->avg.load_sum, se_weight(se) * se->avg.load_sum);
+	sub_positive(&cfs_rq->pelt.load_avg, se->pelt.load_avg);
+	sub_positive(&cfs_rq->pelt.load_sum, se_weight(se) * se->pelt.load_sum);
 	/* See update_cfs_rq_load_avg() */
-	cfs_rq->avg.load_sum = max_t(u32, cfs_rq->avg.load_sum,
-					  cfs_rq->avg.load_avg * PELT_MIN_DIVIDER);
+	cfs_rq->pelt.load_sum = max_t(u32, cfs_rq->pelt.load_sum,
+		cfs_rq->pelt.load_avg * PELT_MIN_DIVIDER);
 }
 #else
 static inline void
@@ -3799,9 +3799,9 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 
 #ifdef CONFIG_SMP
 	do {
-		u32 divider = get_pelt_divider(&se->avg);
+		u32 divider = get_pelt_divider(&se->pelt);
 
-		se->avg.load_avg = div_u64(se_weight(se) * se->avg.load_sum, divider);
+		se->pelt.load_avg = div_u64(se_weight(se) * se->pelt.load_sum, divider);
 	} while (0);
 #endif
 
@@ -3855,22 +3855,22 @@ static inline int throttled_hierarchy(struct cfs_rq *cfs_rq);
  *
  * So instead of the above, we substitute:
  *
- *   grq->lw.weight -> grq->avg.load_avg                         (2)
+ *   grq->lw.weight -> grq->pelt.load_avg                 	 (2)
  *
  * which yields the following:
  *
- *                     tg->weight * grq->avg.load_avg
+ *                     tg->weight * grq->pelt.load_avg
  *   ge->lw.weight = ------------------------------              (3)
  *                             tg->load_avg
  *
- * Where: tg->load_avg ~= \Sum grq->avg.load_avg
+ * Where: tg->load_avg ~= \Sum grq->pelt.load_avg
  *
  * That is shares_avg, and it is right (given the approximation (2)).
  *
  * The problem with it is that because the average is slow -- it was designed
  * to be exactly that of course -- this leads to transients in boundary
  * conditions. In specific, the case where the group was idle and we start the
- * one task. It takes time for our CPU's grq->avg.load_avg to build up,
+ * one task. It takes time for our CPU's grq->pelt.load_avg to build up,
  * yielding bad latency etc..
  *
  * Now, in that special case (1) reduces to:
@@ -3888,10 +3888,10 @@ static inline int throttled_hierarchy(struct cfs_rq *cfs_rq);
  *
  *              tg->weight * grq->lw.weight
  *     ---------------------------------------------------         (5)
- *     tg->load_avg - grq->avg.load_avg + grq->lw.weight
+ *     tg->load_avg - grq->pelt.load_avg + grq->lw.weight
  *
  * But because grq->lw.weight can drop to 0, resulting in a divide by zero,
- * we need to use grq->avg.load_avg as its lower bound, which then gives:
+ * we need to use grq->pelt.load_avg as its lower bound, which then gives:
  *
  *
  *                     tg->weight * grq->lw.weight
@@ -3900,8 +3900,8 @@ static inline int throttled_hierarchy(struct cfs_rq *cfs_rq);
  *
  * Where:
  *
- *   tg_load_avg' = tg->load_avg - grq->avg.load_avg +
- *                  max(grq->lw.weight, grq->avg.load_avg)
+ *   tg_load_avg' = tg->load_avg - grq->pelt.load_avg +
+ *                  max(grq->lw.weight, grq->pelt.load_avg)
  *
  * And that is shares_weight and is icky. In the (near) UP case it approaches
  * (4) while in the normal case it approaches (3). It consistently
@@ -3918,7 +3918,7 @@ static long calc_group_shares(struct cfs_rq *cfs_rq)
 
 	tg_shares = READ_ONCE(tg->shares);
 
-	load = max(scale_load_down(cfs_rq->lw.weight), cfs_rq->avg.load_avg);
+	load = max(scale_load_down(cfs_rq->lw.weight), cfs_rq->pelt.load_avg);
 
 	tg_weight = atomic_long_read(&tg->load_avg);
 
@@ -4004,15 +4004,15 @@ static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
 }
 
 #ifdef CONFIG_SMP
-static inline bool load_avg_is_decayed(struct sched_avg *sa)
+static inline bool load_avg_is_decayed(struct sched_pelt *pelt)
 {
-	if (sa->load_sum)
+	if (pelt->load_sum)
 		return false;
 
-	if (sa->util_sum)
+	if (pelt->util_sum)
 		return false;
 
-	if (sa->runnable_sum)
+	if (pelt->runnable_sum)
 		return false;
 
 	/*
@@ -4020,16 +4020,16 @@ static inline bool load_avg_is_decayed(struct sched_avg *sa)
 	 * Make sure that rounding and/or propagation of PELT values never
 	 * break this.
 	 */
-	SCHED_WARN_ON(sa->load_avg ||
-		      sa->util_avg ||
-		      sa->runnable_avg);
+	SCHED_WARN_ON(pelt->load_avg ||
+		      pelt->util_avg ||
+		      pelt->runnable_avg);
 
 	return true;
 }
 
 static inline u64 cfs_rq_last_update_time(struct cfs_rq *cfs_rq)
 {
-	return u64_u32_load_copy(cfs_rq->avg.last_update_time,
+	return u64_u32_load_copy(cfs_rq->pelt.last_update_time,
 				 cfs_rq->last_update_time_copy);
 }
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -4064,7 +4064,7 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 	if (cfs_rq->lw.weight)
 		return false;
 
-	if (!load_avg_is_decayed(&cfs_rq->avg))
+	if (!load_avg_is_decayed(&cfs_rq->pelt))
 		return false;
 
 	if (child_cfs_rq_on_list(cfs_rq))
@@ -4110,10 +4110,10 @@ static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
 	if (now - cfs_rq->last_update_tg_load_avg < NSEC_PER_MSEC)
 		return;
 
-	delta = cfs_rq->avg.load_avg - cfs_rq->tg_load_avg_contrib;
+	delta = cfs_rq->pelt.load_avg - cfs_rq->tg_load_avg_contrib;
 	if (abs(delta) > cfs_rq->tg_load_avg_contrib / 64) {
 		atomic_long_add(delta, &cfs_rq->tg->load_avg);
-		cfs_rq->tg_load_avg_contrib = cfs_rq->avg.load_avg;
+		cfs_rq->tg_load_avg_contrib = cfs_rq->pelt.load_avg;
 		cfs_rq->last_update_tg_load_avg = now;
 	}
 }
@@ -4182,14 +4182,14 @@ void set_task_rq_fair(struct sched_entity *se,
 	 * time. This will result in the wakee task is less decayed, but giving
 	 * the wakee more load sounds not bad.
 	 */
-	if (!(se->avg.last_update_time && prev))
+	if (!(se->pelt.last_update_time && prev))
 		return;
 
 	p_last_update_time = cfs_rq_last_update_time(prev);
 	n_last_update_time = cfs_rq_last_update_time(next);
 
 	__update_load_avg_blocked_se(p_last_update_time, se);
-	se->avg.last_update_time = n_last_update_time;
+	se->pelt.last_update_time = n_last_update_time;
 }
 
 /*
@@ -4208,21 +4208,21 @@ void set_task_rq_fair(struct sched_entity *se,
  *
  * However, update_tg_cfs_load() is more complex. So we have:
  *
- *   ge->avg.load_avg = ge->lw.weight * ge->avg.runnable_avg		(2)
+ *   ge->pelt.load_avg = ge->lw.weight * ge->pelt.runnable_avg		(2)
  *
  * And since, like util, the runnable part should be directly transferable,
  * the following would _appear_ to be the straight forward approach:
  *
- *   grq->avg.load_avg = grq->lw.weight * grq->avg.runnable_avg	(3)
+ *   grq->pelt.load_avg = grq->lw.weight * grq->pelt.runnable_avg	(3)
  *
  * And per (1) we have:
  *
- *   ge->avg.runnable_avg == grq->avg.runnable_avg
+ *   ge->pelt.runnable_avg == grq->pelt.runnable_avg
  *
  * Which gives:
  *
- *                      ge->lw.weight * grq->avg.load_avg
- *   ge->avg.load_avg = -----------------------------------		(4)
+ *                      ge->lw.weight * grq->pelt.load_avg
+ *   ge->pelt.load_avg = -----------------------------------		(4)
  *                               grq->lw.weight
  *
  * Except that is wrong!
@@ -4247,14 +4247,14 @@ void set_task_rq_fair(struct sched_entity *se,
  *
  * Given the constraint:
  *
- *   ge->avg.running_sum <= ge->avg.runnable_sum <= LOAD_AVG_MAX
+ *   ge->avg.running_sum <= ge->pelt.runnable_sum <= LOAD_AVG_MAX
  *
  * We can construct a rule that adds runnable to a rq by assuming minimal
  * overlap.
  *
  * On removal, we'll assume each task is equally runnable; which yields:
  *
- *   grq->avg.runnable_sum = grq->avg.load_sum / grq->lw.weight
+ *   grq->pelt.runnable_sum = grq->pelt.load_sum / grq->lw.weight
  *
  * XXX: only do this for the part of runnable > running ?
  *
@@ -4262,7 +4262,7 @@ void set_task_rq_fair(struct sched_entity *se,
 static inline void
 update_tg_cfs_util(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
 {
-	long delta_sum, delta_avg = gcfs_rq->avg.util_avg - se->avg.util_avg;
+	long delta_sum, delta_avg = gcfs_rq->pelt.util_avg - se->pelt.util_avg;
 	u32 new_sum, divider;
 
 	/* Nothing to update */
@@ -4270,31 +4270,31 @@ update_tg_cfs_util(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq
 		return;
 
 	/*
-	 * cfs_rq->avg.period_contrib can be used for both cfs_rq and se.
+	 * cfs_rq->pelt.period_contrib can be used for both cfs_rq and se.
 	 * See ___update_load_avg() for details.
 	 */
-	divider = get_pelt_divider(&cfs_rq->avg);
+	divider = get_pelt_divider(&cfs_rq->pelt);
 
 
 	/* Set new sched_entity's utilization */
-	se->avg.util_avg = gcfs_rq->avg.util_avg;
-	new_sum = se->avg.util_avg * divider;
-	delta_sum = (long)new_sum - (long)se->avg.util_sum;
-	se->avg.util_sum = new_sum;
+	se->pelt.util_avg = gcfs_rq->pelt.util_avg;
+	new_sum = se->pelt.util_avg * divider;
+	delta_sum = (long)new_sum - (long)se->pelt.util_sum;
+	se->pelt.util_sum = new_sum;
 
 	/* Update parent cfs_rq utilization */
-	add_positive(&cfs_rq->avg.util_avg, delta_avg);
-	add_positive(&cfs_rq->avg.util_sum, delta_sum);
+	add_positive(&cfs_rq->pelt.util_avg, delta_avg);
+	add_positive(&cfs_rq->pelt.util_sum, delta_sum);
 
 	/* See update_cfs_rq_load_avg() */
-	cfs_rq->avg.util_sum = max_t(u32, cfs_rq->avg.util_sum,
-					  cfs_rq->avg.util_avg * PELT_MIN_DIVIDER);
+	cfs_rq->pelt.util_sum = max_t(u32, cfs_rq->pelt.util_sum,
+					  cfs_rq->pelt.util_avg * PELT_MIN_DIVIDER);
 }
 
 static inline void
 update_tg_cfs_runnable(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
 {
-	long delta_sum, delta_avg = gcfs_rq->avg.runnable_avg - se->avg.runnable_avg;
+	long delta_sum, delta_avg = gcfs_rq->pelt.runnable_avg - se->pelt.runnable_avg;
 	u32 new_sum, divider;
 
 	/* Nothing to update */
@@ -4302,23 +4302,23 @@ update_tg_cfs_runnable(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cf
 		return;
 
 	/*
-	 * cfs_rq->avg.period_contrib can be used for both cfs_rq and se.
+	 * cfs_rq->pelt.period_contrib can be used for both cfs_rq and se.
 	 * See ___update_load_avg() for details.
 	 */
-	divider = get_pelt_divider(&cfs_rq->avg);
+	divider = get_pelt_divider(&cfs_rq->pelt);
 
 	/* Set new sched_entity's runnable */
-	se->avg.runnable_avg = gcfs_rq->avg.runnable_avg;
-	new_sum = se->avg.runnable_avg * divider;
-	delta_sum = (long)new_sum - (long)se->avg.runnable_sum;
-	se->avg.runnable_sum = new_sum;
+	se->pelt.runnable_avg = gcfs_rq->pelt.runnable_avg;
+	new_sum = se->pelt.runnable_avg * divider;
+	delta_sum = (long)new_sum - (long)se->pelt.runnable_sum;
+	se->pelt.runnable_sum = new_sum;
 
 	/* Update parent cfs_rq runnable */
-	add_positive(&cfs_rq->avg.runnable_avg, delta_avg);
-	add_positive(&cfs_rq->avg.runnable_sum, delta_sum);
+	add_positive(&cfs_rq->pelt.runnable_avg, delta_avg);
+	add_positive(&cfs_rq->pelt.runnable_sum, delta_sum);
 	/* See update_cfs_rq_load_avg() */
-	cfs_rq->avg.runnable_sum = max_t(u32, cfs_rq->avg.runnable_sum,
-					      cfs_rq->avg.runnable_avg * PELT_MIN_DIVIDER);
+	cfs_rq->pelt.runnable_sum = max_t(u32, cfs_rq->pelt.runnable_sum,
+					      cfs_rq->pelt.runnable_avg * PELT_MIN_DIVIDER);
 }
 
 static inline void
@@ -4336,17 +4336,17 @@ update_tg_cfs_load(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq
 	gcfs_rq->prop_runnable_sum = 0;
 
 	/*
-	 * cfs_rq->avg.period_contrib can be used for both cfs_rq and se.
+	 * cfs_rq->pelt.period_contrib can be used for both cfs_rq and se.
 	 * See ___update_load_avg() for details.
 	 */
-	divider = get_pelt_divider(&cfs_rq->avg);
+	divider = get_pelt_divider(&cfs_rq->pelt);
 
 	if (runnable_sum >= 0) {
 		/*
 		 * Add runnable; clip at LOAD_AVG_MAX. Reflects that until
 		 * the CPU is saturated running == runnable.
 		 */
-		runnable_sum += se->avg.load_sum;
+		runnable_sum += se->pelt.load_sum;
 		runnable_sum = min_t(long, runnable_sum, divider);
 	} else {
 		/*
@@ -4354,12 +4354,12 @@ update_tg_cfs_load(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq
 		 * assuming all tasks are equally runnable.
 		 */
 		if (scale_load_down(gcfs_rq->lw.weight)) {
-			load_sum = div_u64(gcfs_rq->avg.load_sum,
+			load_sum = div_u64(gcfs_rq->pelt.load_sum,
 				scale_load_down(gcfs_rq->lw.weight));
 		}
 
 		/* But make sure to not inflate se's runnable */
-		runnable_sum = min(se->avg.load_sum, load_sum);
+		runnable_sum = min(se->pelt.load_sum, load_sum);
 	}
 
 	/*
@@ -4368,25 +4368,25 @@ update_tg_cfs_load(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq
 	 * running_sum is in [0 : LOAD_AVG_MAX <<  SCHED_CAPACITY_SHIFT]
 	 * runnable_sum is in [0 : LOAD_AVG_MAX]
 	 */
-	running_sum = se->avg.util_sum >> SCHED_CAPACITY_SHIFT;
+	running_sum = se->pelt.util_sum >> SCHED_CAPACITY_SHIFT;
 	runnable_sum = max(runnable_sum, running_sum);
 
 	load_sum = se_weight(se) * runnable_sum;
 	load_avg = div_u64(load_sum, divider);
 
-	delta_avg = load_avg - se->avg.load_avg;
+	delta_avg = load_avg - se->pelt.load_avg;
 	if (!delta_avg)
 		return;
 
-	delta_sum = load_sum - (s64)se_weight(se) * se->avg.load_sum;
+	delta_sum = load_sum - (s64)se_weight(se) * se->pelt.load_sum;
 
-	se->avg.load_sum = runnable_sum;
-	se->avg.load_avg = load_avg;
-	add_positive(&cfs_rq->avg.load_avg, delta_avg);
-	add_positive(&cfs_rq->avg.load_sum, delta_sum);
+	se->pelt.load_sum = runnable_sum;
+	se->pelt.load_avg = load_avg;
+	add_positive(&cfs_rq->pelt.load_avg, delta_avg);
+	add_positive(&cfs_rq->pelt.load_sum, delta_sum);
 	/* See update_cfs_rq_load_avg() */
-	cfs_rq->avg.load_sum = max_t(u32, cfs_rq->avg.load_sum,
-					  cfs_rq->avg.load_avg * PELT_MIN_DIVIDER);
+	cfs_rq->pelt.load_sum = max_t(u32, cfs_rq->pelt.load_sum,
+					  cfs_rq->pelt.load_avg * PELT_MIN_DIVIDER);
 }
 
 static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable_sum)
@@ -4435,7 +4435,7 @@ static inline bool skip_blocked_update(struct sched_entity *se)
 	 * If sched_entity still have not zero load or utilization, we have to
 	 * decay it:
 	 */
-	if (se->avg.load_avg || se->avg.util_avg)
+	if (se->pelt.load_avg || se->pelt.util_avg)
 		return false;
 
 	/*
@@ -4476,7 +4476,7 @@ static inline void migrate_se_pelt_lag(struct sched_entity *se)
 	struct rq *rq;
 	bool is_idle;
 
-	if (load_avg_is_decayed(&se->avg))
+	if (load_avg_is_decayed(&se->pelt))
 		return;
 
 	cfs_rq = cfs_rq_of(se);
@@ -4538,7 +4538,7 @@ static inline void migrate_se_pelt_lag(struct sched_entity *se)
 	now -= throttled;
 	if (now < lut)
 		/*
-		 * cfs_rq->avg.last_update_time is more recent than our
+		 * cfs_rq->pelt.last_update_time is more recent than our
 		 * estimation, let's use it.
 		 */
 		now = lut;
@@ -4559,23 +4559,23 @@ static void migrate_se_pelt_lag(struct sched_entity *se) {}
  * The cfs_rq avg is the direct sum of all its entities (blocked and runnable)
  * avg. The immediate corollary is that all (fair) tasks must be attached.
  *
- * cfs_rq->avg is used for task_h_load() and update_cfs_share() for example.
+ * cfs_rq->pelt is used for task_h_load() and update_cfs_share() for example.
  *
  * Return: true if the load decayed or we removed load.
  *
- * Since both these conditions indicate a changed cfs_rq->avg.load we should
+ * Since both these conditions indicate a changed cfs_rq->pelt.load we should
  * call update_tg_load_avg() when this function returns true.
  */
 static inline int
 update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 {
 	unsigned long removed_load = 0, removed_util = 0, removed_runnable = 0;
-	struct sched_avg *sa = &cfs_rq->avg;
+	struct sched_pelt *pelt = &cfs_rq->pelt;
 	int decayed = 0;
 
 	if (cfs_rq->removed.nr) {
 		unsigned long r;
-		u32 divider = get_pelt_divider(&cfs_rq->avg);
+		u32 divider = get_pelt_divider(&cfs_rq->pelt);
 
 		raw_spin_lock(&cfs_rq->removed.lock);
 		swap(cfs_rq->removed.util_avg, removed_util);
@@ -4585,14 +4585,14 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 		raw_spin_unlock(&cfs_rq->removed.lock);
 
 		r = removed_load;
-		sub_positive(&sa->load_avg, r);
-		sub_positive(&sa->load_sum, r * divider);
-		/* See sa->util_sum below */
-		sa->load_sum = max_t(u32, sa->load_sum, sa->load_avg * PELT_MIN_DIVIDER);
+		sub_positive(&pelt->load_avg, r);
+		sub_positive(&pelt->load_sum, r * divider);
+		/* See pelt->util_sum below */
+		pelt->load_sum = max_t(u32, pelt->load_sum, pelt->load_avg * PELT_MIN_DIVIDER);
 
 		r = removed_util;
-		sub_positive(&sa->util_avg, r);
-		sub_positive(&sa->util_sum, r * divider);
+		sub_positive(&pelt->util_avg, r);
+		sub_positive(&pelt->util_sum, r * divider);
 		/*
 		 * Because of rounding, se->util_sum might ends up being +1 more than
 		 * cfs->util_sum. Although this is not a problem by itself, detaching
@@ -4604,14 +4604,14 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 		 * sync, we are only sure that util_sum must be above or equal to
 		 *    util_avg * minimum possible divider
 		 */
-		sa->util_sum = max_t(u32, sa->util_sum, sa->util_avg * PELT_MIN_DIVIDER);
+		pelt->util_sum = max_t(u32, pelt->util_sum, pelt->util_avg * PELT_MIN_DIVIDER);
 
 		r = removed_runnable;
-		sub_positive(&sa->runnable_avg, r);
-		sub_positive(&sa->runnable_sum, r * divider);
-		/* See sa->util_sum above */
-		sa->runnable_sum = max_t(u32, sa->runnable_sum,
-					      sa->runnable_avg * PELT_MIN_DIVIDER);
+		sub_positive(&pelt->runnable_avg, r);
+		sub_positive(&pelt->runnable_sum, r * divider);
+		/* See pelt->util_sum above */
+		pelt->runnable_sum = max_t(u32, pelt->runnable_sum,
+			pelt->runnable_avg * PELT_MIN_DIVIDER);
 
 		/*
 		 * removed_runnable is the unweighted version of removed_load so we
@@ -4624,9 +4624,9 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 	}
 
 	decayed |= __update_load_avg_cfs_rq(now, cfs_rq);
-	u64_u32_store_copy(sa->last_update_time,
+	u64_u32_store_copy(pelt->last_update_time,
 			   cfs_rq->last_update_time_copy,
-			   sa->last_update_time);
+			   pelt->last_update_time);
 	return decayed;
 }
 
@@ -4636,15 +4636,15 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
  * @se: sched_entity to attach
  *
  * Must call update_cfs_rq_load_avg() before this, since we rely on
- * cfs_rq->avg.last_update_time being current.
+ * cfs_rq->pelt.last_update_time being current.
  */
 static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	/*
-	 * cfs_rq->avg.period_contrib can be used for both cfs_rq and se.
+	 * cfs_rq->pelt.period_contrib can be used for both cfs_rq and se.
 	 * See ___update_load_avg() for details.
 	 */
-	u32 divider = get_pelt_divider(&cfs_rq->avg);
+	u32 divider = get_pelt_divider(&cfs_rq->pelt);
 
 	/*
 	 * When we attach the @se to the @cfs_rq, we must align the decay
@@ -4653,8 +4653,8 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 	 *
 	 * XXX illustrate
 	 */
-	se->avg.last_update_time = cfs_rq->avg.last_update_time;
-	se->avg.period_contrib = cfs_rq->avg.period_contrib;
+	se->pelt.last_update_time = cfs_rq->pelt.last_update_time;
+	se->pelt.period_contrib = cfs_rq->pelt.period_contrib;
 
 	/*
 	 * Hell(o) Nasty stuff.. we need to recompute _sum based on the new
@@ -4662,23 +4662,23 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 	 * entirely outside of the PELT hierarchy, nobody cares if we truncate
 	 * _sum a little.
 	 */
-	se->avg.util_sum = se->avg.util_avg * divider;
+	se->pelt.util_sum = se->pelt.util_avg * divider;
 
-	se->avg.runnable_sum = se->avg.runnable_avg * divider;
+	se->pelt.runnable_sum = se->pelt.runnable_avg * divider;
 
-	se->avg.load_sum = se->avg.load_avg * divider;
-	if (se_weight(se) < se->avg.load_sum)
-		se->avg.load_sum = div_u64(se->avg.load_sum, se_weight(se));
+	se->pelt.load_sum = se->pelt.load_avg * divider;
+	if (se_weight(se) < se->pelt.load_sum)
+		se->pelt.load_sum = div_u64(se->pelt.load_sum, se_weight(se));
 	else
-		se->avg.load_sum = 1;
+		se->pelt.load_sum = 1;
 
 	enqueue_load_avg(cfs_rq, se);
-	cfs_rq->avg.util_avg += se->avg.util_avg;
-	cfs_rq->avg.util_sum += se->avg.util_sum;
-	cfs_rq->avg.runnable_avg += se->avg.runnable_avg;
-	cfs_rq->avg.runnable_sum += se->avg.runnable_sum;
+	cfs_rq->pelt.util_avg += se->pelt.util_avg;
+	cfs_rq->pelt.util_sum += se->pelt.util_sum;
+	cfs_rq->pelt.runnable_avg += se->pelt.runnable_avg;
+	cfs_rq->pelt.runnable_sum += se->pelt.runnable_sum;
 
-	add_tg_cfs_propagate(cfs_rq, se->avg.load_sum);
+	add_tg_cfs_propagate(cfs_rq, se->pelt.load_sum);
 
 	cfs_rq_util_change(cfs_rq, 0);
 
@@ -4691,24 +4691,24 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
  * @se: sched_entity to detach
  *
  * Must call update_cfs_rq_load_avg() before this, since we rely on
- * cfs_rq->avg.last_update_time being current.
+ * cfs_rq->pelt.last_update_time being current.
  */
 static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	dequeue_load_avg(cfs_rq, se);
-	sub_positive(&cfs_rq->avg.util_avg, se->avg.util_avg);
-	sub_positive(&cfs_rq->avg.util_sum, se->avg.util_sum);
+	sub_positive(&cfs_rq->pelt.util_avg, se->pelt.util_avg);
+	sub_positive(&cfs_rq->pelt.util_sum, se->pelt.util_sum);
 	/* See update_cfs_rq_load_avg() */
-	cfs_rq->avg.util_sum = max_t(u32, cfs_rq->avg.util_sum,
-					  cfs_rq->avg.util_avg * PELT_MIN_DIVIDER);
+	cfs_rq->pelt.util_sum = max_t(u32, cfs_rq->pelt.util_sum,
+					  cfs_rq->pelt.util_avg * PELT_MIN_DIVIDER);
 
-	sub_positive(&cfs_rq->avg.runnable_avg, se->avg.runnable_avg);
-	sub_positive(&cfs_rq->avg.runnable_sum, se->avg.runnable_sum);
+	sub_positive(&cfs_rq->pelt.runnable_avg, se->pelt.runnable_avg);
+	sub_positive(&cfs_rq->pelt.runnable_sum, se->pelt.runnable_sum);
 	/* See update_cfs_rq_load_avg() */
-	cfs_rq->avg.runnable_sum = max_t(u32, cfs_rq->avg.runnable_sum,
-					      cfs_rq->avg.runnable_avg * PELT_MIN_DIVIDER);
+	cfs_rq->pelt.runnable_sum = max_t(u32, cfs_rq->pelt.runnable_sum,
+					      cfs_rq->pelt.runnable_avg * PELT_MIN_DIVIDER);
 
-	add_tg_cfs_propagate(cfs_rq, -se->avg.load_sum);
+	add_tg_cfs_propagate(cfs_rq, -se->pelt.load_sum);
 
 	cfs_rq_util_change(cfs_rq, 0);
 
@@ -4733,13 +4733,13 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 	 * Track task load average for carrying it to new CPU after migrated, and
 	 * track group sched_entity load average for task_h_load calculation in migration
 	 */
-	if (se->avg.last_update_time && !(flags & SKIP_AGE_LOAD))
+	if (se->pelt.last_update_time && !(flags & SKIP_AGE_LOAD))
 		__update_load_avg_se(now, cfs_rq, se);
 
 	decayed  = update_cfs_rq_load_avg(now, cfs_rq);
 	decayed |= propagate_entity_load_avg(se);
 
-	if (!se->avg.last_update_time && (flags & DO_ATTACH)) {
+	if (!se->pelt.last_update_time && (flags & DO_ATTACH)) {
 
 		/*
 		 * DO_ATTACH means we're here from enqueue_entity().
@@ -4798,37 +4798,37 @@ static void remove_entity_load_avg(struct sched_entity *se)
 
 	raw_spin_lock_irqsave(&cfs_rq->removed.lock, flags);
 	++cfs_rq->removed.nr;
-	cfs_rq->removed.util_avg	+= se->avg.util_avg;
-	cfs_rq->removed.load_avg	+= se->avg.load_avg;
-	cfs_rq->removed.runnable_avg	+= se->avg.runnable_avg;
+	cfs_rq->removed.util_avg	+= se->pelt.util_avg;
+	cfs_rq->removed.load_avg	+= se->pelt.load_avg;
+	cfs_rq->removed.runnable_avg	+= se->pelt.runnable_avg;
 	raw_spin_unlock_irqrestore(&cfs_rq->removed.lock, flags);
 }
 
 static inline unsigned long cfs_rq_runnable_avg(struct cfs_rq *cfs_rq)
 {
-	return cfs_rq->avg.runnable_avg;
+	return cfs_rq->pelt.runnable_avg;
 }
 
 static inline unsigned long cfs_rq_load_avg(struct cfs_rq *cfs_rq)
 {
-	return cfs_rq->avg.load_avg;
+	return cfs_rq->pelt.load_avg;
 }
 
 static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf);
 
 static inline unsigned long task_util(struct task_struct *p)
 {
-	return READ_ONCE(p->se.avg.util_avg);
+	return READ_ONCE(p->se.pelt.util_avg);
 }
 
 static inline unsigned long task_runnable(struct task_struct *p)
 {
-	return READ_ONCE(p->se.avg.runnable_avg);
+	return READ_ONCE(p->se.pelt.runnable_avg);
 }
 
 static inline unsigned long _task_util_est(struct task_struct *p)
 {
-	return READ_ONCE(p->se.avg.util_est) & ~UTIL_AVG_UNCHANGED;
+	return READ_ONCE(p->se.pelt.util_est) & ~UTIL_AVG_UNCHANGED;
 }
 
 static inline unsigned long task_util_est(struct task_struct *p)
@@ -4845,9 +4845,9 @@ static inline void util_est_enqueue(struct cfs_rq *cfs_rq,
 		return;
 
 	/* Update root cfs_rq's estimated utilization */
-	enqueued  = cfs_rq->avg.util_est;
+	enqueued  = cfs_rq->pelt.util_est;
 	enqueued += _task_util_est(p);
-	WRITE_ONCE(cfs_rq->avg.util_est, enqueued);
+	WRITE_ONCE(cfs_rq->pelt.util_est, enqueued);
 
 	trace_sched_util_est_cfs_tp(cfs_rq);
 }
@@ -4861,9 +4861,9 @@ static inline void util_est_dequeue(struct cfs_rq *cfs_rq,
 		return;
 
 	/* Update root cfs_rq's estimated utilization */
-	enqueued  = cfs_rq->avg.util_est;
+	enqueued  = cfs_rq->pelt.util_est;
 	enqueued -= min_t(unsigned int, enqueued, _task_util_est(p));
-	WRITE_ONCE(cfs_rq->avg.util_est, enqueued);
+	WRITE_ONCE(cfs_rq->pelt.util_est, enqueued);
 
 	trace_sched_util_est_cfs_tp(cfs_rq);
 }
@@ -4887,7 +4887,7 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 		return;
 
 	/* Get current estimate of utilization */
-	ewma = READ_ONCE(p->se.avg.util_est);
+	ewma = READ_ONCE(p->se.pelt.util_est);
 
 	/*
 	 * If the PELT values haven't changed since enqueue time,
@@ -4952,7 +4952,7 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 	ewma >>= UTIL_EST_WEIGHT_SHIFT;
 done:
 	ewma |= UTIL_AVG_UNCHANGED;
-	WRITE_ONCE(p->se.avg.util_est, ewma);
+	WRITE_ONCE(p->se.pelt.util_est, ewma);
 
 	trace_sched_util_est_se_tp(&p->se);
 }
@@ -7225,11 +7225,11 @@ static unsigned long cpu_load_without(struct rq *rq, struct task_struct *p)
 	unsigned int load;
 
 	/* Task has no contribution or is new */
-	if (cpu_of(rq) != task_cpu(p) || !READ_ONCE(p->se.avg.last_update_time))
+	if (cpu_of(rq) != task_cpu(p) || !READ_ONCE(p->se.pelt.last_update_time))
 		return cpu_load(rq);
 
 	cfs_rq = &rq->cfs;
-	load = READ_ONCE(cfs_rq->avg.load_avg);
+	load = READ_ONCE(cfs_rq->pelt.load_avg);
 
 	/* Discount task's util from CPU's util */
 	lsub_positive(&load, task_h_load(p));
@@ -7248,14 +7248,14 @@ static unsigned long cpu_runnable_without(struct rq *rq, struct task_struct *p)
 	unsigned int runnable;
 
 	/* Task has no contribution or is new */
-	if (cpu_of(rq) != task_cpu(p) || !READ_ONCE(p->se.avg.last_update_time))
+	if (cpu_of(rq) != task_cpu(p) || !READ_ONCE(p->se.pelt.last_update_time))
 		return cpu_runnable(rq);
 
 	cfs_rq = &rq->cfs;
-	runnable = READ_ONCE(cfs_rq->avg.runnable_avg);
+	runnable = READ_ONCE(cfs_rq->pelt.runnable_avg);
 
 	/* Discount task's runnable from CPU's runnable */
-	lsub_positive(&runnable, p->se.avg.runnable_avg);
+	lsub_positive(&runnable, p->se.pelt.runnable_avg);
 
 	return runnable;
 }
@@ -7983,11 +7983,11 @@ static unsigned long
 cpu_util(int cpu, struct task_struct *p, int dst_cpu, int boost)
 {
 	struct cfs_rq *cfs_rq = &cpu_rq(cpu)->cfs;
-	unsigned long util = READ_ONCE(cfs_rq->avg.util_avg);
+	unsigned long util = READ_ONCE(cfs_rq->pelt.util_avg);
 	unsigned long runnable;
 
 	if (boost) {
-		runnable = READ_ONCE(cfs_rq->avg.runnable_avg);
+		runnable = READ_ONCE(cfs_rq->pelt.runnable_avg);
 		util = max(util, runnable);
 	}
 
@@ -8005,11 +8005,11 @@ cpu_util(int cpu, struct task_struct *p, int dst_cpu, int boost)
 	if (sched_feat(UTIL_EST)) {
 		unsigned long util_est;
 
-		util_est = READ_ONCE(cfs_rq->avg.util_est);
+		util_est = READ_ONCE(cfs_rq->pelt.util_est);
 
 		/*
 		 * During wake-up @p isn't enqueued yet and doesn't contribute
-		 * to any cpu_rq(cpu)->cfs.avg.util_est.
+		 * to any cpu_rq(cpu)->cfs.pelt.util_est.
 		 * If @dst_cpu == @cpu add it to "simulate" cpu_util after @p
 		 * has been enqueued.
 		 *
@@ -8070,7 +8070,7 @@ unsigned long cpu_util_cfs_boost(int cpu)
 static unsigned long cpu_util_without(int cpu, struct task_struct *p)
 {
 	/* Task has no contribution or is new */
-	if (cpu != task_cpu(p) || !READ_ONCE(p->se.avg.last_update_time))
+	if (cpu != task_cpu(p) || !READ_ONCE(p->se.pelt.last_update_time))
 		p = NULL;
 
 	return cpu_util(cpu, p, -1, 0);
@@ -8652,7 +8652,7 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 	}
 
 	/* Tell new CPU we are migrated */
-	se->avg.last_update_time = 0;
+	se->pelt.last_update_time = 0;
 
 	update_scan_period(p, new_cpu);
 }
@@ -9701,10 +9701,10 @@ static void attach_tasks(struct lb_env *env)
 #ifdef CONFIG_NO_HZ_COMMON
 static inline bool cfs_rq_has_blocked(struct cfs_rq *cfs_rq)
 {
-	if (cfs_rq->avg.load_avg)
+	if (cfs_rq->pelt.load_avg)
 		return true;
 
-	if (cfs_rq->avg.util_avg)
+	if (cfs_rq->pelt.util_avg)
 		return true;
 
 	return false;
@@ -9835,7 +9835,7 @@ static void update_cfs_rq_h_load(struct cfs_rq *cfs_rq)
 
 	while ((se = READ_ONCE(cfs_rq->h_load_next)) != NULL) {
 		load = cfs_rq->h_load;
-		load = div64_ul(load * se->avg.load_avg,
+		load = div64_ul(load * se->pelt.load_avg,
 			cfs_rq_load_avg(cfs_rq) + 1);
 		cfs_rq = group_cfs_rq(se);
 		cfs_rq->h_load = load;
@@ -9848,7 +9848,7 @@ static unsigned long task_h_load(struct task_struct *p)
 	struct cfs_rq *cfs_rq = task_cfs_rq(p);
 
 	update_cfs_rq_h_load(cfs_rq);
-	return div64_ul(p->se.avg.load_avg * cfs_rq->h_load,
+	return div64_ul(p->se.pelt.load_avg * cfs_rq->h_load,
 			cfs_rq_load_avg(cfs_rq) + 1);
 }
 #else
@@ -9866,7 +9866,7 @@ static bool __update_blocked_fair(struct rq *rq, bool *done)
 
 static unsigned long task_h_load(struct task_struct *p)
 {
-	return p->se.avg.load_avg;
+	return p->se.pelt.load_avg;
 }
 #endif
 
@@ -9963,7 +9963,7 @@ static unsigned long scale_rt_capacity(int cpu)
 		return 1;
 
 	/*
-	 * avg_rt.util_avg and avg_dl.util_avg track binary signals
+	 * pelt_rt.util_avg and pelt_dl.util_avg track binary signals
 	 * (running and not running) with weights 0 and 1024 respectively.
 	 */
 	used = cpu_util_rt(rq);
@@ -10602,7 +10602,7 @@ struct sg_lb_stats;
 static unsigned int task_running_on_cpu(int cpu, struct task_struct *p)
 {
 	/* Task has no contribution or is new */
-	if (cpu != task_cpu(p) || !READ_ONCE(p->se.avg.last_update_time))
+	if (cpu != task_cpu(p) || !READ_ONCE(p->se.pelt.last_update_time))
 		return 0;
 
 	if (task_on_rq_queued(p))
@@ -13178,7 +13178,7 @@ static void detach_entity_cfs_rq(struct sched_entity *se)
 	 * - A task which has been woken up by try_to_wake_up() but is
 	 *   waiting for actually being woken up by sched_ttwu_pending().
 	 */
-	if (!se->avg.last_update_time)
+	if (!se->pelt.last_update_time)
 		return;
 #endif
 
@@ -13309,7 +13309,7 @@ static void task_change_group_fair(struct task_struct *p)
 
 #ifdef CONFIG_SMP
 	/* Tell se's cfs_rq has been changed -- migrated */
-	p->se.avg.last_update_time = 0;
+	p->se.pelt.last_update_time = 0;
 #endif
 	set_task_rq(p, task_cpu(p));
 	attach_task_cfs_rq(p);
@@ -13360,7 +13360,7 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 
 		init_cfs_rq(cfs_rq);
 		init_tg_cfs_entry(tg, cfs_rq, se, i, parent->se[i]);
-		init_entity_runnable_average(se);
+		init_entity_pelt(se);
 	}
 
 	return 1;
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index e395d77a4c13..22fc855a1405 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -99,23 +99,23 @@ static u32 __accumulate_pelt_segments(u64 periods, u32 d1, u32 d3)
  *                     n=1
  */
 static __always_inline u32
-accumulate_sum(u64 delta, struct sched_avg *sa,
+accumulate_sum(u64 delta, struct sched_pelt *pelt,
 	       unsigned long load, unsigned long runnable, int running)
 {
 	u32 contrib = (u32)delta; /* p == 0 -> delta < 1024 */
 	u64 periods;
 
-	delta += sa->period_contrib;
+	delta += pelt->period_contrib;
 	periods = delta / 1024; /* A period is 1024us (~1ms) */
 
 	/*
 	 * Step 1: decay old *_sum if we crossed period boundaries.
 	 */
 	if (periods) {
-		sa->load_sum = decay_load(sa->load_sum, periods);
-		sa->runnable_sum =
-			decay_load(sa->runnable_sum, periods);
-		sa->util_sum = decay_load((u64)(sa->util_sum), periods);
+		pelt->load_sum = decay_load(pelt->load_sum, periods);
+		pelt->runnable_sum =
+			decay_load(pelt->runnable_sum, periods);
+		pelt->util_sum = decay_load((u64)(pelt->util_sum), periods);
 
 		/*
 		 * Step 2
@@ -133,17 +133,17 @@ accumulate_sum(u64 delta, struct sched_avg *sa,
 			 * so no point in calculating it.
 			 */
 			contrib = __accumulate_pelt_segments(periods,
-					1024 - sa->period_contrib, delta);
+					1024 - pelt->period_contrib, delta);
 		}
 	}
-	sa->period_contrib = delta;
+	pelt->period_contrib = delta;
 
 	if (load)
-		sa->load_sum += load * contrib;
+		pelt->load_sum += load * contrib;
 	if (runnable)
-		sa->runnable_sum += runnable * contrib << SCHED_CAPACITY_SHIFT;
+		pelt->runnable_sum += runnable * contrib << SCHED_CAPACITY_SHIFT;
 	if (running)
-		sa->util_sum += contrib << SCHED_CAPACITY_SHIFT;
+		pelt->util_sum += contrib << SCHED_CAPACITY_SHIFT;
 
 	return periods;
 }
@@ -177,18 +177,18 @@ accumulate_sum(u64 delta, struct sched_avg *sa,
  *            = u_0 + u_1*y + u_2*y^2 + ... [re-labeling u_i --> u_{i+1}]
  */
 static __always_inline int
-___update_load_sum(u64 now, struct sched_avg *sa,
+___update_load_sum(u64 now, struct sched_pelt *pelt,
 		  unsigned long load, unsigned long runnable, int running)
 {
 	u64 delta;
 
-	delta = now - sa->last_update_time;
+	delta = now - pelt->last_update_time;
 	/*
 	 * This should only happen when time goes backwards, which it
 	 * unfortunately does during sched clock init when we swap over to TSC.
 	 */
 	if ((s64)delta < 0) {
-		sa->last_update_time = now;
+		pelt->last_update_time = now;
 		return 0;
 	}
 
@@ -200,7 +200,7 @@ ___update_load_sum(u64 now, struct sched_avg *sa,
 	if (!delta)
 		return 0;
 
-	sa->last_update_time += delta << 10;
+	pelt->last_update_time += delta << 10;
 
 	/*
 	 * running is a subset of runnable (weight) so running can't be set if
@@ -223,7 +223,7 @@ ___update_load_sum(u64 now, struct sched_avg *sa,
 	 * Step 1: accumulate *_sum since last_update_time. If we haven't
 	 * crossed period boundaries, finish.
 	 */
-	if (!accumulate_sum(delta, sa, load, runnable, running))
+	if (!accumulate_sum(delta, pelt, load, runnable, running))
 		return 0;
 
 	return 1;
@@ -238,11 +238,11 @@ ___update_load_sum(u64 now, struct sched_avg *sa,
  * The max value of *_sum varies with the position in the time segment and is
  * equals to :
  *
- *   LOAD_AVG_MAX*y + sa->period_contrib
+ *   LOAD_AVG_MAX*y + pelt->period_contrib
  *
  * which can be simplified into:
  *
- *   LOAD_AVG_MAX - 1024 + sa->period_contrib
+ *   LOAD_AVG_MAX - 1024 + pelt->period_contrib
  *
  * because LOAD_AVG_MAX*y == LOAD_AVG_MAX-1024
  *
@@ -254,16 +254,16 @@ ___update_load_sum(u64 now, struct sched_avg *sa,
  * if it's more convenient.
  */
 static __always_inline void
-___update_load_avg(struct sched_avg *sa, unsigned long load)
+___update_load_avg(struct sched_pelt *pelt, unsigned long load)
 {
-	u32 divider = get_pelt_divider(sa);
+	u32 divider = get_pelt_divider(pelt);
 
 	/*
 	 * Step 2: update *_avg.
 	 */
-	sa->load_avg = div_u64(load * sa->load_sum, divider);
-	sa->runnable_avg = div_u64(sa->runnable_sum, divider);
-	WRITE_ONCE(sa->util_avg, sa->util_sum / divider);
+	pelt->load_avg = div_u64(load * pelt->load_sum, divider);
+	pelt->runnable_avg = div_u64(pelt->runnable_sum, divider);
+	WRITE_ONCE(pelt->util_avg, pelt->util_sum / divider);
 }
 
 /*
@@ -285,17 +285,17 @@ ___update_load_avg(struct sched_avg *sa, unsigned long load)
  *
  * cfq_rq:
  *
- *   runnable_sum = \Sum se->avg.runnable_sum
- *   runnable_avg = \Sum se->avg.runnable_avg
+ *   runnable_sum = \Sum se->pelt.runnable_sum
+ *   runnable_avg = \Sum se->pelt.runnable_avg
  *
- *   load_sum = \Sum se_weight(se) * se->avg.load_sum
- *   load_avg = \Sum se->avg.load_avg
+ *   load_sum = \Sum se_weight(se) * se->pelt.load_sum
+ *   load_avg = \Sum se->pelt.load_avg
  */
 
 int __update_load_avg_blocked_se(u64 now, struct sched_entity *se)
 {
-	if (___update_load_sum(now, &se->avg, 0, 0, 0)) {
-		___update_load_avg(&se->avg, se_weight(se));
+	if (___update_load_sum(now, &se->pelt, 0, 0, 0)) {
+		___update_load_avg(&se->pelt, se_weight(se));
 		trace_pelt_se_tp(se);
 		return 1;
 	}
@@ -305,11 +305,11 @@ int __update_load_avg_blocked_se(u64 now, struct sched_entity *se)
 
 int __update_load_avg_se(u64 now, struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	if (___update_load_sum(now, &se->avg, !!se->on_rq, se_runnable(se),
+	if (___update_load_sum(now, &se->pelt, !!se->on_rq, se_runnable(se),
 				cfs_rq->curr == se)) {
 
-		___update_load_avg(&se->avg, se_weight(se));
-		cfs_se_util_change(&se->avg);
+		___update_load_avg(&se->pelt, se_weight(se));
+		cfs_se_util_change(&se->pelt);
 		trace_pelt_se_tp(se);
 		return 1;
 	}
@@ -319,12 +319,12 @@ int __update_load_avg_se(u64 now, struct cfs_rq *cfs_rq, struct sched_entity *se
 
 int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq)
 {
-	if (___update_load_sum(now, &cfs_rq->avg,
+	if (___update_load_sum(now, &cfs_rq->pelt,
 				scale_load_down(cfs_rq->lw.weight),
 				cfs_rq->h_nr_runnable,
 				cfs_rq->curr != NULL)) {
 
-		___update_load_avg(&cfs_rq->avg, 1);
+		___update_load_avg(&cfs_rq->pelt, 1);
 		trace_pelt_cfs_tp(cfs_rq);
 		return 1;
 	}
@@ -335,7 +335,7 @@ int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq)
 /*
  * rt_rq:
  *
- *   util_sum = \Sum se->avg.util_sum but se->avg.util_sum is not tracked
+ *   util_sum = \Sum se->pelt.util_sum but se->pelt.util_sum is not tracked
  *   util_sum = cpu_scale * load_sum
  *   runnable_sum = util_sum
  *
@@ -345,12 +345,12 @@ int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq)
 
 int update_rt_rq_load_avg(u64 now, struct rq *rq, int running)
 {
-	if (___update_load_sum(now, &rq->avg_rt,
+	if (___update_load_sum(now, &rq->pelt_rt,
 				running,
 				running,
 				running)) {
 
-		___update_load_avg(&rq->avg_rt, 1);
+		___update_load_avg(&rq->pelt_rt, 1);
 		trace_pelt_rt_tp(rq);
 		return 1;
 	}
@@ -361,7 +361,7 @@ int update_rt_rq_load_avg(u64 now, struct rq *rq, int running)
 /*
  * dl_rq:
  *
- *   util_sum = \Sum se->avg.util_sum but se->avg.util_sum is not tracked
+ *   util_sum = \Sum se->pelt.util_sum but se->pelt.util_sum is not tracked
  *   util_sum = cpu_scale * load_sum
  *   runnable_sum = util_sum
  *
@@ -371,12 +371,12 @@ int update_rt_rq_load_avg(u64 now, struct rq *rq, int running)
 
 int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
 {
-	if (___update_load_sum(now, &rq->avg_dl,
+	if (___update_load_sum(now, &rq->pelt_dl,
 				running,
 				running,
 				running)) {
 
-		___update_load_avg(&rq->avg_dl, 1);
+		___update_load_avg(&rq->pelt_dl, 1);
 		trace_pelt_dl_tp(rq);
 		return 1;
 	}
@@ -388,7 +388,7 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
 /*
  * hardware:
  *
- *   load_sum = \Sum se->avg.load_sum but se->avg.load_sum is not tracked
+ *   load_sum = \Sum se->pelt.load_sum but se->pelt.load_sum is not tracked
  *
  *   util_avg and runnable_load_avg are not supported and meaningless.
  *
@@ -402,11 +402,11 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
 
 int update_hw_load_avg(u64 now, struct rq *rq, u64 capacity)
 {
-	if (___update_load_sum(now, &rq->avg_hw,
+	if (___update_load_sum(now, &rq->pelt_hw,
 			       capacity,
 			       capacity,
 			       capacity)) {
-		___update_load_avg(&rq->avg_hw, 1);
+		___update_load_avg(&rq->pelt_hw, 1);
 		trace_pelt_hw_tp(rq);
 		return 1;
 	}
@@ -419,7 +419,7 @@ int update_hw_load_avg(u64 now, struct rq *rq, u64 capacity)
 /*
  * IRQ:
  *
- *   util_sum = \Sum se->avg.util_sum but se->avg.util_sum is not tracked
+ *   util_sum = \Sum se->pelt.util_sum but se->pelt.util_sum is not tracked
  *   util_sum = cpu_scale * load_sum
  *   runnable_sum = util_sum
  *
@@ -450,17 +450,17 @@ int update_irq_load_avg(struct rq *rq, u64 running)
 	 * We can safely remove running from rq->clock because
 	 * rq->clock += delta with delta >= running
 	 */
-	ret = ___update_load_sum(rq->clock - running, &rq->avg_irq,
+	ret = ___update_load_sum(rq->clock - running, &rq->pelt_irq,
 				0,
 				0,
 				0);
-	ret += ___update_load_sum(rq->clock, &rq->avg_irq,
+	ret += ___update_load_sum(rq->clock, &rq->pelt_irq,
 				1,
 				1,
 				1);
 
 	if (ret) {
-		___update_load_avg(&rq->avg_irq, 1);
+		___update_load_avg(&rq->pelt_irq, 1);
 		trace_pelt_irq_tp(rq);
 	}
 
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index f4f6a0875c66..6a2bbcbafd2d 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -13,7 +13,7 @@ int update_hw_load_avg(u64 now, struct rq *rq, u64 capacity);
 
 static inline u64 hw_load_avg(struct rq *rq)
 {
-	return READ_ONCE(rq->avg_hw.load_avg);
+	return READ_ONCE(rq->pelt_hw.load_avg);
 }
 #else
 static inline int
@@ -40,12 +40,12 @@ update_irq_load_avg(struct rq *rq, u64 running)
 
 #define PELT_MIN_DIVIDER	(LOAD_AVG_MAX - 1024)
 
-static inline u32 get_pelt_divider(struct sched_avg *avg)
+static inline u32 get_pelt_divider(struct sched_pelt *avg)
 {
 	return PELT_MIN_DIVIDER + avg->period_contrib;
 }
 
-static inline void cfs_se_util_change(struct sched_avg *avg)
+static inline void cfs_se_util_change(struct sched_pelt *avg)
 {
 	unsigned int enqueued;
 
@@ -126,7 +126,7 @@ static inline void update_rq_clock_pelt(struct rq *rq, s64 delta)
  * When rq becomes idle, we have to check if it has lost idle time
  * because it was fully busy. A rq is fully used when the /Sum util_sum
  * is greater or equal to:
- * (LOAD_AVG_MAX - 1024 + rq->cfs.avg.period_contrib) << SCHED_CAPACITY_SHIFT;
+ * (LOAD_AVG_MAX - 1024 + rq->cfs.pelt.period_contrib) << SCHED_CAPACITY_SHIFT;
  * For optimization and computing rounding purpose, we don't take into account
  * the position in the current window (period_contrib) and we use the higher
  * bound of util_sum to decide.
@@ -134,9 +134,9 @@ static inline void update_rq_clock_pelt(struct rq *rq, s64 delta)
 static inline void update_idle_rq_clock_pelt(struct rq *rq)
 {
 	u32 divider = ((LOAD_AVG_MAX - 1024) << SCHED_CAPACITY_SHIFT) - LOAD_AVG_MAX;
-	u32 util_sum = rq->cfs.avg.util_sum;
-	util_sum += rq->avg_rt.util_sum;
-	util_sum += rq->avg_dl.util_sum;
+	u32 util_sum = rq->cfs.pelt.util_sum;
+	util_sum += rq->pelt_rt.util_sum;
+	util_sum += rq->pelt_dl.util_sum;
 
 	/*
 	 * Reflecting stolen time makes sense only if the idle
@@ -232,5 +232,3 @@ update_idle_rq_clock_pelt(struct rq *rq) { }
 
 static inline void update_idle_cfs_rq_clock_pelt(struct cfs_rq *cfs_rq) { }
 #endif
-
-
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 4b8e33c615b1..55b6f93ab12f 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2454,7 +2454,7 @@ void __init init_sched_rt_class(void)
 static void switched_to_rt(struct rq *rq, struct task_struct *p)
 {
 	/*
-	 * If we are running, update the avg_rt tracking, as the running time
+	 * If we are running, update the pelt_rt tracking, as the running time
 	 * will now on be accounted into the latter.
 	 */
 	if (task_current(rq, p)) {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1012ee420208..1c64615a1619 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -677,7 +677,7 @@ struct cfs_rq {
 	/*
 	 * CFS load tracking
 	 */
-	struct sched_avg	avg;
+	struct sched_pelt	pelt;
 #ifndef CONFIG_64BIT
 	u64			last_update_time_copy;
 #endif
@@ -1213,13 +1213,13 @@ struct rq {
 
 	struct list_head cfs_tasks;
 
-	struct sched_avg	avg_rt;
-	struct sched_avg	avg_dl;
+	struct sched_pelt	pelt_rt;
+	struct sched_pelt	pelt_dl;
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
-	struct sched_avg	avg_irq;
+	struct sched_pelt	pelt_irq;
 #endif
 #ifdef CONFIG_SCHED_HW_PRESSURE
-	struct sched_avg	avg_hw;
+	struct sched_pelt	pelt_hw;
 #endif
 	u64			idle_stamp;
 	u64			avg_idle;
@@ -2732,7 +2732,7 @@ extern void init_dl_entity(struct sched_dl_entity *dl_se);
 
 extern unsigned long to_ratio(u64 period, u64 runtime);
 
-extern void init_entity_runnable_average(struct sched_entity *se);
+extern void init_entity_pelt(struct sched_entity *se);
 extern void post_init_entity_util_avg(struct task_struct *p);
 
 #ifdef CONFIG_NO_HZ_FULL
@@ -3374,7 +3374,7 @@ static inline unsigned long cpu_bw_dl(struct rq *rq)
 
 static inline unsigned long cpu_util_dl(struct rq *rq)
 {
-	return READ_ONCE(rq->avg_dl.util_avg);
+	return READ_ONCE(rq->pelt_dl.util_avg);
 }
 
 
@@ -3383,7 +3383,7 @@ extern unsigned long cpu_util_cfs_boost(int cpu);
 
 static inline unsigned long cpu_util_rt(struct rq *rq)
 {
-	return READ_ONCE(rq->avg_rt.util_avg);
+	return READ_ONCE(rq->pelt_rt.util_avg);
 }
 
 #else /* !CONFIG_SMP */
@@ -3511,7 +3511,7 @@ static inline bool uclamp_rq_is_idle(struct rq *rq)
 
 static inline unsigned long cpu_util_irq(struct rq *rq)
 {
-	return READ_ONCE(rq->avg_irq.util_avg);
+	return READ_ONCE(rq->pelt_irq.util_avg);
 }
 
 static inline
-- 
2.43.0

