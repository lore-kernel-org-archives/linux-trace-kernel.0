Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAA1C6FD1D
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 15 Mar 2023 19:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbjCOToh (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 15 Mar 2023 15:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbjCOTof (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 15:44:35 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10C3F773
        for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:44:31 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id r5so17505125qtp.4
        for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678909470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v18L/HyzbX8RIGPkv74gEAaNuKF2umfPmevTB4XROmQ=;
        b=LAK5vaKQ7yNuOXwJ/bmj+BxFvK6WV9egm/yBtxMZRQ86LkU+ecP3uQvSIt9nrBkN+u
         Zx3IzVf7Qvxjmyq2vNKFl9qY9SmA2yHS3dUcZJYtGNJdYLUNEp14r4a9nDEFBOf2I51P
         K36kb3x302AK7FfweoSCaIdBujCIksdSNSirg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678909470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v18L/HyzbX8RIGPkv74gEAaNuKF2umfPmevTB4XROmQ=;
        b=A/fAhMmGG6f2XiEZE0s3kKFP/nfyHbOea0Os/yWlSRGgsYq6RFk2l/gs/nnJDEPLRA
         nR+NRYzaaHbv66PkwRqyh1Cazhv/oqzPzNTLPEL4qsrHNvz6yToFWDd4fx92350l8CM6
         lq0iCCR7/XDKT8p6nRx2WH+JgGm6m+/uJYWnRQqaxXCT4ocw9MdiM/5Oemr132iFQBK0
         UvQ3xihgrlH1Q+awSW5jyU1KWJ9VWpBx6IxqI8cT/pIK0dFaUfJbNe4juEA46QAr/eF/
         rKp03O5xTHD8NLNHf0R0TafdpwAEQtjkcVKrMjWJIND7B8tlSFhqZCsOSwIUpoTrxFQ7
         jAOg==
X-Gm-Message-State: AO0yUKXojNOkgag6wpTKQR2+3IlOpYwks3/vT5GLG3a7p11Xnz3BfgQ6
        EGNUpu4/wqkgNw5eOORfIlz64g==
X-Google-Smtp-Source: AK7set+1xJxMyUYjCwPpkgFMm3z1hwMdYE1QZynRvOo/9xx1oGT3RffTi7vAUfXL1hJQUwX5WJAIMg==
X-Received: by 2002:a05:622a:174c:b0:3bf:d1b3:2bbb with SMTP id l12-20020a05622a174c00b003bfd1b32bbbmr2125188qtk.13.1678909470197;
        Wed, 15 Mar 2023 12:44:30 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id c15-20020ac8660f000000b003b86b088755sm4346666qtp.15.2023.03.15.12.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 12:44:29 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Zqiang <qiang1.zhang@intel.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH 2/9] rcu: Fix missing TICK_DEP_MASK_RCU_EXP dependency check
Date:   Wed, 15 Mar 2023 19:43:42 +0000
Message-Id: <20230315194349.10798-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230315194349.10798-1-joel@joelfernandes.org>
References: <20230315194349.10798-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

From: Zqiang <qiang1.zhang@intel.com>

This commit adds checks for the TICK_DEP_MASK_RCU_EXP bit, thus enabling
RCU expedited grace periods to actually force-enable scheduling-clock
interrupts on holdout CPUs.

Fixes: df1e849ae455 ("rcu: Enable tick for nohz_full CPUs slow to provide expedited QS")
Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/trace/events/timer.h | 3 ++-
 kernel/time/tick-sched.c     | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/timer.h b/include/trace/events/timer.h
index 2e713a7d9aa3..3e8619c72f77 100644
--- a/include/trace/events/timer.h
+++ b/include/trace/events/timer.h
@@ -371,7 +371,8 @@ TRACE_EVENT(itimer_expire,
 		tick_dep_name(PERF_EVENTS)		\
 		tick_dep_name(SCHED)			\
 		tick_dep_name(CLOCK_UNSTABLE)		\
-		tick_dep_name_end(RCU)
+		tick_dep_name(RCU)			\
+		tick_dep_name_end(RCU_EXP)
 
 #undef tick_dep_name
 #undef tick_dep_mask_name
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index b0e3c9205946..ba2ac1469d47 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -281,6 +281,11 @@ static bool check_tick_dependency(atomic_t *dep)
 		return true;
 	}
 
+	if (val & TICK_DEP_MASK_RCU_EXP) {
+		trace_tick_stop(0, TICK_DEP_MASK_RCU_EXP);
+		return true;
+	}
+
 	return false;
 }
 
-- 
2.40.0.rc1.284.g88254d51c5-goog

