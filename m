Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03207466B5B
	for <linux-trace-kernel@vger.kernel.org>; Wed,  3 Jun 2026 12:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780491126; cv=none; b=pdDEdomqawgVnNgLrLLzhmTEmxNSnpEqBbQ9T0nAwOqPyrS2gCdUzFwiQ6/rpEqataxfE9MOkkO2VIkL3Hxf4xru9uvZZMcRsy202KhV+peFvvTpAD6Y0g6rIXrHYVf+2H9fHKdEzCLnbZEyOPi0c/0cxeBtiSU0Oz4PFbA1tiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780491126; c=relaxed/simple;
	bh=hyyQkqmd24HNBfA2o++3tmaA+qjvcj/jKkxZywaY/9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=txQC32GA7+eDZeJGIw7hKJvdNvtgkdk3PrFynPzsX2NuYJX3fS14VThaCMbeANDXqxvx5ghwMnP+J4ANeYbunsxe518Pxp0B4iV+MsrOYPpsNyS0Vf6Ykkgjb5jGtOkve1cuZjwko1N68NXdwzOTBgP6BQ8xfYfNyAsFOGZQH1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ClLy+ZwW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ClLy+ZwW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780491124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mxQyKJJij/W1fw1cc7kWftOmSTgAMcT8hotC31l+0Ww=;
	b=ClLy+ZwWrKdBG1hdfQawSFcFRwH0hCln4sBasTKu9ZmOQ3ch3kVcoqvmklLwdHJjywvLHC
	xB0ZhDh7T/FukZUuBsrLpnw4ez1OEB5lQnQOGrfmyjSQ1MaxBRq0mQusSIb5RLgPgP9Vbx
	Dp/wc5ozDnnsLLQCcb375DdfIxVUHCM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-eGGfT31vN0WlqayqPy79fg-1; Wed,
 03 Jun 2026 08:52:00 -0400
X-MC-Unique: eGGfT31vN0WlqayqPy79fg-1
X-Mimecast-MFC-AGG-ID: eGGfT31vN0WlqayqPy79fg_1780491119
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4CBF4195608E;
	Wed,  3 Jun 2026 12:51:59 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6072A195E486;
	Wed,  3 Jun 2026 12:51:57 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org,
	Gabriele Monaco <gmonaco@redhat.com>,
	unknownbbqrx <dev@unknownbbqr.xyz>,
	Wen Yang <wen.yang@linux.dev>
Subject: [GIT PULL] rv fixes for v7.1
Date: Wed,  3 Jun 2026 14:50:56 +0200
Message-ID: <20260603125056.75559-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: z9kaFDcrPErXIJYNalPPSVRyquzKDtGT4xF1BcdWDyM_1780491119
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Steve,

The following changes since commit e43ffb69e0438cddd72aaa30898b4dc446f664f8:

  Linux 7.1-rc6 (2026-05-31 15:14:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gmonaco/linux.git rv-fixes-7.1

for you to fetch changes up to 44c2e91a684132ff0e47dc1f792bbdb42d64bd64:

  verification/rvgen: Fix ltl2k writing True as a literal (2026-06-03 13:20:58 +0200)

----------------------------------------------------------------
rv fixes for v7.1

Summary of changes:

- Fix reset ordering on per-task destruction

  Reset the task before dropping the slot instead of after, which was
  causing out-of-bound memory accesses.

- Fix HA monitor synchronization and cleanup

  Ensure synchronous cleanup for HA monitors by running timer callbacks
  in RCU read-side critical sections and using synchronize_rcu() during
  destruction.

- Avoid armed timers after tasks exit

  Add automatic cleanup for per-task HA monitors to prevent timers from
  firing after task exit.

- Fix memory ordering for DA/HA monitors

  Fix race conditions during monitor start by using release-acquire
  semantics for the monitoring flag.

- Fix initialization for DA/HA monitors

  Ensure monitors are not initialized relying on potentially corrupted
  state like the monitoring flag, that is not reset by all monitors type
  and may have an unknown state in monitors reusing the storage
  (per-task).

- Fix memory safety in per-task and per-object monitors

  Prevent use-after-free and out-of-bounds access by synchronizing with
  in-flight tracepoint probes using tracepoint_synchronize_unregister()
  before freeing monitor storage or releasing task slots.

- Adjust monitors for preemptible tracepoints

  Fix monitors that relied on tracepoints disabling preemption.
  Explicitly disable task migration when per-CPU monitors handle events
  to avoid accessing the wrong state and update the opid monitor logic.

- Fix incorrect __user specifier usage

  Remove __user from a non-pointer variable in the extract_params()
  helper.

- Fix bugs in the rv tool

  Ensure strings are NUL-terminated, fix substring matching in monitor
  searches, and improve cleanup and exit status handling.

- Fix several bugs in rvgen

  Fix LTL literal stringification, subparsers' options handling, and
  suffix stripping in dot2k.

----------------------------------------------------------------
Gabriele Monaco (15):
      rv: Fix __user specifier usage in extract_params()
      rv: Reset per-task DA monitors before releasing the slot
      rv: Prevent in-flight per-task handlers from using invalid slots
      rv: Ensure all pending probes terminate on per-obj monitor destroy
      rv: Do not rely on clean monitor when initialising HA
      rv: Add automatic cleanup handlers for per-task HA monitors
      rv: Ensure synchronous cleanup for HA monitors
      rv: Prevent task migration while handling per-CPU events
      rv: Use 0 to check preemption enabled in opid
      tools/rv: Fix substring match bug in monitor name search
      tools/rv: Fix substring match when listing container monitors
      tools/rv: Fix cleanup after failed trace setup
      verification/rvgen: Fix suffix strip in dot2k
      verification/rvgen: Fix options shared among commands
      verification/rvgen: Fix ltl2k writing True as a literal

Wen Yang (1):
      rv: Fix monitor start ordering and memory ordering for monitoring flag

unknownbbqrx (1):
      tools/rv: Ensure monitor name and desc are NUL-terminated

 include/rv/da_monitor.h                            | 139 +++++++++++++++++----
 include/rv/ha_monitor.h                            |  91 +++++++++++++-
 include/rv/ltl_monitor.h                           |   1 +
 kernel/trace/rv/monitors/deadline/deadline.h       |   3 +-
 kernel/trace/rv/monitors/nomiss/nomiss.c           |   4 +-
 kernel/trace/rv/monitors/opid/opid.c               |  12 +-
 kernel/trace/rv/monitors/stall/stall.c             |   4 +-
 tools/verification/rv/src/in_kernel.c              |  65 +++++-----
 tools/verification/rvgen/__main__.py               |  10 +-
 tools/verification/rvgen/rvgen/dot2k.py            |   4 +-
 tools/verification/rvgen/rvgen/ltl2ba.py           |   9 +-
 .../rvgen/rvgen/templates/dot2k/main.c             |   4 +-
 12 files changed, 263 insertions(+), 83 deletions(-)

To: Steven Rostedt <rostedt@goodmis.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Cc: unknownbbqrx <dev@unknownbbqr.xyz>
Cc: Wen Yang <wen.yang@linux.dev>

