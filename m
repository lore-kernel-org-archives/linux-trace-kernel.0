Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534175;
	b=qWHKvZZKAfdoU52Q/f1CrNU1P1k+3Wo6c4nJyGYt6XnFIAxWexxSDCP3UA7nzqFV9wJj
	 emEMsOjgd4XYcvy2p4zBd9heyqGtYTI7eglulqja5SG0J/yDgwaNNdlEd4x7AU+oGmOpo
	 of1zLmclVCZeNWf90qjkJymR4xUogI/jVlt4B+Y2xM0X/44hzWUc8W32zIC5ZZoivmcGt
	 MrkC0nRdgYwK4CTZyMRHMZQVJa/dETSaG3xiQyKMXN/+jfOH05ZZTfrwJNGCkpYp1zCyz
	 u+5gHxtlrD8+1gr6/p9YIsUv4UJobhJKcLLUEyRUYjcSlXWHUaBhgnIN05805miIUSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534175;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=LoCHYzw2l3suo+jGQIj5bj47LEPtTtGO3zS1o9HP5XM=;
	b=AgOoMFQjRDReS+x4C5CL3nLdcXlQXGdFz4e7UTemVpyxzr9Osygf1u/Luez5rw2TpXzm
	 F5ASKM1Gv8GzG3GGlADHO/ASFnTw0pHLNLernUXCjj3oEHF/zwpFFbCVDo+kFoj3tD4zn
	 1dCNg5BASZwPDnDP7l1jizVoqMrC9Wk0/OjNCGQzPjtbrFiML9ubFegOxfpWBvJRsIZts
	 xO+H36lmhYgwRiUY163LLtK2a3+cdBccSuaDavs/PntRn+b2/ThylkThEMUqD8qdU/2JJ
	 +/M5U/VtrkktkuHIrxmyiaPP+soVpxfTknXh/GsH/JT3+CZ22tiZbNOV2hEBplT3ciA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cuhkB5Kg;
	arc=none smtp.remote-ip=209.85.128.70
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C7A60A263C
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 15:29:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40C7A60A263C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cuhkB5Kg
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4bb69d84053so32900875e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 07:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795534172; x=1796138972; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LoCHYzw2l3suo+jGQIj5bj47LEPtTtGO3zS1o9HP5XM=;
        b=cuhkB5Kggg4UljtubX1ljrKh4vCUUV0HgMi4UVgEzTNiB9JUVuDZfIc2WA/7lWURI8
         rhGm6ezMKAqe2BG9rr2cMOnvRrIgDIJ0SDEPnpVNUx5v7BFKYR6Q/xfPtjF60Uhy3r/Z
         IKCFoFasVbfrv8vWbJ3//80PV3pd+2H+hRw/j/7NYnmP+sIpXBM+I6oltUqZNwf++bli
         Y2jRwzzUeSGXqqL05wb4ZyU0aa7NUYxpCEjA2M8CxJBFpP9RlsYb2soVQ+dw3meIdhll
         NaJRFFfrvFFcieR2dRps8FDUvByhxkc0RMICPaqoN5n4UKh+Eb0V99ElgR3uZ50PcqVb
         6feQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795534172; x=1796138972;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LoCHYzw2l3suo+jGQIj5bj47LEPtTtGO3zS1o9HP5XM=;
        b=sEtnogg2IahTyNkUTf3Uaa/ov5D60sitP6H+0o0hdW4P+Je+0mPFb5FtRaMjdKv+cb
         zBW9IH5bom0vww8h4747xR/lEyqvaLtjpX6jOySyJ1tJB9FKGuQutIJaKdzr0e7GaaFJ
         TQuUp+z9QQKVQm80ZyvsmQX0Uf76koNFHbnKz1gU74hDai7+26uXpAOmVLuJLCusApCc
         fmzt6zNis1lD4B/f9rRECb7w1xDsige1xmcddA3nMSBdM6S+QaYK09CaZIHGQiEf6059
         FgQ7j9O+HJmMOlMASzDQq2TKG29/cEcPr+Eo/SSlFXpO+htjsRB5uiZ6pzKyXIGBX4wt
         HR+w==
X-Forwarded-Encrypted: i=1; AL+hErF8mgHKmny74sdI6jsfqMFWRnghg3dOzlcOmYMMhKcBN3qrd0bGX7PmXER0wJhpK80Vfi4JX72WWx9K4pc+PHbuLJY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9zgH0iJWKPEWm9anGLyzGZ/Hp490EY6Oo7VoutEVk8sXSA8Jzn
	ypFQDcYRB+mp66shHrdzYTbsr6Qeqwx3tpoNJR5o2lov80cQBqRk+Y5WW9ssE8C2F23hkx9pDGN
	shsiDB4w7VMT+2GORe/EBGA==
X-Received: from wmg25.prod.google.com ([2002:a05:600c:22d9:b0:4b6:4096:72ad])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:848d:b0:4bb:6687:5386 with SMTP id 5b1f17b1804b1-4bb8880c7f1mr325571055e9.19.1795534172141;
 Tue, 24 Nov 2026 07:29:32 -0800 (PST)
Date: Tue, 24 Nov 2026 15:28:38 +0000
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
Message-ID: <20261124152845.2233401-15-vdonnefort@google.com>
Subject: [PATCH v9 14/21] ring-buffer: Add kerneldoc for ring_buffer_poll_remote
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Document ring_buffer_poll_remote().

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/ring_buffer.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index f517bc651e84..33d962f9d8cd 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6936,6 +6936,17 @@ bool ring_buffer_empty_cpu(struct trace_buffer *buffer, int cpu)
 }
 EXPORT_SYMBOL_GPL(ring_buffer_empty_cpu);
 
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
2.56.1.809.ga0b61035b5-goog

