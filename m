Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4034E1EEF9;
	Mon,  3 Feb 2025 14:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738592211; cv=none; b=kOlOw+Qz0CqVXXemR+N/qQJRk8st82gxizFoLy6YFH0RQaJQtmZzzBTHnvVQG+rQLSVtTiZYac/DpBqL2B8q4muWMtqE03vICvZuDRXnGRqwUcyDx64Xd7KTJf4AyE23x3fgrdFe6r97az0O0vCwLct905v/Z4TMA4NOxAIngUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738592211; c=relaxed/simple;
	bh=25O/yp6UnkbO77kBkc7PxJ4KzqrbhWQScdgzucAMvtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QtvjNnmbjdIVpvsgHjMtpQiWtzj+GCcohW0pFhbZ8JA/E2g38GpgvNpR9Z/0AFvOq6rknlaCXBccBqFpXcKEZFcZyVcySQqBMrgks0ieD8sZzEAtHq/Z1Mh6ED8Eh5dxH3iTxiQZVAStfIk2UH5Zv90YmLj+zFPI+aJOpCurSaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hTRuqSGF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SwmMtGXX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hTRuqSGF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SwmMtGXX"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738592208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BK05d/1mfk1oZVQnNoGYNIpEo3eku4M94weqeHOTRAw=;
	b=hTRuqSGFY1vnL4Ofc1Mw/T6rl8rOe6nK/S/z02ouwF18ep2BVBP9bcNCCOm5UiSu6Kfd9O
	Mh2w2PeSsoYZrn9UyHzK7+L8fZNkBS3VlK4Yh87u2FIgi6hN74J5CDaOP5FJ8vgpcV0BTw
	fTTBmgAwXIxPm8y8u7SYg1hzxRXIVSO/pC65sKddSCgtIEPaC1UOAZZiUqOhVTE1CKgoEm
	6oUYcpnecUZFbL+nAknWQidqmmg/FanSsFYbDzNMTxBw9UmJtvK1bbHpthkqqi4nU9wewD
	jVUgFoz+MV/OiJuPatsYn1sMyKnOZtOXG5S/GVRelRQOtNfklNTJ1tRosQsabA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738592208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BK05d/1mfk1oZVQnNoGYNIpEo3eku4M94weqeHOTRAw=;
	b=SwmMtGXXF7NHVNDd/yYy+H+f3JpafdNAYmrniD0Lx+pv1X4U73IYtocFPD3B4qJG7lpIXw
	e9fIrsF+WhDOXGAw==
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
Subject: [PATCH v2 9/9] tracing: Use preempt_model_str().
Date: Mon,  3 Feb 2025 15:16:32 +0100
Message-ID: <20250203141632.440554-10-bigeasy@linutronix.de>
In-Reply-To: <20250203141632.440554-1-bigeasy@linutronix.de>
References: <20250203141632.440554-1-bigeasy@linutronix.de>
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

