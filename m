Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A62438737A
	for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Sep 2026 02:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790044451; cv=none; b=pZmOH6+muKZkZ8WpXWPNl4urTxS0yZGWECezZ1f5Ki6HsWBcqlFA6G1c/btTus+xGajUdkfm2OnozZ0UMZpNQbsVhoBF7pidTYlOVGsiglPcXvuvIMa2kZI2qx+2FofXqRM2QPoCFOBY642Sd585ZUGcSvqcEl9MofJjaDi9mTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790044451; c=relaxed/simple;
	bh=EMsOGg9VRxBcocei3P3dGUkU8foVu6cO35v23va9IOs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LuSScAWyskN8ChugKjXnok6D8dVDbM+BLvs2z0wcz6I4H1Ur67gPvSZ2hxH8sIEEJLesi+amXBXCk84n9/812HTRApQHfYKrb4we/sGo3ZXlzUF7U9YkTZnxOoLVeoenXRURNqffC0GB3Uaj+AM3lC+i5kEKQ4Yl8Mo5EE28WXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=gxu6iCps; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="gxu6iCps"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-9104e54b1abso49337426d6.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Sep 2026 19:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1790044448; x=1790649248; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vixDe7y/8fdtCmwAQ+Tlt/gsuGiEiA9j8JVU0h22FWI=;
        b=gxu6iCpsUuLPXgYUiCTsOhdCO0oUcbJMBjMPpP+jv0eOHhhCXhGwUeIs2HbNQ20DHx
         74qKmviwa3RDrCJ7/9SzC3LYu0B9qZiq+5geSmAmd1lXncRixovrhMmqKpR0VohQ1W0Q
         jTaNOe2nZxjJVrveqr8GHCCcHdZWmjGs5eqXGSVA08vZ/Cy4PVwRnkqczI8d4de7SEBh
         PIl1D3KJ8rVTur1Y2QIIEAXJZviOyS0YuCtPLU/DFmzblAiFHYxUvd3ejTUgCcd4nLFr
         qGMy8pp96s6aeeS5/W0b4ATIkBgLliiR2U1+mMJ7ruU1y5jxhOgCgcRf219wL53YetDD
         dafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790044448; x=1790649248;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vixDe7y/8fdtCmwAQ+Tlt/gsuGiEiA9j8JVU0h22FWI=;
        b=mY46T9MU6LW8AUg/SBQnwroD9bklfHaVfVgpYBk87HihM0Lh9RIpHF11z9cptAtd/H
         SAu47UVXrVOxYgmEWFdbBVODIJc+hvjs568t3h1wouY9SuoieXeql/KBlnxj4erm8++x
         k4rIy1TklaZdCLuczsscOpy15EvyLWIqaBzwRR/2jZjVwuFkq6K6Zmxxg84S1kjj4TOa
         0T4lOf6MmNTLFH4wT1g8rYdU1fr8wQnvdNrUZmRcs8jA869pBbS5a12KOsNiyiwMEedt
         02SmFQuAorNFjdhJL7oaCX8W3Ym70CCDh8joPOHa6ADCYvJTB+tlr7SZ8DzSCpnllRHU
         T9rg==
X-Forwarded-Encrypted: i=1; AKwUvBwHp6thlk4IRj074IF7QLFjjNfSfrG4dqgOVse2/iv7FBLbS3QzGxh2kYQuGIpELvJNCJZ8cVXAfKU2Om2+Uj4rYWI=@vger.kernel.org
X-Gm-Message-State: AFuF++n3crKsKJWRJjyCRXlOga6lNBbefh6arthFKImDoZ62nh87wxG2
	9gkJNlibV7qBOvGAvxmTHYy52vKeEu5qRW+Ld/pGv1zKMpGWHB6T5Z1ZeZxz30MfZCA=
X-Gm-Gg: AYBFou11qbz0EYxT6/9t72G1rfz0p1Y+5FKSoAlTmhk9TP3Eff2eX0GgxSp4kQgexBZ
	Sd7faANFbhFKrAszC3YKWEu5LKZNgfLN9x+KFt391gP6/9fq7ymKoDEOhxOA/emGK+DZZDBDT4l
	Q681D2UnOp0GV/g+qjO67MGXMWgKcBDHDHGEULu0RN0rOewlFKQ3TCE4UNaMZxOqHEBsK9hu8KW
	bsI8lu16ZdEOhYNqKYSLS2X8bUxTtYJjY3AQmiEYfypSL3NyXiP4Ig2pZQTx11mTEZGd9cE3tIF
	re8XRw1RBi3ssjLMUEo/0YP9L9ZVj335LkjRODmKHL1RMcDkU2FTX7kVFENP+9vNptriU6Eakp2
	bsH6qI4dXiEpDCcFyYUKbR24OtxXMp8EU0iiEeVKJE2dqHkz6EtGuu8J6pg5CLwvFFvmT404aaw
	XnxIwxN3X0oFtS9LdT6O5JuLl4zXGEDCWXchP2+9JZp4QHdtVfNj/kybyqDEy5QQ/FbbofGWmCO
	aK6cw6nGFql41o=
