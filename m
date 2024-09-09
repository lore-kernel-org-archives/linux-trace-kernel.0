Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70F04C6D;
	Mon,  9 Sep 2024 14:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725892354; cv=none; b=Md/b/L9zO2rpCLZXqLKG/1kCwd4EOkt8TdAi/1cKiy07tda7y1ojrZuR3NOyB3cqBXTGH+yyVrJ65Mo8CfYrlHeHbqE+LGsyOaano+hdW6PsIjaQSEEEtRasTX8MYjk8F979aCJ/7UH3Rhl0OXUpovKcU3n0Zu1f5I2F1hlVUL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725892354; c=relaxed/simple;
	bh=gP0cJNdRSrHsCAa7SNcTD0I1GYBvw01uZ2k6szFGuJE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=NUP9qqmAjyudf/2/lCuul+4JB5+xdsb/yVsKLoR70UpdWyK1fuOVpGbl4lAw5Sr83QxD7pPdmAHWursLRO8YmBGuDvQqNnqieLW3HX6SU6iuasdJpqwKVPf8a1uvKAiN5GfMPIB9Gab5zT95H5CGlmBZG+FiW16BDz6wmMwai4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 764C0C4CEC5;
	Mon,  9 Sep 2024 14:32:33 +0000 (UTC)
Date: Mon, 9 Sep 2024 10:32:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, "Bityutskiy, Artem"
 <artem.bityutskiy@intel.com>, "Dubel, Helena Anna"
 <helena.anna.dubel@intel.com>, "Luis Claudio R. Goncalves"
 <lgoncalv@redhat.com>, Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH] tracing/osnoise: Fix build when timerlat is not enabled
Message-ID: <20240909103231.23a289e2@gandalf.local.home>
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

To fix some critical section races, the interface_lock was added to a few
locations. One of those locations was above where the interface_lock was
declared, so the declaration was moved up before that usage.
Unfortunately, where it was placed was inside a CONFIG_TIMERLAT_TRACER
ifdef block. As the interface_lock is used outside that config, this broke
the build when CONFIG_OSNOISE_TRACER was enabled but
CONFIG_TIMERLAT_TRACER was not.

Fixes: e6a53481da29 ("tracing/timerlat: Only clear timer if a kthread exists")
Reported-by: "Bityutskiy, Artem" <artem.bityutskiy@intel.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Note to self: Add test to build the kernel with osnoise but not timer lat
              to my test-suite.

 kernel/trace/trace_osnoise.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index bbe47781617e..7e75c1214b36 100644
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
2.45.2

