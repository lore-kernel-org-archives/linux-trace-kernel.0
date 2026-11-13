Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794583657;
	b=yjzAaAvlFcKBeGzF9UXKVjedz97xycsfryr5dtpUZS5+ol4Z4mzTPKygpROzkqPdWaDg
	 ic4ZNyFrYACoyIx1XdDzo3eY+2Fs4VU1rGmTi9rmKyQp2jtjPnUwsUlfZ8sPkTfnMgXzo
	 AljiYJLJ95gf/tMNQcEpPHGnaw0kJQ2OiPhvFP5W1zfmN+bSH/WNTI7qzSo8Axy/qW2IR
	 CFE4LEo9A5Hc4TQ8oxC7t0Mns59aI2AQxxvFNIW55ettl7e6cj41Fiw32+RVIhnddKtCg
	 uS40/P8g+E1H3+xFThHzN29IJyuDsjuSCP+sSwfM9FQRkYZT0E+LUMzjtV1QsBHzWwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794583657;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=FrGK4LQCQBqx0hUtkMsYYjxe3VECT+KAsWnhnUDOZDM=;
	b=vo4ZA0fl/QnJfp2pN+PBWyrR+Rj2YYg5X97PZCw8QpVNKIgl0qCLzZV62E8zJZ3YdEl/
	 5ptNrexqSsR1YtB+f59f3ouD8oQ3IRED4MhnSQKlUiJdIiGnzE/NoqWsgJs8/A2COLqE+
	 9MsI+84LaetvIgzEX7YXhrMpEsjVRYvZyHWn6XMnTLgZPCRmVBl80TPSa6IvRV0YKB1mH
	 A41YESnYrQckBQJWVbQFLaOIun4LJtyQ8D1XcHfbdnpHtkZSBeyMZWDSUSCstVIa8dk/G
	 dd0jfYy2Mcfk6hERh6JLa826AxUqFfgI+Y/2lcajECwyvMFGwHtuo1VE2+xjDqv9x+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lbGQVyka;
	arc=none smtp.remote-ip=209.85.128.72
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1639606A89B
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 15:27:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1639606A89B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lbGQVyka
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4ba078f26f4so6705925e9.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 07:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794583655; x=1795188455; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FrGK4LQCQBqx0hUtkMsYYjxe3VECT+KAsWnhnUDOZDM=;
        b=lbGQVykauPq3rzPl+rYk4kEwNYQrN/P4fG033HJrEKxLSymRIV+nR2A0z67u7F+1PW
         vZlF0WX9pVUANdVwBtolDAbdNeaLB2eXYIU8GoZzR3+6lTCUsrJfSwlw5fkkPYQuSGYC
         rrbPKT/ZIFjXQlqQDk9t/UYO62wGzMAiLO3Ej6gTzW7QF9F48hR01asi7RQLjcchiKpW
         mmAzUVBlVgCmRilly/l4ik1UsdOO7SDMtY2ZgUfKfNdYYGyTKFJNa1nFCQL3enIhGXW3
         qVD+YewRBkpy8v0ERnp5zgLq9zhdKwELXSDqwfjkV+sCQz8O5pIAIDIoTdL6f+VCJfgM
         4b5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794583655; x=1795188455;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FrGK4LQCQBqx0hUtkMsYYjxe3VECT+KAsWnhnUDOZDM=;
        b=OEaNBugnN4lCW6ajBLboEqP1KI5YN8WmGEIWTLZUs25OLp3XqGkI5G4Sc2GNWHON7W
         +6ENwyJxH6XIJhNIQgLCPO3+Bk/MQKEzt1C42OY2jRL1SwxXzNiBMSogYwYbgfjuIovk
         VgnHEcEHvGLITiMmkmvO6DcalER4I15FEhdEw+q4TI30HJ6ShhfvHD+x7GOhk5oWJtgC
         vk1DkJTrrMW3tfSkbzOmeJJTBBjQmw/kxn6A/OBBe2swBhMM9cUN/mTZNtMcTgesjeWs
         KD81ZkubBZ2DD4Q3yHCGyNzFaqNprAEL1iRZhQxvUHuz72DxMttl82KwnhtzxAfu91Q0
         7FWw==
