Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343A2DDD2
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Nov 2025 00:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762992185; cv=none; b=bxx/CeieqI4R/YwTUyoHeYQZFrp/X2OylFIlfqeqZEdlvsWEtXEHR6/fE0eFphncZ2sXR+0GerOuySqZ9uORW1RDyCT9KSdw1iaaUczpy3+ob7Z2stON9eaK/OjgB0aI9931coFWaXq1d4i3V3Fv3P9ewH71X7oD2WofZTZd4gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762992185; c=relaxed/simple;
	bh=2d1PmSahrO9i9M6Z1G+BuUB4z0o+2hreIN2UcdEKnzg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QhA9cOfIbuNTKJGRLpd+Gc1VRJuGeKS9qnej7s68IUVol1GfjaWTVUL1ALCp6GqIopCZOA5B8bt4XQNpQEOp1g4GAjh1yznq67MPU7EmDFqG6ZvdKPrhyb1dBmUyNkeU+dLWgQgZ2Rnwy4It/exTzw1HQnjvQ4kG87Pt1DIm9dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZvkB3+o; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZvkB3+o"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7b4933bc4bbso221409b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762992183; x=1763596983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MEj/ojo6JDZMNsfky5JeXpMs3oH+g8HQgGx2nKzX0hI=;
        b=hZvkB3+otxOel1j2H5JrMTWgojzIQHW9Molncfhf3lL+HK7HzA7uFni6TlE8Fpor8E
         sLRO4PNvbRrXD1FDX57Tgk+/UzTU8CAQOBwrCaxfWbafeims3WMoTqiTX+hw88I1/e0x
         mDdZswNUFS2gCJwbCeGSiQ4mlAd27UTyBTnSZ2NS863N61ug+KfaGP5u9DBOMPEiTKB/
         LwwOAEkCBVhcDKK05sQtSEgaOCFDlKu0cDoX/MsUo5o1aWTAFhwTPOk0oyw2gn45Uzvt
         aTUvqksNISPy2rNiMnCJndgaDGpKN//jOee8qWdlJEQphHikoBh8IgEPBfIGfTk0b35P
         raMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762992183; x=1763596983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MEj/ojo6JDZMNsfky5JeXpMs3oH+g8HQgGx2nKzX0hI=;
        b=xBibayP4eUtH8vSY8UrKX/BSurCDiv550DUitDrfnuJ5XipDX6hk1C4wuhpadC0H7q
         PL4ibFh5H2mNJIYHeEPIifEZJ0YPRYTm4a8yAnTBfevVkfzMGXGr1zCOqBuG7ELsVYAV
         KveHKRdoCXPCB6Wnujj0bNlhulmqyIsVmL39pc9eE8ubQrpqABuYtskyk2inpiRj3R+I
         Mlb8i9DBncG0u63ms5tWOy8oKhvbRkuO2PMrVKdE57g7md3ZAyWVcu5eP1REcH7Iz3d3
         Eov+lR4p5dnhQtOeWq1zl9bvAsQYgsa2CzQdrqZmrzzmKcXiFbNxE2r/uJ0V313Mek8y
         4RaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOKIEkRdOc2SV9HgggiDX0vQQkpao1Bx2PHEHegc4nVRNXIK2ac+TfXzUmp4R7vptzkY4fTnLc4AohJkWCvc26VoY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7uP+ii6BFMRyEQkSGbEfhKdy3MhTk5zlPVy1pvKJaxxky8pVD
	oaXu5BQ9+CPYRS4Nu/bEXOThdpP4Yr40AC+hA3ZbuwaWmNnl6pBk3u5i6TbwKyTxcJk=
X-Gm-Gg: ASbGncu4QxNTdYDX0t9UDdZ87XaV7OIXwYagC64EKKB9pH3zS21GfE4iC8R5BS8NIR3
	y+sqo5ZMHv9NjIeLmh1JG1spqvwinSTK4xgYwRLSPSYaQ36E/zuCsI3S4P/WSEMB3OmssGlE/Ed
	0ZL3EqHSCutEyOIW+XgGLZldaOe2iXGlZV56QNh2+cQTAZiB2fcUHB5GICJjCW7RK4F2PaUZmoO
	z5Dg7CWsx3Fy+tylwsgTDz/vbiuThjGG3zyJcCcE801J9JoSQSqdaqOC62LMYOPuWNq5vFEpYEK
	qdvdux+pq4DtTpMuv/M5KxYDpznEzr5LYMNSqt8J0ECbQQ0jAU016ISwXt5WWCG3bejWg703ECs
	mJfcwq4HEZ4Xg6A/j+6HLga5MKXhlHytBOx9j2qSPXvF/Z6PoSmLZJDXx4jLDa9Pmlcj9TwBWfg
	4WPRcxVMgkgHw+rbP0D8PzggOwseA6tkp/J0/kCd2aipnnGg==