X-Received: by 2002:a05:6214:1304:b0:90e:9875:b48c with SMTP id 6a1803df08f44-913fc8b1f2dmr34711036d6.12.1790044448184;
        Mon, 21 Sep 2026 19:34:08 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9140250b82asm4582396d6.39.2026.09.21.19.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 19:34:07 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 22 Sep 2026 02:23:31 +0000
Subject: [PATCH v5 12/13] rcu-tasks-trace: Assert no reader is held on
 return to userspace
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-b4-rcu-tasks-preempt-qs-v5-12-410f57770bad@toxicpanda.com>
References: <20260922-b4-rcu-tasks-preempt-qs-v5-0-410f57770bad@toxicpanda.com>
In-Reply-To: <20260922-b4-rcu-tasks-preempt-qs-v5-0-410f57770bad@toxicpanda.com>
To: "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: Boqun Feng <boqun@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
 Thomas Gleixner <tglx@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
 rcu@vger.kernel.org, bpf@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1790043820; l=2581;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=EMsOGg9VRxBcocei3P3dGUkU8foVu6cO35v23va9IOs=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLzeLb/2gtbRDPx3ssZtnGVRsANVTMmhDuPYTamLR1rD3jjMOpYIakVJmblm2P6SqGgYyithDIa
 ERiWg9/irxQs=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

With trampolines now taking rcu_read_lock_trace() open-coded from
assembly and JIT-emitted code, an unbalanced reader would silently
turn every later Tasks Trace grace period on that task into a stall.
No task can legitimately reach userspace with current->trc_reader_nesting
non-zero, so under CONFIG_PROVE_RCU check it in the generic entry
code's return-to-user validation, next to the existing kmap and lockdep
assertions.  Compiles away otherwise.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/irq-entry-common.h | 2 ++
 include/linux/rcupdate_trace.h   | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-common.h
index e19b41ee6b18..d42568a488a7 100644
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -5,6 +5,7 @@
 #include <linux/context_tracking.h>
 #include <linux/hrtimer_rearm.h>
 #include <linux/kmsan.h>
+#include <linux/rcupdate_trace.h>
 #include <linux/rseq_entry.h>
 #include <linux/static_call_types.h>
 #include <linux/syscalls.h>
@@ -214,6 +215,7 @@ static __always_inline void __exit_to_user_mode_validate(void)
 {
 	/* Ensure that kernel state is sane for a return to userspace */
 	kmap_assert_nomap();
+	rcu_tasks_trace_assert_idle();
 	lockdep_assert_irqs_disabled();
 	lockdep_sys_exit();
 }
diff --git a/include/linux/rcupdate_trace.h b/include/linux/rcupdate_trace.h
index dcdb11643496..9eb7f92c710b 100644
--- a/include/linux/rcupdate_trace.h
+++ b/include/linux/rcupdate_trace.h
@@ -217,6 +217,12 @@ unsigned long rcu_tasks_trace_batches_completed(void);
 // Placeholders to enable stepwise transition.
 void __init rcu_tasks_trace_suppress_unused(void);
 
+/* A task must never reach userspace inside an rcu_read_lock_trace() reader. */
+static inline void rcu_tasks_trace_assert_idle(void)
+{
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && READ_ONCE(current->trc_reader_nesting));
+}
+
 #else
 static inline unsigned long rcu_tasks_trace_batches_completed(void) { return 0; }
 /*
@@ -226,6 +232,7 @@ static inline unsigned long rcu_tasks_trace_batches_completed(void) { return 0;
 static inline void call_rcu_tasks_trace(struct rcu_head *rhp, rcu_callback_t func) { BUG(); }
 static inline void rcu_read_lock_trace(void) { BUG(); }
 static inline void rcu_read_unlock_trace(void) { BUG(); }
+static inline void rcu_tasks_trace_assert_idle(void) { }
 #endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
 
 DEFINE_LOCK_GUARD_0(rcu_tasks_trace,

-- 
2.55.0

