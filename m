Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01EB3D300F
	for <linux-trace-kernel@vger.kernel.org>; Thu,  1 Oct 2026 12:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790856796; cv=none; b=Qahb3w9SudYCyghhOT3qDlaF1WA4k9/Z5WLHiSCjZDNguvmDPh5+gKow982uvM/r23Rl3yzeQefukrRR8xArbVwCxUEW9IWiAavJHINLywcHBWt62qKzgNxXymipAXNz0izLQstj6f+l5sQljl2FC7jQMc+egJjEAzpPHb1gv1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790856796; c=relaxed/simple;
	bh=3AwjGRXGu8zT5eH6+ZoOQ3OcTZ/G7b/KTBaBFUCITTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=R5NPDI24GkCT4xf9Ak+D0IPzbcetAj19p/USiLkiwohoKglW50XQYrnJIuAeRVbNaBeU669L/yic+SZR+AYEUNsqrCW2PQwNE8RSsqlivapwpWPsrGvJAvnqdnMHVzkmfNVmtgC9g6zPmREQTNU2g9MuXot+CWZZGjTP9PPgJzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Thv3XS7u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Thv3XS7u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790856794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oJx64k3tpOWp6ewLW+ASrcp0fX+Z1KsGOTzisWPjMBg=;
	b=Thv3XS7ulGm6O9YfU7aH1lOHCG54aFoprHeZxyOCQuuLqdVrVhrqznFnIYr07/28yGDwm1
	rzMmlazDShPBydO5BhhVCnr/dBruSwCFPI4eM9aDeEXs/pd8PBDTaKWEjjfsK4oI//5CDt
	LfI7LMPLa57XQF4NjITXOTWhnJ8VV4M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-xA-WbZo3O5yy7uLXx2hwkQ-1; Thu,
 01 Oct 2026 08:13:08 -0400
X-MC-Unique: xA-WbZo3O5yy7uLXx2hwkQ-1
X-Mimecast-MFC-AGG-ID: xA-WbZo3O5yy7uLXx2hwkQ_1790856787
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 22788180A9A5;
	Thu,  1 Oct 2026 12:13:07 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 733B51800299;
	Thu,  1 Oct 2026 12:13:05 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org,
	Nam Cao <namcao@linutronix.de>,
	Wen Yang <wen.yang@linux.dev>
Subject: [GIT PULL] rv changes for v7.4 (for-next)
Date: Thu,  1 Oct 2026 14:12:19 +0200
Message-ID: <20261001121218.77078-2-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: rM5XGZn48Rk9Au-myuAUYOhEAs38RWHCymARUM32ibI_1790856787
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Steve,

The following changes since commit fd73f4a6659897191fa0d40695fe370925dd3780:

  Linux 7.3-rc3 (2026-09-13 14:38:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gmonaco/linux.git rv-7.4-next

for you to fetch changes up to 5e9bdf2924c9041ff1520b528db6104626e9ef41:

  rv/rtapp/wakeup: Use "rv_this" the rv_monitor variable (2026-10-01 13:59:46 +0200)

----------------------------------------------------------------
rv changes for v7.4 (for-next)

Summary of changes:

- Improve lockdep annotation for reactors

  Reactors are not supposed to take locks, so they fit the LD_WAIT_FREE
  lockdep class. However, reactors may run in preemptible context and
  if the preempting code (tick or simply the scheduler) takes locks, we
  see a lockdep splat. Switch to LD_WAIT_SPIN to avoid the splat while
  documenting that reactors should still not take locks.

- Add KUnit tests for reactors

  Add KUnit test cases to validate registration and reaction, this
  requires exporting some symbols and other minor fixes.

- Use the right rv_this variable in the wakeup monitor

  LTL monitors were updated to use the generic rv_this static variable
  but this change wasn't propagated to the newly introduced wakeup
  monitor. This broke reactors for the monitor: update the it.

----------------------------------------------------------------
Nam Cao (1):
      rv/rtapp/wakeup: Use "rv_this" the rv_monitor variable

Wen Yang (4):
      rv: Use LD_WAIT_SPIN as the reactor lockdep wait type
      rv: Propagate rv_register_reactor() error from reactor init
      rv: Export rv_register_reactor() and rv_unregister_reactor()
      rv: Add KUnit tests for reactor registration and dispatch

 kernel/trace/rv/Kconfig                  |  12 ++++
 kernel/trace/rv/Makefile                 |   1 +
 kernel/trace/rv/monitors/wakeup/wakeup.c |   6 +-
 kernel/trace/rv/reactor_panic.c          |   3 +-
 kernel/trace/rv/reactor_printk.c         |   3 +-
 kernel/trace/rv/rv_reactors.c            |  12 +++-
 kernel/trace/rv/rv_reactors_kunit.c      | 111 +++++++++++++++++++++++++++++++
 7 files changed, 140 insertions(+), 8 deletions(-)
 create mode 100644 kernel/trace/rv/rv_reactors_kunit.c

To: Steven Rostedt <rostedt@goodmis.org>
Cc: Nam Cao <namcao@linutronix.de>
Cc: Wen Yang <wen.yang@linux.dev>

