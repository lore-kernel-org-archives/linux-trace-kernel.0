Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD67485CD8
	for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 14:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790261917; cv=none; b=pfgTUQB6OEvVIq2V5oE2oRA+vacusDQsL4k4IxRZHoDdtnJ7atKj5FXD143vZhDaBy+ttdD8FbUwxkiOz3sLXrnII4HaeIN88JqLBHa1zWe/RU95YdX77L0n02JYth2aiBETZlfavzElJUTvUtALm3kdFmb4o6daNmwyeubj4EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790261917; c=relaxed/simple;
	bh=GtXTawTkGaLEnygFpzjGviB4NZO0NEo7bzwgCMnHdD0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FU3Iwp2S6M+u045p+FrU1k/LfBbywADgzDiHc5QKyQn6RGYjrPMyVZdGl9PYkQTUy1L35Sa634dGkBRvHu/CL3NLP4A59gAZeixBMnysVkHpOeaY4KE0UEjkc1xhTJtvgaZLUjFqigUjCeBZ/+iZu46VI9XzBA1P8fFM3uFt5xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jr7IfXFP; arc=none smtp.client-ip=209.85.221.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jr7IfXFP"
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-486f1ecf9bbso702078f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 07:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790261910; x=1790866710; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9Ssz0kuZEB0oM4fbrjjlkUTjFkWgmAmLspvk/qGU7c0=;
        b=jr7IfXFP/j9NwmILP5UO8kvmbhcRUKkrSNMVw6sIdJrDYBsVjIRTFucXNQUyaiTBpp
         1UCa0CqkinH33EZL4jiNoZT+/c5Un8anu4jy8SlilSf3jgMmn+tMzmOzkoRRbSi8ABey
         UqxH56xViho5dACa9t0xhQInBUIYqFEFRNla2sWa+/gsaaj/7pWmMHLWqBhRixBvrGzP
         /Jq6Lp3PswEyd1Ake7YK8DHIo687xKnjuT0NUXBwznZJlYh6yQD5LYLbkJ8+E893RPd2
         2hA884RQdYXBY0vZaxZsTceiRcO9kquhyQyeH4UHSOFB34PWwCmUw3L/XQ820hFYBYc/
         lgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790261910; x=1790866710;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9Ssz0kuZEB0oM4fbrjjlkUTjFkWgmAmLspvk/qGU7c0=;
        b=RtH+racxEy0ZY7rVjOUfnKbk8vg/CNxW9Myun6dAHqYjh349YVDe+LWXLgYasjTimB
         +f1wnCo1unJvvWWFDiYZohE1gpM5PYFBZaWRDmlbRlGsr7knGrcmFgle/f8y9WlsqQ+5
         fMkTTCJAY3a0fAP4b3YamFzIAllNFK3RYltiS1pBm2pPzjfTsLc6W1oSdD8i6zBNkF8I
         ENrEgkEPY0gwxFLXnpVgOxHh5l511K+lWQy+I2RBURHRNMXbLQc8BMcHsTlWz2E2oF7k
         rwGcfW4rZEhFQJO0Xw1pYMmByAH9/vpftFLDwfyyR9PUIGrEn9DZWDCpbOnO8dxGnLDf
         h3eg==
X-Forwarded-Encrypted: i=1; AKwUvBzBrhGxTSZdPAMV3DZibwukMGnZK3FutzjleuXRpdHJ3TzY4PKXS8Emcr1/Lb0BmGJSXXeA3tuGB8aDe0f6FluOTjM=@vger.kernel.org
X-Gm-Message-State: AFuF++mz0L4FPW/y2Yk8Q680RDlKf7G97swtaaxtxFZb6whoeS/teh2R
	8/8TsukNQARo8VPkY1vfURY4PVufns4ycjSDI1njsa9Ogs+1L6Ky59JyjC7cSOY+rkajxHdq0K1
	D7lAcGh6boGChx+W4PV2O3Q==
X-Received: from wrbfk11.prod.google.com ([2002:a05:6000:270b:b0:482:e0a4:9fd8])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:64c8:0:b0:487:2589:ce4f with SMTP id ffacd0b85a97d-4887170f1c0mr5191154f8f.43.1790261909393;
 Thu, 24 Sep 2026 07:58:29 -0700 (PDT)
Date: Thu, 24 Sep 2026 15:57:39 +0100
In-Reply-To: <20260924145754.1285146-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924145754.1285146-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260924145754.1285146-6-vdonnefort@google.com>
Subject: [PATCH v7 05/20] tracing/remotes: Annotate remote shared fields with READ_ONCE/WRITE_ONCE
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

tracing_on_show(), remote_event_enable_show(), and buffer_size_kb_show()
read remote->tracing_on, evt->enabled, and remote->trace_buffer_size
without holding remote->lock, while the corresponding write and cmdline
functions modify them under the lock.

While this is unlikely to cause issues in practice, annotate the accesses
with READ_ONCE() and WRITE_ONCE() to keep KCSAN happy.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/trace_remote.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index aa76845a630a..517546e8343a 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -136,7 +136,7 @@ static int trace_remote_enable_tracing(struct trace_remote *remote)
 		return ret;
 	}
 
-	remote->tracing_on = true;
+	WRITE_ONCE(remote->tracing_on, true);
 
 	return 0;
 }
@@ -155,7 +155,7 @@ static int trace_remote_disable_tracing(struct trace_remote *remote)
 		return ret;
 
 	ring_buffer_poll_remote(remote->trace_buffer, RING_BUFFER_ALL_CPUS);
-	remote->tracing_on = false;
+	WRITE_ONCE(remote->tracing_on, false);
 	trace_remote_try_unload(remote);
 
 	return 0;
@@ -250,11 +250,12 @@ tracing_on_write(struct file *filp, const char __user *ubuf, size_t cnt, loff_t
 
 	return cnt;
 }
+
 static int tracing_on_show(struct seq_file *s, void *unused)
 {
 	struct trace_remote *remote = s->private;
 
-	seq_printf(s, "%d\n", remote->tracing_on);
+	seq_printf(s, "%d\n", READ_ONCE(remote->tracing_on));
 
 	return 0;
 }
@@ -281,7 +282,7 @@ static ssize_t buffer_size_kb_write(struct file *filp, const char __user *ubuf,
 	if (trace_remote_loaded(remote))
 		return -EBUSY;
 
-	remote->trace_buffer_size = val;
+	WRITE_ONCE(remote->trace_buffer_size, val);
 
 	return cnt;
 }
@@ -290,7 +291,7 @@ static int buffer_size_kb_show(struct seq_file *s, void *unused)
 {
 	struct trace_remote *remote = s->private;
 
-	seq_printf(s, "%lu (%s)\n", remote->trace_buffer_size >> 10,
+	seq_printf(s, "%lu (%s)\n", READ_ONCE(remote->trace_buffer_size) >> 10,
 		   trace_remote_loaded(remote) ? "loaded" : "unloaded");
 
 	return 0;
@@ -1131,7 +1132,7 @@ trace_remote_enable_event(struct trace_remote *remote, struct remote_event *evt,
 	if (ret)
 		return ret;
 
-	evt->enabled = enable;
+	WRITE_ONCE(evt->enabled, enable);
 
 	return 0;
 }
@@ -1140,7 +1141,7 @@ static int remote_event_enable_show(struct seq_file *s, void *unused)
 {
 	struct remote_event *evt = s->private;
 
-	seq_printf(s, "%d\n", evt->enabled);
+	seq_printf(s, "%d\n", READ_ONCE(evt->enabled));
 
 	return 0;
 }
-- 
2.56.0.rc1.310.g51773c2048-goog

