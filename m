Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DA11F5407
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Dec 2024 14:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735310952; cv=none; b=rqYeDp3APb3Ra9sRxK1IlVnAzJtl3r+MNRf1CnpotrQiPns3cRDbObd7oL1fdajBQwRVN8p1V4bLQeRTJHVGLmGv53kL3Rs2wcd5wcBk9NAaJlGBJIWvx8KsX82jMS63P7LsCuLAoEvCtTYM8So7b/LM24EMSUaciCeRsXePW7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735310952; c=relaxed/simple;
	bh=97dCnuXAlmt+oirWqgXqXWMvfziNjb3FEzCcy3y2MeY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SNa48Go8S7bZIFCsQ4+yWWguuUcIDed7jwpavnhwQJfUwac9pIKRbTap+y8mZkHyKEnRBcAD9qeBu3k0/pWCV2CjgmWA2LTVJrFIy77HFQQEvB3zxfa1Q/uEP3SrtPSC9XG+LsNIWNgt8130nbvOH4FUJh4Jp7SJJkPRLExRTPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LtW/PYFL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LtW/PYFL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735310949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Vv5isfPbiQ4Np5jt9B/CgLIHyk8w1jwLtifdhggMdLg=;
	b=LtW/PYFLZLE9EsY4QR3zaMvLQ8uxHXGxj6KzbhjKF4UmoksWYwDAGqE/onhoPTZrX+fy3x
	x/xtRXtve+5t25wueIPVqSkoWg7S0JuIuaY+SMw9kkV47+uwjQaSL/N+bOwICwyiHOwSUr
	7UKNA1cx6mDkA1yT1n3VU0orZppA89o=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-137-GsyCfj2QMbifVMqeG_DXdg-1; Fri,
 27 Dec 2024 09:49:04 -0500
X-MC-Unique: GsyCfj2QMbifVMqeG_DXdg-1
X-Mimecast-MFC-AGG-ID: GsyCfj2QMbifVMqeG_DXdg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CB5111956056;
	Fri, 27 Dec 2024 14:49:03 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.39.192.164])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 43AB03000197;
	Fri, 27 Dec 2024 14:48:59 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH 0/8] rv: Automate manual steps in monitor creation
Date: Fri, 27 Dec 2024 15:47:44 +0100
Message-ID: <20241227144752.362911-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

While creating a new monitor in RV, besides generating code from dot2k,
there are a few manual steps which can be tedious and error prone, like
adding the tracepoints, makefile lines and kconfig, or selecting events
that start the monitor in the initial state.

This patchset tries to automate as much as possible among those steps to
make creating a new RV monitor much quicker. It is still required to
select proper tracepoints, this step is harder to automate in a general
way and, in several cases, would still need user intervention.

The first 3 patches are preparatory work around the templates.

Patch 1 fixes the template directory used if dot2k is not installed but
is run from the kernel tree (tools/verification/).

Patch 2 unifies the templates for the 3 monitor types to change them
easier.

Patch 3 makes the format used for variables replaced by the dot2k script
a bit more robust.

Patch 4 implements the already present -n and -D flags to set the
monitor name and description, respectively.

Patch 5 moves most of the monitor-specific code to the monitor directory
(tracepoints, Kconfig). The user still needs to manually fill some
content but the copy-paste-change is reduced.

Patch 6 adapts dot2k to produce monitors as defined in patch 5, adding
the necessary templates. Additionally, while printing the checklist,
dot2k also suggests what lines to add and where.

Patch 7 adds the possibility to further automate what is done in patch 5
and 6. If dot2k finds a valid kernel source and the -a flag is passed,
it automatically changes the files accordingly (RV Makefile, tracepoints
and Kconfig) and moves the new monitor folder in the final position.

Patch 8 allows to automatically select events that start the monitor, to
achieve this, the automata parser can now understand if there are events
that always lead to the initial state or are only valid in the initial
state. dot2k uses da_handle_start_event with the former and, as a
fallback, da_handle_start_run_event for the latter.

Gabriele Monaco (8):
  verification/dot2k: Fix template directory detection
  verification/dot2k: Unify main.c templates
  verification/dot2k: More robust template variables
  verification/dot2k: Add support for name and description options
  rv: Simplify manual steps in monitor creation
  verification/dot2k: Simplify manual steps in monitor creation
  verification/dot2k: Auto patch current kernel source
  verification/dot2k: Implement event type detection

 kernel/trace/rv/Kconfig                       |  27 +--
 kernel/trace/rv/Makefile                      |   3 +
 kernel/trace/rv/monitors/wip/Kconfig          |  12 +
 kernel/trace/rv/monitors/wip/wip.c            |   2 +-
 kernel/trace/rv/monitors/wip/wip_trace.h      |  15 ++
 kernel/trace/rv/monitors/wwnr/Kconfig         |  11 +
 kernel/trace/rv/monitors/wwnr/wwnr.c          |   2 +-
 kernel/trace/rv/monitors/wwnr/wwnr_trace.h    |  16 ++
 kernel/trace/rv/rv.c                          |   2 +-
 .../events/rv.h => kernel/trace/rv/rv_trace.h |  26 +-
 tools/verification/dot2/automata.py           |  36 ++-
 tools/verification/dot2/dot2c.py              |   4 +-
 tools/verification/dot2/dot2k                 |  17 +-
 tools/verification/dot2/dot2k.py              | 226 +++++++++++++++---
 .../verification/dot2/dot2k_templates/Kconfig |   6 +
 .../verification/dot2/dot2k_templates/main.c  |  91 +++++++
 .../dot2/dot2k_templates/main_global.c        |  91 -------
 .../dot2/dot2k_templates/main_per_cpu.c       |  91 -------
 .../dot2/dot2k_templates/main_per_task.c      |  91 -------
 .../verification/dot2/dot2k_templates/trace.h |  13 +
 20 files changed, 419 insertions(+), 363 deletions(-)
 create mode 100644 kernel/trace/rv/monitors/wip/Kconfig
 create mode 100644 kernel/trace/rv/monitors/wip/wip_trace.h
 create mode 100644 kernel/trace/rv/monitors/wwnr/Kconfig
 create mode 100644 kernel/trace/rv/monitors/wwnr/wwnr_trace.h
 rename include/trace/events/rv.h => kernel/trace/rv/rv_trace.h (79%)
 create mode 100644 tools/verification/dot2/dot2k_templates/Kconfig
 create mode 100644 tools/verification/dot2/dot2k_templates/main.c
 delete mode 100644 tools/verification/dot2/dot2k_templates/main_global.c
 delete mode 100644 tools/verification/dot2/dot2k_templates/main_per_cpu.c
 delete mode 100644 tools/verification/dot2/dot2k_templates/main_per_task.c
 create mode 100644 tools/verification/dot2/dot2k_templates/trace.h


base-commit: aef25be35d23ec768eed08bfcf7ca3cf9685bc28
-- 
2.47.1

