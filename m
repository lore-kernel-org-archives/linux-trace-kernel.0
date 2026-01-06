Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E18131A810
	for <linux-trace-kernel@vger.kernel.org>; Tue,  6 Jan 2026 13:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767706629; cv=none; b=usqE9WnDV7C715V35k/7Qh0D10rKl5YFv1itXO8Ro4asexaLgJvTHVRhSrK+juelLr1iBS4cfkO4hEp/NucEj2rmiP6zUhcEq70Ec4bbPS+u+Fo14xtaymfzlivYB0p7qXWG3zK7kLpL4YbzB2r5uQ7wro7h0BmUUEXc2YGR73U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767706629; c=relaxed/simple;
	bh=OqSJFUWiHQxqFxFPisv6EWYIhOs52b4UJjqYTr5vIlM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=J3bQsJsZay37njMwj5ccLJmONts7T7Ew3xqAhuQRj8GJ0AKcBr5lP7xJMsZXwYHKeutv9mtAoROz5Glasoke3XtwAxqvHDs3lBrGLVyRy27S/vgMonA3UXmj19gAwTwc1CDOk8yuBm66NmINfS5tpI/6Vy7p1zhO7azMsfL9XE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eMmiEg13; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eMmiEg13"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767706626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=j/2+/oiDEs1gVD3rwkh3CY+VLUKffCw/auboD8hTvso=;
	b=eMmiEg13+3cR5fcXI2WR1tsI3y5MOw4mHKg6i7ThHSPDQEn5cVhyT4oWTqQuMfsGVCgPDt
	2AJ5KNWSRaetKHIMwRV3dj3uxHbEW4dmcW6FDkhHQlIe9uuevOSMGwjrC6ziq2aPWefseK
	2/b4cV+scNszz+CEBWmqbqC1DR6aouI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-WbFG8iVLPJyIps3yAsXKtA-1; Tue,
 06 Jan 2026 08:37:03 -0500
X-MC-Unique: WbFG8iVLPJyIps3yAsXKtA-1
X-Mimecast-MFC-AGG-ID: WbFG8iVLPJyIps3yAsXKtA_1767706622
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 17DCF195FCEB;
	Tue,  6 Jan 2026 13:37:02 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.89.23])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4D4471800367;
	Tue,  6 Jan 2026 13:36:58 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	linux-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [PATCH v2 00/18] rtla: Code quality and robustness improvements
Date: Tue,  6 Jan 2026 08:49:36 -0300
Message-ID: <20260106133655.249887-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

This patch series addresses several code quality and robustness issues
in the rtla (Real-Time Linux Analysis) tool. The changes focus on
eliminating potential buffer overflows, fixing NULL pointer dereferences,
improving error handling, and simplifying code maintenance through better
abstractions and helper functions.

The series introduces safer string handling practices, including proper
null termination after read() operations, correct buffer sizing for
strncpy(), and volatile qualification for signal handler variables. It
replaces unsafe functions like atoi() with robust error-checking
alternatives, eliminates magic numbers in favor of named constants, and
adds compile-time string length calculations to prevent buffer overruns.

Additionally, the series reduces code duplication by introducing helper
macros and functions for common patterns like action iteration, argument
parsing, and threshold restart logic. It also includes minor cleanups
such as removing redundant operations, unused headers, and fixing
documentation inconsistencies. These improvements make the rtla codebase
safer, more maintainable, and more consistent with kernel coding
standards.

Changes:

v2:
- exit on memory allocation failure
- remove redundant strlen() calls
- fix possible race on condition on stop_tracing variable access
- ensure null termination on read() calls
- fix checkpatch reports
- make extract_args() an inline function
- add the usage of common_restart() in more places

Wander Lairson Costa (18):
  rtla: Exit on memory allocation failures during initialization
  rtla: Use strdup() to simplify code
  rtla: Introduce for_each_action() helper
  rtla: Replace atoi() with a robust strtoi()
  rtla: Simplify argument parsing
  rtla: Use strncmp_static() in more places
  rtla: Introduce common_restart() helper
  rtla: Use standard exit codes for result enum
  rtla: Remove redundant memset after calloc
  rtla: Replace magic number with MAX_PATH
  rtla: Remove unused headers
  rtla: Fix NULL pointer dereference in actions_parse
  rtla: Fix buffer size for strncpy in timerlat_aa
  rtla: Add generated output files to gitignore
  rtla: Make stop_tracing variable volatile
  rtla: Ensure null termination after read operations in utils.c
  rtla: Fix parse_cpu_set() return value documentation
  rtla: Simplify code by caching string lengths

 tools/tracing/rtla/.gitignore          |   4 +
 tools/tracing/rtla/src/actions.c       | 114 +++++++++++++++----------
 tools/tracing/rtla/src/actions.h       |  13 ++-
 tools/tracing/rtla/src/common.c        |  67 ++++++++++-----
 tools/tracing/rtla/src/common.h        |  11 ++-
 tools/tracing/rtla/src/osnoise.c       |  28 ++----
 tools/tracing/rtla/src/osnoise_hist.c  |  26 ++----
 tools/tracing/rtla/src/osnoise_top.c   |  25 ++----
 tools/tracing/rtla/src/timerlat.c      |   5 +-
 tools/tracing/rtla/src/timerlat_aa.c   |   4 +-
 tools/tracing/rtla/src/timerlat_hist.c |  44 ++++------
 tools/tracing/rtla/src/timerlat_top.c  |  46 ++++------
 tools/tracing/rtla/src/timerlat_u.c    |   4 +-
 tools/tracing/rtla/src/trace.c         |  59 +++++--------
 tools/tracing/rtla/src/trace.h         |   4 +-
 tools/tracing/rtla/src/utils.c         |  99 ++++++++++++++++++---
 tools/tracing/rtla/src/utils.h         |  26 ++++--
 17 files changed, 335 insertions(+), 244 deletions(-)

-- 
2.52.0

