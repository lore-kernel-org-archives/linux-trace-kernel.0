Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A542B2010FB;
	Wed, 27 Nov 2024 17:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732728610; cv=none; b=sBcRxJmpL7xRzPJcxcDw9Kz1Wl5tD9s8UK5hWQm9d2uPhwqsjWpZnAu/5jvtMj4FsGhDXFg5b4ft8EokU/0RgHclzczSGZHrFPa/fxq80M7zpfUPIteWcCUhqMXDQaUqrQ0JZ3dpRmpGLhPE4uaIKCdd23/ScaglA3nhsLx4F4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732728610; c=relaxed/simple;
	bh=jB6V5LnOG2FU2rWhkR2mAKb1UPOirED+m9TxmqTlLDg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hxs0/b20ZbG9tkKntSFf4cT4oUh8RctWy2UO2RMj00iNesvd4eSBvSdBP+yXP9ds66QSIaqqHBdbUdVJmVv7AZo+WBXmOOhrDcTA+dW3ZhtBdeIDlZB5aQF/LTQiz2rHi3MRilQUp5ZPhUjTKPMufE+qSso6xob/j3oNlEKuiAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5D9kcQj; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5D9kcQj"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7e9e38dd5f1so5960400a12.0;
        Wed, 27 Nov 2024 09:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732728608; x=1733333408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJ4wyksNmGKwRpxqsruWC4A8GzGFI32FmHe+iaxPpao=;
        b=i5D9kcQjX0UQJpfGstl06rvbkIxxCU7ZLV22+4ZeO33ePlezqTYF3DCUFYwl/p4O1Z
         uJTBxgwc9XoOeWU1L9StQGV09hhpAJfOQH70u7QJfpb5Qg4j521VWESqk/KHni4IKmLb
         2S6Mp2VQJyKi/TtMav8hsR6IBKbpkPw0qy2Rncmeg5p1skfQNjMBFO3ivhORiAncYYob
         qil9T3DxqCDDBdPx32JEzG7+9EpJNhcDxB6BeiGYjNowhClNVm5lCIWVqp5zRpMk80m7
         +iB5vfktkgXTn2NQbehin0zT6MpoZtICmAYS2aGrPL2ALLcgNXMx8BQck9EcffdQIYW1
         vCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732728608; x=1733333408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJ4wyksNmGKwRpxqsruWC4A8GzGFI32FmHe+iaxPpao=;
        b=k/25DkIa5QSIfjPF/6azPzOTH7nvi51EW6jMs7CAI0A77mYjZGqKJUqEIh8D48gOfM
         LbfYRBHt/waWtX5P1pbn/9P/+XyueEOXWa3HPUR+Yx0JzGtkdRM4mG4fD1f0I3uk7Pgv
         NjjmKbdDQ8j/q3eDt/iyLCFx0Et1isoJqrCdj9beAKfUcsjaEEHCphJzQm3/X8tCrEOm
         WJQX3f5y9vd4fKTJ4hQcemrvAs34pg/cuOObINAMrotmfUj67BONqnLl58wza/kGpykP
         kBxsJs1Y9v6K47F7anYJIeTyajsRTjIiTaWhQEuW+3hrrSCIvftlousNCDbyZJI/jnos
         jcsA==
X-Forwarded-Encrypted: i=1; AJvYcCUCG1NI/m4Ro25sn1Aab1NHIpq8Z+97wklnwYw7WMk6QteBmElJ0N8Zl5sNoqWesQyElhTqEd92+/gNOkpKvMqMes0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbSahKbXNm+e+2DIl5Lb4vwVAOmW6ZJj821oM0k3v0C4T8q/kZ
	BCjY51ZEd/RncWyOBmBW12eFo4kIvqjaAXVV4P53ne9rIzoq1wHS
X-Gm-Gg: ASbGncsiMs31gGz+rBwjEJ/3Z5LMFXVOCLtIqnLgO1pY9U2QQeBVeZyHwVtBlAls/B8
	hEgqyiaO9AgmJvtuLrROiw9dzh0xI31z/PujSZtWcnlsAXqx8i6O0mMWwCcnUghHi2kx94cpBJ4
	dtc+2PrsMvik4WSKUY4eWwDB5ksNxy/2WGWb4MAb4cfV58QlWoL1v9fHZk9h3uz/uPHfIjSq0lX
	OKN0s+jRinwVLeox1u5QNi5O2ir0S/tG+kmasq7uZtTWA0j+68oVL3fYr5IuBxu1fWwcKugJQ9K
	6UC+1Ac1pZ87C7B8KTjJaEAQDyny
