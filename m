Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730AF2036E8;
	Fri, 14 Mar 2025 16:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741968502; cv=none; b=hhc603QO7LseSH/bPjhu4ouFiphAK9I4gdeUqmldggAPciM12TZOQhK1OST7yyt4hFScXCXH+fJuR/EPYWg6qDWADt1ZsPGxlOgFxh7N0SkwoCsey3EnVPfC1AjTmy1GgXgxF77TBw2DpDz+UyN0sds7t7jVJ6UXDm+uYA7Yi9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741968502; c=relaxed/simple;
	bh=XqcsY6o6fpXWY2codHVy3UgJNf7GA85mCt53UwBExks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BbJbBK4vjKOizdbbKy92JwhjUmcpPsvn1H3c4k/+xrDPPRz1XU4zNSsfN618LePQIyooJPv7vx5Cb+ECdLp+SZZA19FJoBFRnHhd7wAxK0hCnWSl+HRi86pOg2CR2MZnjJbst3DOzU7+2S+cV+vniIJu71ArKtnYVbgHya4zHdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n6trQHKl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BShPwRx7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n6trQHKl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BShPwRx7"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741968498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ev8xxyCWrO7UYEFMB8bMIA2a0AaTG/gUghwzI4DhR2o=;
	b=n6trQHKl78YEElXSiECySNw0hwZCvK/W4LRwxf+jTEO7sU1uPOuzYYNorxddMIA5RHU/P9
	eqNvlsGOHryl2J+9/NBSQyfwktE1qGIGSDRzXuajLS771Hti8ufTjJlzTinnrxy5H6qDO1
	qunpO0pA5F9khK3+QMuQWhtKt5Lk3zhc9LizbKmQfqvAw8ppEY3/oxhkKfc3NyT+P/WCw8
	RjcVR763eJSu0H7v/bHz4EuOuV1rh9V5nIawoflTql41EHmQ3YdCzGIUxLcKtuBqaXfNeR
	HWa7vQ3IK+1UIbY96biCqzMcI1NXcOaJJ8c8U2PvFx93O27NmPk6iyZ9Sj7ZIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741968498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ev8xxyCWrO7UYEFMB8bMIA2a0AaTG/gUghwzI4DhR2o=;
	b=BShPwRx7mUK1yn3qgIU25R77XSDnl1aA3xx4c0F0x9M5Uu7Y+K7tz68Vh+2XG/vVwGBUIa
	/d/GbzmC8jpWR3AA==
To: linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: Ben Segall <bsegall@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Mel Gorman <mgorman@suse.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Will Deacon <will@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4 9/9] tracing: Use preempt_model_str().
Date: Fri, 14 Mar 2025 17:08:10 +0100
Message-ID: <20250314160810.2373416-10-bigeasy@linutronix.de>
In-Reply-To: <20250314160810.2373416-1-bigeasy@linutronix.de>
References: <20250314160810.2373416-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use preempt_model_str() instead of manually conducting the preemption
model.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-trace-kernel@vger.kernel.org
Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/trace/trace.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 0e6d517e74e0f..fd3cb2b2ab829 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4100,12 +4100,7 @@ print_trace_header(struct seq_file *m, struct trace_=
iterator *iter)
 		   entries,
 		   total,
 		   buf->cpu,
-		   preempt_model_none()      ? "server" :
-		   preempt_model_voluntary() ? "desktop" :
-		   preempt_model_full()      ? "preempt" :
-		   preempt_model_lazy()	     ? "lazy"    :
-		   preempt_model_rt()        ? "preempt_rt" :
-		   "unknown",
+		   preempt_model_str(),
 		   /* These are reserved for later use */
 		   0, 0, 0, 0);
 #ifdef CONFIG_SMP
--=20
2.47.2

