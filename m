Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794413200;
	b=el4QXNCOYFK4k5+beWSZTgvNi3lLdYqgU+C/ZiJW7pH24XcRJNOzkP3AFT574QB5blaG
	 SB9Y7VBJjZPQZKrMx668QigmUXsRKWQ+O6+bYRxOsKmr5MjZBROFR2wR+i4KxjvYpEHik
	 20H/6f8KFUXAr9yv2uIkRQz2UC4qtJ5qV7noAwS6eln+63LGZBaMyXg9t6hsFbLxSMpnk
	 FOjX6hvmHk992Gm5rrP+fpoopHSJtVWsEuqOJZNGysON9q7VW+Dnz9Vtk6kCzbp7c63t9
	 3R6pAfPaPeYgSYo8or6u8SuW+4ViqSgFzg6saZFyWCXLXPI9r8o5WKLLk7O7M+Kh4zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413200;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=Zwnj5luvWXI+zz4DC9yFt+NfwoUiaj5sZIrQqKOOYdI=;
	b=NPBNWD10Xdl0Yol1QFZjrc7qT6VBswLFAlYTXDyxlc1aCjHJ3/iK1ToavUJQZkuCM341
	 7aBI+gLkkEGGvFsZA5SMo0EbAmnMJ8D5Qu0LCGZCDPmk3A8IvCUTaxkt+qnN7WI6bZ03t
	 hhBFptNRNEDyRMtOa0eSCH7qKs8JEGxzvYaQq3CqxGoCLlrMKicgpHVei14KGwRja7ZaY
	 IC4ixBMXDb2Pu3jM4HPHWi//F23OurMslGuTEf/X4fGVnTQZy9aJ9YU2KkKQomj2YxjDl
	 VEAckMu0/V5x/qHwozS2Ris4ZzKv9ZaFLxfEg5sZvXNU4Frwe0BgCiL21gc3E84cLOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PxbkSNeg;
	arc=none smtp.remote-ip=209.85.221.72
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EFA606A326
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Nov 2026 16:06:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40EFA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PxbkSNeg
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48e1d839ddaso2222535f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Nov 2026 08:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794413198; x=1795017998; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zwnj5luvWXI+zz4DC9yFt+NfwoUiaj5sZIrQqKOOYdI=;
        b=PxbkSNegdHa5QRH+K7DvMOloPelPQYAJmS+J789kpMcOnguhvxPgJjJh8+XdHOm8ZD
         3Q6tcMLdmgJTA7Gs1eorYmURm0o4JNOAFRBMOWMya5xKrOAaEV+N58I4MRvjaeLxngTk
         IDsKsqBp3jz8uqRNJ81SIPSj2UrfSMjjRv8VrjoHp67d0UqxLtinLPTJbN9B9XxQTQKX
         ibuX6wXov+foqaRc/3spXZW+1Cz11kyZDRaAYsoz9duSX1OE/yGMOZiWN8NL8TqfC5LI
         8aXqNr/VugfaZWuMObmWIF6RdlSyPF3ZM+H8cD/UJcXvuZmi4F8RSGMKarqw+Is8Dg6Q
         ViCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794413198; x=1795017998;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zwnj5luvWXI+zz4DC9yFt+NfwoUiaj5sZIrQqKOOYdI=;
        b=DJy20NPrOoPl/yFCGERdmntmEIbdsmQGGjlWDGEgG5XwPENDXxUmnFw2m3+VcFO1bB
         mT2P0lHuQXVGPTgxdNodGyjZTh+6tQUGHpx6Pfxjz4x7jJmrzyAHopZYWyBaJXRh+lz1
         Er62xnj9B7KeIKdSbmmVznStC3MiYFkX7bYm5wffmp634ykHUnX2J1HB5ecpKoGQSHVG
         k9V9Ir9e03DeyWp7B57bwCwx7NpO2rsfNDy0ToFDtMHJG4PMtIRBnG6UWfsjArwBvUyL
         Sss9tgbSrmJGBeGPNJr//GIw4pKBLG1u65q/CR8N8T+UVT3QUNSi9myfGckSf4uhbdi1
         rVqw==
X-Forwarded-Encrypted: i=1; AL+hErG1/Np16Yd+a+kWq1iJLs8N+YB7I/dRVxvJrUWiIHuAAB5T9aCyQcVVe4zy07q6Tn4KjJ9cyAbKbQ6YhGT6OhPxpsY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+BSE9r7nFV7/dUVSOoDd7gQdV7ga35oUOB4xyGthNR5gl3X346
	b2tj87iSX8QYAfK3IurVNzerH5v4kFoPEYct/2W7JGPc010Wj6/GKBhrFh9SZi7KvGHMFnvqJ2Q
	WDN/Q4rygtPvDrVeZUVn2Zw==
X-Received: from wroj9.prod.google.com ([2002:adf:f009:0:b0:48d:ef24:b9a0])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5d0a:0:b0:493:c0a:5087 with SMTP id ffacd0b85a97d-499c75526fcmr6092201f8f.51.1794413198261;
 Wed, 11 Nov 2026 08:06:38 -0800 (PST)
Date: Wed, 11 Nov 2026 16:06:24 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261111160624.1294946-1-vdonnefort@google.com>
Subject: [PATCH] ring-buffer: Let the reader spin on head page update
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>, 
	Breno Leitao <leitao@debian.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When a writer hits the head page, it needs to move it. The update
happens in two steps: first it swaps the HEAD link for UPDATE and then
swaps the following from NORMAL to HEAD. However, if a stale
cpu_buffer->head_page sits past the UPDATE link, rb_set_head_page() will
find HEAD directly and allow swapping.

