Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B5339A81C
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Feb 2026 09:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772097432; cv=none; b=YUzrlf4Htpn/LFn2AXanXHeeCeqC5EQxwMuZC7xlnu3Ulw/T2Vvl57B3Zh/SzFFyFu6BQbeJSWKQ3QtRxl07v+8m9aCoMWQSqO00vq9fuQsxA356qRuJCigYmKKnLcQsf62DBRJyFdYggc55Pr4+d6FaJ9e60RQ0hEJ4u4HUF1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772097432; c=relaxed/simple;
	bh=u4mLjVeY90P9uE8k+OrgrA7HWVbWe0oz8RoRO9olmZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f4QKI/zUt2ZQiLaNOqqyEZ707JPyrUOfPbaJUtISwLxPNhusO8YVWdufGAYfafNVQ0lqcK3Feom9/s0hBRCT9iKh5F7X6CzqhrEJL9Y60WNg0nBxU7yOCYe1O8euaz9JJPz/zDeYV4wLn2+JIpcQ6YROoGrMepdyTiVBae4IAVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m7co8Hus; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7co8Hus"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-439857ec679so509122f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Feb 2026 01:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772097426; x=1772702226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUADCGvGxdCHKYsX5uYRweI3t7gagyhmTu/5nLW20I8=;
        b=m7co8HusL4pUKoQuNtZe+OTWZmD8rK1gcW34DPcQadJarssSPrjAzVpyV9hnr6Hzlx
         UnBUt5o5pl1RfIP2e4wvSyLlPYuZRTG60agUDQSJHBv4RXUS5ejRRtbSYjNnWtzFUAr0
         TI0UGBSLp74il1EMio068H9viDvjsVuXeWwlIJ7cyIlzumsoEXi2e6OOULFSokIFdgUD
         j6wl+k30rrwyKsBZH6Kb+0/erqwfqGCtdDKrSe3RYcdf0vT6AUVFD5zSinl8BusIMqgU
         DRAQH5r7RakchA8SB468iCbwKgr/Gcbzy3MfVIChBM3idq7yF58P88Uxxu1/pG96IWlQ
         VMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772097426; x=1772702226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AUADCGvGxdCHKYsX5uYRweI3t7gagyhmTu/5nLW20I8=;
        b=lmJR5Hgr1AmJxbCNVnb4GncONXqYjXo0p5qihNyP671juwzRsLNUVBNxumWMd/UVuz
         Bdc3PJyggP+D9lIxQ7yDaQAAHC4wVqA1g02xomHRkkS+1mZzLe4IAodzZH/1unw0NRW5
         ovMein2FXCY8xnaHVfnn0b9dDhgTWG4qhR7XKxBeW/KeFRyON5DajGrDqSABtZm/LHJ7
         IGBVzv3GA7hqWpxAJNgMcdIZzKmpe1B4+pZAJGVBBKkJoX3m9hAaPiS5pG28BcbDXNUN
         4TuP9kvf5egiq7ZSjDH0L7tc3ANJFAVqQEGLWc9gaMcwezH4HG8byl+rkFAw+yzpnWcd
         lnMg==
X-Forwarded-Encrypted: i=1; AJvYcCXwvlWp5IAI8m2iRjjW8pUKsF5uBbggsj0P+HJMaRGwUGqPub6C3Lij66qVQ8R4c7SVj/587TKr4CGFKhY+OeotOuA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5WCpuMqu+s5p0SKIExJquSUrqduuQkEnpKmb9SwgfqvN6roNc
	eNdNspkH5m2jhiO0RbD8R5yiuonXLqk1qPEf2p7Et6rax/vuRlymI8jK
