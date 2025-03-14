Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414751C878E
	for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Mar 2025 12:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741957059; cv=none; b=i2iBUwKL9hg0mj9SXguMEJW3yh5MqLsJibQQ7DmVKK2D82rSBEbZ3iJB/83nXNnCcoE8ze/qE6X5y9cSEZqZ5yXvb89Duky9V0023luSrc/qKxcA9H0t1DdF6yFD/NGHRqdrBxgq4d5CfA5H0RHl0xVpcJ1oDVT4e1cxL1PVEfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741957059; c=relaxed/simple;
	bh=mD0ScLqQP2nX8l+BpGqppNLwRbdhi2adPqOAAVNbup8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PVZXwLg+zthTtubDOkhGaRyRA1FbUM4ZDici3weqw1lHruXKHNxBF0EyXNE1Kp8DxCpJ3zty6ynoPA7Rm8MpBSNCa1Uxb6u65HwKYZFqUliB2qIcDDfPK4Ix7ynUntrb815VneiVrZlov96lM4dE40T/abNpeWBQ/oI2oTw+oIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M6lRBxJJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M6lRBxJJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741957057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mIOT1kOj3A3TZR39PUq6iLDvDzsRB+WLpC5QiNfE6mw=;
	b=M6lRBxJJuQv1f0tM8d4wxMWjTSLia+qiR+prII3XzzVS0EoeYDUvCskAdtuBH5F3PWdM29
	2qSOM7MteOM9lRq6mjgPwSmAmliO6QMJiMBo3TgL7iN20k7xER+5j5VFGdltVgMrcfQq6S
	p6N7suVNoc1d9eslqpogisb1PRsO3YE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-306-NbIWzVfiNC2mrJKU6oD8gw-1; Fri,
 14 Mar 2025 08:57:34 -0400
X-MC-Unique: NbIWzVfiNC2mrJKU6oD8gw-1
X-Mimecast-MFC-AGG-ID: NbIWzVfiNC2mrJKU6oD8gw_1741957052
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B6DD180035E;
	Fri, 14 Mar 2025 12:57:32 +0000 (UTC)
Received: from fedora.. (unknown [10.45.225.79])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1BEB81954B3C;
	Fri, 14 Mar 2025 12:57:29 +0000 (UTC)
From: Gabriele Paoloni <gpaoloni@redhat.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Paoloni <gpaoloni@redhat.com>
Subject: [RFC PATCH] tracing: fix return value in __ftrace_event_enable_disable for TRACE_REG_UNREGISTER
Date: Fri, 14 Mar 2025 13:57:25 +0100
Message-ID: <20250314125725.6425-1-gpaoloni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

When __ftrace_event_enable_disable invokes the class callback to
unregister the event, the return value is not reported up to the
caller, hence leading to event unregister failures being silently
ignored.

This patch assigns the ret variable to the invocation of the
event unregister callback, so that its return value is stored
and reported to the caller.

Signed-off-by: Gabriele Paoloni <gpaoloni@redhat.com>
---
Sending this as RFC since I am not sure if checking the ret
value is really needed.
I have been mainly driven by the implementation of
disable_trace_kprobe, disable_trace_fprobe,
tracepoint_probe_unregister, disable_trace_eprobe that can
return an error.

 kernel/trace/trace_events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 513de9ceb80e..8d92b271ce0d 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -790,7 +790,7 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 				clear_bit(EVENT_FILE_FL_RECORDED_TGID_BIT, &file->flags);
 			}
 
-			call->class->reg(call, TRACE_REG_UNREGISTER, file);
+			ret = call->class->reg(call, TRACE_REG_UNREGISTER, file);
 		}
 		/* If in SOFT_MODE, just set the SOFT_DISABLE_BIT, else clear it */
 		if (file->flags & EVENT_FILE_FL_SOFT_MODE)
-- 
2.48.1

