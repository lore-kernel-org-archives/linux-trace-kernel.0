Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31185370AD6
	for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Jul 2026 15:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784303363; cv=none; b=otB8lSQoSaw18DI7oA18CK/5qONu+4IVgcwhy8UcBlkILjzxEFoqHYZPfYuTSDjyc2x4vZworj0ybIJEWGUk8f2mNowAiqH/dRRATt/xFUGNCCiECZ20ZqXg7lopKv5twcb5kAZR62uFs18KbCLwCHSMaZ/Zs0EHFWUjHDusYB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784303363; c=relaxed/simple;
	bh=xXaIarO6met28YkseyNHcQizFWioTZjYEayWFFiF7no=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=tK9VlS/BjUomhmLZz3car5475HNXeXa1tT9z+zc1UeJwbJPxBJm/uslZrc6b7Ou4RMKU/4pdkvF/FuxryftXpFuCBiXBAwLaXWZv/xoVIuuDXnvVpjZgmXy5T8hxXP4PL9KSCeDRjAl5oKarWGfV0ejyvtAkr3+3KhNm8KW6LGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eLbwso3D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eLbwso3D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784303360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0rg8/odVrC6K+/oPHjo8skQzS2Qub6L3Pd7Jhfnd+C8=;
	b=eLbwso3D7dto4/kBXpaSDQ2M1zs9vqZDbA9syjYWxzVXmZb+tNEmX/SzS/unknEl7oMIgE
	UrJr0D3TwZvlC0SzAifqrHI3pldHxOvNlm9PZaMXetX9oeS7u+SJp4ABGh4gQ7Kn51+Utv
	j83U/vGU/vEuaVLqmJNZidUvpW7d8dE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-pakbyllvOf-seOnZHsrZPQ-1; Fri,
 17 Jul 2026 11:48:02 -0400
X-MC-Unique: pakbyllvOf-seOnZHsrZPQ-1
X-Mimecast-MFC-AGG-ID: pakbyllvOf-seOnZHsrZPQ_1784303281
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D83C1955DC5;
	Fri, 17 Jul 2026 15:48:01 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.local (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C37B630040BF;
	Fri, 17 Jul 2026 15:47:56 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Nam Cao <namcao@linutronix.de>,
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v4 11/17] rv: Export task monitor slot and react symbols
Date: Fri, 17 Jul 2026 17:46:32 +0200
Message-ID: <20260717154638.220789-12-gmonaco@redhat.com>
In-Reply-To: <20260717154638.220789-1-gmonaco@redhat.com>
References: <20260717154638.220789-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: FWWfb_1wjHEVNdPe1MOkm-65W96yHZvrcSF6SogFom8_1784303281
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Export rv_get_task_monitor_slot, rv_put_task_monitor_slot, and rv_react
to GPL modules so they can be accessed by KUnit and future monitors
built as kernel modules.

Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/trace/rv/rv.c          | 2 ++
 kernel/trace/rv/rv_reactors.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index ee4e68102f17..9d58c730821d 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -189,6 +189,7 @@ int rv_get_task_monitor_slot(void)
 
 	return -EINVAL;
 }
+EXPORT_SYMBOL_GPL(rv_get_task_monitor_slot);
 
 void rv_put_task_monitor_slot(int slot)
 {
@@ -205,6 +206,7 @@ void rv_put_task_monitor_slot(int slot)
 	task_monitor_count--;
 	task_monitor_slots[slot] = false;
 }
+EXPORT_SYMBOL_GPL(rv_put_task_monitor_slot);
 
 /*
  * Monitors with a parent are nested,
diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
index 460af07f7aba..2f5fc8d18dea 100644
--- a/kernel/trace/rv/rv_reactors.c
+++ b/kernel/trace/rv/rv_reactors.c
@@ -479,3 +479,4 @@ void rv_react(struct rv_monitor *monitor, const char *msg, ...)
 
 	va_end(args);
 }
+EXPORT_SYMBOL_GPL(rv_react);
-- 
2.55.0

