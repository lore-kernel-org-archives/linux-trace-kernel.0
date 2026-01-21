Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA371FA272;
	Wed, 21 Jan 2026 01:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768957702; cv=none; b=KZf8uUdXPlD9Bgaux/brW2lGQJqrPpAqOHc8JConDfpOglB3PP7rZsKQUZuxj9saEMm+MEP0cS+QEX5PqZSZOhiVzm3fLxki8hqwUnI1sPFadpVjKHQMddsaYG2Lruu/aLwnxSbX84sGhghzMdb5JJcmk30jQUFRFeGo1f17i3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768957702; c=relaxed/simple;
	bh=t+qvd1UC4H2Y/ZgfxViM8hAMUzWAceSDjbK5hRJzSYA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=clGQkW4GcqsxWksiLIGEX4BLi4BxwIsWoa7Zmiuq+KsKXba6Db7BoE45Y1L9CuX4hy2bq4AFGS+pS85Xw/t57v5o6dYEhhBXMOgWdD+lfjCTp3d7/BqiZx6xHW5czj1vqm8NUT/jG6hAhO2UvyTUjmOPYtaLMJJkjGOiV5oCJak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nExVMOL1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nExVMOL1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92AD1C16AAE;
	Wed, 21 Jan 2026 01:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768957702;
	bh=t+qvd1UC4H2Y/ZgfxViM8hAMUzWAceSDjbK5hRJzSYA=;
	h=From:To:Cc:Subject:Date:From;
	b=nExVMOL18K+VCOwhXpWFBeQ8rxtM4Vfl6jztVkwYhO3Cw33hpMh8qTgWri3hRU2aM
	 nQ9MbexOF1Um16c3G9Qjk+j3WnxKStdtujgK6LY7FCOwRl/VbVwCGYw2KImW8sMwrz
	 daVdZXFISlAfIWEooojdVn1Pjd/Yd22PdahBLGKkYpYuKuVr+wc075g4KTOLGbFZeU
	 iwqYpKP9aTsiUpWJhHDAjOf5ImNaw9r4QhgQ3FbyUhkf9Ym7mdaAdTog9I9BOzJu3g
	 ZJRZFKfGW5Qr9oBos7NVpDNnNh8FUTuKO1gTRODP08FFAoh4TgfzRDGxAtxhOzkqZF
	 q3HRGxQjRrA8g==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Naveen N Rao <naveen@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3] kprobes: Use dedicated kthread for kprobe optimizer
Date: Wed, 21 Jan 2026 10:08:18 +0900
Message-ID: <176895769808.68134.3333703656952897053.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
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

Instead of using generic workqueue, use a dedicated kthread for optimizing
kprobes, because it can wait (sleep) for a long time inside the process
by synchronize_rcu_task(). This means other works can be stopped until it
finishes.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v3:
  - Wait events in interruptible state for avoiding hung_task.
 Changes in v2:
  - Make the kthread unfreezable same as workqueue.
  - Add kthread_should_stop() check right before calling optimizer too.
  - Initialize optimizer_state to OPTIMIZER_ST_IDLE instead of 0.
---
 kernel/kprobes.c |  106 ++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 86 insertions(+), 20 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index ab8f9fc1f0d1..71e8d6e81eee 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -32,6 +32,7 @@
 #include <linux/debugfs.h>
 #include <linux/sysctl.h>
 #include <linux/kdebug.h>
+#include <linux/kthread.h>
 #include <linux/memory.h>
 #include <linux/ftrace.h>
 #include <linux/cpu.h>
@@ -40,6 +41,7 @@
 #include <linux/perf_event.h>
 #include <linux/execmem.h>
 #include <linux/cleanup.h>
+#include <linux/wait.h>
 
 #include <asm/sections.h>
 #include <asm/cacheflush.h>
@@ -514,8 +516,17 @@ static LIST_HEAD(optimizing_list);
 static LIST_HEAD(unoptimizing_list);
 static LIST_HEAD(freeing_list);
 
-static void kprobe_optimizer(struct work_struct *work);
-static DECLARE_DELAYED_WORK(optimizing_work, kprobe_optimizer);
+static struct task_struct *kprobe_optimizer_task;
+static wait_queue_head_t kprobe_optimizer_wait;
+static atomic_t optimizer_state;
+enum {
+	OPTIMIZER_ST_IDLE = 0,
+	OPTIMIZER_ST_KICKED = 1,
+	OPTIMIZER_ST_FLUSHING = 2,
+};
+
+static DECLARE_COMPLETION(optimizer_completion);
+
 #define OPTIMIZE_DELAY 5
 
 /*
@@ -597,14 +608,10 @@ static void do_free_cleaned_kprobes(void)
 	}
 }
 
-/* Start optimizer after OPTIMIZE_DELAY passed */
-static void kick_kprobe_optimizer(void)
-{
-	schedule_delayed_work(&optimizing_work, OPTIMIZE_DELAY);
-}
+static void kick_kprobe_optimizer(void);
 
 /* Kprobe jump optimizer */
