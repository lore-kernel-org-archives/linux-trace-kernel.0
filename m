Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1829D14F9E4
	for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Jun 2024 19:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718047227; cv=none; b=j9I4P7c2eeNbuidH5ebyzmcbYUgu8DQi5ROgBm+2UcR79nOrVsIoQYlYQkDjxx4pbGcbOrfIw4ewiGClvO8yfqClC7jT4ndBAcpqS1COB0o+Sypz0Jc+V/OpMbozPVs6pcs0zI3Do/M+FCi+QOk2EkXll3R02G3hun+wB+oe5EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718047227; c=relaxed/simple;
	bh=osm+qh/Kr8Orx2ri9MuXrY6lmGDiwIyif5UE65dXUnQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NBVLN86EAyy3iJoE5ZfwkjB5/v695u71DjTvLpjIdEQUfmVlf6KEikxO7rVMpaPmWa0Dl8CIx6G1iNAvha/vC1qHRBMcbRC0LkP7kRHMjrHZttnsOYQSUHMmTxRIdVikWQcQrnErEq4CX/twhCrzEL40vv/elT7PmdyWKl9+nFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=kiMlit+G; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="kiMlit+G"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3550134ef25so293459f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Jun 2024 12:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1718047224; x=1718652024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aqecuk/j+cWcR1uWGatEcThGq+5RIRJx4qSyiIgAFX8=;
        b=kiMlit+GmFjSMWn6OuG2lnGiGvsKMkKT+9KCH6n5wBuko6t5jAUePVT4M6IwV44i8Y
         zvH+hmTrYprMZcDllMGv2UjU3Yjc7Fyr6rkmnNVDiERq8z4AZpOQr4HxsEKrYPwkJ5LY
         J5huvnzo8Qfbm5w4RH0CLR8TG4sM/KDm/H0ipidNRA1STmbLjl91wsP23vulTB9/t7J9
         u9cUOVubf4ECsN1EBfWy0ldp94VTDzLIC6o+aDf9u6tM4g64oxF29WW98gKSrUhr7SH1
         6U4iIYcToi+vq6k3tSAAiGZUy51wuL9OxjpaY4Hlp85F4AROKLGHlC6eBUrNEaSkhdXx
         rbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718047224; x=1718652024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aqecuk/j+cWcR1uWGatEcThGq+5RIRJx4qSyiIgAFX8=;
        b=hwojftXVfFkRiTWBYXuHqr7+0pVy9zHPui925qiiw6ILUIsz2yRdbVb9Upi+5XKYsb
         aO0Fgea+JqlC/VVJ4XElEW/OS51IyM8S9+ncrt3iZZgalqvDIINzG/vcPC5hkFOqHAZM
         Ic1vpdldjhKG23WEeJnPew9rL2afWqZ4KW+2cmRlrUnuHEhRV5lKxc4zVjVdzp0GnFR0
         g4v+tFZUK46A60H2vYxVjPkxk1x4z/cosmEiolonODhI+1al3CfHyGAcbQU4brl5MRo/
         rpbYETRtJs4SK/GTnJ02WnhU28U2NU5x3BR1og87bwobgM+NiB7px1VmDKbqbk6t0Yuk
         4S5g==
X-Forwarded-Encrypted: i=1; AJvYcCU151urR8hS3Podtii+e5qa4PosdS3cQAsdv5l43S+mP+Sdo7X+NmfcnSLNZG68LvvFLszwgyD4HfrRWBig22sQQtyL49BLl/CCVz1YcM+x/S+0
X-Gm-Message-State: AOJu0YwJAgwd/PqHGahwiJCwWp9JL+Ub9TQE6FRrkemsXBnmT+rB93m+
	LSn4nJ7oDKgaBgvD3B2UwP4sX+PUwV2zEXwbhZnYKlQN6wQPV/r3dYy82fCjVV0=
X-Google-Smtp-Source: AGHT+IEPW9YFcQ2VxHIOQv4sUvLowLBf5ILbQcop/NQ40oDtk2hX5iHMJ7fOb4sgyat3imPvhg5Q1g==
X-Received: by 2002:a05:6000:154c:b0:355:2db:a0e with SMTP id ffacd0b85a97d-35efed1e599mr8511407f8f.13.1718047224576;
        Mon, 10 Jun 2024 12:20:24 -0700 (PDT)
Received: from airbuntu.. (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f1f30c3ccsm4988326f8f.7.2024.06.10.12.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 12:20:24 -0700 (PDT)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Metin Kaya <metin.kaya@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v6 2/3] sched/rt, dl: Convert functions to return bool
Date: Mon, 10 Jun 2024 20:20:17 +0100
Message-Id: <20240610192018.1567075-3-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610192018.1567075-1-qyousef@layalina.io>
References: <20240610192018.1567075-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

{rt, realtime, dl}_{task, prio}() functions' return value is actually
a bool. Convert their return type to reflect that.

Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: Metin Kaya <metin.kaya@arm.com>
Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 include/linux/sched/deadline.h |  8 +++-----
 include/linux/sched/rt.h       | 16 ++++++----------
 2 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
index 5cb88b748ad6..3a912ab42bb5 100644
--- a/include/linux/sched/deadline.h
+++ b/include/linux/sched/deadline.h
@@ -10,18 +10,16 @@
 
 #include <linux/sched.h>
 
-static inline int dl_prio(int prio)
+static inline bool dl_prio(int prio)
 {
-	if (unlikely(prio < MAX_DL_PRIO))
-		return 1;
-	return 0;
+	return unlikely(prio < MAX_DL_PRIO);
 }
 
 /*
  * Returns true if a task has a priority that belongs to DL class. PI-boosted
  * tasks will return true. Use dl_policy() to ignore PI-boosted tasks.
  */
-static inline int dl_task(struct task_struct *p)
+static inline bool dl_task(struct task_struct *p)
 {
 	return dl_prio(p->prio);
 }
diff --git a/include/linux/sched/rt.h b/include/linux/sched/rt.h
index a055dd68a77c..91ef1ef2019f 100644
--- a/include/linux/sched/rt.h
+++ b/include/linux/sched/rt.h
@@ -6,25 +6,21 @@
 
 struct task_struct;
 
-static inline int rt_prio(int prio)
+static inline bool rt_prio(int prio)
 {
-	if (unlikely(prio < MAX_RT_PRIO && prio >= MAX_DL_PRIO))
-		return 1;
-	return 0;
+	return unlikely(prio < MAX_RT_PRIO && prio >= MAX_DL_PRIO);
 }
 
-static inline int realtime_prio(int prio)
+static inline bool realtime_prio(int prio)
 {
-	if (unlikely(prio < MAX_RT_PRIO))
-		return 1;
-	return 0;
+	return unlikely(prio < MAX_RT_PRIO);
 }
 
 /*
  * Returns true if a task has a priority that belongs to RT class. PI-boosted
  * tasks will return true. Use rt_policy() to ignore PI-boosted tasks.
  */
-static inline int rt_task(struct task_struct *p)
+static inline bool rt_task(struct task_struct *p)
 {
 	return rt_prio(p->prio);
 }
@@ -34,7 +30,7 @@ static inline int rt_task(struct task_struct *p)
  * PI-boosted tasks will return true. Use realtime_task_policy() to ignore
  * PI-boosted tasks.
  */
-static inline int realtime_task(struct task_struct *p)
+static inline bool realtime_task(struct task_struct *p)
 {
 	return realtime_prio(p->prio);
 }
-- 
2.34.1