X-Google-Smtp-Source: AGHT+IF4fq/f76pFPUxSVNMwuLs8cfvtvFw2AwTwF+Xja2556ySDeUDGNdUbpJFYW6y4k7ZnLfhsXg==
X-Received: by 2002:a05:6a20:914b:b0:1e0:d123:7154 with SMTP id adf61e73a8af0-1e0e0ade54cmr5763536637.17.1732728607749;
        Wed, 27 Nov 2024 09:30:07 -0800 (PST)
Received: from localhost.localdomain (1-171-29-17.dynamic-ip.hinet.net. [1.171.29.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcc1e3fdbsm9359582a12.30.2024.11.27.09.30.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 27 Nov 2024 09:30:07 -0800 (PST)
From: Andy Chiu <andybnac@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	bjorn@rivosinc.com,
	puranjay12@gmail.com,
	alexghiti@rivosinc.com,
	yongxuan.wang@sifive.com,
	greentime.hu@sifive.com,
	nick.hu@sifive.com,
	nylon.chen@sifive.com,
	tommy.wu@sifive.com,
	eric.lin@sifive.com,
	viccent.chen@sifive.com,
	zong.li@sifive.com,
	samuel.holland@sifive.com
Subject: [PATCH v3 4/7] riscv: ftrace: do not use stop_machine to update code
Date: Thu, 28 Nov 2024 01:29:05 +0800
Message-Id: <20241127172908.17149-5-andybnac@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20241127172908.17149-1-andybnac@gmail.com>
References: <20241127172908.17149-1-andybnac@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Chiu <andy.chiu@sifive.com>

Now it is safe to remove dependency from stop_machine() for us to patch
code in ftrace.

Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
---
 arch/riscv/kernel/ftrace.c | 53 +++-----------------------------------
 1 file changed, 4 insertions(+), 49 deletions(-)

diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index 5ebe412280ef..57a6558e212e 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -13,23 +13,13 @@
 #include <asm/patch.h>
 
 #ifdef CONFIG_DYNAMIC_FTRACE
-void ftrace_arch_code_modify_prepare(void) __acquires(&text_mutex)
+void arch_ftrace_update_code(int command)
 {
 	mutex_lock(&text_mutex);
-
-	/*
-	 * The code sequences we use for ftrace can't be patched while the
-	 * kernel is running, so we need to use stop_machine() to modify them
-	 * for now.  This doesn't play nice with text_mutex, we use this flag
-	 * to elide the check.
-	 */
-	riscv_patch_in_stop_machine = true;
-}
-
-void ftrace_arch_code_modify_post_process(void) __releases(&text_mutex)
-{
-	riscv_patch_in_stop_machine = false;
+	command |= FTRACE_MAY_SLEEP;
+	ftrace_modify_all_code(command);
 	mutex_unlock(&text_mutex);
+	flush_icache_all();
 }
 
 static int ftrace_check_current_call(unsigned long hook_pos,
@@ -155,41 +145,6 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 	return __ftrace_modify_call_site(&ftrace_call_dest, func, true);
 }
 
-struct ftrace_modify_param {
-	int command;
-	atomic_t cpu_count;
-};
-
-static int __ftrace_modify_code(void *data)
-{
-	struct ftrace_modify_param *param = data;
-
-	if (atomic_inc_return(&param->cpu_count) == num_online_cpus()) {
-		ftrace_modify_all_code(param->command);
-		/*
-		 * Make sure the patching store is effective *before* we
-		 * increment the counter which releases all waiting CPUs
-		 * by using the release variant of atomic increment. The
-		 * release pairs with the call to local_flush_icache_all()
-		 * on the waiting CPU.
-		 */
-		atomic_inc_return_release(&param->cpu_count);
-	} else {
-		while (atomic_read(&param->cpu_count) <= num_online_cpus())
-			cpu_relax();
-
-		local_flush_icache_all();
-	}
-
-	return 0;
-}
-
-void arch_ftrace_update_code(int command)
-{
-	struct ftrace_modify_param param = { command, ATOMIC_INIT(0) };
-
-	stop_machine(__ftrace_modify_code, &param, cpu_online_mask);
-}
 #endif
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
-- 
2.39.3 (Apple Git-145)

