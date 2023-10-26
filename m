Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4AF623
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Oct 2023 07:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="MTVi1uRq"
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648D8D6
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Oct 2023 00:38:45 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6b36e1fcea0so523662b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Oct 2023 00:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698305925; x=1698910725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZG3qoWCwoxT+TLCEuUt16k9wNNeW+1r80cBnWyU8Z+U=;
        b=MTVi1uRqgTV8TDuladvd+64U6hbGlqor/TPLaglRVo7lkqk8IOK4QlLoKYfmsf085n
         g9UQyYgmAkX0AyphPaxahd7/bUuyixft4ixjj+vI0WqSqjE6Khg29TYFjXdltLPVf8uV
         WSO101nRINT6H4xqIiNSDhvUenKr/6NEzaLq7GYVaOKxbuAhVDPswUtKz99m+woXwn5R
         bDuJlZ1KpbzqOol9ah7unWTwwxjr9DUZPfc9z+xDE9VpdtQLDwm0tCGZoAFie3Asj/q/
         sXSzOWLUSzVAJhbSMtqJNv2PcnpcZvzwtJOdp+KJaZFOCJ99of6QqeilS8GtqupVxHFI
         JTvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698305925; x=1698910725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZG3qoWCwoxT+TLCEuUt16k9wNNeW+1r80cBnWyU8Z+U=;
        b=CxlKi1vbNtiImlcmjuytjTHJZ5XMGULGWEndaQgQx4JwbuWYP3zeQ33tovpbiGX1+R
         YAE83hSuIEaIVXfn5mPXBzmh7rKPF1PFu5aKWnD5q5Vw+cIdf71EBMmANFZsJCzGxz+r
         QH3SPzhb+PzZhOAGCo1nD6YkQvl3pO8kHtcYbFnZNFHNGjegjlI8/FVdRvkCPuMHzRXc
         IuOd6u3UjLjD8HzN20EOnEFmk3O5CONlTXFRh/IFY83qJ044uzKrQRYUTNJGJSjjSYEE
         pfXY2frvIEFm6xPWYcyxMh7hD+w4rne3/HJ7o0w/oAWANC19QR6/qs3TZzF6gmilPsZX
         mfhA==
X-Gm-Message-State: AOJu0YwceXqZDR19x08a3PdUuih56/Gh/hDnoA34bZphSHIJY4bcwWFF
	U/ypzioKKbYb0jVS5T23taCBMQ==
X-Google-Smtp-Source: AGHT+IHq6kCr2WgiybVkVsJdkg6kX0FUjTQTwtH6Fh9MoRIQ0MX9TAkqJRXMowX33tJNLT1ray7uJw==
X-Received: by 2002:a05:6a21:6da2:b0:16c:b5ce:50f with SMTP id wl34-20020a056a216da200b0016cb5ce050fmr7544436pzb.32.1698305924849;
        Thu, 26 Oct 2023 00:38:44 -0700 (PDT)
Received: from devz1.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id s66-20020a625e45000000b0068bc6a75848sm11020071pfb.156.2023.10.26.00.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 00:38:44 -0700 (PDT)
From: "wuqiang.matt" <wuqiang.matt@bytedance.com>
To: Vineet Gupta <vgupta@kernel.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Ingo Molnar <mingo@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>
Cc: linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	mattwu@163.com,
	"wuqiang.matt" <wuqiang.matt@bytedance.com>
Subject: [PATCH 1/3] locking/atomic: arc: use generic_cmpxchg[64]_local for arch_cmpxchg[64]_local
Date: Thu, 26 Oct 2023 15:38:27 +0800
Message-Id: <20231026073828.702105-1-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arch_cmpxchg[64]_local() are not defined for arc architecture. This patch
implement them with generci_cmpxchg[64]_local, advised by Masami Hiramatsu.

Closes: https://lore.kernel.org/linux-trace-kernel/169824660459.24340.14614817132696360531.stgit@devnote2
Closes: https://lore.kernel.org/oe-kbuild-all/202310241310.Ir5uukOG-lkp@intel.com/

Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
---
 arch/arc/include/asm/cmpxchg.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arc/include/asm/cmpxchg.h b/arch/arc/include/asm/cmpxchg.h
index e138fde067de..ef644cdbe956 100644
--- a/arch/arc/include/asm/cmpxchg.h
+++ b/arch/arc/include/asm/cmpxchg.h
@@ -140,4 +140,18 @@
 
 #endif
 
+/*
+ * always make arch_cmpxchg[64]_local available. __generic_cmpxchg[64]_local
+ * are atomic with respect to current cpu.
+ */
+#include <asm-generic/cmpxchg-local.h>
+
+#define arch_cmpxchg_local(ptr, o, n) ({				\
+	(__typeof__(*ptr))__generic_cmpxchg_local((ptr),		\
+						(unsigned long)(o),	\
+						(unsigned long)(n),	\
+						sizeof(*(ptr)));	\
+})
+#define arch_cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
+
 #endif
-- 
2.40.1

