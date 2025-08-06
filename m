Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860CD241686;
	Wed,  6 Aug 2025 12:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754482165; cv=none; b=j3/GKL5a78SVuRlSoODzlK4BQ/uCtlh14lPqBLMKH/ERhtIBoB3JVAaGdopSgo9zNgN7OYf47jLKsESRLFN0cZtL+4MPZcNWgoPvRnIeiv5XGDdFaQDRs1JvWIaNvq4lMdkgh80dzbld9NMC3o0Nsq7cXjIsR72Wcbvd7SKm+PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754482165; c=relaxed/simple;
	bh=BcGRasAQ9mogvAZ87Ab3YO4UYy6ryOhYE0EsyCCMpd4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l7hb9GW12feqTjevQCefcSdxDYXpNB9ylTnzuUrVwht/CWodLPYd9BiAKcl/oZBqv9BacnpMZ+Oaq8geRocwrfw8jELYnNqrHNY/p4dLNeSJapbE2VLk1zeOUwrPYdQaDTCcqsmrVf+hyX4w4+ndkt9MSoMrq5icdzOd2ck7sYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xuRNfk+k; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T2joTnpz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xuRNfk+k";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T2joTnpz"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754482161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=elVoctTYc9GXeKCg6teCfRlkF2UnaMQD5ikej+jBDe0=;
	b=xuRNfk+kDiYVGXhOBWbEfPNDZL1XIE7pTpfqwzomQ0Vu4x2QNpLc6xK/7t0YZfviGEVXgE
	8la52iqEwaZCFaQPh1BR/0U9/hRcoy5m71TLqjwVaeHxz1/18Flfq9s4n5bSBw8QIl+4ea
	IKSM7kjUgHfzoNKQRN81aum+8otgEwQuNBu4liQNw04E7kp9hm+enNxW0ooISx56Q/aI0Y
	e7mcg6C/5781UK0/KkA4gTs8WIx7WUSbD14EcxSYtY70BGV/FUM3M4LcO3FIR2Uot70iTi
	VadkJzHy//DWglWyHHEa6NputeRWukHcrVQMbrOAzL8LY6AxosD/pMjEoe/MGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754482161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=elVoctTYc9GXeKCg6teCfRlkF2UnaMQD5ikej+jBDe0=;
	b=T2joTnpz+VIgeZP41lET/PP19n3gAV6zXTb/4eS5Jv4FMMkjiD5RPfW9uEo2CEZCSJLaiW
	rGv7qmvdwqDswICg==
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH] rv: Fix wrong type cast in enabled_monitors_next()
Date: Wed,  6 Aug 2025 14:09:11 +0200
Message-Id: <20250806120911.989365-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Argument 'p' of enabled_monitors_next() is not a pointer to struct
rv_monitor, it is actually a pointer to the list_head inside struct
rv_monitor. Therefore it is wrong to cast 'p' to struct rv_monitor *.

This wrong type cast has been there since the beginning. But it still
worked because the list_head was the first field in struct rv_monitor_def.
This is no longer true since commit 24cbfe18d55a ("rv: Merge struct
rv_monitor_def into struct rv_monitor") moved the list_head, and this wrong
type cast became a functional problem.

Properly use container_of() instead.

Fixes: 24cbfe18d55a ("rv: Merge struct rv_monitor_def into struct rv_monito=
r")
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 kernel/trace/rv/rv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index bd7d56dbf6c2..6ce3495164d8 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -495,7 +495,7 @@ static void *available_monitors_next(struct seq_file *m=
, void *p, loff_t *pos)
  */
 static void *enabled_monitors_next(struct seq_file *m, void *p, loff_t *po=
s)
 {
-	struct rv_monitor *mon =3D p;
+	struct rv_monitor *mon =3D container_of(p, struct rv_monitor, list);
=20
 	(*pos)++;
=20
--=20
2.39.5

