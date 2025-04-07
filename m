Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B6B22172D;
	Mon,  7 Apr 2025 18:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049359; cv=none; b=LDp4a2ly++MEZIT1lJ8s6Tql4Nu1DzgSZr+Sded4xggvpBssyXxqt2ps036MV0J1JSSBwtKJKwPRz81jhTigPnD7UQjTtpE2x28/6mpzn6eUShqtEZDS2wLSvc1tTky2v6ofFYQ9NIqYEvTzpi3r/2vA3dtQdBMib2rKrh+OJ70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049359; c=relaxed/simple;
	bh=agVH5EqQC74AZQuZVZRWvc3EDR17eFHNK2n6C56gscc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WLZgOjizONQAc/fQlJyCtk/MFNqV9XWjmoK43r+7AiIPPjjt0jTs3eMAjZltDIrWsRLeUcIT90NK4bbVlEtGisvfCCbbhgii83NdqpgiP1xOVFUjnX4Wke/14WDX7YkmsmHSPOHebjDibN/YniRjj5HxTYXzMBsvHM2sGnmUsCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWpk3dI3; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWpk3dI3"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22580c9ee0aso50092985ad.2;
        Mon, 07 Apr 2025 11:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744049357; x=1744654157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9VOOAOCKhHyxTpEvBxwItchQtvdn2LoPZ+ikId4PHc=;
        b=GWpk3dI38hpQBTgaYWiA69MT6oAlxCacfCr/EVWgn9BeasEePW57H8Dy6UwLv5jxiO
         G75ZZjW75kE7kfuI7ccXqG3mKLQytriMLXmZjzbPxoe7qRXThpV50l044HvWe6L3vwvu
         LNpNPqOAyDmVf8AcJ/f0knukBfd/27I6IWgkAw+D+SnTiT1ziN3JojKVAUVxS2DRxvH0
         j0pKPuVbYNCWD10aE5NPIYCB7wDOPdc8FxN7T2iMT4Rx+RXtuvqIS5WhX7fY8mkDIyy0
         5alPRN72XRH7djVq7nE2h03jFQAUxcd+C7XNo45Cs4Wm+cD9LM3TomGlbfQyqZADuHrM
         XVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744049357; x=1744654157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m9VOOAOCKhHyxTpEvBxwItchQtvdn2LoPZ+ikId4PHc=;
        b=PBgKrVadCYaRWDs+ylVzVF9EfkZAfgFgBkhFr70X3wcSz3idcIJcYHoxAY7BW2ELOU
         7screFbEjW2+j/+TYvCLDX/GVGl8tVngzK8nbHKUs0D4P45/twX62xJ+2s2zyw9JPyMD
         KiUBJgiEHJKKwPQ7NQdBGL3TBav/dS063Gj6VLAd1KUpRXFPEZmUfW+etlNWZDRRB7tJ
         lmaFB7cJiR68j/8OCk817/zF45PNZTrxzo6ZhluRFysIJjAJ5e5U0NgjZWjbLrw7Rmp0
         AhPJj3vMqHD7c9Px7zcnsC2v4WhKaPUvZigHrDQZ22/YnitRdjYeFAGxT933LUgsrRR3
         G8Og==
X-Forwarded-Encrypted: i=1; AJvYcCUuW8Whsjt9WDwuPmv/cujcc8xa9OeJNS2QPpyi/Atf2JHDK4887n+tcUcfmhPfSTRfh8kHcUhkRNp+mL8=@vger.kernel.org, AJvYcCVpdR9thPQlk0uUwlHDD0EoypitYwFaoWxdEaS5RltfmTIm06f0QWodr1kPX1Et2fNogCPK10e3NAZFpOclijCqRKcz@vger.kernel.org
X-Gm-Message-State: AOJu0YwKY0FfHCVpN+S5U+oX5CWD1QXHTRvhtrDE5QDyZra2fm8CgzN1
	MBUsTwon2WT31dyHzTWNb+v2d30yM34oBuJRkneswzxeLtL7hoG7
