Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292F03B635A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Jul 2026 09:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784798978; cv=none; b=FZTftSgSAZezXYlelGe2yE5iuw9lfEbrcAzz0QFais22bxDbq2b0l8BeQPjxaXs5NYEDWcb8GINuWddM2t/wYZ+J18yAbXHE14TlQtIKmRE2oPWZKyTjzB6yl2svhRrcssKsASc2D9ZhdGplc16EWDQFkI9c42Zd4MnyZRS0uVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784798978; c=relaxed/simple;
	bh=hwRsQmLo79vuJApHiHeVt2kWKqWlWo8jxeos0iQUQQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bzySAv7u/opK1lzJx1D6okgveNgEV9AM8SDlmgweyRYHu9IwZ8HiSz7xIZ9KqRTQF1AUDY6dTcU4V1k13zAGW75vWdJfsbfODojMJjJFiU4maK/Px7zHcaEN66vjIVfrEG+6JuS8+GvbtsY62nN6aiBFIHufZhaH6Pn2FIovOAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFU3urj8; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFU3urj8"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ceed7018c8so3267825ad.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Jul 2026 02:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784798969; x=1785403769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dyZbGE6s/GhiUQY1p3Ic3dHaqeDboCKAETdtIwyjiwg=;
        b=FFU3urj86FhVLxbSG01EFdCtiyKoM3SGaHOq2oqaB4cIkkkbsir3uBvssziEn7aLjL
         64pqOnHzvg8RIU8axi0lII8eEXz4LOvaEo6Z44UkyBwCRL6BAAEY3EW7Pn778B2CGtSb
         soED72P8uuDye4ujIO4AuShklD+ocFCBeW8PNGU2r4gTZUqLvPk0euOMQTJw1wweHKoz
         Nn30nid2p3dCgQoEO2NWKA/peuMdEY1MTG0QulX1C/IeMg2oa+LyrpUGH7tUHvQYAxyD
         f65e9pv39pf0P/WsWSOuWsYI8Tf2XxZ5tH/zG0u7ojA14eASmJcDg2vEh410s6whMUWQ
         wBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784798969; x=1785403769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dyZbGE6s/GhiUQY1p3Ic3dHaqeDboCKAETdtIwyjiwg=;
        b=ZTUiX9gHRbsCr7r3tE/ImNJHhAv9iQv5bNASnq5W6zuA9/UWeSSLMMn5k+aQuXBqVI
         nuFEma7a2P7b7mBdBlZoaeNcSdNsLxu3O6gpwVMyJBxdZ0V5zKhKkIaCkzBWr69cOZZM
         MKU6Z7oPhXzGk2NKus05L6yFza0FrnnEkmunAYZ2J7HTg5Xt0JX/8MXjiuNJMBfBN8sL
         Mo70nByDid477leH90Tjb/nGqL6zGrPBmM4BbqQdQIb8gaVjmYtgmRHVSiwc6KdkVlP2
         KDQKfBqYNkkUBDOPceDyPqoLKILZWBN4YX4JMy52vy0WBAOD4+grqNAiAXHjUhRSl7jY
         6Fgg==
X-Forwarded-Encrypted: i=1; AHgh+RqUZcMLtctquDBDKwn/mLR3gPoFltUCFXjXRulTb9tczjHUaqK16xYRVDAXset9Gaqv+doEIPFZK6PwsCeWEt7pJ6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ++bntgMGG5tP+jgjBfN7YmpqXIFLDfoZ6RS5xVMVh6FCm9q+
	SGPa9IJBPlwYXK4tmAx+5DKIL3S4297fqXEkvjUmaivxAOMEEZpebRRS
X-Gm-Gg: AR+sD12mUsLPlZhlAy4UwtWtcnQOwmBjK1J2REju9E36SZ5MgUMBuY9ahxVXHuT/cqv
	LkdT1Rbct10kR0y3c+ujRfblg2HF4O6/6zRUlpfUmEj787qpST+yUyA+WUg0/z7bL6HpFgmtsOa
	LHNGmS8q+CG6Fb5K64e859N4K3zc81KtNJFv/3xfAEZYv3zOVs/10lkXFgKMBJC9DEfcOmhhzwN
	jhzFUKgnnx73YVHnLEiI5ZmfGlFk+q0yjwvLu3qk0zXWG5I2i0yo6wTFTd5weuvPCIGvqjisvNz
	qnREcjxcbwIPyDjO7CxNusrGcDcnKRod2Tv0M343QaQqYtrerdVbpWjMV7t961Zq29H5/a/ug1n
	ptid+bIcUgrdZFK+dVtjvJwZOOt2N9kvv3La8OVG4wz2SDlxVakD3URPbyiH97twfnSHLWYUMsg
	PJQZuaCjwDsy4vQKl9sw==
