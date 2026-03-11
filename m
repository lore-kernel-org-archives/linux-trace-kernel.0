Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E06C3C9443;
	Wed, 11 Mar 2026 10:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773224187; cv=none; b=iKFdvwlr8F4dKbuJ1Kv0EmGNmUVswcYG/wLUdrxctDK9go1FPqyV+3TMFfHth/C5zaWzIp7d7zL7vhDGreHPVZG2N9SKLjYy0QFlZ3a4exoTYPaDuQygJ4/wblcmRjOLfbLAEgADx382CO3UJ4zmUM1Gu7uV+afyhQ7HTXxbcxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773224187; c=relaxed/simple;
	bh=ZJvsYq/9QXH/JBlQi6mWA45F4v47A2sHIptcO3IpxA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iytyQteoqDrJayURs0FQQOqc2QRogeJ7iSNpsr6eLNBu4oxl63m8LBE/ZSLYCBrXv+aCWH0ngfBqnauypIL4wJxP6ZWdAyrBg0g9KlClhvauWj62tjbQ0vOLhV6pPdsAd0zhL1lcI2ptjN18LKFMiBnrbEnU0Cd97jrXymjYz3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qZDaR7IS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AWmISy0K; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qZDaR7IS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AWmISy0K"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773224184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8tY76R/HYHkM6tdxqlr1WrQmWc28Wofr4qsZxpr6vc0=;
	b=qZDaR7ISn67NH70pv1ReQ2+FkUW+B8c0RPGZ2NqvAsG5pGM2QABhFdIf90lMozDtZRWuHh
	4BIiDGyFOdF8Bwgv8mQMkJFY80uV04YuhOj6w7TfC6va0d49Y6ynEe6YIET0mtTR9znIts
	JNlafL5DuL5c9T2416CAJK/36eMiP984cJTIXAu8TJlPRPkk46W8HA7xBCUQBbIEPFbNwA
	CmcroV+Ny2uPHWr0rKN6I4XqBguRp0PzuEaYLzuhu6U9DfZUBR/trzJrq7QgsHLLdaugLo
	PEe6Ql+bfz13+UWQ16WsQWZFgUXqA1OUOJ+Ekn+zO/7J38WU5y9Wdq9JOJtsBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773224184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8tY76R/HYHkM6tdxqlr1WrQmWc28Wofr4qsZxpr6vc0=;
	b=AWmISy0K1Va252rjvZ+6P8Dxzuhj0JOt0uN6/ysb6QEJ/n5xAojX5k0G03jsEK+mil0p7q
	MmB7Bs2eFNat44BA==
Date: Wed, 11 Mar 2026 11:15:20 +0100
Subject: [PATCH 11/12] hrtimer: Remove trailing comma after
 HRTIMER_MAX_CLOCK_BASES
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260311-hrtimer-cleanups-v1-11-095357392669@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773224171; l=736;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=ZJvsYq/9QXH/JBlQi6mWA45F4v47A2sHIptcO3IpxA8=;
 b=LaB39xq/m4WM9sNi6k5h2pJ6QL85D/F0rENYTp+fI1N81Ijya3Rb/vOjUGsm15KXcv+Go388x
 We8J5rhmSqbAv4eBELEcpuGvfgupcBZEcENc1XX+2BYW9Q2Op+xzVqw
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

HRTIMER_MAX_CLOCK_BASES is required to stay the last value of the enum.

Drop the trailing comma so no new members are added after it by mistake.

Signed-off-by: Thomas Weißschuh (Schneider Electric) <thomas.weissschuh@linutronix.de>
---
 include/linux/hrtimer_defs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/hrtimer_defs.h b/include/linux/hrtimer_defs.h
index a03240c0b14f..52ed9e46ff13 100644
--- a/include/linux/hrtimer_defs.h
+++ b/include/linux/hrtimer_defs.h
@@ -44,7 +44,7 @@ enum hrtimer_base_type {
 	HRTIMER_BASE_REALTIME_SOFT,
 	HRTIMER_BASE_BOOTTIME_SOFT,
 	HRTIMER_BASE_TAI_SOFT,
-	HRTIMER_MAX_CLOCK_BASES,
+	HRTIMER_MAX_CLOCK_BASES
 };
 
 /**

-- 
2.53.0

