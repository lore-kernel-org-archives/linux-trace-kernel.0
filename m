Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FCB304985
	for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Nov 2025 09:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763112316; cv=none; b=jlrnatonKRWcbqG0/LXfE7OYtg0RI5BT8sVyF1FMlefeHJXHC+MY8lGKe5uxfjBdDHwvw1/++cyeKbJu5sUm/mhUyVJmAb7F/TeU7xSnC4b3lXRF6uAyb9YH1ug5x5xaXAQz7r0uGi8UZN530L02HHPhNcldFCTp4T/8WfbyNbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763112316; c=relaxed/simple;
	bh=13rTaiSsL0NTZ1YOaRxf6oSc1Dy8agBuYumvqKAnvQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a4ICd22PwH2KEim8UwI/SdrSpg3aJkmU8JaMMb962zV3kyHJqH/DMkpEBj47V90TFsFRTO5BoBjUYuOizb6Yy1yPAJ0lDxMx4HtbrTDDx25GBFPun1jX2+8dksm7yL+uZx1FVhpITakmqdPCMuvhtPhRr6qjNp+cOQx7AdHQkYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KrHL9VWt; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrHL9VWt"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2953ad5517dso20817425ad.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Nov 2025 01:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763112314; x=1763717114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CR4G2sTlGki2siCN1jOZFPTFr3TbudN4PF6c7ryHzjk=;
        b=KrHL9VWtE4O82KxpyXvhAlHSQMbpyLBZwKUcaF4AbRQCceK+D0jWXXwEcDe9XZa/o9
         wyE8FYRpIctdMJ7CAHP+l3qIBfo1b5cHCqcRWDzELndSENhLcw0ooW7g6Og4T6roba4r
         CaX90a2FMRbyAVPFARRBcCC4rrTFqE6SSBJYk88oUK1Fb5MHM8rGR66D8kUNsIyRIfkZ
         xQvX/uUFXgjuYlLocgrzDZKyzj4aoC4pg4yYkE3h/+lRVy4GZjpmNwsM7bYVTPbJN3wq
         PY1FDC2TnuVuNIEfteqFI9zr5zHORNi1i+y+IeQMf0yV5Hss7tyqxGcwlsQHGLud3r0s
         wSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763112314; x=1763717114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CR4G2sTlGki2siCN1jOZFPTFr3TbudN4PF6c7ryHzjk=;
        b=iTXaSXJmxFhM9nxkL+oE1crEhYh2KctQKm6gNO6vQHzEGm9/l7jHycD8SW5vwAM1Yn
         cV2WB2lFkDCuGIHz96VCxGti2nKjPHaw5/KjyverU2RUnOyzTqz2EmpCimMKSNxvxI2e
         Q6Su1mc7Ix+NRBBv+/VuyTgVxZ9uOrMNpNfdKYzuG1QN10rP7zBfgLEHCXCJlqujQY1v
         3y2hPu1dRSZPo4wSkt1dKhbsCya4RrCm/JyVPUcPanv6OUt8VCJ6iIHsQ9TqXWafE7MY
         d3lVFxuh3L3t9oFyDnK7Eivtn3ug8C9bE7T2apJ6pSR111JWaCfj9GHrai18TpGyWPDk
         tbow==
X-Forwarded-Encrypted: i=1; AJvYcCU1sUWgM2qsSF436hhxSs4tH8gjqIB8hL+foy3LsFJ+0QAn2FrmCVbTJSNdOi3/ANsGDb9EhMT0HU/2RJxOR8hl2A8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMiq9GGqyjih+KE8AS2EIuY2ITn826nsxSPLaIn3PI3M+iD/ze
	3pfKLjX5LV9aNusj/Xc+5SNXoc4FNQSMklh8TL9az/IVlYHhXyFchMq4KznPAlFJ2n4=
X-Gm-Gg: ASbGncsXN1kyxEulUhKIz2fFlh905sCOhsfCvP0j9lRKtYTlq9f1pj4fcqB2/GRzqEA
	ZQeKJGXGjMxz+Vj19Tg7nWT9y3hz5PANxRgITVxmvcefC3fFsc1XnnCduYVGYKG9Bi3fPx4fh3Q
	NSQGm6zxey+19nidMKgyMeDo2mneT5p7PNw1re7qPnU/2KxsT5WO1KzfPn2OBl8v/Y/KgyFLxW1
	M1gWqBcnrYohsOhR0sBfLQ0cKDwp+S+B6S/yw320a7U+Y+MsaRjoDqxJX3CJRTFaQQNF1JOheM0
	4I9/mv8tPuqI9dh9vrqJYhvc6gDClISHsAujS1HWUKkdBs2evcB90aH5v1hr0eMLevP8R0ETse2
	Ot9LPqbncfs/g24+icIzT4vLa/cYsxxT9MwnDEdaGv1PfarJonybKbFdvVqTt2gz95746lFnH/N
	i66bF8nlc0Cxs=
X-Google-Smtp-Source: AGHT+IHcncu3fCVBTRgs6cuHPXbsXwtrJ/13HcgbxbxqCj94e5Leoiq1IYCMd5ZzNeVgfN5DkjRaag==
X-Received: by 2002:a17:903:22c5:b0:295:2c8e:8e44 with SMTP id d9443c01a7336-2986a76bc1dmr29990775ad.59.1763112313782;
        Fri, 14 Nov 2025 01:25:13 -0800 (PST)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2346dasm50451525ad.7.2025.11.14.01.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 01:25:13 -0800 (PST)
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
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH RFC bpf-next 3/7] bpf: fix the usage of BPF_TRAMP_F_SKIP_FRAME
Date: Fri, 14 Nov 2025 17:24:46 +0800
Message-ID: <20251114092450.172024-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251114092450.172024-1-dongml2@chinatelecom.cn>
References: <20251114092450.172024-1-dongml2@chinatelecom.cn>
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
index de5083cb1d37..2d300ab37cdd 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3272,7 +3272,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 
 	arg_stack_off = stack_size;
 
-	if (flags & BPF_TRAMP_F_SKIP_FRAME) {
+	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		/* skip patched call instruction and point orig_call to actual
 		 * body of the kernel function.
 		 */
-- 
2.51.2

