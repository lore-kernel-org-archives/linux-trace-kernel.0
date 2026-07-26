Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7127B37BE99
	for <linux-trace-kernel@vger.kernel.org>; Sun, 26 Jul 2026 12:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785068569; cv=none; b=UkrI0/yCuNrguDancI8ZaH/SrhPJJPSEAQbOhnhjnmy/QpcDT/nECJe871Ak6NOeY7vsH8YAApwRdEPz46mJTGux2iLrcaAMwwlPbYHl7v7TSE0LmaGpRqQIEuMhMAcDqppWlMvVAcLkBghVxF9Ro8ub/Q1ld5LkevzFZIQ94u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785068569; c=relaxed/simple;
	bh=EWnv07DWloHMIzkcvB+TMe7XnJ2cm6FV6nkeNMADT+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lLtbEUqhYr6siEa9w7wMoKx9+4O4KLAMhTrWLB/sutYMnFsOoXvVv+sd1vYeeXTrDx0JPmJN3XviaHtTzfCeCEo6WguwSfZneYQoeUURBe1E+OrhFFGX6o++Hxcl3ziZsjQT4Tn9v5BSXIhpz0uKWCrLYDY1te+FdMORHguwvVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FE1m9exK; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FE1m9exK"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6aa9606ddadso1488887eaf.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 26 Jul 2026 05:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785068567; x=1785673367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dWX/ZZduUGn7dvOGbkdZ90gJ+u5X4idkSvz+SXiZQGM=;
        b=FE1m9exKHLvAS5o8BjC4LgdZqTAQmeDiCRP6Fm/+xbACJcyN1TzGYr92GoWNuxLmlg
         j3J5VYJhIbyD2BsKoBD1M0yVoqpIrMV5H9nRLTky6fVIpq6tEN9QwGDwEvlzClzVJ3LM
         iB9OWMUT04IuUPiq/DRCNGKnPG/n7LWU91GQiLYvBkgMSvav8SxCIf0Oj0p73W2bIBzG
         bISQ96f7jbbiUmHBlm6s09ZkCZHY6si2+sn9zDXNTomkDQKiZVAo8SHgTeDw/J7M7wZ+
         IicURTfq2sHn8lcR3infjIWyp2tBVOUtMCOATzyRhKI3AhfBsjEvsxpnHuF9PZbNYdJf
         SQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785068567; x=1785673367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dWX/ZZduUGn7dvOGbkdZ90gJ+u5X4idkSvz+SXiZQGM=;
        b=LDiF1rvEoobHkB1xizjS0e2+e/yhDOjjWS+fxF03cSmT1r2SRetWXrCJsjgPLNiPH7
         w/R4qKBxVmGHNBp8+ry4VXF54ztc6qFtL2jw8naosfYU76wDmmFz5C6vwO73/hUNHVj/
         kprhRW4bKPDn52Alh0dvS7N0c09Sa532alQsY8M9cmklrlYoPJbIXNO0RR5aWn6tiytU
         q210fNdygH4l0MWdiZsKxE2uXwaMiQn7TIOjRvAVnQzrezcAMJBhatQK5iBdtFc3zhii
         GA/w+GlL+IYktrTHdA/L7QIjMCSnr4RklQRnv833dzhPlHfI4LUCQz+yc5cErGL0r2KN
         m7Bg==
X-Forwarded-Encrypted: i=1; AHgh+Ro6pTuJeQskY84VBOqwsu79ZOT7eV8A5GAB8G5OaCkzfYURsUgYcdN0Yk2hcbwSLyHp4LKrI43zBeyU3WzD0uuPZtg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjwu3PBfdxP8qgjSN0WkdYyvaEirS+qBkmnDrkrxFJi+/O18Vg
	bcfRkO+TEMhtSVkgAKBeKg7jQqWd8weclOysQJMhZIQtF5lUIXtWsQYY
