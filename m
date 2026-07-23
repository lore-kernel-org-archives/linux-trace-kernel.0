Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31D241DDE8
	for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Jul 2026 09:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784798966; cv=none; b=R+2Hg0WTJKr0IEBDLFZCnLy77UKf+vkCjCkM6aB+eWuYjLz9jHUkrk4N+ZAqODB+5qtCF3CSGtL7F0YmiGbI3u7/l6vaFLo7tfYvLvqUny6msp8TNxO73prqPZHeMOsBv4FTND4sxm5ZQcXe56vkDv9b4b5lhzmPd7fj3M0bRHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784798966; c=relaxed/simple;
	bh=4fEZwYjt3eqmvueftOSjx31IgktoqpPK8ZZdvqj3JGc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HbNoC/WsZVhd22gYLqU9ATQjNopHCcI5b19cHw8tqU/aJaGWAb7m9qUyCEXK5b/Bro7MxBxEx8lqXLJT3G4XLl6wEqgHqoeQk60ofrSb7AVmYE3ucnwhcJK21mc4k2XuK2rvM36Am4gvlXNN97JvZN7R86RGT0USgx5Q559CpRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tMBqC+Q5; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tMBqC+Q5"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cc97653887so5060455ad.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Jul 2026 02:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784798960; x=1785403760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XgS4LfBBZVF7e0vsLNofmuF1qmxptGwTKB4edvEsX44=;
        b=tMBqC+Q5uPCsUydn7rdLa+aoYH36CDPkta788pUHMLuQ2KJBiADS4swVwDkxYzxEvU
         da6xuyFUMJF9y5YNJDbXPXBeaE323acv5JwomAytmruz8+8MiabGK0ei1dUyvMT7RoGJ
         uEnZN0oFNALUSZrQ6AjMLbCE1UrhZiJ0JiuKSIEBr3UpfWqhRh0n8NWu6G5NCBh0NnfF
         aRnM5ZLdbm8BDwA5FuaJfCBTujCq6ovcF0ndnwpJqh32RVjE27lweP4ynuA0EkWuTYoz
         TIjsY0oh2u6/hnpzMHVjO8GfG1Lb7+ThRDaJzjdS5/ew1QspvLg5JisgcanUFglx3fRj
         uwiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784798960; x=1785403760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XgS4LfBBZVF7e0vsLNofmuF1qmxptGwTKB4edvEsX44=;
        b=iwkK6R0O35bVBqGn7rfFJJ1WGdGbM7BZmWUawXIKaXXmQc9f5B/p7ji1deum727rBn
         3sbYbKnSckz1+77o3B6UfU+aJ1grO0okp7uIOjE9eA0OlDaAVZcv5TPlxZvvpvr/msND
         pHgXef4vWVn5KY3V5EOA/SuP4rQ7NzlML+0xzVvoIcZvOX9T5mm+R7Cs+Z3HlXnW9sLG
         7vabiSKF63m5Ci+FBFte8Wh808hoS0tozxXBn+On7zIl9z0gqsIrHF0rQWV4qRIvHUqb
         5wT6XLwTH0jl/hjJ3DkjTP+L1IGGvOTmzXSuP7l2fcv47zBuXermTSfGauSpTrKf+wwZ
         y7fQ==
X-Forwarded-Encrypted: i=1; AHgh+RpnFwVAxo3j5sy0M7099GAJOioGPb9lx8VxcR8hJZX1YnwzacjBwDes+YGE8UfKRlf9nDZmKsT5B8n6bLQG+wCEZek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6blHHbLosPYH9dEtMAiw2CLTXCtVVRoUoYnE0VDIH8/YaeV3x
	OH4hfF4Yg9+40/sxmA+eDc0uZ0OpHqIIjfd4D0bP7mtab+ss+ONBmJcb
X-Gm-Gg: AR+sD12wF6WMGbXc0S7Qlr0JWNj1mAInb0JtPKioV+O46FLBkVR7/hXcL799rBVejX2
	lkH5xsvIZy2nQJgVV52m06uHzzbGEGwH77t//+Yss2PqLMVMyfp6LznnLPY84ZT2xQR2ybs0ViY
	at8TKgYAC1AI3eEE/wPKT2rBMKY1bqFDtk9RZpLiGSx3ubZdCbc/MwXf5Q8wFa584n+yFT1aW4G
	Fh/igN+u8IpjEyrecP/MRrB09fE8CD0m6uNmTBfFAcG0b96C5iof8YWNS1l01sNRrydTKCtaY4n
	tvM4G9OROzEacl2SJ6EKPmrQfTwhDfVBJQR4iD52eT1iv4vwTBDEtc0QeYpkad9bGxzodaiv/Sl
	Dl0zx/nV/lgvX/Njp2nipvGrF6/KaoXh9q9oC4QyZdI81dUXyl+cWDvrczX8epKYrleao0so7LQ
	nEEJonfvrG76kno8GboQ==
X-Received: by 2002:a17:902:d4d2:b0:2c9:97a8:afe7 with SMTP id d9443c01a7336-2cfa74db373mr26986545ad.42.1784798959619;
        Thu, 23 Jul 2026 02:29:19 -0700 (PDT)
Received: from PC-2B0BA31200898.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efa388fsm30298125ad.12.2026.07.23.02.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 02:29:18 -0700 (PDT)
From: Meijing Zhao <zhaomeijing100@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Meijing Zhao <zhaomeijing@lixiang.com>
Subject: [PATCH RESEND 1/3] mm: trace: decode arm64 and sparc64 VM_ARCH_1 flags
Date: Thu, 23 Jul 2026 17:29:03 +0800
Message-Id: <20260723092905.761037-2-zhaomeijing100@gmail.com>
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

The VM_ARCH_1 bit has architecture-specific meanings.  show_vma_flags(),
which is used by VMA tracepoints and %pGv, already reports the powerpc,
parisc and no-MMU meanings, but falls back to the generic "arch_1" name
on arm64 and sparc64.

Report VM_ARM64_BTI as "bti" and VM_SPARC_ADI as "adi" so trace output
and %pGv dumps expose the actual architecture-specific state.  These
names also match the mnemonics used by /proc/<pid>/smaps.

Signed-off-by: Meijing Zhao <zhaomeijing@lixiang.com>
---
 include/trace/events/mmflags.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index a6e5a44c9b42..add5ad6843e8 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -176,6 +176,10 @@ IF_HAVE_PG_ARCH_3(arch_3)
 #define __VM_ARCH_SPECIFIC_1 {VM_SAO,     "sao"           }
 #elif defined(CONFIG_PARISC)
 #define __VM_ARCH_SPECIFIC_1 {VM_GROWSUP,	"growsup"	}
+#elif defined(CONFIG_SPARC64)
+#define __VM_ARCH_SPECIFIC_1 {VM_SPARC_ADI, "adi"		}
+#elif defined(CONFIG_ARM64)
+#define __VM_ARCH_SPECIFIC_1 {VM_ARM64_BTI, "bti"		}
 #elif !defined(CONFIG_MMU)
 #define __VM_ARCH_SPECIFIC_1 {VM_MAPPED_COPY,"mappedcopy"	}
 #else
-- 
2.25.1
