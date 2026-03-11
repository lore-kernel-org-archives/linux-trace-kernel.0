Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4211E3C943A;
	Wed, 11 Mar 2026 10:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773224183; cv=none; b=ml5F0QSOxw3whxiCWFT0z57HLen7YWJiaoHzdyuGREnDTFQxwrsybasXcIWe1h6cylRSpmmyzloAqzeNH+o+Yy7EuRMJZd8h0D+t/2gD57XrFUs+hBxI9JewQENuDINzW8MfST/2pvIF8eGHfLA19LZqAuANvNY4LIrm2fNrLgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773224183; c=relaxed/simple;
	bh=8+MLDaCSM0MSOJ9HU/8HVQtykhvH4AGT9aWVx61Jn20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W5P0pURFibjDE7TH82N3mxLrD2DOpf2o5MmglFZQILIeDF1+HKCVOiwNqmSHJnbFACU1THRPKJsnTjDwMQXfbBqohWrP/nga/BedYueujQMOJcZvnnxx+QkXwc6cSxLMNpoTDq7/aOwQ3loMyxsJTc/36VmDSbQ7JziKrhQvRgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m75o3Gpi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BK89OeL5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m75o3Gpi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BK89OeL5"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773224180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oRLaIn3ZVXeoA5KaFSl2ICf9KwjqTgv/ecRWgaINhBA=;
	b=m75o3GpixcEgdhOp+jBO4W/Dy4kEL77U0azizIxyf0vGjdxk4zety5XkbQ6vnZvhjSTny8
	FWTMmNSFrbrrMliqpvnAZYylcB+0ssm6JSlKwDOTX6q29GOhCShDtGFKs3Iq3vddLqEHHk
	0aqbdbuATvEj1UvEB0K1Ldw5gzjvSXYkWn5vVJAZCZy/afmGVTfyjGNnk6gy6ZEeH8o+1B
	l8AdY0k9RK+bDe5BYKU8A6Z1SRqqADz18OwpEVnVyhTpsIfug+Fw4a19YaWiExQK5Og7by
	SJ0SXLZwNJXcATRKBdlTfn9stXHWuxT+sILmIKitjS1+epCmRkwMHCr6X/MWVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773224180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oRLaIn3ZVXeoA5KaFSl2ICf9KwjqTgv/ecRWgaINhBA=;
	b=BK89OeL5GzpncybxPcRCUEQuhEiYp7GRcE10xGZ+W8fhPcUeKCcSZUL6RAd3a8kR+NLGgU
	GOtMqChk/6Vf7dBg==
Date: Wed, 11 Mar 2026 11:15:14 +0100
Subject: [PATCH 05/12] timekeeping: Mark offsets array as const
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260311-hrtimer-cleanups-v1-5-095357392669@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773224171; l=1858;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=8+MLDaCSM0MSOJ9HU/8HVQtykhvH4AGT9aWVx61Jn20=;
 b=KJZUpY6+lZ+Hs8okQj/SySUzFagkYeuXX1g8nEKqC6Oq10n9nOa0LTS/ndoqOyhkWSjfOJVIX
 xxeHY3CdgggA+0v6SaEnhvclrBPjgALHgr3FZUy1g6HWpNXw7B+CCMc
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Neither the array nor the offsets it is pointing to are meant to be
changed through the array.

Mark both the array and the values it points to as const.

Signed-off-by: Thomas Weißschuh (Schneider Electric) <thomas.weissschuh@linutronix.de>
---
 kernel/time/timekeeping.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 46b77c3deb95..27f17428f7c5 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -989,7 +989,7 @@ u32 ktime_get_resolution_ns(void)
 }
 EXPORT_SYMBOL_GPL(ktime_get_resolution_ns);
 
-static ktime_t *offsets[TK_OFFS_MAX] = {
+static const ktime_t *const offsets[TK_OFFS_MAX] = {
 	[TK_OFFS_REAL]	= &tk_core.timekeeper.offs_real,
 	[TK_OFFS_BOOT]	= &tk_core.timekeeper.offs_boot,
 	[TK_OFFS_TAI]	= &tk_core.timekeeper.offs_tai,
@@ -998,8 +998,9 @@ static ktime_t *offsets[TK_OFFS_MAX] = {
 ktime_t ktime_get_with_offset(enum tk_offsets offs)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
+	const ktime_t *offset = offsets[offs];
 	unsigned int seq;
-	ktime_t base, *offset = offsets[offs];
+	ktime_t base;
 	u64 nsecs;
 
 	WARN_ON(timekeeping_suspended);
@@ -1019,8 +1020,9 @@ EXPORT_SYMBOL_GPL(ktime_get_with_offset);
 ktime_t ktime_get_coarse_with_offset(enum tk_offsets offs)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
-	ktime_t base, *offset = offsets[offs];
+	const ktime_t *offset = offsets[offs];
 	unsigned int seq;
+	ktime_t base;
 	u64 nsecs;
 
 	WARN_ON(timekeeping_suspended);
@@ -1043,7 +1045,7 @@ EXPORT_SYMBOL_GPL(ktime_get_coarse_with_offset);
  */
 ktime_t ktime_mono_to_any(ktime_t tmono, enum tk_offsets offs)
 {
-	ktime_t *offset = offsets[offs];
+	const ktime_t *offset = offsets[offs];
 	unsigned int seq;
 	ktime_t tconv;
 

-- 
2.53.0

