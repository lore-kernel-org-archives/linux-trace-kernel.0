Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132652FFDCA
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Feb 2026 02:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772161135; cv=none; b=JuXj99QnrK+4hy3/g/6IQwL1cKEMbIwh8y6Rs0dBB1EjQ5l0nKSrt2IUDDk/WctkT1XpUpAtABGIuGmb/04LIlBO3STFvbk44Pz8NeXaoMlPW0AF/hRWOoLcm3oQEfjGW/9AV3yUU5m+am8nklCN7Sq5A0LedQzWSokFKb4m0pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772161135; c=relaxed/simple;
	bh=YFj7yhjrtadWncMpo5/biqn5I1v6dyWQJz0v5w89S08=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XyEhD2TFQlTqcDBbwkjLq4lOSF503EBsfmPHfVoTT8dWVQgP/nnmM/Yc2BHM8ZU3Ubx6aQnrfU+XuN7u7mYNhJQQvvPMTZXsfqHU35T9U1m/1Psm0vkSIQqJ35fnm5Pz1aS/PQN7TVT8YL79DshtA+RRI3BIQWlyfOJ+JNpB2aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9NdEDiu; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9NdEDiu"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-43991cc3155so1503006f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Feb 2026 18:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772161132; x=1772765932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vprqqt0LKIo00nWNx3ZKXI+4xqRRuBJ55PJ2vhVXiRQ=;
        b=E9NdEDiuNc2pklVypBf9+ItwCF3A5tDQv4+RyXiUT24DGLLZ3Vt5xuBNYnjCdMzeQK
         SHBz/UdAeoFqpxziquQUCYAqnIWSZJMdKNamEjCZ0lTq4+xg1IeWaVPpc5csxJaePaP4
         ZKyTwWCzc6DtbsRdgcYPMiTDsmCMWBFt0IJnHStDror+XxUZ3QZCc1cRWtwXEaoTLEz+
         FQM+Zs/p4DLi04iLNzwQVcAXxK1TL1cCFEDDN6Mq4oRRlE8TuNgvEq6RZGyWjZi1AuQG
         oAPL4aXtSMHxEvrG012tnvJ88Xs27nKcYsNtgLSPQeiQc/wX9bnC0DCD8V6Uf975g1GJ
         hgYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772161132; x=1772765932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vprqqt0LKIo00nWNx3ZKXI+4xqRRuBJ55PJ2vhVXiRQ=;
        b=FOmJ3t24XvAU2zdBTiuAH/z1XS+8gWaBVblg6akdBjra73VV1caC+gu12jPi49RsSe
         VwMsgNy0X31Y/dH/vc4taxOkQWw5lu9mcgIfGU9GzvxApzOppsenV08117sgGZsdf+6r
         FLD1jwsMaOu/ZkVR4cJP7qdWyn/QtDt71dn6vfJ6JJJ1FiYpw+i1A/84Dgfqz21yauCl
         W7Ew8SlB5HMQ0NQxh5GZ7LMjPJ5YISEzV1tzdjX1ThzUmXmSv2858QdG5MpJyPWHY2cQ
         /eK+wqEN8hoCZIxXkrpYnRof8pRgv597pXIh58SqOnkrrCgQzwG78QIJWZswXF2gEukl
         QiyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMWVGs/CEx7Q//6NlCM7GZ/u5RLqk1q2D3Vm+TO4w/7Hb3lw7pX3ExQAOnt9lqq93PDXX0GD2aXS9oDnpxrkpomRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YySVmBwJBQg/cJ2N68LEdZLZXgFmxEX5ilhdpsTPFI28YMQQOcU
	pK6EGz6b7d+sZ+giLa0CDp0+VlCmr4mNsH5LN9awm2Yr4bfmSEVNy+Bl
X-Gm-Gg: ATEYQzxCXOIYYOt8PDe2RaQ6pR4dOLC0g7MDPVVs19UkaEw+7bnZ7mkCXTH0vxVgFyG
	GeRBfNPNXHwoo1p1QFw6g/+qPawi7fGx47Ot0BBxgXkVrlOj1M3KqpR+ImToJSNju0YwkC3XxPn
	5NgYE4GY1MbEF3ITyhhBcc2B0UQCOVHGwaI7Adsv1V2TufoXL+Z7UgeNVH5t88Pzcj2Lhh8EJ8P
	icOIepFEqpx6ZpPdh9wujQDJQGaq7CzLA3cjtS6Gww/TitANUbeUrkb5r3zITV7gVjFBqpoHItT
	Jn2ibYRAf2Q57paWRKrJJq+zcJP6r+FxVOt9MdnIMp5wRWObkDxxh4yo7PlrWQPmLL6jmIIyh9P
	7Ow7Ai8M0Xit91oXCdCK17kzTXOag9aKt2F/iDyMLEaz5dR6pJY7uk19tGd4ezUJ6EUnt3pNH2w
	Z6bTnb9c/U2IyCR8WDNvEfInZ38XZy/NgiSlJoOXIzL1+z41uzxw==
