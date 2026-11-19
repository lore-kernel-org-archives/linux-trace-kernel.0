Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116156;
	b=EZ7yQQOqsHeCps0/6c/+rI5Ce6DqZIrJPc9F9EvzT6UY+pEMPC8vt6+Ry22dDPOrPST1
	 Et4LjhnrdbvWiPnueXZIpAQNGDtbpc5psxSQqbhB0j7rzTVJMOgXfVYkHbZEA3KoTN/z8
	 Uxn7z1bSVZYzOWUgm9kRSacn9NedCrNfUq7HJHMXSlFdOgPvSYm3qOmL+itSRvivA4bwR
	 4h550QPbAs8QSGzL0SkKaJI/u1QmqoFIde9oTzcFPY481tE5i5+w0yIYsmM6Mur3Gydgc
	 J86E+fN2AF6k5PnvVfBYRmoQ8fqvd8CFgmOw3Lo0Ivx/pwnkEei3E4JxQFwtrR9zNfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116156;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=5AWBPDr0HQpp4mKVAW/tYzafCeAMEU1ur2Y/7G6Rffk=;
	b=eOzNKFluK8zKGnV0YRQ1NwDJPAp0IQgBfrJkp/PoKioi3GaYOKVGRgQGsqVzvphqD7gY
	 5RWivwo27G7L/hYvm0f3OFdYYwlR2gJUuGOxXT5f4MIYHt1Kac15Ae7GEJKKYj00p90yK
	 R9y+BELjbqyaazPc9u+Ec5rNF65tH84v9F2avQ4PPAlN74xIBc7ApeEcuT0SL0P0/Lbk8
	 8KcoiZy9YXL7AlRzIbjeeWTdSIyLy9YhNKeYaVjrWN7wy95fccS/YJ/iLmotULOTiqxbN
	 ZZaJh/wrJ2oTdWCQi5aSrFzUecS6r+GOCrQxKHhtIlsqxGpNeI1pf6jjSOyEqa2sh8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=T6q7vru1;
	arc=none smtp.remote-ip=209.85.128.69
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4496D606A320
	for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Nov 2026 19:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4496D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=T6q7vru1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a009f82bedso336225e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Nov 2026 11:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795116155; x=1795720955; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5AWBPDr0HQpp4mKVAW/tYzafCeAMEU1ur2Y/7G6Rffk=;
        b=T6q7vru11bZmo75UmF1a1JupQjTo39tyIWWehnSAujwZdId1rsKdiWdP3yeiDiCkbb
         QCLi6LvzX/2U9MSizx1vBQRWDgnJOJMQ4q5pfBmt2NhS6i043WDPKR1Pe13cRxk5yxdV
         7h0lWuYtfY1sNLA+p9CxHh/kN1JcFP4hjgJtTsaEf4UfhBj0p+AWaNlA4I/ZDLYYTiqB
         WQRx67la0b6GVPV1qyjl3w00EoyNE5BxPzd694gGufO4bYwS5GBr/0F2kh/kKj+JQDuw
         s1gsU/5xeiNubpaKPS4ZUYDHen6NIGbQAs+PQkq/OWeqstrH80g5eCHjmzhkD3lL4sBw
         4QLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795116155; x=1795720955;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5AWBPDr0HQpp4mKVAW/tYzafCeAMEU1ur2Y/7G6Rffk=;
        b=ENXXYa8eOsdEWn2XBaiTcP8OUg+qZNRZrWukEEHteJkuepgbAzQ6uvgihFHNb2poIt
         IZVIKj3YDUdztNxaNCsMpRyqqUu6pzwQjmg2af/f8MJ7iV3a8BkMSCeJzXTfm/FvAF0x
         H18gmyGBcd0i7Bu6UPGTTWIEIxFGaD4CJcJ6IqneIGkcCKI6Fxc9ZpNvNcooNESxmI+S
         9SJrWZ/rhYqyFA5f7PjIsvsQTiZOY4CtCGXLa6YWpiYwAerqHdrITH9NMQzdvajVXxwL
         1x6rdtz66FZI0nK5oShDFAUX5LT3eQ8CwJ6UuKNzNpLu8qJXfg7U1xHbgyad076e732L
         iz9Q==
