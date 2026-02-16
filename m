Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE6723A9B3
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Feb 2026 09:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771232510; cv=none; b=mxYQqzRwMEp0Ga9sCrtZ7n8ox6cuHyo7C4ZjquGnRfA9QpnvT45kwoxIal83DOsW7MknVl8HDZwrUOl588PStVWGcEhXXakX0U+cReA85OLTfNPyawAj/WAL8yj/qwV073HCD3PJ6+B19JfpU7WNPtUnu9WTmKLEMpbHzY+NBDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771232510; c=relaxed/simple;
	bh=JkPMAavzwLTFq8prvcAV3K72XwnVPZLy6KPEo0Issqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HUvlEMRp/WnWny7p3j/QZk84wdt/AszMUMFBsdszrKQsF4zNtjjn2NZ+9LLOSOLsVTVqTkp73OCFMWpq6BwzIQrg3dpOFQVphx9P/Z2or6SvJ3szSiPemxn1csJEySHm+WZb+2tATe61QVgXGm9A9K/s7VXr5D619OMSPvn6uCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GaDvnxHP; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaDvnxHP"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-59e6c181402so3684998e87.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Feb 2026 01:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771232508; x=1771837308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwldnQ5cJQ78NY64Pq9I1WXhiqI+ltEK3WKmy0FwY+4=;
        b=GaDvnxHPtavHerKwQ142m5wazvlFvAr797kt8QXX7ApPd2aQ+7U0hVW4KeWM8no7Ya
         QYNVHsWKHcBfXZPi+WXTulIwdWzhR1LYxn5AyHoZPJEmAKvF9jFjjLBsR/0271NrOmZi
         kq1kmmCILpeAjuQ4OuRunO7oLJZGxEaBZH0JTywVV3bNwc2La3hTZOnDyxW+1SQ7w6hS
         1l1IuvfGd4L5hm20vcs3KFE2ELJOLN7kCEEyAyrdfcNagFJmB9UEVekAQGIwpUGpeHOV
         2XC8sjrQHz4qyQV57F+SPNrQeD8xZoV3rT3vWGOVzGDsDvUxV3EdIvsBAectjIIbVV9b
         ygOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771232508; x=1771837308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RwldnQ5cJQ78NY64Pq9I1WXhiqI+ltEK3WKmy0FwY+4=;
        b=MmMAGZacrD2u5UByqireubpvmu/gag5kFbfS3jmUMOtxhMptXKQnrv6az22lf/z6KR
         PPF56o10PqG5JjI5y9zj1gamBLQCtPI+TE5+U3DIxncUx9/GrwImbAqJ78ycAysSwJPv
         PrQIwqBxgwCI6gOJRVpWJmaY6ahe1ZWORmC2wZd3pfFw5YD0gPImju7oS6LXarCudHru
         L827AKN8Hu/vRhP1jbEB1MsJokzD99vViuvsOkcVa2odj0fcKJndwcW+GIG9mLpAP9bJ
         gfezT/UoSyyODmzcXixSYJ9gGi06OshmY3uhtKihWY0S57+x2pc4ayXs+E2c/ABNNgx4
         4xUg==
X-Forwarded-Encrypted: i=1; AJvYcCXV7qQgv4iuDZm+Ic2Sy1jtt1xWqhd1gM2WYkVNh6tOouB4XFmRDQ1QsFODph1CD3EuIhmV4LrI/pctt02Tk3z/9lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSaQSCX84UZy1vLFhFseaiSy9mF6HdOP7dtBJutvaKFE5Xpeam
	wWK+g3tEmfKjuiW6opLaKCd+BJk3A5052N/klRjFyTMRN2i0c6J5hyDw
