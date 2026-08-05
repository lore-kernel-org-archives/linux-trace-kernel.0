Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C69847D464
	for <linux-trace-kernel@vger.kernel.org>; Wed,  5 Aug 2026 15:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785943709; cv=none; b=Q8TSOD8d++s0KulppD0UhN8xMDthHZViGhCCLco8VJb8qqXeor8/oh4iBrOA9xgrywQ1J/5jPwAj/9vsbwGCaVmekmPkPKPs45EcQNblFAanjJRN6vERyMRd5rLNzSsz/J0+Y9QxNxkMMbGrCfLlfWLwiv7qzzBTyOMf0yi37Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785943709; c=relaxed/simple;
	bh=7P+95rV/TT2pjxEUWAqZlW3qZJwsQmHgEDFHcG7CoDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=pOZ+9uZj0L3GgsN4BgrQy1ap/htMVbqJBGrHCrg1jtH/69mfz7WVxFWCabCJEdjw6Gtfku4LxfH6v1XBapcqhgWMRhvH2YHPmb5oeOX/j9X/zw470YqiIezcrvXyh1BaypcvhYK3LMwbHkSQYpR4t9xCKvv7iC5z+KoiOKhTmwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aCDm9/ne; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aCDm9/ne"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785943693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ctK7/PVJVWRli4Y2LPB1zFtJQgnpw1xEyC0DTxTCzuA=;
	b=aCDm9/neQJPI+bj5GrJY9rbriExxCtiHNiXwWEDW00AkSJfiuijNC4C3nIgQVf6+t7gG7Z
	lNSGPn63QOk0vqebhKTkbhju3C0+PDsWrBqXbYqyFYKWsaAW+Qvc611h+kmA6tYFSI8Gju
	i90xRweRh1WqI9EerLd3JDwYNXXQQ74=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-417-scZsBcpfMnml1bp4lxmY4A-1; Wed,
 05 Aug 2026 11:28:05 -0400
X-MC-Unique: scZsBcpfMnml1bp4lxmY4A-1
X-Mimecast-MFC-AGG-ID: scZsBcpfMnml1bp4lxmY4A_1785943684
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 794D8180064C;
	Wed,  5 Aug 2026 15:28:04 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.39])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ADD8E19560AB;
	Wed,  5 Aug 2026 15:28:02 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [GIT PULL] RTLA changes for 7.3
Date: Wed,  5 Aug 2026 17:10:55 +0200
Message-ID: <20260805151055.870722-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: OX7-fg5pPwK_2a8r9179zEBolb4RoWFmpTM4Y4GEsYo_1785943684
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Steven,

The following changes since commit 075b74841bd0065a3bda3440873c747938e69b68:

  Linux 7.2-rc6 (2026-08-02 16:24:24 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tglozar/linux.git tags/rtla-v7.3

for you to fetch changes up to 0ad45018ace734e3a21c8b15280df65b429135d1:

  rtla/cli: Unify and improve handling of invalid option arguments (2026-08-05 10:14:40 +0200)

----------------------------------------------------------------
RTLA patches for 7.3

- Extend support for unsetting CLI options

libsubcmd auto-generates "--no-<option>" to unset options, provided
the option callback supports it. Implement this for RTLA CLI beyond
boolean options, and document the few exceptions that are left out.

- Test all tracer options in runtime tests

Verify that RTLA sets osnoise/timerlat options correctly by reading them
from tracefs during runtime tests.

- Improve range validation for option arguments

Make CLI range validation consistent with the kernel limits and unify
implementation and error messages between options.

- Improve invalid option argument parsing

Consistently reject invalid values for numeric option arguments with
a unified error message for all options.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>

----------------------------------------------------------------
Tomas Glozar (7):
      rtla: Allow unsetting non-list custom-callback CLI options
      rtla: Add unit tests for unset in opt callbacks
      rtla: Add unit tests for CLI with unset
      Documentation/rtla: Document unsetting options
      rtla/tests: Test all tracer options in runtime tests
      rtla/cli: Unify and improve range validation logic
      rtla/cli: Unify and improve handling of invalid option arguments

 Documentation/tools/rtla/common_appendix.txt       |  17 +
 Documentation/tools/rtla/common_options.txt        |  13 +-
 .../tools/rtla/common_osnoise_options.txt          |   4 +
 .../tools/rtla/common_timerlat_options.txt         |   4 +
 tools/tracing/rtla/src/cli.c                       |  42 +-
 tools/tracing/rtla/src/cli_p.h                     | 497 ++++++++++++-------
 tools/tracing/rtla/tests/engine.sh                 |  41 +-
 tools/tracing/rtla/tests/hwnoise.t                 |   3 +
 tools/tracing/rtla/tests/osnoise.t                 |  39 +-
 .../rtla/tests/scripts/check-osnoise-option.sh     |  16 +
 .../rtla/tests/scripts/check-tracefs-value.sh      |  11 +
 tools/tracing/rtla/tests/timerlat.t                |  40 +-
 tools/tracing/rtla/tests/unit/cli_opt_callback.c   | 534 ++++++++++++++-------
 tools/tracing/rtla/tests/unit/osnoise_hist_cli.c   |  18 +
 tools/tracing/rtla/tests/unit/osnoise_top_cli.c    |  18 +
 tools/tracing/rtla/tests/unit/timerlat_hist_cli.c  |  18 +
 tools/tracing/rtla/tests/unit/timerlat_top_cli.c   |  18 +
 17 files changed, 949 insertions(+), 384 deletions(-)
 create mode 100755 tools/tracing/rtla/tests/scripts/check-osnoise-option.sh
 create mode 100755 tools/tracing/rtla/tests/scripts/check-tracefs-value.sh

