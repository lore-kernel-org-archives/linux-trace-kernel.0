Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1B047ECC6
	for <linux-trace-kernel@vger.kernel.org>; Tue,  1 Sep 2026 13:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788270377; cv=none; b=nbkwhrtEQTN4goIwU0kbuDZiMH3+yFZNl6vGLFfGObZ1Z1Nn06fQi2QIZHQFo2Utfw58rlWQVbley2Y36XPR0GuJIPBzW37SqXJlzRYjFjlvStcgRtEOCLNwP+TLwPcm1tr73F4QKLqrSps5Hn9ZkrDR/LEb98gcQdit+xVQEoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788270377; c=relaxed/simple;
	bh=bm8bp3OKvTpbmVk86pCxKeMFsEBnuwMNAx9kusqWPLg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BAmvnaSZBHDwHvk59r8FF+ta9Tl7OY56qhc2LaFPt6iqo11Wa2fw+wp+JnL0Sq3ydxYLrfCxLru+v7PgFAC19gZHhFA8mRGIslzr3SJ/rGs1SaVXRzDFq3o3pCsze1jMr8ik2uAffuIXgO4sud2EJh4yT69cskfII0RqmupXVrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CfyGHiWr; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfyGHiWr"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8557c3f270eso3953476b3a.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 01 Sep 2026 06:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788270375; x=1788875175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wwOVRZXUuFeiUE0jd/1FDXen2th6EKXLFmcEZJapFes=;
        b=CfyGHiWryRfLOCo/uaY5apvPkjWgGPUOQCNFmh0c5GiZ3vSBk/fmao8zyt74nWN7zq
         PaDwJYHGEhilO8PDjZyARTgHVc7AI+1xGa15uT0GZ948pI4GgTDTIWeLE4iO1oxCCw8v
         hHsuhaEUPPem7qkA88NSkzvtTWZHGWU3C8NTLgm149LNOVP/hwQikSH/hxk5W9v1aEVq
         31z+WsfdOdL7PgCY27LGSN+2yKwdUOZvzgIWa3Ol3r2xZajOshFiCECMAiUBwidDFngS
         uC7Qd6dsxAvVoQuI+JR3JnSXr1lDJxXgi/6olOU5tyIFthSx+0w+nG6kCX1vWGVrEQ8D
         hWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788270375; x=1788875175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wwOVRZXUuFeiUE0jd/1FDXen2th6EKXLFmcEZJapFes=;
        b=T28sokhnC9rhdzTJYPWATHhtM0onjA4bA98T9wF02bkcE96r5tJ+kLc6xwwh8Srhje
         Cg4Isn+DVVQQ1kBT7oxrzJoueIurpgKlhFyC79UbVJ2ka5w1xhTcnmvIhPazpad+Sm0p
         0PNyjzgcyb3QrGq+al5Pep9xm1XzJ3TL+480rhuNXz/8ltWryglAoz2VmQBUgEwuR6fK
         VIs+HpQOMObd9cXKS+ch0yisebHHwjGvO45poTceZhpCjRjU5ETNIWwrRr8dbd8Ifr1k
         3P+LoNmv/BYeHkq8G/xM/ttWY18fxlNKwW+mhwF58AXqmjpmW2qK8/jsFSvAphHOj9mV
         UmJQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq6TKrxy08A3NUpshlv5JYyitXnjRvKsQuNXuhsx04XNMCldN6hGqEcnKfYPcytV1YPyaWIRP9eWhRlP9O5Lo83tLY=@vger.kernel.org
X-Gm-Message-State: AFuF++kzk4nAjTqczxR2Lgm+SWm6f1txU2XPUX7iVSMBgBDXxmZ1iZ+V
	iuj4EGwQ6WWQoejQ5ytuIdXa8ud77WFpBYzlkps7rAB1vmNWsyRMIy82
X-Gm-Gg: AR+sD13xx6S1WEX9lyC60yKD291pI4ff2bZ7v6AzhPNx1Axg7sFp61lk+T/vkRKWJG1
	A1Ns+AxBKLdJ+Eaqryz7t6hf4xO1+mCi0vWFILfr0dHY756LI0LCZEb9V2LAQfkKwR/T9qSI36L
	oFVDB5FbDmXyJAZCvmrYW7c6Tcq5kplNtpjGrsI5KP1Po4/BvRfMQHAQIfxpXJ6eELWH89kCoBZ
	0IuW1aR/98eZ3WvK//dhjDCsuCh7qZza18OH/tSIySR53/s19ClY1J8ba/EnLFyCOV2cRlB9VtO
	95I0I91UsSs7SK2CmgibQDjLcfHxWZ1DkLmNOCRB1HNdq53XKT7J5kch7KzaEAbx7y1/0EfBsyl
	zX7KgxMTFnPSRsQ9Pps1K6cGF92cQGQRnJQ05kHPl4VuSjS+gEuEq3OWTzbZKyJZ/xEMcEauYos
	dl8xucJ96cFEi7XjqJQk1YXQO3uaZmGXXlMt4qDCD6vKiI55EnfzqJyELdezxTH4MT4m94HC9YV
	iLB
