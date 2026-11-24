Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534163;
	b=B8uTUnygfQjcNbcLc//RypCweENR/xMA7VHGdtKybwULCXXT3pREqrkSAxxYDOj9r1Nc
	 MU2v5OOKYxjNlmLl9KXDANLjK+uOUqg5e0JkI1BsKzeKxo/uu6KCSQgtRWCf+538yWjzM
	 SfXV3HRF1LbB3cFcMtgV6h6/653DzLAiWtRkeOlg8OZ35905sdd5BTz+6YZC8pSUiE4v4
	 QkyVa/60y8vhPIEE2a5Gs3HdyD339eMupSn2Q9hu+AszuMX4mJs8EwZ6Cvwe0/DiXc5Mm
	 f8fYltbkm3PESlEjO5eXbdriReZL7q8QxxhaY64PW7I/YPQ1TgKuul8el7/A1pyH1Sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534163;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Dal2xlC6YbNI+m/e+H7cP1DHv0h5jSPjbzazqHofe5w=;
	b=gBD2xhb2mM+aSIe3I2cfgnnac77WADZ2LxsTMdViMqehSNrBTDDvn3mMBD4bMuFgqLgN
	 Mk0cPC4jo4rE06tP5Negs2Q3ud+YuLmt9w8e5+4NdEZqFqyc9aBRXWPkpdVNBh4+z7Hiu
	 HsvvxmTng33jOvxqtXfxnd7Y11E4orNG72RlU+H27H1zrMVrblMnJ1asLKeR0dRBRez+1
	 kHN/iphqCaAXRNbTt9hd72TLYpQjA/OGngCb+F/KewicumV62YszuWh97OA0FE7vOy82Q
	 u7RBm+6H185B05YpuQcauKzlHADVTuMrGS7L3aQMU9vL6m8gu5PDnx1Wcf9D8D3fdtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GgNYu3sY;
	arc=none smtp.remote-ip=209.85.128.69
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC9A606A698
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 15:29:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBC9A606A698
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GgNYu3sY
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a20e41008cso14325245e9.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 07:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795534161; x=1796138961; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dal2xlC6YbNI+m/e+H7cP1DHv0h5jSPjbzazqHofe5w=;
        b=GgNYu3sY255DPhgAHWISOLSbzVznRizYctr9Du/n4duSax0H5E+vKaY83wWS2RNX4K
         oFDgGRsnV1tVDwFS9iGIDnAggygplxA+MrZ3SnasGy0HJ0WzfjlGr2rZBfP7AhQqVs35
         l5GXOAfIj4bnEH45wphkjELYP1yqykYkYl2scQ42y+hwxv0x1XH/FmN0zjSwXm7jJ7Us
         tWswydGw3Zixuc07uxVS9cDXwUMrAccmeodLLGLts0PmnDLyDZab9oyNBulN1M9iRdAR
         rj/etn21Z75wb0+6RaoGq9yiveZEyrhrmn8E1sP+UQuANatYjgsKivCSeDdgNxt9wRYS
         Kkrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795534161; x=1796138961;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dal2xlC6YbNI+m/e+H7cP1DHv0h5jSPjbzazqHofe5w=;
        b=YYXd2+dC/nEiTgvdInlIx/Pfhp9DcDECUkx0OX89e7fQRzBeSXExGwIcleHsIbViRr
         jIyFIemSHgunU2UQmkGblGmexWEY6pN9svatp1r5Y+o9vgeWjN0ZS5fuHaNmt6KnZAla
         QnUS6Ti9sI2uGBOL5FEeRrsZ6gn/d6CroLPquPkjfpsBvXwTkw5/rwOZDbv9cqe7VrGR
         TyzjwOYfwBb7KUi8F+7W+s5TFm4+mU+K4G8w1GApYhTW6IN9ik7CpYwG0gMQ20MsFB7d
         arT2Gm2/fb55tBnPksXHYZhsdHWfdkYbWELnEuD3JLbBMXorClITKVzwltWIItzI+bGp
         T6bQ==
X-Forwarded-Encrypted: i=1; AL+hErF0MpM01jEcJuGuyFuQoWdmhgcb7dx9rFidZ2hY9rVq0k1a9dvQM9c7lRJne02FCPoFhJTk9M+RW4a8l5ezEHkRid8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9wMnU30puF6uOsEobfT9ZW99MLlZZ3S4ha3KtQFOUMeWyjcaf3
	rl7T8feZr5aZmViTNUerdF02Vh2GM6n5EiOyYKOwX3TK19BXi3RolgH4LVcgj/yDcYHvTtD8let
	9AdHRQsGmmCTlAABi0Qpcfw==
X-Received: from wmqu9.prod.google.com ([2002:a05:600c:19c9:b0:4a3:5d5b:9ad9])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5308:b0:4bb:76d6:1f5d with SMTP id 5b1f17b1804b1-4bb887ca192mr317588245e9.2.1795534161135;
 Tue, 24 Nov 2026 07:29:21 -0800 (PST)
Date: Tue, 24 Nov 2026 15:28:29 +0000
In-Reply-To: <20261124152845.2233401-1-vdonnefort@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261124152845.2233401-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261124152845.2233401-6-vdonnefort@google.com>
Subject: [PATCH v9 05/21] tracing/remotes: Annotate remote shared fields with READ_ONCE/WRITE_ONCE
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
index 6e514e78392f..7faa589ddf42 100644
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
2.56.1.809.ga0b61035b5-goog

