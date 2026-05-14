Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2B83F4121
	for <linux-trace-kernel@vger.kernel.org>; Thu, 14 May 2026 03:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778730704; cv=none; b=NulJCnGU1PzGIK99BZ19ctrPlcDDRWA5vKzp9AkpBI4YKAqAARG0IDQAIAyeWR6rBL3aN/V4XYONqrn5hYSKkFLWuQ0ODc5WRclHmBGqqVVLIxiwR8i89fYkIdpiQcK8mv6NIacJCAphlYfvBZQmFvAEyXMmsqOCzr/OVYFQD7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778730704; c=relaxed/simple;
	bh=kO6F9KMlB3sbBDEPTXleXsF8wBQkim0N1ulxW3DbWgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cy+h4CPKGZD0At507s/Wg8Su+eHzUrKlnOoJFmSk21ToGbcKn4WdC+JD31ApdsPrQZyUHcT5/E3ss1Zohmo+8SNAI3V+7tNsGA+EVMNolVXLV45KHOHuvf8BBqlYBEVlZv90REHbr1xbWvQUEJT6UOhVG59xH3YSF5VeYZ8J7q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qspHjp/n; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qspHjp/n"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ba17c8cfacso76178155ad.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 13 May 2026 20:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778730702; x=1779335502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wG7tTs9fMY8PBaoLPotUG6XJlPO/khDCKvg1p3MbIiU=;
        b=qspHjp/nhiD72MLmOAOnBl0yU0ocQiYlT3PuZwG+jb3l/OPnimFNnoRrF3Y+kdjaZA
         aIbzVIsClh+15tqldJxsv/a9Jc4SNALqyQv6/qNJLPvbIB7G0tYXV31O8XyZCyuG2Sa0
         jhkBBtC1Q5CQvGO9fpR19VA0qifwUnbiHF3E0jyURqBq4JYuwv0A6ROZHPdsMwnpgZYL
         ypXw8I3ESnn61mm5Pl2Zm/flQTZOE2inQEhvSZUNBj1Ax0dYJ06LuLSbr43ZaSfiL1n6
         Ma6jdy1ksiH4MVs17MDweI1u3cyIqAIoPcngmAPF8Z7poXBGf0WoI4Zzhl51rcM69CkE
         oM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778730702; x=1779335502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wG7tTs9fMY8PBaoLPotUG6XJlPO/khDCKvg1p3MbIiU=;
        b=sIhJP3e5y5ZRWXgja6h5BrTBOctTQbMYZk6eM44HYU3dqlX42OF9qoC6E1OjAKBBnf
         j67CHrYqi8rtprp5X/FLozlw/XzibdIDDZ9xVf6/+naWIN/ABA3FJursN3wwZBuRhB/0
         m13t8vDfS60QT+fA8sa1hnVbLJ4+PPlRpYEMj4D+ZDJGtIg5eVs772F1U0JwuSuHJIjc
         dIq6obfv1KFbH7qDs8ldcBsJ2pmSrBGjs59F0/TiddIncB5ZvvffU+HxfMSRN7oNb0wu
         UbrQl02jkra5Dokl4wvf6TyXIY0y8LFHjy031mvyvms0AwQu2CwvdJXzpFL7YKZgSgMM
         ngJw==
X-Gm-Message-State: AOJu0Yxk+aihqkMQtUHXeOBxcw6Q+IWsqO8UOYYWBXS4LUEDNvTB2EPH
	N7pyi3JBJYbyv/iQMGHuwMVpQxT+ivhXvx7JCleTJBznmReNC0EIwWuFmY8KZbbrhkQ=
X-Gm-Gg: Acq92OHIToyKcePFWjp7Vhl5zTwL9qXeMcJeHUZqh+yz6wlH1Zc94FpeaoOe72RmmkT
	xYqs4Or9drKPqv0Oj+Lo5L18yy226ggqwzXluss8DgCl7rCfy+tuI6rNku9Raajaa47uRiQMDzX
	N2PixDB/lbdMO0F7qYY4mU5SAp9J2tNNb4UhtqARrr83hJLvqLzfm3AG+Zb12xeYoiiCmUw6Y/D
	tc/V6ucmIxiR27hIZPsXJ9p4s6r4AVokGityQn8LtrCrtSOVIK6lh0kqeqI16LS1eOVBip0G7uG
	Ojje1K9XcLlmTkQ6v0AIAwL526qfucSUEqrMw5UG7nEX4KX81isegJE29sZUA1FxaVUap7AwyjM
	1Q7NJUQgV6a2pGlZzr/dZgqXwx1ec8WU+Gl/O7GWO2k26a8doo2C9RkN5aNp3i8GJwN9Vi89pJU
	aUVMcfK8rkYX8Hoa5hXQe0eNjy1Spx3XXPP5irDISK3L8doK45
