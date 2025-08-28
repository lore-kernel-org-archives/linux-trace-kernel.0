Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498D92E040F;
	Thu, 28 Aug 2025 07:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756366470; cv=none; b=g67h/2qi5HUX5rAdySNbCcLypOQ+vQkiHBZN+FhAaUJ72w2l6p56MH/d9Ytw+4jMVKg0LCed+Qt7ZGLVhrZQr+3BXQfhlBKvZsehU/WNSYbI/aXzIj1EYkOiPyWzTQfgq+ehqQ0b3OQOLJ9oArduB5O7wrB/nGFilar0ajL9mpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756366470; c=relaxed/simple;
	bh=4PtaQ74SJJPVLMYDACBxzq/zXR+p3d86HHwkF6eNxxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MD5Sz5nirKZqWfK/IkelA4TPmsYmfyr07EN3+CH0MIbfCMRiFqXyhea2IjPfEti0Eaw8b6iSwtDz3HkR4hmei/3GqyrdVn11w7hQSXtU9ipskELOGy57xq7m7tSzFXFLQaj48JEywYARUr15q7OSK/oDel8uFDhtMTXtLrZa/tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUQwbD9l; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUQwbD9l"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-248dc002bbaso3272205ad.1;
        Thu, 28 Aug 2025 00:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756366466; x=1756971266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQYOiNSD0BVFYt8LJn6Fepybq7p8FLHlj9qtf7JwQoI=;
        b=bUQwbD9lMuoyP2w30lTwK0hBzlrtkuyJnseJ7gaycI3XfV44uhJZuQ3pJcz7Bd0oAI
         NYs5YebXCbnC4Q/0k5p64oUNz9NXDX3p/DSEA2/kCbWyijVqbzlHefOQiDeQhiH35O6f
         Xo2hHU5nv2NGTw1ohUPsJ13Zt3mKR//CicRaatSNcQlok1dy1fiu0cLkvV5ExF8pfFVw
         nSYvY/9oYik/KUu0zqwF+ewqKr27Z8c1dUaYyASBUiXmCp9sjqvmXwMeDI1vFOd8VlPz
         ulwCM4C3LisO/NxBTYF78A4Y6s+BJKo8J3VK1gvsXuUGse4WBsUUgXRRD0+Uh5QAG52q
         ifLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756366466; x=1756971266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BQYOiNSD0BVFYt8LJn6Fepybq7p8FLHlj9qtf7JwQoI=;
        b=d9jiIqc5fkUd3is5SPWkT2Qb+wG55XSnqN+Ou3yHqQu4+XYnd9eXddp3b4fX0yVyhz
         hY3ZqzrGgjHsJwWlKs2DNWpwPKakq/hOURyzDHbhlaBhghy1sUdISH+dsFB3DTiVxYdJ
         jUbyEIcFZ0tdZVR+KK6Ykfl2W6umbQy1GlpFVd9VQlPLsRSSWn4KECsAyTPcg1emOVTJ
         72KoRbHrwjzq8f0MDu8fBUAW7AWSOaxll/Kck8cxCRhMXDEaZCQw2UxXXKGbe3C6lhL5
         GDzQwoolEXDdh0WR2nnFEpCPBzmUwAeHxGlH5qubvVFSwDUvBlxHBdeTTd3nSS1loTtA
         Y1IA==
X-Forwarded-Encrypted: i=1; AJvYcCXZX8TukVfVVTFGr/NNDlSFvzG7oxAVmH0iNFD1arpq1YHpTcZoTB4RgeXdKuA3iEdx2gIjeoUwiVPzcw5mn9PBorY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlADKaQi3nU/UwAXqZB2X6u97zl5biLkAxNhTvmgSQhsRD1p+b
	qayLlML+arNYo5rg0On7pEZGrp9HNXz95oLkEQFudmD/mal/c01N6fKm
X-Gm-Gg: ASbGnctZphdlgdRS7s6z+bhHq9JMFjCFxhXZaugkb/WhYtj1KOQU6P/hWt0mEm+teM9
	MGxE4t2WjyxO0NqKs1e2Yv3btOGTITX+XLNWw8BlkU1iN90veFjrWZrYP8/lDh5d9RpUNDC3NUA
	fiaWeCEnIXY+V9OCYlRXciLZeStatOqBQSZWR42wgCKKxAZk7u6z8S3yUiYRHhAazcb+YmjJcGq
	eKGi9TTaOLsXrGeePGKnqrpT+UOoRyNBK0Y3cYktdoynpaISyIi+wdYcBz+KzDmmOCBgkApkHQm
	vEScOrwZb8Lsz3g9bMqSx/MJG+5rEogRQSBKBONj5roBDQ44UO+ZqFYUyKafd3v/+2gdJ4p3Kct
	fHCb+jO5cHyNU75lbd6tYiJw5WdpIr4Hv+igaR64wMARws0PD1kBie6phjDt+brTk1/xyQZ0=
