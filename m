Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB68741E6D8
	for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Jul 2026 09:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784798972; cv=none; b=m4sFdMGLOvA5IC2M8RAsJiGsMkG2oHPEUBO12Lm8Bazv4hnuCkq3w5pkZH26n6HMOhNJWMgQlkut36iMH6tPdzR4yaJmi3WqSHitqvCs18hcwldr2fSly1SDUVRmQn2cSl6LlaqWvfHVv5GydLmVI9yzmabzXY4kdXg3GzApMFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784798972; c=relaxed/simple;
	bh=9ASsrQ1cF0efVFUhQt8gAyuPyoNF5aaURJcBjot6c0c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rtzbqo4OGa6cEls5UhjNl4JKmRl5dQFtjWW0bDryfHBC6JBuuW91scoFm/xRcqSzIy2DK5gDZtC/tpsmC7ptIMMGiFnQiKHpMsc0wUKEFh1xZy5uvg31/7qljrpEyLT973dBTs8JHqmw2fI7mzc/jjLLjyUUnJsIJ2IXcXCeieU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hf6bGz/P; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hf6bGz/P"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cee9b74ee1so3268925ad.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Jul 2026 02:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784798964; x=1785403764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dPfVR8qOQpuRYvB5SnMtHyLaliAGnyBwBDTXNiCFaX4=;
        b=hf6bGz/PZAryjFLZmmWQe4CDHCagYD/pUHXWBrJcmPZqhigAnWNNqt1Fujwz0hMPJY
         XwBShXbT7prLvlGx0Bk3Gwx/VUOQwGlVyWnLL7kq6XaM0pgrIDzZ7ANbxEeKAiHLIRfj
         hq+bR3tMn7M1/kVzcPyR7Mb51UAlmmeZUpSOE6mC/53abadlnEbRlv3YZsJLzzlF0HL6
         FIUuEptI6ODWQG0dq7/TMZ8gJ6VMPu/xR4vsdzXa+HtICFIp/JiRBmWPIALQFnmssLgV
         7HHpto7XEUfaEyIZeXV5ME0EVjvito8hCumcheX34LEiCtBmMcZVkSxOnfksVU7Dh7x1
         dnwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784798964; x=1785403764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dPfVR8qOQpuRYvB5SnMtHyLaliAGnyBwBDTXNiCFaX4=;
        b=pqGyrxSfy/zBhUWHrf/ZdGHVhoQFdOHYNUJLdf16ck9hjk9UQ9J8y5xIlGS7Y2G+GS
         Wwu1aWXuT0iKdKyrp6tO4MDR04VnSkTpVGBfvubdoCESjZnQ49y79mm40gocoasglJNZ
         4hwH4ucnGT0QkM6WUEJfH53sjn5KGzkA4ODMgHpO2RxuLh+cbGM8UuN3CmrJPW78COW3
         qX3JcOwj4MQxpsMm7CjoORJBSZRGHimRhAMZ6UVKB16zygSe+/kDHGyvcOFyNimXJ+v9
         J+NTcpa+veG8bDAnRAx9Nabwo9tEUTsd1SDvVSV+H/rkwab2deh25u1XndRIkZkLHm0l
         pD8w==
X-Forwarded-Encrypted: i=1; AHgh+RoiLoRWEybxzEdTe3zq+38K4sK4BfjYfsgJJxLc3i3j4Wb26KVCqE6sWE+btaCCzNpZoab1mXXcFByYUMkWCNqIp8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBc93/wKL2FBQD1K9vEGvU/1ROwWndBb36F9JucByYuJ6xKLO9
	Apzhsjk3MSN6fkVoRgamMiNsf6UTPHyZMPMdy9kfNab2ArwfOjaTeR9Y
