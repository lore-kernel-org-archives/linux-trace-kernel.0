Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C502C11CF
	for <linux-trace-kernel@vger.kernel.org>; Fri, 29 May 2026 13:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780060590; cv=none; b=X5At+nhyJMe/YpFxRptLTbkORcMoifBfSO4Zj7D6Nq8ouYmGZd6XH+IL5mj0pMWG2gpjpjeYLBYKzvqhpCQwBREzrrAZWheCQLvKS2NBzY+ToEdIf0XpiLTvrKKkamPIDog5t977rhqZk/+XC/k6se+nGOQg+zmISNcyKw+IFJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780060590; c=relaxed/simple;
	bh=FaCBUCvVqxY4nULkTI/5ULFTPp3Vvl7JHKkFuCeDVuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=AR5jitE/IMsA7nQt2IXowxk9uDnvsKrTTIxXCkctdamEObDlXLT738oOB0YRqnIviq13T9VfFLvsv+rWWVsPJR+w09DTwDRkLRDzK2XW80gPgLhvc+p80/zGPODprG1fptTzsQfi/v0vavDYOS5JtR3EKOvOO3eEDaUZH1/J6r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XnEB65Vb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XnEB65Vb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780060588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=h76TO3C/XJ0bUQcwa0kSOi2jrVqPKKl/lZWXwyUkLeg=;
	b=XnEB65Vb4FzJyw9pK3nkfqcDGGPXorwrS62S/CAByY8PekPzpJY8jpF9iEfupHyfeFWI5J
	54LNRt8BOIjBv3xU6O5MQpFTY1UT3t8kuY6wGq0gLFLIhy9ojaP6Y+0fQ6jyBuWCV1oo3z
	GHpX8o8MGNn0nCCQ2bdoLJJuTaOSKZ8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-64-aWaOkawHNXiJ8eOqlKvnEw-1; Fri,
 29 May 2026 09:16:25 -0400
X-MC-Unique: aWaOkawHNXiJ8eOqlKvnEw-1
X-Mimecast-MFC-AGG-ID: aWaOkawHNXiJ8eOqlKvnEw_1780060584
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E6A02195609E;
	Fri, 29 May 2026 13:16:23 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.33.96])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C27E51800465;
	Fri, 29 May 2026 13:16:21 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [GIT PULL] RTLA changes for 7.2
Date: Fri, 29 May 2026 15:06:43 +0200
Message-ID: <20260529130643.3080315-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: 7AwSZ742nubh1PNRAD51arEnKm8_b3u2_acoKwJ38Mo_1780060584
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Steven,

