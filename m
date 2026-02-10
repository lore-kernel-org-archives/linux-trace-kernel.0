Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4695331AF3B
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Feb 2026 11:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770723295; cv=none; b=DBQASlpMX3p7+VK2sW0yHo0240CuoJd15/W0Eo48uQvE6PC/IfjtcupBl/69JiQd86hCklQJbMf+hujsc+ZKIpdBl2juXvn69CqBPsTVUjHZTGM176wuXfoNmSqG4FCvDx4e3HUhTQ2b2pkhxNBz+onDcfrXFqx6G51fCym/Ric=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770723295; c=relaxed/simple;
	bh=0xU71SkOti3kTgJYWms4PrdcUYZl6h4meNUN5JHsWe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RPaOdbdNcK8T+ecafMiKz2t7yKAamtyGB56zsfo6wjW8uyf4vABK9xUGc6ft18LiFDQVnUnbF4WIP63c9jejmcMBD3Y5WgkhI5kF6V08ybddCCX95FbQpvdj9h0NZsT1wONSwZz92k3ivjrBkfMElEI+2iUU530bgB1rAw9hGV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=J/dVBla3; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="J/dVBla3"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47edd6111b4so80403215e9.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Feb 2026 03:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770723290; x=1771328090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+gbx0AbZEG5vm2vG4RENDj7vKJAZc/9+lYAtjtBx+1U=;
        b=J/dVBla3KNoFYhtkD8i84c5gP6OtQ4Qxfpc34jHQmWRcnP/2xDBM/p4C8TiKujKC3v
         8qv5AEhyV99IAdZ60NuRyASzUCj4hXYqfV9XChjwHYJVeN2EkPjtlVPdvrs65RcknSs0
         LD58ocEMgT30rKxnXmT68XLtJEmZzh4+G5PjEjStWPhbnjB7bVdLCmgiJ5A6LR9EAP8o
         hVRd+8pBy/2OcEPECB1bih583Mhxfj7V1ijZ0iu2nFiEiI5TJuGe2s0aKzksXVqzOfix
         Fqw9lhJb3Sd9lXjRFZySjJ5x6w4iB9KUSHfMRSbpTJirna0B60P+bsiWyr9iAQCqFj+F
         m59w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770723290; x=1771328090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+gbx0AbZEG5vm2vG4RENDj7vKJAZc/9+lYAtjtBx+1U=;
        b=VlmULr4Vkh1GHSZzDIXmVDLXFXES+DfoEWcpbr5A3lGgrVKXFDNcG3bV8tyZQ2X+0+
         UkE4m/Vj1iOMDN8uW07pgoB4Wpvs8pTkaJHrrauXpZE7TefBzG8ktI3+B9rL4jH97R2c
         oQ376bKVrxAfs0urSmt1cfu2Xax+4dwAWdl58dMZH1fV26uMzkV6fbfV2UtcYZQ6b7wq
         a70hoFynYShSKrZD9S1pXA65PMhMn8+pKkId1ihxrdsibvdP7/JX/x23MbWlGjxMPpNN
         LBJhN+Zn3fSNwwIb4oN31UQAJ2RSlsOdW/I//jipB06VMGVvuSWowUHaidvVk+VS9we7
         FbEg==
X-Forwarded-Encrypted: i=1; AJvYcCXrwBocbper7B03DKU/c2//5ChGI5mS+z9ydctuFIFwZmyQ1ejO21LbaLhf3WbEcrIZXBYDm3tswpjC5vA1nw+d00U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9P/kAiSlpH6F2esE/sfHbZS1OW/yFbE7jYb5LDZt8PYpXNfp+
	2r/rVliap7tcpga9Jw6HVKnpbeUPnMmJJj9p0h8QqQQCpr/rogNdNPbuMsM3nBv3Nws=