X-Gm-Gg: AR+sD10i24XKcHwbE2mrrnJfYyKSFNtm4WePy7TEfV46qdrhISSeNdi57MBCziOxRrH
	inuoIATzBIY6R3fvmk00b/SV6JV2nKrUlnW8WDyUHZAfgTTBtU/4qFanAXBLDHkLIqU80S6TQFd
	nmXiGKNHYAUyFX+x8e/8gnLykzo0uAI20VX0uhaDjTNOIDmCPbN/F1Nz8UCJnBgv94hWtYB8gDK
	4aK4Hm79R7fjsVzy3eosEZjyB3iGW3yspSKWT4x8S7PcVLUrPG2I6z8YgJE5Oek+z6IuB9NhQ6o
	wbzh0YRWiZhuc5hAf5VPkSdwk+U1/qv0lICIR13DCEU17jmWMnn9bkFDI6DDlv/glCQxWaSQAbu
	sz506PpwjvLzn5O+vOlsbLEBE2Epo5VjXaqgtSNGQal4FFIqagb5wY674eGA5Q3hcs6TbFXJ7yg
	JcHrs86wYuZYeAq9uTsQ==
X-Received: by 2002:a17:903:3d10:b0:2c7:f338:5691 with SMTP id d9443c01a7336-2cfa74b2ffdmr28199215ad.36.1784798964222;
        Thu, 23 Jul 2026 02:29:24 -0700 (PDT)
Received: from PC-2B0BA31200898.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efa388fsm30298125ad.12.2026.07.23.02.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 02:29:23 -0700 (PDT)
From: Meijing Zhao <zhaomeijing100@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Meijing Zhao <zhaomeijing@lixiang.com>
Subject: [PATCH RESEND 2/3] mm: trace: decode MTE and shadow stack VMA flags
Date: Thu, 23 Jul 2026 17:29:04 +0800
Message-Id: <20260723092905.761037-3-zhaomeijing100@gmail.com>
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

show_vma_flags(), which is used by VMA tracepoints and %pGv, leaves
architecture-specific HIGH_ARCH_* bits unnamed.  Arm64 MTE flags and
user shadow stack flags are therefore printed as raw hexadecimal values.

These bit positions are shared between architectures.  For example, bit
37 represents VM_MTE_ALLOWED on arm64 but VM_SHADOW_STACK on x86, so a
shared HIGH_ARCH_* bit cannot be given an unconditional name.

Add conditionally compiled names for VM_MTE, VM_MTE_ALLOWED and
VM_SHADOW_STACK.  Keep the configuration guards aligned with the
definitions of these aliases so each shared bit position is decoded
according to the target architecture.

For example, an arm64 VMA containing VM_MTE_ALLOWED is now printed as:

  ...|account|mte_allowed|...

instead of:

  ...|account|0x2000000000

Signed-off-by: Meijing Zhao <zhaomeijing@lixiang.com>
---
 include/trace/events/mmflags.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index add5ad6843e8..2d76daacb70c 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -204,6 +204,19 @@ IF_HAVE_PG_ARCH_3(arch_3)
 # define IF_HAVE_VM_DROPPABLE(flag, name)
 #endif
 
+#ifdef CONFIG_ARM64_MTE
+# define IF_HAVE_VM_MTE(flag, name) {flag, name},
+#else
+# define IF_HAVE_VM_MTE(flag, name)
+#endif
+
+#if defined(CONFIG_X86_USER_SHADOW_STACK) || defined(CONFIG_RISCV_USER_CFI) || \
+	defined(CONFIG_ARM64_GCS)
+# define IF_HAVE_VM_SHADOW_STACK(flag, name) {flag, name},
+#else
+# define IF_HAVE_VM_SHADOW_STACK(flag, name)
+#endif
+
 #define __def_vmaflag_names						\
 	{VM_READ,			"read"		},		\
 	{VM_WRITE,			"write"		},		\
@@ -238,6 +251,9 @@ IF_HAVE_VM_SOFTDIRTY(VM_SOFTDIRTY,	"softdirty"	)		\
 	{VM_HUGEPAGE,			"hugepage"	},		\
 	{VM_NOHUGEPAGE,			"nohugepage"	},		\
 IF_HAVE_VM_DROPPABLE(VM_DROPPABLE,	"droppable"	)		\
+IF_HAVE_VM_MTE(VM_MTE,			"mte")			\
+IF_HAVE_VM_MTE(VM_MTE_ALLOWED,		"mte_allowed")		\
+IF_HAVE_VM_SHADOW_STACK(VM_SHADOW_STACK, "shadow_stack")	\
 	{VM_MERGEABLE,			"mergeable"	}		\
 
 #define show_vma_flags(flags)						\
-- 
2.25.1
