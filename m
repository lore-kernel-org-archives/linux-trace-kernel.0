Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029C0235070
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Jun 2025 10:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749725050; cv=none; b=rVRHpC/ZmjPC5SwEQGKvYgOEZjeHHpLhJfGpxn7TtTAUYRMhe/0FxYzMRD3AH08d1KrjGmwtKooeBZRC28EyZ58OdWddI6qlrnApKMhSbG3N9iMp36joqsbbMiRQBHphkrVOey6ssCwnPntiD0As445TVEEdgibK/ywHgkWjM3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749725050; c=relaxed/simple;
	bh=NjET1/I4O6qCg36+3IxGKU8QMjap42X3AuiGirl/J5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YivWMD8v4I/l8XOYfzcK8glr5hTkiq6YMmfOJ1c0z9n25kfMXIqx5GhuCuiaGa/Zmo5PYVwxDtN8yL1mS5g9Te1xVsk/j41oajIr6FD/wl+YvbflvmGzuRpzz9OFbYhjT5JeNYlNBpFnNCsXlMmW2Xr2Yu0RKeFEi19eCkDWOnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TRTEZczV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TRTEZczV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749725046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SyzDax2CaJs/CotN5bZehEF7cSARdOrtLu036UBz6Qk=;
	b=TRTEZczVYrLszR1qLKmyyUEMrGiS/2qMbGDbnvDClSi4826XnQIjrSSYFwqZ66TJYx0fbk
	CMmd/Ic6/BgBKG19l4IpPtzs7k4d400DFtLoClqnjMPiM23o2UDE6fuhh8IE8BmWgK4/gm
	d0SbHQE9mj+aGrKt9fUYROWTJbhq4HA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-suRnNhvqPFC6gSG21ZKhWg-1; Thu,
 12 Jun 2025 06:44:05 -0400
X-MC-Unique: suRnNhvqPFC6gSG21ZKhWg-1
X-Mimecast-MFC-AGG-ID: suRnNhvqPFC6gSG21ZKhWg_1749725044
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 98C0F180029E;
	Thu, 12 Jun 2025 10:44:04 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.242.17])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7828C19560B2;
	Thu, 12 Jun 2025 10:44:01 +0000 (UTC)
From: Gabriele Paoloni <gpaoloni@redhat.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: acarmina@redhat.com,
	chuck.wolber@boeing.com,
	Gabriele Paoloni <gpaoloni@redhat.com>
Subject: [RFC PATCH 1/2] tracing: fixes of ftrace_enable_fops
Date: Thu, 12 Jun 2025 12:43:48 +0200
Message-ID: <20250612104349.5047-2-gpaoloni@redhat.com>
In-Reply-To: <20250612104349.5047-1-gpaoloni@redhat.com>
References: <20250612104349.5047-1-gpaoloni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Currently there are different issues associated with ftrace_enable_fops
- event_enable_write: *ppos is increased while not used at all in the
  write operation itself (following a write, this could lead a read to
  fail or report a corrupted event status);
- event_enable_read: cnt < strlen(buf) is allowed and this can lead to
  reading an incomplete event status (i.e. not all status characters
  are retrieved) and/or reading the status in a non-atomic way (i.e.
  the status could change between two consecutive reads);
- .llseek is set to default_llseek: this is wrong since for this
  type of files it does not make sense to reposition the ppos offset.
  Hence this should be set instead to noop_llseek.

This patch fixes all the issues listed above.

Signed-off-by: Gabriele Paoloni <gpaoloni@redhat.com>
Tested-by: Alessandro Carminati <acarmina@redhat.com>
---
 kernel/trace/trace_events.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 120531268abf..5e84ef01d0c8 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1798,6 +1798,13 @@ event_enable_read(struct file *filp, char __user *ubuf, size_t cnt,
 
 	strcat(buf, "\n");
 
+	/*
+	 * A requested cnt less than strlen(buf) could lead to a wrong
+	 * event status being reported.
+	 */
+	if (cnt < strlen(buf))
+		return -EINVAL;
+
 	return simple_read_from_buffer(ubuf, cnt, ppos, buf, strlen(buf));
 }
 
@@ -1833,8 +1840,6 @@ event_enable_write(struct file *filp, const char __user *ubuf, size_t cnt,
 		return -EINVAL;
 	}
 
-	*ppos += cnt;
-
 	return cnt;
 }
 
@@ -2557,7 +2562,7 @@ static const struct file_operations ftrace_enable_fops = {
 	.read = event_enable_read,
 	.write = event_enable_write,
 	.release = tracing_release_file_tr,
-	.llseek = default_llseek,
+	.llseek = noop_llseek,
 };
 
 static const struct file_operations ftrace_event_format_fops = {
-- 
2.48.1

