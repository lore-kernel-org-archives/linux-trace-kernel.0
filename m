Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D0B2AE68
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Feb 2026 08:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772092828; cv=none; b=jBntsGv+aYdRC1mk2Or6GRJseJgHQKycV/s7mfCdNsfNkDGuYdIlEjCtJn2d4Xi91ZNb4pQcPKWKzk07BalzpwkqxpBzueS6E0bvOvZgb+M5faPallDDWUPQpvV38Z0WPH4xEhaYzuyy887hAatJ2Gz14iPDdq3zwEDlggR6Y9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772092828; c=relaxed/simple;
	bh=JFpdlOb/KF/KZ4CkgJfnZGNAnHuMauFGWP0L29YiCDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dCZ79agOF1fTdQa3gnsSzSL8Vw065NKAVdfm/8W9IWam0pyU242sj90nkNnBHwDBzwcKH1nGEI22Qcqip/1CIB24U0tysTwqHrB0lg5W011rm/yxOl+he9leur2KD+QhKbOaIzR2D2usplUu2rxUQicpyS21u3je/RqgEC7dWO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jRpO4C+A; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRpO4C+A"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-4398dd671daso567425f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Feb 2026 00:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772092825; x=1772697625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zokyEb7aHw2V+Pk6mMPVX7opPiBUmjfWHZD2WD3HqsE=;
        b=jRpO4C+AcgDB0FQQMsdOs8M0a33cWcammxsot8hMauIJxlECe9TCuwn9D8fmwH/KoU
         JXWRUO675nM0LMBU78LrMPwdPoiDwb4KlqfbOxp3WT4nZXBFLP0lySKNYfgKYs0LPc1j
         JCn8sphkW92czigPc4pGRCgpd8EYZKVIEM1EemMxHg/xmVbpoI1oACIdlb0IxpbOONCI
         TP6BNd8vBQeCUXDsH+GlkIOeEcrO94xRVD2BePu24+eFqu2GIFSj0hp4tRQdva/ng/7r
         3kUzjKp+ZoUW33tTX1Fc6/R72ybtoqAaBWOqqZGG2Fq0V3DAaj1BB6Ga4Mrxaacf8Tb+
         q14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772092825; x=1772697625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zokyEb7aHw2V+Pk6mMPVX7opPiBUmjfWHZD2WD3HqsE=;
        b=EB0E9yXhqwWB7Eb0sLplQQ47Z0DTeVFEK9HRW3qnWKGp4N79+AF1nnY0JKhurOvKnb
         paaPbFZ0eZlgJ+2aNTr87qpcvwTWsVFI9hhEF0ItCIRGRygB3Agln8330tYXSbIssDDU
         siRw3BJT5dPpRh4kPcncGxm4Wep28vxLFxfGvuGkQmMUZrL5G2iwQuuq3ZmN3nKxVhtT
         lUdvuii4EUjMIGEw8/ubZtxOFnMAQOkGvVOyAHjB9+Fhmp8iPPJcjChviiBDIPvUCbQo
         Xb2uyjFQnv4opXqoNLGyiQTDcwsU90d6iZhexZ7qjBaBuAP1qfwPzOvIlmqSEYwXqqfe
         6bDA==
X-Forwarded-Encrypted: i=1; AJvYcCUfqqkhOb06UAnIqz4Uv+O8Hg7NPWUSiPfttGI0lbbeJ1o8ULXncSM21u9yu3SiX7cR/C7jgsaPqBuKWj+ASIxLLSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVlPZAOAW2HWQ62jo4HUquIla5j9n/avKXUlSIP9uelVKJ+wm8
	4KIygaWJkKIXKjOOhbA7PU7+6DL/ou6c36WbyQYHUlA5IsHj9aeTlwYK
X-Gm-Gg: ATEYQzxMXLme0jzR2s44ogV4cccgMlVGlKimpSUQzCLI2+a9Vjq11Vx03b7GkvAHjdC
	H8GUcsWFfM/PRRRtbnb9ALQsWArBTTV3sVJXyJ3gaY6g7HsVwPqhMg80YPbyOXCNocNgwNynxTP
	X61BrZK9EdPGNfkmQAHN4Ask5S6PUn0/UKtgFkNj0vZ7xlM1BFPhtu7GHej63vD7BdbTa3nYF9m
	0DlOqZSmLksnUxavMu16jP0NqGAdxN8AVP+ZZBlsvwteXhdtHLyOUxh3lYFKvV1zSE3JAH7MYaX
	psb0IDTehA2foImPMUqN8o1q4WrwS2NXsLCXoRwc1NStwhMrUtoo5jYTZULxuTFn8oQmQs2Hiwy
	aeJv1zQ8b2fIe5Lc62r48ZRDjSnYsCIBpTgajyX4GI/BuwC9L1YEsbsHsOLAh7WI8wmDNVaT/sQ
	a0TrTdvGKv+vSodydWVv91+uldbHuP9hI0IBoqAeEIHJCRaGOCBQ==
X-Received: by 2002:a05:6000:2012:b0:437:7589:100c with SMTP id ffacd0b85a97d-43997f4654dmr2357823f8f.58.1772092823040;
        Thu, 26 Feb 2026 00:00:23 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.215])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d3ff1csm38104086f8f.20.2026.02.26.00.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 00:00:22 -0800 (PST)
From: Qing Wang <wangqing7171@gmail.com>
To: syzbot+3b5dd2030fe08afdf65d@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [trace?] WARNING in tracing_buffers_mmap_close (3)
Date: Thu, 26 Feb 2026 16:00:13 +0800
Message-Id: <20260226080013.270883-1-wangqing7171@gmail.com>
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

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 23de3719f495..72b39295a8b0 100644
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
+	WARN_ON(ring_buffer_map(iter->array_buffer->buffer, iter->cpu_file, vma));
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

