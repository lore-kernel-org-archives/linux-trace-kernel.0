Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0FE1FCFD2;
	Wed, 19 Feb 2025 18:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739989257; cv=none; b=XHbAAyhhwExqtkeN5X8GPcRyJcAUvhaRIQdK6LQXQ7Cr4o5z/hMs1Vx57jHpiGellNCVOWTZqFQ7653rOqS0HnUoo74ItamCrgEdkUqGcrhvbNghaG1YIAnbH5LXQp0DLlGbgxFoEzfaZLpA8QNLNte74xu3cZ/JBasYfzrwSro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739989257; c=relaxed/simple;
	bh=rQ8bcokXMUsT0O26l4C05hk4Nq6bD2AfFqSydoUZ4+4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PeabEnm8Tipb1IC7dau3JbJiK5D3Fay09j+aGu1jXWOzKTBrbrxmEfJOTrUj7au8cnVPUhXJCCq5/SFaoG2heko02MJYzYfKFiC2ZxQKuMS8bqHtte7cHlxV4ryTKaIWTwSvqoJA2us3sUiRWHcJlzQydbtqjBzmxnCwYMqZwKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KD0qxJYJ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KD0qxJYJ"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-220d601886fso386725ad.1;
        Wed, 19 Feb 2025 10:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739989254; x=1740594054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5p2EDPD2hrOilPBaJ5g109213F21yai5E/clxIpda/0=;
        b=KD0qxJYJO66J0X7BBE0WnAM5kMytuu4bSGK8uWec2c4lTnXoy7i2dd6jkKNVIPioTz
         nmqhq72nFlgcac3HnDU2S/s2Nor5lHLUnwwn7jFuVAu9cCIs8uyea5xqetj0yeUqWgpd
         LW517WYY9n/lblt8H+kTPWFxMkyFqX5vEBEuTJyb6zUa2TNmBuLSmdKzeysi59KMCbBT
         gbfnaJbDGEg0K9Kr1zu2JysEH6/HE5woAjg7E9ehlXSSFk810O1/ra3j72txpJWzPtD2
         /GiqcVJS1iMikmXjOIYH+besE3BC5QXBRV+yozV/JE6DCxKnLxCpBVdlccPuO3TIJi5z
         PpbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739989254; x=1740594054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5p2EDPD2hrOilPBaJ5g109213F21yai5E/clxIpda/0=;
        b=Bhyl8kofw4ZkTOgCFTqsM+/vjjDnbuvzuHdD42GwMt1ebxpSX6nvDYQ7B5Wn/jtngz
         VxsfcVMhxPy0o14z3y/BhXZSO7XLj2fFKAB2uVvHmNQv5250Vy81lhGpF4RPeU6CboYU
         5M/fudp0Uezyc5/ZaOkvFlGpmtyLM6hbaIm0+F0rH3d2PXp9HHFGqMo0dJiq6CADetVV
         F8MIP1aNzWe1RTS52NQMCWKn1rtI4UCc3gT3TOlvwx6ow4HBZHEfg/nugP9YXwu4i6v1
         CVTNakOAbdKP+FuDDu61rTOd2qTxve5RSukFejjp5wa/q5Kk6brY46ZwQhdxocZtfnsk
         cgGw==
X-Forwarded-Encrypted: i=1; AJvYcCVMqtbuX0nyvPswAv9BhUOWqVdh+M91v8rMsa3vgNGYyHX22y0wAnksauTMSyBCwMSKBFGHfTeym5klVmu3@vger.kernel.org, AJvYcCWyJF1RVkH6as07EhhKuTLtKntoom8f29tbj/jyeMgEcYUdxFAPt5LpjfWnOflZYcMVAqYw5pDn7nEQqPH2JPojMrou@vger.kernel.org, AJvYcCX9JiAmHlSqRM2xnSOPnJ3zZ7V1loTEl6kRLlZaA8RB2FG7gXnqejKD2zVnCwdaSURsTMvRCD3fLjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvFdX+9lxebMNLNWBz7zpnJEkk+CyVKMeonFfrzvtjHjYrGCX/
	fxoOJL00OWJoxbA7uKqZHZ2aiYhv/+5i+gfP0HDPq8RzZGRtd4Tn
X-Gm-Gg: ASbGncuquR3Yi1ePRZm5BPQ81l179LywbuVbhYV4/m0NP/sh97sarzsK6EgVrDPjfM1
	PCU1Z6t+mUnR8A7FkBFBmNTccQe3xaX0mLr2IA23y3YLu5bLbSMf0pzJtR+xLzEhll0iOja2TR6
	bmah1mEzbxdWueUPTzjGbtiI5uMbBbEJBjcqHTR+L//brI+8n3fiB97Ytbi8tIy5YuBGoPQ4WTD
	qUitICk9ZGJaN9iYPAT6Pj6WCLrRBuKlWgCS/IMo9IP4+BfwOyq0UiP5opuPkWNbvgktm54wU89
	2BuPFamWxyBD8A==
X-Google-Smtp-Source: AGHT+IEZVlp725qKRCRsgSqazV7Pq14zs5C77m0E2s4jzHatpHhNEkG/H3io/MVYTIELzC3rxlG4LA==
X-Received: by 2002:a05:6a20:6a0b:b0:1e1:b883:3c56 with SMTP id adf61e73a8af0-1ee8cb86923mr31070762637.23.1739989253999;
        Wed, 19 Feb 2025 10:20:53 -0800 (PST)
Received: from jemmy.. ([47.116.124.190])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ade083277b3sm7753218a12.27.2025.02.19.10.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 10:20:53 -0800 (PST)
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
Subject: [PATCH 1/2] sched: Refine scheduler naming for clarity and specificity
Date: Thu, 20 Feb 2025 02:20:19 +0800
Message-ID: <20250219182020.393006-2-jemmywong512@gmail.com>
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

- Rename ttwu_do_wakeup to ttwu_set_running:
    - This function only sets task state to TASK_RUNNING,
        not performing the actual wakeup.

- Rename update_cfs_group to update_cfs_group_shares:
    - The name was too generic; specifying shares clarifies its purpose.

- Rename place_entity to update_entity_sched:
    - The function does not handle entity placement but updates
        sched info: vruntime, slice, and deadline.

