Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1C440BCBC
	for <linux-trace-kernel@vger.kernel.org>; Mon,  3 Aug 2026 15:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785769614; cv=none; b=ldAQeCBX2GmZfekIGptRQvTE+CTD9at0f4JgavC5LQi+Yi9lKwU6K3QiagAQ1qHt3fX9wrtuJvPb+L/yz7U8+72o3RvUmKyhdUu/7Y0Plr3Oac5PQr5JmwCZLfOSOBbQIX4i0PhX5aKrn3rwvB59g8xSQZ88Q5DQou4rk0d4vkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785769614; c=relaxed/simple;
	bh=MpO+pp2HiIWUjhzqCv/Lq5OWy9Yjn3b8JJ6qtSY7O9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=EWkr71v3HOZ6HN/U1jMGZFcJNzUa3D94hfC3zSYHDQ5wJOL/tw6yW7hQElYuGDWRGhp6dx0bAjKOig+sKpuJZRFZVBncs0NBgGKNd1At/XxFnXABaDL7ycivzEgF0oVTwybd7vPSEEFBOW+43Mbfek+WGTcttmPyVRfKGtdATV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BEtikFkL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BEtikFkL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785769612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ACvWihxYy/ul4bcXakvZISOJgaz8YCKLC49bix6yqKs=;
	b=BEtikFkLoGcSb49k6VKiBMFtVRyOvVGifRSEGuyqrjFTs2WvoGdjDsNlict49TAm28+qTi
	NJkySf+U1ZOI36WtPRUgzVyBBCbBIc5FTyoAgMSHA0H+G6ANfTkBwk9z+TGKAfs+HjfjOD
	hHtQ64gnUMJ9hegqX1HgzxwqxB6kNJ0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-163-OHSNcvpAOUmmzSagtCEN_Q-1; Mon,
 03 Aug 2026 11:06:49 -0400
X-MC-Unique: OHSNcvpAOUmmzSagtCEN_Q-1
X-Mimecast-MFC-AGG-ID: OHSNcvpAOUmmzSagtCEN_Q_1785769606
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9AC361800358;
	Mon,  3 Aug 2026 15:06:46 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3F40F180036E;
	Mon,  3 Aug 2026 15:06:44 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>
Subject: [PATCH] rv: Fix 32-bit build of nomiss KUnit test
Date: Mon,  3 Aug 2026 17:06:22 +0200
Message-ID: <20260803150622.322806-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: fygnxHOW3E3q1Sc1NiVq72XEbsPkb6iVL5s5TSBRJVQ_1785769606
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Commit 8da2a8838365 ("rv: Add KUnit tests for some DA/HA monitors")
introduced a division of a 64-bit value by 1000 in the nomiss KUnit
test. This does not compile on 32-bit systems, as standard division of
64-bit values leads to an undefined reference to __udivdi3.

Fix the build on 32-bit systems by using div_u64().

Fixes: 8da2a8838365 ("rv: Add KUnit tests for some DA/HA monitors")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202608020311.hYjqOG5k-lkp@intel.com
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/trace/rv/monitors/nomiss/nomiss_kunit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/rv/monitors/nomiss/nomiss_kunit.c b/kernel/trace/rv/monitors/nomiss/nomiss_kunit.c
index 1f64249dfcce..763129e2a990 100644
--- a/kernel/trace/rv/monitors/nomiss/nomiss_kunit.c
+++ b/kernel/trace/rv/monitors/nomiss/nomiss_kunit.c
@@ -28,7 +28,7 @@ static void rv_test_nomiss(struct kunit *test)
 	udelay(10);
 	rv_nomiss_ops.handle_sched_switch(NULL, 0, target, other, TASK_RUNNING);
 	RV_KUNIT_EXPECT_REACTION_HERE(test, ctx) {
-		udelay(15 + *rv_nomiss_ops.deadline_thresh / 1000);
+		udelay(15 + div_u64(*rv_nomiss_ops.deadline_thresh, 1000));
 		rv_nomiss_ops.handle_sched_switch(NULL, 0, other, target, TASK_RUNNING);
 	}
 }

base-commit: 984b5a36fd12d1849511a45fda32036fe2b0d004
-- 
2.55.0

