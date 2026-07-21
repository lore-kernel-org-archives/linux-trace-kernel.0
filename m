Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A4E4D8DAE
	for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Jul 2026 10:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784630197; cv=none; b=XQ3b5CwlYxM39khXh/Tuh62RkF58vB0tXNvIUijl/iNx46piMX7iSRbCkzaH7VGXQ+j7UWo4QCETHYF8B1c99VCwCkR6PkPNDh2s5BRwuQsULrEIspeaIY2E9WhThytoHKGUL+pvAO9KS7vZB1WAKZMu6Y1cSXj9RO/B4GalBuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784630197; c=relaxed/simple;
	bh=cxo2d+GvifQfDGhNHaZRVtIWs5CmSWyYkoR88BDUQ4g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tZgQLDchRzQqv7wY4mUZvWxY5NcreqotYb9zglRznMlgVTArvQT+aWRiheB6ncep2z14xAO7H9q2JkeRh+KGJJMafKJXvk+hmpDScALeJhKm1xTJ66ADWCxMYcW+znwMWYz3hfVH1zE5nLobsUBAVIFU1/aeP9oIhIFmrx+P7BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jc6Ztyfd; arc=none smtp.client-ip=209.85.221.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jc6Ztyfd"
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f6e8b5996so3029748f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Jul 2026 03:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784630194; x=1785234994; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0XxM/zgyIM8cTyjtfPJ6E0fytFa6RLF0BsfQPlPlQ2A=;
        b=jc6ZtyfdcOXKoK6V2rAXdLXfhRmvCBxd2t7RHzq5cf/H+09LNEt+NMmaEHRlySsfZX
         nHLUVXGO307GhUQwy2f1j6OtM6u4RkjmRZEh1Hb7fNfFicIRWmu2XfL2AGMDUld5jvX8
         tr6SVPP2OwQ0MF4+nqIhHiBqjY6rDeaaEYHKVOciu8XnH//yGLLgdNElmqVXzzD3x3Ww
         VYUDSOC/t3QW88Uq0ikp6MWngtPkGjQT7vgjwYQpGB3LjcxBgWVU0Mom+SUXMUfqnpjG
         BvFlKLnNRDJzWNuWYU83KhYbdEKsDji9GuOJXj9OCr721UvVZHE3PGBXGM07ykZLimxA
         ysnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784630194; x=1785234994;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0XxM/zgyIM8cTyjtfPJ6E0fytFa6RLF0BsfQPlPlQ2A=;
        b=YBeuui1o5Nh3fffP49xhv6FLpHrjEJZBntWrs1vzq+ktMe21xUxurOsLwgP8g1hbys
         220BV4qI0YsQvC4HRcv0wtYU3vT3K+e2MU9aeoebhv7/JS5nF+tPwoMzBFhcKPPURW29
         xp8FHr0zu+gn+1Za9/dP/BteAYTQpIk0L4rYbn/vsdppLrGfmqx7n8HAOOwrG1cHjeSa
         vxo55A8MXkzkCTS8FQgnNjfKwg9niLp/SLuy6rBUPac5Wsi0vka8NhTYyi81OLL4yasB
         VBjv9O/TmBzYaLPz7Hg07KJ/uIyQHX76A0sG3mnxJqj/DdL0gsIn1OSzE8ucRCITI45R
         O1lg==
X-Forwarded-Encrypted: i=1; AHgh+RqTmFd6Y9JaNeZJs1pPSTf4LvfiGGd4p4U6fVnFjE2BZl8Qbmr1BWxigEGg6D7kq0wUUd2Lt9YYseAOpTd6n7fuDvU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwm/h7mM6PbLngM+jhdErBiOg0v5z7iA+p4dT3uvqjCdOjr6Bm
	0vlo2aOBUueQTmXQjSm9QOVcQsb28VDtqD5d0i69mt5+UhS0fLbqBRIQGX7tAO0N3v9ZtmtmIpd
	yztVZvBzyKYRxZc/kGrntHw==
X-Received: from wmhf2.prod.google.com ([2002:a7b:cc02:0:b0:493:b719:1145])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4687:b0:495:4e1d:82e6 with SMTP id 5b1f17b1804b1-4954e1d837bmr172693725e9.36.1784630193864;
 Tue, 21 Jul 2026 03:36:33 -0700 (PDT)
Date: Tue, 21 Jul 2026 11:35:57 +0100
In-Reply-To: <20260721103603.342266-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721103603.342266-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721103603.342266-13-vdonnefort@google.com>
Subject: [PATCH v3 12/18] ring-buffer: Add kerneldoc for ring_buffer_poll_remote
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Document ring_buffer_poll_remote().

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index c35e36c553aa..0e3a53226bfc 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6846,6 +6846,17 @@ int ring_buffer_read_remote_meta_page(struct trace_buffer *buffer, int cpu)
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
2.55.0.229.g6434b31f56-goog