X-Google-Smtp-Source: AGHT+IEnM79BvZyBixnjboboF7WynqTSpPF7hApf/6Tx2azXkKYm6rIu6qmhALR/iDXye9UzL+a+8w==
X-Received: by 2002:a05:6a20:939e:b0:342:1d16:80e with SMTP id adf61e73a8af0-35a4eafc50fmr1438846637.4.1762992183333;
        Wed, 12 Nov 2025 16:03:03 -0800 (PST)
Received: from VM-119-80-tencentos.localdomain ([14.22.11.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b927731a72sm213711b3a.50.2025.11.12.16.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 16:03:02 -0800 (PST)
From: Yongliang Gao <leonylgao@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	bigeasy@linutronix.de
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	frankjpliu@tencent.com,
	Yongliang Gao <leonylgao@tencent.com>,
	Huang Cun <cunhuang@tencent.com>
Subject: [PATCH v3] trace/pid_list: optimize pid_list->lock contention
Date: Thu, 13 Nov 2025 08:02:52 +0800
Message-ID: <20251113000252.1058144-1-leonylgao@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yongliang Gao <leonylgao@tencent.com>

When the system has many cores and task switching is frequent,
setting set_ftrace_pid can cause frequent pid_list->lock contention
and high system sys usage.

For example, in a 288-core VM environment, we observed 267 CPUs
experiencing contention on pid_list->lock, with stack traces showing:

 #4 [ffffa6226fb4bc70] native_queued_spin_lock_slowpath at ffffffff99cd4b7e
 #5 [ffffa6226fb4bc90] _raw_spin_lock_irqsave at ffffffff99cd3e36
 #6 [ffffa6226fb4bca0] trace_pid_list_is_set at ffffffff99267554
 #7 [ffffa6226fb4bcc0] trace_ignore_this_task at ffffffff9925c288
 #8 [ffffa6226fb4bcd8] ftrace_filter_pid_sched_switch_probe at ffffffff99246efe
 #9 [ffffa6226fb4bcf0] __schedule at ffffffff99ccd161

Replaces the existing spinlock with a seqlock to allow concurrent readers,
while maintaining write exclusivity.

---
Changes from v2:
- Keep trace_pid_list_next() using raw_spin_lock for simplicity. [Steven Rostedt]
- Link to v2: https://lore.kernel.org/all/20251112181456.473864-1-leonylgao@gmail.com
Changes from v1:
- Fixed sleep-in-atomic issues under PREEMPT_RT. [Steven Rostedt]
- Link to v1: https://lore.kernel.org/all/20251015114952.4014352-1-leonylgao@gmail.com
---

Signed-off-by: Yongliang Gao <leonylgao@tencent.com>
Reviewed-by: Huang Cun <cunhuang@tencent.com>
---
 kernel/trace/pid_list.c | 30 +++++++++++++++++++++---------
 kernel/trace/pid_list.h |  1 +
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/pid_list.c b/kernel/trace/pid_list.c
index 090bb5ea4a19..dbee72d69d0a 100644
--- a/kernel/trace/pid_list.c
+++ b/kernel/trace/pid_list.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2021 VMware Inc, Steven Rostedt <rostedt@goodmis.org>
  */
 #include <linux/spinlock.h>
+#include <linux/seqlock.h>
 #include <linux/irq_work.h>
 #include <linux/slab.h>
 #include "trace.h"
@@ -126,7 +127,7 @@ bool trace_pid_list_is_set(struct trace_pid_list *pid_list, unsigned int pid)
 {
 	union upper_chunk *upper_chunk;
 	union lower_chunk *lower_chunk;
-	unsigned long flags;
+	unsigned int seq;
 	unsigned int upper1;
 	unsigned int upper2;
 	unsigned int lower;
@@ -138,14 +139,16 @@ bool trace_pid_list_is_set(struct trace_pid_list *pid_list, unsigned int pid)
 	if (pid_split(pid, &upper1, &upper2, &lower) < 0)
 		return false;
 
-	raw_spin_lock_irqsave(&pid_list->lock, flags);
-	upper_chunk = pid_list->upper[upper1];
-	if (upper_chunk) {
-		lower_chunk = upper_chunk->data[upper2];
-		if (lower_chunk)
-			ret = test_bit(lower, lower_chunk->data);
-	}
-	raw_spin_unlock_irqrestore(&pid_list->lock, flags);
+	do {
+		seq = read_seqcount_begin(&pid_list->seqcount);
+		ret = false;
+		upper_chunk = pid_list->upper[upper1];
+		if (upper_chunk) {
+			lower_chunk = upper_chunk->data[upper2];
+			if (lower_chunk)
+				ret = test_bit(lower, lower_chunk->data);
+		}
+	} while (read_seqcount_retry(&pid_list->seqcount, seq));
 
 	return ret;
 }
@@ -178,6 +181,7 @@ int trace_pid_list_set(struct trace_pid_list *pid_list, unsigned int pid)
 		return -EINVAL;
 
 	raw_spin_lock_irqsave(&pid_list->lock, flags);
+	write_seqcount_begin(&pid_list->seqcount);
 	upper_chunk = pid_list->upper[upper1];
 	if (!upper_chunk) {
 		upper_chunk = get_upper_chunk(pid_list);
@@ -199,6 +203,7 @@ int trace_pid_list_set(struct trace_pid_list *pid_list, unsigned int pid)
 	set_bit(lower, lower_chunk->data);
 	ret = 0;
  out:
+	write_seqcount_end(&pid_list->seqcount);
 	raw_spin_unlock_irqrestore(&pid_list->lock, flags);
 	return ret;
 }
@@ -230,6 +235,7 @@ int trace_pid_list_clear(struct trace_pid_list *pid_list, unsigned int pid)
 		return -EINVAL;
 
 	raw_spin_lock_irqsave(&pid_list->lock, flags);
+	write_seqcount_begin(&pid_list->seqcount);
 	upper_chunk = pid_list->upper[upper1];
 	if (!upper_chunk)
 		goto out;
@@ -250,6 +256,7 @@ int trace_pid_list_clear(struct trace_pid_list *pid_list, unsigned int pid)
 		}
 	}
  out:
