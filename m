Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6254220FA8B;
	Wed, 12 Feb 2025 13:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739367698; cv=none; b=N5ouzn6b1VJpbenzAHw74njiOhcAYsxYDGqJXJnlvFgkwY7fPCISgwBlSLpaMA0W/VBixETEes4zBiGEQC10G3PzHDvx3N+aamq+ULgkAao7e1FUU6omkGI5Q8MvqylJ1/OreWGIoVLRFOsFavmMPAtprsudQHdJ3QCdXiimq04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739367698; c=relaxed/simple;
	bh=b109fr8xLKB6Xr42RnvTRVQiYkpAsCIXfKaB+vPm0+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V6jrJZ/45RNS4tUWaBeUbwa2dlf/xvA1ju+hgMXmRy7N9EPJ5n3lHrHMxh4sgwfv5p0MF1zb3OZ1qaqI9YZmEns9tu4b1lKPflyOcex76tJ2Y63jjk90Y+XAfKpEy6iFLW/hSY9H3k9D4nqGkUdYvW4CMqlbE0pr3uWEDlkgjIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LQgPZVRm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DPkb9BXP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LQgPZVRm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DPkb9BXP"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739367694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4hP9MIj/xfZayutuHmqVzRbNPdN0j7i3yHMFRYnK4OA=;
	b=LQgPZVRmuBn4LNzN1KHxssrOrPp+EErK7odNx4tZUbsC9iGkQg72pFuDrpZH6Fp7QUGQfu
	tGamFD122GTVysn8sSD+eH1OimyOB7YcVriz53Gy08/GuwqFrbs2JzSlrKOIl0EmqOk1c0
	aYJZgC12UYXPaszdBUt+RO+KrkNbGFIOKR5pY3Yv4wPVjGmRYcJG3R76ukvFHyzyM9+kdJ
	cRoY4hF7wCODJE/2hvI4REFJUFiF7d32QW+pa2PgiZBbsAzt4lbtB0Y1jIDtwXI5d9WPUM
	ZjYJF7kGkKNv/+mxAij4EcN8ct5s+mo//hFdRpUDR3fv9U5Aaqo16zdLc7UUyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739367694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4hP9MIj/xfZayutuHmqVzRbNPdN0j7i3yHMFRYnK4OA=;
	b=DPkb9BXPbKtqItzIRd/gIqcbCfHgIwnyyDgWf5WSnMk65ld7bQmVtDTeRVB9X91Nf6cF15
	4E8kIHF+3+5B+pBw==
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
Subject: [PATCH v3 9/9] tracing: Use preempt_model_str().
Date: Wed, 12 Feb 2025 14:41:15 +0100
Message-ID: <20250212134115.2583667-10-bigeasy@linutronix.de>
In-Reply-To: <20250212134115.2583667-1-bigeasy@linutronix.de>
References: <20250212134115.2583667-1-bigeasy@linutronix.de>
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
index 1496a5ac33ae1..77271faab20e9 100644
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

