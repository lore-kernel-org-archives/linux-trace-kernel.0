Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CF715575B
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Sep 2024 06:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727247223; cv=none; b=lr1j/sOGY+MtVCirL6xpJEbc4DryliJPIKQfoHklae1ZtwPJ+ivmn4zfCEmlhabevJJs+Osu+6jtUjjd0EHuZCAtt/G3VLiyZzII3N6KVkAJpiSeTlsRV75luAC+UJDfDxpLuF6HOL4ayBf1LjlWVURjBNoSSWssMT0LBcuNf9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727247223; c=relaxed/simple;
	bh=xOEYAu53yq7gRs6vSUaPmm1I4Uq8HUcYekaeYyfJQZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Duw94Lp1ZhpkVOap7dOa3kujolRgXMMqLJ9poyDhFy+MGm7zFhS/FKnTa9N/mC615Ajql/R5NHq8rwx8rZnKzli2K+7CiOg1ch6fOGq4efOqq6y++tRNZ1vTlE3QPiC+cY1NK5oH43A7e9su4zYVX0iWpVMQWy0Kg68x7M1ih64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZrMv8D6L; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZrMv8D6L"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7d50e865b7aso5157607a12.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Sep 2024 23:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1727247220; x=1727852020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocj9pLKaZVxq69VsJPKezFYPC0j22GZ+6ngnvWMj5Ms=;
        b=ZrMv8D6Lu3OvJi5SL3i7+o5xlj+CBe1LRaVHDtrNONbzh3VdwwepwDP+8mUGwx3FnE
         vKRDcE9/mb/sCN+t04TpxiYa4qyhn5KG5dcfyvHgCFugDZpk3EpbeYaUQXnHevd4JL5+
         lTdFS4VzbEHFRqBfhjhQGdC7vcPQyFLR9+yxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727247220; x=1727852020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ocj9pLKaZVxq69VsJPKezFYPC0j22GZ+6ngnvWMj5Ms=;
        b=DSQpNzkkVshP5WE7nTXCpN5nRW7KeN5eX6ap6cC6M2BMBFftHVVMbITpxwxfghhUiK
         sz2XVZTtq8aDUrKxsVu9XmTEctRlQdtlRZWAzytTbueAxgpDIY30ldje6a7seSMhbOS+
         wSYSGP/VD1preGymt8W2398hMHiTD34J/YGyD9SqXkJh/jEyMgRA0pkrxyxaTDNG9azc
         B4jk0S2avyiNyQ7TRNFpHlCvmP3dD4uiYLjkKr4TLpyqI0ZLT0vcwU8l6xtvJLMs5Xj1
         drgn67NQwC5pqcXHcjqpqcLNx6iAXFIpKKzBcL7QMX0mZs4xbiABF0cDgW5kG/YLt6Te
         3nwg==
X-Forwarded-Encrypted: i=1; AJvYcCWSMe9/RseY6I91HMp0MtIzuVHiaXJoqxnyQkYkgLMEqDfh/9OVSzNPshMgFV/Z+ZCHoNw7CRBCGtRuT5FJHTdcqm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQXnFgBo8HnB2nTp/fWcVyzD0+AdzTcoulLm2nk1sxLyiACaDi
	86xFsIKhcRNIz9FbtA4dRU9m65mU98EC7KrHiZSteufmX67wRb+uq6UNRQ6J9oWDwzDbQY+Ttqq
	+Lg==
X-Google-Smtp-Source: AGHT+IE40F2Z8QFtmyCQfQ6un+BCfmpOsQ5XiqfHbVSIT1H2+hg/dfp8dEW+fqOkJzaaiVe1lO1C2w==
X-Received: by 2002:a05:6a20:cfa5:b0:1cf:3b22:feca with SMTP id adf61e73a8af0-1d4d4aaef94mr2565484637.15.1727247220128;
        Tue, 24 Sep 2024 23:53:40 -0700 (PDT)
Received: from shivania.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc97b623sm2147203b3a.169.2024.09.24.23.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 23:53:39 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org,
	jpoimboe@redhat.com,
	sashal@kernel.org,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH 1/2 v5.10] x86/ibt,ftrace: Search for __fentry__ location
Date: Tue, 24 Sep 2024 23:53:23 -0700
Message-Id: <20240925065324.121176-2-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240925065324.121176-1-shivani.agarwal@broadcom.com>
References: <20240925065324.121176-1-shivani.agarwal@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit aebfd12521d9c7d0b502cf6d06314cfbcdccfe3b ]

Currently a lot of ftrace code assumes __fentry__ is at sym+0. However
with Intel IBT enabled the first instruction of a function will most
likely be ENDBR.

Change ftrace_location() to not only return the __fentry__ location
when called for the __fentry__ location, but also when called for the
sym+0 location.

