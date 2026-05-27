Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206132E718F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 27 May 2026 07:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779866666; cv=none; b=lNkVkIBL62HTbH99L0VPdRqSsSZZoEhelyHG9E4mPhHZ5lk4H9jho/naxkOFDJYIcn13I3GDKJ9RIyY8lj3CqLdneep6JbhFGY1IWNWmZoYILw8nMBU+295IKPdpVpNG9Bo/CSXOosCjqNlbldBvoNe4r1ptDDGOKGd8K/CnE8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779866666; c=relaxed/simple;
	bh=yZD8BlIWibNDG3vNFFijxjWlLCkFemDXbhq9nyMYzNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=E+EdXRIR9YDxNYckWZMlOTAm6mmRMs4l5aeRXvM6kyOleMFhbFdVSi1Af296l8rLV5BXSQXr6+c0ckiH4dLObPtRk46JK/fubnMXZaPFk6YuX7ABC2v/r3iQNcho+jFQim6oQIi0aJb87X7GWXCnv7wDHASJ/ithhgHqubIqGbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ue1laDdk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ue1laDdk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779866664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BE4XyLT87Gg/bjycNNgnmr9xZqsrTBb+GlBCQ/isyoQ=;
	b=Ue1laDdkfDBPrSPaNayx6pzfxPrMXsmmsZzTy73FFHAcMqxBR4KN3NbxYIg6lVOJSn/za4
	NanTp5sNbmLhGr5Gyrf3Lg/FMlRTjKjb1V+H0pQdxFdF+MAI7lmmrD+a0/juM8J6aD+/Ms
	fXKzTRknHdhSeW1AFsR9//x3RLLr8Aw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-HTlYC6WbMy2mmvnldwO1fQ-1; Wed,
 27 May 2026 03:24:18 -0400
X-MC-Unique: HTlYC6WbMy2mmvnldwO1fQ-1
X-Mimecast-MFC-AGG-ID: HTlYC6WbMy2mmvnldwO1fQ_1779866657
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E79C3180044D;
	Wed, 27 May 2026 07:24:16 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.32.86])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D6F9C19560AB;
	Wed, 27 May 2026 07:24:13 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Wen Yang <wen.yang@linux.dev>,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH] rv: Use 0 to check for preemption enabled in opid
Date: Wed, 27 May 2026 09:24:07 +0200
Message-ID: <20260527072407.82062-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: oRBM9Q43OKE2okdcW6iKhXoEsKLfsgbP34wE_8GPXQ0_1779866657
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Since tracepoint handlers no longer run with preemption disabled by
default, the opid monitor should count 1 in the preemption count as
preemption disabled.

Change the rule for preempt_off to preempt > 0.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---

Forgot to add this commit to the fixes series. This is required since
opid was merged with the commits enabling preemption in tracepoints,
similarly to "rv: Prevent task migration while handling per-CPU events"

---
 kernel/trace/rv/monitors/opid/opid.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/kernel/trace/rv/monitors/opid/opid.c b/kernel/trace/rv/monitors/opid/opid.c
index 2922318c6112..3b6a85e815b8 100644
--- a/kernel/trace/rv/monitors/opid/opid.c
+++ b/kernel/trace/rv/monitors/opid/opid.c
@@ -22,14 +22,8 @@ static u64 ha_get_env(struct ha_monitor *ha_mon, enum envs_opid env, u64 time_ns
 	if (env == irq_off_opid)
 		return irqs_disabled();
 	else if (env == preempt_off_opid) {
-		/*
-		 * If CONFIG_PREEMPTION is enabled, then the tracepoint itself disables
-		 * preemption (adding one to the preempt_count). Since we are
-		 * interested in the preempt_count at the time the tracepoint was
-		 * hit, we consider 1 as still enabled.
-		 */
 		if (IS_ENABLED(CONFIG_PREEMPTION))
-			return (preempt_count() & PREEMPT_MASK) > 1;
+			return (preempt_count() & PREEMPT_MASK) > 0;
 		return true;
 	}
 	return ENV_INVALID_VALUE;

base-commit: 8bc67e4db64aa72732c474b44ea8622062c903f0
-- 
2.54.0

