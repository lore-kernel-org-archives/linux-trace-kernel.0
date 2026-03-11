Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA90C3C9EEB;
	Wed, 11 Mar 2026 10:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773224182; cv=none; b=gc0LYrIH64fNT5LZsmp70TQkQrcxXauStF0BS8OWxWu1kvlz4L9TMs3D1QNvrtZoVku9SIC9TknE72OmYQUT5NE9kG1sp2mI0yoxCGZ3wkJDIsG4dtpwpd+MBY378WxA7k/PwsObU5ybMmpiHeUNMNJbK+Q229P+S/jLWFc3RJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773224182; c=relaxed/simple;
	bh=kurRXUCo7OfBthe3tV4P5mSmDlzeULf8xwGygLvMcSY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tX07x80qMaSdOH3Mxb5Hkrm69KXTnxV5iClNak+AkzZAGk348DYvB+jOpzu+mVdlVZACrct9p5F07qHmUqWXXBkhX/cKzAyivApqTq7dK0uysgG5aM/ts8Y1QUu8+1priUycC4HYpvdtOfElTEjw2hNc0D28ZeLGMDVuFLS2K3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vo1ks4fy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5awxQcdK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vo1ks4fy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5awxQcdK"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773224180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WCKXRqxiuhIrg3ee6neMev5gBvLIWyRDcDEDwP1EOIg=;
	b=Vo1ks4fyPoYkDfWFZtgeqjL+E+JZPwC5IKfHhXYtyClRdP2N+nWHaeUlETupLY+eTBc+vn
	BgcY5spfWEVrUS+JoRlWYRbgQsh3SlrVYgV2bQSCAUcl2vOaVzmacdP4ghK88Rc6SabxR4
	w2Ji0F4P+eRyBMeBkW62K07wDhleyzFtfVTpETpfYLB2u48dT+nyp3kKm6rsWKr5eJP4mu
	qjweTqc3UUSyvzT1KzkYeyGITjQA9p/c1LEf8bOa60tb44PEnk5Hf0ZeQMPJvg85ijTFYT
	S5Kf6Ju7WzqXts7IMu8pdnXBjZCtQcJdk/weGoZfW+zjnw0H1KCZpGCIOIwZnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773224180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WCKXRqxiuhIrg3ee6neMev5gBvLIWyRDcDEDwP1EOIg=;
	b=5awxQcdKGx7bLXU5HxB1jVhHfXlG/YI+Srt7IeWJXxP0POifKs4xrxVt77ci1g83UNncFl
	F2norV58gVxAzJCw==
Date: Wed, 11 Mar 2026 11:15:13 +0100
Subject: [PATCH 04/12] timekeeping: auxclock: Consistently use raw
 timekeeper for tk_setup_internals()
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260311-hrtimer-cleanups-v1-4-095357392669@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773224171; l=896;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=kurRXUCo7OfBthe3tV4P5mSmDlzeULf8xwGygLvMcSY=;
 b=zVh5yiMLdUPkP8HzQgDFnv1EixUcvjp34ElakXKn5JfSydg0blbpKb7NUy7ttUE8QYiA35rbV
 iOohY7y9AwzAEQKXtPuikkBYPPxDKb8Lc0arr4xl+PwfoskOAAYjHUI
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

In aux_clock_enable() the clocksource from tkr_raw is used to call
tk_setup_internals(). Do the same in tk_aux_update_clocksource().
While the clocksources will be the same in any case, this is less
confusing.

Signed-off-by: Thomas Weißschuh (Schneider Electric) <thomas.weissschuh@linutronix.de>
---
 kernel/time/timekeeping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 5153218df29f..46b77c3deb95 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2985,7 +2985,7 @@ static void tk_aux_update_clocksource(void)
 			continue;
 
 		timekeeping_forward_now(tks);
-		tk_setup_internals(tks, tk_core.timekeeper.tkr_mono.clock);
+		tk_setup_internals(tks, tk_core.timekeeper.tkr_raw.clock);
 		timekeeping_update_from_shadow(tkd, TK_UPDATE_ALL);
 	}
 }

-- 
2.53.0

