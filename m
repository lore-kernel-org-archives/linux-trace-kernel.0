Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCEA31355D
	for <linux-trace-kernel@vger.kernel.org>; Wed, 27 May 2026 06:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779863025; cv=none; b=Nd/ylX85SRirl93F/1RAJf6TdHpnCm66sHv7jG/0HgfTLZ5ToRUm/uF5rEAIzLJ9wz1Lj9Q5yfwRtsGlZLarWpKVfACBs2ptB/WzGFI/3NseYWV8j9oJPHjO4vNCly2jpiDAE/1KKFTo2ij8m+h5EWK+pQ7BDt7lfatigN7lRAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779863025; c=relaxed/simple;
	bh=0WvukjNb7+6J250sUTZeFAglCempKiB453zxn8PCmiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=KeJwhoutRE2eywl10Bk3n3KV6wrrHSx8PxONT0MH5ypqwimdFzq0f951nOLQnIUhrpPVwknagyd4BXDfILD3gd7h9XWjzCGecamQKErNkwMDx5SaTVkvZgrBgF+KmLvxom3MzWKRok+9YETLYlThOQ1qUEABJq0FuWJpr6obnzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=glaFbR0p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="glaFbR0p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779863023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iXiwCnyMX/kUwxnsk5xQt1kVR84WvuI8YoIYMs0mVNw=;
	b=glaFbR0poB7O0FpfJyZ6pBKNZfR/N+YDml5D6xBkV3BGuba+Ci8qOQMXKRkniyKDGqlGhU
	c0qDbnf+6Vh9tSJXvex5PIsQaRmSs/CXCE26r53UNyfHyr5Wywmq446mfxCZV8zxeqM+HA
	q6ScQyiTgl79DcBuFZ9aM8faMe3dB/w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-134-Agvs4bcnM8moVnIvSbZu_g-1; Wed,
 27 May 2026 02:23:40 -0400
X-MC-Unique: Agvs4bcnM8moVnIvSbZu_g-1
X-Mimecast-MFC-AGG-ID: Agvs4bcnM8moVnIvSbZu_g_1779863019
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A8C5719560A5;
	Wed, 27 May 2026 06:23:38 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.32.86])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2272F1800465;
	Wed, 27 May 2026 06:23:35 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org
Cc: Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v2 02/12] rv: Fix read_lock scope in per-task DA cleanup
Date: Wed, 27 May 2026 08:23:02 +0200
Message-ID: <20260527062313.39908-3-gmonaco@redhat.com>
In-Reply-To: <20260527062313.39908-1-gmonaco@redhat.com>
References: <20260527062313.39908-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: uY-h3k6WCiNZPHjiEu8ZCWm4g4bzmgQwNjZGHHyhvxY_1779863019
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The da_monitor_reset_all() function for per-task monitors takes
tasklist_lock while iterating over tasks, then keeps it also while
iterating over idle tasks (one per CPU). The latter is not necessary
since the lock needs to guard only for_each_process_thread().

Use a scoped_guard for more compact syntax and adjust the scope only
where the lock is necessary.

Fixes: 30984ccf31b7f ("rv: Refactor da_monitor to minimise macros")
Fixes: 8259cb14a7068 ("rv: Reset per-task monitors also for idle tasks")
Reviewed-by: Wen Yang <wen.yang@linux.dev>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/rv/da_monitor.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 39765ff6f098..250888812125 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -272,12 +272,12 @@ static void da_monitor_reset_all(void)
 	struct task_struct *g, *p;
 	int cpu;
 
-	read_lock(&tasklist_lock);
-	for_each_process_thread(g, p)
-		da_monitor_reset(da_get_monitor(p));
+	scoped_guard(read_lock, &tasklist_lock) {
+		for_each_process_thread(g, p)
+			da_monitor_reset(da_get_monitor(p));
+	}
 	for_each_present_cpu(cpu)
 		da_monitor_reset(da_get_monitor(idle_task(cpu)));
-	read_unlock(&tasklist_lock);
 }
 
 /*
-- 
2.54.0

