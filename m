Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4D0315D39
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Nov 2025 03:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763351373; cv=none; b=VzQsTR61pU/J1uqboLLh5RB1dxRidMYOi3+fgvKAov+ghYKbwj6M6gJ7LZFChzIXfuNqEDhS97lL4OC1Fn1vJcHp2XFCHZaD6EMouXaA9xewZP9EBhzQSLfuhaoYf4OI+PFD/1qbuJT2Zlz9JoWQDeCfpAC3imYwQ6p1VL+J51c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763351373; c=relaxed/simple;
	bh=CuZzfhxpaY2RwGDUn1Vx9bQnsJNO8QHP2g34k19NaVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=abGLP9vvBfYMy++hpsqhnHLF7p2RsMyUjiLgnr3sq/mca4XZs58FUEz8rPQjOdukOosf83FZFjY1SGJcXjU6Gi3Scqj4W0uIu4zbiO6iraYPSv9QNQqwMqmmzXg8zv3/Iidmxco2tkqHSE9cO/3rkmyaKZtnFXsrwSaqg6gE/SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQsrDH3T; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQsrDH3T"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-7a435a3fc57so3538989b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 16 Nov 2025 19:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763351371; x=1763956171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gr5zFCvf3ujgW8K/MBn3EvZvT1zNiYJuY8EfOcbbjUE=;
        b=UQsrDH3TOamJbHpZtRnA99ovxE1K3pPfoCmqViPWdqB4HAPDC0nO+Y4kS0jF7gt8K+
         8DxNUovN4945HxYrK/nkDAAUrkT305H1YHCteTmbjqejdCGtG4miGTD8RbvsFdczjp6k
         mq4P89LG+RBLIu2iSCBv9s/iWP5hnfHR+8b/D+ukcsVgnyTEEqe92zJy/rWZSgEpzkHW
         ULTZC8rzkZ8S6qYNNlMA+LgjjaBm96siPwUMHtmun0pvp5SH2kfZQ2cbCQtj5u+VASVm
         +Y3GcdYH2lPqFA7wWI8zoorKttncUBPE632qVmzIjHo9U6KJ7vokLgjeSmt0TGN4FZMc
         9Scw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763351371; x=1763956171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gr5zFCvf3ujgW8K/MBn3EvZvT1zNiYJuY8EfOcbbjUE=;
        b=WjYHZ/7dmA9DscSpgqlawzCwVRzo0r4g/rV68hYFhBytBWYaJF7g9n/Wt3dT+e1pac
         FO2LxfwiZlSHsEbXtD4HZAL6unmWxuKH+WBX8zn8OnHQuK8GZobRfSB7LM8oTKYOS/2b
         g9RonyaTpOyysjhlgXYOCiM1/Y1Qm2c49duMJvN5QzgOEB3HPqXcwGZSE5f2mVpRKGan
         HrJVCZLW0cDqKUMXQxPFuXaz/3G8UmjMJU+OwL6CMIHUdi8zA8Dojmo88uyUBAM1HZqs
         T8wcSizJ3h0mNYT29kchB5NhUGcRQNcnCUENKJNECfYqrt4XCVDIwhgRjtLhU+DzfGbt
         kaQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOXZfu+/ho3YXCMpZhsU0uJMEaDz8tQIFDYn2P70Fsg9IxwGfe/o2IjQvJcAbE2W4h8JIqeMeIs2/ApWZZRmb9TcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBgEw2tFF945dwg6pUyomEZzSfj5aiFE8ZvLBc7ZqyuxJkUmOL
	IMOYBSD/+LVPQfFyj/ztzUcFIOK7riwqtOxN8mNDGZ2UiWvQ+ZifFLWG
X-Gm-Gg: ASbGncvI+91EWmEPTcuQAb60Sacdf3IUqTMvMqfePjwFmvTvIvQnC+eFxzAwkeooY6E
	uyKLfCgFm+rUSja99DhzouXBx3xeKaG+WbQEAbDfdUw+T6EBbionyPaBOzCtb8zNAGVDDirS29x
	mXPMc1uFOmLMn7IZzOXd6GMUabpyWk6cZoGuCHUmy4DRcMm7ZpLxPJXL2daYJ/Il1FRwnifBYQJ
	zBcbH2LtUgF7J9o66Fc0ycdxs1M+GqyyJY/AWAYNr6xqPq8sTPy6PIHT1uflcZDsOocbtg28LbI
	8l3bknjZuw+9rQ/15NIEi3ZR1jn26QQG19lViigNzDCLFeyGswlN/fDCjeAd/SXorPYSA5nwUPn
	+3/5ueYcBFLxkwg9pYINNIz3ileX3I/69mDIMCjBzjyA8fa3qpKrewKSiB6a145/zqvrjRxKq6l
	ks
X-Google-Smtp-Source: AGHT+IEsiDE6ta++Kmx6LtSUk5n6u7iPjxOL8FLATJIsjty7oKbw7jcSClMzSU49gt+/kqfQxb+meQ==
X-Received: by 2002:a05:6a20:244e:b0:33b:f418:c3e8 with SMTP id adf61e73a8af0-35ba259aaebmr12228233637.60.1763351371537;
        Sun, 16 Nov 2025 19:49:31 -0800 (PST)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc37703a0d9sm10348179a12.31.2025.11.16.19.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 19:49:31 -0800 (PST)
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
Subject: [PATCH bpf-next v2 3/6] bpf: fix the usage of BPF_TRAMP_F_SKIP_FRAME
Date: Mon, 17 Nov 2025 11:49:03 +0800
Message-ID: <20251117034906.32036-4-dongml2@chinatelecom.cn>
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

