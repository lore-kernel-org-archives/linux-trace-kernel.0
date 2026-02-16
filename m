Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179EC24E4C3
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Feb 2026 07:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771228060; cv=none; b=L8vxd1Jsdf690kAk+mUQxkPVIX05B+22P4mpq4M8FxnFV7HnqTKAyqZXZ7XX/alN3LW53jhLY0l9t87ekZ48661LGi08vgo8uwJfyKOyKSPO1NpoxNjj18LcKvyCP+R7uXcGHFvIUQM/pryIADFsRCPosNuT2wk76fbbaqIGjaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771228060; c=relaxed/simple;
	bh=Z4QDTJNEDvGpW1kJiYtBNO27/JzZiYoj3e5OHA7c9sY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rhxV4aMOFFY8Dcncny6nWxPIlW+DucP6mx+B8GB5kaqRdesZMowAvhLy9q4kxeGMlIcgCjBhZKqzd94Un2C9LOVayBLwF8Vy7bmn72p/V015VM4hzsSzp7TqHXjrt6YfFbFi54eLOvzsY38heJ1kzrzMap2tl5QPOYSlGyR0w/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E//y5Ot5; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E//y5Ot5"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59dd4bec4ecso3331631e87.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 15 Feb 2026 23:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771228056; x=1771832856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OliZMof4JGqGAI7mR9RpknyBqlfF2jHZ//xx+NGaeTI=;
        b=E//y5Ot53wsJ7BP2d+NdMlXjVyrmNV6FuCdLdDH2/wZ13V8dSgoiPbk/LXtzEzYxr3
         SPlSr09+M61sqBhdDZI3Qsa5alBXHKP3emEDJyJA9pt274tBA4ZjCMDk25r1sHCtmhIR
         CKOBtxZBQMcGlQV81fzQgkgNvrFPRoTl4jxgbsjmxdbEhRujfEu9J0L7rhH9L8cxJz2G
         bBs1FxutepKMuLiuUUXSfC/NQNLHrEOtVIa3EMZgngtwszMw5n0rX0ntdGgapmH/SROY
         fJYWdWtnwJarUIOj41Iddvu51Fvjjjs61rxE7o3dP+tAcbLnXKM3C3PrYfFQg0/iWG+U
         8xzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771228056; x=1771832856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OliZMof4JGqGAI7mR9RpknyBqlfF2jHZ//xx+NGaeTI=;
        b=SnjaNbJA+JvSbe3ZhKqfu0ZG/EV86ELNac7qpsFO2lfq8pPtB6tiWsvQHXySOYjb39
         N4MPRR/aR7w07EwTP1qDpBrI4paSloHhm3yTcbRb0OOTFiNKEs5xs4KzeZbW2rJxD0ru
         3BDa74CyJ0awTcOJcx8Xoo9h9/Bpm5HCd5CF3YpARk23D2ty6KAW0KDWJ/DDMJlZmPj0
         aBcCuwFsa3jCX2D5c8hFCoNVqzU5aR8HEdT7pF0Xlo499/GqGOFaLw2f8CXaNtKpSlQR
         bdZT0bJg3EE3cqEh5TmHhVCrvdhr6VhISNaUge9qrSdUTO0hyypE4rTLNxamANrcZMPw
         fNXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwGaQGiBEjMHiACS14SczLPp50toff9ROwQx3pHH6WxsSOvbJEWZBLMcopdqWlKyXgUg5IIPVrA6AZJNtLdLS6Pug=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCX7ez0d+irP1HDDw1kocz+57TX4kK95XgC2mF9mzR9TcT3eEl
	byiZCKf4xek60hfR2rq1kAQrWvQbDIOuejR955yjUaBPDCsyVwUCiVJ5
