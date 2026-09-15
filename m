Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6316949E5E6
	for <linux-trace-kernel@vger.kernel.org>; Tue, 15 Sep 2026 13:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789478284; cv=none; b=YdQRvPvFzsdR9B8pH/c7chFaoZMQMieY0QfUUDJkuNq4YNvgEOdMhuZrP/7n6uNrasNuLIUqaXrTPoig860SwyhxRlXtthb2r7aBJOhMp34Sc+y/K46o70UG41bCRL2IQLvFqiO8RnzQ99mK3CMlmNNgeXrzbTg04fvcpgXh34s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789478284; c=relaxed/simple;
	bh=TXFGxaV6JtFDo/uJzdvTZ+O6U4MOxiEs7Jz7Lihg/aQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cAXk8oxrbDFOihtbJc9kQ0jL8Iz9K3rVD5L/zJqhs5zPQVRw/FmGsJsXJ1ryQIdd3HbqYAZiGg4w2Sk4nJHQLe9wkw48i95howzS+0SK3GBVMQ58AUSMpiaX9lnaTjz/C0BSYBgJQTSoEFC1stE+PfOSb2ECV0r9EsViTogWTLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=bRSWL12x; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="bRSWL12x"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93910ad2273so338683885a.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 15 Sep 2026 06:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789478280; x=1790083080; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BZpG8a4K/YgKhJUrG5n9/0zVHbEqV2OSxLbwC0u3TSA=;
        b=bRSWL12x+A+rTMxJhSViwhc3RRPmXEOL33ALQt8rbeHDX6Le2oyRBpkQnx70vVuzAR
         jLxmtX2glQ9zH2fD/5p5AYGmXsW5AIEVr5zvFqSbJamelMfs1s2ylM5RJTGnwsSAH91o
         EA5NMiKVZWdMqy6UMpYVww50/7Cq7W8xuR+7lXTEmFTHO2HT8PAF/g3IyzDt0CoaFu9d
         uuxtm4YfQYPrR4++fJnzKbDO8T8zfHeui3cxVgo/tHOVYRfrE5mALr/FNM8GPyx5W0ou
         G3/1zF+/L41pfToSshsmMSClirkaJPUZmwVRwPqsDTzK1OMEOcL0u2bbmu/OwqICLFmL
         secw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789478280; x=1790083080;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BZpG8a4K/YgKhJUrG5n9/0zVHbEqV2OSxLbwC0u3TSA=;
        b=B0r32EcudfdzIJagLeczcUoZqCx9JUdsfECkY3xIOIpsr+PzSzfAk8I27oQ+yDuDgF
         +SeaAm793nDRiyC3Ma0F9ZFYlHqrlwG08ok2bdf3rdrVEmKdRFX6BKEfmxAZGmnKdiVX
         BNVBxUDu9etA3PxstoTybuTSGSaL+km4KC0B/7ETHx/FKOj5UvQu82mdoP+O++oydAJN
         WVJeiBMU+ZU+fl/xR48yvbwggFA2JIJMEGH/SwzfAzBUalC6H/Et8Y/PRDTecCn0sS5r
         Q8LHC0BOQmovVUfytEp1LrhnNdGcMFg4H3Y6m7hjRuCRBn7uy8T8mReM35bhZ2AfR4Dv
         1SXQ==
X-Forwarded-Encrypted: i=1; AKwUvBwNzaJudFLsw+aMrZpj82w2v1WLj8ObmzBYUc1DZdEjMm9HoJCqTHT8f/5NMnx1eovrUwRkM63Ehp19sK50+ne+kts=@vger.kernel.org
X-Gm-Message-State: AFuF++khRPZtpix4SFasZrPd1Boyl0N170t1wrj1Z/tODvV25xqtdCcR
	HrlUU+44F9JzKAEJ3M9goNwHYSwvVSVjCARNXhvT0CUHS2tV1CQqGGmuAVKjaJ2rs34=
