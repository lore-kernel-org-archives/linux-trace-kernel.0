Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF51E38E8CD
	for <linux-trace-kernel@vger.kernel.org>; Mon,  1 Jun 2026 09:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780305531; cv=none; b=p6g5oGg5sNnmdCDonKEqd7JN4eI4v8CghxWvE26sN1I7U+O311J+8snV+fU2AZtrVoJ35hGDMdwJj+8sPkeRUhqcUkLWYzS7v322CKah6WbW1m2qW4HpTCsJdHOstvtBsqEq1Ea4gjVjf/mQKJCo5FfPwEP8BsRZrOpTOCSnnHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780305531; c=relaxed/simple;
	bh=FOn32qhjq3GapkHJ0h9eyewyZNgxAwcKrrAhXuTQ3hY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=UiEJyRBRHYzmmZ9ihsZoR68yw2NvFZA3t6vwnjeXRbHEZU7AytduicXZ/mjnlUuTTSXmywdITcjgEMH1sOm5jpP/rm8RoeCPJBH5NL7GDCboKCa8IQ6wfnpBZxmwbcaq9rqC8NNwXJIeJCvEOQIYPqeC+HbfJdf5/YwpHDH1a6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xe8bWudB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xe8bWudB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780305528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GCYYo7SevwRXZqa6rCTN/iICemSOaNmdHSRjEYdJPAU=;
	b=Xe8bWudB+otXxjWj3svzeIZUUm7dmDMXermkfaZxPdj7dM6WlwuR2j6yJYz75QPoTMlGJv
	G2uRIgWZKg0s3QHQIKxOWUhPJFeyenHBDGsMMK+0e6UvDpHBCWQKRvPxjSFLSMrsggkTcG
	EsSUrL9PPhJB1S6QAX43dO2JD4T3STo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-iQrnbcBDObSDw5MCrvBHJg-1; Mon,
 01 Jun 2026 05:18:47 -0400
X-MC-Unique: iQrnbcBDObSDw5MCrvBHJg-1
X-Mimecast-MFC-AGG-ID: iQrnbcBDObSDw5MCrvBHJg_1780305526
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 32BD718005B9;
	Mon,  1 Jun 2026 09:18:46 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.109])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7BC4B1685;
	Mon,  1 Jun 2026 09:18:43 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] rtla: Fix and clean up .gitignore
Date: Mon,  1 Jun 2026 11:18:35 +0200
Message-ID: <20260601091835.3118094-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: SR4xxNUN2XfaHZFcjyHddbsdT74DvcUITP2B17GnDI4_1780305526
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

.gitignore includes several entries prone to unwanted matches in
subdirectories. One of them, the recently added "lib/", matches the
recently added directory "tests/scripts/lib/" in addition to the
intended top-level "lib/", which contains object files built from
sources in tools/lib.

Add "/" to all .gitignore entries that are intended to only match
top-level files or directories: rtla, rtla_static, unit_tests,
libsubcmd/.

Remove .gitignore entries that are not needed at all:

- lib/ (contains only object files, ignored by top-level .gitignore
  already).
- .txt rtla output files added to .gitignore in commit 02689ae385c5
  ("rtla: Add generated output files to gitignore"). Since commit
  ad5b50a0959f ("rtla/tests: Run runtime tests in temporary directory"),
  those are created in a temporary directory, not in tools/tracing/rtla.

Keeping libsubcmd/ as that contains other generated files (headers,
archives, etc.).

Fixes: 48209d763c22 ("rtla: Add libsubcmd dependency")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605291919.eszupseg-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202605300436.PqQ0Bc8q-lkp@intel.com/
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/.gitignore | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/tools/tracing/rtla/.gitignore b/tools/tracing/rtla/.gitignore
index c7b4bf1c8ba9..2a1c99ddd1bf 100644
--- a/tools/tracing/rtla/.gitignore
+++ b/tools/tracing/rtla/.gitignore
@@ -1,14 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0-only
-rtla
-rtla-static
-unit_tests
+/rtla
+/rtla-static
+/unit_tests
 fixdep
 feature
 FEATURE-DUMP
 *.skel.h
-custom_filename.txt
-osnoise_irq_noise_hist.txt
-osnoise_trace.txt
-timerlat_trace.txt
-libsubcmd/
-lib/
+/libsubcmd/
-- 
2.54.0

