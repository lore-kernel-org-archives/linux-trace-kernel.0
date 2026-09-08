Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6A7380FC8;
	Tue,  8 Sep 2026 06:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788848541; cv=none; b=OuMbniWf2MJPghgpZf5LBTRB4pov1m1zC2A2Et9mx/JHpNgaWoobh+Do5ipUKYYDKoZM8V+8F9WcNiXvR0OnA5LhU+/sI/8DSZaSNH2R3jW+JD5LdqF7k3yF+OJkn5JqTbxwWBnYg6LxZ8Mg1ojcpIXfwbTHE/Ss1fo4lSBympg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788848541; c=relaxed/simple;
	bh=zAT6OkKCvliEPOEq8U2CAdfNT8wiBntFtwUDghsPOXU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LJDPrFriqQhkHaNJk/eXyKpALbBlomTsbd5feDkBBDzdTrXlR7mXWwROkkz/iXj9jWJpgsWxWM2vgGi2WhImd3z0+YEAlM/A6+Le4tPPdOYbkgRd3I2WiC8mE96U3J1N/CzasP9BbBqEslEG+XmnRFdWoB0Stu4tP11go0ks7hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WntViQ9H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+zL0EzqV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WntViQ9H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+zL0EzqV"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788848538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zbOwDumNVEBBo2G/MbKcD830SEh1cuRXMj/EZAUQybI=;
	b=WntViQ9HWLvPHEgDDdiUyJaOeV++b5JmfUAmKICsbEbhBOaOt7c9N2+Rr7QH3GiBoN+1pa
	Nro9t9YrZ1OvJ7cAIM7rnkm09mWTxz4cdFlHstgd1R/nZbNRKjE9tpX24mFpRFctiIqOaV
	O20u2ZL2ecYAjLn2iG0sKTbwS81L+DlQ8SKdGueRNv7vGiLmVo9D84ndBSWhBLSVI0lQGr
	Bu84VXea1fV/5+wlAfK+2F5mcXoAJys3Rj8x8UXIX/Np09jGYMXkIvq/dWP6MordzL+Y3s
	/q1o9lLx/Cx8OTjZyb0B5J8ae1v7f6N7x7WWN5yDmML5TI8vhik2f+kvmt2QeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788848538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zbOwDumNVEBBo2G/MbKcD830SEh1cuRXMj/EZAUQybI=;
	b=+zL0EzqVcB1KK6VW/UviOJEPDubjtC2AFmxksJ/jlrDg2JYkzXiNOT19rLXmB0UWOdGcZq
	rCtKUjQM8DN4HwCQ==
Date: Tue, 08 Sep 2026 08:22:16 +0200
Subject: [PATCH v2 2/7] tracing: Remove duplicate declaration of
 ftrace_set_clr_event()
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-tracing-cli-event-filter-v2-2-05396a3fb663@linutronix.de>
References: <20260908-tracing-cli-event-filter-v2-0-05396a3fb663@linutronix.de>
In-Reply-To: <20260908-tracing-cli-event-filter-v2-0-05396a3fb663@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788848535; l=997;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=zAT6OkKCvliEPOEq8U2CAdfNT8wiBntFtwUDghsPOXU=;
 b=CTpL1yD3pw2tlYs0VWTlmBlJfP8ra1haxBhX0G92utVffCqWScbjjm4HCkt4orNAT9+0/N+aZ
 8yw6BuRQ0+zC+nffW4qNzujzdaO1B/5z0nviVsbqe3lfIv5HLqwSR9W
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The function is also declared in include/linux/trace_events.h which is
even included from kernel/trace/trace.h.

Having two declarations creates churn when changing the signature.

Remove the unnecessary, duplicate declaration.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 kernel/trace/trace.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 74a7a50d1e78..8fffd10fad53 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -2287,7 +2287,6 @@ static inline const char *get_syscall_name(int syscall)
 void trace_event_init(void);
 void trace_event_update_all(struct trace_eval_map **map, int len, struct module *mod);
 /* Used from boot time tracer */
-extern int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set);
 extern int trigger_process_regex(struct trace_event_file *file, char *buff);
 #else
 static inline void __init trace_event_init(void) { }

-- 
2.55.0