X-Gm-Gg: AYBFou174LLB6ZnC/zCMYvTaTl42jIHnBu/gc/hXyeVOdv/+WoYRKZvPB5K83ukf8qS
	V/dAF+dnryIbOXiE4d5P2vyN8SpcWk2DFUypWRUY0ZTiq+TmIGl+czehjAAN75Hk5MAEAuTAVln
	H2Se0iKTdUyeVmA6M3QPfsFtztF07J0AFpKsDTQBMjuvkR2JL5NfkBurU5VE7SqrW2u0O1pMMVp
	zbx4pUWhsDg9+quvEwqypUt/D1psYGPky5aGwhSSVwxCyN5QehVTl7O2zlmHa5RCsaJC5InQ2po
	GmgpMxBEIEIe2gtMbl3RaLxtKky+yaxcH+UZbm6fYA5C4OzVMb8W4zyB/MWa+2zi100A4RV9UwO
	G3HUBWjoVl3FWgiiMStLxnYClNaqcq0K4GieKGzdHDiVusP7PvpTQPlSIIMiyCOsuflquSQnGRw
	E6L3QqxlcTjqt438RYfpY9F1ZUX9w0Adm1V0f0z6Nx731UvCGfszjErdR9y5uL/B+MJfzgvwTnM
	KE+SjmBAGJZbH1Bz7xO53dhxwbkcNQehLTOw1GlMEDI/tFK9X8t3/Sm
X-Received: by 2002:a05:620a:1b98:b0:93a:1092:48fa with SMTP id af79cd13be357-93a297e91bemr9631785a.4.1789478278679;
        Tue, 15 Sep 2026 06:17:58 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e86b7424sm1246377685a.32.2026.09.15.06.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 06:17:58 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 15 Sep 2026 13:17:33 +0000
Subject: [PATCH RFC v3 06/13] bpf: Take a Tasks Trace reader in the
 trampoline glue
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-b4-rcu-tasks-preempt-qs-v3-6-0ad30c4c5ee7@toxicpanda.com>
References: <20260915-b4-rcu-tasks-preempt-qs-v3-0-0ad30c4c5ee7@toxicpanda.com>
In-Reply-To: <20260915-b4-rcu-tasks-preempt-qs-v3-0-0ad30c4c5ee7@toxicpanda.com>
To: "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Boqun Feng <boqun@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
 Xu Kuohai <xukuohai@huaweicloud.com>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Boqun Feng <boqun@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
 Xu Kuohai <xukuohai@huaweicloud.com>
Cc: Andy Lutomirski <luto@kernel.org>, 
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Juergen Gross <jgross@suse.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, linux-kernel@vger.kernel.org, 
 rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 xen-devel@lists.xenproject.org, Andy Lutomirski <luto@kernel.org>, 
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Juergen Gross <jgross@suse.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, linux-kernel@vger.kernel.org, 
 rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 xen-devel@lists.xenproject.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1789478262; l=11875;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=TXFGxaV6JtFDo/uJzdvTZ+O6U4MOxiEs7Jz7Lihg/aQ=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QMNOzSXH+MqwbhPyhl85UFDH60OjviU5by15ukzOGqWorm6a0N96E9GIqZviv+bWi33vuGmPHvW
 FnOzjv4m5SQI=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

On CONFIG_TASKS_RCU_TRAMPOLINE_READERS kernels Tasks RCU keeps a BPF
trampoline image allocated only while a task using it is a Tasks Trace
RCU reader or is executing text that rcu_tasks_trampoline_text()
recognises.  The image itself is such text, but from it we call C glue
in core kernel text -- __bpf_prog_enter*(), __bpf_prog_exit*(),
__bpf_tramp_enter() and __bpf_tramp_exit() -- and today only the
sleepable variants take rcu_read_lock_trace().

Rather than add anything to the JIT-emitted trampolines, close the gap
in the glue: place all of it in .text..rcu_tramp via __rcu_trampoline so
that a task interrupted in its prologue or epilogue is treated like one
interrupted in the image, have every enter helper take
rcu_read_lock_trace() before anything that could run out of line and
every exit helper drop it last, and bracket the percpu_ref get and put
in __bpf_tramp_enter()/__bpf_tramp_exit() the same way (the percpu_ref
continues to cover the call to the original function).  From the
image's call to the glue's return the task is then always either in
recognised text or a reader.  The extra reader is compiled out on other
configurations, and the sleepable paths are unchanged.

