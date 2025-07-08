Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7121E231E
	for <linux-trace-kernel@vger.kernel.org>; Tue,  8 Jul 2025 08:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751963690; cv=none; b=eSRYOwy1ECvlj2Mpi6rC7vu1AcEG4RGQxGRmolpWKNkOmvfBpi63MyetHKi/JyP6iTUDFQ7BUQ1fjGNXoinxuhFG1x1PkoCC3DyzlUPWq4GYdbY3/a0QlKIrck5db10hWQWezZhe0WNZVFYLqYZtXEXaMq5aJoQzWaKnNqDYHkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751963690; c=relaxed/simple;
	bh=3Ds2Sx45pnkMg7iaFweDgWNlUOwHGzX5GUkhgeYgbzQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FGVazqGMA6ciOw5gBp/VLIcA+CBMxzVv9AbA3S7aRx2edyeNp8J3wmq1FgVF7Huhn4nUjleLp6E1nIno7RV6UmblGJmd0jALZpJgFxy/qrSYibEdIqk7vQYM75jhUySlyRH/86PPhL/HPkdf7q0Ctk0it9a7y3qHc8zVoRM7MO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=JHlCq5M/; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="JHlCq5M/"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-73c17c770a7so5039884b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 08 Jul 2025 01:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1751963688; x=1752568488; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=km9alGI0XcL6Qvzjzja6icFIdbRKvCumIapJv3kvhgI=;
        b=JHlCq5M/IYsv507yOK/iTHer+g0MTpws79Wg84pR4YXLTi3g0xFVEfKBISBY5rXMjD
         LUTIddSIPHdwfK6WO+apj5EZSwotAg50PwzmzH2HSqkzWfrXpT516GTiut7iTpjZRtKL
         l9v4fIxBWQr6Yy4w1SWos/MRMZI96/8cNQmVce61rG7MxAIyopRTY4IezJsITs2viXj9
         KCoEKUBg0p7fBX2H9dL8Q3oyHS87R7nDSBxL5bGquZa2CXHBnXqDPFckMz2lkwcOJ4Ph
         pUoNTPZpoIf12pOtzdV+9teoDqAdU50FMaOwfAkYDEkXl08T45qTToEEhdSVNwx7ZnnU
         YrKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751963688; x=1752568488;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=km9alGI0XcL6Qvzjzja6icFIdbRKvCumIapJv3kvhgI=;
        b=VEF04JDv99FGq8Gv2mFzW8nxhLZGduHmRtJpzdKZ5iaMQcLs15n1quyNknQ6lbk+ok
         UTFtI61ff8mi1oZwbNxwtdVHQ98d+vVEHNtEyvfN/bJqafk7MToChWK9DMT+Mi6Y3ZAH
         FlTGlLkBIWz2CP1LCg6igD4C4BJUQ9vHPiP3JfxPXWpiROcTCJqfVNW5ZylDvObKaH3F
         ESW/RE5NmxrDtuj10PuF1Ed8ibPKZLIDU29SlpaRtark7OF13MCxMOBscHRv1tch9Q/x
         nWVWR2dSqjhehz01NL3efIeUZzBXoZbZ6DS8HkmPGDJVLLqBJPvjLW7oLMgKHe2GYcp2
         iu5g==
X-Forwarded-Encrypted: i=1; AJvYcCUNioy/AMO+DT/5bwjRh9/jMhhTBytTArkQsltFWmaeIYwKsgR7cbW8lnStbxTgnQsr4z1p7uRiRWUPKzo9tWPDq0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyxOkk/7hWRLpg8PwBwlMuJAdV6l36NIk3gR/awZs9m3e+YKlZ
	SMDxlq/wMgc+6psJcVDztcgVCixe1ZBH/C36GqUTWQXuzXC0SBpwUw18g1SrgQpp6cg=
X-Gm-Gg: ASbGncvT4swp8TKc6lLEIJOAqnFBo8qG1k8gDpfQKtlV5upsAueiHhEc37Uf2wVcbLA
	UML+dbHlVI5I3DAXFNspjFu2mH5t07c7vieN9BjlIeniAO3DxL1vsKhEKMlrKeUDn5Nuha65Tjo
	AY0fRI3WCL9T312MEvx2jSqnj9VF+WJyaQCSWfa8ckro3eFbx5e99JLw0sqjDfWnsLTQOjfO6+m
	f5s77M+YqzFfG9W/g9vrqsq7loKeg0+VGXbg4TP/2I1dnMvTxSDrEpxQCn5QVz36UIdgF7EBC6h
	jE50frXNlmL/GDt0dC5vO8uAqUj8sgr6L/yo+VaRrLQLW6eql+FdG1vx2GfJq1x2J003MOVTmZR
	Ecgy2oyDA2mXoykdmQftd15Q1ituzOt4Qzt8ZZPj5Ov+k
