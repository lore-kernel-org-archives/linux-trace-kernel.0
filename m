Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2091B322DB7
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Oct 2025 11:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760529000; cv=none; b=f5kXORVyJy9HanaIqW/jBA06HgiiZFJlM71LO9MaqBmvfUesbfJ2jGbW15SKK20j0RGuUfQGlLZftPOdZMG0gYXeKlFhm+bYrAlVODdluHz7ojzNDKgmLUlx6+HjumN8NawIWGLymQx8vidHG/vOAohBIO1rcF2bX6rHwChAsfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760529000; c=relaxed/simple;
	bh=67bPLpk4XtiM2chNuj/NIzxAtVYUBkPeAY7FycKz6x8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HeVWoPQfcVdzuZoZqUteo58fQOlJ6JgSvcvo++YHiiJdREUDh1F7FGIQ+2r8qdlF8ySEJvLlb/FkmhpItMuJnxDtUc+a+9QnIsx0bk4z0bm8DFVGXK5GtHxxo0qiRGcconuYpjGUDzjPflQAdbHbyWHe5QTzP7eiY63uikRsJzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hk/tktpQ; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hk/tktpQ"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b555ab7fabaso5944868a12.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760528998; x=1761133798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o7DX/MsjusdVTQDdPxzEiOw94/h8+AXMbc90Y8BQxVw=;
        b=hk/tktpQXkqqHRT7an5sKJ65tB4T2xXnYJz6ktReFg7+0UR6ndpyr3Ld6K1JnI4YW8
         dKJchGk1WPnPrIkypO2+GG+DYc3xEW/ALRkMgME9b3YOvmy+M+YvQizzCN3DQTNfNfEt
         5fNOHtip/toozfFzzNj9TQum3yED16IFUZkMPZvHypHccBb/8vCNKs/C2Rz0cV5j8H/P
         GIiD+pi8/PuN0httHMaO87M6SPVGw0jnISAoR0+SMWPL7DACV5lmzWmrDh321SDNM1LO
         fwqtTNda8+643ySqhWjBWJrAyk3R0x63PGj1W6fqIYv9DPHZmFVq4K9YRGazVHRXR3pC
         D7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760528998; x=1761133798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o7DX/MsjusdVTQDdPxzEiOw94/h8+AXMbc90Y8BQxVw=;
        b=QslSDyjLPC2itDYXqh53IRehtuWk763+hcaX67lTIR5h3FDpxTDeq3t66NOOmK1yPd
         lngoFEZYUevbE6oj0rWGTasXApdMWvdr/qC8FNMD4OVkUpSl1T3xNWONlpZlp7eu/s8R
         0B1ysXVmJn574OnepMRz454r8mkK23cf3yUKF48KFxIsaYB7GKaG6r1nlqHRazwntZKr
         H8aFsGaTSnsynyfktrOXHWi9flm3BIkTNzuKd9eJkA61fRJVGjCNW8JmQ/pP5NLCur23
         oMZAdxBs5/7MhIQdaHqbGZeX845W3YtjqDb8MypQFWx1uQpx+9PrchYnx62I+vpCgb9D
         5V/w==
X-Forwarded-Encrypted: i=1; AJvYcCVCcDzaQK+mJKMtfPzcGTw5e5S8Us5nzozCU9T5uCpncVtRlrd8vHxwBqeAO6jIkrp8sB3VgfnTnIy89XeZMSOGsMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcNAKo3P+gsvzHudnyCTQAwA9gDyipYP2CtpCAqZCKtxhJk7Wg
	tQwBkKQiatxa4JiJuRyedz2Ao3DNyKnG3jf/i+iAXEbo8HyM294qMUNb/1kTfvvL
X-Gm-Gg: ASbGncvy5JiCUn6FS7gkYvdQ88abMPbIFibOsPsNMQiaol+3h9XlMKtGxefxYnK78sr
	kh4tJK1uvWAp0JBXGiajFa/tTxpgUjxBunhtv+sqjcgwwAxcrqbZeR2JQu8iyOIFMgyzzNzqLSs
	mXkV7MRl15Us/EpUr1jU4KtJRyrbF/nTFyXHsXS8DKJ6XqmLurQocrt2VykCWuAmHv0aLHy+UyR
	X1pWGEF/KQNFjU6B+y72SszNDdyfPg57j0OPm3L2Vr6WPulkVNJj7ZAv3aoz7RNYSvtZhjHw7HU
	1TM96XV43JNdA+h80OnGSJiUeVV6wyPFhaijcyCyv8kMky0PGvuUrK7TTqJwWJMoflvqGvmZ+d1
	jUt/UWScYpP97dcowhBNQINWpeFznl2yk409Xb3q06+5KGFtF1+JjtO3jHqyOfzrY3teb9sN8rQ
	idSasP5L7y4Vr/+YA=
