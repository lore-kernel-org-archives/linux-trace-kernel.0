Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD04F2989A2
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Mar 2026 15:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774624125; cv=none; b=Ay1Cx9VFHe0noEBCm4eQfTc48GpU8PIDiwZ1hGtBQuxpG8QtNnlrPeyFRd9nAUz/4H3dAggpMczi7iuT9036hofiw/eLLQI6jPlyr28tsVaSR84K2atpIgxmCJYWkLrHlRXe1JMcTyhy2ype/jK0pAOb0hd/VHPJdvuyl7ih3VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774624125; c=relaxed/simple;
	bh=lhWBmjUqrhX7Jm+pRLuhZRoBs6G3a1veozDWEh5uRFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=ksKHCmbq0tJbG0QyHkxzSrWWIuWzcIYDYDrKiI6Suq27/vTpFrOftL+VsDGwudzlxPPwlHvhojCrwC7+gm/P0Y5OvvR5hEhujsBJXL5B1zdtYqLQVgzJiOHalcZfTBlSzueoZ18DLYGNatz9af+G/W30F2rWp15srwJXzinLQZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NDhhgiIh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NDhhgiIh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774624122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3RTq8TYvkOOSsUrIzWfTLQNMicMdS3cR2OfvefLF1fc=;
	b=NDhhgiIhnK9sEH3CehwOkesKJAP9eavgq+a0MRA/vW4Nd2x++z93yzF2i1w2UOvS3i/Jzn
	VH1wO+ObLRcbjx1Qfwa/NGzZb3qdfb7Uun4YlZLhFcsLLvHs5OcAD0FyOCZC1BOloPoorC
	u9bpCx8sbEKjsaEegMbGBFUMtmMZPB8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-z5VMjNwTPeKSGqxTS2a1Jw-1; Fri,
 27 Mar 2026 11:08:38 -0400
X-MC-Unique: z5VMjNwTPeKSGqxTS2a1Jw-1
X-Mimecast-MFC-AGG-ID: z5VMjNwTPeKSGqxTS2a1Jw_1774624118
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BE6E91956048;
	Fri, 27 Mar 2026 15:08:37 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.152])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 233511800361;
	Fri, 27 Mar 2026 15:08:34 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [GIT PULL] RTLA changes for v7.1
Date: Fri, 27 Mar 2026 16:02:37 +0100
Message-ID: <20260327150237.405973-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: j-pSmaETsoZNCNUYQnwtbMkuaXdWPkWe45avmumwMVw_1774624118
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Steven,

please pull the following changes for RTLA (more info in tag description).

Thanks,
Tomas