X-Received: by 2002:a05:6000:290f:b0:439:98b8:6470 with SMTP id ffacd0b85a97d-4399de25af8mr1513898f8f.49.1772161132119;
        Thu, 26 Feb 2026 18:58:52 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.215])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c76b40esm3083180f8f.36.2026.02.26.18.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 18:58:51 -0800 (PST)
From: Qing Wang <wangqing7171@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Qing Wang <wangqing7171@gmail.com>,
	Vincent Donnefort <vdonnefort@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	syzbot+3b5dd2030fe08afdf65d@syzkaller.appspotmail.com
Subject: [PATCH] tracing: Fix WARN_ON in tracing_buffers_mmap_close
Date: Fri, 27 Feb 2026 10:58:42 +0800
Message-Id: <20260227025842.1085206-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a process forks, the child process copies the parent's VMAs but the
user_mapped reference count is not incremented. As a result, when both the
parent and child processes exit, tracing_buffers_mmap_close() is called
twice. On the second call, user_mapped is already 0, causing the function to
return -ENODEV and triggering a WARN_ON.

Fix it by incrementing the user_mapped reference count without re-mapping
the pages in the VMA's open callback.

Fixes: cf9f0f7c4c5bb ("tracing: Allow user-space mapping of the ring-buffer")
Reported-by: syzbot+3b5dd2030fe08afdf65d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3b5dd2030fe08afdf65d
Tested-by: syzbot+3b5dd2030fe08afdf65d@syzkaller.appspotmail.com
Signed-off-by: Qing Wang <wangqing7171@gmail.com>
---
 include/linux/ring_buffer.h |  1 +
 kernel/trace/ring_buffer.c  | 21 +++++++++++++++++++++
 kernel/trace/trace.c        | 13 +++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 876358cfe1b1..d862fa610270 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -248,6 +248,7 @@ int trace_rb_cpu_prepare(unsigned int cpu, struct hlist_node *node);
 
 int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 		    struct vm_area_struct *vma);
+void ring_buffer_map_dup(struct trace_buffer *buffer, int cpu);
 int ring_buffer_unmap(struct trace_buffer *buffer, int cpu);
 int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu);
 #endif /* _LINUX_RING_BUFFER_H */
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index f16f053ef77d..17d0ea0cc3e6 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7310,6 +7310,27 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 	return err;
 }
 
+/*
+ * This is called when a VMA is duplicated (e.g., on fork()) to increment
+ * the user_mapped counter without remapping pages.
+ */
+void ring_buffer_map_dup(struct trace_buffer *buffer, int cpu)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+
+	if (WARN_ON(!cpumask_test_cpu(cpu, buffer->cpumask)))
+		return;
+
+	cpu_buffer = buffer->buffers[cpu];
+
+	guard(mutex)(&cpu_buffer->mapping_lock);
+
+	if (cpu_buffer->user_mapped)
+		__rb_inc_dec_mapped(cpu_buffer, true);
+	else
+		WARN(1, "Unexpected buffer stat, it should be mapped");
+}
+
 int ring_buffer_unmap(struct trace_buffer *buffer, int cpu)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 23de3719f495..1e7c032a72d2 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8213,6 +8213,18 @@ static inline int get_snapshot_map(struct trace_array *tr) { return 0; }
 static inline void put_snapshot_map(struct trace_array *tr) { }
 #endif
 
+/*
+ * This is called when a VMA is duplicated (e.g., on fork()) to increment
+ * the user_mapped counter without remapping pages.
+ */
+static void tracing_buffers_mmap_open(struct vm_area_struct *vma)
+{
+	struct ftrace_buffer_info *info = vma->vm_file->private_data;
+	struct trace_iterator *iter = &info->iter;
+
+	ring_buffer_map_dup(iter->array_buffer->buffer, iter->cpu_file);
+}
+
 static void tracing_buffers_mmap_close(struct vm_area_struct *vma)
 {
 	struct ftrace_buffer_info *info = vma->vm_file->private_data;
@@ -8232,6 +8244,7 @@ static int tracing_buffers_may_split(struct vm_area_struct *vma, unsigned long a
 }
 
 static const struct vm_operations_struct tracing_buffers_vmops = {
+	.open		= tracing_buffers_mmap_open,
 	.close		= tracing_buffers_mmap_close,
 	.may_split      = tracing_buffers_may_split,
 };
-- 
2.34.1

