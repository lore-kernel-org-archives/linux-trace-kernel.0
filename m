Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824B51EE02F
	for <linux-trace-kernel@vger.kernel.org>; Mon,  4 Aug 2025 19:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754336923; cv=none; b=QcTBOzF5cbzIDrS5hAJLUAMEm/FMio9ZAvQ0boNrcwcZXZSwC8qoM+hZQvR74cKlzI5yK3nmqRk1X0JcHp0+BJOpWRJILyOneNc3lmUF3lSEIjzsxMVaypzxv5E3f9p2+nRvR03bPkBCGJdxUjy0usHTts02SL4jlbih7MuvdN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754336923; c=relaxed/simple;
	bh=dtaRe64+AqlR3pjGYRgsiZ7j/ZtnofP8nv41zy0byXw=;
	h=Subject:Date:Message-ID:MIME-Version:Cc:From:To; b=ZNXZ1MapvPEy8U0M/LimOyH2TaAvriCkuUlSGPWCMy0g/psN08UM/P8THOuzF4KTa+GF6CjoGzQMrCNyfZS0jBazP7TWEGvxY5Rr+eqx3uVSVXLC0aFzp4by4HZkNTg6hYWnpcPVgL8DEVkksHxLe1zWnjr7tYHejKV3Ud0UHCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=F6wc9oJG; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="F6wc9oJG"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76bf3dafaa5so1711113b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 04 Aug 2025 12:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1754336920; x=1754941720; darn=vger.kernel.org;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=904ayUqwmjpVmj+ZJJt8yCDrWE+pSoeD6gDXQ0kyQ/U=;
        b=F6wc9oJGWchvlFdmU+PYJ6Aw/RJ+MvxI4yPfYYJMnpLMFojlISCRcjejVevLzZbpJM
         4b/1eKnTRiD+yZaeX11uWNYAtT1EgrbLGV8Z46VdZGb3dfzrT9jSf1LBciDuCm5F4FD/
         fu7MQYzIBqv2Mt6vFzwhirq8usubuY6jjXRH67cbVsU/neHgHe4TNMjMwH0/8O+xB4Us
         G31uOdRbN6s8KLO4OZqqJ7TJhSWcyQTO/ahQcpS0UDslls+Rxti4vDNCom2tC9YcJZ3O
         lpeNiPM9Dhwqfk2H3L5pYX5tUHTfYVoYI849aT+Ds37+4018sNpyF5B1Tj1jGoGaxpsQ
         wzfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754336920; x=1754941720;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=904ayUqwmjpVmj+ZJJt8yCDrWE+pSoeD6gDXQ0kyQ/U=;
        b=M5RJZlV4AYKZL9ukXvGAjmeN4p81fT90FRo8DSybp1fnz//U2xzxj+Qv6gc0uTAImX
         fZQHaDUrFlUx9B87c/JtUfkcXf+LA5AMEQGhJL6sAj88PHEILOZ5iriW/po6CDEiw4vr
         XH7k0EUtmhKQ7U+Vu1o11xA5E+MMg35p1meVEbwAnpq2AP+Lgpj0uEdI7QWYm8A5+SWJ
         VePD9wptMsTxfrVQs0sRSY08SMsz/zIc9j9ulOYzlbMaFYE2oDQkxcj2GDH6Slt7cT4E
         /oyyLRfk4C7a55b21EzYBT3ODwxSRq5UmgHAjBI6IWwG3ctgulqCh7X/4kbtqg5zT0SU
         RUWg==
X-Forwarded-Encrypted: i=1; AJvYcCWDFUETeQPN8ruPEE/jOnRlwqg7HiQWbV4JZiWmGbRFm9GlNo41QF8wcjDmtVMdvjuOWHvnaC/JlXKG0WT8lUClux8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDhoiz7d/VqDII9mR88p9FYhi0MOEGlb8/Y1Q0J1qj+XQnPaVQ
	KZ2HJhr9R5Ja9q1DPn9zOV/TYKhymsP/nOxE/Kjr/ufqf24zII31fgd8PKKMrUGbQxJjOUxIfMT
	mddNHsUI=
