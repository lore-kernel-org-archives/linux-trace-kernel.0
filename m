Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025B03559C9
	for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Nov 2025 12:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763469430; cv=none; b=ADb08MNpi2hCHGy/oUvdluCVZret1h4lo1iO3/fROtA0M5O5o50U5mkWr8WzIpnV7HNuia2Z+22xx8W+wth5Kj+wUrvM8Pi/BpOVy9NhqSKxnlkwPmuH2lc3aK1vSA4kAUfQIIuQRy/H2uBkmnMsSctgzkfit97WvIL5Ei6+7IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763469430; c=relaxed/simple;
	bh=CuZzfhxpaY2RwGDUn1Vx9bQnsJNO8QHP2g34k19NaVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gwaZzlNZLJcQZmFM+58fuefVnE+tHwBB9JGpO/Tmv96MmnnNXsJy1pSAmC1LWBHUA7E033UHmF7iHaF9rnCHEXqwEmL7PpsflqD0OfBw6bnU6xuOYVmVGrvBi8H0oHteWtfg8f9ItXIFUfZ80mjbxgzTudz2WKRunAHrzr+2gM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/FOs5sp; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/FOs5sp"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-7b8eff36e3bso1752844b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Nov 2025 04:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763469428; x=1764074228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gr5zFCvf3ujgW8K/MBn3EvZvT1zNiYJuY8EfOcbbjUE=;
        b=F/FOs5spanaAWg1eMuStZ0swyfWqGCjFh3BNVwH8MObwzotT48DICKhvWuX+Yd1mhx
         jBpKQxxFcWEeFYDz/F8w/zLigNcE8//nXMsAH4q8mYl7AbZ7d7eUgLAEGG91QlVt7Kyl
         rkZTuk8KYu639iPWBf1hxj6vl42p70b90ds9++2VgJ6ZUfR8ZQmTbPnbUL3yz6gMZm3n
         FTtvTKe/ReebLrdyDvvS4Dw3/hGMX3sN4P56pYi9tFK0sXIZkiAxnKrzVoYHQUdnD4Lv
         d516NKodA0yCA+53y/w1XXIS8MHZylmkqq1ZpVYTGHjEENLNnB4lDrqRRfbE5s37Mwso
         UKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763469428; x=1764074228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gr5zFCvf3ujgW8K/MBn3EvZvT1zNiYJuY8EfOcbbjUE=;
        b=uoOjh9SvqTdMf0vry1PQ3ur5KBWVwN1Qx+r45RFMyteYHxknKrsSBh8PJ/ps3+VCxC
         +/7sU8YsMcSfKuk2tIei7vFXRgyX/cTSdU4tqJ7dt69ZwUZiQ3Lg8ldUTNfmaS0JrENz
         td6dB89pV87ELFaDx9Yq9pRxP7KGY0eLA1EzWfQckYK95k6/I/4bWt9LFupZ6mFVXsgW
         8hN8i2DH3WsdIEA7GQfrgLcHPoxSHXZBIiT3o2D6utqASJuDMBjTWt14qTXzVG02psQg
         FHyOFjOeLarN+U53FiZjin8hRYshejIGCHSR0Re7MSN6nBnwX/zDCo9st09K6/DGG5Ca
         p7UA==
X-Forwarded-Encrypted: i=1; AJvYcCUP7CEXz2+keGHNWDzOzLcNrsmz8gDWkP1i36AoBU728lSi1X0mpW0tigtKMspdwiqIKB4/9gc2QYDM20WSzEVfPhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJuQ4GrCJCf8CPnnrszLD6GngU79lH/bndQZaTdY1TNWHgK0N0
	2pPb8ERmwU6FNTSszZuLMx9Tsjjq+aLNU1y3anAazopYGVZDgcrvf6P1
X-Gm-Gg: ASbGncufAzxWsq+4J9Y/pGsy4j3CnJ81dY5lL1+hU7lnFt7r4izq7eKTKrWHVf9zEkr
	KRY0O9i/Jok6PDL6MotFLuOV7qI122dWbHMYcNe4EvubterE7PuqXPUBCObKCRnhX4WODKuv846
	EqHigxysQubgLyQEBBmS2mwuBjNzHMP29N25tCMlAyFniVnaczJtMnA5JEqK58V3Jqp3oU9Hu8Q
	ghHtHOPvEbIblzxTYZ6BfboRXq48MxIgxoH6AAgJA0UrzCjDlEIsATfcMAV36qjLzFSTWuMgqOD
	5Iv27u4SJzy8gnAwvTB7pgV6cgoroPp6rAW9TzcrRYw4aVCfY6LAwievPVU7ogbWQmlE3Dp8JYj
	F5DyrxgRk5cdIl4tCxIJ4XBvP1d3YxsOsxKqt5HtjBlLKV/PbxYpAsplXf7VZP3bpIYCkeoA+oN
	RnjVyWhHiDxqw=
X-Google-Smtp-Source: AGHT+IH3lGATztfAevxX/+Crp6j/wkxIW4bZ1e3m6KQ8glDX3xAvYvs6wWCH2053VFn2llBG12hFJg==
X-Received: by 2002:a05:6a00:2408:b0:7a9:c21a:559a with SMTP id d2e1a72fcca58-7ba39bc0c02mr18696620b3a.8.1763469428198;
        Tue, 18 Nov 2025 04:37:08 -0800 (PST)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b92772e7f2sm16331496b3a.57.2025.11.18.04.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 04:37:07 -0800 (PST)
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
Subject: [PATCH bpf-next v3 3/6] bpf: fix the usage of BPF_TRAMP_F_SKIP_FRAME
Date: Tue, 18 Nov 2025 20:36:31 +0800
Message-ID: <20251118123639.688444-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251118123639.688444-1-dongml2@chinatelecom.cn>
References: <20251118123639.688444-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some places calculate the origin_call by checking if
BPF_TRAMP_F_SKIP_FRAME is set. However, it should use
BPF_TRAMP_F_ORIG_STACK for this propose. Just fix them.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Acked-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/riscv/net/bpf_jit_comp64.c | 2 +-
 arch/x86/net/bpf_jit_comp.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 45cbc7c6fe49..21c70ae3296b 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1131,7 +1131,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	store_args(nr_arg_slots, args_off, ctx);
 
 	/* skip to actual body of traced function */
-	if (flags & BPF_TRAMP_F_SKIP_FRAME)
+	if (flags & BPF_TRAMP_F_ORIG_STACK)
 		orig_call += RV_FENTRY_NINSNS * 4;
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 36a0d4db9f68..808d4343f6cf 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3289,7 +3289,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 
 	arg_stack_off = stack_size;
 
-	if (flags & BPF_TRAMP_F_SKIP_FRAME) {
+	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		/* skip patched call instruction and point orig_call to actual
 		 * body of the kernel function.
 		 */
-- 
2.51.2

