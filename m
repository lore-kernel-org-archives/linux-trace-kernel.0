Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1BA1A6815;
	Wed, 11 Mar 2026 10:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773224181; cv=none; b=d/6CajVeVjY2tqdgr6uW/i959Yn6f5NQiluUlx1RDazNakMV0sb3jj1bJhyVtJDuGiqD5xWvxv24VxDRtHKihSqzFy8MSwAq/gxw4lwvds86fqVkKE9OXYNY0tYctw24hE8A1rryTL+0V31P/mcWqcwckvCMQR2FVzogZwkFzL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773224181; c=relaxed/simple;
	bh=re8JDRCPYzgZOEMayn+dpu8izTgVZs4o4lu4tO+6g4c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mhDKcSfVIvF+ttniFHg/WUe0l+PkkZdbCBZl/ZH/2Jc6HnbnT4HWArjTcyKeyQAta8m5B0gE5GAL3RM4zM+aSjfBhAuLfOVwQkANJktVQLZQdjjcDHdKJBb9+5lXQi+TbBeOP4G6daGWa1H3fSp2twpWSkSwKf7GZbKvZXyE7VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B1F4q3Bb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Mupnw1zo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B1F4q3Bb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Mupnw1zo"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773224178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HZM0DU4QRem/47Ih92uwxuhlHlKL6kjp0QYOR6qvTog=;
	b=B1F4q3BbFrfG2r2JL5eCGaYbECu7Oyhu7I5AQPEafeb4aKy3FzelBUey5pW0hCVGTcDd2Q
	OLDz1JtjnNPOXfORjhM+XaRGepJ2xZr1AMj/8MzpIRTNafNr62AZzSyvuMfkKa1shQmLA2
	f5Js+gRH9+ngYmjZJE2rW9Jqdqw9tRUpCgBO/ETdHzGV1E7ThAzJn0Jurc7+6W4bDjgfFJ
	QcAOpuSaPkeeMUw/ymajDl2YCF59JR3JhvJL7QQvX6QmHugSn+ZaIYtKGDRZ8iqkdwTsaY
	KgIp2bbvoHruXqoVTtKOmsGUH83mx5I4KXJm04OKYtGE7QpGmzGO8yw3qrAuaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773224178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HZM0DU4QRem/47Ih92uwxuhlHlKL6kjp0QYOR6qvTog=;
	b=Mupnw1zoEJSLQQkDdaiFSPpEt8ghtFHBnO4jwVqZnl0mNpVCl+6h2F5/Tsap+9YeENUJqM
	4dcfvxyt2QUByBCQ==
Date: Wed, 11 Mar 2026 11:15:10 +0100
Subject: [PATCH 01/12] scripts/gdb: timerlist: Adapt to move of tk_core
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260311-hrtimer-cleanups-v1-1-095357392669@linutronix.de>
References: <20260311-hrtimer-cleanups-v1-0-095357392669@linutronix.de>
In-Reply-To: <20260311-hrtimer-cleanups-v1-0-095357392669@linutronix.de>
To: Jan Kiszka <jan.kiszka@siemens.com>, 
 Kieran Bingham <kbingham@kernel.org>, John Stultz <jstultz@google.com>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Frederic Weisbecker <frederic@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773224171; l=1009;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=re8JDRCPYzgZOEMayn+dpu8izTgVZs4o4lu4tO+6g4c=;
 b=BmRh1fl3moNOUCIbPDcMqY1T+jEs2k4UqK400XIZDqrlHqh4EusxGbiB9DRHlbE+3AonII1+v
 8CbtdKUHYA+CZChpyYSDqxjFKZj4ecW7IXr42sTd/8pfeRex4XmLTZP
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

tk_core is a macro today which can not be resolved by gdb.

Use the correct symbol expression to reference tk_core.

Fixes: 22c62b9a84b8 ("timekeeping: Introduce auxiliary timekeepers")
Signed-off-by: Thomas Weißschuh (Schneider Electric) <thomas.weissschuh@linutronix.de>
---
 scripts/gdb/linux/timerlist.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gdb/linux/timerlist.py b/scripts/gdb/linux/timerlist.py
index ccc24d30de80..9fb3436a217c 100644
--- a/scripts/gdb/linux/timerlist.py
+++ b/scripts/gdb/linux/timerlist.py
@@ -20,7 +20,7 @@ def ktime_get():
     We can't read the hardware timer itself to add any nanoseconds
     that need to be added since we last stored the time in the
     timekeeper. But this is probably good enough for debug purposes."""
-    tk_core = gdb.parse_and_eval("&tk_core")
+    tk_core = gdb.parse_and_eval("&timekeeper_data[TIMEKEEPER_CORE]")
 
     return tk_core['timekeeper']['tkr_mono']['base']
 

-- 
2.53.0