X-Google-Smtp-Source: AGHT+IHA7jmacf+2jyZ8effG47uhvpwUPR/qPm49iok5/wykenkm7y4wr4qNXbSUS6lRbQH9DgwwKA==
X-Received: by 2002:a17:90b:33d1:b0:339:d1f0:c740 with SMTP id 98e67ed59e1d1-33b51149673mr39484383a91.1.1760528998341;
        Wed, 15 Oct 2025 04:49:58 -0700 (PDT)
Received: from VM-119-80-tencentos.localdomain ([14.22.11.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b52a4f8bfsm9632658a91.10.2025.10.15.04.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 04:49:57 -0700 (PDT)
From: Yongliang Gao <leonylgao@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Yongliang Gao <leonylgao@tencent.com>,
	Huang Cun <cunhuang@tencent.com>
Subject: [PATCH] trace/pid_list: optimize pid_list->lock contention
Date: Wed, 15 Oct 2025 19:49:52 +0800
Message-ID: <20251015114952.4014352-1-leonylgao@gmail.com>
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

For example, in a vmcore environment with 288 cores, We found 267
CPUs are in pid_list->lock contention.

 #4 [ffffa6226fb4bc70] native_queued_spin_lock_slowpath at ffffffff99cd4b7e
 #5 [ffffa6226fb4bc90] _raw_spin_lock_irqsave at ffffffff99cd3e36
 #6 [ffffa6226fb4bca0] trace_pid_list_is_set at ffffffff99267554
 #7 [ffffa6226fb4bcc0] trace_ignore_this_task at ffffffff9925c288
 #8 [ffffa6226fb4bcd8] ftrace_filter_pid_sched_switch_probe at ffffffff99246efe
 #9 [ffffa6226fb4bcf0] __schedule at ffffffff99ccd161

Signed-off-by: Yongliang Gao <leonylgao@tencent.com>
Reviewed-by: Huang Cun <cunhuang@tencent.com>
---
 kernel/trace/pid_list.c | 26 +++++++++++++-------------
 kernel/trace/pid_list.h |  2 +-
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/pid_list.c b/kernel/trace/pid_list.c
index 090bb5ea4a19..62082a4f60db 100644
--- a/kernel/trace/pid_list.c
+++ b/kernel/trace/pid_list.c
@@ -138,14 +138,14 @@ bool trace_pid_list_is_set(struct trace_pid_list *pid_list, unsigned int pid)
 	if (pid_split(pid, &upper1, &upper2, &lower) < 0)
 		return false;
 
-	raw_spin_lock_irqsave(&pid_list->lock, flags);
+	read_lock_irqsave(&pid_list->lock, flags);
 	upper_chunk = pid_list->upper[upper1];
 	if (upper_chunk) {
 		lower_chunk = upper_chunk->data[upper2];
 		if (lower_chunk)
 			ret = test_bit(lower, lower_chunk->data);
 	}
-	raw_spin_unlock_irqrestore(&pid_list->lock, flags);
+	read_unlock_irqrestore(&pid_list->lock, flags);
 
 	return ret;
 }
@@ -177,7 +177,7 @@ int trace_pid_list_set(struct trace_pid_list *pid_list, unsigned int pid)
 	if (pid_split(pid, &upper1, &upper2, &lower) < 0)
 		return -EINVAL;
 
-	raw_spin_lock_irqsave(&pid_list->lock, flags);
+	write_lock_irqsave(&pid_list->lock, flags);
 	upper_chunk = pid_list->upper[upper1];
 	if (!upper_chunk) {
 		upper_chunk = get_upper_chunk(pid_list);
@@ -199,7 +199,7 @@ int trace_pid_list_set(struct trace_pid_list *pid_list, unsigned int pid)
 	set_bit(lower, lower_chunk->data);
 	ret = 0;
  out:
-	raw_spin_unlock_irqrestore(&pid_list->lock, flags);
+	write_unlock_irqrestore(&pid_list->lock, flags);
 	return ret;
 }
 
@@ -229,7 +229,7 @@ int trace_pid_list_clear(struct trace_pid_list *pid_list, unsigned int pid)
 	if (pid_split(pid, &upper1, &upper2, &lower) < 0)
 		return -EINVAL;
 
-	raw_spin_lock_irqsave(&pid_list->lock, flags);
+	write_lock_irqsave(&pid_list->lock, flags);
 	upper_chunk = pid_list->upper[upper1];
 	if (!upper_chunk)
 		goto out;
@@ -250,7 +250,7 @@ int trace_pid_list_clear(struct trace_pid_list *pid_list, unsigned int pid)
 		}
 	}
  out:
-	raw_spin_unlock_irqrestore(&pid_list->lock, flags);
+	write_unlock_irqrestore(&pid_list->lock, flags);
 	return 0;
 }
 
@@ -282,7 +282,7 @@ int trace_pid_list_next(struct trace_pid_list *pid_list, unsigned int pid,
 	if (pid_split(pid, &upper1, &upper2, &lower) < 0)
 		return -EINVAL;
 
-	raw_spin_lock_irqsave(&pid_list->lock, flags);
+	read_lock_irqsave(&pid_list->lock, flags);
 	for (; upper1 <= UPPER_MASK; upper1++, upper2 = 0) {
 		upper_chunk = pid_list->upper[upper1];
 
@@ -302,7 +302,7 @@ int trace_pid_list_next(struct trace_pid_list *pid_list, unsigned int pid,
 	}
 
  found:
-	raw_spin_unlock_irqrestore(&pid_list->lock, flags);
+	read_unlock_irqrestore(&pid_list->lock, flags);
 	if (upper1 > UPPER_MASK)
 		return -1;
 
@@ -339,10 +339,10 @@ static void pid_list_refill_irq(struct irq_work *iwork)
 	int lcnt = 0;
 
  again:
-	raw_spin_lock(&pid_list->lock);
+	write_lock(&pid_list->lock);
 	upper_count = CHUNK_ALLOC - pid_list->free_upper_chunks;
 	lower_count = CHUNK_ALLOC - pid_list->free_lower_chunks;
-	raw_spin_unlock(&pid_list->lock);
+	write_unlock(&pid_list->lock);
 
 	if (upper_count <= 0 && lower_count <= 0)
 		return;
@@ -369,7 +369,7 @@ static void pid_list_refill_irq(struct irq_work *iwork)
 		lcnt++;
 	}
 
-	raw_spin_lock(&pid_list->lock);
+	write_lock(&pid_list->lock);
 	if (upper) {
 		*upper_next = pid_list->upper_list;
 		pid_list->upper_list = upper;
@@ -380,7 +380,7 @@ static void pid_list_refill_irq(struct irq_work *iwork)
 		pid_list->lower_list = lower;
 		pid_list->free_lower_chunks += lcnt;
 	}
-	raw_spin_unlock(&pid_list->lock);
+	write_unlock(&pid_list->lock);
 
 	/*
 	 * On success of allocating all the chunks, both counters
@@ -418,7 +418,7 @@ struct trace_pid_list *trace_pid_list_alloc(void)
 
 	init_irq_work(&pid_list->refill_irqwork, pid_list_refill_irq);
 
-	raw_spin_lock_init(&pid_list->lock);
+	rwlock_init(&pid_list->lock);
 
 	for (i = 0; i < CHUNK_ALLOC; i++) {
 		union upper_chunk *chunk;
diff --git a/kernel/trace/pid_list.h b/kernel/trace/pid_list.h
index 62e73f1ac85f..da200834f4ad 100644
--- a/kernel/trace/pid_list.h
+++ b/kernel/trace/pid_list.h
@@ -76,7 +76,7 @@ union upper_chunk {
 };
 
 struct trace_pid_list {
-	raw_spinlock_t			lock;
+	rwlock_t			lock;
 	struct irq_work			refill_irqwork;
 	union upper_chunk		*upper[UPPER1_SIZE]; // 1 or 2K in size
 	union upper_chunk		*upper_list;
-- 
2.43.5