- Rename update_load_<set, add, sub> to load_weight_<set, add, sub>:
    - load can refer to either PELT load or load weight, causing ambiguity;
        load_weight specifies it's dealing with weight.

Signed-off-by: Jemmy Wong <jemmywong512@gmail.com>
---
 Documentation/trace/ftrace.rst | 190 ++++++++++++++++-----------------
 include/linux/sched.h          |   2 +-
 kernel/sched/core.c            |  16 +--
 kernel/sched/debug.c           |   6 +-
 kernel/sched/fair.c            | 144 ++++++++++++-------------
 kernel/sched/pelt.c            |   6 +-
 kernel/sched/sched.h           |   4 +-
 7 files changed, 184 insertions(+), 184 deletions(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 2b74f96d09d5..f75f38856cbe 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -986,14 +986,14 @@ why a latency happened. Here is a typical trace::
   #  => ended at:   _raw_spin_unlock_irqrestore
   #
   #
-  #                  _------=> CPU#
-  #                 / _-----=> irqs-off
-  #                | / _----=> need-resched
-  #                || / _---=> hardirq/softirq
-  #                ||| / _--=> preempt-depth
-  #                |||| /     delay
-  #  cmd     pid   ||||| time  |   caller
-  #     \   /      |||||  \    |   /
+  #                  _------=> CPU#
+  #                 / _-----=> irqs-off
+  #                | / _----=> need-resched
+  #                || / _---=> hardirq/softirq
+  #                ||| / _--=> preempt-depth
+  #                |||| /     delay
+  #  cmd     pid   ||||| time  |   caller
+  #     \   /      |||||  \    |   /
         ps-6143    2d...    0us!: trace_hardirqs_off <-__lock_task_sighand
         ps-6143    2d..1  259us+: trace_hardirqs_on <-_raw_spin_unlock_irqrestore
         ps-6143    2d..1  263us+: time_hardirqs_on <-_raw_spin_unlock_irqrestore
@@ -1490,14 +1490,14 @@ an example::
   #  => ended at:   run_timer_softirq
   #
   #
-  #                  _------=> CPU#
-  #                 / _-----=> irqs-off
-  #                | / _----=> need-resched
-  #                || / _---=> hardirq/softirq
-  #                ||| / _--=> preempt-depth
-  #                |||| /     delay
-  #  cmd     pid   ||||| time  |   caller
-  #     \   /      |||||  \    |   /
+  #                  _------=> CPU#
+  #                 / _-----=> irqs-off
+  #                | / _----=> need-resched
+  #                || / _---=> hardirq/softirq
+  #                ||| / _--=> preempt-depth
+  #                |||| /     delay
+  #  cmd     pid   ||||| time  |   caller
+  #     \   /      |||||  \    |   /
     <idle>-0       0d.s2    0us+: _raw_spin_lock_irq <-run_timer_softirq
     <idle>-0       0dNs3   17us : _raw_spin_unlock_irq <-run_timer_softirq
     <idle>-0       0dNs3   17us+: trace_hardirqs_on <-run_timer_softirq
@@ -1541,14 +1541,14 @@ function-trace, we get a much larger output::
   #  => ended at:   ata_scsi_queuecmd
   #
   #
-  #                  _------=> CPU#
-  #                 / _-----=> irqs-off
-  #                | / _----=> need-resched
-  #                || / _---=> hardirq/softirq
-  #                ||| / _--=> preempt-depth
-  #                |||| /     delay
-  #  cmd     pid   ||||| time  |   caller
-  #     \   /      |||||  \    |   /
+  #                  _------=> CPU#
+  #                 / _-----=> irqs-off
+  #                | / _----=> need-resched
+  #                || / _---=> hardirq/softirq
+  #                ||| / _--=> preempt-depth
+  #                |||| /     delay
+  #  cmd     pid   ||||| time  |   caller
+  #     \   /      |||||  \    |   /
       bash-2042    3d...    0us : _raw_spin_lock_irqsave <-ata_scsi_queuecmd
       bash-2042    3d...    0us : add_preempt_count <-_raw_spin_lock_irqsave
       bash-2042    3d..1    1us : ata_scsi_find_dev <-ata_scsi_queuecmd
@@ -1689,14 +1689,14 @@ is much like the irqsoff tracer.
   #  => ended at:   do_IRQ
   #
   #
-  #                  _------=> CPU#
-  #                 / _-----=> irqs-off
-  #                | / _----=> need-resched
-  #                || / _---=> hardirq/softirq
-  #                ||| / _--=> preempt-depth
-  #                |||| /     delay
-  #  cmd     pid   ||||| time  |   caller
-  #     \   /      |||||  \    |   /
+  #                  _------=> CPU#
+  #                 / _-----=> irqs-off
+  #                | / _----=> need-resched
+  #                || / _---=> hardirq/softirq
+  #                ||| / _--=> preempt-depth
+  #                |||| /     delay
+  #  cmd     pid   ||||| time  |   caller
+  #     \   /      |||||  \    |   /
       sshd-1991    1d.h.    0us+: irq_enter <-do_IRQ
       sshd-1991    1d..1   46us : irq_exit <-do_IRQ
       sshd-1991    1d..1   47us+: trace_preempt_on <-do_IRQ
@@ -1727,14 +1727,14 @@ was over.
   #  => ended at:   task_rq_unlock
   #
   #
-  #                  _------=> CPU#
-  #                 / _-----=> irqs-off
-  #                | / _----=> need-resched
-  #                || / _---=> hardirq/softirq
-  #                ||| / _--=> preempt-depth
-  #                |||| /     delay
-  #  cmd     pid   ||||| time  |   caller
-  #     \   /      |||||  \    |   /
+  #                  _------=> CPU#
+  #                 / _-----=> irqs-off
+  #                | / _----=> need-resched
+  #                || / _---=> hardirq/softirq
+  #                ||| / _--=> preempt-depth
+  #                |||| /     delay
+  #  cmd     pid   ||||| time  |   caller
+  #     \   /      |||||  \    |   /
       bash-1994    1d..1    0us : _raw_spin_lock_irqsave <-wake_up_new_task
       bash-1994    1d..1    0us : select_task_rq_fair <-select_task_rq
       bash-1994    1d..1    1us : __rcu_read_lock <-select_task_rq_fair
@@ -1841,14 +1841,14 @@ tracers.
   #  => ended at:   ata_scsi_queuecmd
   #
   #
-  #                  _------=> CPU#
-  #                 / _-----=> irqs-off
-  #                | / _----=> need-resched
-  #                || / _---=> hardirq/softirq
-  #                ||| / _--=> preempt-depth
-  #                |||| /     delay
-  #  cmd     pid   ||||| time  |   caller
-  #     \   /      |||||  \    |   /
+  #                  _------=> CPU#
+  #                 / _-----=> irqs-off
+  #                | / _----=> need-resched
+  #                || / _---=> hardirq/softirq
+  #                ||| / _--=> preempt-depth
+  #                |||| /     delay
+  #  cmd     pid   ||||| time  |   caller
+  #     \   /      |||||  \    |   /
         ls-2230    3d...    0us+: _raw_spin_lock_irqsave <-ata_scsi_queuecmd
         ls-2230    3...1  100us : _raw_spin_unlock_irqrestore <-ata_scsi_queuecmd
         ls-2230    3...1  101us+: trace_preempt_on <-ata_scsi_queuecmd
@@ -1894,14 +1894,14 @@ Here is a trace with function-trace set::
   #  => ended at:   mutex_unlock
   #
   #
-  #                  _------=> CPU#
-  #                 / _-----=> irqs-off
-  #                | / _----=> need-resched
-  #                || / _---=> hardirq/softirq
-  #                ||| / _--=> preempt-depth
-  #                |||| /     delay
-  #  cmd     pid   ||||| time  |   caller
-  #     \   /      |||||  \    |   /
+  #                  _------=> CPU#
+  #                 / _-----=> irqs-off
+  #                | / _----=> need-resched
+  #                || / _---=> hardirq/softirq
+  #                ||| / _--=> preempt-depth
+  #                |||| /     delay
+  #  cmd     pid   ||||| time  |   caller
+  #     \   /      |||||  \    |   /
   kworker/-59      3...1    0us : __schedule <-schedule
   kworker/-59      3d..1    0us : rcu_preempt_qs <-rcu_note_context_switch
   kworker/-59      3d..1    1us : add_preempt_count <-_raw_spin_lock_irq
@@ -1987,7 +1987,7 @@ wakeup
 One common case that people are interested in tracing is the
 time it takes for a task that is woken to actually wake up.
 Now for non Real-Time tasks, this can be arbitrary. But tracing
-it nonetheless can be interesting.
+it nonetheless can be interesting.

 Without function tracing::

@@ -2007,14 +2007,14 @@ Without function tracing::
   #    | task: kworker/3:1H-312 (uid:0 nice:-20 policy:0 rt_prio:0)
   #    -----------------
   #
-  #                  _------=> CPU#
-  #                 / _-----=> irqs-off
-  #                | / _----=> need-resched
-  #                || / _---=> hardirq/softirq
-  #                ||| / _--=> preempt-depth
-  #                |||| /     delay
-  #  cmd     pid   ||||| time  |   caller
-  #     \   /      |||||  \    |   /
+  #                  _------=> CPU#
+  #                 / _-----=> irqs-off
+  #                | / _----=> need-resched
+  #                || / _---=> hardirq/softirq
+  #                ||| / _--=> preempt-depth
+  #                |||| /     delay
+  #  cmd     pid   ||||| time  |   caller
+  #     \   /      |||||  \    |   /
     <idle>-0       3dNs7    0us :      0:120:R   + [003]   312:100:R kworker/3:1H
     <idle>-0       3dNs7    1us+: ttwu_do_activate.constprop.87 <-try_to_wake_up
     <idle>-0       3d..3   15us : __schedule <-schedule
@@ -2076,14 +2076,14 @@ Instead of performing an 'ls', we will run 'sleep 1' under
   #    | task: sleep-2389 (uid:0 nice:0 policy:1 rt_prio:5)
   #    -----------------
   #
-  #                  _------=> CPU#
-  #                 / _-----=> irqs-off
-  #                | / _----=> need-resched
-  #                || / _---=> hardirq/softirq
-  #                ||| / _--=> preempt-depth
-  #                |||| /     delay
-  #  cmd     pid   ||||| time  |   caller
-  #     \   /      |||||  \    |   /
+  #                  _------=> CPU#
+  #                 / _-----=> irqs-off
+  #                | / _----=> need-resched
+  #                || / _---=> hardirq/softirq
+  #                ||| / _--=> preempt-depth
+  #                |||| /     delay
+  #  cmd     pid   ||||| time  |   caller
+  #     \   /      |||||  \    |   /
     <idle>-0       3d.h4    0us :      0:120:R   + [003]  2389: 94:R sleep
     <idle>-0       3d.h4    1us+: ttwu_do_activate.constprop.87 <-try_to_wake_up
     <idle>-0       3d..3    5us : __schedule <-schedule
@@ -2125,19 +2125,19 @@ Doing the same with chrt -r 5 and function-trace set.
   #    | task: sleep-2448 (uid:0 nice:0 policy:1 rt_prio:5)
   #    -----------------
   #
-  #                  _------=> CPU#
-  #                 / _-----=> irqs-off
-  #                | / _----=> need-resched
-  #                || / _---=> hardirq/softirq
-  #                ||| / _--=> preempt-depth
-  #                |||| /     delay
-  #  cmd     pid   ||||| time  |   caller
-  #     \   /      |||||  \    |   /
+  #                  _------=> CPU#
+  #                 / _-----=> irqs-off
+  #                | / _----=> need-resched
+  #                || / _---=> hardirq/softirq
+  #                ||| / _--=> preempt-depth
+  #                |||| /     delay
+  #  cmd     pid   ||||| time  |   caller
+  #     \   /      |||||  \    |   /
     <idle>-0       3d.h4    1us+:      0:120:R   + [003]  2448: 94:R sleep
     <idle>-0       3d.h4    2us : ttwu_do_activate.constprop.87 <-try_to_wake_up
-    <idle>-0       3d.h3    3us : check_preempt_curr <-ttwu_do_wakeup
+    <idle>-0       3d.h3    3us : check_preempt_curr <-ttwu_set_running
     <idle>-0       3d.h3    3us : resched_curr <-check_preempt_curr
-    <idle>-0       3dNh3    4us : task_woken_rt <-ttwu_do_wakeup
+    <idle>-0       3dNh3    4us : task_woken_rt <-ttwu_set_running
     <idle>-0       3dNh3    4us : _raw_spin_unlock <-try_to_wake_up
     <idle>-0       3dNh3    4us : sub_preempt_count <-_raw_spin_unlock
     <idle>-0       3dNh2    5us : ttwu_stat <-try_to_wake_up
@@ -2251,14 +2251,14 @@ events.
   #    | task: sleep-5882 (uid:0 nice:0 policy:1 rt_prio:5)
   #    -----------------
   #
-  #                  _------=> CPU#
-  #                 / _-----=> irqs-off
-  #                | / _----=> need-resched
-  #                || / _---=> hardirq/softirq
-  #                ||| / _--=> preempt-depth
-  #                |||| /     delay
-  #  cmd     pid   ||||| time  |   caller
-  #     \   /      |||||  \    |   /
+  #                  _------=> CPU#
+  #                 / _-----=> irqs-off
+  #                | / _----=> need-resched
+  #                || / _---=> hardirq/softirq
+  #                ||| / _--=> preempt-depth
+  #                |||| /     delay
+  #  cmd     pid   ||||| time  |   caller
+  #     \   /      |||||  \    |   /
     <idle>-0       2d.h4    0us :      0:120:R   + [002]  5882: 94:R sleep
     <idle>-0       2d.h4    0us : ttwu_do_activate.constprop.87 <-try_to_wake_up
     <idle>-0       2d.h4    1us : sched_wakeup: comm=sleep pid=5882 prio=94 success=1 target_cpu=002
@@ -3470,7 +3470,7 @@ with the number of entries.
 Or simply read buffer_total_size_kb
 ::

-  # cat buffer_total_size_kb
+  # cat buffer_total_size_kb
   5632

 To modify the buffer, simple echo in a number (in 1024 byte segments).
@@ -3505,7 +3505,7 @@ at the top level will just show an X
 This is where the buffer_total_size_kb is useful:
 ::

-  # cat buffer_total_size_kb
+  # cat buffer_total_size_kb
   12916

 Writing to the top level buffer_size_kb will reset all the buffers
@@ -3568,9 +3568,9 @@ Here is an example of using the snapshot feature.
             <idle>-0     [005] d...  2440.603828: sched_switch: prev_comm=swapper/5 prev_pid=0 prev_prio=120   prev_state=R ==> next_comm=snapshot-test-2 next_pid=2242 next_prio=120
              sleep-2242  [005] d...  2440.603846: sched_switch: prev_comm=snapshot-test-2 prev_pid=2242 prev_prio=120   prev_state=R ==> next_comm=kworker/5:1 next_pid=60 next_prio=120
   [...]
-          <idle>-0     [002] d...  2440.707230: sched_switch: prev_comm=swapper/2 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=snapshot-test-2 next_pid=2229 next_prio=120
+          <idle>-0     [002] d...  2440.707230: sched_switch: prev_comm=swapper/2 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=snapshot-test-2 next_pid=2229 next_prio=120

-  # cat trace
+  # cat trace
   # tracer: nop
   #
   # entries-in-buffer/entries-written: 77/77   #P:8
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9632e3318e0d..4b3765ca3e00 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -546,7 +546,7 @@ struct sched_statistics {

 struct sched_entity {
 	/* For load-balancing: */
-	struct load_weight		load;
+	struct load_weight		lw;
 	struct rb_node			run_node;
 	u64				deadline;
 	u64				min_vruntime;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9aecd914ac69..f16f814f9e4c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -526,9 +526,9 @@ sched_core_dequeue(struct rq *rq, struct task_struct *p, int flags) { }
  *
  *  - sched_setaffinity()/
  *    set_cpus_allowed_ptr():	p->cpus_ptr, p->nr_cpus_allowed
- *  - set_user_nice():		p->se.load, p->*prio
+ *  - set_user_nice():		p->se.lw, p->*prio
  *  - __sched_setscheduler():	p->sched_class, p->policy, p->*prio,
- *				p->se.load, p->rt_priority,
+ *				p->se.lw, p->rt_priority,
  *				p->dl.dl_{runtime, deadline, period, flags, bw, density}
  *  - sched_setnuma():		p->numa_preferred_nid
  *  - sched_move_task():	p->sched_task_group
@@ -1435,7 +1435,7 @@ void set_load_weight(struct task_struct *p, bool update_load)
 	if (update_load && p->sched_class->reweight_task)
 		p->sched_class->reweight_task(task_rq(p), p, &lw);
 	else
-		p->se.load = lw;
+		p->se.lw = lw;
 }

 #ifdef CONFIG_UCLAMP_TASK
@@ -3697,7 +3697,7 @@ ttwu_stat(struct task_struct *p, int cpu, int wake_flags)
 /*
  * Mark the task runnable.
  */
-static inline void ttwu_do_wakeup(struct task_struct *p)
+static inline void ttwu_set_running(struct task_struct *p)
 {
 	WRITE_ONCE(p->__state, TASK_RUNNING);
 	trace_sched_wakeup(p);
@@ -3729,7 +3729,7 @@ ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
 	activate_task(rq, p, en_flags);
 	wakeup_preempt(rq, p, wake_flags);

-	ttwu_do_wakeup(p);
+	ttwu_set_running(p);

 #ifdef CONFIG_SMP
 	if (p->sched_class->task_woken) {
@@ -3799,7 +3799,7 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
 			 */
 			wakeup_preempt(rq, p, wake_flags);
 		}
-		ttwu_do_wakeup(p);
+		ttwu_set_running(p);
 		ret = 1;
 	}
 	__task_rq_unlock(rq, &rf);
@@ -4201,7 +4201,7 @@ int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 			goto out;

 		trace_sched_waking(p);
-		ttwu_do_wakeup(p);
+		ttwu_set_running(p);
 		goto out;
 	}

@@ -8564,7 +8564,7 @@ void __init sched_init(void)
 		 * system CPU resource is divided among the tasks of
 		 * root_task_group and its child task-groups in a fair manner,
 		 * based on each entity's (task or task-group's) weight
