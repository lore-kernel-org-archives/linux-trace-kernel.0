Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C69258ED7
	for <linux-trace-kernel@vger.kernel.org>; Sat, 27 Sep 2025 06:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758953541; cv=none; b=QSc2B6axY4BCd2SxVe1fkgBzFtpWjlwK4tLymvox1HzzvqazF/yY5bVd+Oe69TPm8fe5pEyF30L1dAVlvxk8BAAcYqveOqGn+iCuHaPFJLr9bcTWzpbR/WIJqFqyMtdT/aFKQpQiEBoSjyibhwaoK5iIc495x28LrC235Nx3GUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758953541; c=relaxed/simple;
	bh=qEjaAg7MkkdMQDjFjmkDjq7XcLyrEouJluZddB+eNqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TPb+DnkCPT0GaTTgCbTt83Jlh9RrCgJvO0i1O2LV0jKY67LmxnPDg1Oqz92RUkdo4lQaCHm/RDsMmf9GMrPb8aqLucrz8BnqicnOOPOK2RnQugnNUmfduE8R6yb9fAVbEyemgtnCkazikFbx0OEbH5nWhHrXDpkRJtsEE/Lx/QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKvZJDAJ; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKvZJDAJ"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-781206cce18so1091543b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 26 Sep 2025 23:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758953540; x=1759558340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABDRs5ioZceZJLzcJ8Ewc6tgp2gu+8s+nwYVCmKuGc0=;
        b=nKvZJDAJEfBZ9qKqELDwnXmDXKR8LYAm80xUkxI7LNrZhVvYcu1hjZ9DAGw0XrAuJ9
         ob11EjBKsGd3BSuBvpHhZX+fC+o/IRfUMxdz35E7CqASigxeDHC6UdNlqcB2SkAUSW0g
         TwN41+4+9UfLhOe2/0e+j+DEBbY50h/qVxYWDe20ISQkeQQg4KVQC7NQIPB5mykG95P0
         JWx/wLLgQgswJmqcJS8LU5MhrH6Wdip+HlfFWDjjqNmyWx6jbGDgunIZli6ff4bxHs6R
         jZJYdx/QLkjVAEyU0re1747R8m1Uf6eZI2GV1fbSZOifhkqHKkYMRL6ctmGjh3Y97DiC
         cv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758953540; x=1759558340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ABDRs5ioZceZJLzcJ8Ewc6tgp2gu+8s+nwYVCmKuGc0=;
        b=M6Bp61z+zSyVIhaqIF7D6PtXcQ7eY5/qgTroceNotMgYYE81rslMBf5CG4R5cCxJRj
         dFx2O3P97D1lYFHkYGZuTgv5ZZPTPcd0vGFu55j8eeLxOCO6+wg2ADGmJmO+aSqfusLs
         56pykOacelTJ9H4GE1ypaWjhdG5XpTcZfnVLQoC6Vd2A+xBHkKlYM4c8SNE8u1Jg5r78
         /0a5nUf4fzppJJw6U6ko5nwSI1AwAQ9xKyzp5l5qaOGODg02UldWHGHVModM5CW48qtZ
         lcWlE2O3ZMEPTWjwUWSFzzwabpzANI7qE655EBKTBbhAuQ3YPJJTIujvpyMe+9VVZQDf
         TR4w==
X-Forwarded-Encrypted: i=1; AJvYcCWmgzFN2MO4dVvicFdjMJSpNLNJBs3VYsUhBuBzvuAfY7dof+rltjdhkzD07Q5bIyWT0cO0+ptf6qzv60cXaHBNH5k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgdq6XMBOBes/DSrfbY/uCwZs6lvFO+fg1Tls7MFs5fl9OpJ1i
	XFhGW6M5mdRD7On8p5Kzx/n4QeauCCjd/rz4hxdqKW+mCznG0FIJ0z3Z
X-Gm-Gg: ASbGncuu5SaWzwUJ2OwvHrLqYkWy1pToQXWk3H9WtAhMOJbQSpChHcQ0Ug99ItCioxk
	gPfebfVjrivpckMXSgjw5bRIp8tPskqBmK6wbWIh9M8QGvOtXdov5isdO8tOhmzNU+qOUZk8snz
	skPm28yPAl5VnEFNjAz0xtc6XMMMLEDaniQdnfa+nm2Nqp+ix28bTFZE3BHCKMdSXv4WeRnQmaz
	42/682tKt8Oy//AD3mSU7IRe7RYyI7v/AwSMtCwyDrggbbhZABpyaLgoy+WHXtt6eRRSHG9Itzz
	tYZ+gbsgK6qPPrXiRTgDkrBTSQBEBkKXnrZ2MnIKIVaM5tkXNzmyMZYS93ii92e4Q9nDj8LpSlQ
	pBDrho2Hws9zxzZ90lLZ9Y3NBkiB7KA==
X-Google-Smtp-Source: AGHT+IHPDRdOF1EEadfXGYb4KmdSc5RgqVg4fiVWRnpz61eUUanWy9Ud2BWVtzZyZWqIWeSNkD/t/Q==
X-Received: by 2002:a05:6a00:855:b0:77e:eb28:c59d with SMTP id d2e1a72fcca58-78100f77c50mr8198937b3a.5.1758953539680;
        Fri, 26 Sep 2025 23:12:19 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-781023edda8sm5891178b3a.43.2025.09.26.23.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 23:12:19 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <menglong.dong@linux.dev>
To: ast@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	jiang.biao@linux.dev
Subject: [PATCH RFC bpf-next 1/3] bpf: report probe fault to BPF stderr
Date: Sat, 27 Sep 2025 14:12:08 +0800
Message-ID: <20250927061210.194502-2-menglong.dong@linux.dev>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250927061210.194502-1-menglong.dong@linux.dev>
References: <20250927061210.194502-1-menglong.dong@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the function bpf_prog_report_probe_violation(), which is used
to report the memory probe fault to the user by the BPF stderr.

Signed-off-by: Menglong Dong <menglong.dong@linux.dev>
---
 include/linux/bpf.h      |  1 +
 kernel/trace/bpf_trace.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 6338e54a9b1f..a31c5ce56c32 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2902,6 +2902,7 @@ void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data,
 void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr);
 void bpf_dynptr_set_rdonly(struct bpf_dynptr_kern *ptr);
 void bpf_prog_report_arena_violation(bool write, unsigned long addr, unsigned long fault_ip);
+void bpf_prog_report_probe_violation(bool write, unsigned long fault_ip);
 
 #else /* !CONFIG_BPF_SYSCALL */
 static inline struct bpf_prog *bpf_prog_get(u32 ufd)
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 8f23f5273bab..9bd03a9f53db 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2055,6 +2055,24 @@ void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp)
 	module_put(mod);
 }
 
+void bpf_prog_report_probe_violation(bool write, unsigned long fault_ip)
+{
+	struct bpf_stream_stage ss;
+	struct bpf_prog *prog;
+
+	rcu_read_lock();
+	prog = bpf_prog_ksym_find(fault_ip);
+	rcu_read_unlock();
+	if (!prog)
+		return;
+
+	bpf_stream_stage(ss, prog, BPF_STDERR, ({
+		bpf_stream_printk(ss, "ERROR: Probe %s access faule, insn=0x%lx\n",
+				  write ? "WRITE" : "READ", fault_ip);
+		bpf_stream_dump_stack(ss);
+	}));
+}
+
 static __always_inline
 void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
 {
-- 
2.51.0