X-Gm-Gg: ASbGncvVFcb4lJBLzymjirH3JDx2KDaTuwWULqL6SPrEuf96Kt2UKGlyUemU5/q56W3
	EIwb36eMtzNSWikQEqfbw78SwNvetDkCvQvALRuCA4DCvYz+S+30pIquMcHxMF+lY9xS3qNYz0p
	8+gHbOZH9ekisAtCebZHYchtzzwDbjA+t2slSGerFTOu/xIrUSfYH8Xg+onJR1HmS6Ron+/POna
	xrj9giynqEtScXSwGUECb4Rmq5MA5rHih3MIMT46gxoIKJnIiS1DIAo/hRlHRJQ6aE6NxlkIK28
	X3Gz4fZGn6ykkcneLYXb2QR/0VDivX7M80g39tKq4yhCzUSlqAtoCwCmz/yg6yW9pwOkPZjYe7G
	+8KVojvJMqqcUNxsZo+te5Y2RXi90942MMg==
X-Google-Smtp-Source: AGHT+IFf6ha6oIioXqe0Dl7spY0xA264EoHLx7/lwi0vWS1NoagPzSr/i5AfZPigVEpWrl+bKtG+9g==
X-Received: by 2002:a17:903:1b2d:b0:216:7926:8d69 with SMTP id d9443c01a7336-22a8a8dd69emr158392105ad.47.1744049356897;
        Mon, 07 Apr 2025 11:09:16 -0700 (PDT)
Received: from localhost.localdomain (118-160-134-247.dynamic-ip.hinet.net. [118.160.134.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297865e03esm84282455ad.146.2025.04.07.11.09.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Apr 2025 11:09:16 -0700 (PDT)
From: Andy Chiu <andybnac@gmail.com>
To: linux-riscv@lists.infradead.org,
	alexghiti@rivosinc.com,
	palmer@dabbelt.com
Cc: Andy Chiu <andy.chiu@sifive.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	bjorn@rivosinc.com,
	puranjay12@gmail.com,
	paul.walmsley@sifive.com,
	greentime.hu@sifive.com,
	nick.hu@sifive.com,
	nylon.chen@sifive.com,
	eric.lin@sifive.com,
	vicent.chen@sifive.com,
	zong.li@sifive.com,
	yongxuan.wang@sifive.com,
	samuel.holland@sifive.com,
	olivia.chu@sifive.com,
	c2232430@gmail.com
Subject: [PATCH v4 06/12] riscv: ftrace: do not use stop_machine to update code
Date: Tue,  8 Apr 2025 02:08:30 +0800
Message-Id: <20250407180838.42877-6-andybnac@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20250407180838.42877-1-andybnac@gmail.com>
References: <20250407180838.42877-1-andybnac@gmail.com>
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
Changelog v4:
 - assume ftrace_update_ftrace_func is always called with irqs enabled
---
 arch/riscv/kernel/ftrace.c | 64 ++++++--------------------------------
 1 file changed, 10 insertions(+), 54 deletions(-)

diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index cf78eef073a0..aca1a322e0aa 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -24,23 +24,13 @@ unsigned long arch_ftrace_get_symaddr(unsigned long fentry_ip)
 }
 
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
 
 static int __ftrace_modify_call(unsigned long source, unsigned long target, bool validate)
@@ -129,51 +119,17 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 	 * before the write to function_trace_op later in the generic ftrace.
 	 * If the sequence is not enforced, then an old ftrace_call_dest may
 	 * race loading a new function_trace_op set in ftrace_modify_all_code
-	 *
-	 * If we are in stop_machine, then we don't need to call remote fence
-	 * as there is no concurrent read-side of ftrace_call_dest.
 	 */
 	smp_wmb();
-	if (!irqs_disabled())
-		smp_call_function(ftrace_sync_ipi, NULL, 1);
-	return 0;
-}
-
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
+	/*
+	 * Updating ftrace dpes not take stop_machine path, so irqs should not
+	 * be disabled.
+	 */
+	WARN_ON(irqs_disabled());
+	smp_call_function(ftrace_sync_ipi, NULL, 1);
 	return 0;
 }
 
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

