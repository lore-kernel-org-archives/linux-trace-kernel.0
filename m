Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480553C9444;
	Wed, 11 Mar 2026 10:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773224182; cv=none; b=SmwEkMYQt7APxirzj7m6QUEzNz2i+BmtUNH+W0QbiLIQHXzS+q/JV1PTRC5p4IGg1UdAHb7HlwSNYYAKBetssinerAJTpY4qPThtsoOixZI8zKbX5GMfZ1n4RJzjJmkkvSsyeq/GyEplXYb9Nt4Chw9BMeQZT08dcrlw6rzLH2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773224182; c=relaxed/simple;
	bh=/pGu31gu6J6DDH6/SJ0ZAkz4gMH53WYvv9stcPp5eEM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JIvtENKSEZD61zqGpJ0jJBP/k1znbCDz/DBiLcN5zw3MwZp63Cqw4r9aIka8n2matiDe2+puByMiaNJZQsPEZWdty5WJW6A/X60lfq845iLxyETtJM1sk7ColoEr6hewTMwLZdN2LmFB0rbKN6cboNQmuR/GhLewOu4hnNiHNW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ck8X6gOJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z1kzaltu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ck8X6gOJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z1kzaltu"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773224179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0LmkymabnXdWeq/Ge02unx5jQD/Pes85LEyCk13947Y=;
	b=Ck8X6gOJ2VfNvFFu6VEr2G9MOlGZLPmfvMvEYJ/YEOPnXkhenb9ncPUeH+8DQgMO9NCkVs
	dit3ls46X+hzqJfeO/ZnAmd96KNI9RJ/L2V53tawWF+s3RzmLXGfu4dlw0H/+So/2vgji2
	Rx8qZlFMMtCdQHKaD4LvF9HI8+kZ8cG4gyUwpIXFK8uLFuTcoyEDNod8OMC6U5jq9QHmH9
	jOktCcyhyaF2jJijSRtLLV8fT+Ey9du0isdxFIrl3B+GHWNQTclJdDJreDCj+MlJkLrtTf
	65tKfWCM39GHEIvB8pDYkBuXC0nGbpnCfVQfRu5sWmyg0ALbajH2T6P04hU6fw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773224179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0LmkymabnXdWeq/Ge02unx5jQD/Pes85LEyCk13947Y=;
	b=Z1kzaltuFp+lrY/vFr57ao4iMwIruR9soS12PtnwAi4btkai0Hju/RUYQiq1P/HCLecXvD
	STJl8ev8aW7u2gDA==
Date: Wed, 11 Mar 2026 11:15:12 +0100
Subject: [PATCH 03/12] timer_list: Print offset as signed integer
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260311-hrtimer-cleanups-v1-3-095357392669@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773224171; l=945;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=/pGu31gu6J6DDH6/SJ0ZAkz4gMH53WYvv9stcPp5eEM=;
 b=EqTmGXuZt0ECkVyiINEGtmNE+Cm9uC5ZhscZKBn8dlMCne1F72VUQIMeuRedv3VkV6ajTmn+l
 HYX6q10b8wFCmSrAYxJLKwC07/ig8yq/cXQ/s4y4TkcS0rkpzVktXco
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The offset of a hrtimer base may be negative.

Print those values correctly.

Signed-off-by: Thomas Weißschuh (Schneider Electric) <thomas.weissschuh@linutronix.de>
---
 kernel/time/timer_list.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timer_list.c b/kernel/time/timer_list.c
index e2e14fd1b466..427d7ddea3af 100644
--- a/kernel/time/timer_list.c
+++ b/kernel/time/timer_list.c
@@ -101,8 +101,8 @@ print_base(struct seq_file *m, struct hrtimer_clock_base *base, u64 now)
 
 	SEQ_printf(m, "  .resolution: %u nsecs\n", hrtimer_resolution);
 #ifdef CONFIG_HIGH_RES_TIMERS
-	SEQ_printf(m, "  .offset:     %Lu nsecs\n",
-		   (unsigned long long) ktime_to_ns(base->offset));
+	SEQ_printf(m, "  .offset:     %Ld nsecs\n",
+		   (long long) base->offset);
 #endif
 	SEQ_printf(m,   "active timers:\n");
 	print_active_timers(m, base, now + ktime_to_ns(base->offset));

-- 
2.53.0

