Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060FB623
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Oct 2023 07:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Fquq9CpL"
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B102184
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Oct 2023 00:39:51 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-27e1eea2f0dso435632a91.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Oct 2023 00:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698305991; x=1698910791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T+9VBh6cqcNium9L3qNrheT8GGQUxnbiy5WokL/gQlQ=;
        b=Fquq9CpLRufAkQ1uF4GPQAmwtRQXaCgyyPQfJzvilPMbcqJqrT52+wVn7oIf3VGiUu
         fLNsTCH85EUXUWNOHjSmg9LXsZTjQQkPWsXp4MfBLdwsdY8MQ9xkreHDO3gv0w18V458
         hwFKgKgKoFkL6omujMXRszUQu/9DCmOxL+R9p7Eye0QyMljagmkK+1jK/ienUXBcXjIy
         PlkgewxRWgXio9ZmMatTRh0xULxUdin8Dp3eTCCdVTxotUWIOnlXxklL/7yoJZtwBPl7
         ODuIKPW4DbmWYxmCm/ctetaJxKz9nZAqhESMAQp+9ztyncKDIL+k8Z40pde+YvgEFVPv
         SU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698305991; x=1698910791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T+9VBh6cqcNium9L3qNrheT8GGQUxnbiy5WokL/gQlQ=;
        b=E/Ki28LWympr//In2Dl2FISrr32iH2yEhNCAEQiCulm46b4TtJX6FrQr9V/rMrDqwK
         ASELkt0WmX+P5+gemh2ePAJxTiHQqHfwbOrnxIufjQ2SNu0H8DtlQ+ofxKSfKdM7y68W
         2AMnkMF69pMpqQNE7QxK+e0KyPh0oP14LGPip05tQhslQmSg/19WKnGP018y4/GtvDSz
         Xm5/AJ6hv9BmPC02HGJ66RXIp/3u57hqHISBNlZP7jld0ar+emfkMTSAaevRw3o/RWCq
         +FVltzTpdXF/avT2JVg0NCs6CVWYPzQEg2zvC+mGj42oIuYhNSsfGMZg349ZyTNGzxeK
         Zxew==
X-Gm-Message-State: AOJu0YxkCoYVtg0ObY62BtcHZ402BVQYiNedCBXH58vOyBIDoTZh8hWj
	7DpfC4EQ60KAxG68pGm/vu06GA==
X-Google-Smtp-Source: AGHT+IEyiwatpHzojQxJQqleOUfB8ZbwEsU5DLNfoM7+aZ9LaIWvETQTLE36A2blfpoBLiD0LSTAKg==
X-Received: by 2002:a17:90a:d505:b0:27c:efe3:89dc with SMTP id t5-20020a17090ad50500b0027cefe389dcmr14429648pju.14.1698305991038;
        Thu, 26 Oct 2023 00:39:51 -0700 (PDT)
Received: from devz1.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id gd22-20020a17090b0fd600b0027dafa55306sm1046795pjb.40.2023.10.26.00.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 00:39:50 -0700 (PDT)
From: "wuqiang.matt" <wuqiang.matt@bytedance.com>
To: Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrzej Hajda <andrzej.hajda@intel.com>
Cc: linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	mattwu@163.com,
	"wuqiang.matt" <wuqiang.matt@bytedance.com>
Subject: [PATCH 3/3] locking/atomic: openrisc: use generic_cmpxchg[64]_local for arch_cmpxchg[64]_local
Date: Thu, 26 Oct 2023 15:39:31 +0800
Message-Id: <20231026073932.702197-1-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arch_cmpxchg[64]_local() are not defined for openrisc. So implement
them with generci_cmpxchg[64]_local, advised by Masami Hiramatsu.

Closes: https://lore.kernel.org/linux-trace-kernel/169824660459.24340.14614817132696360531.stgit@devnote2
Closes: https://lore.kernel.org/oe-kbuild-all/202310241310.Ir5uukOG-lkp@intel.com

Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
---
 arch/openrisc/include/asm/cmpxchg.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/openrisc/include/asm/cmpxchg.h b/arch/openrisc/include/asm/cmpxchg.h
index 8ee151c072e4..7d0555257389 100644
--- a/arch/openrisc/include/asm/cmpxchg.h
+++ b/arch/openrisc/include/asm/cmpxchg.h
@@ -168,4 +168,18 @@ __arch_xchg(volatile void *ptr, unsigned long with, int size)
 						 sizeof(*(ptr)));	\
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
 #endif /* __ASM_OPENRISC_CMPXCHG_H */
-- 
2.40.1

