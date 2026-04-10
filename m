Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126F58C1F
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Apr 2026 12:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775825140; cv=none; b=rv8vDvA9shOXx8+6o/9bfqPDvwAf7FC/M3AuKseSNvTrlsj4lIf4fW94rywH6mWjwRDNnfmyEG7sbPT9BkT1XhEoOf2rKp2PQeZHyppH/Ty2ljjqA5xzg+k0fTB6FVRJXtRdgUReiORHRNvLKIu3kXaRuyx/q9G99DWiZhBy42A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775825140; c=relaxed/simple;
	bh=QHiukfKSmwMd57SgXEaDANZ0GnMRsME8FwRdtZB9Mtc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VG9m6d3vXa5etJKkOa8H+Svqn7Yjf8Z3yUHFceEuN0ItTBC6GzRiXW6ULj7ArRBFbSaniW1EiQzoEDW7Tr1HS1HpJR7iePy3vA9zBIOAyTg9Y1Wn9PPoKOqGOixrsgcgnnc8boa4IXMExhNi4Jsz3DyVtl/9265C/wNJQ0G1fRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GZLqt15T; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GZLqt15T"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-488d64eba6eso5264285e9.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Apr 2026 05:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775825137; x=1776429937; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=apY7Ejl8X5JBwAsC8h7VHQdCvb1Zq/PpjmokFJg+xQw=;
        b=GZLqt15T+z2W8h9fqW4QmSCLGS9Ja1PnIeZub+3U3fgkVyirr0y5WxbXWhDyg92EBX
         A7/IybLZNR6CO6lo14AXj62vI8H/5vqIFjqsSWdNFXPuvQPJ87dFgT7Tg/MINJO/T7EP
         WeoiUj6Xp2jc2J5B1EpxPDwjy7vI/entKwLKtwN8o+LQJWwckErXZf70kDyEI1A1jj52
         Uk+H2tN2kyoZvKLrPdZyZvV9RjTnnuzwXN25w25BhfFDN8pELgg35wLgRqzozMOJ8Eaw
         dwQeMUn71il+mWG6Tx8tPmeCCCvpZ4CCKMRbT/qSTXbYXWjssPps8rnbP5dOLp8sNSKg
         nt2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775825137; x=1776429937;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=apY7Ejl8X5JBwAsC8h7VHQdCvb1Zq/PpjmokFJg+xQw=;
        b=N3LaK5iYQ5OLauvIJFOvG4EkUrR9aWZ6LL5rXSihXVUyyRjqpzL4TQDqhcGAFxLbbr
         5jdsHaJJHBK1yNc8r86VL3noe248EODlZS1KnPsHNqrKnks6rHj0bp9rL1p8+C4BHWUn
         74Liq0QcJbhH11CwzjsY1Opv3VYRg0h4rbtkLTgR+rNTpEJPYEW4GyVJ3HMqgBKUGKHC
         jYtLIibnivxOAhTrnByRqDapfTAdNvfbc+qepR94DCIF5TTcaAgrkQ9wMd5+idb+esx7
         /xKeLrJuHeJMkG5M4UR15FMizf1pnXAmNQQQwrhb9d0Vx9QQgJ4KO1CZDV517U5qtea9
         9Ndw==
X-Forwarded-Encrypted: i=1; AJvYcCWCOwB0PgIbQNmfROfy646P073l0q0c1e+5AR53HS8c5I238Dpfp6uK66qfnQ9EWh/4IVz1MbfMQzA2rccax2b6Y04=@vger.kernel.org
X-Gm-Message-State: AOJu0YzACAo6VqXOm2o95Ge2ZDefPBAGrdN+FUm6/Cq9chx86h2eNhjw
	Ujkw+KhovXzVvVQI7+BrMZ16FmqyBrewNqocmusHSQh3Th9EQ1wP8iSrSPm6RIsjMnI3VDWXS4o
	3c46QYgKaXMCT0vKamVf5pA==
X-Received: from wmoo3.prod.google.com ([2002:a05:600d:103:b0:480:6b05:6b94])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:45ce:b0:488:a8f0:35bd with SMTP id 5b1f17b1804b1-488d67df745mr38438805e9.8.1775825137170;
 Fri, 10 Apr 2026 05:45:37 -0700 (PDT)
Date: Fri, 10 Apr 2026 13:45:27 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260410124527.3563970-1-vdonnefort@google.com>
Subject: [PATCH] ring-buffer: Prevent off-by-one array access in ring_buffer_desc_page()
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>, Dan Carpenter <error27@gmail.com>
Content-Type: text/plain; charset="UTF-8"

As pointed out by Smatch, the ring-buffer descriptor array page_va is
counted by nr_page_va, but the accessor ring_buffer_desc_page() allows
access off by one.

Currently, this does not cause problems, as the page ID always comes
from a trusted source. Nonetheless, ensure robustness and fix the
accessor. While at it, make the page_id unsigned.

Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

--- 

Currently based on kvmarm/next.

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 96e0d80d492b..2c77020e7aac 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2238,9 +2238,9 @@ static struct ring_buffer_desc *ring_buffer_desc(struct trace_buffer_desc *trace
 	return NULL;
 }
 
-static void *ring_buffer_desc_page(struct ring_buffer_desc *desc, int page_id)
+static void *ring_buffer_desc_page(struct ring_buffer_desc *desc, unsigned int page_id)
 {
-	return page_id > desc->nr_page_va ? NULL : (void *)desc->page_va[page_id];
+	return page_id >= desc->nr_page_va ? NULL : (void *)desc->page_va[page_id];
 }
 
 static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,

base-commit: 94b4ae79ebb42a8a6f2124b4d4b033b15a98e4f9
-- 
2.53.0.1213.gd9a14994de-goog

