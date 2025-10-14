Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD91296BD3;
	Tue, 14 Oct 2025 05:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760421131; cv=none; b=Qg5pEw2ab4MAC5iHfc0yK6nJ3MIs50Q/JUB9FiFowwWQSRY1Tpr3ZU5tq8eubKoA8OUlruL7B+vud9KhbP5V7cEP/cIF/6PuqM6x9tEWH4pK1gu0RwDc7rDu/YVfTY6iWiKQIm8Cs8eiaomt0zN4xCgp00nxb9LIn3hTZRvRIWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760421131; c=relaxed/simple;
	bh=fKYWQj7wYHUZT/y+sxSyhrMWKl/HIFm5JmEH7v2RNV0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DFfGVs/IITsF82z1bluM+zLUSm/UmywRYuwzo6wH1+Vfu3rTRgrnFWDyqOnmSSYHmN29lqxdM72tUuJuMf2ZPRMTPOIUxf4sAyMLBiD1wcJgD/HedVv2Y0Dm7UXxq8VNH9hr1u7Lvs+EYOI+DAk9Za6b/QO4sczFMRfT+H5UC8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kdU0nPCF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xLvpn4U1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kdU0nPCF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xLvpn4U1"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760421126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e5TEmMFK+xjD8cADcSVz9FrBuhGsq1gyJWyQa3E0bLc=;
	b=kdU0nPCF77WDPryjKkZKCi27UXtV6jAMv9teo6l2c7kgC5W02j7yjOskD3+DUz3IUq+jEe
	wxPZ99xtH/I+FnNtPUUL+Zg8EHhNG+7lemIEMHH2IQ5+6SoCw1niR/aR2b9KBNSXx80TrG
	sDWImU4V6lydC3Za2MGS6pQEfv+40uo0QLqV+Ut8wnXqJLoQzpAxGlq1Ao8JW4YDbXrgXe
	n+DCAoHjnP4DgCMqXIwakWOFHGwsG4w0RUktOupioD58ZOtL+qUpR81Mqoi7AZQCL/M+PH
	0ybBVvDYFX4l6drUseag3zFy43FAwJjLqodG9jlq5/vb/sqqubtVOR4lpyq5HA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760421126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e5TEmMFK+xjD8cADcSVz9FrBuhGsq1gyJWyQa3E0bLc=;
	b=xLvpn4U1tPGyR0mx0s0rxQvHdYGEYrwOiEIa0g6S1B8X0yPYsB0MXiF8aEkdrty7B/yeYY
	5CA9tLU6u3AOfbCA==
Date: Tue, 14 Oct 2025 07:51:57 +0200
Subject: [PATCH 2/3] rv: Make rv_reacting_on() static
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251014-rv-lockdep-v1-2-0b9e51919ea8@linutronix.de>
References: <20251014-rv-lockdep-v1-0-0b9e51919ea8@linutronix.de>
In-Reply-To: <20251014-rv-lockdep-v1-0-0b9e51919ea8@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Gabriele Monaco <gmonaco@redhat.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Nam Cao <namcao@linutronix.de>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760421123; l=1503;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=fKYWQj7wYHUZT/y+sxSyhrMWKl/HIFm5JmEH7v2RNV0=;
 b=UmH/nISgjOTjvPvEc/fOaP8GtWf7fVonneRF4odVY2tpzDL791RPOgYv/Ew1pRdVMRjeW51wk
 TO150Q4rHmxBJLFTAgjeTBcXovK8zEtk/9lqjKv/DM9w9jtJx1bj5w6
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

There are no external users left.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/linux/rv.h            | 6 ------
 kernel/trace/rv/rv_reactors.c | 2 +-
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/linux/rv.h b/include/linux/rv.h
index b567b0191e67f7dfab74e2aad6de3ed63d94058d..92fd467547e76d8868289b694f28220fc857dbcc 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -116,17 +116,11 @@ int rv_get_task_monitor_slot(void);
 void rv_put_task_monitor_slot(int slot);
 
 #ifdef CONFIG_RV_REACTORS
-bool rv_reacting_on(void);
 int rv_unregister_reactor(struct rv_reactor *reactor);
 int rv_register_reactor(struct rv_reactor *reactor);
 __printf(2, 3)
 void rv_react(struct rv_monitor *monitor, const char *msg, ...);
 #else
-static inline bool rv_reacting_on(void)
-{
-	return false;
-}
-
 __printf(2, 3)
 static inline void rv_react(struct rv_monitor *monitor, const char *msg, ...)
 {
diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
index cb1a5968055abb22439a066b4e25dad98f078389..8c02426bc3bd944265f809e431283d1a20d56a8c 100644
--- a/kernel/trace/rv/rv_reactors.c
+++ b/kernel/trace/rv/rv_reactors.c
@@ -347,7 +347,7 @@ static bool __read_mostly reacting_on;
  *
  * Returns 1 if on, 0 otherwise.
  */
-bool rv_reacting_on(void)
+static bool rv_reacting_on(void)
 {
 	/* Ensures that concurrent monitors read consistent reacting_on */
 	smp_rmb();

-- 
2.51.0

