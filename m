Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269C81369AA
	for <linux-trace-kernel@vger.kernel.org>; Fri,  4 Oct 2024 09:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728035459; cv=none; b=NuoPzFOFw3VXauZeJTMWC3eOmUAV+jxkuQhil5rGoDlyus/1gVNVaZwpa9Bc39Qz7uMIrQRVcik8sPO/sHSQJgyBmYcYe7z3nXiDTsEa3aMZaQQElz/VbICFp+LDiAlyYhsG/AOZRIVCJ9xQFWqUj/u2/Og+lxza/TrrV3FgCgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728035459; c=relaxed/simple;
	bh=gDrh7LmIfa6gh5zH1k80MRQGL+Fg2GkJtdw7cQnMFD8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l7Pa0yyQRlBWVNm/zDQNiC3n0+HIoKYTWdW0sTjR7q3O59Ff3cszKcMZzrdTeBO314hXkw9PznqD3izAgKhqkMl8BCvQp8/tbLI8qLk2fcs4TziXTBUnZ0Et8VdWIMR9mlhyZv4OwMKeRQfus39R7OIjSmFyESe44a27QO0x8BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b9rUsdgM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b9rUsdgM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728035456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x2d3VNvVfX1pcobZjVsoHMKRs2INBW88Oz7JLqrGNdA=;
	b=b9rUsdgMVn7AKt+zO9U7EGq37X/JEnJRgA1/U8PfUvE55T1QSUeTruNAQ+BoxQvb6LQZz9
	M5O+qK8Soob3BLqm7faOww0n8iEV4xGGCQORnRZFj8+PXchCXTYr/wy1ZaJXXXtNH+nkuc
	mpPb9T1YmRS+AJZjnmK7rAb7XGDZ2L0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-ejQiada3PuSRpkXCGntX3Q-1; Fri,
 04 Oct 2024 05:50:52 -0400
X-MC-Unique: ejQiada3PuSRpkXCGntX3Q-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B14271955EA5;
	Fri,  4 Oct 2024 09:50:51 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.176])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 659263000198;
	Fri,  4 Oct 2024 09:50:49 +0000 (UTC)
From: tglozar@redhat.com
To: rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jwyatt@redhat.com,
	jkacur@redhat.com,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH RESEND v3 0/6] rtla: Support idle state disabling via libcpupower in timerlat
Date: Fri,  4 Oct 2024 11:50:08 +0200
Message-ID: <20241004095014.2492813-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Tomas Glozar <tglozar@redhat.com>

rtla-timerlat allows reducing latency on wake up from idle by setting
/dev/cpu_dma_latency during the timerlat measurement. This has an effect on
the idle states of all CPUs, including those which are not used by timerlat.

Add option --deepest-idle-state that allows limiting the idle state only on cpus
where the timerlat measurement is running.

libcpupower is used to do the disabling of idle states via the corresponding
sysfs interface.

v2:
- Split patch adding dependency on libcpupower to two patches, one for
libcpupower detection and one for rtla libcpupower dependency.
- Make building against libcpupower optional. rtla will throw an error
when built without libcpupower and --deepest-idle-state is used.
- Rename option from --disable-idle-states to --deepest-idle-state and
add an argument to choose the deepest idle state the CPU is allowed to
get into. -1 can be used to disable all idle states: this is useful on
non-ACPI platforms, where idle state 0 can be an actual idle state with
an exit latency rather than a representation of an active CPU, as with the
ACPI C0 state.

Note: It is also possible to retrieve the latency for individual idle states
of a cpu by calling cpuidle_state_latency. This could be used to implement
another rtla option that would take the maximum latency, like --dma-latency
does, and which would only take effect on CPUs used by timerlat.

My opinion is that this proposed feature should not replace either
--dma-latency nor --deepest-idle-state. For the former, there might be
systems which have /dev/cpu_dma_latency but don't have a cpuidle
implementation; for the latter, in many cases the user will want to set
the idle state rather than the latency itself.

v3:
- Remove unneeded NULL check before free in restore_cpu_idle_disable_state
and free_cpu_idle_disable_states.
- Check for calloc() returning NULL in save_cpu_idle_disable_state.
- Check for saved_cpu_idle_disable_state existing in
restore_cpu_idle_disable_state.
- Implement dummy functions for libcpupower functionality if libcpupower is
not present during build. That allows libcpupower presence to be checked
through a special function at one place instead of using several #ifdefs.
- Only call sysconf() once when iterating through all CPUs. Note that there
are a few instances in the original code which keep on calling sysconf()
multiple times; fixing that is for another patch.

Tomas Glozar (6):
  tools/build: Add libcpupower dependency detection
  rtla: Add optional dependency on libcpupower
  rtla/utils: Add idle state disabling via libcpupower
  rtla/timerlat: Add --deepest-idle-state for top
  rtla/timerlat: Add --deepest-idle-state for hist
  rtla: Documentation: Mention --deepest-idle-state

 .../tools/rtla/common_timerlat_options.rst    |   8 +
 tools/build/Makefile.feature                  |   1 +
 tools/build/feature/Makefile                  |   4 +
 tools/tracing/rtla/Makefile                   |   2 +
 tools/tracing/rtla/Makefile.config            |  10 ++
 tools/tracing/rtla/README.txt                 |   4 +
 tools/tracing/rtla/src/timerlat_hist.c        |  42 ++++-
 tools/tracing/rtla/src/timerlat_top.c         |  42 ++++-
 tools/tracing/rtla/src/utils.c                | 150 ++++++++++++++++++
 tools/tracing/rtla/src/utils.h                |  13 ++
 10 files changed, 274 insertions(+), 2 deletions(-)

-- 
2.46.2

