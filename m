Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8726852759A
	for <linux-trace-kernel@vger.kernel.org>; Tue, 29 Sep 2026 12:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790686211; cv=none; b=cV3Nv3cLbrzI7aUNJDG7o/0zm29jUG/mwq9/lyuNSx4ebk7T/D4hsAjoG6D2NuHAgjaVAmA2EJ2DRuyFcOnPRhRPCG9MaDvBRvwXrsd3diOl4EyqOAXsfqamLGn5Cjgs0ROojNvyyLU1LlUnz6in89WhPqCEF+CPGBJrBcXkMpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790686211; c=relaxed/simple;
	bh=2SYqMc5nOHCEFqx9WfaxQSXoS7WaFQYjntXLjIkv8tM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=QDlmRB4iZ4Uulvn0HzIa+2vgFdEVazxulybVK1akt8Z/m8DagXuOdRRa0tJ5rtzxqcNHCKo/aeuRl5f3oGpjTIZwA9E6JCISK6PeqPhqIufsII5WUps0gmWc42kikMAOPpxSOnoezbSuQXku4JNyLDUfd/OPYiCfHZx9v7ca3HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NJHgsnD0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NJHgsnD0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790686208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wHaGMCXyIkGnoyaYh0LETmY8L2tC06QSukbAYMiiHTA=;
	b=NJHgsnD0patCpURaac2sppr5Wq5+91LMeowkYNyOSwulBBTC/5f/NWxqYZ5ewIpBOhF4wH
	s92nn4TmR5Tbt7DRo9chZt4aKzqKUZA46ORPyiYYNYfHNh3HvOMYNw0oQBqaRtEXPonX+a
	gttsdcA+TjOHuq76N5JkdfiTBjf4luI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-295-nU551zQzPlWUMxHpxtV9Qw-1; Tue,
 29 Sep 2026 08:50:02 -0400
X-MC-Unique: nU551zQzPlWUMxHpxtV9Qw-1
X-Mimecast-MFC-AGG-ID: nU551zQzPlWUMxHpxtV9Qw_1790686201
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1E4ED1802663;
	Tue, 29 Sep 2026 12:50:01 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ACF791956095;
	Tue, 29 Sep 2026 12:49:58 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Wen Yang <wen.yang@linux.dev>,
	Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 10/10] selftests/verification: Lower stressor priority in rv_deadline
Date: Tue, 29 Sep 2026 14:49:08 +0200
Message-ID: <20260929124908.177676-11-gmonaco@redhat.com>
In-Reply-To: <20260929124908.177676-1-gmonaco@redhat.com>
References: <20260929124908.177676-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: oOEKcKXT2oCg-bTnLbwCxPQaiwyMSnA5izOL_Cd7EF4_1790686201
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The rv_deadline selftest case runs a few stressors with Round-Robin
policy and priority 50 for 5 seconds. This may starve RCU callbacks and
timers on PREEMPT_RT, which results in splats, runtime replenishment
errors and (legit) model failures.

Lower the priority to 1 to allow ktimers and rcu threads (usually FF:1)
to run when they need to.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/testing/selftests/verification/test.d/rv_deadline.tc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/verification/test.d/rv_deadline.tc b/tools/testing/selftests/verification/test.d/rv_deadline.tc
index fc95267dbb82..5f57a3753f8a 100644
--- a/tools/testing/selftests/verification/test.d/rv_deadline.tc
+++ b/tools/testing/selftests/verification/test.d/rv_deadline.tc
@@ -8,8 +8,8 @@ load() { # returns true if there was a reaction
 	lines_before=$(dmesg | wc -l)
 	stress-ng --cpu 2 --sched deadline --sched-period 100000000 \
 		--sched-deadline 100000000 --sched-runtime 20000000 -t 5 &
-	stress-ng --cpu 2 --sched rr --sched-prio 50 --cyclic 1 \
-		--cyclic-policy rr --cyclic-prio 50 -t 5 &
+	stress-ng --cpu 2 --sched rr --sched-prio 1 --cyclic 1 \
+		--cyclic-policy rr --cyclic-prio 1 -t 5 &
 	wait
 	dmesg | tail -n +$((lines_before + 1)) | grep -q "rv: monitor [a-z]\+ does not allow event"
 }
-- 
2.55.0

