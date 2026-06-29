Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7CC3B71DE
	for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jun 2026 09:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782727146; cv=none; b=W0Id4G8o7hCpgdQuGWQTjYyKe6oCeOyn3lHqRmlcU92PaXq4bePvB4oo7ndXmKo1dUD/i2W6vl9/5oYk9BuZ6c/BAKpQV2BSO5tevsUcB2KezvsDwg/iCv0k/SNQ2p5kKwHzLpefoqdaA7sX88NHiXFr3urC2eim40piJiYloyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782727146; c=relaxed/simple;
	bh=4FjJMIJIqV4UpdTxqBp9mxXGDEPdHlUbmfRxRfFRVHU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dOri/tR/sfQ5zpZM/mtRoeSOgjq8aBc6NmNsdiL/i1kdF0rkvsIGUknKv6w2O7liLQ9rVW3X+5wGW7dQu2gIXFU2nMnZJg/3onw1O1kQuclr0mc4j94F6Btt4iumdadUBVZFF87K/cnItoRCJ3XgXrCzgH17hKQVTkI7cw+rRso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtiTJJVh; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtiTJJVh"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-37d70036426so1250315a91.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jun 2026 02:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782727144; x=1783331944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CIOSdeAgJ4xdVXXOLPnviXzuudcbRcbd9u51YC2jtkY=;
        b=NtiTJJVhs4RTer+08psl3YOBnJ9QqcWtNSm67uNIeoJa0LF5Zaz+m5EbcHqmHoT27x
         VgU4dX/ULVZQBPYL+BIcuiXUrZ2i5KsDXq5YRQV49iDVkITHAZ7a8Ci23ABhP5ctkYl7
         QW6hXtzw5F3R3jH+qRPJ1i7hDoLeemU5Q3qNaBlewGHnPCly3ED6IoMwpbFGCXOTEnus
         YlqKsGSgSbSGJAiHsAKi7qdqTnQl363Cn7hs15tdHLrwW+kUZ8uk37OMw1xv0xecWoee
         q/7GwvhDtHVzhBs1SiY93ddYa6VwmoDgjZNOI8gw33PLzgBccfD2sbUUcdNP/xTqEPlt
         peHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782727144; x=1783331944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIOSdeAgJ4xdVXXOLPnviXzuudcbRcbd9u51YC2jtkY=;
        b=EdB72KaKWl3NIDyO9pfwEkInXLMvA3RxZXjwzCiHRo7mrymkDPFA0J9mR5IotgAnw5
         N7jTBfkceRL3sFETKZgv0QNE6G41APapYoATRCZaiOqbvRsEFHcj5YkEcy20djELG9Xw
         mFhq03gX5TUo0JAdIl/AViYwEwPVXkviIgMo7sdmH+qIZHqLg8thfBDY8f9vyDB744nC
         emhL/N0JujhKZb0ZiNTutgftj9YbdMiyCbu3HhufDa0KjhEJP8osuEqXlUNjWYB3m9c3
         JO0lVbUUfkmLvObfFDr2XmHzBq1FomHK3pzq+vXy3BXChMMUdDnDnz5nLXSoz6XRDwLq
         2oqg==
X-Forwarded-Encrypted: i=1; AHgh+RpHE2DgUCG4yDWHYbQ/LMGwDtD1YQWP8gWnDPNCLwBPlqcWhmCdma9+8bB/eQePu0D/rTKg/p8QiOfF59SXmSoljio=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEIy0QUT0lk9WGHhGkgRMoqW6gBFUC9bCJDEUyWRFhCVukAX9t
	NU6mOlvcVTErxBdijxX2m7KMmY542ID5g8nu4acM4BkVTrNCFI9dYA8e
X-Gm-Gg: AfdE7ckIDPew7IDZC9kaBixyVUk+jdHZrDdikKSRHL9o9tXKUTkluOaKjvBBbRIrsb8
	AWbaxsY/lat73if2FqQlQoTqtALKN5xPm5YceAe1pnCbhugKkvkxYq5HupTrocLt1Mq051uatjK
	xVigbyeMhPkbvxYecXnT86FbbPpdvIkViQoYDuM6y9qARY53ekFy91lsxFSki2Lp1SRazG6wH3T
	J4j3UtYln3+qnE+Ws2+qwMxXmKyK2s0SUWe1uf6xtdEn70ilpOVDKGDZ5la5W/phH8CXk0Wm9uh
	UhQe79fZNYGT6DIFhq/n6Kq/oA6X5cA7pFD/VUz/6UGy1K78LLewiQcuhvP0+T3MQhBnhRhRonz
	60L184c5PVabcP15VDSE/ntQBOjLQZx8dph8vDUjWeYctJEOktjGPf7dg1cqspSSdrl1kPDx/So
	u359iH
X-Received: by 2002:a17:90b:57ce:b0:37e:2005:6507 with SMTP id 98e67ed59e1d1-37e20056697mr9153254a91.15.1782727143321;
        Mon, 29 Jun 2026 02:59:03 -0700 (PDT)
Received: from martin ([2405:9800:b862:14dc:12ff:e0ff:fecd:7ddc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37ed2a68075sm5081813a91.10.2026.06.29.02.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 02:59:02 -0700 (PDT)
From: Martin Weiss <martin.githubacc@gmail.com>
X-Google-Original-From: Martin Weiss <Martin.weiss2410@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Martin Weiss <Martin.weiss2410@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] trace_branch: use per-cpu counters for correct/incorrect stats
Date: Mon, 29 Jun 2026 16:58:38 +0700
Message-ID: <20260629095838.601926-1-Martin.weiss2410@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace per-task counters with per-cpu increments to avoid race
conditions in the branch profiler fast path.

Fixes FIXME about atomicity.

Signed-off-by: Martin Weiss <Martin.weiss2410@gmail.com>
---
 kernel/trace/trace_branch.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_branch.c b/kernel/trace/trace_branch.c
index d8e97ad798f0..960bcb3d7dbf 100644
--- a/kernel/trace/trace_branch.c
+++ b/kernel/trace/trace_branch.c
@@ -213,11 +213,11 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 	 */
 	trace_likely_condition(f, val, expect);
 
-	/* FIXME: Make this atomic! */
+	/* use per-cpu counters to avoid contention */
 	if (val == expect)
-		f->data.correct++;
+		this_cpu_inc(f->data.correct);
 	else
-		f->data.incorrect++;
+		this_cpu_inc(f->data.incorrect);
 
 	user_access_restore(flags);
 }
-- 
2.54.0

