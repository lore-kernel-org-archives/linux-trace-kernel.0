Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988481;
	b=sCX9ORHqAiiitGtzZosFw6vJAy/CxiEltYaZYwfNKIz3Ib/ONpGLLmVDHOIzYaDWZflo
	 dQTqZmgN+q3hjO7MfNAzUc7lAjCRBk0iztisrsTS1HPRJV5UTEYl0GYNqHogzMqeMhi6k
	 bxy5Jgoj32vq5yUfmidGvextlS4XCMc8nAw9VyuTpNzNnucDnp1d+iux+xJzHdzpm5u+1
	 2IpLqzuOuRrZkj9d7ZGhlWc9oKQ1WI7b2AIu6LL5SX30zMcyDAJUyMwJXnRRWy+JYXUpE
	 ftKNb2cXB+vzB/i8pmVu6DSBl4dfJOw08Y5xOc6fqmURQlxZBgNJvfvUND98SQV28QA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988481;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=EIEtPuBp8yGj/o3XjSC3UWWuxltU58Pi1nP2zq/NhpA=;
	b=NFN/CpkIGJ1siz/IiK66vtGOdxFZbmZgSjOO76y7FbrbTn5uwd2jfBy4V/NSk6YRxiuQ
	 12BOp5vhZVb3pAPb9XkiCMIJ36y4tI167D/24ndcT9T1S8bh9EyJngk0hnAQJmiv1z+Za
	 0LcPu38U7LeoMfDVIzYwovJVzXxLKFoF14/wRfl3RscEz6/oCRkqr+e8mn6fLK6Lpp+ej
	 deFkA3HgY2R+XID8bYoKoOqObH0L/REfcBxo7u+go4p0+PXnG4LB86MF7QKZ8kyBz4lkL
	 uvS592fuR61LH8w7i6aI5ggRH/NkthGemxnzE0UB51kQ6hYSVpX2sERHQX2iNLsIDVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ohQlzThz;
	arc=none smtp.remote-ip=209.85.128.72
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E931C6082BD9
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Nov 2026 18:08:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E931C6082BD9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ohQlzThz
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a009f82bedso7450235e9.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Nov 2026 10:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793988479; x=1794593279; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EIEtPuBp8yGj/o3XjSC3UWWuxltU58Pi1nP2zq/NhpA=;
        b=ohQlzThzZlPtFpaHeHTo25spt3JoTwtQ7HqzmfzQlsWnANBZgLC7rb/YLL37ow8auq
         tzhtivt2NdEiJ56U0RGSogdRMHA3WRwdH7C3kHOngHlGIzjl2PgPUL7skKFUIrXX29Gt
         DK0iiJNgobkWrR1NSjANEURL9YTqS8U/ijfN4C+gAgLwvmnLp6tZ02KdzC1sebZtgu2i
         c+KGxhBJYDyDT7G+75sbP/zDciWl8rs+t/XNVRiLvYmhhGrcIKsN0xjaS3hGpvfMymlq
         pni+qHPywwpVVP2mAZohwT5MTvncbJAWzXH5eNDSofGo8n5w8y63kvin0dA6qTxTw2pv
         XcPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793988479; x=1794593279;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EIEtPuBp8yGj/o3XjSC3UWWuxltU58Pi1nP2zq/NhpA=;
        b=PKv5eqN4T0OYlwLiq4Gz+9wOrujuv7cV15o32iQOyLujYg/36ZISIiyUwe0m4Wq6J2
         3BiZWsF6U80is7F364jZfWHe8yhHc55IS7jBBvpo3UgL93t3Gtr+77oI0rh6pKn1BG30
         8Lt1Lho6iuC7wJMEPPsxtcL2/KjGOuJ2HbeCg18+0qpOd+ZHz7kF3aJn+G/hfqr2DPNC
         kpVasPOe1W/o1wrrRezcWVMr7+b003nvGqXSPHBJSd1ri1Y6aISjLQqP1QzkwCVhAddm
         tkNFDGAb/s6lw4gpQjYYqDKwTOcjUc/+lL1hJWuL07E1XTwb/LH2B/RL+Ju8CxA01oWj
         LWrQ==
X-Forwarded-Encrypted: i=1; AKwUvBzgOwhV47QCQkZYgGhZg+BHAWasSLgsp1RBwmAPJCka6OEoVJnOZYkLGsaK94j9VUNNgZj4w2jRmvRJZ5t96jAa2ng=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Qsec8/e5dpDCidxBiPEHynZMnFwdtTK3fIxCxXFjjA9wxKMXs
	V3xU2GybUL8CyDRltzbEOMpzeIwJaGktk06Qp7MLpSXMyOGSA8xbwbDUX95m7p12gBoXXQwzt0e
	UwLrT+0kRN2WSUVqErlyh/A==
X-Received: from wrny9.prod.google.com ([2002:adf:ee09:0:b0:48b:9d:e37d])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f4c:b0:4a3:12fb:1ef1 with SMTP id 5b1f17b1804b1-4b6df9bf612mr67318185e9.29.1793988479220;
 Fri, 06 Nov 2026 10:07:59 -0800 (PST)
Date: Fri,  6 Nov 2026 18:06:50 +0000
In-Reply-To: <20261106180657.2460376-1-vdonnefort@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261106180657.2460376-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106180657.2460376-15-vdonnefort@google.com>
Subject: [PATCH v8 14/21] ring-buffer: Add kerneldoc for ring_buffer_poll_remote
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
index 9c707cb751ba..82f0a4654c95 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6910,6 +6910,17 @@ bool ring_buffer_empty_cpu(struct trace_buffer *buffer, int cpu)
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
2.56.0.455.g6c5a503b38-goog

