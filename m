Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8460E306B08
	for <linux-trace-kernel@vger.kernel.org>; Sat, 30 May 2026 14:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780150627; cv=none; b=GBoM5o9941dpHSyA66j0ETiXkTfOJ1b2uBolxLIXppdLVxdlekbcAoQpvEQfx+r18PWtuBIbv70p4brSM5L76H7FbP2EIHV5jlX/zq0T+B4s3kSg1hjemD1Mq99nZInpE1hRc7URnbqRODGwOA3HTUlSA61MzfoUvKwo4Eadzqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780150627; c=relaxed/simple;
	bh=pszbcYEsq//OiYCCHsvHwEvxJOtdPCbkTA8r8kgB3pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=BPfRmD5NP/iecdwQG59szTbTrneznP73m18piuvkWYYNYBOj5lwbZz7k1z4InYjD9WgAdhX4lMJ64zT9XjYQDUud5q7tQxb50dgaBaxElpn41VSLeU9elwSqaBG6lubPK6UFBxIi0VnV/J/FZ3tMYuqWgctkTFFApUl6d2tk+8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cI+ZKLoF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cI+ZKLoF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780150625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DLtoEvCNWgKdSfRoCmvaPssGV6PxlVLj7JwDVUvi37Q=;
	b=cI+ZKLoFVqJ+z83mVW/40odq5pI/GJlVroS2hv52vA0tTGY/N4U4kCUJiLQXJIUdYCu/Hj
	+0aeF7SDa9CEBmG7AfHSOPwlh8OWrsvHrCr4wzW4ZoTn7kgM0VBZMErK/aF+iprReb5SNE
	5KBhp8t2rnxVHLStuupzJWk3AhMZTmo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-MxRiYWTlM6iLOp91a73rEQ-1; Sat,
 30 May 2026 10:17:02 -0400
X-MC-Unique: MxRiYWTlM6iLOp91a73rEQ-1
X-Mimecast-MFC-AGG-ID: MxRiYWTlM6iLOp91a73rEQ_1780150620
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D7131956096;
	Sat, 30 May 2026 14:17:00 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BB6D030001BB;
	Sat, 30 May 2026 14:16:57 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>,
	Wen Yang <wen.yang@linux.dev>,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v3 01/13] rv: Fix __user specifier usage in extract_params()
Date: Sat, 30 May 2026 16:16:40 +0200
Message-ID: <20260530141652.58084-2-gmonaco@redhat.com>
In-Reply-To: <20260530141652.58084-1-gmonaco@redhat.com>
References: <20260530141652.58084-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: zv8mleurQXyCzKUE6sHUb7dUFUMoxTB1qu8w-W3Wi2o_1780150620
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The attributes variables extracted from syscalls in the helper are both
defined with the __user specifier although only the actual pointer to
user data should be marked.

Remove the __user specifier from attr.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202604150820.Ny143u6X-lkp@intel.com
Fixes: b133207deb72 ("rv: Add nomiss deadline monitor")
Reviewed-by: Wen Yang <wen.yang@linux.dev>
Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/trace/rv/monitors/deadline/deadline.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/rv/monitors/deadline/deadline.h b/kernel/trace/rv/monitors/deadline/deadline.h
index 0bbfd2543..78fca873d 100644
--- a/kernel/trace/rv/monitors/deadline/deadline.h
+++ b/kernel/trace/rv/monitors/deadline/deadline.h
@@ -95,7 +95,8 @@ static inline u8 get_server_type(struct task_struct *tsk)
 static inline int extract_params(struct pt_regs *regs, long id, pid_t *pid_out)
 {
 	size_t size = offsetofend(struct sched_attr, sched_flags);
-	struct sched_attr __user *uattr, attr;
+	struct sched_attr __user *uattr;
+	struct sched_attr attr;
 	int new_policy = -1, ret;
 	unsigned long args[6];
 
-- 
2.54.0

