Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E443E49D2
	for <linux-trace-kernel@vger.kernel.org>; Fri,  2 Oct 2026 16:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790959132; cv=none; b=t9ReoYQLUQlOmqdUhd3v74qmaZUkTepso20h+UXNTtppAy3YyGAC8yUX4HKah85TiyCnYBcI0d8DJkMYSFqTegBq+m82d5gykIyPv88/fhn+IoCI59/Uj0YRhK0S7cwcdQaLN9z0jNnJiehZD35Cx8XI6L0ek/8EwTHkVqbcFd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790959132; c=relaxed/simple;
	bh=9No86Q/EoD6DqTlvKzNVCMnr5bckUCGKftXvO+mgS3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=JfjUbvKbx7j0+vXXym2TKx3DzDQA8ce1oG+8jhJmjJuUqYOYnuOMm1yEqZ6dWj+mDoSz3wAKRQdT0L1+A0iBV6vEpRblhHKkKAq0Z4j8y2MIO0y6tWosq32RaUm7vAt3sHqv8lz5vwsaHdczIb+TT6fM0MYyzxUyiiuUA9jWGK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VK4JjoDX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VK4JjoDX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790959129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VoBn/EcwwjiTLNGiwDYqt+D4uMPJqPchOJxh3hBQgk0=;
	b=VK4JjoDXxO0WY6wf1GIWKm9Ejq5N9kEAoxx9WOIp2weiC3U9Jikg7sauIPMukf+oS1JKt7
	ER15fNe5KPRJ9dohBLKG/CeO3eGoadjrbT0cti3osLak1O1nRiH1jkima6sdt3ziQEEIxD
	aAma0w884Eq378jyfj7sbW+yVU1rZdM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-574-8E69i-PfO3KSfTx5CYfZkg-1; Fri,
 02 Oct 2026 12:38:48 -0400
X-MC-Unique: 8E69i-PfO3KSfTx5CYfZkg-1
X-Mimecast-MFC-AGG-ID: 8E69i-PfO3KSfTx5CYfZkg_1790959127
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EFFF91800BE2;
	Fri,  2 Oct 2026 16:38:46 +0000 (UTC)
Received: from tglozar-thinkpadt14gen5.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2035C433;
	Fri,  2 Oct 2026 16:38:44 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Crystal Wood <crwood@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [GIT PULL] RTLA changes for 7.4
Date: Fri,  2 Oct 2026 18:37:57 +0200
Message-ID: <20261002163757.3078413-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: gXYAASe02_4Li_GdsquK8afTx0RguFmk6sOEYpGWRgM_1790959127
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Steven,

The following changes since commit 93f51579e7df248780214094418f205253383cc5:

  Linux 7.3-rc4 (2026-09-20 13:48:15 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tglozar/linux.git tags/rtla-v7.4

for you to fetch changes up to 5ddc4497508a628b6c18653a0d5208edc6228aaf:

  rtla: Simplify osnoise tracer option setting code (2026-09-30 13:26:57 +0200)

----------------------------------------------------------------
RTLA patches for 7.4

- Test actions in absence of threshold

Cover the case which regressed in the past in tests.

- More robust CPU count detection

Parse /sys/devices/system/cpu/possible directly instead of going through
libc for CPU count and sanity check against any mismatch with the number
reported by tracefs / osnoise.

- Add option to record IPI count in osnoise top

In addition to counting IRQs, add an option to enable counting IPIs
targetting the measurement CPU to the rtla-osnoise-top tool.

- Improve runtime test usability

Catch up with increased complexity of runtime tests with better defaults
and more options available to the developer running the tests.

- Simplify osnoise tracer option setting code

Deduplicate osnoise tracer option setting code with macros to make it
less error-prone and to make it easier to add new tracer options in
the future.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>

----------------------------------------------------------------
Crystal Wood (3):
      rtla/tests: Use absolute path for $RTLA
      rtla/tests: Show the command line for failing tests
      rtla/tests: Add $SUBTESTS and $STOPONFAIL

Tomas Glozar (7):
      rtla/tests: Test actions in absence of threshold
      rtla: Replace get_nprocs_conf() with sysfs possible cpus
      rtla: Discard trace entries with cpu >= nr_cpus
      rtla: Abort on nr_cpus mismatch with tracer
      rtla/tests: Add unit test for cpu_list_iterate()
      rtla/tests: Add unit test for get_max_cpu_from_list()
      rtla: Simplify osnoise tracer option setting code

Valentin Schneider (8):
      rtla/osnoise: Add IPI tracking cmdline option
      rtla/osnoise: Record IPI count in osnoise top
      rtla/osnoise: Leverage IPI event filters when tracing a subset of CPUs
      rtla/osnoise: Allow IPI filters to gracefully fail
      rtla: Make struct trace_events double linked
      rtla: Enable and disable events in the user-defined order
      rtla: Unconditionally clean any pre-existing filters for user-provided events
      rtla/osnoise: Trace IPI events when recording a trace file

 Documentation/tools/rtla/common_options.txt   |    9 +-
 Documentation/tools/rtla/rtla-osnoise-top.rst |    4 +
 tools/tracing/rtla/src/cli.c                  |    1 +
 tools/tracing/rtla/src/cli_p.h                |    7 +-
 tools/tracing/rtla/src/common.c               |   31 +-
 tools/tracing/rtla/src/common.h               |  102 +-
 tools/tracing/rtla/src/osnoise.c              | 1291 ++++++++++---------------
 tools/tracing/rtla/src/osnoise.h              |   38 +-
 tools/tracing/rtla/src/osnoise_hist.c         |    1 +
 tools/tracing/rtla/src/osnoise_top.c          |  156 ++-
 tools/tracing/rtla/src/timerlat_hist.c        |    1 +
 tools/tracing/rtla/src/timerlat_top.c         |    1 +
 tools/tracing/rtla/src/trace.c                |   35 +-
 tools/tracing/rtla/src/trace.h                |    2 +
 tools/tracing/rtla/src/utils.c                |  181 +++-
 tools/tracing/rtla/src/utils.h                |    6 +
 tools/tracing/rtla/tests/engine.sh            |   23 +-
 tools/tracing/rtla/tests/osnoise.t            |    2 +
 tools/tracing/rtla/tests/timerlat.t           |    2 +
 tools/tracing/rtla/tests/unit/utils.c         |   71 ++
 20 files changed, 1049 insertions(+), 915 deletions(-)

