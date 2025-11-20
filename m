Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA15364E9E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Nov 2025 15:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763653063; cv=none; b=Rnr1Wn7NAMEIfEHKj57Ud/y26/3iKfyl4zXNovPFFEnxVEq2DHmMozSI87onbR2ygTY6UIPK5RdOWIbGnRgEJG1Yk0UptEW6DGeK3q+/gKA1WQUciD1TIZfRwf8ZkPslCVMyVZcpXWFcy5hjnBZel9Q0+62GsSuZ1ayOFR6pW7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763653063; c=relaxed/simple;
	bh=JTC8oRUdGxim6jJm2Y6GYnhxTXcQKgXxae11DQcUsk8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pSicCYIm9O0qXj55ODLJiox4X8niMr+PvtJeEkwKp1kd6ImcpwsUPHN1dAnKfwsj1EE4uwe/H+TMo9GJL+CscP8WKKAmn6ee92Enldh79nt5sto+IGTj3vE56WGENmewWYyOgeMPwWOMz9xH4qpSVCSyUPuCW82QwhTzECI06Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dPS+4lrb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dPS+4lrb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763653060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0dMVEmKj1UrHxWpSsEfkhwuLhFtVCQPIK8LQDbkAf1Y=;
	b=dPS+4lrbp4PWFKzpARqrgE6tmLOlJpne9D2KF1RcV8sDaL/bGFdv1Xioy2fkhqdC9+B5JQ
	oRo/NFw4QVqwijokQgaHVsMGbudqzv2FzL2aKujJrYNoVk+B9BfYvp48gKdqfp2Frvf/o3
	HbhpJRo+BhPPuorakoD0VWRjXTGK8IA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-2_OK6DWBN7eJGnbU3dS_zw-1; Thu,
 20 Nov 2025 10:37:37 -0500
X-MC-Unique: 2_OK6DWBN7eJGnbU3dS_zw-1
X-Mimecast-MFC-AGG-ID: 2_OK6DWBN7eJGnbU3dS_zw_1763653056
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3351E180048E;
	Thu, 20 Nov 2025 15:37:36 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.228])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F03F630044DB;
	Thu, 20 Nov 2025 15:37:33 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	John Kacur <jkacur@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [GIT PULL] RTLA updates for v6.19
Date: Thu, 20 Nov 2025 16:35:48 +0100
Message-ID: <20251120153548.176987-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Steven,

Please pull the following changes for RTLA. See the tag description for more
information.

Thanks,
Tomas