X-Gm-Gg: AZuq6aIHErIYNqYOEcoL4dZi90seNN6C18vn4SWUMkuA3Fg1olNRDPtfQxEikhPOowY
	+npXZezSYJMQ/F6dvTeG3jEVbvU6tBhKWw9q5YOGuhKYBsB/+PDtoAEfo0uyox6PkPZk8WNBrES
	fDZvV4pYBbvuKjTgmNfxsLN5Cn5UeTb7fSsd098DObaKY+oZsFz1xtOCKiZ4amqALQgHxpyeMiB
	EGoVxoZ91gEWX3PRJpoOMsqoUEFZ5Gc1ij3xQj9s/BSCdrjs/EQBnKWqUDHNL8D+TCYyiynCMAt
	mFt5FO/igJ5tKOiSzFzPr9f6FTz2Wz0dW2BUtEqVx6jllG8Azra3fXnmRQm0Vkdb/ICVCIbEY8c
	mCSIQHmujSWEEKRfVT0PCEq0ejdN6FarB7R80s+yZXOl88AY+LSi4fvkKf0WWWARlp77vi21Eu3
	xuoWW9emShy/ZFxkwkL7tHbBmUIUJdNY0SzkObM0SeBVPZ9bLr29o24ZREqHYIvBorp4jeoKNz+
	g6gP/PLeQCfBfVVm56sSBVe
X-Received: by 2002:a05:600c:c16b:b0:480:20f1:7abd with SMTP id 5b1f17b1804b1-4835082d1a3mr26387265e9.31.1770723289691;
        Tue, 10 Feb 2026 03:34:49 -0800 (PST)
Received: from zovi.suse.cz (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483209cfd77sm120182275e9.14.2026.02.10.03.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 03:34:49 -0800 (PST)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH 2/5] tracing: Fix checking of freed trace_event_file for id files
Date: Tue, 10 Feb 2026 12:28:17 +0100
Message-ID: <20260210113427.1068932-3-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260210113427.1068932-1-petr.pavlu@suse.com>
References: <20260210113427.1068932-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code for reading an event id currently uses file->f_inode->i_private to
store the value of trace_event_file->event_call->event.type, unlike all
other event files which use it to store a pointer to the associated
trace_event_file data. The event_id_read() function retrieves this id value
from i_private and checks if it is non-0/NULL to determine whether the
event is still valid. This approach worked in the past when
remove_event_file_dir() would set i_private to NULL for all files in an
event directory upon removal. However, with the introduction of eventfs,
i_private is assigned when an eventfs inode is allocated and remains set
throughout its lifetime. As a result, event_id_read() may fail to detect
that an event is being removed.

Fix this issue by changing the event id file to use i_private to store
a trace_event_file pointer and utilize event_file_file() to check for the
EVENT_FILE_FL_FREED flag.

Fixes: 6fdac58c560e ("tracing: Remove unused trace_event_file dir field")
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/trace/trace_events.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index e8ed6ba155cf..3d272b3cd688 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2090,11 +2090,18 @@ static int trace_format_open(struct inode *inode, struct file *file)
 static ssize_t
 event_id_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
 {
-	int id = (long)event_file_data(filp);
+	struct trace_event_file *file;
+	int id;
 	char buf[32];
 	int len;
 
-	if (unlikely(!id))
+	mutex_lock(&event_mutex);
+	file = event_file_file(filp);
+	if (likely(file))
+		id = file->event_call->event.type;
+	mutex_unlock(&event_mutex);
+
+	if (!file)
 		return -ENODEV;
 
 	len = sprintf(buf, "%d\n", id);
@@ -2572,7 +2579,9 @@ static const struct file_operations ftrace_event_format_fops = {
 
 #ifdef CONFIG_PERF_EVENTS
 static const struct file_operations ftrace_event_id_fops = {
+	.open = tracing_open_file_tr,
 	.read = event_id_read,
+	.release = tracing_release_file_tr,
 	.llseek = default_llseek,
 };
 #endif
@@ -2936,7 +2945,6 @@ static int event_callback(const char *name, umode_t *mode, void **data,
 	if (call->event.type && call->class->reg &&
 	    strcmp(name, "id") == 0) {
 		*mode = TRACE_MODE_READ;
-		*data = (void *)(long)call->event.type;
 		*fops = &ftrace_event_id_fops;
 		return 1;
 	}
-- 
2.52.0