X-Gm-Gg: AZuq6aJf23s/njSetdAiLXRCEyEgi1D2S6VvvH+C8C4az7RRoD28jnKutMrllNlk9dR
	5B1jOw0A5g6Qqe0i5EHwSFE46+pvK7h8aCIs8T9ciIjnSnaOMgk/ePQecw/BgDJ7exMuVIQfoDL
	k1jlE1uQlRfOef2jty60iJmgKPRYSI4mMFkuJkKoaxMRqcMmsv/zJk/DvrIGPYSXV2NiXRSj6wA
	oIWAyCkyT9uvOht+vURWiSc5+1FkUFiZaVRHJBh8h7N4bef8KOsJkVPDRkA+HRzS7jMO2q32HEI
	IogMTXQtbKRoZVPWckZO+Jiol5palD27V/Q+0C9YUuaBgjwD5TF5z9KgrpNKoXbNO+nTP7eb4aA
	7tii0BWu30P/ur206KtcaNwFvmkebtUOAlOSif0+8apb85i8XMNYxsnEmLX0CGOdhk+Xj4WyzVA
	oWqKh46obgkQM3GWJnAu8FyvEEaSTQB0WCkQ==
X-Received: by 2002:a05:6512:3406:b0:59f:6be2:28fd with SMTP id 2adb3069b0e04-59f6be22de4mr2902968e87.27.1771228055904;
        Sun, 15 Feb 2026 23:47:35 -0800 (PST)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e5f5635ddsm2984958e87.12.2026.02.15.23.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 23:47:35 -0800 (PST)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: Gabriele Monaco <gmonaco@redhat.com>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH] rv: Fix multiple definition of __pcpu_unique_da_mon_this
Date: Mon, 16 Feb 2026 12:47:27 +0500
Message-ID: <20260216074727.741822-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The refactoring in commit 30984ccf31b7 ("rv: Refactor da_monitor to
minimise macros") replaced per-monitor unique variable names
(da_mon_##name) with a fixed name (da_mon_this).

While this works for 'static' variables (each translation unit gets its
own copy), DEFINE_PER_CPU internally generates a non-static dummy
variable __pcpu_unique_<n> for each per-cpu definition. When multiple
per-cpu monitors (e.g. sco and sts) are built-in simultaneously, they
all produce the same __pcpu_unique_da_mon_this symbol, causing a link
error:

  ld: kernel/trace/rv/monitors/sts/sts.o: multiple definition of
      `__pcpu_unique_da_mon_this';
      kernel/trace/rv/monitors/sco/sco.o: first defined here

Fix this by introducing a DA_MON_NAME macro that expands to a
per-monitor unique name (da_mon_<MONITOR_NAME>) via the existing
CONCATENATE helper. This restores the uniqueness that was present
before the refactoring.

Fixes: 30984ccf31b7 ("rv: Refactor da_monitor to minimise macros")
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 include/rv/da_monitor.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index db11d41bb438..f6da07863ed8 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -19,6 +19,7 @@
 #include <linux/stringify.h>
 #include <linux/bug.h>
 #include <linux/sched.h>
+#define DA_MON_NAME CONCATENATE(da_mon_, MONITOR_NAME)
 
 static struct rv_monitor rv_this;
 
@@ -183,14 +184,14 @@ static inline bool da_event(struct da_monitor *da_mon, struct task_struct *tsk,
 /*
  * global monitor (a single variable)
  */
-static struct da_monitor da_mon_this;
+static struct da_monitor DA_MON_NAME;
 
 /*
  * da_get_monitor - return the global monitor address
  */
 static struct da_monitor *da_get_monitor(void)
 {
-	return &da_mon_this;
+	return &DA_MON_NAME;
 }
 
 /*
@@ -223,14 +224,14 @@ static inline void da_monitor_destroy(void) { }
 /*
  * per-cpu monitor variables
  */
-static DEFINE_PER_CPU(struct da_monitor, da_mon_this);
+static DEFINE_PER_CPU(struct da_monitor, DA_MON_NAME);
 
 /*
  * da_get_monitor - return current CPU monitor address
  */
 static struct da_monitor *da_get_monitor(void)
 {
-	return this_cpu_ptr(&da_mon_this);
+	return this_cpu_ptr(&DA_MON_NAME);
 }
 
 /*
@@ -242,7 +243,7 @@ static void da_monitor_reset_all(void)
 	int cpu;
 
 	for_each_cpu(cpu, cpu_online_mask) {
-		da_mon = per_cpu_ptr(&da_mon_this, cpu);
+		da_mon = per_cpu_ptr(&DA_MON_NAME, cpu);
 		da_monitor_reset(da_mon);
 	}
 }
-- 
2.53.0

