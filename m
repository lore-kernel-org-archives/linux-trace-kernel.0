Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FD146D2DE
	for <linux-trace-kernel@vger.kernel.org>; Tue,  4 Aug 2026 14:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785852249; cv=none; b=nMRRzDpLGqkvfJbETlFkBL71Xwr6f6lFLFqzTo3XZtMQeOKxiTOOwziuTjULQ8LKLSuw0OBQWkVtTbUFXtEYrbZieiFkiMBFB+BQQh6Hr2VMEtTjhNN5/D8a4W3Pw3YAs4vP5Hm7JfUxFPmXKeb6zrNvPCWmRtX+tpZmegMWan4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785852249; c=relaxed/simple;
	bh=mJd4AJ8AR+Jb9QHmo1fgIyfkiHMyyvJ/w+QEr57zfYw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p8/Xe3WWptMfKGvt6otfasujQWOjvxBCXvbBy/D1Hmin7Rwh36DD/xseQdpWMxbxOolp4wweI4BU7Q6heI5LSxr2IVj9cyxD/lwA5vP7J9G2VzzUyduUMpXDkH8HOqvrKLejOKhX9qlGD63rVUecY0z6fy0h1wqK0rQ1WoQCraY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qpksj6qF; arc=none smtp.client-ip=209.85.221.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qpksj6qF"
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f835ac1aeso3712736f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 04 Aug 2026 07:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785852246; x=1786457046; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KB5qHRnyZLsgA5zhQzo7YNGC/4MQ072Z7VCdf5mW6a8=;
        b=Qpksj6qFq3lCEf5bkJF2qGnZaLiaOeF1o1yeq6FxTZCsKWM+/JQZbdTTWF/P3XQgw9
         Qfvr+XHs5prhQdvAAEfFt6w5Bsrwd0yzvrdr3JuhY6sGJAoBQv1Yud3rKZzRIaEvl26+
         8VtGYrIrvwBjPMrR7aYCJL8uSkewQE4ePWsH4eJaIBSYugIqstoexVCvMSj4czNEwVc0
         Ds50fkp2rVRuqehKz25eqhAwA8S/iK7amtLbMeilNFBoVQKX33SrYEYwEPIVGJrMrl+u
         YLu2AWY0JKKwoxgYfSh5unhDbBvQL0v8rnF2VrU4guTbfEfHRgadxbH/AnDCSq+s0Uxs
         9fvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785852246; x=1786457046;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KB5qHRnyZLsgA5zhQzo7YNGC/4MQ072Z7VCdf5mW6a8=;
        b=VB6/numm4nX6ZXU2enoqwonO8YQsOPxZTU/LqIIfxzV9r4fgSXpLDxs+HDDNsEU5Bw
         qkiPQkXOpg0dHtst/NrcUVCQycRNz/kzzbOpr7M5uhbMq8pLymAixDVq9Zbjty2l7w93
         PwW+urSWgS7f9gxb0nwLLes5DFuNrLsDSlw5vE6kD4W7WYG2dybmqEmybZjBsvQPqYXO
         t9LOF2dRzma+bs3PpUJYxGKskHVRkb/eF1v+wCQ+8xlf+zs2FTtRFW+7HHaQGi6woCf9
         ILBk4eh95JjFm2i8N8ZltynZihgQd2SwyQqgADq/kN9Lrx574ZB1C3zSni5hQBxft8B4
         ecjQ==
X-Forwarded-Encrypted: i=1; AHgh+RpSLsOZENMbCB26XrklRz1rdGJbmyyeoUFk9Z11XfQSxkXd+nUc9YZ200pF9P7MRYWkjch1gjkMNwKvDiZwNlcidy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMeais9bYHO4slJX8MYE+qsLo88uWofz8UUtNVCE6IyG0qZQex
	F0zvDFkyYpRWRjCUuQ0H4UfP+j9m1osIC1Dk6kPep3Xl6/XAh/7T/HCirii9nx5tdK9VXdwtscD
	gc7oN4R9UDmRPS0ItlwzgVw==
X-Received: from wmxa7-n2.prod.google.com ([2002:a05:600d:6447:20b0:495:55d9:36ad])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:12c8:b0:495:63e6:5fb8 with SMTP id 5b1f17b1804b1-4980c653e58mr226747225e9.12.1785852245793;
 Tue, 04 Aug 2026 07:04:05 -0700 (PDT)
Date: Tue,  4 Aug 2026 15:03:27 +0100
In-Reply-To: <20260804140333.797210-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804140333.797210-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804140333.797210-13-vdonnefort@google.com>
Subject: [PATCH v4 12/18] ring-buffer: Add kerneldoc for ring_buffer_poll_remote
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Document ring_buffer_poll_remote().

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 4bb1a7780860..8cb10e9da122 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6848,6 +6848,17 @@ int ring_buffer_read_remote_meta_page(struct trace_buffer *buffer, int cpu)
 	return 0;
 }
 
+/**
+ * ring_buffer_poll_remote - poll a remote ring buffer for new data
+ * @buffer: The ring buffer
+ * @cpu: The CPU buffer to poll (or RING_BUFFER_ALL_CPUS)
+ *
+ * This function polls the specified remote CPU buffer (or all of them)
+ * by reading its meta page to update the local reader's view. If new
+ * entries are detected, it triggers wakeups for any waiting readers.
+ * Returns:
+ *  0 on success, or -EINVAL if the CPU is not in the buffer's cpumask.
+ */
 int ring_buffer_poll_remote(struct trace_buffer *buffer, int cpu)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
-- 
2.55.0.571.g244d577d93-goog