+	write_seqcount_end(&pid_list->seqcount);
 	raw_spin_unlock_irqrestore(&pid_list->lock, flags);
 	return 0;
 }
@@ -340,8 +347,10 @@ static void pid_list_refill_irq(struct irq_work *iwork)
 
  again:
 	raw_spin_lock(&pid_list->lock);
+	write_seqcount_begin(&pid_list->seqcount);
 	upper_count = CHUNK_ALLOC - pid_list->free_upper_chunks;
 	lower_count = CHUNK_ALLOC - pid_list->free_lower_chunks;
+	write_seqcount_end(&pid_list->seqcount);
 	raw_spin_unlock(&pid_list->lock);
 
 	if (upper_count <= 0 && lower_count <= 0)
@@ -370,6 +379,7 @@ static void pid_list_refill_irq(struct irq_work *iwork)
 	}
 
 	raw_spin_lock(&pid_list->lock);
+	write_seqcount_begin(&pid_list->seqcount);
 	if (upper) {
 		*upper_next = pid_list->upper_list;
 		pid_list->upper_list = upper;
@@ -380,6 +390,7 @@ static void pid_list_refill_irq(struct irq_work *iwork)
 		pid_list->lower_list = lower;
 		pid_list->free_lower_chunks += lcnt;
 	}
+	write_seqcount_end(&pid_list->seqcount);
 	raw_spin_unlock(&pid_list->lock);
 
 	/*
@@ -419,6 +430,7 @@ struct trace_pid_list *trace_pid_list_alloc(void)
 	init_irq_work(&pid_list->refill_irqwork, pid_list_refill_irq);
 
 	raw_spin_lock_init(&pid_list->lock);
+	seqcount_raw_spinlock_init(&pid_list->seqcount, &pid_list->lock);
 
 	for (i = 0; i < CHUNK_ALLOC; i++) {
 		union upper_chunk *chunk;
diff --git a/kernel/trace/pid_list.h b/kernel/trace/pid_list.h
index 62e73f1ac85f..0b45fb0eadb9 100644
--- a/kernel/trace/pid_list.h
+++ b/kernel/trace/pid_list.h
@@ -76,6 +76,7 @@ union upper_chunk {
 };
 
 struct trace_pid_list {
+	seqcount_raw_spinlock_t		seqcount;
 	raw_spinlock_t			lock;
 	struct irq_work			refill_irqwork;
 	union upper_chunk		*upper[UPPER1_SIZE]; // 1 or 2K in size
-- 
2.43.5

