Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B9331328E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 27 May 2026 06:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779863033; cv=none; b=bdAP9FxJMC60kqPV5xu8SuiTeNLt4kPh+pQNOd2n3uDo7PUEFbFBw8ZBhyPOFmtBsPt1RxRcYfcF/KHMDMgGMYiSQ7rkOjWXN7PdzJy+SwG7HXgXquFt5zBPrmHmm5OiI9OjIaoGHhVGoyXCDl30sOjEg5cp4fx6D/AQZLO918I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779863033; c=relaxed/simple;
	bh=eikqB3Erq24n5lHU9BNiKCLEGJRJzBTNr2LoDc87s5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=rAh/iuzdomUG+JgDr4uPUysd88XJ92SQOSw/fdeYxHzAJMa3hJ5r8M971VjtvZJ1uaiPIrbv/EmCBk9gV5JoG7KmXz2ctFmtyYHmI/4vqtnu+dnyP3c+CTjVKGGnKd+v/Jz/+VGWPKko+irc7LNXpaSddxBzn7TUhWV0AQGMU70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TiKaUbbl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TiKaUbbl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779863027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LEdohwFEX/u4pMwStfP944VErCxUAuNDwNExysb2NsQ=;
	b=TiKaUbblKmkQ2nL6lMLvRUjlPMaiutc7BZmzwUTs6dJlfvz9v1CbBer4XsHn9PKt2cUxuM
	7R0KPcIZd06wahsPlLRnOva+bKmOka+UgJp5lJWAIz5kUkDsWRFW1pgeS3PIY4xLfOG3As
	mYLiXR08I0NN/yYr8oElZz1RuQWBiyM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-45-K865yf4JPVKtcAs8xQRkuw-1; Wed,
 27 May 2026 02:23:43 -0400
X-MC-Unique: K865yf4JPVKtcAs8xQRkuw-1
X-Mimecast-MFC-AGG-ID: K865yf4JPVKtcAs8xQRkuw_1779863022
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2BA161956080;
	Wed, 27 May 2026 06:23:42 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.32.86])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A90A01800465;
	Wed, 27 May 2026 06:23:39 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org
Cc: Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v2 03/12] rv: Reset per-task DA monitors before releasing the slot
Date: Wed, 27 May 2026 08:23:03 +0200
Message-ID: <20260527062313.39908-4-gmonaco@redhat.com>
In-Reply-To: <20260527062313.39908-1-gmonaco@redhat.com>
References: <20260527062313.39908-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: 6nPYr8RGT97UksysYCPPFWDkq5K6XQQ3NWHc5mHx-Ac_1779863022
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Per-task monitors use task_mon_slot to determine which slot in the array
to use for the monitor. During destruction, this slot is returned but
this is done before resetting the monitor. As a result, the monitor's
reset is in fact resetting a slot that is outside of the array
(RV_PER_TASK_MONITOR_INIT).

Release the slot only after the reset to avoid out-of-bound memory
access.

Fixes: f5587d1b6ec93 ("rv: Add Hybrid Automata monitor type")
Suggested-by: Wen Yang <wen.yang@linux.dev>
Reviewed-by: Wen Yang <wen.yang@linux.dev>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/rv/da_monitor.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 250888812125..0b7028df08fb 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -309,10 +309,11 @@ static inline void da_monitor_destroy(void)
 		WARN_ONCE(1, "Disabling a disabled monitor: " __stringify(MONITOR_NAME));
 		return;
 	}
-	rv_put_task_monitor_slot(task_mon_slot);
-	task_mon_slot = RV_PER_TASK_MONITOR_INIT;
 
 	da_monitor_reset_all();
+
+	rv_put_task_monitor_slot(task_mon_slot);
+	task_mon_slot = RV_PER_TASK_MONITOR_INIT;
 }
 
 #elif RV_MON_TYPE == RV_MON_PER_OBJ
-- 
2.54.0

