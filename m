Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70E13A0B17
	for <linux-trace-kernel@vger.kernel.org>; Wed,  7 Jan 2026 17:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767807076; cv=none; b=idjCEf7KjTElI3VZDz9Qm0nT0zCb5Ebym2/B/3gFCR35/4rLZhVWl+HuAcRBzv88w7yxidJPgdmPqW/nhCWk3ipiBL972gem5mIZ+cZTlhieXrqKP2mSC16GeNaUSRvvLhIh77Tf2fxwv59/dzamzyWqfGmVlrCF3j4l5PFg4PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767807076; c=relaxed/simple;
	bh=uScQnQ+Ya3fi7oynxW6RbxRI7+HkKh59FSF5uEZCxWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JUYtcr1J71G4beNhrqkctLC20kWLJZG+gIOY0KwZpmlp728wMfOYhaNrfDsKomVYXkbL84BeS5APX7TtNOYbDKzq7Q/ZWgvmdMvfI4QJXeoBwG0jASB/9t4fkhOQ5gboDus+HJTR1Tl05XmVPB8rORqQyDo8FEgOfa/SmP1RMGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fNMBXAcI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fNMBXAcI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767807072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XMtOv45yK97eORj3aQ0j2BAGefKc5Spmp7l02Y2YzhQ=;
	b=fNMBXAcIT+nKKp9XFR9yz48k1zSpxSkIZG0yHmlR4Fbh+e2m03m8HFs5d66ZaLvbViyBvy
	ArpQ3mU4nOb2pj1p/WIkngBAvRO/xzYipj7Ec0MCWchjUQP7t5GVI5I6i2P61nHjEqKsjs
	q6U6n+UXgbJgfz5Sv7g2ibZ+6SIrnsA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-56-ud43qSAtO1WAZjyBBV30xw-1; Wed,
 07 Jan 2026 12:31:10 -0500
X-MC-Unique: ud43qSAtO1WAZjyBBV30xw-1
X-Mimecast-MFC-AGG-ID: ud43qSAtO1WAZjyBBV30xw_1767807069
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B6CFE18005AE;
	Wed,  7 Jan 2026 17:31:09 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.226.8])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DF4C91956053;
	Wed,  7 Jan 2026 17:31:06 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [GIT PULL] RTLA changes for v6.20
Date: Wed,  7 Jan 2026 18:17:24 +0100
Message-ID: <20260107171724.217028-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Steven,

please pull the following changes for RTLA (more info in tag description).

Thanks,
Tomas

