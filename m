Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2233C9437;
	Wed, 11 Mar 2026 10:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773224186; cv=none; b=ehYoVbS/oYVHZxYj/WGS8BZ29rDSigvjeH4ou020y7RIXTAT+T2pd5p1zOqqd9/uakMDN7taL1FhTMMumuZ9eDXUGZpHB/Q+CBmfJRuslYDHWnyhAkD/PaGs9dfkUtUTaO3Xzt2aE5000+RELXxPqlJiYVhkrSKmeXKJl0QRPD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773224186; c=relaxed/simple;
	bh=k2XwGZqPcFVrZtTNRH+HpoPYodLcAgvbSVWzG5oK1II=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HUQNIr6eYva24Wq3Hyc06/G3XmynC0YsdtgrG2x7OLTU86jVl0G9gAzaXG4QksBL5wdQF+9x/7DbOTUkBCKEeZ65bSMnck+Gmrh1RKJziOClTlnDIioTRO5+TGTqGfcoeXt4XzlEfLhXz+W9oDXpQcQVtcmvtnQajHHXDGZbAu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bte7dt1V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l+U6z/Nz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bte7dt1V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l+U6z/Nz"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773224184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wJRuJckQ+ypso4OXrye4CavrmtHzMV0pbF16GSMCkSI=;
	b=bte7dt1VD4M43iM8PHbg5cAxzsX+VT3cUXuHmSegfKPw+5mCEgcf5V5LyvHxkUlRdIfC3C
	SW+SwGjfx32TLAEi27EUh3iY2t0B6xJD1hUSGUMdk/++kgvn6b6uccKwvPrnO2mMSH9Acy
	guWUNjtsfqLygB8V8dlNugoL7e9RHIp43QlBeneCQPFibu2IJXPU1SQ5py1+8PaaEFaJoz
	klk5ZLx9r/bn0kf4Nvin+VqIpLwhKB8At8ts5PFFNITxTfVRxxyvyJB1ruOIoxUzLiF1sv
	R/eIw7j7n2bmPb2kvsmQjH+GJJ3j4q532Fk9F0TiRQ2nXaDuvWNJmac1H2Vm7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773224184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wJRuJckQ+ypso4OXrye4CavrmtHzMV0pbF16GSMCkSI=;
	b=l+U6z/Nz3Z4vWit8W2qAkRfSpeAhBL9+GjC9sx9Qlb8vWXAhPpNTYYkdBXEo5s9rvAQxKZ
	D9fn7cTH4oGNdpAw==
Date: Wed, 11 Mar 2026 11:15:19 +0100
Subject: [PATCH 10/12] hrtimer: Mark index and clockid of clock base as
 const
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260311-hrtimer-cleanups-v1-10-095357392669@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773224171; l=798;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=k2XwGZqPcFVrZtTNRH+HpoPYodLcAgvbSVWzG5oK1II=;
 b=gRGoaH/njoXsF22mq9SDR6cCKKbC9OIMEWmXBPwA1Fg4IwaKgZlNb1/pTcFTu+Pnm5ja7VJAy
 QpPcGMUodXHCqfvh8CCSr8cmebl56qHNiXkEL7fWAQU5pT9hj3wByMq
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

These fields are initialized once and are never supposed to change.

Mark them as const to make this explicit.

Signed-off-by: Thomas Weißschuh (Schneider Electric) <thomas.weissschuh@linutronix.de>
---
 include/linux/hrtimer_defs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/hrtimer_defs.h b/include/linux/hrtimer_defs.h
index e6d4dc1b61e0..a03240c0b14f 100644
--- a/include/linux/hrtimer_defs.h
+++ b/include/linux/hrtimer_defs.h
@@ -26,8 +26,8 @@
  */
 struct hrtimer_clock_base {
 	struct hrtimer_cpu_base		*cpu_base;
-	unsigned int			index;
-	clockid_t			clockid;
+	const unsigned int		index;
+	const clockid_t			clockid;
 	seqcount_raw_spinlock_t		seq;
 	ktime_t				expires_next;
 	struct hrtimer			*running;

-- 
2.53.0