X-Google-Smtp-Source: AGHT+IHRcwV/1/T5oymXkbwGRFIYuEsWNfVXVWrzLoP+RWTG54BAK6UpJOoefXueOfXgf20o6DvMKw==
X-Received: by 2002:a05:6a21:7a44:b0:215:efe1:a680 with SMTP id adf61e73a8af0-2260a795654mr20246310637.16.1751963688189;
        Tue, 08 Jul 2025 01:34:48 -0700 (PDT)
Received: from alexghiti.eu.rivosinc.com (alexghiti.eu.rivosinc.com. [141.95.202.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce43d4f1asm10877511b3a.161.2025.07.08.01.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 01:34:47 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Tue, 08 Jul 2025 08:33:48 +0000
Subject: [PATCH] riscv: ftrace: Properly acquire text_mutex to fix a race
 condition
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-alex-fixes-v1-1-5b008d3f4d0c@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAOzXbGgC/x2LQQqAIBAAvyJ7TlAj1L4SHazWWggLF0II/550H
 GbmBcZMyDCKFzI+xHSlBroTsB4h7ShpawxGmUFZ5WQ4schIBVlqtNov3nkfe2jDnfEXrZ/mWj+
 cWU9oXAAAAA==
X-Change-ID: 20250708-alex-fixes-1e719b9899f3
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Han Gao <rabenda.cn@gmail.com>, 
 Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <ziyao@disroot.org>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2192;
 i=alexghiti@rivosinc.com; h=from:subject:message-id;
 bh=3Ds2Sx45pnkMg7iaFweDgWNlUOwHGzX5GUkhgeYgbzQ=;
 b=owGbwMvMwCGWYr9pz6TW912Mp9WSGDJybqi8ChN0klf9crq7b8aPt753f26W6d7Q/lf4XIly/
 tbNVWHHOkpZGMQ4GGTFFFkUzBO6WuzP1s/+c+k9zBxWJpAhDFycAjARhkcM/71fRb1avvPr6cDQ
 57eWZxy+GdJybW8Tt0THf0umRv+l5qsYGe4fuN+4spx9reHpB0yRSob6tk+dHI13b2m5sXtL/ql
 4LV4A
X-Developer-Key: i=alexghiti@rivosinc.com; a=openpgp;
 fpr=DC049C97114ED82152FE79A783E4BA75438E93E3

As reported by lockdep, some patching was done without acquiring
text_mutex, so there could be a race when mapping the page to patch
since we use the same fixmap entry.

Reported-by: Han Gao <rabenda.cn@gmail.com>
Reported-by: Vivian Wang <wangruikang@iscas.ac.cn>
Reported-by: Yao Zi <ziyao@disroot.org>
Closes: https://lore.kernel.org/linux-riscv/aGODMpq7TGINddzM@pie.lan/
Tested-by: Yao Zi <ziyao@disroot.org>
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/kernel/ftrace.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index 4c6c24380cfd9d6c51f0e4340cd674160b83a610..22e7bdf8de2b6ca950cf2c8b734bc82ea46ba8bf 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -14,6 +14,16 @@
 #include <asm/text-patching.h>
 
 #ifdef CONFIG_DYNAMIC_FTRACE
+void ftrace_arch_code_modify_prepare(void)
+{
+	mutex_lock(&text_mutex);
+}
+
+void ftrace_arch_code_modify_post_process(void)
+{
+	mutex_unlock(&text_mutex);
+}
+
 unsigned long ftrace_call_adjust(unsigned long addr)
 {
 	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS))
@@ -29,10 +39,8 @@ unsigned long arch_ftrace_get_symaddr(unsigned long fentry_ip)
 
 void arch_ftrace_update_code(int command)
 {
-	mutex_lock(&text_mutex);
 	command |= FTRACE_MAY_SLEEP;
 	ftrace_modify_all_code(command);
-	mutex_unlock(&text_mutex);
 	flush_icache_all();
 }
 
@@ -149,6 +157,8 @@ int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
 	unsigned int nops[2], offset;
 	int ret;
 
+	guard(mutex)(&text_mutex);
+
 	ret = ftrace_rec_set_nop_ops(rec);
 	if (ret)
 		return ret;
@@ -157,9 +167,7 @@ int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
 	nops[0] = to_auipc_t0(offset);
 	nops[1] = RISCV_INSN_NOP4;
 
-	mutex_lock(&text_mutex);
 	ret = patch_insn_write((void *)pc, nops, 2 * MCOUNT_INSN_SIZE);
-	mutex_unlock(&text_mutex);
 
 	return ret;
 }

---
base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
change-id: 20250708-alex-fixes-1e719b9899f3

Best regards,
-- 
Alexandre Ghiti <alexghiti@rivosinc.com>

