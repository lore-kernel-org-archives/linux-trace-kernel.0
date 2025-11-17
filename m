Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1114F314A65
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Nov 2025 03:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763351368; cv=none; b=kA+1BqoLTs44DTMtP+nvR93VFZNffL6WC+kwGf91/2gSSK44W+3BRHnZD4oApAA13fScUGEHUzl978UyWsd+EVKnhtb0ZZSpgUhE1dxr/kGGfxsaiAR5lOKZceJ/gsjsnlsNWj1lLj1GUWg1c0sGkTGqvkQrFNlXYHmYx/1lAUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763351368; c=relaxed/simple;
	bh=yw0+14vG3MTkylBTsNGEjI1rTbbl51z2DrBpLhZnx4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EPEWVzynYVxNgZDPky7HFuRn5DggSeKtM4gOFYmiPelIof/p5qF5sgG6V/gXTWiLiAhsZvp+z3NXNLG0uqaXTADuNl/wqPQz/fJ8n5Sd1ObuALtLxpCVUJbxngb4yjfaYovFhEQstR/lvHFTKMMSrCKmqrl+gFkxTgUjFlQpHB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkPynhKe; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkPynhKe"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-7ade456b6abso3310921b3a.3
        for <linux-trace-kernel@vger.kernel.org>; Sun, 16 Nov 2025 19:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763351366; x=1763956166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRkWsGzjZIg7j77yjUEwdtDGoZTowRE1mWBAeLLFj3U=;
        b=hkPynhKebPTTFVqZuhGue4sgPwRj245N5SF2dcLva3U/90CsNJu4tsf5DWWoVFevGJ
         vQ0rEwVYaT+wyu8CvLqLlEdQEfnmVg3tnQLRgrre8Houy4GFeSbsv5UPOMdrF2+nx+7L
         uV4xTMZ+6uMcKoJnKrKW5JEiQ4ymft5i3P8KrNB0TDAtddCsfWdKsUVO7yCDlif5F6Gg
         F6WJDsK25MVezlk4pX1BikRIWbG3O8amqRMtjgNdXiDEmbksTPnVsGe63oBcR5KDQuXK
         Oj+ux5idxqjqokGvAJLqlfO3Wt1Ct1uj7dfUzDfahH8naZhA2iXWGaJscpsVfDB6L7h0
         UdzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763351366; x=1763956166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KRkWsGzjZIg7j77yjUEwdtDGoZTowRE1mWBAeLLFj3U=;
        b=iE6jCAxZLix0/me6StGj8JEB5A86KmKtKT0vMidIpvSavHKtdUSRKsjaF6DhjGXCU8
         T0Cdtwu2NjTe+H8ifYSfOpGykFnZOcVQev6oiuYQiPLqVeSnoyuDKAErahVw3ycOMin4
         3M/ds3PJbAk7tryuPQJDPwPjM0Dw4YlADCn/prTJ0rvI+RJduYtIczS5xYHqfei0JSjG
         t69hvOZwYiKZDANyeYJwRYiacCJ8wxCBs68N/W4Q2gT6mXpq54R/46tWsa6h3QiRzYyE
         E58Roq17Oth1tJereDWRa/c1ttuSqqqK8RHMZBWBYerWmeYrSmBxjQtoFZ1wWoATWG4n
         s/qg==
X-Forwarded-Encrypted: i=1; AJvYcCWJ8o1wnsZ6tTPn9RywpssOEX7DtGC3m6Hlo4P23TtBNLEWMwWZxRtamIXgVk8Xakkx39TsNn7Rp+wwT0Z0A+1IO2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTrJZV+83YNXPJW/YmBYffSziBC//9Q/mquEQ8SPmg7LIn5p6w
	XLAEE1i8xmWz8eiVpFJfNOXcx7pH3nF6q+lUyHwFqiX/TkJcsNASSl2q
X-Gm-Gg: ASbGncsrjP8ihk8p33u3tDwnrfxf8RBrKIlGov2loyFdZ59bb3RE6sdQdb/4pc3XCBY
	xqPzP+UdecCrrTxids0/AkyYeIUmUzL5qVffExsn4H2ysP6sDGojins5ujtcYzQo+ZIBaqdWeuh
	Syrv4qmT3h4VU5d15GwXefSC+dX0pvl/dNiSJMOnK2HwKzSiWyU+v5AgvhFmr9yuk+rF7RD8Gwf
	bfxAAk0gkSvkpuY/2tfUSlrL/OiQMRdcUJDwGK/u8T8LbX4zI1H+IliMydVi4NiYKt/NzdxGvVQ
	CBJmi3zXghcLIMPkH5bR5MZS6PBVVCYzapCWEuMumiY/GSopC89NwjpZqUNiJYS4HfMerRv54qK
	6o1ITMDEARHNCgcerguPsdZSYHKgtmaPXUZBEEOV/0KCH6oNLjJZ4o9ljKWZfYUVR1Uyh2f2WBO
	TK
