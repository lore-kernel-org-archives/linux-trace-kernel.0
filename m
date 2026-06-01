Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAC03DE438
	for <linux-trace-kernel@vger.kernel.org>; Mon,  1 Jun 2026 15:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780328375; cv=none; b=Jfb7WT/4vpEuYT0r8W/zfHczRfwWDdq57ATQFKcM3VKlHrhQMHRtcvRCkpDwqUu3kEE35fd3/NE5W9X4BFsDovREJAEGIfPI3pDy8jYXwcsRlcOxDAQ2AQ4rpasadc0cYUkgDfNLqrukyyo5smkDVhZxKH/Cny5d8eorzZnQMy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780328375; c=relaxed/simple;
	bh=ANdFDagE1FI9L4ciaaW1zLEpqNlIYVOqb5rOO66ytYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=ZodSjKiZS1ybZe+TWoJfgDz4oBHcvKa5vpsgF7Mb1QZ9QY/Xz7mOSRzLp3Y4mGozN9po70IGZcQCEy9Uxq5BIAiYi/5kWdJVG0AHlaqf2+h5pAspUEOtKUNigIIIZzZBUhfMpACCGIjYtKkD95K0re5qoHkM5h9IWa7mNp/gnj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hE1f5Twq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hE1f5Twq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780328370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5rLOUc5HbPT/FYcWYXwCC9V4dfTGQw36C0sjysDza+o=;
	b=hE1f5TwqhD3DrIs6rxJcmtxeOx7VVzDRbZxcdOvDFyAzFULo/1OtjX0Zgk9RvzDMBgxvAy
	v4tsLfjTQ5yrlxtFIaomoW4zbXRbRDlRWB9BF8n6LQZOZqIgKfF5Du4D5lN5Y2ME6ed4LA
	gxCrYKMoxC9n20QF/6TWZvzUnJ5jNTY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171-xxXPe-vyMRinj0o79rqR3w-1; Mon,
 01 Jun 2026 11:39:26 -0400
X-MC-Unique: xxXPe-vyMRinj0o79rqR3w-1
X-Mimecast-MFC-AGG-ID: xxXPe-vyMRinj0o79rqR3w_1780328365
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 84C7C1956060;
	Mon,  1 Jun 2026 15:39:25 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BACDA18004A3;
	Mon,  1 Jun 2026 15:39:23 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org
Cc: Wen Yang <wen.yang@linux.dev>,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v4 12/13] rv: Fix read_lock scope in per-task DA cleanup
Date: Mon,  1 Jun 2026 17:38:39 +0200
Message-ID: <20260601153840.124372-13-gmonaco@redhat.com>
In-Reply-To: <20260601153840.124372-1-gmonaco@redhat.com>
References: <20260601153840.124372-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: hfNE9KtMrFhl70TT0Rwl7GcfLyP3K6rI_0X028s3Mkc_1780328365
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The da_monitor_reset_all() function for per-task monitors takes
tasklist_lock while iterating over tasks, then keeps it also while
iterating over idle tasks (one per CPU). The latter is not necessary
since the lock needs to guard only for_each_process_thread().

Use a scoped_guard for more compact syntax and adjust the scope only
where the lock is necessary.

Reviewed-by: Wen Yang <wen.yang@linux.dev>
Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/rv/da_monitor.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 34b8fba9e..08e5d0c59 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -334,12 +334,12 @@ static void __da_monitor_reset_all(void (*reset)(struct da_monitor *))
 	struct task_struct *g, *p;
 	int cpu;
 
-	read_lock(&tasklist_lock);
-	for_each_process_thread(g, p)
-		reset(da_get_monitor(p));
+	scoped_guard(read_lock, &tasklist_lock) {
+		for_each_process_thread(g, p)
+			reset(da_get_monitor(p));
+	}
 	for_each_present_cpu(cpu)
 		reset(da_get_monitor(idle_task(cpu)));
-	read_unlock(&tasklist_lock);
 }
 
 static void da_monitor_reset_all(void)
-- 
2.54.0