X-Received: by 2002:a05:6a00:1f11:b0:857:73e2:9105 with SMTP id d2e1a72fcca58-85773e29383mr38768468b3a.21.1788270374889;
        Tue, 01 Sep 2026 06:46:14 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85be8f52cb4sm1132502b3a.39.2026.09.01.06.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 06:46:14 -0700 (PDT)
From: Donglin Peng <dolinux.peng@gmail.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	dolinux.peng@gmai.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v5 0/3] Use BTF to trim return values
Date: Tue,  1 Sep 2026 21:46:01 +0800
Message-Id: <20260901134604.4052265-1-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

The funcgraph-retval option currently records one machine-word return
value without considering the function's declared return type. As a
result, void-returning functions can produce meaningless output, and
return values narrower than a general-purpose register can include
undefined high bits.

This series uses kernel BTF to identify the return type of traced
functions and to improve funcgraph-retval output:

  - Do not print a return value for functions with a void return type.
  - Trim integer, enum, struct, and union values to the available return
    value width when the BTF type provides suitable size information.
  - Format integer, enum, and boolean values according to their BTF
    encoding.
  - Mark values as "(trunc)" when the return type is wider than the
    value captured by the function graph tracer.

Here is an output comparison:

Before:
 # perf ftrace -G vfs_read --graph-opts retval
 ...
 1)               |   touch_atime() {
 1)               |     atime_needs_update() {
 1)   0.069 us    |       make_vfsuid(); /* ret=0x0 */
 1)   0.067 us    |       make_vfsgid(); /* ret=0x0 */
 1)               |       current_time() {
 1)   0.197 us    |         ktime_get_coarse_real_ts64_mg(); /* ret=0x187f886aec3ed6f5 */
 1)   0.352 us    |       } /* current_time ret=0x69380753 */
 1)   0.792 us    |     } /* atime_needs_update ret=0x0 */
 1)   0.937 us    |   } /* touch_atime ret=0x0 */

After:
 # perf ftrace -G vfs_read --graph-opts retval
 ...
 2)               |   touch_atime() {
 2)               |     atime_needs_update() {
 2)   0.070 us    |       make_vfsuid(); /* ret=0x0 */
 2)   0.070 us    |       make_vfsgid(); /* ret=0x0 */
 2)               |       current_time() {
 2)   0.162 us    |         ktime_get_coarse_real_ts64_mg();
 2)   0.312 us    |       } /* current_time ret=0x69380649(trunc) */
 2)   0.753 us    |     } /* atime_needs_update ret=false */
 2)   0.899 us    |   } /* touch_atime */

Changelog:

v5:
  - Add an inline fallback for btf_trim_retval() when
    CONFIG_DEBUG_INFO_BTF is disabled.
  - Release the BTF reference after return type lookup.

v4:
  - Link: https://lore.kernel.org/all/20251215034153.2367756-1-dolinux.peng@gmail.com/
  - Build trace_btf.c when CONFIG_DEBUG_INFO_BTF is enabled.
  - Remove the redundant BPF_SYSCALL dependency from
    CONFIG_PROBE_EVENTS_BTF_ARGS.
  - Update the funcgraph-retval documentation and cover letter.

v3:
  - Link: https://lore.kernel.org/all/20251209121349.525641-1-dolinux.peng@gmail.com/
  - Print the return value based on its type for human readability,
    thanks Masami.
  - Update the documentation and cover letter.

v2:
  - Link: https://lore.kernel.org/all/20251208131917.2444620-1-dolinux.peng@gmail.com/
  - Update the funcgraph-retval documentation.
  - Revise the cover letter.

v1:
  - Link: https://lore.kernel.org/all/20251207142742.229924-1-dolinux.peng@gmail.com/

pengdonglin (3):
  ftrace: Build trace_btf.c when CONFIG_DEBUG_INFO_BTF is enabled
  fgraph: Enhance funcgraph-retval with BTF-based type-aware output
  tracing: Update funcgraph-retval documentation

 Documentation/trace/ftrace.rst       | 88 ++++++++++++++++------------
 kernel/trace/Kconfig                 |  2 +-
 kernel/trace/Makefile                |  2 +-
 kernel/trace/trace_btf.c             | 68 +++++++++++++++++++++
 kernel/trace/trace_btf.h             | 16 +++++
 kernel/trace/trace_functions_graph.c | 50 ++++++++++++----
 6 files changed, 173 insertions(+), 53 deletions(-)

-- 
2.34.1