X-Google-Smtp-Source: AGHT+IEWoo9NvVrwFggEbU1z4T+s2r8capz8djYg6deD4z5HEE79cQawvyH0KkyQkeiQELrp+e/ovQ==
X-Received: by 2002:a05:6a20:12ce:b0:34f:b50e:e2e2 with SMTP id adf61e73a8af0-35ba2f6eb18mr12762977637.58.1763351366176;
        Sun, 16 Nov 2025 19:49:26 -0800 (PST)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc37703a0d9sm10348179a12.31.2025.11.16.19.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 19:49:25 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	rostedt@goodmis.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 2/6] x86/ftrace: implement DYNAMIC_FTRACE_WITH_JMP
Date: Mon, 17 Nov 2025 11:49:02 +0800
Message-ID: <20251117034906.32036-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251117034906.32036-1-dongml2@chinatelecom.cn>
References: <20251117034906.32036-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the DYNAMIC_FTRACE_WITH_JMP for x86_64. In ftrace_call_replace,
we will use JMP32_INSN_OPCODE instead of CALL_INSN_OPCODE if the address
should use "jmp".

Meanwhile, adjust the direct call in the ftrace_regs_caller. The RSB is
balanced in the "jmp" mode. Take the function "foo" for example:

 original_caller:
 call foo -> foo:
         call fentry -> fentry:
                 [do ftrace callbacks ]
                 move tramp_addr to stack
                 RET -> tramp_addr
                         tramp_addr:
                         [..]
                         call foo_body -> foo_body:
                                 [..]
                                 RET -> back to tramp_addr
                         [..]
                         RET -> back to original_caller

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 arch/x86/Kconfig            |  1 +
 arch/x86/kernel/ftrace.c    |  7 ++++++-
 arch/x86/kernel/ftrace_64.S | 12 +++++++++++-
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index fa3b616af03a..462250a20311 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -230,6 +230,7 @@ config X86
 	select HAVE_DYNAMIC_FTRACE_WITH_ARGS	if X86_64
 	select HAVE_FTRACE_REGS_HAVING_PT_REGS	if X86_64
 	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+	select HAVE_DYNAMIC_FTRACE_WITH_JMP	if X86_64
 	select HAVE_SAMPLE_FTRACE_DIRECT	if X86_64
 	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI	if X86_64
 	select HAVE_EBPF_JIT
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 4450acec9390..0543b57f54ee 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -74,7 +74,12 @@ static const char *ftrace_call_replace(unsigned long ip, unsigned long addr)
 	 * No need to translate into a callthunk. The trampoline does
 	 * the depth accounting itself.
 	 */
-	return text_gen_insn(CALL_INSN_OPCODE, (void *)ip, (void *)addr);
+	if (ftrace_is_jmp(addr)) {
+		addr = ftrace_jmp_get(addr);
+		return text_gen_insn(JMP32_INSN_OPCODE, (void *)ip, (void *)addr);
+	} else {
+		return text_gen_insn(CALL_INSN_OPCODE, (void *)ip, (void *)addr);
+	}
 }
 
 static int ftrace_verify_code(unsigned long ip, const char *old_code)
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 823dbdd0eb41..a132608265f6 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -285,8 +285,18 @@ SYM_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
 	RET
 
+1:
+	testb	$1, %al
+	jz	2f
+	andq $0xfffffffffffffffe, %rax
+	movq %rax, MCOUNT_REG_SIZE+8(%rsp)
+	restore_mcount_regs
+	/* Restore flags */
+	popfq
+	RET
+
 	/* Swap the flags with orig_rax */
-1:	movq MCOUNT_REG_SIZE(%rsp), %rdi
+2:	movq MCOUNT_REG_SIZE(%rsp), %rdi
 	movq %rdi, MCOUNT_REG_SIZE-8(%rsp)
 	movq %rax, MCOUNT_REG_SIZE(%rsp)
 
-- 
2.51.2

