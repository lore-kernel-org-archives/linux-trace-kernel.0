Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3391E32D6
	for <linux-trace-kernel@vger.kernel.org>; Wed, 27 May 2026 06:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779863022; cv=none; b=fvEof9l05XHRhR9XS+X67duFA451TKDNjnwiTqJrhNc1p3TuTycaZ7LYbkRQYKq57mhB2TIqz3Jbf/yWbFC45e3kdXZnEN9CV1QSuRaDYdAuVl7ekB3S65pmJXudP1emCB5xJk9dc332V2YXjpACvMR2kKS68x0zfz7X5sJ+DwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779863022; c=relaxed/simple;
	bh=/BQ/E0mDfOUgpiZiAckjd3M+EtXR2g3jD2R/osZBSkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=AVdKm5VBa2lgQFVJCdzV2gev5zanzGgOkibYBrmOyeYuBYVhYcCVWLJpUh8nRHFXiUFv4hRZLhnroENGAnJbGO3Vxw/dpCoHL1haXj5aOFR3RUfbGVsaGdrN5bb5BwOiXWDGrf878IftSAZ3j0xfdEvndct2nrKP5Mhu3BD5RI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ftFLgHzg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ftFLgHzg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779863020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4+lfnvHsemjEBYbRo7zqOy4YlMSao2Yfnsg9e7Il7LE=;
	b=ftFLgHzgGzxcWVwF58hndq6/+h8FJJvigdk81BDXFY6xIrEUfBLE/g4kFUz2p4Yo45iFhp
	So5raB2J6aD2INIBOfr7MSjT+a6BfHhZobiuW58EfxIVbiN+SDHvyiGNsZF1H76Jpqk6J3
	hOe+2+a1QQ96rVXxou1eALWoy7rC1RQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-rb85mRc2MUuNE8IRkhJjBQ-1; Wed,
 27 May 2026 02:23:36 -0400
X-MC-Unique: rb85mRc2MUuNE8IRkhJjBQ-1
X-Mimecast-MFC-AGG-ID: rb85mRc2MUuNE8IRkhJjBQ_1779863015
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0142E19560BB;
	Wed, 27 May 2026 06:23:35 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.32.86])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A5484180034E;
	Wed, 27 May 2026 06:23:31 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v2 01/12] rv: Fix __user specifier usage in extract_params()
Date: Wed, 27 May 2026 08:23:01 +0200
Message-ID: <20260527062313.39908-2-gmonaco@redhat.com>
In-Reply-To: <20260527062313.39908-1-gmonaco@redhat.com>
References: <20260527062313.39908-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: ip8D7gk-JfyUAz4XoI_sA4T2B7xAvydGKO7FqhFNF6M_1779863015
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
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/trace/rv/monitors/deadline/deadline.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/rv/monitors/deadline/deadline.h b/kernel/trace/rv/monitors/deadline/deadline.h
index 0bbfd2543329..78fca873d61e 100644
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

