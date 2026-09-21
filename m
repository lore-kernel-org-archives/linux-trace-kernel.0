Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902714F85DA
	for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Sep 2026 21:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790026017; cv=none; b=upgHP7VCGHGNuHR6udByVIBg9TLMTyM1frK2iBGXx2E6Q+xJmc8U05uHmH8CfHSZtTYegUcgt+Gc4+VzB7B8a312pEhftkaS095bjOXtzrT9dYPaUIdIiLLDsgNRqzoqzx3R7aQq7Mg80+pEjyUTxBNGAlXc/qcTURTNWKF8s38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790026017; c=relaxed/simple;
	bh=kMLmAu5aucbcuCSoji8mzcOeg1rx1GcCwe8mL5DIBl8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WDYPkoNJxL4v/bfz8kSJO5OxaXmV76vwRG0BGxorZhvIkJRNTpxJf3vWeB2VxXt8nlSw3Q0TUsntSt29bUbDdLmEf7ITmpmMIuvN7dey6tcpsNnhY1whKQerJ9dimwbjo4P/UYo1U24PmzM5EX1/dgNfCnpbGgrxhcL8d+0TQLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--abhishekbapat.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g27LNg5G; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--abhishekbapat.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g27LNg5G"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2db87f759c5so66337305ad.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Sep 2026 14:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790026016; x=1790630816; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sGtqedsZp9Mv9p5klFEFRiNUNOWdSEz9xQsHh22BPzw=;
        b=g27LNg5GnTHTerrefRnFV9uqoiPDHHBjt6NQVeXDdGnF51HHJf0hHO5kbrkd4hHq3+
         8XJ6li8QEPX2wzhccSx6C/d0Wz25fVYYchfemoOAMkQrNR8Ozo2WtG+fvYpJ03DrlZu1
         +IY81Nzx3LKk4TPPsP3n44sue7lnVtUEUc7XUKE/r9b/5gyqfoHYxmVVrUviFTW4VH0x
         MivGRWucxEoV+xXveCWahZBuGlnKmRNAGKcUlr71MqA4vYAu6i+X8JxIXQLIV8uXVaBd
         c5xy/KUcp28fkYMozd+aI4YOtWAM658KdZUBRLK3KhwB0O93EcjIdz7RV78bJpQ/VTvx
         +8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790026016; x=1790630816;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sGtqedsZp9Mv9p5klFEFRiNUNOWdSEz9xQsHh22BPzw=;
        b=Ojirr87VuczZr0Aar0UIjhD/AXLI0FpKa9pXtHVJhCL4BrKi97+tXUDiN0pgiK4Xbv
         jJWa3kMGKlfAbaSusCuMmKJklg0HKtucYy6jiykiSzJoOnBF4n1jQvJ73o/4jMhh7vsk
         v+UXIFGgiThs5Y8YChbAEgKBUk3cvDy2ZTkio1TGB+Fc5nBNfpF36HdB15DIHy5QD7xT
         ZzNJt5bJP/2AMx9g4XvDxNTHnqpPouNEg27OZAlDC3tLS1r3TNuxXzm0R3OUGM0alTeH
         oUySyAolu3lbJKVkccDk3dsw0TF3+T/lI51LrPr4RCo88MdHwnxpGpShIZR3OH76o2CD
         s+dQ==
X-Forwarded-Encrypted: i=1; AKwUvByV0ndUaE0e1ei9qoMdhXtno2/wdJRPP/yYkoQZ51eZ9HrYFK92d6bcLUoywl5EipJ+dsNGIk0e/HGXvK7eeKT7YsE=@vger.kernel.org
X-Gm-Message-State: AFuF++lyVg6ni3ExaSEJTXfeswP0uxiFmxG+aGmTYRtdNylGLcXDmy87
	kDJOCLTVQT2M0mIdbSsCiUdwas2nwUjZfXVU1Cu+IpmR/yavHth4iYyqY7z25ye/ZNnifxI5ttU
	ibSs4/3fUR22rBaQuit2GUPqxMFff9ZawRQ==
X-Received: from dyx27.prod.google.com ([2002:a05:693c:821b:b0:33e:5767:2163])
 (user=abhishekbapat job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2f89:b0:2d9:3850:2741 with SMTP id d9443c01a7336-2df5b0edd73mr4636595ad.0.1790026015752;
 Mon, 21 Sep 2026 14:26:55 -0700 (PDT)
Date: Mon, 21 Sep 2026 21:26:37 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <cover.1790025465.git.abhishekbapat@google.com>
Subject: [PATCH 0/4] alloc_tag: Introduce selective tracing for MAP
From: Abhishek Bapat <abhishekbapat@google.com>
To: Suren Baghdasaryan <surenb@google.com>, Hao Ge <hao.ge@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	Shuah Khan <shuah@kernel.org>, Abhishek Bapat <abhishekbapat@google.com>
Content-Type: text/plain; charset="UTF-8"

The existing memory allocation profiling (MAP) tool accurately maintains
aggregate counters for overall memory accounting. However, relying
purely on aggregated counters restrics the visibility needed for
targeted debugging.

This patch series integrates three new tracepoints (alloc_tag_hit,
alloc_tag_mem_alloced and alloc_tag_mem_freed) directly into the
alloc_hooks_tag fast path.

Enabling trace events globally for all allocations introduces a severe
baseline overhead. To limit the performance overhead, we let the admin
select specific allocations to be traced.

A new IOCTL is introduced to allow privileged users to determine which
allocation tags need tracing enabled. The IOCTL utilizes the
pre-existing filtering mechanism to specify the allocation tags to
enable tracing on.

Abhishek Bapat (4):
  alloc_tag: Add trace events for tracing allocations
  alloc_tag: Introduce IOCTLs to toggle allocation tracepoints
  alloc_tag: extend allocinfo_filter to support tracing queries
  alloc_tag: add a test for trace state toggle and filtering

 MAINTAINERS                                   |   1 +
 include/linux/alloc_tag.h                     |  94 +++++++++---
 include/linux/codetag.h                       |   5 +-
 include/trace/events/alloc_tag.h              | 122 +++++++++++++++
 include/uapi/linux/alloc_tag.h                |  17 ++-
 mm/alloc_tag.c                                | 142 +++++++++++++++++-
 .../alloc_tag/allocinfo_ioctl_test.c          | 111 +++++++++++++-
 7 files changed, 462 insertions(+), 30 deletions(-)
 create mode 100644 include/trace/events/alloc_tag.h


base-commit: 8d61431ed2607386b427752505379536eb634ce8
-- 
2.55.0.1082.g2b9226bbc0-goog

