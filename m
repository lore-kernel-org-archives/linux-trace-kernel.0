Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DAB623
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Oct 2023 07:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="O6o1iYaE"
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A1C184
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Oct 2023 00:39:20 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6ba172c5f3dso549889b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Oct 2023 00:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698305960; x=1698910760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5k67Hyx/3tO2irTOWAzuyS8QjyluKIuu0eflWrJg2/E=;
        b=O6o1iYaEeQK2As7r7AUA74Ohv3FqDslN3Hgn2+iMYoJt+PvwUoae5d8THhCRszetzV
         4IACqsIlpqozrdVy1G026Z0MPogaOUOJzz+zHbzsvxqU99/uDytyLcH2C0OsFBzqdiTF
         zJZq9D5rKkkEWvKL7Lw35IuzjMSCY7MRS2CLD6iSkLtWB4qHLzkuCQYF+XVuWZ3a7n/9
         tZUBI4ObGz1XWq5J3elYlfOAK1qLI7qLss+qDnd/SXKeV/lynADMViqYyL+I6m/tba0i
         jxFxy51RXAmolvJFPfOHGWSTrTdXiu13SDHYmMFDi8CS9EtFqEkssQzISDo8lrxNTOS5
         ohVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698305960; x=1698910760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5k67Hyx/3tO2irTOWAzuyS8QjyluKIuu0eflWrJg2/E=;
        b=InsjKAYx1XXaI0jR+kd20x4TV1T8utzVuYCjpBGCzxFLxsQicFt+QyYmAIgsdHDqyq
         x+uJd4kkntvtp+fIAj7gfmcRnQQzkNMM1RbESiTp0Sv+GmCF7tKzkKBLfuDyq1KZhI8o
         6omN3zt5SSeWPTbbZAr/uVPX3Tpkc4J0oxSkzqt4AZ3CksGxo0sPQcxuI8piPZps2CME
         P31pRVGdmvGWcyNenPSbGe9BTSs88uQHB0HGd5BgGbeOxpPzU1cIkGH7lythPigt0Nq6
         DhUetLMye7GhpO1iQVBzG57fuSrGjxugPbqG9IaQGHS14t/DrHjbAngFMLBVwiTKC4Om
         jWlw==
X-Gm-Message-State: AOJu0YwDdEzHoI33km6BSf1lSoTeuj9EC6fb9w7qAKNRvBqFf96CxJkQ
	WQgbeSxJNzCUj/bbZ1s/FSPZWg==
X-Google-Smtp-Source: AGHT+IGILFhcFkGFRHLmdKRDpNuEc4Fn/eaOxfCN4+XWBjWpQ8AbXagO1jKjSOBaYcn37leswMRgNg==
X-Received: by 2002:a05:6a21:7906:b0:152:be08:b013 with SMTP id bg6-20020a056a21790600b00152be08b013mr7124964pzc.42.1698305960266;
        Thu, 26 Oct 2023 00:39:20 -0700 (PDT)
Received: from devz1.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id z10-20020aa7990a000000b0068bbe3073b6sm9568848pff.181.2023.10.26.00.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 00:39:19 -0700 (PDT)
From: "wuqiang.matt" <wuqiang.matt@bytedance.com>
To: Brian Cain <bcain@quicinc.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Ingo Molnar <mingo@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	mattwu@163.com,
	"wuqiang.matt" <wuqiang.matt@bytedance.com>
Subject: [PATCH 2/3] locking/atomic: hexagon: use generic_cmpxchg[64]_local for arch_cmpxchg[64]_local
Date: Thu, 26 Oct 2023 15:39:01 +0800
Message-Id: <20231026073902.702153-1-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arch_cmpxchg[64]_local() are not defined for hexagon. So implement
them with generci_cmpxchg[64]_local, as advised by Masami Hiramatsu.

Closes: https://lore.kernel.org/linux-trace-kernel/169824660459.24340.14614817132696360531.stgit@devnote2
Closes: https://lore.kernel.org/oe-kbuild-all/202310241310.Ir5uukOG-lkp@intel.com

Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
---
 arch/hexagon/include/asm/cmpxchg.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/hexagon/include/asm/cmpxchg.h b/arch/hexagon/include/asm/cmpxchg.h
index bf6cf5579cf4..c14520730194 100644
--- a/arch/hexagon/include/asm/cmpxchg.h
+++ b/arch/hexagon/include/asm/cmpxchg.h
@@ -72,4 +72,18 @@ __arch_xchg(unsigned long x, volatile void *ptr, int size)
 	__oldval;						\
 })
 
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
 #endif /* _ASM_CMPXCHG_H */
-- 
2.40.1

