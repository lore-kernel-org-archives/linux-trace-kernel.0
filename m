Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A698B3EFD06
	for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Apr 2026 13:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776949585; cv=none; b=kwRpHq6fEGiFURAEt+2TA5wetd+huEMjYRGbU85pb7EzSGOjYD4dKpicVAtvhu41gBAxM3Oqz8gJLmi9NQGV9jjlmZYVMYBSqfHT3Du+LcyavJEk8Usq8hh96j+YxZkW2Ii7EES24eIN09K1cOfo96eG4WblFWt0yYFWq+TODE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776949585; c=relaxed/simple;
	bh=jH6RG8YyZF+X4kBZk0o3xliGCRgpWGl4DM2ooSO07HY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=ab2y8dFJrrxdHJ7KbCbAW/SYUHz6NtsQ0FyNPd2WoCkSUMO6nPLMQ660US/RN0f/Qtk6JGl4kSaL3xb1Up10T/hJLWQId9XMAWpLIjhJljoWWWlEyZqQGHbbDJhcK8tjD+x/oXVzpwyfwo5CJFk9RsTit6Dw152rtJVc4n6FPKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IpHpoFCO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IpHpoFCO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776949582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zHl+leK81oEVhfbrnLdSI2/cG4v6LOWTco08aMzksrE=;
	b=IpHpoFCOYXquPuz0NXCzk2kZHbZMBdmlhk05il74AsyYggKMEIVhmQP85uM7wtRoTqlHeH
	9sF8D3ccM4+bPeqJ69VtKrvECIe0+E93TQVVDgj2puM7qzxOw2OgGeO3MoCBZFECeFdFTh
	5IPeyV4U3Bn8y8fXXiXpf8CtVvxRNQI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-212-Qy2yHafEOyuXA_6oBgCr0g-1; Thu,
 23 Apr 2026 09:06:19 -0400
X-MC-Unique: Qy2yHafEOyuXA_6oBgCr0g-1
X-Mimecast-MFC-AGG-ID: Qy2yHafEOyuXA_6oBgCr0g_1776949578
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 734381800451;
	Thu, 23 Apr 2026 13:06:18 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.109])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 440161800348;
	Thu, 23 Apr 2026 13:06:16 +0000 (UTC)
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
Subject: [PATCH 5/9] rtla/tests: Extend timerlat top --aa-only coverage
Date: Thu, 23 Apr 2026 15:05:54 +0200
Message-ID: <20260423130558.882022-6-tglozar@redhat.com>
In-Reply-To: <20260423130558.882022-1-tglozar@redhat.com>
References: <20260423130558.882022-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: dOd4vLK87J0_Ni35md3itNvGD7y8Idw2dJL2vlXPxkU_1776949578
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

rtla-timerlat-top's --aa-only option is currently only tested for return
value.

Extend the tests to also check that only auto-analysis is being done via
a negative match for the "Timer Latency" text in the top header, and
further split the test case into two:

- one test case for --aa-only stopping on threshold
- one test case for --aa-only exiting without threshold being hit

For both cases, the expected output ("analyzing it" or "Max latency was"
respectively) is checked against in addition to the negative match.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/tests/timerlat.t | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/tracing/rtla/tests/timerlat.t b/tools/tracing/rtla/tests/timerlat.t
index f47a82c115c7..28c01d8b299d 100644
--- a/tools/tracing/rtla/tests/timerlat.t
+++ b/tools/tracing/rtla/tests/timerlat.t
@@ -35,8 +35,10 @@ check_top_hist "set the automatic trace mode" \
 	"timerlat TOOL -a 5" 2 "analyzing it"
 check_top_hist "dump tasks" \
 	"timerlat TOOL -a 5 --dump-tasks" 2 "Printing CPU tasks"
-check "print the auto-analysis if hits the stop tracing condition" \
-	"timerlat top --aa-only 5" 2
+check "verify --aa-only stop on threshold" \
+	"timerlat top --aa-only 5" 2 "analyzing it" "Timer Latency"
+check "verify --aa-only max latency" \
+	"timerlat top --aa-only 2000000 -d 1s" 0 "^  Max latency was" "Timer Latency"
 check_top_hist "disable auto-analysis" \
 	"timerlat TOOL -s 3 -T 10 -t --no-aa" 2 "" "analyzing it"
 check_top_q_hist "verify -c/--cpus" \
-- 
2.53.0

