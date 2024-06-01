Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BAE20DF7
	for <linux-trace-kernel@vger.kernel.org>; Sat,  1 Jun 2024 21:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717277615; cv=none; b=dN2QGQDIAf6t3pbp+aaitP74SvsRaOAF6CYtXJ5aYYh3S8UbWA3Yeh3Ylxhz1qE0TgS/vhuoJJ4WAioqD+9iA5AMZMs6kMSg1bIAlFplHNXlehhE9z8egbNHvXreQHvNQcjc04ha2NJ67+4wNsaT2uYkRjCF+XubKKsv/jxhHBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717277615; c=relaxed/simple;
	bh=O8JuXN/F7C9Ahr23boiRySLU30zszNQXarX6RobRxdc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L8JGiBI75tx8MtaY3PMS927uW+mPqTxevCZgESsfjHiJZldw06m91l5iorFIbk0YXN7+OPuBw+fg9Amqf0yNUUBEu5FExICj/reE3+d5Z1D1fmaF5ETWezPDDASjQS9l63dQIDyQFIGMHyxJWLRonUsBmJcsUkwdfVvKw9dX1ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=gsCHRutT; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="gsCHRutT"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2e95abc7259so34233021fa.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 01 Jun 2024 14:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1717277612; x=1717882412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3sT0UxPJVsFvbizWQFXaFxd+myFLbvt1Djq9NxHiO/k=;
        b=gsCHRutT+kkmDaDw99jdqRf4h1xDF/cC9Jm4Ym/eV0Ly4NNEN6JdUMV4lgMFGJx26Q
         08fT9CRM5LZSvPxdS/JZ52OPmwPJYJG46ca9sXEqrCqwCxpcdGcMHjXduDQDpDPGR6rj
         RmYt2I7xUPy4YzZ+qseoBshXeMlrFd57aiK/LxtqkCTvTkXNua/yOlg2QJIwSykoozRR
         F0KaTZegWZI3PpfgRYvwINALTlsKABcK8W6+p6r2ri9Q5RFhkqY7FSk0Vs4zNW2LVWFI
         nRrf2roBbiYoXd8SnU3/9F1X1uNLlxOvs75pdkbQMMvw8NnsS0Zzy2i3dYBcGTmsVIah
         lFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717277612; x=1717882412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3sT0UxPJVsFvbizWQFXaFxd+myFLbvt1Djq9NxHiO/k=;
        b=omHuJPhZ6cV6FHS/PES62CB+hx+XF6O5Sauw0oSC+oiyLiD2YyumK8WRPyticLtjVD
         w5nKIo71XBLWAzPjG8kqa2eMELU5AzKiqT4fePXl6uRI5Mr902LAl0Qf+O0XTvnpMRwl
         dSb1uFdWo/P4MHfyFPoG4aecJX5HGZ1VRV80x+lCw9HSO7GG2ocqy6z4gjEcU/o6SrNL
         nxSNWqVfczhCNfmzO/50XisjpVhQ7zLXsaQ2Ta4o+6oGBaSy9IkPjU4Lfu1fpJxQzeY4
         hpAqQ3TRe/dg4K4/CnHOURBh+t2sEg2uE00KeKzkBBnuAfXb8qeVA7ftgX6mSekZSFMJ
         l9ag==
X-Forwarded-Encrypted: i=1; AJvYcCUQZ7vIbXo8UbsdBeP7XXJI1NzW8D+77nAbMfUxtOnexZrPhxgsmNE4dcJGiUlO74Q3TenHw3LXBA6tpbQyhYlAQrNHJLXJ0aAvSU0W0fi8GYOo
X-Gm-Message-State: AOJu0Ywoy05RuRecXmYHMiJfT7sdQTQ8y60+/txS27pVIak65B8zBcsF
	NwfihhMMhCWF//zERd/5O2G9vHE4ZkD8kE279PCGI18QioSDiu0Ab3lTsrq4UAI=
X-Google-Smtp-Source: AGHT+IHTtXDQYUCHcup+VdBP7H+9TJT0tVCvzBLqaigZ6UCn3zIJ6feyXGCuTgk0t3iYmSADXLLaag==
X-Received: by 2002:a2e:8e62:0:b0:2ea:7954:3777 with SMTP id 38308e7fff4ca-2ea950f8c22mr29792601fa.18.1717277611480;
        Sat, 01 Jun 2024 14:33:31 -0700 (PDT)
Received: from airbuntu.. (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04c0839sm4751324f8f.23.2024.06.01.14.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 14:33:31 -0700 (PDT)
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
Subject: [PATCH v4 2/2] sched/rt, dl: Convert functions to return bool
Date: Sat,  1 Jun 2024 22:33:09 +0100
Message-Id: <20240601213309.1262206-3-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240601213309.1262206-1-qyousef@layalina.io>
References: <20240601213309.1262206-1-qyousef@layalina.io>
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
 include/linux/sched/deadline.h |  8 ++++----
 include/linux/sched/rt.h       | 16 ++++++++--------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
index 5cb88b748ad6..f2053f46f1d5 100644
--- a/include/linux/sched/deadline.h
+++ b/include/linux/sched/deadline.h
@@ -10,18 +10,18 @@
 
 #include <linux/sched.h>
 
-static inline int dl_prio(int prio)
+static inline bool dl_prio(int prio)
 {
 	if (unlikely(prio < MAX_DL_PRIO))
-		return 1;
-	return 0;
+		return true;
+	return false;
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
index a055dd68a77c..efbdd2e57765 100644
--- a/include/linux/sched/rt.h
+++ b/include/linux/sched/rt.h
@@ -6,25 +6,25 @@
 
 struct task_struct;
 
-static inline int rt_prio(int prio)
+static inline bool rt_prio(int prio)
 {
 	if (unlikely(prio < MAX_RT_PRIO && prio >= MAX_DL_PRIO))
-		return 1;
-	return 0;
+		return true;
+	return false;
 }
 
-static inline int realtime_prio(int prio)
+static inline bool realtime_prio(int prio)
 {
 	if (unlikely(prio < MAX_RT_PRIO))
-		return 1;
-	return 0;
+		return true;
+	return false;
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

