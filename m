Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6ADAC6FD1C
	for <linux-trace-kernel@archiver.kernel.org>; Sat, 25 Mar 2023 17:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbjCYReL (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Sat, 25 Mar 2023 13:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjCYReG (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 13:34:06 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37A3D535
        for <linux-trace-kernel@vger.kernel.org>; Sat, 25 Mar 2023 10:34:00 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 31so3847197qvc.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 25 Mar 2023 10:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1679765640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkqhMIgatpcxnL+zHWHZ8wmMPBfEMgxQ9GLo+81Qz2Y=;
        b=urQ3eGiSW39KOAg6HtdLQrdsQBhLE8fe/4vhcVkRPGPen+juA88G3/CNjtLggI5yz+
         /Hsq3yl9CS37DT4iPWQayHWqbtRy9ZytQ8GAhvPbolMecAoOjwgCOLok1U+uYBLXNFGT
         fF2bATwed5QWM3wvD1atFjToYeb3jtgI3zZSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679765640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkqhMIgatpcxnL+zHWHZ8wmMPBfEMgxQ9GLo+81Qz2Y=;
        b=QV3n0Ackw7rXSpJ6qeH7UPTIDUO/C7UZ9hjoJUEgCeSZ8JpA3mEO3uL4u4G4hcuMCt
         lkxdOp/ySALFpGhboSW4RCWPj+iwan99/PtiTVW7LvSePhDpqo7xX0ZVf4jfRn0OGvAE
         yVYUKxxhFwCydRoofZIByjW9ZdBV/ELkqY0N/iCaQdOCgQh40lTuN+vYFjYGrw5hb9wO
         OGdWMg95pKf6Qu3yMT+uDs4hhCSDUo9w4QA/bYVeInnQujJFyGeAL9uBDwy6cUs5mt/i
         rOJMj/6RgI6/K+6beB8r48041DtcYDnkR7G8Gdbi3K5PPE/0LJFpWrZtABUceF47Wn8z
         PSGQ==
X-Gm-Message-State: AAQBX9dntyHgg+OdpTQ1F3SuCPV1AzV9RqP6XIH3bnrMBar2X8aSIi7o
        EQBfNEqViFneds7I2iXBeiBZqg==
X-Google-Smtp-Source: AKy350aHEmw9YFemES+YvWFbuHmTRQ1f6F/yTZi3NzBEEE4hql5/JbCy7XCBFuSVU3Z1xg6Fl0ubRA==
X-Received: by 2002:a05:6214:27c6:b0:574:97e9:e21c with SMTP id ge6-20020a05621427c600b0057497e9e21cmr11359421qvb.4.1679765639777;
        Sat, 25 Mar 2023 10:33:59 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id m4-20020ac84444000000b003e37ee54b5dsm6762764qtn.90.2023.03.25.10.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 10:33:59 -0700 (PDT)
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
Subject: [PATCH v2 07/13] rcu: Fix missing TICK_DEP_MASK_RCU_EXP dependency check
Date:   Sat, 25 Mar 2023 17:33:10 +0000
Message-Id: <20230325173316.3118674-8-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230325173316.3118674-1-joel@joelfernandes.org>
References: <20230325173316.3118674-1-joel@joelfernandes.org>
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
index 68d81a4283c8..a46506f7ec6d 100644
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
2.40.0.348.gf938b09366-goog