X-Gm-Gg: ATEYQzweePWxW/iybdeLkd2ozb3F07LXjYKssGINgdw8akxbqWWk5jsRKEpCU895QzA
	pGDUQO9Y7Kyy1/EqsGjFLdfq9ccQNjFlBEdHeKhO81FOUQVEV7U5a3EA+TWCh54mAknRQwYi7ed
	BrjnVbHew0bbUeWo5w0lSpNYj0JZY7a0WwMnXFqkyGdmKUNjN1tW8YmArX5H3LPg2IL3nCDaEKH
	JucLp0r4dvZzZAV72kulPivkDIu6C/TdUH9NIr/LISvMmMHP5H/6PONxv6IsHBpWx2/8g2EP3QU
	nQKIyKegP/Qk9x/2BC1hAlk1jqoGmYr3SwO/z/AP7KYwn+lt1mbN6LME/UqIv/4GxAzhIY+f03x
	u0T5ujkB6EURegNckyqNX/0nr6hUY2udTopKfD+CwHOs5m0YmyF+5N1Nzux7QNoTQHFGkCtDuiJ
	sNSMdoTejP6SsJriaAlsarjOdY87GmwcYH2MR5GkpAYsJO/JfLDYOmk+S0T2mE
X-Received: by 2002:a05:6000:1a87:b0:432:5bf9:cf15 with SMTP id ffacd0b85a97d-4399429d1b0mr6054031f8f.5.1772097426294;
        Thu, 26 Feb 2026 01:17:06 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.215])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43987f3ed03sm20010929f8f.16.2026.02.26.01.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 01:17:05 -0800 (PST)
From: Qing Wang <wangqing7171@gmail.com>
To: syzbot+3b5dd2030fe08afdf65d@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [trace?] WARNING in tracing_buffers_mmap_close (3)
Date: Thu, 26 Feb 2026 17:16:57 +0800
Message-Id: <20260226091657.895403-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <699fc6d3.a00a0220.21906d.0073.GAE@google.com>
References: <699fc6d3.a00a0220.21906d.0073.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 876358cfe1b1..07f5127c8255 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -248,6 +248,7 @@ int trace_rb_cpu_prepare(unsigned int cpu, struct hlist_node *node);
 
 int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 		    struct vm_area_struct *vma);
+void ring_buffer_map_user_mapped_inc(struct trace_buffer *buffer, int cpu);
 int ring_buffer_unmap(struct trace_buffer *buffer, int cpu);
 int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu);
 #endif /* _LINUX_RING_BUFFER_H */
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index f16f053ef77d..59516b89e612 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7310,6 +7310,30 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 	return err;
 }
 
+/**
+ * ring_buffer_map_user_mapped_inc - Increment user_mapped counter for VMA duplication
+ * @buffer: The ring buffer
+ * @cpu: The CPU of the ring buffer to increment
+ *
+ * This is called when a VMA is duplicated (e.g., on fork()) to increment
+ * the user_mapped counter without remapping pages.
+ */
+void ring_buffer_map_user_mapped_inc(struct trace_buffer *buffer, int cpu)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+
+	if (!cpumask_test_cpu(cpu, buffer->cpumask))
+		return;
+
+	cpu_buffer = buffer->buffers[cpu];
+
+	guard(mutex)(&cpu_buffer->mapping_lock);
+
+	if (cpu_buffer->user_mapped)
+		__rb_inc_dec_mapped(cpu_buffer, true);
+}
+EXPORT_SYMBOL_GPL(ring_buffer_map_user_mapped_inc);
+
 int ring_buffer_unmap(struct trace_buffer *buffer, int cpu)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 23de3719f495..b2ab95ed8d41 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8213,6 +8213,14 @@ static inline int get_snapshot_map(struct trace_array *tr) { return 0; }
 static inline void put_snapshot_map(struct trace_array *tr) { }
 #endif
 
+static void tracing_buffers_mmap_open(struct vm_area_struct *vma)
+{
+	struct ftrace_buffer_info *info = vma->vm_file->private_data;
+	struct trace_iterator *iter = &info->iter;
+
+	ring_buffer_map_user_mapped_inc(iter->array_buffer->buffer, iter->cpu_file);
+}
+
 static void tracing_buffers_mmap_close(struct vm_area_struct *vma)
 {
 	struct ftrace_buffer_info *info = vma->vm_file->private_data;
@@ -8232,6 +8240,7 @@ static int tracing_buffers_may_split(struct vm_area_struct *vma, unsigned long a
 }
 
 static const struct vm_operations_struct tracing_buffers_vmops = {
+	.open		= tracing_buffers_mmap_open,
 	.close		= tracing_buffers_mmap_close,
 	.may_split      = tracing_buffers_may_split,
 };