The following changes since commit 9ace4753a5202b02191d54e9fdf7f9e3d02b85eb:

  Linux 6.19-rc4 (2026-01-04 14:41:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tglozar/linux.git tags/rtla-v6.20

for you to fetch changes up to fb8b8183208d8efe824e8d2c73fb1ab5ad1191fd:

  rtla: Fix parse_cpu_set() return value documentation (2026-01-07 15:57:56 +0100)

----------------------------------------------------------------
RTLA patches for v6.20

- Remove unused function declarations

Some functions were removed in recent code consolidation 6.18, but
their prototypes were not removed from headers. Remove them.

- Set stop threshold after enabling instances

Prefer recording samples without stopping on them on the start of
tracing to stopping on samples that are never recorded. This fixes
flakiness of some RTLA tests and unifies behavior of sample collection
between tracefs mode and BPF mode.

- Consolidate usage help message implementation

RTLA tools (osnoise-top, osnoise-hist, timerlat-top, timerlat-hist)
each implement usage help individually. Move common logic between
them into a new function to reduce code duplication.

- Add BPF actions feature

Add option --bpf-action to attach a BPF program (passed as filename of
its ELF representation) to be executed via BPF tail call at latency
threshold.

- Consolidate command line option parsing

Each RTLA tool implements the parsing of command line options
individually. Now that we have a common structure for parameters,
unify the parsing of those options common among all four tools into
one function.

- Deduplicage cgroup common code

Two functions in utils.c, setting cgroup for comm and setting cgroup
for pid, duplicate code for constructing the cgroup path. Extract it
to a new helper function.

- String and error handling fixes and cleanups

There were several instances of unsafe string and error handling that
could cause invalid memory access; fix them. Also, remove a few unused
headers, update .gitignore, and deduplicate code.

The tag was tested (make && make check) as well as pre-tested on top of
next-20260107. There are no known conflicts.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>

----------------------------------------------------------------
Costa Shulyupin (11):
      tools/rtla: Remove unused function declarations
      tools/rtla: Add common_usage()
      tools/rtla: Add common_parse_options()
      tools/rtla: Consolidate -c/--cpus option parsing
      tools/rtla: Consolidate -C/--cgroup option parsing
      tools/rtla: Consolidate -D/--debug option parsing
      tools/rtla: Consolidate -d/--duration option parsing
      tools/rtla: Consolidate -e/--event option parsing
      tools/rtla: Consolidate -P/--priority option parsing
      tools/rtla: Consolidate -H/--house-keeping option parsing
      tools/rtla: Deduplicate cgroup path opening code

Crystal Wood (1):
      rtla: Set stop threshold after all instances are enabled

Tomas Glozar (7):
      rtla/timerlat: Support tail call from BPF program
      rtla/timerlat: Add --bpf-action option
      rtla/timerlat: Add example for BPF action program
      rtla/tests: Test BPF action program
      rtla/tests: Run Test::Harness in verbose mode
      Documentation/rtla: Rename sample/ to example/
      Documentation/rtla: Document --bpf-action option

Wander Lairson Costa (10):
      rtla: Introduce for_each_action() helper
      rtla: Replace atoi() with a robust strtoi()
      rtla: Use standard exit codes for result enum
      rtla: Remove redundant memset after calloc
      rtla: Remove unused headers
      rtla: Fix NULL pointer dereference in actions_parse
      rtla: Add generated output files to gitignore
      rtla: Make stop_tracing variable volatile
      rtla: Ensure null termination after read operations in utils.c
      rtla: Fix parse_cpu_set() return value documentation

 .../tools/rtla/common_timerlat_options.txt         |  20 ++-
 tools/tracing/rtla/.gitignore                      |   4 +
 tools/tracing/rtla/Makefile                        |  19 ++-
 tools/tracing/rtla/example/timerlat_bpf_action.c   |  16 +++
 .../rtla/{sample => example}/timerlat_load.py      |   0
 tools/tracing/rtla/src/actions.c                   |  17 +--
 tools/tracing/rtla/src/actions.h                   |   5 +
 tools/tracing/rtla/src/common.c                    | 140 ++++++++++++++++++++-
 tools/tracing/rtla/src/common.h                    |  10 +-
 tools/tracing/rtla/src/osnoise.c                   |  17 +--
 tools/tracing/rtla/src/osnoise.h                   |   8 --
 tools/tracing/rtla/src/osnoise_hist.c              |  76 ++---------
 tools/tracing/rtla/src/osnoise_top.c               |  90 +++----------
 tools/tracing/rtla/src/timerlat.bpf.c              |  25 +++-
 tools/tracing/rtla/src/timerlat.c                  |  29 ++---
 tools/tracing/rtla/src/timerlat.h                  |   2 +-
 tools/tracing/rtla/src/timerlat_bpf.c              |  66 ++++++++++
 tools/tracing/rtla/src/timerlat_bpf.h              |   7 +-
 tools/tracing/rtla/src/timerlat_hist.c             |  80 +++---------
 tools/tracing/rtla/src/timerlat_top.c              |  80 +++---------
 tools/tracing/rtla/src/trace.c                     |   1 -
 tools/tracing/rtla/src/utils.c                     | 110 ++++++++++------
 tools/tracing/rtla/src/utils.h                     |  10 +-
 tools/tracing/rtla/tests/bpf/bpf_action_map.c      |  25 ++++
 tools/tracing/rtla/tests/engine.sh                 |   1 -
 tools/tracing/rtla/tests/timerlat.t                |  15 +++
 26 files changed, 513 insertions(+), 360 deletions(-)
 create mode 100644 tools/tracing/rtla/example/timerlat_bpf_action.c
 rename tools/tracing/rtla/{sample => example}/timerlat_load.py (100%)
 create mode 100644 tools/tracing/rtla/tests/bpf/bpf_action_map.c