-		 * (se->load.weight).
+		 * (se->lw.weight).
 		 *
 		 * In other words, if root_task_group has 10 tasks of weight
 		 * 1024) and two child groups A0 and A1 (of weight 1024 each),
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index ef047add7f9e..e446c16f839e 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -683,7 +683,7 @@ static void print_cfs_group_stats(struct seq_file *m, int cpu, struct task_group
 		P_SCHEDSTAT(wait_count);
 	}

-	P(se->load.weight);
+	P(se->lw.weight);
 #ifdef CONFIG_SMP
 	P(se->avg.load_avg);
 	P(se->avg.util_avg);
@@ -847,7 +847,7 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_runnable", cfs_rq->h_nr_runnable);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_queued", cfs_rq->h_nr_queued);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_idle", cfs_rq->h_nr_idle);
-	SEQ_printf(m, "  .%-30s: %ld\n", "load", cfs_rq->load.weight);
+	SEQ_printf(m, "  .%-30s: %ld\n", "load", cfs_rq->lw.weight);
 #ifdef CONFIG_SMP
 	SEQ_printf(m, "  .%-30s: %lu\n", "load_avg",
 			cfs_rq->avg.load_avg);
@@ -1240,7 +1240,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 	__PS("nr_voluntary_switches", p->nvcsw);
 	__PS("nr_involuntary_switches", p->nivcsw);