Then audit/update all callsites of this function to consistently use
these new semantics.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220308154318.227581603@infradead.org
Stable-dep-of: e60b613df8b6 ("ftrace: Fix possible use-after-free issue in ftrace_location()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Shivani: Modified to apply on v5.10.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 arch/x86/kernel/kprobes/core.c | 11 ++------
 kernel/bpf/trampoline.c        | 20 +++-----------
 kernel/kprobes.c               |  8 ++----
 kernel/trace/ftrace.c          | 48 ++++++++++++++++++++++++++++------
 4 files changed, 48 insertions(+), 39 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index e7edc9e4c6cd..6d59c8e7719b 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -194,17 +194,10 @@ static unsigned long
 __recover_probed_insn(kprobe_opcode_t *buf, unsigned long addr)
 {
 	struct kprobe *kp;
-	unsigned long faddr;
+	bool faddr;
 
 	kp = get_kprobe((void *)addr);
-	faddr = ftrace_location(addr);
-	/*
-	 * Addresses inside the ftrace location are refused by
-	 * arch_check_ftrace_location(). Something went terribly wrong
-	 * if such an address is checked here.
-	 */
-	if (WARN_ON(faddr && faddr != addr))
-		return 0UL;
+	faddr = ftrace_location(addr) == addr;
 	/*
 	 * Use the current code if it is not modified by Kprobe
 	 * and it cannot be modified by ftrace.
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 87becf77cc75..0a14f14d83fe 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -87,18 +87,6 @@ static struct bpf_trampoline *bpf_trampoline_lookup(u64 key)
 	return tr;
 }
 
-static int is_ftrace_location(void *ip)
-{
-	long addr;
-
-	addr = ftrace_location((long)ip);
-	if (!addr)
-		return 0;
-	if (WARN_ON_ONCE(addr != (long)ip))
-		return -EFAULT;
-	return 1;
-}
-
 static int unregister_fentry(struct bpf_trampoline *tr, void *old_addr)
 {
 	void *ip = tr->func.addr;
@@ -127,12 +115,12 @@ static int modify_fentry(struct bpf_trampoline *tr, void *old_addr, void *new_ad
 static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
 {
 	void *ip = tr->func.addr;
+	unsigned long faddr;
 	int ret;
 
-	ret = is_ftrace_location(ip);
-	if (ret < 0)
-		return ret;
-	tr->func.ftrace_managed = ret;
+	faddr = ftrace_location((unsigned long)ip);
+	if (faddr)
+		tr->func.ftrace_managed = true;
 
 	if (tr->func.ftrace_managed)
 		ret = register_ftrace_direct((long)ip, (long)new_addr);
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index c8e62458d323..551ac118159f 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1609,14 +1609,10 @@ static inline int check_kprobe_rereg(struct kprobe *p)
 
 int __weak arch_check_ftrace_location(struct kprobe *p)
 {
-	unsigned long ftrace_addr;
+	unsigned long addr = (unsigned long)p->addr;
 
-	ftrace_addr = ftrace_location((unsigned long)p->addr);
-	if (ftrace_addr) {
+	if (ftrace_location(addr) == addr) {
 #ifdef CONFIG_KPROBES_ON_FTRACE
-		/* Given address is not on the instruction boundary */
-		if ((unsigned long)p->addr != ftrace_addr)
-			return -EILSEQ;
 		p->flags |= KPROBE_FLAG_FTRACE;
 #else	/* !CONFIG_KPROBES_ON_FTRACE */
 		return -EINVAL;
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 31fec924b7c4..a781733b2a01 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1575,17 +1575,34 @@ unsigned long ftrace_location_range(unsigned long start, unsigned long end)
 }
 
 /**
- * ftrace_location - return true if the ip giving is a traced location
+ * ftrace_location - return the ftrace location
  * @ip: the instruction pointer to check
  *
- * Returns rec->ip if @ip given is a pointer to a ftrace location.
- * That is, the instruction that is either a NOP or call to
- * the function tracer. It checks the ftrace internal tables to
- * determine if the address belongs or not.
+ * If @ip matches the ftrace location, return @ip.
+ * If @ip matches sym+0, return sym's ftrace location.
+ * Otherwise, return 0.
  */
 unsigned long ftrace_location(unsigned long ip)
 {
-	return ftrace_location_range(ip, ip);
+	struct dyn_ftrace *rec;
+	unsigned long offset;
+	unsigned long size;
+
+	rec = lookup_rec(ip, ip);
+	if (!rec) {
+		if (!kallsyms_lookup_size_offset(ip, &size, &offset))
+			goto out;
+
+		/* map sym+0 to __fentry__ */
+		if (!offset)
+			rec = lookup_rec(ip, ip + size - 1);
+	}
+
+	if (rec)
+		return rec->ip;
+
+out:
+	return 0;
 }
 
 /**
@@ -4948,7 +4965,8 @@ ftrace_match_addr(struct ftrace_hash *hash, unsigned long ip, int remove)
 {
 	struct ftrace_func_entry *entry;
 
-	if (!ftrace_location(ip))
+	ip = ftrace_location(ip);
+	if (!ip)
 		return -EINVAL;
 
 	if (remove) {
@@ -5096,11 +5114,16 @@ int register_ftrace_direct(unsigned long ip, unsigned long addr)
 	struct ftrace_func_entry *entry;
 	struct ftrace_hash *free_hash = NULL;
 	struct dyn_ftrace *rec;
-	int ret = -EBUSY;
+	int ret = -ENODEV;
 
 	mutex_lock(&direct_mutex);
 
+	ip = ftrace_location(ip);
+	if (!ip)
+		goto out_unlock;
+
 	/* See if there's a direct function at @ip already */
+	ret = -EBUSY;
 	if (ftrace_find_rec_direct(ip))
 		goto out_unlock;
 
@@ -5229,6 +5252,10 @@ int unregister_ftrace_direct(unsigned long ip, unsigned long addr)
 
 	mutex_lock(&direct_mutex);
 
+	ip = ftrace_location(ip);
+	if (!ip)
+		goto out_unlock;
+
 	entry = find_direct_entry(&ip, NULL);
 	if (!entry)
 		goto out_unlock;
@@ -5360,6 +5387,11 @@ int modify_ftrace_direct(unsigned long ip,
 	mutex_lock(&direct_mutex);
 
 	mutex_lock(&ftrace_lock);
+
+	ip = ftrace_location(ip);
+	if (!ip)
+		goto out_unlock;
+
 	entry = find_direct_entry(&ip, &rec);
 	if (!entry)
 		goto out_unlock;
-- 
2.39.4

