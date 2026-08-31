Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8C23DD51C
	for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Aug 2026 09:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788167260; cv=none; b=LoZj4xVdNzX3tIgW8usbIU0s8ytYVk1HfXxl2l9XYl92Bt+ybzzhvgfDz3Mve400khuATQMoIyQq6jl+eu13Uxro+9ujbl15BPQS6tVTjNUUt+ctUy1510Jy7PlQCGJwNc037FFT2IHQVkrC7jFQf3c0As/9J4urKtZgYigyEDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788167260; c=relaxed/simple;
	bh=+qV67Ar596nvxR1LzpkF9oPPwr0qUM+QM87yOpwM8ik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=FClrUmNTjfPmv1wrHcE7ZsWumQCpXV8eOsRMh5iWjdjXACp/0vA8DuUH1ef2IbGsA1ygh8kAddh+NlC22JSQDwbx+aldpnC08WIpcwKj/ywwwNzJWyTLWLmUbLwR8ZKw5r+3RXmWS0H4FVoxSEpWImsXXxlXUUYg3vvkEU/JICo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iHczDFMj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iHczDFMj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788167257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cjis/B05Scr88Nzqwwo6UIDqHak36kTaKJ2jA+vrqPA=;
	b=iHczDFMj1LMlqItKKyHoDJtq7jbATOFaDP78UdEEZqSsT97SAN+fAKK2p19pd17wOKPKoT
	nVtAz9DV8RDqv3eDzqbHeTaD83xjWi6A3sxpMnyyJtYCYMOki0qasZazKVlQHFdmzXXndE
	v8VnKoK3cDhTfoLGIoqQO1etW8sWSZI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-538-cfPM8NB5NN6Ue5h7KqYHQw-1; Mon,
 31 Aug 2026 05:07:34 -0400
X-MC-Unique: cfPM8NB5NN6Ue5h7KqYHQw-1
X-Mimecast-MFC-AGG-ID: cfPM8NB5NN6Ue5h7KqYHQw_1788167252
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7ECEE1977503;
	Mon, 31 Aug 2026 09:07:32 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 42F0A18005BB;
	Mon, 31 Aug 2026 09:07:29 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Nam Cao <namcao@linutronix.de>,
	Wen Yang <wen.yang@linux.dev>,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	Viktor Malik <vmalik@redhat.com>
Subject: [RFC PATCH 09/20] rv: Handle unregistered monitors safely in tracefs
Date: Mon, 31 Aug 2026 11:05:13 +0200
Message-ID: <20260831090524.106845-10-gmonaco@redhat.com>
In-Reply-To: <20260831090524.106845-1-gmonaco@redhat.com>
References: <20260831090524.106845-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: fBD_P9jze8E1jSsbu8jYBMiVDzLpGtIj8oItQUHZzIo_1788167252
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

With the introduction of pluggable BPF monitors, a monitor can be
dynamically unregistered while its tracefs files are still open by a
userspace process. This leaves a dangling pointer in the tracefs file
descriptor's private_data.

Validate that the monitor pointer still exists in the rv_monitors_list
before dereferencing it during read/write operations and return an error
otherwise.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/trace/rv/rv.c          | 32 +++++++++++++++++++++++++++++---
 kernel/trace/rv/rv.h          |  1 +
 kernel/trace/rv/rv_reactors.c |  6 ++++++
 3 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index 33919c5fbd6a..6ddd3b92da1d 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -245,13 +245,31 @@ struct rv_monitor *rv_get_monitor_by_name(const char *name)
 /*
  * This section collects the monitor/ files and folders.
  */
+
+bool rv_is_monitor_registered(struct rv_monitor *mon)
+{
+	struct rv_monitor *m;
+
+	list_for_each_entry_rcu(m, &rv_monitors_list, list,
+				lockdep_is_held(&rv_interface_lock)) {
+		if (m == mon)
+			return true;
+	}
+	return false;
+}
+
 static ssize_t monitor_enable_read_data(struct file *filp, char __user *user_buf, size_t count,
 					loff_t *ppos)
 {
 	struct rv_monitor *mon = filp->private_data;
 	const char *buff;
 
-	buff = mon->enabled ? "1\n" : "0\n";
+	scoped_guard(rcu) {
+		if (!rv_is_monitor_registered(mon))
+			return -ENODEV;
+
+		buff = mon->enabled ? "1\n" : "0\n";
+	}
 
 	return simple_read_from_buffer(user_buf, count, ppos, buff, strlen(buff)+1);
 }
@@ -384,6 +402,9 @@ static ssize_t monitor_enable_write_data(struct file *filp, const char __user *u
 
 	guard(mutex)(&rv_interface_lock);
 
+	if (!rv_is_monitor_registered(mon))
+		return -ENODEV;
+
 	if (val)
 		retval = rv_enable_monitor(mon);
 	else
@@ -407,9 +428,14 @@ static ssize_t monitor_desc_read_data(struct file *filp, char __user *user_buf,
 	struct rv_monitor *mon = filp->private_data;
 	char buff[MAX_RV_DESCRIPTION_SIZE + 2];
 
-	memset(buff, 0, sizeof(buff));
+	scoped_guard(rcu) {
+		if (!rv_is_monitor_registered(mon))
+			return -ENODEV;
 
-	snprintf(buff, sizeof(buff), "%.*s\n", MAX_RV_DESCRIPTION_SIZE, mon->description);
+		memset(buff, 0, sizeof(buff));
+		snprintf(buff, sizeof(buff), "%.*s\n", MAX_RV_DESCRIPTION_SIZE,
+			 mon->description);
+	}
 
 	return simple_read_from_buffer(user_buf, count, ppos, buff, strlen(buff) + 1);
 }
diff --git a/kernel/trace/rv/rv.h b/kernel/trace/rv/rv.h
index 4d2c9cb284c9..6650ee9de308 100644
--- a/kernel/trace/rv/rv.h
+++ b/kernel/trace/rv/rv.h
@@ -28,6 +28,7 @@ int rv_enable_monitor(struct rv_monitor *mon);
 bool rv_is_container_monitor(struct rv_monitor *mon);
 bool rv_is_nested_monitor(struct rv_monitor *mon);
 struct rv_monitor *rv_get_monitor_by_name(const char *name);
+bool rv_is_monitor_registered(struct rv_monitor *mon);
 
 #ifdef CONFIG_RV_REACTORS
 int reactor_populate_monitor(struct rv_monitor *mon, struct dentry *root);
diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
index 2f5fc8d18dea..e23e0b5cc0ca 100644
--- a/kernel/trace/rv/rv_reactors.c
+++ b/kernel/trace/rv/rv_reactors.c
@@ -142,6 +142,9 @@ static int monitor_reactor_show(struct seq_file *m, void *p)
 	struct rv_monitor *mon = m->private;
 	struct rv_reactor *reactor = container_of(p, struct rv_reactor, list);
 
+	if (!rv_is_monitor_registered(mon))
+		return -ENODEV;
+
 	if (mon->reactor == reactor)
 		seq_printf(m, "[%s]\n", reactor->name);
 	else
@@ -235,6 +238,9 @@ monitor_reactors_write(struct file *file, const char __user *user_buf,
 
 	guard(mutex)(&rv_interface_lock);
 
+	if (!rv_is_monitor_registered(mon))
+		return -ENODEV;
+
 	list_for_each_entry(reactor, &rv_reactors_list, list) {
 		if (strcmp(ptr, reactor->name) != 0)
 			continue;
-- 
2.55.0