X-Gm-Gg: ASbGncugO01OVV0XPfFpQH5WDkYwgb0xgH8YPnGDhHwZ9a79kcde1jPxMX6JhxefamE
	UL+86FcdRvCO04lMxMHlhiX/Yf/RnbH7lZqF4WcrHwU45evaV+dstdetnasxkMAW1RbIX51qkSY
	XGE65B60Et568dGLpGdcOFs+rPYfno5KqFl5GOokUwkEofaeIa18LHEgmullA0NQrnUTo3IHNMg
	Slm0BtzpUIhhCMaHEOWbrK9GFzFlohUyrzn8DPPBQj8oC2nxWMw7bPGyK75AB0W47tQSaO9FXyd
	TaoWpcc61eNN99T2FEigYHetE83GfNtAbmF4vYE/Mr57goO4A2gudwvBRmU9Bq1AVFvp3Gat/1Q
	eZxtqOe2Ys1bYSxvVIbDS
X-Google-Smtp-Source: AGHT+IEqJbXqxaA1YR9/O5owyw3rl79r4HGXkOejPGbQDf/eQff1LDclhID/L8+DwGTYqoNjJoorCA==
X-Received: by 2002:a05:6a21:32a0:b0:220:898b:2ca1 with SMTP id adf61e73a8af0-2401eac06d1mr1160785637.21.1754336919674;
        Mon, 04 Aug 2025 12:48:39 -0700 (PDT)
Received: from localhost ([2620:10d:c090:500::6:c42f])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-76bf77210aesm5114249b3a.113.2025.08.04.12.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 12:48:39 -0700 (PDT)
Subject: [PATCH] rv: Support systems with time64-only syscalls
Date: Mon,  4 Aug 2025 12:45:19 -0700
Message-ID: <20250804194518.97620-2-palmer@dabbelt.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
  Palmer Dabbelt <palmer@dabbelt.com>, gmonaco@redhat.com, linux-trace-kernel@vger.kernel.org,
  linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: rostedt@goodmis.org, namcao@linutronix.de

From: Palmer Dabbelt <palmer@dabbelt.com>

Some systems (like 32-bit RISC-V) only have the 64-bit time_t versions
of syscalls.  So handle the 32-bit time_t version of those being
undefined.

Fixes: f74f8bb246cf ("rv: Add rtapp_sleep monitor")
Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
---
This seems a little ugly, as it'll blow up when neither is defined.  Some
#if/#error type stuff seemed uglier, though, and that's the best I could come
up with.  I figure anyone without either flavor of futex call is probably deep
enough in the weeds to just figure what blows up here...
---
 kernel/trace/rv/monitors/sleep/sleep.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/rv/monitors/sleep/sleep.c b/kernel/trace/rv/monitors/sleep/sleep.c
index eea447b06907..c1347da69e9d 100644
--- a/kernel/trace/rv/monitors/sleep/sleep.c
+++ b/kernel/trace/rv/monitors/sleep/sleep.c
@@ -127,7 +127,9 @@ static void handle_sys_enter(void *data, struct pt_regs *regs, long id)
 	mon = ltl_get_monitor(current);
 
 	switch (id) {
+#ifdef __NR_clock_nanosleep
 	case __NR_clock_nanosleep:
+#endif
 #ifdef __NR_clock_nanosleep_time64
 	case __NR_clock_nanosleep_time64:
 #endif
@@ -138,7 +140,9 @@ static void handle_sys_enter(void *data, struct pt_regs *regs, long id)
 		ltl_atom_update(current, LTL_CLOCK_NANOSLEEP, true);
 		break;
 
+#ifdef __NR_futex
 	case __NR_futex:
+#endif
 #ifdef __NR_futex_time64
 	case __NR_futex_time64:
 #endif
-- 
2.50.1