X-Google-Smtp-Source: AGHT+IE4aRaufJVGsSk9bLtr/W5Lqko9zfUO1kQyEX8W4RgjXYJGEEk+9pgg5qU+rFjRTJfPqxplDQ==
X-Received: by 2002:a17:902:d4d2:b0:248:9964:3796 with SMTP id d9443c01a7336-24899643b24mr70784475ad.43.1756366466373;
        Thu, 28 Aug 2025 00:34:26 -0700 (PDT)
Received: from localhost.localdomain ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cb8afb7bsm13182613a12.16.2025.08.28.00.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 00:34:26 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Naveen N . Rao" <naveen@kernel.org>,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH 05/17] x86/HWBP: introduce arch_reinstall_hw_breakpoint() for atomic context
Date: Thu, 28 Aug 2025 15:32:38 +0800
Message-ID: <20250828073311.1116593-6-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828073311.1116593-1-wangjinchao600@gmail.com>
References: <20250828073311.1116593-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce arch_reinstall_hw_breakpoint() to update hardware breakpoint
parameters (address, length, type) without freeing and reallocating the
debug register slot.

This allows atomic updates in contexts where memory allocation is not
permitted, such as kprobe handlers.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 arch/x86/include/asm/hw_breakpoint.h |  1 +
 arch/x86/kernel/hw_breakpoint.c      | 50 ++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/arch/x86/include/asm/hw_breakpoint.h b/arch/x86/include/asm/hw_breakpoint.h
index 0bc931cd0698..bb7c70ad22fe 100644
--- a/arch/x86/include/asm/hw_breakpoint.h
+++ b/arch/x86/include/asm/hw_breakpoint.h
@@ -59,6 +59,7 @@ extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 
 
 int arch_install_hw_breakpoint(struct perf_event *bp);
+int arch_reinstall_hw_breakpoint(struct perf_event *bp);
 void arch_uninstall_hw_breakpoint(struct perf_event *bp);
 void hw_breakpoint_pmu_read(struct perf_event *bp);
 void hw_breakpoint_pmu_unthrottle(struct perf_event *bp);
diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index b01644c949b2..89135229ed21 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -132,6 +132,56 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
 	return 0;
 }
 
+/*
+ * Reinstall a hardware breakpoint on the current CPU.
+ *
+ * This function is used to re-establish a perf counter hardware breakpoint.
+ * It finds the debug address register slot previously allocated for the
+ * breakpoint and re-enables it by writing the address to the debug register
+ * and setting the corresponding bits in the debug control register (DR7).
+ *
+ * It is expected that the breakpoint's event context lock is already held
+ * and interrupts are disabled, ensuring atomicity and safety from other
+ * event handlers.
+ */
+int arch_reinstall_hw_breakpoint(struct perf_event *bp)
+{
+	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
+	unsigned long *dr7;
+	int i;
+
+	lockdep_assert_irqs_disabled();
+
+	for (i = 0; i < HBP_NUM; i++) {
+		struct perf_event **slot = this_cpu_ptr(&bp_per_reg[i]);
+
+		if (*slot == bp)
+			break;
+	}
+
+	if (WARN_ONCE(i == HBP_NUM, "Can't find a matching breakpoint slot"))
+		return -EINVAL;
+
+	set_debugreg(info->address, i);
+	__this_cpu_write(cpu_debugreg[i], info->address);
+
+	dr7 = this_cpu_ptr(&cpu_dr7);
+	*dr7 |= encode_dr7(i, info->len, info->type);
+
+	/*
+	 * Ensure we first write cpu_dr7 before we set the DR7 register.
+	 * This ensures an NMI never see cpu_dr7 0 when DR7 is not.
+	 */
+	barrier();
+
+	set_debugreg(*dr7, 7);
+	if (info->mask)
+		amd_set_dr_addr_mask(info->mask, i);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(arch_reinstall_hw_breakpoint);
+
 /*
  * Uninstall the breakpoint contained in the given counter.
  *
-- 
2.43.0