X-Forwarded-Encrypted: i=1; AL+hErFV1XZgIOyOlYEiDPO0hZD5fW4UYQfyimV9I8V97+pIetrYcG420pP/VtfsQ2KovGsQmYZ3WKHA2Th12JH+nDBaTAM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+C8+HsN+OPiv9QSlqeI+P+u/rf6btetxCOCrMym9hKKBDjynOj
	739UcaYZuBaAupIWbyikQDSpLevnYFabKk03W9CjGsqxNTzfGeJP79YFt9MqlgRXNsjFXqYpR3j
	nt+QoWGIEl4lVjxty8aBoXQ==
X-Received: from wmfv1.prod.google.com ([2002:a05:600c:15c1:b0:4a1:fe2c:3323])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1c0d:b0:4ba:59f7:9032 with SMTP id 5b1f17b1804b1-4bb55c5f60dmr71390435e9.10.1794583654644;
 Fri, 13 Nov 2026 07:27:34 -0800 (PST)
Date: Fri, 13 Nov 2026 15:27:12 +0000
In-Reply-To: <20261113152729.837429-1-vdonnefort@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113152729.837429-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261113152729.837429-4-vdonnefort@google.com>
Subject: [PATCH v1 3/4] ring-buffer: Order remote page commit with data and timestamp
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, bgrzesik@google.com, 
	Vincent Donnefort <vdonnefort@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

__rb_get_reader_page_from_remote() uses page::commit to check if more
data is available for consumption. However, it needs to make sure that
data and page::time_stamp are not stale. Enforce page::commit order with
page::data and page::time_stamp, and defer updating read_stamp on page
swap until rb_page_size() confirms committed data is present.

Cc: stable@vger.kernel.org
Fixes: 2e67fabd8b77 ("ring-buffer: Introduce ring-buffer remotes")
Fixes: 34e5b958bdad ("tracing: Introduce simple_ring_buffer")
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/ring_buffer.c        | 23 ++++++++++++++++-------
 kernel/trace/simple_ring_buffer.c |  5 +++++
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index f70010e2ede7..6016d16d1566 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5832,11 +5832,8 @@ __rb_get_reader_page_from_remote(struct ring_buffer_per_cpu *cpu_buffer)
 	smp_rmb();
 
 	/* More to read on the reader page */
-	if (cpu_buffer->reader_page->read < rb_page_size(cpu_buffer->reader_page)) {
-		if (!cpu_buffer->reader_page->read)
-			cpu_buffer->read_stamp = cpu_buffer->reader_page->page->time_stamp;
-		return cpu_buffer->reader_page;
-	}
+	if (cpu_buffer->reader_page->read < rb_page_size(cpu_buffer->reader_page))
+		goto out;
 
 	if (!rb_num_of_entries(cpu_buffer))
 		return NULL;
@@ -5883,10 +5880,22 @@ __rb_get_reader_page_from_remote(struct ring_buffer_per_cpu *cpu_buffer)
 	cpu_buffer->reader_page = new_reader;
 	cpu_buffer->reader_page->read = 0;
 	cpu_buffer->pages = &new_head->list;
-	cpu_buffer->read_stamp = new_reader->page->time_stamp;
 	cpu_buffer->lost_events = cpu_buffer->meta_page->reader.lost_events;
 
-	return rb_page_size(cpu_buffer->reader_page) ? cpu_buffer->reader_page : NULL;
+	if (!rb_page_size(cpu_buffer->reader_page))
+		return NULL;
+
+out:
+	/*
+	 * Order page::commit read before page::data and page::time_stamp, most
+	 * likely paired with simple_ring_buffer_commit().
+	 */
+	smp_rmb();
+
+	if (!cpu_buffer->reader_page->read)
+		cpu_buffer->read_stamp = cpu_buffer->reader_page->page->time_stamp;
+
+	return cpu_buffer->reader_page;
 }
 
 static struct buffer_page *
diff --git a/kernel/trace/simple_ring_buffer.c b/kernel/trace/simple_ring_buffer.c
index 5f14ba152fba..2dddaef638dc 100644
--- a/kernel/trace/simple_ring_buffer.c
+++ b/kernel/trace/simple_ring_buffer.c
@@ -307,6 +307,11 @@ EXPORT_SYMBOL_GPL(simple_ring_buffer_reserve);
  */
 void simple_ring_buffer_commit(struct simple_rb_per_cpu *cpu_buffer)
 {
+	/*
+	 * Order page::data and page::time_stamp before page::commit. Paired
+	 * with __rb_get_reader_page_from_remote().
+	 */
+	smp_wmb();
 	local_set(&cpu_buffer->tail_page->page->commit,
 		  cpu_buffer->tail_page->write);
 
-- 
2.56.0.611.g1030f0b940-goog

