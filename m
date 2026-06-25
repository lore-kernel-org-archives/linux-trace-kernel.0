Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06453E0256
	for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Jun 2026 12:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782389735; cv=none; b=iAcNhiWPqfPUhUZ+2dUoYP/ob+1tWXU9/TXcuODfWHCXTbSTA2I+EXwjMXW6WtzFC6AzTujmGZudbRTeZyrM3jy4ZJe7yAQWIYg2fVJUckuQeHc3jasriOYvXf9e2GBSv2xx5eTGCbGki64Oec0L/7iAgkz3X3UuHBa0pFUNrPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782389735; c=relaxed/simple;
	bh=1/vSaP53PLdCrAbR6r+RfP7NsXmt7gUtPWtA02Wq4hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=HSW7gxVNwcU2Z6kL/WSDlnD2ecZsh7CxlLtdHui17ENYU3hU6ptgA3f+FrenZuGlZXyO/HmxsWpPWYdPp5xWVxZah2HSlRdi/gubSgIHqmYzeNeOqGYQyfYLUC+7yVIqVjjplzBluEEHvow1tF5WihuAcZDORGUGwaPai9PGjE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WimEpXPI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WimEpXPI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782389732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BBOriWxdKwhfkgRlwBP1vC/5tMxsYhubYeRJVs35gso=;
	b=WimEpXPIOTHzCy9lTZEGD+P5iEsAZ6QNAKg71TNw7XMh66rVyU9RgxIYAwzqSwElFjuqcm
	IkPeDfrQqbHzgBSXAK6fIkTsph7sSa/z0BUAvHRliT4Fd8Q4/LLFeqvG1UezgCykEr+CSr
	X1yea9oEVAWw63dzGgno2OAOJF6RDjI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-4L1fVsQGOkiD_IzpSXdFqw-1; Thu,
 25 Jun 2026 08:15:29 -0400
X-MC-Unique: 4L1fVsQGOkiD_IzpSXdFqw-1
X-Mimecast-MFC-AGG-ID: 4L1fVsQGOkiD_IzpSXdFqw_1782389727
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C16331809C8D;
	Thu, 25 Jun 2026 12:15:27 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0949C30002E0;
	Thu, 25 Jun 2026 12:15:24 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Nam Cao <namcao@linutronix.de>,
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v3 08/17] rv: Export task monitor slot and react symbols
Date: Thu, 25 Jun 2026 14:14:30 +0200
Message-ID: <20260625121440.116317-9-gmonaco@redhat.com>
In-Reply-To: <20260625121440.116317-1-gmonaco@redhat.com>
References: <20260625121440.116317-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: bwDJY-qr5MzBNEMgngNDTaGvww24iIzdedMn7Vv4GCM_1782389727
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Export rv_get_task_monitor_slot, rv_put_task_monitor_slot, and rv_react
to GPL modules so they can be accessed by KUnit and future monitors
built as kernel modules.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/trace/rv/rv.c          | 2 ++
 kernel/trace/rv/rv_reactors.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index f59385a24f..bb893bf4a2 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -192,6 +192,7 @@ int rv_get_task_monitor_slot(void)
 
 	return -EINVAL;
 }
+EXPORT_SYMBOL_GPL(rv_get_task_monitor_slot);
 
 void rv_put_task_monitor_slot(int slot)
 {
@@ -210,6 +211,7 @@ void rv_put_task_monitor_slot(int slot)
 	task_monitor_count--;
 	task_monitor_slots[slot] = false;
 }
+EXPORT_SYMBOL_GPL(rv_put_task_monitor_slot);
 
 /*
  * Monitors with a parent are nested,
diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
index 3435dcedc7..76c104f71d 100644
--- a/kernel/trace/rv/rv_reactors.c
+++ b/kernel/trace/rv/rv_reactors.c
@@ -486,3 +486,4 @@ void rv_react(struct rv_monitor *monitor, const char *msg, ...)
 
 	va_end(args);
 }
+EXPORT_SYMBOL_GPL(rv_react);
-- 
2.54.0