X-Received: by 2002:a17:903:2409:b0:2ba:7749:f89a with SMTP id d9443c01a7336-2bd27179682mr63543275ad.11.1778730701814;
        Wed, 13 May 2026 20:51:41 -0700 (PDT)
Received: from localhost.localdomain ([2408:8607:1b00:8:3771:9b3a:64a3:f42d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5fae5sm8189435ad.6.2026.05.13.20.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 20:51:41 -0700 (PDT)
From: Li Pengfei <ljdlns1987@gmail.com>
X-Google-Original-From: Li Pengfei <lipengfei28@xiaomi.com>
To: linux-trace-kernel@vger.kernel.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	linux-kernel@vger.kernel.org,
	cmllamas@google.com,
	zhangbo56@xiaomi.com,
	lipengfei28@xiaomi.com
Subject: [RFC PATCH 0/3] trace: stack trace deduplication for ftrace ring buffer
Date: Thu, 14 May 2026 11:49:13 +0800
Message-Id: <20260514034916.2162517-1-lipengfei28@xiaomi.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pengfei Li <lipengfei28@xiaomi.com>

Hi Steven, all,

This series adds stack trace deduplication to ftrace, reducing ring
buffer usage by ~80% when stacktrace is enabled.

Problem:
When the stacktrace option is enabled, each trace event stores a full
kernel stack (typically 10-20 frames x 8 bytes = 80-160 bytes). On
production devices with 4-8MB trace buffers, this fills the buffer in
seconds, limiting the usefulness of boot-time tracing and always-on
performance monitoring.

Solution:
A lock-free hash map (modeled after tracing_map.c as suggested by
Steven [1]) that deduplicates stack traces. The ring buffer stores
only a 4-byte stack_id; full stacks are exported via tracefs.

Design (following tracing_map.c pattern):
- Lock-free insert via cmpxchg (NMI/IRQ/any context safe)
- Pre-allocated element pool (zero allocation on hot path)
- Linear probing with 2x over-provisioned table
- Per-trace_array instance support

We adopted the same lock-free algorithm as tracing_map but with a
purpose-built data structure, because tracing_map's API is designed
for histogram aggregation with fixed-size keys and sum/var fields,
while our use case requires variable-length stack traces with
reference counting.

Test results (ARM64, Qualcomm SM8850, kernel 6.12):
- kmem_cache_alloc events, 1 second capture:
  774 unique stacks, 8264 hits, 0 drops, 100% hit rate
  Ring buffer savings: 795KB -> 176KB (78% reduction)
- Function tracer, 3 seconds:
  3632 unique stacks, 25466 hits, 0 drops
  Ring buffer savings: 2.5MB -> 653KB (74% reduction)

Note: An earlier prototype using rhashtable crashed in IRQ context
(BUG at rhashtable.h:912), which led us to adopt the tracing_map
cmpxchg-based approach.

Usage:
  echo 1 > /sys/kernel/debug/tracing/options/stackmap
  echo 1 > /sys/kernel/debug/tracing/options/stacktrace
  # trace output: <stack_id 42>
  # resolve:      cat /sys/kernel/debug/tracing/stack_map

[1] https://lore.kernel.org/all/20260513085145.30dd23e0@fedora/

Pengfei Li (3):
  trace: add lock-free stackmap for stack trace deduplication
  trace: integrate stackmap into ftrace stack recording path
  trace: add documentation, selftest and tooling for stackmap

 Documentation/trace/ftrace-stackmap.rst       | 111 ++++
 kernel/trace/Kconfig                          |  21 +
 kernel/trace/Makefile                         |   1 +
 kernel/trace/trace.c                          |  46 ++
 kernel/trace/trace.h                          |  16 +
 kernel/trace/trace_entries.h                  |  15 +
 kernel/trace/trace_output.c                   |  23 +
 kernel/trace/trace_stackmap.c                 | 569 ++++++++++++++++++
 kernel/trace/trace_stackmap.h                 |  54 ++
 .../ftrace/test.d/ftrace/stackmap-basic.tc    |  74 +++
 tools/tracing/stackmap_dump.py                | 120 ++++
 11 files changed, 1050 insertions(+)
 create mode 100644 Documentation/trace/ftrace-stackmap.rst
 create mode 100644 kernel/trace/trace_stackmap.c
 create mode 100644 kernel/trace/trace_stackmap.h
 create mode 100755 tools/testing/selftests/ftrace/test.d/ftrace/stackmap-basic.tc
 create mode 100755 tools/tracing/stackmap_dump.py

-- 
2.34.1

