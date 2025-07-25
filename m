Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AC11A2C11
	for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Jul 2025 13:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753450721; cv=none; b=IClEZR2ZUJXPkt0eEt4jOp1KpSb3zkhy7fSwsXUqlAQH0UaA+hhKFfLTlf0yifYKE9+ceUeGuWd6p56nDETPygI3VC1LstjEVC4DGKx1kvAqcDVhAqdN7KJJMM7EgTwjPsCtLxqFJccgNYeUwbIKJZbhuHO6ixoENHeIEtwrDy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753450721; c=relaxed/simple;
	bh=WB4vaJ8rA1rvCob9PBN3Peg1K4oEZTRtLGZr6RRUmQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k2KPtIRJLW9X6WOaV+RqGnNngSn8Vr7SULsX3i2Rtd6Y9ShkKwx9WhFpYpuxB6newGrMynfWCuA3z/8rYX5PsITTRBpb0KXSNnECWkkXVHQAefv+ziW5/4BXPJ5dXkbMHsKMderr4WVb6YnRjgfWq4Gc48zMgcTCfl9VrU5Ka8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HCeO5uQK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HCeO5uQK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753450718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aIbpoQy3CBFNVkU6NNRXvQ5vAjdz0FjWrCoZfSMM8lc=;
	b=HCeO5uQKjvZJjCIx0AZaqzRLcGHS3of23/hWjWaryGSTdNs9cRcERBpBqWTEIjRFTu5NqT
	FlQeIsd8VyZpapWFj3/jtRa7McQnxjuiGkI5GdWOfVHSX6sMTCqy8wi6yLOtdtAPoxttKu
	SvXQnXPqxrZR6QfymRHpgo/vjMCjJkg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-foQB_smnNKysHKDw7T1-Yg-1; Fri,
 25 Jul 2025 09:38:33 -0400
X-MC-Unique: foQB_smnNKysHKDw7T1-Yg-1
X-Mimecast-MFC-AGG-ID: foQB_smnNKysHKDw7T1-Yg_1753450712
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E6BB218001CA;
	Fri, 25 Jul 2025 13:38:31 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.89])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B40EF19560AA;
	Fri, 25 Jul 2025 13:38:28 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Chang Yin <cyin@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 0/2] rtla: Improve test coverage with output checking and actions
Date: Fri, 25 Jul 2025 15:38:15 +0200
Message-ID: <20250725133817.59237-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Recently added actions on threshold/end and checking output with "grep" in tests
enable more accurate testing.

Implement two additions: grep filters for base tests, and a new tests, using
action on threshold to verify if priority of timerlat thread is set correctly.

Tomas Glozar (2):
  rtla/tests: Add grep checks for base test cases
  rtla/tests: Test timerlat -P option using actions

 tools/tracing/rtla/tests/engine.sh                |  2 +-
 tools/tracing/rtla/tests/hwnoise.t                | 11 ++++++-----
 tools/tracing/rtla/tests/osnoise.t                |  6 +++---
 .../tracing/rtla/tests/scripts/check-priority.sh  |  8 ++++++++
 tools/tracing/rtla/tests/timerlat.t               | 15 +++++++++------
 5 files changed, 27 insertions(+), 15 deletions(-)
 create mode 100755 tools/tracing/rtla/tests/scripts/check-priority.sh

-- 
2.49.0