This is where things gets hairy. If a outer update is interrupted before
setting HEAD, this nested writer finishes the update first. Another CPU
running trace_pipe can swap that newly installed head page with its
reader page. Now back to the outer writer. It resumes and tries to swap
the following link from NORMAL to HEAD. It sees PAGE_MOVED which is
fatal for the ring buffer.

To prevent the race, mark the newly moved head links with HEAD_UPDATE
(HEAD | UPDATE) and only convert the final link to PAGE_HEAD when the
outer writer exists rb_handle_head_page(). This effectively keeps the
reader spinning.

Fixes: 77ae365eca89 ("ring-buffer: make lockless")
Reported-by: Breno Leitao <leitao@debian.org>
Closes: https://lore.kernel.org/all/20261105-ring-buffer-head-moved-v2-1-05da40cebccc@debian.org/
Cc: stable@vger.kernel.org
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/ring_buffer.c | 44 +++++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 1fd28a72e6ee..73f31e6719f9 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1306,6 +1306,7 @@ EXPORT_SYMBOL_GPL(ring_buffer_normalize_time_stamp);
 #define RB_PAGE_NORMAL		0UL
 #define RB_PAGE_HEAD		1UL
 #define RB_PAGE_UPDATE		2UL
+#define RB_PAGE_HEAD_UPDATE	(RB_PAGE_HEAD | RB_PAGE_UPDATE)
 
 
 #define RB_FLAG_MASK		3UL
@@ -1455,6 +1456,15 @@ static int rb_head_page_set_head(struct ring_buffer_per_cpu *cpu_buffer,
 				old_flag, RB_PAGE_HEAD);
 }
 
+static int rb_head_page_set_head_update(struct ring_buffer_per_cpu *cpu_buffer,
+					struct buffer_page *head,
+					struct buffer_page *prev,
+					int old_flag)
+{
+	return rb_head_page_set(cpu_buffer, head, prev,
+				old_flag, RB_PAGE_HEAD_UPDATE);
+}
+
 static int rb_head_page_set_normal(struct ring_buffer_per_cpu *cpu_buffer,
 				   struct buffer_page *head,
 				   struct buffer_page *prev,
@@ -3699,6 +3709,11 @@ rb_handle_head_page(struct ring_buffer_per_cpu *cpu_buffer,
 	type = rb_head_page_set_update(cpu_buffer, next_page, tail_page,
 				       RB_PAGE_HEAD);
 
+	/* We have interrupted an update */
+	if (type == RB_PAGE_HEAD_UPDATE)
+		type = rb_head_page_set_update(cpu_buffer, next_page, tail_page,
+					       RB_PAGE_HEAD_UPDATE);
+
 	/*
 	 * type can be one of four:
 	 *  NORMAL - an interrupt already moved it for us
@@ -3711,6 +3726,7 @@ rb_handle_head_page(struct ring_buffer_per_cpu *cpu_buffer,
 	 */
 
 	switch (type) {
+	case RB_PAGE_HEAD_UPDATE:
 	case RB_PAGE_HEAD:
 		/*
 		 * We changed the head to UPDATE, thus
@@ -3773,8 +3789,8 @@ rb_handle_head_page(struct ring_buffer_per_cpu *cpu_buffer,
 	new_head = next_page;
 	rb_inc_page(&new_head);
 
-	ret = rb_head_page_set_head(cpu_buffer, new_head, next_page,
-				    RB_PAGE_NORMAL);
+	ret = rb_head_page_set_head_update(cpu_buffer, new_head, next_page,
+					   RB_PAGE_NORMAL);
 
 	/*
 	 * Valid returns are:
@@ -3785,7 +3801,7 @@ rb_handle_head_page(struct ring_buffer_per_cpu *cpu_buffer,
 	 *               the page forward again.
 	 */
 	switch (ret) {
-	case RB_PAGE_HEAD:
+	case RB_PAGE_HEAD_UPDATE:
 	case RB_PAGE_NORMAL:
 		/* OK */
 		break;
@@ -3816,7 +3832,7 @@ rb_handle_head_page(struct ring_buffer_per_cpu *cpu_buffer,
 		    buffer_tail_page != next_page)
 			rb_head_page_set_normal(cpu_buffer, new_head,
 						next_page,
-						RB_PAGE_HEAD);
+						RB_PAGE_HEAD_UPDATE);
 	}
 
 	/*
@@ -3824,7 +3840,7 @@ rb_handle_head_page(struct ring_buffer_per_cpu *cpu_buffer,
 	 * changed the original pointer from HEAD to UPDATE),
 	 * then it is up to us to reset it to NORMAL.
 	 */
-	if (type == RB_PAGE_HEAD) {
+	if (type == RB_PAGE_HEAD || type == RB_PAGE_HEAD_UPDATE) {
 		ret = rb_head_page_set_normal(cpu_buffer, next_page,
 					      tail_page,
 					      RB_PAGE_UPDATE);
@@ -3833,6 +3849,24 @@ rb_handle_head_page(struct ring_buffer_per_cpu *cpu_buffer,
 			return -1;
 	}
 
+	if (type == RB_PAGE_HEAD) {
+		struct buffer_page *prev_page;
+
+		do {
+			/* Interrupts might have moved the head further  */
+			while (!rb_is_head_page(new_head, new_head->list.prev))
+				rb_inc_page(&new_head);
+
+			prev_page = new_head;
+			rb_dec_page(&prev_page);
+
+			/* Try to release the reader */
+			ret = rb_head_page_set_head(cpu_buffer, new_head, prev_page,
+						    RB_PAGE_HEAD_UPDATE);
+
+		} while (ret != (RB_PAGE_HEAD_UPDATE));
+	}
+
 	return 0;
 }
 

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.56.0.542.g3ef89b7020-goog

