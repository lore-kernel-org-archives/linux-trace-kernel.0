Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795792422;
	b=HmbemjcKUCUkShyUp43vqt0OWrxq+sptD74gj/Im0RS1b1+OaVXwv7+fj2cdcv9oBUAp
	 zj1YuHVikzyDYYw46uLTaUPgLDxVdjEH+uMzWdZH9FJw/VcD2EF/a2PgUdk4jeqiBIQvR
	 RxbCpc0hq6uXsvrf9cCpPVBqMC7L/3sswlDGGNBXL4kfq1RZ+HTrHo8zFtBPmVsgADbrF
	 Elo4FKF+URmaJnPg8VqWV+Xnq80pCPVl8cviS/J8NESKpUxLvB+VI2/8faRVDCEkNeNca
	 QaJLrTWeGxtSnqaeTrUDsViU463jbkSYY3cWxrFXEnGPP+zTpb5oLApXSoMnCLlY0wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795792422;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=QUdvWncd1Nex597ohZHTKVDevRK+Yf/5v5Q8NnQr0js=;
	b=vhITD/sWi7eBfW59zfE0ObMeIJew0TpbjlmijDM7k2Y8iJ1ZlIC+cflSSsatLb65SbhA
	 v+tlwsnIIwi2+DWj4JVagY3h24Y/QJkfRqKdCrYANI29XJ2kuChVTY4FcaORKh9fk2Dao
	 2CMEbnj7Xz/cNPtr3epywmwtgjj4hoMkgyDNECpa6viW1HE0Lppuwvy80doFjXU/m8HmT
	 HdHa8MsZOpu+bv4sDCcJJARpeS8pNmhgEGtu2k8nhb45yUSuuWqZfEzHOw2YXO3bkGJMN
	 cKkPL3rqe5Iojt8ZNrArP4HtsaNKKluLzud9w4gxQ1EH8iLXQZYijE0PZpPNXWD0BDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=owbioq6l;
	arc=none smtp.remote-ip=209.85.128.70
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C937F606A334
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Nov 2026 15:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C937F606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=owbioq6l
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a204f135ffso42895645e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Nov 2026 07:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795792420; x=1796397220; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QUdvWncd1Nex597ohZHTKVDevRK+Yf/5v5Q8NnQr0js=;
        b=owbioq6lUez30mE7kW8oE/u7H6q7faOAWCb6bxACFOybBMA3fSqWqBUFHz1WQLscPm
         OtedwXRiMLejupAN/SaX9+pheYGaPJJGictLwkQuE1pEILNusf6+96oMNZMBEKleHzPN
         MUP7Wy6S9aJRPFPLlAl/ZhO+NIrYAahBntZU8WmCAXmJBDKIhqEF0bzPz7teh7QEKfnu
         rYmv2kKryfQ7T/Hke3cp8VT98CrgkzC5uriZWIe2ZPD/PFHz9JTrAWh7jv2XSR3EjgUk
         sR8hgXZlXqIeYZptYQTSkiShp503O0jIzqupUg3QQ3BwjFLpcvjjfYwXeIOwubUdTEFw
         iJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795792420; x=1796397220;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QUdvWncd1Nex597ohZHTKVDevRK+Yf/5v5Q8NnQr0js=;
        b=NycL5sIoqLJiZrkPl01eHdfgK5bSiNlMxYskJG1FdEwJJoslJF9JMCCb0JN6r38mm0
         bCstEhwEp6dZIKDPhySchwSViA8u4clOuIfWp102HZPyGbKiXmjZhirh5PXQuRwESYxa
         gZLmSdhGbuLAYqlgwrlW34KIVaf/VRh5phJnE+SqjvT3zbYpzqA6JOOvyih/o/L42pSY
         Nv9zZLqnktHtbcjMbfJTlZvqM1EiXqQFPY6XRlnORm5zbbKDNywegXTFjDqchmuUmHmu
         Cwm29IelfGv2BhLlCJ90RpQmaEltnMdlvKV24VYzC4tKZsKZje0+m5EntM7onlenGeHt
         Fm6A==
X-Forwarded-Encrypted: i=1; AL+hErHNulWSqCMOyqRf1PnXrZt4qf6kYJVLI6XyvXO/uMsts6fn6FapAJ9vusQ4SyU6DkrYsWtwIJUms1XRIkhxne5epFk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9GCagpy2VdBHZHE9QEcoL2m4sRQbj/Z3k+RvfXnX5Mm6k/9/nk
	2ukC1lX4kgiKhPtCjPLF382e0xf+jM0t8Telap9Oj+me4Oo3qUjxlpEKPE0R2pwNCWPb82p8Q0P
	eaUvtNzyEVIandsCfe8cTHA==
X-Received: from wmxt6-n1.prod.google.com ([2002:a05:600d:8646:10b0:4bb:6c3d:a4ef])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1549:b0:4bb:741d:ea8 with SMTP id 5b1f17b1804b1-4bb8880ad4amr475821795e9.7.1795792420044;
 Fri, 27 Nov 2026 07:13:40 -0800 (PST)
Date: Fri, 27 Nov 2026 15:13:24 +0000
In-Reply-To: <20261127151326.515232-1-vdonnefort@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261127151326.515232-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261127151326.515232-3-vdonnefort@google.com>
Subject: [PATCH v2 2/3] ring-buffer: Use kvzalloc_objs for remote buffer subbuf_ids
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Creating a remote ring buffer requires allocating an array of struct
buffer_page *. For large ring buffers, this contiguous allocation can
fail under memory fragmentation.

Switch it to kvzalloc_objs() to use the vmalloc fallback under memory
pressure.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/ring_buffer.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 484fb1c08682..bcff4c12680f 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2638,8 +2638,8 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, unsigned long nr_pages, int
 		cpu_buffer->remote = buffer->remote;
 		cpu_buffer->meta_page = (struct trace_buffer_meta *)(void *)desc->meta_va;
 		cpu_buffer->nr_pages = nr_pages;
-		cpu_buffer->subbuf_ids = kzalloc_objs(*cpu_buffer->subbuf_ids,
-						      cpu_buffer->nr_pages + 1);
+		cpu_buffer->subbuf_ids = kvzalloc_objs(*cpu_buffer->subbuf_ids,
+						       cpu_buffer->nr_pages + 1);
 		if (!cpu_buffer->subbuf_ids)
 			goto fail_free_reader;
 
@@ -2699,7 +2699,7 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, unsigned long nr_pages, int
 	return_ptr(cpu_buffer);
 
  fail_free_reader:
-	kfree(cpu_buffer->subbuf_ids);
+	kvfree(cpu_buffer->subbuf_ids);
 	free_buffer_page(cpu_buffer->reader_page);
 
 	return NULL;
@@ -2712,8 +2712,8 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
 
 	irq_work_sync(&cpu_buffer->irq_work.work);
 
-	if (cpu_buffer->remote)
-		kfree(cpu_buffer->subbuf_ids);
+	kvfree(cpu_buffer->subbuf_ids);
+	cpu_buffer->subbuf_ids = NULL;
 
 	free_buffer_page(cpu_buffer->reader_page);
 
-- 
2.56.1.839.g22a8290db9-goog

