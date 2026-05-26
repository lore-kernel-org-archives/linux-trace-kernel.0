Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19A93DD52C
	for <linux-trace-kernel@vger.kernel.org>; Tue, 26 May 2026 10:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779791151; cv=none; b=Qv5WmN0NOJUfF5uySFc6WK/R7yrkH18QQsbvO0D0glNtQg3LAX6RAtsaGHuxUYWE+7Pq0YqgwpggLEqcfu5+nKyqlOLyxxTmSOIFRIsFs36CnbVdhOTBaioFtMl73wl6Gb3UspvJyLCIAldqnd0DpeczA7/JUnrh/vPoKqIMBaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779791151; c=relaxed/simple;
	bh=yl/Fn0uYjHIo7SNNI8xk78Tc47S0BJNkemU8wKXYjwk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=HsPiWm/6ugNLpo9YaBfYaBHVTr7QGLsc56C1RK984Mo4/uytOq4cYzjNs+BQv6BbHGL9jMT+/HjZpgo/G6MzWf2OfKvTlQi1/3NJdrD1AWHuvR94UdB8waCBlRW5ZsGFGWaifbjBBsrec7PmYWwH3Xjzwr+BlIeh6cin0GExJFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=axNBXwq0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="axNBXwq0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779791148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mSyrzkEVrKYf/h5nCX5rJ7HJcosIbyv1A7npDmN1HTs=;
	b=axNBXwq0WvG30P/bwhuaIZjEF9eM3NkE0D002SLpVrD5Nzm57zrnxCHh0oFd9syzKoE+ZR
	SfqckV0n8+6OoXVzPHBNiegbxYvfT8Z53eRrvBiFvnHLc8R6l6bupnV55jNSYianDVaYZY
	D/7HJXST+16FEUB3IBgOxxc+y8gdhvY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-451-rFbA7PLvNFOGMI92FcTMIA-1; Tue,
 26 May 2026 06:25:45 -0400
X-MC-Unique: rFbA7PLvNFOGMI92FcTMIA-1
X-Mimecast-MFC-AGG-ID: rFbA7PLvNFOGMI92FcTMIA_1779791144
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 97EE2195605F;
	Tue, 26 May 2026 10:25:44 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.109])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2B7491956053;
	Tue, 26 May 2026 10:25:41 +0000 (UTC)
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
Subject: [PATCH 1/4] rtla/actions: Restore continue flag in actions_perform()
Date: Tue, 26 May 2026 12:25:20 +0200
Message-ID: <20260526102523.2662391-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: 7GTYjGUrNjsxtvgMOiqJhBmVsQvagLJWPUth5PcvsRs_1779791144
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Currently, actions_perform() only ever sets the continue flag (when
performing the continue action), but never resets it. That leads to
RTLA continuing tracing even if the continue action was not performed in
the current iteration.

For example, the following command:

$ rtla timerlat hist -T 100 --on-threshold shell,command='
    echo Spike!
    if [ -f /tmp/a ]
    then
      exit 1
    else
      touch /tmp/a
    fi' --on-threshold continue

should print Spike! at most once, because after hitting the threshold
for the first time, /tmp/a exists, the shell action will fail, and the
continue action is not performed. However, unless /tmp/a exists before
the measurement, it will print Spike! until stopped, as the continue
flag stays set.

Set the continue flag to false in the beginning of actions_perform() to
make RTLA continue only if the action was actually performed.

Fixes: 8d933d5c89e ("rtla/timerlat: Add continue action")
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/actions.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/tracing/rtla/src/actions.c b/tools/tracing/rtla/src/actions.c
index b0d68b5de08d..bf13d9d68f16 100644
--- a/tools/tracing/rtla/src/actions.c
+++ b/tools/tracing/rtla/src/actions.c
@@ -247,6 +247,8 @@ actions_perform(struct actions *self)
 	int pid, retval;
 	const struct action *action;
 
+	self->continue_flag = false;
+
 	for_each_action(self, action) {
 		switch (action->type) {
 		case ACTION_TRACE_OUTPUT:
-- 
2.54.0