The following changes since commit 11439c4635edd669ae435eec308f4ab8a0804808:

  Linux 7.0-rc2 (2026-03-01 15:39:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tglozar/linux.git tags/rtla-v7.1

for you to fetch changes up to 82374995b63d2de21414163828a32d52610dcaf2:

  Documentation/rtla: Document SIGINT behavior (2026-03-27 10:58:30 +0100)

----------------------------------------------------------------
RTLA patches for v7.1

- Simplify option parsing

Auto-generate getopt_long() optstring for short options from long options
array, avoiding the need to specify it manually and reducing the surface
for mistakes.

- Add unit tests

Implement unit tests (make unit-tests) using libcheck, next to existing
runtime tests (make check). Currently, three functions from utils.c are
tested.

- Add --stack-format option

In addition to stopping stack pointer decoding (with -s/--stack option)
on first unresolvable pointer, allow also skipping unresolvable pointers
and displaying everything, configurable with a new option.

- Unify number of CPUs into one global variable

Use one global variable, nr_cpus, to store the number of CPUs instead of
retrieving it and passing it at multiple places.

- Fix behavior in various corner cases

Make RTLA behave correctly in several corner cases: memory allocation
failure, invalid value read from kernel side, thread creation failure,
malformed time value input, and read/write failure or interruption by
signal.

- Improve string handling

Simplify several places in the code that handle strings, including
parsing of action arguments. A few new helper functions and variables
are added for that purpose.

- Get rid of magic numbers

Few places handling paths use a magic number of 1024. Replace it with
MAX_PATH and ARRAY_SIZE() macro.

- Unify threshold handling

Code that handles response to latency threshold is duplicated between
tools, which has led to bugs in the past. Unify it into a new helper
as much as possible.

- Fix segfault on SIGINT during cleanup

The SIGINT handler touches dynamically allocated memory. Detach it
before freeing it during cleanup to prevent segmentation fault and
discarding of output buffers. Also, properly document SIGINT handling
while at it.

The tag was tested (make && make check && make unit-tests) as well as
pre-tested on top of next-20260326. There are no known conflicts.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>

----------------------------------------------------------------
Costa Shulyupin (7):
      tools/rtla: Generate optstring from long options
      tools/build: Add feature test for libcheck
      tools/rtla: Add unit tests for utils.c
      tools/rtla: Consolidate nr_cpus usage across all tools
      tools/rtla: Remove unneeded nr_cpus arguments
      tools/rtla: Remove unneeded nr_cpus members
      tools/rtla: Remove unneeded nr_cpus from for_each_monitored_cpu

Tomas Glozar (4):
      rtla/timerlat: Add --stack-format option
      Documentation/rtla: Document --stack-format option
      rtla: Fix segfault on multiple SIGINTs
      Documentation/rtla: Document SIGINT behavior

Wander Lairson Costa (17):
      rtla: Exit on memory allocation failures during initialization
      rtla: Use strdup() to simplify code
      rtla/actions: Simplify argument parsing
      rtla: Introduce common_threshold_handler() helper
      rtla: Replace magic number with MAX_PATH
      rtla: Simplify code by caching string lengths
      rtla/timerlat: Add bounds check for softirq vector
      rtla: Handle pthread_create() failure properly
      rtla: Add str_has_prefix() helper function
      rtla: Use str_has_prefix() for prefix checks
      rtla: Enforce exact match for time unit suffixes
      rtla: Use str_has_prefix() for option prefix check
      rtla/timerlat: Simplify RTLA_NO_BPF environment variable check
      rtla/trace: Fix write loop in trace_event_save_hist()
      rtla/trace: Fix I/O handling in save_trace_to_file()
      rtla/utils: Fix resource leak in set_comm_sched_attr()
      rtla/utils: Fix loop condition in PID validation

 Documentation/tools/rtla/common_appendix.txt       |  21 ++++
 .../tools/rtla/common_timerlat_options.txt         |  12 +++
 tools/build/Makefile.feature                       |   3 +
 tools/build/feature/Makefile                       |   4 +
 tools/build/feature/test-libcheck.c                |   8 ++
 tools/tracing/rtla/Build                           |   1 +
 tools/tracing/rtla/Makefile                        |   5 +
 tools/tracing/rtla/Makefile.config                 |   8 ++
 tools/tracing/rtla/README.txt                      |   1 +
 tools/tracing/rtla/src/actions.c                   | 103 +++++++++++-------
 tools/tracing/rtla/src/actions.h                   |   8 +-
 tools/tracing/rtla/src/common.c                    | 120 +++++++++++++++++----
 tools/tracing/rtla/src/common.h                    |  24 ++++-
 tools/tracing/rtla/src/osnoise.c                   |  26 ++---
 tools/tracing/rtla/src/osnoise_hist.c              |  51 ++++-----
 tools/tracing/rtla/src/osnoise_top.c               |  41 ++-----
 tools/tracing/rtla/src/timerlat.c                  |  16 ++-
 tools/tracing/rtla/src/timerlat.h                  |   1 +
 tools/tracing/rtla/src/timerlat_aa.c               |  51 ++++++---
 tools/tracing/rtla/src/timerlat_aa.h               |   2 +-
 tools/tracing/rtla/src/timerlat_bpf.c              |  19 ++--
 tools/tracing/rtla/src/timerlat_bpf.h              |  12 +--
 tools/tracing/rtla/src/timerlat_hist.c             | 116 +++++++++-----------
 tools/tracing/rtla/src/timerlat_top.c              | 114 +++++++++-----------
 tools/tracing/rtla/src/timerlat_u.c                |  13 ++-
 tools/tracing/rtla/src/timerlat_u.h                |   1 +
 tools/tracing/rtla/src/trace.c                     | 102 ++++++++++--------
 tools/tracing/rtla/src/trace.h                     |   4 +-
 tools/tracing/rtla/src/utils.c                     | 113 ++++++++++++++-----
 tools/tracing/rtla/src/utils.h                     |  33 ++++++
 tools/tracing/rtla/tests/unit/Build                |   2 +
 tools/tracing/rtla/tests/unit/Makefile.unit        |  17 +++
 tools/tracing/rtla/tests/unit/unit_tests.c         | 119 ++++++++++++++++++++
 33 files changed, 769 insertions(+), 402 deletions(-)
 create mode 100644 tools/build/feature/test-libcheck.c
 create mode 100644 tools/tracing/rtla/tests/unit/Build
 create mode 100644 tools/tracing/rtla/tests/unit/Makefile.unit
 create mode 100644 tools/tracing/rtla/tests/unit/unit_tests.c

