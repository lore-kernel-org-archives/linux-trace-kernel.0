Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA68D2356D9;
	Wed, 30 Apr 2025 11:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746010967; cv=none; b=m5BQjU+XazgLbm3S2sc613Sbyka0/L/R0cWrCAkxBDFE+vxkQpkvOzmmWzxyWwdYFndDCmp4M7bsv6CmFGUR0MVBosvIXp1+H+mgJwrmIDQG3zE1rk/CmRbBoRqOx5NYDs9G49MgWkaKj+y/MkGNz7maPJQtsThpdk2FbDYwytI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746010967; c=relaxed/simple;
	bh=XLIwTZUPwuaMfKzDKP66sLEghroVG+ojtKHrNXY4pD4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HU0tSku6qdNubn+LU0VbuGLBKTx8F/e/2P8Tnf3onk95L67oAY9mUHo+9uKLs83q8kvzw6HDSgTXfy7UP2Bt+pWl0G894Jq/k55j0kH/qi9amyl8LFXJ3B2nRwEeCkT1yozPkt9X4pAFR4GaeAi2HMHz0flIjsHn4qzg80aNvX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rHIX0A2+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aeC/RN38; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rHIX0A2+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aeC/RN38"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746010964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nLbwQQqpQiGUQcMTHG6q9ADA6juJe7ifpWtTjSR5QDs=;
	b=rHIX0A2+u+ouJGTIzKQ6DHF1/2Z/TGSr/ZS8k03/cH1G67jNRfuEY6lhmP8BL2uasjet85
	/iX8cY+InR3+KVqrUwugkJ9OpvGiDkFVFCsKKy9FyfZm37M6J7pDlAkqlVKgVqRM4XuYLi
	sMaW4f7L6cM9KxH0eXwuteibqWDyPxkMOELa+c3KrNPxsbe7nb4KZu6TjJdN/wxkXH9ngi
	PZ5AIRaNrKNfKw5QplwgHmyBwIrlyjyarePO/x458MqXFBSuKs8NiTSqkInVnNatuUII31
	zKUEtJyiXKvfVgl2Ps4J4n2EJ8tNWahuPbjEQ7NuMAeB03wyTocGSuNxMvAZDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746010964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nLbwQQqpQiGUQcMTHG6q9ADA6juJe7ifpWtTjSR5QDs=;
	b=aeC/RN38VTlBX/+J3iYpeKPOoebjBp3UmGy3/gi/ov+xXAAbctyZyYhOdbZj/On3kpSo1Y
	JGrsYKyerKVdGxCg==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v6 02/22] printk: Make vprintk_deferred() public
Date: Wed, 30 Apr 2025 13:02:17 +0200
Message-Id: <42ce595f371c03598bbbdc5a7e0d9b1dd9275b33.1745999587.git.namcao@linutronix.de>
In-Reply-To: <cover.1745999587.git.namcao@linutronix.de>
References: <cover.1745999587.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

vprintk_deferred() is useful for implementing runtime verification
reactors. Make it public.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 include/linux/printk.h   | 5 +++++
 kernel/printk/internal.h | 1 -
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 4217a9f412b2..1b7eebe13f14 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -154,6 +154,7 @@ int vprintk_emit(int facility, int level,
=20
 asmlinkage __printf(1, 0)
 int vprintk(const char *fmt, va_list args);
+__printf(1, 0) int vprintk_deferred(const char *fmt, va_list args);
=20
 asmlinkage __printf(1, 2) __cold
 int _printk(const char *fmt, ...);
@@ -213,6 +214,10 @@ int vprintk(const char *s, va_list args)
 {
 	return 0;
 }
+__printf(1, 0) int vprintk_deferred(const char *fmt, va_list args)
+{
+	return 0;
+}
 static inline __printf(1, 2) __cold
 int _printk(const char *s, ...)
 {
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index a91bdf802967..28afdeb58412 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -71,7 +71,6 @@ int vprintk_store(int facility, int level,
 		  const char *fmt, va_list args);
=20
 __printf(1, 0) int vprintk_default(const char *fmt, va_list args);
-__printf(1, 0) int vprintk_deferred(const char *fmt, va_list args);
=20
 void __printk_safe_enter(void);
 void __printk_safe_exit(void);
--=20
2.39.5

