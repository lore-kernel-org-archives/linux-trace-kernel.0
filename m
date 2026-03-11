Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D523CAE6D;
	Wed, 11 Mar 2026 10:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773224184; cv=none; b=S1OgTafq2rMNrKAkj1JGP/N0rAyA2z7UukX2E7cRJg3Fl8puKxBvom9MCiTGjTTXWEayiXgPvblGZo0xUZazXkUCUp/4hzxxxvIYWSoAG/DOcoRsDj040Zft1jJxT9wGq3AkPe7E3ZS0vdwTwhMXMYFV9ZuV4lh+aYeL1X2bN8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773224184; c=relaxed/simple;
	bh=Rjblk5lG+/N1D4ncy0DNJlG86erv+vbGPCgFswiU2pw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cHw84MGXNpRYJ4tO85yI6KoynjFcEWqM/dEL7bvWO2+hbzoDU+lnfA4l0jTF5vHp1H9iJVQmpknfGNmyXuOieZFBGBn7QqYd7Bv1icLu+WjdNkoW87eo3EtTVVwsbNylIvPlkVsMjYWRcoG8I+k70w2KMq0ZEc/3w+lHNHmhW7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=08TITzKL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DRL3oMAQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="08TITzKL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DRL3oMAQ"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773224181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D/3Pupjtyw5OaqO+yHKDzdUCtAMdrSUWA4bAtmedxIQ=;
	b=08TITzKLZBDrJ4r5xRT2b4jzHSpyCmKeRdB8aVUhG8MkdmNJmUahT2KMMljO7uLLG1deBo
	RfQpXJlbUquei+zbmDe1nfvloYac3XpxDeCMQovQncLdZFxIllRNU0d8v3L1QGX0vfjf6v
	/OHuYd7YEUiN1qWO5ffEWAy318MO/TJnWB5tM4KG7SPwpd345on6OpRmekE+Ah7SEFDUS2
	ZVLU9TwFS+6ZWTMad2tgl7xl9gjeGcpvXy2tqgQOa4haKBIlgdBaQzCK2ON+DFV2JDeRqj
	TZT83PGX9sv15ZlS97uAU5I1APnCdZ/ltf9oLUZGWXFnCip7/WXgGgL0io3tmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773224181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D/3Pupjtyw5OaqO+yHKDzdUCtAMdrSUWA4bAtmedxIQ=;
	b=DRL3oMAQFu9vXwFv5F+aHnpuqhiVsP28UAfGWMtG+QBAKa3qHrspfZnndYuW1g50NCDpFn
	IPHot5DYd1rG4sDA==
Date: Wed, 11 Mar 2026 11:15:15 +0100
Subject: [PATCH 06/12] hrtimer: Remove hrtimer_get_expires_ns()
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260311-hrtimer-cleanups-v1-6-095357392669@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773224171; l=779;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Rjblk5lG+/N1D4ncy0DNJlG86erv+vbGPCgFswiU2pw=;
 b=Igi+MVWq7Iz0MTkzlPnCEq0zLBKeq5bgTVOmA/xebuJzPNUIz6VIWX+KXKxIRrPo0lXGxbhwy
 j2LRLj5NM7AArcvXW9givvh3IVQTUnawoyxicGo5oqBDBn4gwyS4zEB
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

There are no users left.

Signed-off-by: Thomas Weißschuh (Schneider Electric) <thomas.weissschuh@linutronix.de>
---
 include/linux/hrtimer.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index c087b7142330..9ced498fefaa 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -116,11 +116,6 @@ static inline ktime_t hrtimer_get_softexpires(const struct hrtimer *timer)
 	return timer->_softexpires;
 }
 
-static inline s64 hrtimer_get_expires_ns(const struct hrtimer *timer)
-{
-	return ktime_to_ns(timer->node.expires);
-}
-
 ktime_t hrtimer_cb_get_time(const struct hrtimer *timer);
 
 static inline ktime_t hrtimer_expires_remaining(const struct hrtimer *timer)

-- 
2.53.0

