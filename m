Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5F63EE1F2
	for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Apr 2026 13:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776949571; cv=none; b=Cepkm7WjfmFLvherinNnUN1///2wios5wJ0CV3zERcZEslR8V5Erv+gGwoVJsblvOogzijFdlT0PM0HR3xcCksIVKK4NxDZIXZSb2ffTTW5EfDL8hFkirIip9hPOoQDbUOH9PWFyium074Pdmp40oUx2jdfMH1w/mQbrj9Mww74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776949571; c=relaxed/simple;
	bh=bErhPwJtC3k6B+veFzZ7MD++BBe8ZfIVOUEKpPY8Ix4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=ufRRb1rZgBPp1kYgaUnXUz92UwZwYbuw+jdyd3Hd492Pi/t7hClIVnXQY985oUF90Mu1sXRmLcVUrnEjbUi9F4oljz0VMDoAiSx6RdeImS3efWUqwRFLYIYqiUj29e9rx/vOO1wbzpRBLGJCCps4Jwn2ARs4+1Ps/+M5UlkNpGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VwgROWT7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VwgROWT7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776949569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5Gu7S5uQnBwkhg8dgiMV01s5iWC2mPTvA2R3srVlDyk=;
	b=VwgROWT7rwDHLZRZF5Phx4bsbyq7d3Iw4DM1n1R58wnM/3AuoOYNEu61jpwhHSAbZ8mrWV
	mHK1TwWTzD/Hls8BMs+JnBfvsp3aEQmjbKO0QGfgnh7KlwBnMhSiHHWXk5p/vjltTCVyWv
	fb4gpIArQkj9PZak+9CoTpirdQKzOEg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-676--ghvFFmyOwaIPbPSrlCv3g-1; Thu,
 23 Apr 2026 09:06:06 -0400
X-MC-Unique: -ghvFFmyOwaIPbPSrlCv3g-1
X-Mimecast-MFC-AGG-ID: -ghvFFmyOwaIPbPSrlCv3g_1776949565
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3256B195606E;
	Thu, 23 Apr 2026 13:06:05 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.109])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8D5031800906;
	Thu, 23 Apr 2026 13:06:02 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: [PATCH 0/9] rtla/tests: Extend runtime test coverage
Date: Thu, 23 Apr 2026 15:05:49 +0200
Message-ID: <20260423130558.882022-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: R4MgT5Z9xK3TOPSmCldj7jr9JHz53oFKmzor-oZKbws_1776949565
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This patchset introduces some new tests to cover more options, especially
histogram and thread options. Most of the new tests use positive and negative
output matches, sometimes in combination with action scripts, to verify that
RTLA is applying the settings correctly.

Tests were reorganized a little, adding two new sections: thread tests and
histogram tests, next to basic tests.

Additionally, coverage of existing tests is extended by adding new matches and
by extending tests to cover both top and hist tools where possible. For the
latter, new helpers check_top_hist and check_top_q_hist are added to engine.sh.

As part of the new action scripts, detection of measurement threads is made more
robust by following child processes of either RTLA (user workload) or kthreadd
(kernel workload) rather than grepping through the comms of all processes, which
might have lead to false positives.

These changes significantly improve test coverage and make the test suite more
against false positives from unrelated processes.

Tomas Glozar (9):
  rtla/tests: Cover both top and hist tools where possible
  rtla/tests: Add get_workload_pids() helper
  rtla/tests: Check -c/--cpus thread affinity
  rtla/tests: Use negative match when testing --aa-only
  rtla/tests: Extend timerlat top --aa-only coverage
  rtla/tests: Cover all hist options in runtime tests
  rtla/tests: Add runtime test for -H/--house-keeping
  rtla/tests: Add runtime test for -k and -u options
  rtla/tests: Add runtime tests for -C/--cgroup

 tools/tracing/rtla/tests/engine.sh            |  15 +++
 tools/tracing/rtla/tests/osnoise.t            |  73 +++++++----
 .../rtla/tests/scripts/check-cgroup-match.sh  |  17 +++
 .../tracing/rtla/tests/scripts/check-cpus.sh  |   9 ++
 .../tests/scripts/check-housekeeping-cpus.sh  |   4 +
 .../rtla/tests/scripts/check-priority.sh      |   8 +-
 .../scripts/check-user-kernel-threads.sh      |  16 +++
 .../tests/scripts/lib/get_workload_pids.sh    |  11 ++
 tools/tracing/rtla/tests/timerlat.t           | 113 +++++++++++-------
 9 files changed, 194 insertions(+), 72 deletions(-)
 create mode 100755 tools/tracing/rtla/tests/scripts/check-cgroup-match.sh
 create mode 100755 tools/tracing/rtla/tests/scripts/check-cpus.sh
 create mode 100755 tools/tracing/rtla/tests/scripts/check-housekeeping-cpus.sh
 create mode 100755 tools/tracing/rtla/tests/scripts/check-user-kernel-threads.sh
 create mode 100644 tools/tracing/rtla/tests/scripts/lib/get_workload_pids.sh

-- 
2.53.0