bpf_tramp_image_put()'s call_rcu_tasks() stages are what now wait for
those readers and for tasks interrupted in the image's own instructions.
For images that call the original function nothing else changes: the
percpu_ref pins the image from __bpf_tramp_enter() to __bpf_tramp_exit(),
so only the instructions before and after need the grace periods they
already get.  A fentry-only image has no percpu_ref, and with one
reader per prog a task walks reader, image, reader, image...; one grace
period only guarantees such a task has left the reader or gap it was in
when the grace period began, so on these kernels the fentry-only
teardown requeues itself for one Tasks RCU grace period per prog
(im->nr_progs, recorded when the image is built) before freeing.  That
costs nothing on the call path and a few more asynchronous grace
periods on detach.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/bpf.h     |   1 +
 kernel/bpf/trampoline.c | 107 +++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 85 insertions(+), 23 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e57af902560c..b97ad80aacae 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1366,6 +1366,7 @@ enum bpf_tramp_prog_type {
 struct bpf_tramp_image {
 	void *image;
 	int size;
+	int nr_progs;		/* see bpf_tramp_image_put() */
 	struct bpf_ksym ksym;
 	struct percpu_ref pcref;
 	void *ip_after_call;
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 90b70ea0d370..dbbc9bd7fd22 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -601,12 +601,25 @@ static void __bpf_tramp_image_put_rcu_tasks(struct rcu_head *rcu)
 	struct bpf_tramp_image *im;
 
 	im = container_of(rcu, struct bpf_tramp_image, rcu);
-	if (im->ip_after_call)
+	if (im->ip_after_call) {
 		/* the case of fmod_ret/fexit trampoline and CONFIG_PREEMPTION=y */
 		percpu_ref_kill(&im->pcref);
-	else
+	} else if (IS_ENABLED(CONFIG_TASKS_RCU_TRAMPOLINE_READERS) &&
+		   --im->nr_progs > 0) {
+		/*
+		 * fentry-only trampoline on a reader-marked Tasks RCU: each prog
+		 * runs in its own Tasks Trace reader with a few image
+		 * instructions in between, and one rcu tasks grace period only
+		 * guarantees that a task has moved on from the reader (or gap) it
+		 * was in when the grace period started.  A task walking the image
+		 * therefore needs one grace period per prog before the image can
+		 * go; keep requeueing until we have had that many.
+		 */
+		call_rcu_tasks(&im->rcu, __bpf_tramp_image_put_rcu_tasks);
+	} else {
 		/* the case of fentry trampoline */
 		call_rcu_tasks(&im->rcu, __bpf_tramp_image_put_rcu);
+	}
 }
 
 static void bpf_tramp_image_put(struct bpf_tramp_image *im)
@@ -619,6 +632,14 @@ static void bpf_tramp_image_put(struct bpf_tramp_image *im)
 	 * (which are few asm insns before __bpf_tramp_enter and
 	 *  after __bpf_tramp_exit)
 	 *
+	 * With CONFIG_TASKS_RCU_TRAMPOLINE_READERS, rcu tasks waits for a task
+	 * in those asm insns because they are trampoline text, and for a task
+	 * inside the glue or a prog because the glue makes it a
+	 * rcu_read_lock_trace reader.  The percpu_ref case is otherwise
+	 * unchanged; the fentry-only case, having no percpu_ref across the
+	 * whole image, takes one rcu tasks grace period per prog, see
+	 * __bpf_tramp_image_put_rcu_tasks().
+	 *
 	 * The trampoline is unreachable before bpf_tramp_image_put().
 	 *
 	 * First, patch the trampoline to avoid calling into fexit progs.
@@ -776,6 +797,7 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 		err = PTR_ERR(im);
 		goto out;
 	}