-static void kprobe_optimizer(struct work_struct *work)
+static void kprobe_optimizer(void)
 {
 	guard(mutex)(&kprobe_mutex);
 
@@ -635,9 +642,53 @@ static void kprobe_optimizer(struct work_struct *work)
 		do_free_cleaned_kprobes();
 	}
 
-	/* Step 5: Kick optimizer again if needed */
+	/* Step 5: Kick optimizer again if needed. But if there is a flush requested, */
+	if (completion_done(&optimizer_completion))
+		complete(&optimizer_completion);
+
 	if (!list_empty(&optimizing_list) || !list_empty(&unoptimizing_list))
-		kick_kprobe_optimizer();
+		kick_kprobe_optimizer();	/*normal kick*/
+}
+
+static int kprobe_optimizer_thread(void *data)
+{
+	while (!kthread_should_stop()) {
+		/* To avoid hung_task, wait in interruptible state. */
+		wait_event_interruptible(kprobe_optimizer_wait,
+			   atomic_read(&optimizer_state) != OPTIMIZER_ST_IDLE ||
+			   kthread_should_stop());
+
+		if (kthread_should_stop())
+			break;
+
+		/*
+		 * If it was a normal kick, wait for OPTIMIZE_DELAY.
+		 * This wait can be interrupted by a flush request.
+		 */
+		if (atomic_read(&optimizer_state) == 1)
+			wait_event_interruptible_timeout(
+				kprobe_optimizer_wait,
+				atomic_read(&optimizer_state) == OPTIMIZER_ST_FLUSHING ||
+				kthread_should_stop(),
+				OPTIMIZE_DELAY);
+
+		if (kthread_should_stop())
+			break;
+
+		atomic_set(&optimizer_state, OPTIMIZER_ST_IDLE);
+
+		kprobe_optimizer();
+	}
+	return 0;
+}
+
+/* Start optimizer after OPTIMIZE_DELAY passed */
+static void kick_kprobe_optimizer(void)
+{
+	lockdep_assert_held(&kprobe_mutex);
+	if (atomic_cmpxchg(&optimizer_state,
+		OPTIMIZER_ST_IDLE, OPTIMIZER_ST_KICKED) == OPTIMIZER_ST_IDLE)
+		wake_up(&kprobe_optimizer_wait);
 }
 
 static void wait_for_kprobe_optimizer_locked(void)
@@ -645,13 +696,17 @@ static void wait_for_kprobe_optimizer_locked(void)
 	lockdep_assert_held(&kprobe_mutex);
 
 	while (!list_empty(&optimizing_list) || !list_empty(&unoptimizing_list)) {
-		mutex_unlock(&kprobe_mutex);
-
-		/* This will also make 'optimizing_work' execute immmediately */
-		flush_delayed_work(&optimizing_work);
-		/* 'optimizing_work' might not have been queued yet, relax */
-		cpu_relax();
+		init_completion(&optimizer_completion);
+		/*
+		 * Set state to OPTIMIZER_ST_FLUSHING and wake up the thread if it's
+		 * idle. If it's already kicked, it will see the state change.
+		 */
+		if (atomic_xchg_acquire(&optimizer_state,
+			OPTIMIZER_ST_FLUSHING) != OPTIMIZER_ST_FLUSHING)
+			wake_up(&kprobe_optimizer_wait);
 
+		mutex_unlock(&kprobe_mutex);
+		wait_for_completion(&optimizer_completion);
 		mutex_lock(&kprobe_mutex);
 	}
 }
@@ -1010,8 +1065,21 @@ static void __disarm_kprobe(struct kprobe *p, bool reopt)
 	 */
 }
 
+static void __init init_optprobe(void)
+{
+#ifdef __ARCH_WANT_KPROBES_INSN_SLOT
+	/* Init 'kprobe_optinsn_slots' for allocation */
+	kprobe_optinsn_slots.insn_size = MAX_OPTINSN_SIZE;
+#endif
+
+	init_waitqueue_head(&kprobe_optimizer_wait);
+	atomic_set(&optimizer_state, OPTIMIZER_ST_IDLE);
+	kprobe_optimizer_task = kthread_run(kprobe_optimizer_thread, NULL,
+					    "kprobe-optimizer");
+}
 #else /* !CONFIG_OPTPROBES */
 
+#define init_optprobe()				do {} while (0)
 #define optimize_kprobe(p)			do {} while (0)
 #define unoptimize_kprobe(p, f)			do {} while (0)
 #define kill_optimized_kprobe(p)		do {} while (0)
@@ -2694,10 +2762,8 @@ static int __init init_kprobes(void)
 	/* By default, kprobes are armed */
 	kprobes_all_disarmed = false;
 
-#if defined(CONFIG_OPTPROBES) && defined(__ARCH_WANT_KPROBES_INSN_SLOT)
-	/* Init 'kprobe_optinsn_slots' for allocation */
-	kprobe_optinsn_slots.insn_size = MAX_OPTINSN_SIZE;
-#endif
+	/* Initialize the optimization infrastructure */
+	init_optprobe();
 
 	err = arch_init_kprobes();
 	if (!err)