X-Forwarded-Encrypted: i=1; AL+hErEzS4xFLrVokIFjKE+5CEbD80ooaC+/9Qc+i7wh9lWIh2nMWFgANmcIwFw0mTSlZYf7TzeYxJOSRuP1l127qed6E2g=@vger.kernel.org
X-Gm-Message-State: APuU4Z+deNvXIfALJaIAnv67zg9qf6sp2PS/C7Vtc5lhRx+VbeDVJ+j6
	Ft7n/irHTLOnzCqN9RUPJv9H4oU5WUB64TdT541BP7zethcRXHAx7BEJ4XkhemDk+6mdfyvDHg=
	=
X-Received: from wmcq4.prod.google.com ([2002:a05:600c:c104:b0:4bb:52ec:7054])
 (user=dmnk job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600d:600b:b0:4a2:cbe:bec2
 with SMTP id 5b1f17b1804b1-4bb8882375cmr11520435e9.32.1795116154251; Thu, 19
 Nov 2026 11:22:34 -0800 (PST)
Date: Thu, 19 Nov 2026 20:22:33 +0100
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261119192233.2664654-1-dmnk@google.com>
Subject: [PATCH] tracing: check kallsyms_show_value() for numeric addresses in
 .function filter
From: Dominik Maier <dmnk@google.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org, 
	dmnk+artist@google.com, Dominik Maier <dmnk@google.com>
Content-Type: text/plain; charset="UTF-8"

In parse_pred(), the .function filter modifier accepts either a symbol
name or a raw numeric kernel address (such as 0xffffffff81000000) and
resolves it through kallsyms_lookup_size_offset().

While tracefs defaults to mode 0700, task-scoped counting tracepoint
events can be opened via perf_event_open() under default
perf_event_paranoid = 2 and configured via PERF_EVENT_IOC_SET_FILTER.
Allowing raw numeric addresses in .function predicates without checking
kallsyms_show_value(current_cred()) lets callers without kallsyms
address visibility test whether candidate kernel addresses fall within a
valid symbol despite kptr_restrict.

Gate raw numeric address parsing in the .function branch of parse_pred()
on kallsyms_show_value(current_cred()), matching other tracing paths
such as trace_kprobe and bpf_trace while keeping symbol-name filtering
unchanged.

This issue was discovered with an AI-assisted code review tool (ARTIST)
and reproduced in QEMU/KVM on an unmodified v7.4-rc3 kernel without
kernel modifications or error injection. The fix was verified against
the reproducer in QEMU/KVM, compile-tested with -Werror, and checked
with checkpatch.pl --strict.

Fixes: e6745a4da964 ("tracing: Add a way to filter function addresses to function names")
Signed-off-by: Dominik Maier <dmnk@google.com>
---
 kernel/trace/trace_events_filter.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index c10951b..9192f3e 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -8,6 +8,7 @@
 #include <linux/uaccess.h>
 #include <linux/module.h>
 #include <linux/ctype.h>
+#include <linux/kallsyms.h>
 #include <linux/mutex.h>
 #include <linux/perf_event.h>
 #include <linux/slab.h>
@@ -1760,6 +1761,10 @@ static int parse_pred(const char *str, void *data,
 		}
 
 		if (isdigit(str[i])) {
+			if (!kallsyms_show_value(current_cred())) {
+				parse_error(pe, FILT_ERR_INVALID_VALUE, pos + i);
+				goto err_free;
+			}
 			/* We allow 0xDEADBEEF */
 			while (isalnum(str[i]))
 				i++;
-- 
2.56.1.750.gf70dc682cf-goog