-	P(se.load.weight);
+	P(se.lw.weight);
 #ifdef CONFIG_SMP
 	P(se.avg.load_sum);
 	P(se.avg.runnable_sum);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1c0ef435a7aa..2644d6c9234a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -164,19 +164,19 @@ static int __init sched_fair_sysctl_init(void)
 late_initcall(sched_fair_sysctl_init);
 #endif

-static inline void update_load_add(struct load_weight *lw, unsigned long inc)
+static inline void load_weight_add(struct load_weight *lw, unsigned long inc)
 {
 	lw->weight += inc;
 	lw->inv_weight = 0;
 }

-static inline void update_load_sub(struct load_weight *lw, unsigned long dec)
+static inline void load_weight_sub(struct load_weight *lw, unsigned long dec)
 {
 	lw->weight -= dec;
 	lw->inv_weight = 0;
 }

-static inline void update_load_set(struct load_weight *lw, unsigned long w)
+static inline void load_weight_set(struct load_weight *lw, unsigned long w)
 {
 	lw->weight = w;
 	lw->inv_weight = 0;
@@ -291,8 +291,8 @@ static u64 __calc_delta(u64 delta_exec, unsigned long weight, struct load_weight
  */
 static inline u64 calc_delta_fair(u64 delta, struct sched_entity *se)
 {
-	if (unlikely(se->load.weight != NICE_0_LOAD))
-		delta = __calc_delta(delta, NICE_0_LOAD, &se->load);
+	if (unlikely(se->lw.weight != NICE_0_LOAD))
+		delta = __calc_delta(delta, NICE_0_LOAD, &se->lw);

 	return delta;
 }
@@ -595,7 +595,7 @@ static inline s64 entity_key(struct cfs_rq *cfs_rq, struct sched_entity *se)
  *
  *	      V +-= lag_i / W
  *
- *	    Also see the comment in place_entity() that deals with this. ]]
+ *	    Also see the comment in update_entity_sched() that deals with this. ]]
  *
  * However, since v_i is u64, and the multiplication could easily overflow
  * transform it into a relative form that uses smaller quantities:
@@ -623,7 +623,7 @@ static inline s64 entity_key(struct cfs_rq *cfs_rq, struct sched_entity *se)
 static void
 avg_vruntime_add(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	unsigned long weight = scale_load_down(se->load.weight);
+	unsigned long weight = scale_load_down(se->lw.weight);
 	s64 key = entity_key(cfs_rq, se);

 	cfs_rq->avg_vruntime += key * weight;
@@ -633,7 +633,7 @@ avg_vruntime_add(struct cfs_rq *cfs_rq, struct sched_entity *se)
 static void
 avg_vruntime_sub(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	unsigned long weight = scale_load_down(se->load.weight);
+	unsigned long weight = scale_load_down(se->lw.weight);
 	s64 key = entity_key(cfs_rq, se);

 	cfs_rq->avg_vruntime -= key * weight;
@@ -660,7 +660,7 @@ u64 avg_vruntime(struct cfs_rq *cfs_rq)
 	long load = cfs_rq->avg_load;

 	if (curr && curr->on_rq) {
-		unsigned long weight = scale_load_down(curr->load.weight);
+		unsigned long weight = scale_load_down(curr->lw.weight);

 		avg += entity_key(cfs_rq, curr) * weight;
 		load += weight;
@@ -728,7 +728,7 @@ static int vruntime_eligible(struct cfs_rq *cfs_rq, u64 vruntime)
 	long load = cfs_rq->avg_load;

 	if (curr && curr->on_rq) {
-		unsigned long weight = scale_load_down(curr->load.weight);
+		unsigned long weight = scale_load_down(curr->lw.weight);

 		avg += entity_key(cfs_rq, curr) * weight;
 		load += weight;
@@ -1047,7 +1047,7 @@ void init_entity_runnable_average(struct sched_entity *se)
 	 * nothing has been attached to the task group yet.
 	 */
 	if (entity_is_task(se))
-		sa->load_avg = scale_load_down(se->load.weight);
+		sa->load_avg = scale_load_down(se->lw.weight);

 	/* when this task is enqueued, it will contribute to its cfs_rq's load_avg */
 }
@@ -3671,7 +3671,7 @@ static inline void update_scan_period(struct task_struct *p, int new_cpu)
 static void
 account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	update_load_add(&cfs_rq->load, se->load.weight);
+	load_weight_add(&cfs_rq->lw, se->lw.weight);
 #ifdef CONFIG_SMP
 	if (entity_is_task(se)) {
 		struct rq *rq = rq_of(cfs_rq);
@@ -3686,7 +3686,7 @@ account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 static void
 account_entity_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	update_load_sub(&cfs_rq->load, se->load.weight);
+	load_weight_sub(&cfs_rq->lw, se->lw.weight);
 #ifdef CONFIG_SMP
 	if (entity_is_task(se)) {
 		account_numa_dequeue(rq_of(cfs_rq), task_of(se));
@@ -3768,7 +3768,7 @@ static inline void
 dequeue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) { }
 #endif

-static void place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags);
+static void update_entity_sched(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags);

 static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 			    unsigned long weight)
@@ -3783,7 +3783,7 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 		se->rel_deadline = 1;
 		if (!curr)
 			__dequeue_entity(cfs_rq, se);
-		update_load_sub(&cfs_rq->load, se->load.weight);
+		load_weight_sub(&cfs_rq->lw, se->lw.weight);
 	}
 	dequeue_load_avg(cfs_rq, se);

@@ -3791,11 +3791,11 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 	 * Because we keep se->vlag = V - v_i, while: lag_i = w_i*(V - v_i),
 	 * we need to scale se->vlag when w_i changes.
 	 */
-	se->vlag = div_s64(se->vlag * se->load.weight, weight);
+	se->vlag = div_s64(se->vlag * se->lw.weight, weight);
 	if (se->rel_deadline)
-		se->deadline = div_s64(se->deadline * se->load.weight, weight);
+		se->deadline = div_s64(se->deadline * se->lw.weight, weight);

-	update_load_set(&se->load, weight);
+	load_weight_set(&se->lw, weight);

 #ifdef CONFIG_SMP
 	do {
@@ -3807,8 +3807,8 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,

 	enqueue_load_avg(cfs_rq, se);
 	if (se->on_rq) {
-		update_load_add(&cfs_rq->load, se->load.weight);
-		place_entity(cfs_rq, se, 0);
+		load_weight_add(&cfs_rq->lw, se->lw.weight);
+		update_entity_sched(cfs_rq, se, 0);
 		if (!curr)
 			__enqueue_entity(cfs_rq, se);

@@ -3828,7 +3828,7 @@ static void reweight_task_fair(struct rq *rq, struct task_struct *p,
 {
 	struct sched_entity *se = &p->se;
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
-	struct load_weight *load = &se->load;
+	struct load_weight *load = &se->lw;

 	reweight_entity(cfs_rq, se, lw->weight);
 	load->inv_weight = lw->inv_weight;
@@ -3845,9 +3845,9 @@ static inline int throttled_hierarchy(struct cfs_rq *cfs_rq);
  * That is, the weight of a group entity, is the proportional share of the
  * group weight based on the group runqueue weights. That is:
  *
- *                     tg->weight * grq->load.weight
- *   ge->load.weight = -----------------------------               (1)
- *                       \Sum grq->load.weight
+ *                     tg->weight * grq->lw.weight
+ *   ge->lw.weight = -----------------------------               (1)
+ *                       \Sum grq->lw.weight
  *
  * Now, because computing that sum is prohibitively expensive to compute (been
  * there, done that) we approximate it with this average stuff. The average
@@ -3855,12 +3855,12 @@ static inline int throttled_hierarchy(struct cfs_rq *cfs_rq);
  *
  * So instead of the above, we substitute:
  *
- *   grq->load.weight -> grq->avg.load_avg                         (2)
+ *   grq->lw.weight -> grq->avg.load_avg                         (2)
  *
  * which yields the following:
  *
  *                     tg->weight * grq->avg.load_avg
- *   ge->load.weight = ------------------------------              (3)
+ *   ge->lw.weight = ------------------------------              (3)
  *                             tg->load_avg
  *
  * Where: tg->load_avg ~= \Sum grq->avg.load_avg
@@ -3875,39 +3875,39 @@ static inline int throttled_hierarchy(struct cfs_rq *cfs_rq);
  *
  * Now, in that special case (1) reduces to:
  *
- *                     tg->weight * grq->load.weight
- *   ge->load.weight = ----------------------------- = tg->weight   (4)
- *                         grp->load.weight
+ *                     tg->weight * grq->lw.weight
+ *   ge->lw.weight = ----------------------------- = tg->weight   (4)
+ *                         grp->lw.weight
  *
  * That is, the sum collapses because all other CPUs are idle; the UP scenario.
  *
  * So what we do is modify our approximation (3) to approach (4) in the (near)
  * UP case, like:
  *
- *   ge->load.weight =
+ *   ge->lw.weight =
  *
- *              tg->weight * grq->load.weight
+ *              tg->weight * grq->lw.weight
  *     ---------------------------------------------------         (5)
- *     tg->load_avg - grq->avg.load_avg + grq->load.weight
+ *     tg->load_avg - grq->avg.load_avg + grq->lw.weight
  *
- * But because grq->load.weight can drop to 0, resulting in a divide by zero,
+ * But because grq->lw.weight can drop to 0, resulting in a divide by zero,
  * we need to use grq->avg.load_avg as its lower bound, which then gives:
  *
  *
- *                     tg->weight * grq->load.weight
- *   ge->load.weight = -----------------------------		   (6)
+ *                     tg->weight * grq->lw.weight
+ *   ge->lw.weight = -----------------------------		   		   (6)
  *                             tg_load_avg'
  *
  * Where:
  *
  *   tg_load_avg' = tg->load_avg - grq->avg.load_avg +
- *                  max(grq->load.weight, grq->avg.load_avg)
+ *                  max(grq->lw.weight, grq->avg.load_avg)
  *
  * And that is shares_weight and is icky. In the (near) UP case it approaches
  * (4) while in the normal case it approaches (3). It consistently
- * overestimates the ge->load.weight and therefore:
+ * overestimates the ge->lw.weight and therefore:
  *
- *   \Sum ge->load.weight >= tg->weight
+ *   \Sum ge->lw.weight >= tg->weight
  *
  * hence icky!
  */
@@ -3918,7 +3918,7 @@ static long calc_group_shares(struct cfs_rq *cfs_rq)

 	tg_shares = READ_ONCE(tg->shares);

-	load = max(scale_load_down(cfs_rq->load.weight), cfs_rq->avg.load_avg);
+	load = max(scale_load_down(cfs_rq->lw.weight), cfs_rq->avg.load_avg);

 	tg_weight = atomic_long_read(&tg->load_avg);

@@ -3950,7 +3950,7 @@ static long calc_group_shares(struct cfs_rq *cfs_rq)
  * Recomputes the group entity based on the current state of its group
  * runqueue.
  */
-static void update_cfs_group(struct sched_entity *se)
+static void update_cfs_group_shares(struct sched_entity *se)
 {
 	struct cfs_rq *gcfs_rq = group_cfs_rq(se);
 	long shares;
@@ -3959,7 +3959,7 @@ static void update_cfs_group(struct sched_entity *se)
 	 * When a group becomes empty, preserve its weight. This matters for
 	 * DELAY_DEQUEUE.
 	 */
-	if (!gcfs_rq || !gcfs_rq->load.weight)
+	if (!gcfs_rq || !gcfs_rq->lw.weight)
 		return;

 	if (throttled_hierarchy(gcfs_rq))
@@ -3970,12 +3970,12 @@ static void update_cfs_group(struct sched_entity *se)
 #else
 	shares = calc_group_shares(gcfs_rq);
 #endif
-	if (unlikely(se->load.weight != shares))
+	if (unlikely(se->lw.weight != shares))
 		reweight_entity(cfs_rq_of(se), se, shares);
 }

 #else /* CONFIG_FAIR_GROUP_SCHED */
-static inline void update_cfs_group(struct sched_entity *se)
+static inline void update_cfs_group_shares(struct sched_entity *se)
 {
 }
 #endif /* CONFIG_FAIR_GROUP_SCHED */
@@ -4061,7 +4061,7 @@ static inline bool child_cfs_rq_on_list(struct cfs_rq *cfs_rq)

 static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 {
-	if (cfs_rq->load.weight)
+	if (cfs_rq->lw.weight)
 		return false;

 	if (!load_avg_is_decayed(&cfs_rq->avg))
@@ -4208,12 +4208,12 @@ void set_task_rq_fair(struct sched_entity *se,
  *
  * However, update_tg_cfs_load() is more complex. So we have:
  *
- *   ge->avg.load_avg = ge->load.weight * ge->avg.runnable_avg		(2)
+ *   ge->avg.load_avg = ge->lw.weight * ge->avg.runnable_avg		(2)
  *
  * And since, like util, the runnable part should be directly transferable,
  * the following would _appear_ to be the straight forward approach:
  *
- *   grq->avg.load_avg = grq->load.weight * grq->avg.runnable_avg	(3)
+ *   grq->avg.load_avg = grq->lw.weight * grq->avg.runnable_avg	(3)
  *
  * And per (1) we have:
  *
@@ -4221,9 +4221,9 @@ void set_task_rq_fair(struct sched_entity *se,
  *
  * Which gives:
  *
- *                      ge->load.weight * grq->avg.load_avg
+ *                      ge->lw.weight * grq->avg.load_avg
  *   ge->avg.load_avg = -----------------------------------		(4)
- *                               grq->load.weight
+ *                               grq->lw.weight
  *
  * Except that is wrong!
  *
@@ -4254,7 +4254,7 @@ void set_task_rq_fair(struct sched_entity *se,
  *
  * On removal, we'll assume each task is equally runnable; which yields:
  *
- *   grq->avg.runnable_sum = grq->avg.load_sum / grq->load.weight
+ *   grq->avg.runnable_sum = grq->avg.load_sum / grq->lw.weight
  *
  * XXX: only do this for the part of runnable > running ?
  *
@@ -4353,9 +4353,9 @@ update_tg_cfs_load(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq
 		 * Estimate the new unweighted runnable_sum of the gcfs_rq by
 		 * assuming all tasks are equally runnable.
 		 */
-		if (scale_load_down(gcfs_rq->load.weight)) {
+		if (scale_load_down(gcfs_rq->lw.weight)) {
 			load_sum = div_u64(gcfs_rq->avg.load_sum,
-				scale_load_down(gcfs_rq->load.weight));
+				scale_load_down(gcfs_rq->lw.weight));
 		}

 		/* But make sure to not inflate se's runnable */
@@ -5182,7 +5182,7 @@ void __setparam_fair(struct task_struct *p, const struct sched_attr *attr)
 }

 static void
-place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
+update_entity_sched(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
 	u64 vslice, vruntime = avg_vruntime(cfs_rq);
 	s64 lag = 0;
@@ -5259,9 +5259,9 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		 */
 		load = cfs_rq->avg_load;
 		if (curr && curr->on_rq)
-			load += scale_load_down(curr->load.weight);
+			load += scale_load_down(curr->lw.weight);

-		lag *= load + scale_load_down(se->load.weight);
+		lag *= load + scale_load_down(se->lw.weight);
 		if (WARN_ON_ONCE(!load))
 			load = 1;
 		lag = div_s64(lag, load);
@@ -5305,7 +5305,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * update_curr().
 	 */
 	if (curr)
-		place_entity(cfs_rq, se, flags);
+		update_entity_sched(cfs_rq, se, flags);

 	update_curr(cfs_rq);

@@ -5316,23 +5316,23 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 *     h_nr_runnable of its group cfs_rq.
 	 *   - For group_entity, update its weight to reflect the new share of
 	 *     its group cfs_rq
-	 *   - Add its new weight to cfs_rq->load.weight
+	 *   - Add its new weight to cfs_rq->lw.weight
 	 */
 	update_load_avg(cfs_rq, se, UPDATE_TG | DO_ATTACH);
 	se_update_runnable(se);
 	/*
 	 * XXX update_load_avg() above will have attached us to the pelt sum;
-	 * but update_cfs_group() here will re-adjust the weight and have to
+	 * but update_cfs_group_shares() here will re-adjust the weight and have to
 	 * undo/redo all that. Seems wasteful.
 	 */
-	update_cfs_group(se);
+	 update_cfs_group_shares(se);

 	/*
 	 * XXX now that the entity has been re-weighted, and it's lag adjusted,
 	 * we can place the entity.
 	 */
 	if (!curr)
-		place_entity(cfs_rq, se, flags);
+		update_entity_sched(cfs_rq, se, flags);

 	account_entity_enqueue(cfs_rq, se);

@@ -5470,7 +5470,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 *   - Update loads to have both entity and cfs_rq synced with now.
 	 *   - For group_entity, update its runnable_weight to reflect the new
 	 *     h_nr_runnable of its group cfs_rq.
-	 *   - Subtract its previous weight from cfs_rq->load.weight.
+	 *   - Subtract its previous weight from cfs_rq->lw.weight.
 	 *   - For group entity, update its weight to reflect the new share
 	 *     of its group cfs_rq.
 	 */
@@ -5493,7 +5493,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	/* return excess runtime on last dequeue */
 	return_cfs_rq_runtime(cfs_rq);

-	update_cfs_group(se);
+	update_cfs_group_shares(se);

 	/*
 	 * Now advance min_vruntime if @se was the entity holding it back,
@@ -5545,7 +5545,7 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	 * when there are only lesser-weight tasks around):
 	 */
 	if (schedstat_enabled() &&
-	    rq_of(cfs_rq)->cfs.load.weight >= 2*se->load.weight) {
+	    rq_of(cfs_rq)->cfs.lw.weight >= 2*se->lw.weight) {
 		struct sched_statistics *stats;

 		stats = __schedstats_from_se(se);
@@ -5629,7 +5629,7 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
 	 * Ensure that runnable average is periodically updated.
 	 */
 	update_load_avg(cfs_rq, curr, UPDATE_TG);
-	update_cfs_group(curr);
+	update_cfs_group_shares(curr);

 #ifdef CONFIG_SCHED_HRTICK
 	/*
@@ -5929,7 +5929,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 		qcfs_rq->h_nr_runnable -= runnable_delta;
 		qcfs_rq->h_nr_idle -= idle_delta;

-		if (qcfs_rq->load.weight) {
+		if (qcfs_rq->lw.weight) {
 			/* Avoid re-evaluating load for this entity: */
 			se = parent_entity(se);
 			break;
@@ -5996,7 +5996,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	/* update hierarchical throttle state */
 	walk_tg_tree_from(cfs_rq->tg, tg_nop, tg_unthrottle_up, (void *)rq);

-	if (!cfs_rq->load.weight) {
+	if (!cfs_rq->lw.weight) {
 		if (!cfs_rq->on_list)
 			return;
 		/*
@@ -6895,7 +6895,7 @@ requeue_delayed_entity(struct sched_entity *se)
 			if (se != cfs_rq->curr)
 				__dequeue_entity(cfs_rq, se);
 			se->vlag = 0;
-			place_entity(cfs_rq, se, 0);
+			update_entity_sched(cfs_rq, se, 0);
 			if (se != cfs_rq->curr)
 				__enqueue_entity(cfs_rq, se);
 			cfs_rq->nr_queued++;
@@ -6986,7 +6986,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)

 		update_load_avg(cfs_rq, se, UPDATE_TG);
 		se_update_runnable(se);
-		update_cfs_group(se);
+		update_cfs_group_shares(se);

 		se->slice = slice;
 		slice = cfs_rq_min_slice(cfs_rq);
@@ -7093,7 +7093,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 			return 0;

 		/* Don't dequeue parent if it has other entities besides us */
-		if (cfs_rq->load.weight) {
+		if (cfs_rq->lw.weight) {
 			slice = cfs_rq_min_slice(cfs_rq);

 			/* Avoid re-evaluating load for this entity: */
@@ -7115,7 +7115,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)

 		update_load_avg(cfs_rq, se, UPDATE_TG);
 		se_update_runnable(se);
-		update_cfs_group(se);
+		update_cfs_group_shares(se);

 		se->slice = slice;
 		slice = cfs_rq_min_slice(cfs_rq);
@@ -13450,7 +13450,7 @@ void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,

 	se->my_q = cfs_rq;
 	/* guarantee group entities always have weight */
-	update_load_set(&se->load, NICE_0_LOAD);
+	load_weight_set(&se->lw, NICE_0_LOAD);
 	se->parent = parent;
 }

@@ -13484,7 +13484,7 @@ static int __sched_group_set_shares(struct task_group *tg, unsigned long shares)
 		update_rq_clock(rq);
 		for_each_sched_entity(se) {
 			update_load_avg(cfs_rq_of(se), se, UPDATE_TG);
-			update_cfs_group(se);
+			update_cfs_group_shares(se);
 		}
 		rq_unlock_irqrestore(rq, &rf);
 	}
@@ -13583,7 +13583,7 @@ static unsigned int get_rr_interval_fair(struct rq *rq, struct task_struct *task
 	 * Time slice is 0 for SCHED_OTHER tasks that are on an otherwise
 	 * idle runqueue:
 	 */
-	if (rq->cfs.load.weight)
+	if (rq->cfs.lw.weight)
 		rr_interval = NS_TO_JIFFIES(se->slice);

 	return rr_interval;
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 7a8534a2deff..e395d77a4c13 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -270,10 +270,10 @@ ___update_load_avg(struct sched_avg *sa, unsigned long load)
  * sched_entity:
  *
  *   task:
- *     se_weight()   = se->load.weight
+ *     se_weight()   = se->lw.weight
  *     se_runnable() = !!on_rq
  *
- *   group: [ see update_cfs_group() ]
+ *   group: [ see update_cfs_group_shares() ]
  *     se_weight()   = tg->weight * grq->load_avg / tg->load_avg
  *     se_runnable() = grq->h_nr_runnable
  *
@@ -320,7 +320,7 @@ int __update_load_avg_se(u64 now, struct cfs_rq *cfs_rq, struct sched_entity *se
 int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq)
 {
 	if (___update_load_sum(now, &cfs_rq->avg,
-				scale_load_down(cfs_rq->load.weight),
+				scale_load_down(cfs_rq->lw.weight),
 				cfs_rq->h_nr_runnable,
 				cfs_rq->curr != NULL)) {

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b93c8c3dc05a..1012ee420208 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -649,7 +649,7 @@ struct balance_callback {

 /* CFS-related fields in a runqueue */
 struct cfs_rq {
-	struct load_weight	load;
+	struct load_weight	lw;
 	unsigned int		nr_queued;
 	unsigned int		h_nr_queued;       /* SCHED_{NORMAL,BATCH,IDLE} */
 	unsigned int		h_nr_runnable;     /* SCHED_{NORMAL,BATCH,IDLE} */
@@ -942,7 +942,7 @@ static inline long se_runnable(struct sched_entity *se)
  */
 static inline long se_weight(struct sched_entity *se)
 {
-	return scale_load_down(se->load.weight);
+	return scale_load_down(se->lw.weight);
 }


--
2.43.0