The following changes since commit 0d5077c73aceb51ef10d096160dd62a11db2f3e4:

  MAINTAINERS: Add Tomas Glozar as a maintainer to RTLA tool (2025-11-14 12:24:41 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tglozar/linux.git/ tags/rtla-v6.19

for you to fetch changes up to 368434d20d021aac8071bd08b1a471c588ce9ccd:

  rtla/timerlat: Exit top main loop on any non-zero wait_retval (2025-11-20 13:26:55 +0100)

----------------------------------------------------------------
RTLA patches for v6.19

Fixes and minor cleanups for RTLA, targetting v6.19 via
linux-trace tools/for-next:

- Add for_each_monitored_cpu() helper

  In multiple places, RTLA tools iterate over the list of CPUs running
  tracer threads.

  Use single helper instead of repeating the for/if combination.

- Remove unused variable option_index in argument parsing

  RTLA tools use getopt_long() for argument parsing. For its last
  argument, an unused variable "option_index" is passed.

  Remove the variable and pass NULL to getopt_long() to shorten
  the naturally long parsing functions, and make them more readable.

- Fix unassigned nr_cpus after code consolidation

  In recent code consolidation, timerlat tool cleanup, previously
  implemented separately for each tool, was moved to a common function
  timerlat_free().

  The cleanup relies on nr_cpus being set. This was not done in the new
  function, leaving the variable uninitialized.

  Initialize the variable properly, and remove silencing of compiler
  warning for uninitialized variables.

- Stop tracing on user latency in BPF mode

  Despite the name, rtla-timerlat's -T/--thread option sets timerlat's
  stop_tracing_total_us option, which also stops tracing on
  return-from-user latency, not only on thread latency.

  Implement the same behavior also in BPF sample collection stop tracing
  handler to avoid a discrepancy and restore correspondence of behavior
  with the equivalent option of cyclictest.

- Fix threshold actions always triggering

  A bug in threshold action logic caused the action to execute even
  if tracing did not stop because of threshold.

  Fix the logic to stop correctly.

- Fix few minor issues in tests

  Extend tests that were shown to need it to 5s, fix osnoise test
  calling timerlat by mistake, and use new, more reliable output
  checking in timerlat's "top stop at failed action" test.

- Do not print usage on argument parsing error

  RTLA prints the entire usage message on encountering errors in
  argument parsing, like a malformed CPU list.

  The usage message has gotten too long. Instead of printing it,
  use newly added fatal() helper function to simply exit with
  the error message, excluding the usage.

- Fix unintuitive -C/--cgroup interface

  "-C cgroup" and "--cgroup cgroup" are invalid syntax, despite that
  being a common way to specify an option with argument. Moreover,
  using them fails silently and no cgroup is set.

  Create new helper function to unify the handling of all such options
  and allow all of:

  -Xsomething
  -X=something
  -X something

  as well as the equivalent for the long option.

- Fix -a overriding -t argument filename

  Fix a bug where -a following -t custom_file.txt overrides the custom
  filename with the default timerlat_trace.txt.

- Stop tracing correctly on multiple events at once

  In some race scenarios, RTLA BPF sample collection might send multiple
  stop tracing events via the BPF ringbuffer at once.

  Compare the number of events for != 0 instead of == 1 to cover for
  this scenario and stop tracing properly.

The tag was tested on both a non-RT-tuned and an RT-tuned machine, and
no issues were found besides known cases of the flakiness of tests for
stack dump and auto-analysis, which rely on correct order of events.

The patchset mostly consists of fixes originally targetting one of
the v6.18-rcs rather than linux-next and the v6.19 merge window; one
of them is even Cc: stable. The delay was caused by maintainership
handover of RTLA.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>

----------------------------------------------------------------
Costa Shulyupin (8):
      tools/rtla: Add for_each_monitored_cpu() helper
      tools/rtla: Remove unused optional option_index
      tools/rtla: Fix unassigned nr_cpus
      tools/rtla: Add fatal() and replace error handling pattern
      tools/rtla: Replace timerlat_top_usage("...") with fatal("...")
      tools/rtla: Replace timerlat_hist_usage("...") with fatal("...")
      tools/rtla: Replace osnoise_top_usage("...") with fatal("...")
      tools/rtla: Replace osnoise_hist_usage("...") with fatal("...")

Crystal Wood (2):
      rtla/tests: Don't rely on matching ^1ALL
      rtla/timerlat: Exit top main loop on any non-zero wait_retval

Ivan Pravdin (2):
      rtla: Fix -C/--cgroup interface
      rtla: Fix -a overriding -t argument

Tomas Glozar (4):
      rtla/timerlat_bpf: Stop tracing on user latency
      tools/rtla: Fix --on-threshold always triggering
      rtla/tests: Extend action tests to 5s
      rtla/tests: Fix osnoise test calling timerlat

 Documentation/tools/rtla/common_options.rst |   2 +-
 tools/tracing/rtla/Makefile.rtla            |   2 +-
 tools/tracing/rtla/src/common.c             |  24 +++--
 tools/tracing/rtla/src/common.h             |   4 +
 tools/tracing/rtla/src/osnoise_hist.c       | 136 +++++++++----------------
 tools/tracing/rtla/src/osnoise_top.c        | 106 +++++++-------------
 tools/tracing/rtla/src/timerlat.bpf.c       |   3 +
 tools/tracing/rtla/src/timerlat.c           |  12 +--
 tools/tracing/rtla/src/timerlat_hist.c      | 148 +++++++++-------------------
 tools/tracing/rtla/src/timerlat_top.c       | 116 ++++++++--------------
 tools/tracing/rtla/src/timerlat_u.c         |  12 +--
 tools/tracing/rtla/src/utils.c              |  41 ++++++++
 tools/tracing/rtla/src/utils.h              |   2 +
 tools/tracing/rtla/tests/osnoise.t          |   6 +-
 tools/tracing/rtla/tests/timerlat.t         |   6 +-
 15 files changed, 247 insertions(+), 373 deletions(-)