X-Received: by 2002:a17:903:181:b0:2c9:97a7:f544 with SMTP id d9443c01a7336-2cfa6f81c55mr27454325ad.42.1784798968576;
        Thu, 23 Jul 2026 02:29:28 -0700 (PDT)
Received: from PC-2B0BA31200898.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efa388fsm30298125ad.12.2026.07.23.02.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 02:29:27 -0700 (PDT)
From: Meijing Zhao <zhaomeijing100@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Meijing Zhao <zhaomeijing@lixiang.com>
Subject: [PATCH RESEND 3/3] mm: trace: name protection key encoding bits
Date: Thu, 23 Jul 2026 17:29:05 +0800
Message-Id: <20260723092905.761037-4-zhaomeijing100@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260723092905.761037-1-zhaomeijing100@gmail.com>
References: <20260723092905.761037-1-zhaomeijing100@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Meijing Zhao <zhaomeijing@lixiang.com>

Protection keys are encoded in architecture-specific HIGH_ARCH_* VMA
flag bits.  show_vma_flags(), which is used by VMA tracepoints and %pGv,
does not name those bits, leaving them as raw hexadecimal values.

Name the protection-key encoding bits pkey_bit0 through pkey_bit4 under
CONFIG_ARCH_HAS_PKEYS.  The names make clear that these are bits of one
protection-key value rather than independent protection keys.  For
example, protection key 3 is represented as:

  pkey_bit0|pkey_bit1

Honor CONFIG_ARCH_PKEY_BITS when exposing bit 3 and bit 4 so only bits
provided by the architecture are included.

Signed-off-by: Meijing Zhao <zhaomeijing@lixiang.com>
---
 include/trace/events/mmflags.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index 2d76daacb70c..c8b8a980f8c7 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -204,6 +204,24 @@ IF_HAVE_PG_ARCH_3(arch_3)
 # define IF_HAVE_VM_DROPPABLE(flag, name)
 #endif
 
+#ifdef CONFIG_ARCH_HAS_PKEYS
+# define IF_HAVE_VM_PKEY(flag, name) {flag, name},
+#if CONFIG_ARCH_PKEY_BITS > 3
+# define IF_HAVE_VM_PKEY3(flag, name) {flag, name},
+#else
+# define IF_HAVE_VM_PKEY3(flag, name)
+#endif
+#if CONFIG_ARCH_PKEY_BITS > 4
+# define IF_HAVE_VM_PKEY4(flag, name) {flag, name},
+#else
+# define IF_HAVE_VM_PKEY4(flag, name)
+#endif
+#else
+# define IF_HAVE_VM_PKEY(flag, name)
+# define IF_HAVE_VM_PKEY3(flag, name)
+# define IF_HAVE_VM_PKEY4(flag, name)
+#endif
+
 #ifdef CONFIG_ARM64_MTE
 # define IF_HAVE_VM_MTE(flag, name) {flag, name},
 #else
@@ -251,6 +269,11 @@ IF_HAVE_VM_SOFTDIRTY(VM_SOFTDIRTY,	"softdirty"	)		\
 	{VM_HUGEPAGE,			"hugepage"	},		\
 	{VM_NOHUGEPAGE,			"nohugepage"	},		\
 IF_HAVE_VM_DROPPABLE(VM_DROPPABLE,	"droppable"	)		\
+IF_HAVE_VM_PKEY(VM_PKEY_BIT0,		"pkey_bit0")		\
+IF_HAVE_VM_PKEY(VM_PKEY_BIT1,		"pkey_bit1")		\
+IF_HAVE_VM_PKEY(VM_PKEY_BIT2,		"pkey_bit2")		\
+IF_HAVE_VM_PKEY3(VM_PKEY_BIT3,		"pkey_bit3")		\
+IF_HAVE_VM_PKEY4(VM_PKEY_BIT4,		"pkey_bit4")		\
 IF_HAVE_VM_MTE(VM_MTE,			"mte")			\
 IF_HAVE_VM_MTE(VM_MTE_ALLOWED,		"mte_allowed")		\
 IF_HAVE_VM_SHADOW_STACK(VM_SHADOW_STACK, "shadow_stack")	\
-- 
2.25.1