+	im->nr_progs = total;
 
 	err = arch_prepare_bpf_trampoline(im, im->image, im->image + size,
 					  &tr->func.model, tr->flags, tnodes,
@@ -1285,9 +1307,34 @@ static __always_inline u64 notrace bpf_prog_start_time(void)
  * [2..MAX_U64] - execute bpf prog and record execution time.
  *     This is start time.
  */
-static u64 notrace __bpf_prog_enter_recur(struct bpf_prog *prog, struct bpf_tramp_run_ctx *run_ctx)
+/*
+ * Where Tasks RCU is built on reader-marked trampolines
+ * (CONFIG_TASKS_RCU_TRAMPOLINE_READERS), the trampoline image that called the
+ * glue below stays allocated only while the task is a Tasks Trace RCU reader
+ * or is executing text that rcu_tasks_trampoline_text() recognises: the image
+ * itself, or this glue, which is therefore placed in .text..rcu_tramp
+ * (__rcu_trampoline).  Each enter helper takes the reader before anything
+ * that could run out of line and each exit helper drops it last, so from the
+ * image's call to the glue's return the task is always one or the other.  The
+ * sleepable variants already are such readers for their own reasons.
+ */
+static __always_inline void bpf_tramp_read_lock_trace(void)
+{
+	if (IS_ENABLED(CONFIG_TASKS_RCU_TRAMPOLINE_READERS))
+		rcu_read_lock_trace();
+}
+
+static __always_inline void bpf_tramp_read_unlock_trace(void)
+{
+	if (IS_ENABLED(CONFIG_TASKS_RCU_TRAMPOLINE_READERS))
+		rcu_read_unlock_trace();
+}
+
+static u64 notrace __rcu_trampoline
+__bpf_prog_enter_recur(struct bpf_prog *prog, struct bpf_tramp_run_ctx *run_ctx)
 	__acquires(RCU)
 {
+	bpf_tramp_read_lock_trace();
 	rcu_read_lock_dont_migrate();
 
 	run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx);
@@ -1329,8 +1376,8 @@ static __always_inline void notrace update_prog_stats(struct bpf_prog *prog,
 		__update_prog_stats(prog, start);
 }
 
-static void notrace __bpf_prog_exit_recur(struct bpf_prog *prog, u64 start,
-					  struct bpf_tramp_run_ctx *run_ctx)
+static void notrace __rcu_trampoline
+__bpf_prog_exit_recur(struct bpf_prog *prog, u64 start, struct bpf_tramp_run_ctx *run_ctx)
 	__releases(RCU)
 {
 	bpf_reset_run_ctx(run_ctx->saved_run_ctx);
@@ -1338,15 +1385,17 @@ static void notrace __bpf_prog_exit_recur(struct bpf_prog *prog, u64 start,
 	update_prog_stats(prog, start);
 	bpf_prog_put_recursion_context(prog);
 	rcu_read_unlock_migrate();
+	bpf_tramp_read_unlock_trace();
 }
 
-static u64 notrace __bpf_prog_enter_lsm_cgroup(struct bpf_prog *prog,
-					       struct bpf_tramp_run_ctx *run_ctx)
+static u64 notrace __rcu_trampoline
+__bpf_prog_enter_lsm_cgroup(struct bpf_prog *prog, struct bpf_tramp_run_ctx *run_ctx)
 	__acquires(RCU)
 {
 	/* Runtime stats are exported via actual BPF_LSM_CGROUP
 	 * programs, not the shims.
 	 */
+	bpf_tramp_read_lock_trace();
 	rcu_read_lock_dont_migrate();
 
 	run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx);
@@ -1354,17 +1403,18 @@ static u64 notrace __bpf_prog_enter_lsm_cgroup(struct bpf_prog *prog,
 	return NO_START_TIME;
 }
 
-static void notrace __bpf_prog_exit_lsm_cgroup(struct bpf_prog *prog, u64 start,
-					       struct bpf_tramp_run_ctx *run_ctx)
+static void notrace __rcu_trampoline
+__bpf_prog_exit_lsm_cgroup(struct bpf_prog *prog, u64 start, struct bpf_tramp_run_ctx *run_ctx)
 	__releases(RCU)
 {
 	bpf_reset_run_ctx(run_ctx->saved_run_ctx);
 
 	rcu_read_unlock_migrate();
+	bpf_tramp_read_unlock_trace();
 }
 
-u64 notrace __bpf_prog_enter_sleepable_recur(struct bpf_prog *prog,
-					     struct bpf_tramp_run_ctx *run_ctx)
+u64 notrace __rcu_trampoline
+__bpf_prog_enter_sleepable_recur(struct bpf_prog *prog, struct bpf_tramp_run_ctx *run_ctx)
 {
 	rcu_read_lock_trace();
 	migrate_disable();
@@ -1381,8 +1431,9 @@ u64 notrace __bpf_prog_enter_sleepable_recur(struct bpf_prog *prog,
 	return bpf_prog_start_time();
 }
 
-void notrace __bpf_prog_exit_sleepable_recur(struct bpf_prog *prog, u64 start,
-					     struct bpf_tramp_run_ctx *run_ctx)
+void notrace __rcu_trampoline
+__bpf_prog_exit_sleepable_recur(struct bpf_prog *prog, u64 start,
+				struct bpf_tramp_run_ctx *run_ctx)
 {
 	bpf_reset_run_ctx(run_ctx->saved_run_ctx);
 
@@ -1392,8 +1443,8 @@ void notrace __bpf_prog_exit_sleepable_recur(struct bpf_prog *prog, u64 start,
 	rcu_read_unlock_trace();
 }
 
-static u64 notrace __bpf_prog_enter_sleepable(struct bpf_prog *prog,
-					      struct bpf_tramp_run_ctx *run_ctx)
+static u64 notrace __rcu_trampoline
+__bpf_prog_enter_sleepable(struct bpf_prog *prog, struct bpf_tramp_run_ctx *run_ctx)
 {
 	rcu_read_lock_trace();
 	migrate_disable();
@@ -1404,8 +1455,8 @@ static u64 notrace __bpf_prog_enter_sleepable(struct bpf_prog *prog,
 	return bpf_prog_start_time();
 }
 
-static void notrace __bpf_prog_exit_sleepable(struct bpf_prog *prog, u64 start,
-					      struct bpf_tramp_run_ctx *run_ctx)
+static void notrace __rcu_trampoline
+__bpf_prog_exit_sleepable(struct bpf_prog *prog, u64 start, struct bpf_tramp_run_ctx *run_ctx)
 {
 	bpf_reset_run_ctx(run_ctx->saved_run_ctx);
 
@@ -1414,10 +1465,11 @@ static void notrace __bpf_prog_exit_sleepable(struct bpf_prog *prog, u64 start,
 	rcu_read_unlock_trace();
 }
 
-static u64 notrace __bpf_prog_enter(struct bpf_prog *prog,
-				    struct bpf_tramp_run_ctx *run_ctx)
+static u64 notrace __rcu_trampoline
+__bpf_prog_enter(struct bpf_prog *prog, struct bpf_tramp_run_ctx *run_ctx)
 	__acquires(RCU)
 {
+	bpf_tramp_read_lock_trace();
 	rcu_read_lock_dont_migrate();
 
 	run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx);
@@ -1425,24 +1477,33 @@ static u64 notrace __bpf_prog_enter(struct bpf_prog *prog,
 	return bpf_prog_start_time();
 }
 
-static void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start,
-				    struct bpf_tramp_run_ctx *run_ctx)
+static void notrace __rcu_trampoline
+__bpf_prog_exit(struct bpf_prog *prog, u64 start, struct bpf_tramp_run_ctx *run_ctx)
 	__releases(RCU)
 {
 	bpf_reset_run_ctx(run_ctx->saved_run_ctx);
 
 	update_prog_stats(prog, start);
 	rcu_read_unlock_migrate();
+	bpf_tramp_read_unlock_trace();
 }
 
-void notrace __bpf_tramp_enter(struct bpf_tramp_image *tr)
+/*
+ * The percpu_ref keeps the image alive across the call to the original
+ * function; the reader only has to cover getting and putting it, see above.
+ */
+void notrace __rcu_trampoline __bpf_tramp_enter(struct bpf_tramp_image *tr)
 {
+	bpf_tramp_read_lock_trace();
 	percpu_ref_get(&tr->pcref);
+	bpf_tramp_read_unlock_trace();
 }
 
-void notrace __bpf_tramp_exit(struct bpf_tramp_image *tr)
+void notrace __rcu_trampoline __bpf_tramp_exit(struct bpf_tramp_image *tr)
 {
+	bpf_tramp_read_lock_trace();
 	percpu_ref_put(&tr->pcref);
+	bpf_tramp_read_unlock_trace();
 }
 
 bpf_trampoline_enter_t bpf_trampoline_enter(const struct bpf_prog *prog)

-- 
2.55.0

