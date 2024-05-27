Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420FA13C822
	for <linux-trace-kernel@vger.kernel.org>; Mon, 27 May 2024 23:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716853525; cv=none; b=iYtLqkRJ0m7DbY8Ezat8G1ajm4SwhEvSmjm1tQN2dyzRs29mPAKL6iXfR9pRjBKWzwCekXHNYKELOUjxeuB6BFYvCgzugH1GWq1XbWxexooO8ivbHBASxnL6ucAB7mU9qhgAn0MIuELi8G82V1NXF/BTQzWb0K5GlkejT0RX/t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716853525; c=relaxed/simple;
	bh=r0I8WXwNICm+VrTNgL8eelRj73Nyj9XjwKgQCzzkGQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g1Tju5bKa8TZ/bnpzu3L7R/IFZ0UvFkTcVjrkm3cGceZoqCBotHCv3llRg7QnkmsaCFZ+9EB0TKhPq94t4oHPFdMtBrdqLmqp6kFLDCXYlx5FmonXDH/aMr3cA7o1YsFnFk8hIQy+lPwf+6YCirPqgCmKiOoIVsDsdtMbIyFzUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=2rH9TvBr; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="2rH9TvBr"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4202c1d19d5so1497875e9.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 27 May 2024 16:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1716853522; x=1717458322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNry0zoFn66IZX3uvbz/6TnygFqmohU9To85tOy+8kg=;
        b=2rH9TvBrRqNzcLEKK21rk6S/c+QXXj2gqSEPIyh8sNmiy3zeDm3gUdpztHFbZhZHmD
         yhx/Wg3cDw27AnbePqkwu3LuiJOQ3krGbAlnkFoM6KdEHfDFP7gl8oiVGBrp5nIQA1gb
         u7wgu/7fUCvP87v+xsOw1xBrBrrL0qim/PHLSl48pUZ+YdmBjquQUmcIxr8hY5HYbqeU
         4aR+01b44BbZZXrSHGXzfM1IXfCVED+Qehmh5SihlPKTn+6S2N7qfJNnyXMiS63ovd54
         JgyhQzFuEktQKRUlpnIsQdBbwi8kHmhQ9kCbTTIpEj+gNrVPH6AmU03oryn6iF4sJvQR
         TtKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716853522; x=1717458322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HNry0zoFn66IZX3uvbz/6TnygFqmohU9To85tOy+8kg=;
        b=kASqg2aTX/y1N8pZHo362b13o79G/4E8GUFc2O5PdQLqv2XtY17nZq0X+QtaVGP4Z6
         xVR4ThoLoBvRhwmw1WZEjBH3u3hyrnTGDdSTi1jLZoSmLrowGkvCInWz6XGUXteLJBWz
         2oN1KY1OBn/uyrot7IfXHELhUb8nzDZe7Id3oTtKozWuHuuXS3zRsQfUklFvTXd21JQN
         rz/VR06djWhfcJJmCwAnvbUCNazGEw9zNFcQaRhLt9fu6NzY4/3ti3FCXiflklR1Wmfn
         /4phCpgt48elZ8Hl1FaoMVQ3m+UMelmv/SGPCEZjHZAjTxBhUWWC0EAX4RxAC1aoBP5S
         SamA==
X-Forwarded-Encrypted: i=1; AJvYcCX1gS2nbq8JM7qitWys2+1QSFt7uLJmlZ52uGOrhmQbn1fCWiiMFXb88lSWyeTxPwf4VsRajvx/vhnIYmamp4NxMacgO+BdC8aOTcAujfdXYKQ8
X-Gm-Message-State: AOJu0YxuWgljGdH9iHsQD9jPxxQawo0WU0e5J9jSHFkT+77e8gq5oTK/
	dA2Kx9xZYqUpLtfI7U3At4+9DsMDlqzCH1EMsMGeNz+fQ5uua/FyXG7sSAlUg6o=
X-Google-Smtp-Source: AGHT+IF9T8Y/YkvAOvS0rS97TuRQ2Ix59hiyfEGtGD745/9EUk8XFN2C3Rg4A4HSPq7FUd53hxMojg==
X-Received: by 2002:a05:600c:4f94:b0:41b:fea6:6526 with SMTP id 5b1f17b1804b1-421089f8d2cmr66410055e9.33.1716853522480;
        Mon, 27 May 2024 16:45:22 -0700 (PDT)
Received: from airbuntu.. (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108970967sm123535515e9.17.2024.05.27.16.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 16:45:22 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v3 3/3] sched/rt, dl: Convert functions to return bool
Date: Tue, 28 May 2024 00:45:08 +0100
Message-Id: <20240527234508.1062360-4-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527234508.1062360-1-qyousef@layalina.io>
References: <20240527234508.1062360-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

{rt, realtime, dl}_{task, prio}() functions return value is actually
a bool.  Convert their return type to reflect that.

Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 include/linux/sched/deadline.h | 4 ++--
 include/linux/sched/rt.h       | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
index 5cb88b748ad6..87d2370dd3db 100644
--- a/include/linux/sched/deadline.h
+++ b/include/linux/sched/deadline.h
@@ -10,7 +10,7 @@
 
 #include <linux/sched.h>
 
-static inline int dl_prio(int prio)
+static inline bool dl_prio(int prio)
 {
 	if (unlikely(prio < MAX_DL_PRIO))
 		return 1;
@@ -21,7 +21,7 @@ static inline int dl_prio(int prio)
  * Returns true if a task has a priority that belongs to DL class. PI-boosted
  * tasks will return true. Use dl_policy() to ignore PI-boosted tasks.
  */
-static inline int dl_task(struct task_struct *p)
+static inline bool dl_task(struct task_struct *p)
 {
 	return dl_prio(p->prio);
 }
diff --git a/include/linux/sched/rt.h b/include/linux/sched/rt.h
index a055dd68a77c..78da97cdac48 100644
--- a/include/linux/sched/rt.h
+++ b/include/linux/sched/rt.h
@@ -6,14 +6,14 @@
 
 struct task_struct;
 
-static inline int rt_prio(int prio)
+static inline bool rt_prio(int prio)
 {
 	if (unlikely(prio < MAX_RT_PRIO && prio >= MAX_DL_PRIO))
 		return 1;
 	return 0;
 }
 
-static inline int realtime_prio(int prio)
+static inline bool realtime_prio(int prio)
 {
 	if (unlikely(prio < MAX_RT_PRIO))
 		return 1;
@@ -24,7 +24,7 @@ static inline int realtime_prio(int prio)
  * Returns true if a task has a priority that belongs to RT class. PI-boosted
  * tasks will return true. Use rt_policy() to ignore PI-boosted tasks.
  */
-static inline int rt_task(struct task_struct *p)
+static inline bool rt_task(struct task_struct *p)
 {
 	return rt_prio(p->prio);
 }
@@ -34,7 +34,7 @@ static inline int rt_task(struct task_struct *p)
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

