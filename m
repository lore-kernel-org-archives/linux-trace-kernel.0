Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104471B9B5A;
	Mon,  9 Sep 2024 13:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725890040; cv=none; b=C14ZYpC1h5rjR4c93eSpvdFf5+ogTK038DXE3HAdL/wUFkLQVhaJmdh/R4cYVQG55gczs7XfFCm00g6lh5KWdNfYxFcf+q3zENZoOb7RPuS1syolu4NXG3rX7egYmZK7bqtSHkfVKx+TJMbcE1lNUMzQM1BMF34sTAxqw4w4EhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725890040; c=relaxed/simple;
	bh=zmCUEdtrd9kta0PfjUYaIMsDJp6G13+lykxK24hQT5A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zwa9Nk0xDwYRk792wyudoXVpkM7rj9/WBv1kTf1s/KL8VnwNFt9QPhHu7asbiCyKSC/4AdsM1sYk+N91fEKsVlPR4S0PKchpTB90Eg4pfMiTKpsTDNExEtbRxD3GRmWJZdR7NHDcqU4HTIbXpH1O5NmW38coURWxFVyJAT6b/nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3dUR5pa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3dUR5pa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25939C4CEC5;
	Mon,  9 Sep 2024 13:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725890039;
	bh=zmCUEdtrd9kta0PfjUYaIMsDJp6G13+lykxK24hQT5A=;
	h=From:To:Cc:Subject:Date:From;
	b=P3dUR5padKuKu6hpGSOs8nlgHp/ZWIupNqCSBBLy6R++D4lPJZnZQZOlsMwKnyBru
	 2JKwbdA+xZDIofnnZDLd0dTUU05shFrlCRwNZ+VquH/nFlWUC2d8/m6qcdPhWM5z3g
	 y3slsNrtElebpTVTSIeyvfi0VnKq4QdcGqDL+ELpzH9CLF+sR6DbcKRNumzlVRySiJ
	 0zSqB5WKe2VOGgJfhd6sZsOMRPz2iCJyHuf2Bcq19XY8qGHm3+S91LFWx1QjE+jjuX
	 xdlQGNkiEVEXEWydniI3q/oo+NNZgOtZpx1Lxxfh0KPKTuIrkhPXRUIYUL4IspoqIg
	 hbF1gj8Oyg6SA==
From: Arnd Bergmann <arnd@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing/timerlat: move interface_lock definition up
Date: Mon,  9 Sep 2024 13:53:20 +0000
Message-Id: <20240909135344.76327-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The definition was previously moved into an #ifdef block by
accident and now causes a build failure when CONFIG_TIMERLAT_TRACER
is disabled:

In file included from include/linux/seqlock.h:19,
                 from kernel/trace/trace_osnoise.c:20:
kernel/trace/trace_osnoise.c: In function 'osnoise_sleep':
kernel/trace/trace_osnoise.c:1631:21: error: 'interface_lock' undeclared (first use in this function); did you mean 'trace_clock'?
 1631 |         mutex_lock(&interface_lock);
      |                     ^~~~~~~~~~~~~~

Move it up some more to be outside of that #ifdef again.

Fixes: e6a53481da29 ("tracing/timerlat: Only clear timer if a kthread exists")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
It looks like the regression already made it into 6.11-rc7 as
part of
https://lore.kernel.org/lkml/20240905172827.6a64cf97@gandalf.local.home/
so this fixup (if correct) is needed for 6.11 as well
---
 kernel/trace/trace_osnoise.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 20c6660762a3..acfd57689af6 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -228,6 +228,11 @@ static inline struct osnoise_variables *this_cpu_osn_var(void)
 	return this_cpu_ptr(&per_cpu_osnoise_var);
 }
 
+/*
+ * Protect the interface.
+ */
+static struct mutex interface_lock;
+
 #ifdef CONFIG_TIMERLAT_TRACER
 /*
  * Runtime information for the timer mode.
@@ -252,11 +257,6 @@ static inline struct timerlat_variables *this_cpu_tmr_var(void)
 	return this_cpu_ptr(&per_cpu_timerlat_var);
 }
 
-/*
- * Protect the interface.
- */
-static struct mutex interface_lock;
-
 /*
  * tlat_var_reset - Reset the values of the given timerlat_variables
  */
-- 
2.39.2