X-Gm-Gg: AR+sD10J1y3mZy8rXcyneTSO52Jc72egTkLtschJzBYWEO03IAAXc5X0cZS4zvpHBFU
	74vpAarEw+86Izk3awXbJhQAZvf4GjVPeiHyD85iiIS25sLXgGmaOkloLT7VggiqVBTDjoAHBSM
	f6VBtMWQRRS9I29hSQcJjo7zTizTSS/P8IjY6VceetrZho5JaEukIBOCRtXpg7JXWWMT1L3h3gk
	MH+OFMX9fBfj0cohZYd+AYk1NBnPn8LBPilQqRY4yjq6kOcoX7bVcC85skckfAlry+WxeM70+HB
	dEAyKZ46rlzOWTe6Kcw4svvw/4qS57MuaOOyylQXOctC2iQTuOBcWVEZFkZ9y7+0zOY84KYMLYn
	MaFQAvPeJT/oDo+c/KNQC6qVZWZJevOdmkZO1VfM5OaJJqmSgW4vYPSj0RzclHHCUlhPmg1MgaO
	8IOw==
X-Received: by 2002:a05:6820:450a:b0:6aa:dfcb:3daf with SMTP id 006d021491bc7-6aaffa204f3mr3158838eaf.51.1785068567318;
        Sun, 26 Jul 2026 05:22:47 -0700 (PDT)
Received: from localhost ([144.24.58.22])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6aaf9363793sm3403006eaf.5.2026.07.26.05.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 05:22:46 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	x86@kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-edac@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH 0/3] hw_breakpoint: Fix and simplify local address updates for wprobe
Date: Sun, 26 Jul 2026 20:22:29 +0800
Message-ID: <cover.1785067572.git.wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <178476143000.26117.9810509272687580410.stgit@devnote2>
References: <178476143000.26117.9810509272687580410.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Masami,

While reviewing wprobe v10, I prepared three patches to fix and simplify
the HWBP support required by wprobe.

This series is based on linux-trace/probes/for-next, the same base used by
wprobe v10. It is intended to replace patches 5-7 in v10, so it should not
be applied on top of topic/wprobe-v2.

Patch 1 fixes the x86 HWBP slot and DR7 races when an operation is
interrupted by an NMI.

Patch 2 adds arch_modify_local_hw_breakpoint_addr(), which updates only
the watched address of an installed breakpoint on the local CPU.

Patch 3 adds the matching generic modify_local_hw_breakpoint_addr() API.
It keeps the original patch structure and Masami's authorship, while
removing attribute parsing, type/length updates and rollback.

With the address-only interface, the install/uninstall refactoring in the
old patch 5 is no longer needed.

I can take care of follow-up maintenance related to fast local HWBP
watched-address updates.

The patches passed checkpatch and the relevant x86_32 and x86_64 object
builds.

Jinchao Wang (2):
  x86/hw_breakpoints: Make DR7 updates NMI safe
  x86/hw_breakpoints: Add arch_modify_local_hw_breakpoint_addr() API

Masami Hiramatsu (Google) (1):
  HWBP: Add modify_local_hw_breakpoint_addr() API

 arch/Kconfig                         |   8 ++
 arch/x86/Kconfig                     |   1 +
 arch/x86/include/asm/debugreg.h      |  36 ++++++---
 arch/x86/include/asm/hw_breakpoint.h |   2 +
 arch/x86/kernel/cpu/mce/core.c       |  20 +++--
 arch/x86/kernel/hw_breakpoint.c      | 114 ++++++++++++++++-----------
 arch/x86/kernel/nmi.c                |  10 ++-
 arch/x86/kernel/traps.c              |  10 ++-
 include/linux/hw_breakpoint.h        |   6 ++
 kernel/events/hw_breakpoint.c        |  30 +++++++
 10 files changed, 166 insertions(+), 71 deletions(-)


base-commit: 1a416ae446afa42d2d8500ce25bd61c564508721
-- 
2.53.0
