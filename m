Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909D84369C
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Oct 2023 13:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Ji2OX7Xm"
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F04F101
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:57:09 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1ca74e77aecso17075765ad.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697551029; x=1698155829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o2olN8CS4kwWpq+8wsnt0IT2xZ6oZLNjhXVzv2yHZDk=;
        b=Ji2OX7XmG8xiCocwGho/BF41XdMXDsGn/ZaoQK/VaAQyZkv6iGVHAURksq/YnsPJvK
         C5xgBof2NqPgDT5G5NJqUlM9iAeZ0aaKxdY6iosKpo8IBM5NiZGzDCdRMBFFPC8Nr4HQ
         6Yw9FbjG5GOF6WVrjcS/NvwQb7lMkRX0duQJDVrUulI2b8SZSjkzRHkdAGHgCx6co65e
         Xmts18aa+UDvDJYDlnewPEQ7Tl4sW+efz4USjRQ710i5VJDytJoHMUIrn+UcURq/oj0N
         6qpmJnq28klDR1XKU7PGS4I9jmDtS4DmVOJ7I5ZFO/KC1rl9gfF3ngw3boBAT2KqVIiP
         GBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697551029; x=1698155829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o2olN8CS4kwWpq+8wsnt0IT2xZ6oZLNjhXVzv2yHZDk=;
        b=q4k40DwaK8/hx1D5Jykrx1IZsfdVBDyKgRlrSi0DEJruRRSvyiM5wcxJbDhlsKaDBb
         HV84OOwEfZaqfVepPNlUDJUbYX3DHS+nt4xSklsmYlXNjUyEz2EXYetXMvoP2/k0Ocvp
         JY3eqK7zYoFwn+mC73m8t07lZS1yYSJtnYVpDQfFTKcdFGUJKAsFduxBs5BjPb9v0hYC
         aq0sQwYfsqga9LTpN7NjZXbjbCCPW1WK/ag3KO+7BPDV/jS5Qumez/VEFMEXXYdg9Fh3
         JbpsphHXA7oyeAsXnPNx2ZOLHc4MZL5h0KQgKeB6Sg8rm0e9jFhu1M1jQSdMVVMKagLe
         61fw==
X-Gm-Message-State: AOJu0YweCiLHyKhjGUeJByPns1WW2BXmX1iu0LJJm/P5fiQsk3XilW4n
	PhvODqVmNfcpZ6YUmeys2HSilxuSd7igdj6I7oQ=
X-Google-Smtp-Source: AGHT+IFLNM8lNcY/hN6qn67VtfPlhy8ur20l2NBCOA7If8R9IMQ/DWquPjSMVU92SFEDGGlhnmUFRA==
X-Received: by 2002:a17:902:e887:b0:1c9:ece9:53c6 with SMTP id w7-20020a170902e88700b001c9ece953c6mr2990072plg.29.1697551028775;
        Tue, 17 Oct 2023 06:57:08 -0700 (PDT)
Received: from devz1.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id b9-20020a170903228900b001b9e9edbf43sm1566634plh.171.2023.10.17.06.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 06:57:08 -0700 (PDT)
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
Subject: [PATCH v11 0/5] lib,kprobes: kretprobe scalability improvement
Date: Tue, 17 Oct 2023 21:56:49 +0800
Message-Id: <20231017135654.82270-1-wuqiang.matt@bytedance.com>
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
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch series introduces a scalable and lockless ring-array based
object pool to improve scalability of kretprobed routines.

v11:
  *) patchset rebased to branch probes/core of linux-trace.git
  *) objpool: objpool_fini optimized for better code readability
  *) test_objpool: asynchronous releasing of objpool now covered

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

