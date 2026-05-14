Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34325405E7
	for <linux-trace-kernel@vger.kernel.org>; Thu, 14 May 2026 16:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778774715; cv=none; b=llOryGWpya5SjuUcBJYmp4egcbFKKxc1AzRoJDDlzh0FA6JV1XyIb3NK/KCHdrU3glC3X5nHxMTjNV2OOpXwh7ciwXHOC0ZBRKe4WC3eDaQC608i+mWRSg9C3WZEQI76UiBX2mBfdFecH2TsSa7OPUQiG1Kux1jmfm3JhLpzjN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778774715; c=relaxed/simple;
	bh=Ehvq2masaHpwOwSufoJKirlnG6yCCNJt/iktfuTIaLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WW539sxjf1m+nnfGjTQ1m7DLpybs/wbaC7CQlnKddMTGdkFv64jmnxSPgpOhHIQFtqdREdTiw/WpuPDQYJixzHBCCDjICI6YM/sv6NkxkdEKtC7Ajrq2nMLQQwM+NiOU5mhetczZKUkgYVvaelcdXfgrJWjBLkEKBB76txbO3so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMtfl0fd; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMtfl0fd"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-83d5bbef760so3259434b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 14 May 2026 09:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778774713; x=1779379513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IaVdXbq9e/jKptXbIvIqQj0fv0S5NPSPcT+Vib3n/iQ=;
        b=GMtfl0fdBrg7iG/Kn9HKPyZ3zik/y1n5aB8SSj8xjfGCUVfRVaqtr/fQdnmd6QReqT
         SFzHVhHwskV3i/eDl1MUZGMlKTt0nAM/dmVPJEsx4mDo7xLB/byEaJENXQ73+Nms8p8m
         A6nHuEaWD6nI+QdIvMHY1xB26vTISa2L+CVGpNjbRITrKAkEhH+bTL90lVtIBP25gtc5
         i0EE9YiE4vuUQT0IKDPAgZsdcXIhGvI7sxY9nQ7YDJ/KzXDDyazKJQ6XHMS97sCkiELA
         0MlJ6LNPEJB994jjmosbf2sq38TsAdkDLMw5wRz0+jZZzbpta9PuRPUa8tAvaKt0GQtK
         qvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778774713; x=1779379513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IaVdXbq9e/jKptXbIvIqQj0fv0S5NPSPcT+Vib3n/iQ=;
        b=TpLZnw/YX8oYMjSJ4iE4M4ibijqciNYvhPF3gF1X/CiVqSmJYuLv0kNu6OXTaSG/39
         rRt3reFqgJ9BHSLupt+IXeOpZTHzCDVD47Vhg9rckQIy/9/3XpzRcp7HWxrt2ODVlYNw
         fFZ034iNHSY2u+YwhbgBTpsNWMyU7XDFHPNoPHFEpAaqh0v7DvJfyw6BU8WNVCvkEP3k
         tB18EPROBDdJ/3el7DNRogJuFtmQyBSEqDXbIOo4i1nYXgxDNbwPBZGOmFmC4XXQLrtD
         ANXb9QbaSOI1ndPgQ9CcxyvLuBy8uT9GPcr9g/X5gSKxB+2faYsU6B4GFah3Usn1fEZx
         syLg==
X-Forwarded-Encrypted: i=1; AFNElJ+lawI89E2q2pDVJQD4ZDIj5F4wcmWS9aKllMedQFUQzyDcabVwOXkkYqDyg8qvswGD66lbJKdfEqEICRlfZMraHhM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9NSTyA5XLMGKrkRzNAip6CwLRayyleFxp9BafVDr4znkPzYqa
	eBkpu8w8sz5u7NP9Z3odWWvec9fugFATc6CwS7S9oe6876t5LPODQXHWr38VQ02k6OoYjw==
X-Gm-Gg: Acq92OERFvfauVUoAqgBz8cx3upZw7mq2sGdCXGRl4wjroQam6+UVgSv2Nx0YVR0kdj
	C06zBj7wBNulEGo+aUIFrmFybFSSrPs7iatnlkn6ojsEjKH/vVSNKSvXj+EBrrvPcZv559uuOL8
	p38atAmbZa5hQrzaHoc3ulUHiK819Q2XEr8qCk5G0Yy8C787uXDRr6fA3YhSYoFR7G0S5u8LhzT
	bSXFkX3wGR6vlfd8sYFhlMuCEY1jYngg2HZEAUMny8uOLOEAQWyF7xbA2VKB1fcNoY7d55bHTDL
	jKMM6JlFkaEB4NPL+lwOW9KnMZn7YCU91tJZI5vXxlEoj6xwQDvxpTzCyeR2vmUgXWQO2t/ry6N
	oljJ0mQK05ej/ummb44ZPRIrMriNIdWyTYE8QpPYXfnvURexoZwdCalYUUY13dd2aXfhvOH0fu4
	tHB7DzrTBn4lcWp3HXpbWbp3U=
X-Received: by 2002:a05:6a00:a29:b0:82d:24f:2509 with SMTP id d2e1a72fcca58-83f33b9e631mr204209b3a.1.1778774713266;
        Thu, 14 May 2026 09:05:13 -0700 (PDT)
Received: from ubuntu24.lan ([14.146.38.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f24cd0422sm3358943b3a.18.2026.05.14.09.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 09:05:12 -0700 (PDT)
From: Yiyang Chen <cyyzero16@gmail.com>
To: peterz@infradead.org,
	rostedt@goodmis.org
Cc: mingo@redhat.com,
	vincent.guittot@linaro.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Yiyang Chen <cyyzero16@gmail.com>
Subject: [PATCH] sched/clock: Provide !HAVE_UNSTABLE_SCHED_CLOCK stub for sched_clock_stable()
Date: Fri, 15 May 2026 00:05:05 +0800
Message-ID: <56e45338858946cd9581b75c8bd45dd37dba52c5.1778773587.git.cyyzero16@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_HAVE_UNSTABLE_SCHED_CLOCK is disabled, sched_clock() is
already assumed to provide stable semantics, but the public header
doesn't provide a sched_clock_stable() stub for that case.

Add a header stub that always returns true and clean up the duplicate
local stub in ring_buffer.c, so callers can use sched_clock_stable()
unconditionally.

Signed-off-by: Yiyang Chen <cyyzero16@gmail.com>
---
 include/linux/sched/clock.h | 5 +++++
 kernel/trace/ring_buffer.c  | 7 -------
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/include/linux/sched/clock.h b/include/linux/sched/clock.h
index 196f0ca351a2..39f0a7f94bfc 100644
--- a/include/linux/sched/clock.h
+++ b/include/linux/sched/clock.h
@@ -33,6 +33,11 @@ extern u64 sched_clock_cpu(int cpu);
 extern void sched_clock_init(void);
 
 #ifndef CONFIG_HAVE_UNSTABLE_SCHED_CLOCK
+static inline int sched_clock_stable(void)
+{
+	return 1;
+}
+
 static inline void sched_clock_tick(void)
 {
 }
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 5326924615a4..02691c3c6dd6 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3769,13 +3769,6 @@ rb_add_time_stamp(struct ring_buffer_per_cpu *cpu_buffer,
 	return skip_time_extend(event);
 }
 
-#ifndef CONFIG_HAVE_UNSTABLE_SCHED_CLOCK
-static inline bool sched_clock_stable(void)
-{
-	return true;
-}
-#endif
-
 static void
 rb_check_timestamp(struct ring_buffer_per_cpu *cpu_buffer,
 		   struct rb_event_info *info)
-- 
2.43.0

