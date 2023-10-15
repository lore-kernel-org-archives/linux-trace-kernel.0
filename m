Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205D31878
	for <linux-trace-kernel@vger.kernel.org>; Sun, 15 Oct 2023 05:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="AFp308hA"
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E00D8
	for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Oct 2023 22:33:08 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-57f02eeabcaso2152022eaf.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Oct 2023 22:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697347987; x=1697952787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3YSbbFplEMGgc8hs9UQZk79UvkhK9cFlSyrmMp8kdAQ=;
        b=AFp308hAuHvw86EaRRO18dsF9leLOyhfadkGtooVYloikOH1Mn2pGwgoIPDSN/WMTy
         od5znADUy/8VOJZqKcrELKOf+txxqgz2TVRDoAsiAXzIjx2OPYbDzphukCfBfoQrRNhV
         +J9ngTNj1C00i3GLNo/j9GVTm7YqwSk/wCNAVLxR89L7AbNtSwccrRjwQPiK9FjZt7mZ
         G+mpZyvGCN+9/485i0pU4e2lIFK6TS2WK/inyUqoVXcPBQEj/wLZa0+wk+CmN69EOrXN
         kuDKm21+sN07O9HBX59p1MlUzf/ysqFb1+r9qV07jvjyZdSDu2ysO+iIph21ypqln+pA
         WHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697347987; x=1697952787;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3YSbbFplEMGgc8hs9UQZk79UvkhK9cFlSyrmMp8kdAQ=;
        b=qeN/52690AUOUfveQlJ+pHIBwJcSGQ3JdOcIm9QXElaU+0Z+uGfYPrmFC2rPspefxb
         0vspJaYlmolE6+LGrKqTkHcYGC3+BaOzzleItlyR/I8wlZDpSYYrHI5iaiQKhbnZoEgS
         ted/6nr/5q+U5ug+KnX0ahBs+KNI775CjMud9/FNN7VNxzDRnjh7YbDdcjkob6cX8g8J
         geMz5BPXzBIYzz+CUsompginINPkw9fMPiUDGylgYqEn3ofmFbgVzuH2NKun48Aruojp
         bABaRPVF6xFWVa/2Dcmt5aL/kVlt8TsBya61JAd/Jhn2KaaeIx4lvZurT55W2e+lPptg
         zxQA==
X-Gm-Message-State: AOJu0YwttJPF9vPZ3YIEaXPsC8OYwQtxKnRbG9wLa2xaifv0q7NXhL5o
	i4bisG6kpuwcVXuRvbnJ3XWTXtI3u6h/so968wNZZw==
X-Google-Smtp-Source: AGHT+IEcgAokBU5YdThWVcsJQqO8kLV4eAzKTCIPBY/Tl6zvGnQacF65q5XNT2Za/cL93juYS2sNaw==
X-Received: by 2002:a05:6358:33a4:b0:151:ac8d:bfe7 with SMTP id i36-20020a05635833a400b00151ac8dbfe7mr35376152rwd.22.1697347987054;
        Sat, 14 Oct 2023 22:33:07 -0700 (PDT)
Received: from devz1.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id u22-20020a62ed16000000b00690fe1c928csm16187368pfh.147.2023.10.14.22.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 22:33:06 -0700 (PDT)
From: "wuqiang.matt" <wuqiang.matt@bytedance.com>
To: linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	davem@davemloft.net,
	anil.s.keshavamurthy@intel.com,
	naveen.n.rao@linux.ibm.com,
	rostedt@goodmis.org,
	peterz@infradead.org,
	akpm@linux-foundation.org,
	sander@svanheule.net,
	ebiggers@google.com,
	dan.j.williams@intel.com,
	jpoimboe@kernel.org
Cc: linux-kernel@vger.kernel.org,
	lkp@intel.com,
	mattwu@163.com,
	"wuqiang.matt" <wuqiang.matt@bytedance.com>
Subject: [PATCH v10 0/5] lib,kprobes: kretprobe scalability improvement
Date: Sun, 15 Oct 2023 13:32:46 +0800
Message-Id: <20231015053251.707442-1-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch series introduces a scalable and lockless ring-array based
object pool to improve scalability of kretprobed routines.

v10:
  *) objpool simplified and improved according to Masami's advices

wuqiang.matt (5):
  lib: objpool added: ring-array based lockless MPMC
  lib: objpool test module added
  kprobes: kretprobe scalability improvement with objpool
  kprobes: freelist.h removed
  MAINTAINERS: objpool added

 MAINTAINERS              |   7 +
 include/linux/freelist.h | 129 --------
 include/linux/kprobes.h  |  11 +-
 include/linux/objpool.h  | 176 ++++++++++
 include/linux/rethook.h  |  16 +-
 kernel/kprobes.c         |  93 +++---
 kernel/trace/fprobe.c    |  32 +-
 kernel/trace/rethook.c   |  90 +++--
 lib/Kconfig.debug        |  11 +
 lib/Makefile             |   4 +-
 lib/objpool.c            | 286 ++++++++++++++++
 lib/test_objpool.c       | 689 +++++++++++++++++++++++++++++++++++++++
 12 files changed, 1270 insertions(+), 274 deletions(-)
 delete mode 100644 include/linux/freelist.h
 create mode 100644 include/linux/objpool.h
 create mode 100644 lib/objpool.c
 create mode 100644 lib/test_objpool.c

-- 
2.40.1