The following changes since commit 5200f5f493f79f14bbdc349e402a40dfb32f23c8:

  Linux 7.1-rc4 (2026-05-17 13:59:58 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tglozar/linux.git tags/rtla-v7.2

for you to fetch changes up to db956bcf8d681b5a01ebe04c79f6a7b29b9934f9:

  rtla: Document tests in README (2026-05-29 09:40:54 +0200)

----------------------------------------------------------------
RTLA patches for v7.2

- Fix discrepancy in --dump-tasks option

Due to a mistake, rtla-timerlat-hist used the CLI syntax "--dump-task"
instead of the documented "--dump-tasks". Change the option to match
both documentation and the other timerlat tool, rtla-timerlat-top.

- Extend coverage of runtime tests

Cover both top and hist tools in all applicable test cases, add tests
for a few uncovered options, and extend checks for some existing tests.

- Add unit tests for actions

rtla's actions feature is implemented in its source file and contains
non-trivial parsing logic. Cover it with unit tests.

- Stop record trace on interrupt

Fix a bug where an interval exists after receiving a signal in which
the main instance is stopped but the record instance is not, leading to
discrepancies in reported results and sometimes rtla hanging.

- Restore continue flag in actions_perform()

Fix a bug where rtla always continues tracing after hitting a threshold
even if the continue action was triggered just once, and add tests
verifying that the flag is reset properly.

- Migrate command line interface to libsubcmd

Replace rtla's argument parsing using getopt_long() with libsubcmd, used
by perf and objtool, to reuse existing code and auto-generate better
help messages. Extensive unit tests are included to detect regressions.

- Add -A/--aligned option to timerlat tools

Add an option to align timerlat threads, based on the recently
introduced TIMERLAT_ALIGN option of the timerlat tracer, together with
unit tests and documentation.

- Document tests in README

Document how to run unit and runtime tests in rtla's README.txt,
including the dependencies needed to run them.

---

Two of the commits:
- 534d9a93dbff2 tools subcmd: support optarg as separate argument
- da62fc3458462 tools subcmd: allow parsing distinct --opt and --no-opt
do minor changes to libsubcmd code needed for rtla. libsubcmd does not
have a MAINTAINERS entry, but generally follows perf commit message
style, so I also followed that instead of the tracing subsystem style.

The tag was built and tested (make && make unit-tests && sudo make
check) on 7.1-rc5 kernel, the same was also done after test-merge into
next-20260528. No new issues were found.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>

----------------------------------------------------------------
Costa Shulyupin (1):
      tools/rtla: Fix --dump-tasks usage in timerlat

Crystal Wood (1):
      rtla: Stop the record trace on interrupt

Tomas Glozar (24):
      rtla/tests: Cover both top and hist tools where possible
      rtla/tests: Add get_workload_pids() helper
      rtla/tests: Check -c/--cpus thread affinity
      rtla/tests: Use negative match when testing --aa-only
      rtla/tests: Extend timerlat top --aa-only coverage
      rtla/tests: Cover all hist options in runtime tests
      rtla/tests: Add runtime test for -H/--house-keeping
      rtla/tests: Add runtime test for -k and -u options
      rtla/tests: Add runtime tests for -C/--cgroup
      rtla/tests: Add unit tests for actions module
      rtla/actions: Restore continue flag in actions_perform()
      rtla/tests: Add unit test for restoring continue flag
      rtla/tests: Run runtime tests in temporary directory
      rtla/tests: Add runtime tests for restoring continue flag
      rtla: Add libsubcmd dependency
      tools subcmd: support optarg as separate argument
      tools subcmd: allow parsing distinct --opt and --no-opt
      rtla: Parse cmdline using libsubcmd
      rtla/tests: Add unit tests for _parse_args() functions
      rtla/tests: Add unit tests for CLI option callbacks
      rtla/timerlat: Add -A/--aligned CLI option
      rtla/tests: Add unit tests for -A/--aligned option
      Documentation/rtla: Add -A/--aligned option
      rtla: Document tests in README

 Documentation/tools/rtla/common_appendix.txt       |   7 +-
 .../tools/rtla/common_timerlat_options.txt         |  11 +
 tools/lib/subcmd/parse-options.c                   |  63 +-
 tools/lib/subcmd/parse-options.h                   |   4 +
 tools/tracing/rtla/.gitignore                      |   3 +
 tools/tracing/rtla/Makefile                        |  66 +-
 tools/tracing/rtla/README.txt                      |  30 +
 tools/tracing/rtla/src/Build                       |   2 +-
 tools/tracing/rtla/src/actions.c                   |   2 +
 tools/tracing/rtla/src/cli.c                       | 539 +++++++++++++++
 tools/tracing/rtla/src/cli.h                       |   9 +
 tools/tracing/rtla/src/cli_p.h                     | 687 ++++++++++++++++++++
 tools/tracing/rtla/src/common.c                    | 128 +---
 tools/tracing/rtla/src/common.h                    |  36 +-
 tools/tracing/rtla/src/osnoise.c                   | 158 ++++-
 tools/tracing/rtla/src/osnoise.h                   |   6 +
 tools/tracing/rtla/src/osnoise_hist.c              | 221 +------
 tools/tracing/rtla/src/osnoise_top.c               | 200 +-----
 tools/tracing/rtla/src/rtla.c                      |  89 ---
 tools/tracing/rtla/src/timerlat.c                  |  29 +-
 tools/tracing/rtla/src/timerlat.h                  |   8 +-
 tools/tracing/rtla/src/timerlat_hist.c             | 317 +--------
 tools/tracing/rtla/src/timerlat_top.c              | 285 +-------
 tools/tracing/rtla/src/utils.c                     |  28 +-
 tools/tracing/rtla/src/utils.h                     |   9 +-
 tools/tracing/rtla/tests/engine.sh                 |  27 +
 tools/tracing/rtla/tests/hwnoise.t                 |   2 +-
 tools/tracing/rtla/tests/osnoise.t                 |  77 ++-
 .../rtla/tests/scripts/check-cgroup-match.sh       |  17 +
 tools/tracing/rtla/tests/scripts/check-cpus.sh     |   9 +
 .../rtla/tests/scripts/check-housekeeping-cpus.sh  |   4 +
 tools/tracing/rtla/tests/scripts/check-priority.sh |   8 +-
 .../tests/scripts/check-user-kernel-threads.sh     |  16 +
 .../rtla/tests/scripts/lib/get_workload_pids.sh    |  11 +
 tools/tracing/rtla/tests/timerlat.t                | 117 ++--
 tools/tracing/rtla/tests/unit/Build                |   8 +-
 tools/tracing/rtla/tests/unit/Makefile.unit        |   6 +-
 tools/tracing/rtla/tests/unit/actions.c            | 393 +++++++++++
 tools/tracing/rtla/tests/unit/cli_opt_callback.c   | 716 ++++++++++++++++++++
 tools/tracing/rtla/tests/unit/cli_params_assert.h  |  68 ++
 tools/tracing/rtla/tests/unit/osnoise_hist_cli.c   | 557 ++++++++++++++++
 tools/tracing/rtla/tests/unit/osnoise_top_cli.c    | 503 ++++++++++++++
 tools/tracing/rtla/tests/unit/timerlat_hist_cli.c  | 722 +++++++++++++++++++++
 tools/tracing/rtla/tests/unit/timerlat_top_cli.c   | 654 +++++++++++++++++++
 tools/tracing/rtla/tests/unit/unit_tests.c         | 120 +---
 tools/tracing/rtla/tests/unit/utils.c              | 106 +++
 46 files changed, 5591 insertions(+), 1487 deletions(-)
 create mode 100644 tools/tracing/rtla/src/cli.c
 create mode 100644 tools/tracing/rtla/src/cli.h
 create mode 100644 tools/tracing/rtla/src/cli_p.h
 delete mode 100644 tools/tracing/rtla/src/rtla.c
 create mode 100755 tools/tracing/rtla/tests/scripts/check-cgroup-match.sh
 create mode 100755 tools/tracing/rtla/tests/scripts/check-cpus.sh
 create mode 100755 tools/tracing/rtla/tests/scripts/check-housekeeping-cpus.sh
 create mode 100755 tools/tracing/rtla/tests/scripts/check-user-kernel-threads.sh
 create mode 100644 tools/tracing/rtla/tests/scripts/lib/get_workload_pids.sh
 create mode 100644 tools/tracing/rtla/tests/unit/actions.c
 create mode 100644 tools/tracing/rtla/tests/unit/cli_opt_callback.c
 create mode 100644 tools/tracing/rtla/tests/unit/cli_params_assert.h
 create mode 100644 tools/tracing/rtla/tests/unit/osnoise_hist_cli.c
 create mode 100644 tools/tracing/rtla/tests/unit/osnoise_top_cli.c
 create mode 100644 tools/tracing/rtla/tests/unit/timerlat_hist_cli.c
 create mode 100644 tools/tracing/rtla/tests/unit/timerlat_top_cli.c
 create mode 100644 tools/tracing/rtla/tests/unit/utils.c