X-Gm-Gg: AZuq6aJKn9pPmxtRbMtEOxXcKdX/RQExbP79hFmo/pZaSZaxdefgkN+PZdQYpHjuy6N
	zdauJLdSnyfgtWOf7y0B3uk2e09gOpULDdbOR6mJkddDOUIQ0jLUWaxSLNyDWtKwm3LiSKKnKSv
	SdSkR1KglxrtMk560p1YyheK5PI226KiL29xCT1uRoopP4qzUQtifRwsh1IICjO7EgnpcIjY4Cb
	KAle4308sBzxOL8Dd6PWQhhFLCOEztZYqr9nKKnMoMAYEr1TkAiqOssbY0aGGQb7pe4vfkiVDp7
	tjnMDCQwD6thFK59QsczNH0DKjz6rQ0QVAhOLGvd9kXtktAAZ2Q40lVJNF6eEe4n5h03RSmRuNX
	HeEwwu8akXZsIoAZwVMIbS75h3523rWrJcO1M28yBLR3BIyJC2gwtUl4MaqdckabxcTN07m8wYu
	GViTzBKd8PU+lgKj/8G6SSnUIe2QcPcYeRkg==
X-Received: by 2002:a05:6512:1113:b0:59f:70ea:29eb with SMTP id 2adb3069b0e04-59f70ea2b81mr1424942e87.26.1771232507336;
        Mon, 16 Feb 2026 01:01:47 -0800 (PST)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e5f56fe99sm3141647e87.36.2026.02.16.01.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 01:01:46 -0800 (PST)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: Gabriele Monaco <gmonaco@redhat.com>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH v2] rv: Fix multiple definition of __pcpu_unique_da_mon_this
Date: Mon, 16 Feb 2026 14:01:41 +0500
Message-ID: <20260216090141.757726-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <628790bb5ee45c8968550a54388862f020d014ff.camel@redhat.com>
References: <628790bb5ee45c8968550a54388862f020d014ff.camel@redhat.com>
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
variable __pcpu_unique_<n> for each per-cpu definition. The requirement
for this variable to be unique although static exists for modules on
specific architectures (alpha) and if the kernel is built with
CONFIG_DEBUG_FORCE_WEAK_PER_CPU (e.g. Fedora's debug kernel).

When multiple per-cpu monitors (e.g. sco and sts) are built-in
simultaneously, they all produce the same __pcpu_unique_da_mon_this
symbol, causing a link error:

  ld: kernel/trace/rv/monitors/sts/sts.o: multiple definition of
      `__pcpu_unique_da_mon_this';
      kernel/trace/rv/monitors/sco/sco.o: first defined here

Fix this by introducing a DA_MON_NAME macro that expands to a
per-monitor unique name (da_mon_<MONITOR_NAME>) via the existing
CONCATENATE helper. This restores the uniqueness that was present
before the refactoring.

Fixes: 30984ccf31b7 ("rv: Refactor da_monitor to minimise macros")
Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 include/rv/da_monitor.h | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index db11d41bb438..7511f5464c48 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -20,6 +20,12 @@
 #include <linux/bug.h>
 #include <linux/sched.h>
 
+/*
+ * Per-cpu variables require a unique name although static in some
+ * configurations (e.g. CONFIG_DEBUG_FORCE_WEAK_PER_CPU or alpha modules).
+ */
+#define DA_MON_NAME CONCATENATE(da_mon_, MONITOR_NAME)
+
 static struct rv_monitor rv_this;
 
 static void react(enum states curr_state, enum events event)
@@ -183,14 +189,14 @@ static inline bool da_event(struct da_monitor *da_mon, struct task_struct *tsk,
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
@@ -223,14 +229,14 @@ static inline void da_monitor_destroy(void) { }
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
@@ -242,7 +248,7 @@ static void da_monitor_reset_all(void)
 	int cpu;
 
 	for_each_cpu(cpu, cpu_online_mask) {
-		da_mon = per_cpu_ptr(&da_mon_this, cpu);
+		da_mon = per_cpu_ptr(&DA_MON_NAME, cpu);
 		da_monitor_reset(da_mon);
 	}
 }
-- 
2.53.0

