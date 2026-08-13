Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227A4481250;
	Thu, 13 Aug 2026 14:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786630049; cv=none; b=p9dsCFQAma6VIv+KfkKbqdGT/DjuhUGcAOr32ohr8Eu89U4k2ehcJY6lvFhIYDcXAvAznvs94JPwD5rMfSfA+tuQhbb8L5IZTnS/7129B/ZdompDF4+lVlvMLY0ErKJKlVAWsIRHgxCWtnlqsr71IcVtZ4HQjL+AJeuxCtx0a7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786630049; c=relaxed/simple;
	bh=gl06iMv/syv71dRvrhZvxHtAduITqKwKiPntPXMOHnU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dFcGOExWzgxni9NVcBZzewVct0uZb97zLw5LPXSQHx/pv/0tgek6dJprE0Va/3qjHgoevcIfVbuiOlyf2GxgAVNp3nrxeyXAZ2CAcQ4A7uarVLuoByc9Pkc2LLD/dT6F14sOfYmIsPlV1SkBwGCi6e568ORqN6qJoI5Fdrz2KDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gGF6I9hr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0t7wj4Y9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gGF6I9hr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0t7wj4Y9"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1786630046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V0KBUZ+fAIZp+Clpmtkqz5bk9loQYOgO5ZwoXQ3pL5g=;
	b=gGF6I9hrWu5BNWfkJ11BqEksDaFNqZmRcPQi96pv27KaZ2jMTPm/KSJ/NAoO+V+bpPDiUS
	sh0Lx1d5f2HsR7NNbL5cuSFV2EZzuUTcDoMC95lzbRjp1m1YPh7/g1VkLlbwiG3rGht+fx
	HD9Ve0MUBP+DYbpnaBelXcKxcD8V+3/H5tVu7xkbhvRfcOjg0nEOoCPgp2bTVQtby5yK+e
	XUVkouSiUEEocF639CYdyJhEO2NL7eVtDYlOhj9LmgaZD/iF3XuYZ3ECWj0JqXtS/HiCLx
	lZDPeXh+l9L2twvATBcZtlJCgmQUAezEhsNu/WioEgDKidNtECj5xa+ywF5WRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1786630046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V0KBUZ+fAIZp+Clpmtkqz5bk9loQYOgO5ZwoXQ3pL5g=;
	b=0t7wj4Y9PN1im/UPjc2pxsYHsniesW/x0+PDaB4HBzLFLz9nXQtKhcjYcK3zqRxS/Kbzw6
	RTiOVftv6LrNAaCw==
Date: Thu, 13 Aug 2026 16:07:15 +0200
Subject: [PATCH RFC 2/7] tracing: Remove duplicate declaration of
 ftrace_set_clr_event()
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260813-tracing-cli-event-filter-v1-2-57c4e8029c86@linutronix.de>
References: <20260813-tracing-cli-event-filter-v1-0-57c4e8029c86@linutronix.de>
In-Reply-To: <20260813-tracing-cli-event-filter-v1-0-57c4e8029c86@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786630039; l=977;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=gl06iMv/syv71dRvrhZvxHtAduITqKwKiPntPXMOHnU=;
 b=oc+qIawThcHhN4cok3NM6zwD5W2eb2rT1BPiRscQpQvmyFwwaJo7H9fq1tj2TN2UwZ+U9VU/Y
 tq6H9tLGpVzDYEPFgsRAC9eCr/EthhMfb9U2I9vjgQ/NfYXrnY0DLqc
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
index 80fe152af1dd..c00e4741f815 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -2286,7 +2286,6 @@ static inline const char *get_syscall_name(int syscall)
 void trace_event_init(void);
 void trace_event_update_all(struct trace_eval_map **map, int len);
 /* Used from boot time tracer */
-extern int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set);
 extern int trigger_process_regex(struct trace_event_file *file, char *buff);
 #else
 static inline void __init trace_event_init(void) { }

-- 
2.55.0

