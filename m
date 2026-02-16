Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B162DAFCA
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Feb 2026 17:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771262838; cv=none; b=Aiq5s+E4f9anMMilxIrtAsXJby4UydFfJZvyvipMeKjsnGs9sCP/sijAaMG2i6rP7ItnA4mxh95Umwxnz7JZXaNraHO6SEYmlgKh+0JLCYWDeWcIT0AzwoKzLorrT/WqPws30nlEAF0VmOhDxdKU5Jatoe2/8rd2Hm83CaZ4LpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771262838; c=relaxed/simple;
	bh=ekHiVyjqiaGWoE6RXaxfHJcPuigOMr+k1bVFfn5BEgw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AumuUWyU1sfe6u2Xpl986yr/5+Sp5ewC1TRFxLcHNAUSC/knNyQoBbQR6JgmfU5VDORiNlgYPSr5acRxJ2qRKrxA40cyxt7pVd6gz2xt/wVJSky1xJd0NmrhYTIiKDPMikY5TC1SA9qo2r8mtdjfxE2kiyutrj0wCajlVPiHBeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wp5D+yBI; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wp5D+yBI"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59dd54b1073so3865647e87.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Feb 2026 09:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771262834; x=1771867634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f3LfzZMm5dzBOXfXpr+wyEgw8UjxM0o7eUchqH58TlY=;
        b=Wp5D+yBIgHVQSCantxJItfvS01Dm28smNHlZKImim+JvaSI7Nqs9Bes+gnnhesSjUx
         c/Grto65zCAb4Zr50arCvUiquIbCEdeeT5oTl6MsJQCiR0XpwigG+iR76MXJ7A+zDP8a
         6/7hatSVC61dPAmYI3R707I2ChvFrpMg+ubTNZYpQedA0i+3KOfyUV019CpiYh6LmvM5
         H48hxMUKwbynbSZZlu8g+CrSpvLMjex341HEjtR1XvFqMHD0Ci0qIi8AqViOZG8fU4N3
         iWR3Lz98M9Tc9Dp/qEJz4ySV/1JLEn+oJn3RmwGI8HcTST9y6YgRMZ/1+xd3b5A8RkPv
         3R+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771262834; x=1771867634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3LfzZMm5dzBOXfXpr+wyEgw8UjxM0o7eUchqH58TlY=;
        b=hIZfoLFwad21rqYslV7fLPbqZyGo2vKHO8i8iYVPTLaAel6m1vx3mmy+kE7plSeIsN
         RVhUhQLPYTYXJ/T5jpYVezcEBXk41BwhUSqLa3mxLh34lhDHqbJG3OnQ4TVT8osC3Pba
         Z9kbCnIUL2PYOE0ZiUnRUSU3Z9/mmfzim7QDYRq+l3bnUbuELd9+COyxEvZLDLFWVata
         TknbWkXc+aQ2myg2OO9Y7taEJsS3yg95mnXfioKfwHRA4wcij1IzMdUuKW4V7mCkrB2l
         qOfGpKQ2497nlDHclgP8Qt2j0jWetH8thWj0r3n209PdcLGUM9MLZMDQUFAvKrjIcp2Q
         VNkA==
X-Forwarded-Encrypted: i=1; AJvYcCX/9WWC8nlxSZX+Q+nBQqmDH4cEKzdTwlnn9ZjxZFzCOmSkmAYATWew5vOtTjK+BqfubyB40dWX+fsOZP+HSDI6pR8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7uJOxTPAK/QvE7JuLTKMNpwpxWidKL33Rsd3nVYXqk/w6tqzr
	EwvvF2T7nd2V2/kxEhojKaXU6AoKpao2xzhQl5JkhnPvf8OnXHTCn7RH
X-Gm-Gg: AZuq6aKXbPMeE9FAFV0LU+p30v7xpMWcEDGh7If4PY9Pto7EWNjvbMZqMPfPQdzjYjq
	mhlY96yCs1TN/gFRKltrjh0FBarxPYYQoAZhtOTdXbVLKNgZdq+/pQQl7qM9NMJuIPNnCM4g3k5
	zAMAvHQorIkSMzrJO7aivPHfvVurAaTFk2X3nq60ZLNSNzPdZWa4oibhTvYWj39nDUOJfJQPLME
	6vxXDrZvi0dOP5rviWuw3a0Z02s7t9UBxu2bWO0Rlgm5Nui55x+TMcGil+35MdsvyCMpt6nFwg3
	vyKYUC9dN76TXQO2Gt3fEm2MzCqdCm0pUqFwzdzP9gGrzZ0oQxPf05TZPGMOpstyH6LcQAapblH
	tNdRjId20ZmOtHBlCsTZZYfrZYySqRYb8TEkqWGITRSSkPhsw0Ubmmnn4Bhc5p4lA4zdVPwQVqZ
	BighVgGDK+oJB3dctt4mpHdcGk38avMMRj1ga2LpZF4AQ8
X-Received: by 2002:a05:6512:224d:b0:59d:e7b1:419e with SMTP id 2adb3069b0e04-59f6d34cf47mr2685656e87.11.1771262833724;
        Mon, 16 Feb 2026 09:27:13 -0800 (PST)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e5f5b062asm3322901e87.73.2026.02.16.09.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 09:27:11 -0800 (PST)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: Gabriele Monaco <gmonaco@redhat.com>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH v3] rv: Fix multiple definition of __pcpu_unique_da_mon_this
Date: Mon, 16 Feb 2026 22:27:07 +0500
Message-ID: <20260216172707.1441516-1-mikhail.v.gavrilov@gmail.com>
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
Changes since v1: https://lore.kernel.org/all/20260216074727.47292-1-mikhail.v.gavrilov@gmail.com/
- Updated commit message with details on when __pcpu_unique_ uniqueness
  is required (alpha modules, CONFIG_DEBUG_FORCE_WEAK_PER_CPU)
- Added code comment above DA_MON_NAME explaining the rationale

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

