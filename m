Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C7722D7A1
	for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Mar 2025 17:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742576918; cv=none; b=kTCM+o++eKQHgqYJsr0v6fMX0qo1ykb2EKpslNcxdYuTvEEkjhYYkoEn6k6853PoqFoRHjqRCqvrsy4MwKPaYlZMD9ZucCWNDJ5gg0oCpGdSyOg4UWa63+qpbrcpfbA2QZNWOPYVqzEGx4in3dulczcfKe+rgc5m9EZtl6ANiCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742576918; c=relaxed/simple;
	bh=9S4qEH3PVlnFOGK2lxW2awQ9ZZN4/6rIeDszBH+aXZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fMszXD2t++Ya23+tvxq6v6iH0ZU2R37GhzUeB9qAvswOjcKmIFvvC5kHsdDbMjp9CW8QiTDyRnwskrQ+jJWUl8E2ZqI9yYv4wzEZfNUjX5rAsiUPDkRoSQ5Tm06Z9iL8zeIPIlW1UgRDwGdnUHArighoWcgYxewFzc63dvRNf9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UgmCG7Jn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UgmCG7Jn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742576914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=N0hYg2vhPmp2fQhhtWVW+roP5z+OtzA4zuLIcnrampE=;
	b=UgmCG7JngsvgjI8Q011l+0Y9K5u1fK9+jH9oolOCWdrWT+taupvNRfjeXYSNwwZo8cWtUC
	Ev0H2BNnGr7NR9pFn0Pb+oo91KpuM/EQiyCSOPI1ErNdAJeMQ2NXVacU9mdT1k/lx2FJtQ
	T2e/0chXuCanJWqgE9DoPSMz6JmpZIE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-oDYfgOSTOdmU9Lb4PFJx2A-1; Fri,
 21 Mar 2025 13:08:33 -0400
X-MC-Unique: oDYfgOSTOdmU9Lb4PFJx2A-1
X-Mimecast-MFC-AGG-ID: oDYfgOSTOdmU9Lb4PFJx2A_1742576911
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E3EA195E92A;
	Fri, 21 Mar 2025 17:08:31 +0000 (UTC)
Received: from fedora.. (unknown [10.44.33.245])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0A81E3001D16;
	Fri, 21 Mar 2025 17:08:27 +0000 (UTC)
From: Gabriele Paoloni <gpaoloni@redhat.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Paoloni <gpaoloni@redhat.com>
Subject: [PATCH v2] tracing: fix return value in __ftrace_event_enable_disable for TRACE_REG_UNREGISTER
Date: Fri, 21 Mar 2025 18:08:21 +0100
Message-ID: <20250321170821.101403-1-gpaoloni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

When __ftrace_event_enable_disable invokes the class callback to
unregister the event, the return value is not reported up to the
caller, hence leading to event unregister failures being silently
ignored.

This patch assigns the ret variable to the invocation of the
event unregister callback, so that its return value is stored
and reported to the caller, and it raises a warning in case
of error.

Signed-off-by: Gabriele Paoloni <gpaoloni@redhat.com>
---
Changes from v1:
     Added WARN_ON_ONCE(ret) according to the feedbacks from
     v1 RFC [1]

[1] https://lore.kernel.org/linux-trace-kernel/20250314125725.6425-1-gpaoloni@redhat.com/T/#u
---
 kernel/trace/trace_events.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 513de9ceb80e..8e7603acca21 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -790,7 +790,9 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 				clear_bit(EVENT_FILE_FL_RECORDED_TGID_BIT, &file->flags);
 			}
 
-			call->class->reg(call, TRACE_REG_UNREGISTER, file);
+			ret = call->class->reg(call, TRACE_REG_UNREGISTER, file);
+
+			WARN_ON_ONCE(ret);
 		}
 		/* If in SOFT_MODE, just set the SOFT_DISABLE_BIT, else clear it */
 		if (file->flags & EVENT_FILE_FL_SOFT_MODE)
-- 
2.48.1

