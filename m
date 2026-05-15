Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5B524677B
	for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 20:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778876187; cv=none; b=i65Ov3HiqmMCDE9XUD9vYdT0FZxjtbOH/FS+6zmBHHh7Za6P6/n5dnYE+eTmu+6ZatPTY8Rvw+1z0Ipny95dL0YFYBiE8Ielc2OHdHQ24cLfTyw64xdtvzUz8PtIimNLD2L0jcPgQ81elY8MKGn+kEIFMxt/Yizz7vSDwobj/jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778876187; c=relaxed/simple;
	bh=oGqhlVrBHPjTbeYR/l3T4e131ONVfyoEihixqwfrEl8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sYuCz8tb8ArxnK762FO4CGWVWBLSrT/QCAzogKeDhgGOexUTRyFPtZ7V+vx4pgfE2foylaJLlJbCVK2RUeFT0W49qVUcFy521/MpTAMXxh413SsnkVKdBo0IrvCPEILqsSNWsy3aFWBaGeL9XTh1ZrEVa0AE78pCE3QE53zDg5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KhMyfBPA; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KhMyfBPA"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-48fe6894f3fso1172545e9.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 13:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778876184; x=1779480984; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Xn/qawXhkyOeysVqBkhh0JVNgHPt7wlvemfSk7X4jRU=;
        b=KhMyfBPA7gZcNDyWmw27vXnsGXEyeSOiF6hQXJCs1iJDY9L94VdrZmoEaYQaKU9FQx
         FW81XzGGqzZ7I/eccMXvLNFOx/z79ugil1Uyh8Vb3XjCHjMqjZldD4UzmIbIdFkAGQ3g
         2qQTV6eKGH9BPER4BpFP5Pr4SpfODKeUwmd+i2rHOBEIX7awWj+cvk0fQoA2ZssEAXVe
         IlS3QcFfYFiNRte7F10RbcyrvCHxjLA61mnVfvqageKU2/fwgTa62QUfxiSXTpWxTUOL
         n0Zg4y/AskWuXHlyF+7P80N9EWGkZkpcyv3rR6jjWsr/Qf90dzuM7bjTtPTq7OYarXOt
         4jCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778876184; x=1779480984;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xn/qawXhkyOeysVqBkhh0JVNgHPt7wlvemfSk7X4jRU=;
        b=dS/uD9MUEHYWuT1OLTjN4DWZPiB3DRrQxD2ak+CiT8SStuPYvJcNOQJvNUUQo0Ni9c
         o3pAMCu9erKabmxIxKWQX2Zg0E4BxFIwgvftgCm3wEX8io+d5uV9cUOgKPadgcVv1nI5
         GK7jeva0Xfn4omMOKep2YDCv5dZSw2jRP8IQhDXTgkLywZWiI1R/ys0hq9KTZhFFW3zB
         MIIIdNpbcZ9+PJmyas2GsCL8koBUHQ06XmUEGn6ig5SSONUqD75+991sBSTeCN2nS2KN
         wx2U/LLdFvqHhXJIlFjywuPqWpzb/supoaEy1ECOXaPaEwPcd1mo4JUqpnI8zKvXNy0B
         qecQ==
X-Forwarded-Encrypted: i=1; AFNElJ/K06FcGDlDKG4j9ljvMOabSgVx3jS0X77P+R2h3Tqfh7HmMGVAMs6Hol2pbO4w5wTJvaB6hKn3aZitZPlI2jdMwKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwecMheHGzYeJ6sN4P4kxumTCgax77OlM+eYhkiU46GbgxUW6mc
	KFi21+JnY5JT+/j+i/ue9B4BWF9ai1kjQ43bouRs7Joe0zoAPvQZv59SMnsOkd3LVnt2v4LCCUx
	YMBQUWOarrx846Lb3292ytA==
X-Received: from wmbc23.prod.google.com ([2002:a7b:c017:0:b0:47d:5bef:a379])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8901:b0:485:ae14:8191 with SMTP id 5b1f17b1804b1-48fe60e3663mr62938555e9.5.1778876184095;
 Fri, 15 May 2026 13:16:24 -0700 (PDT)
Date: Fri, 15 May 2026 21:16:16 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515201616.337469-1-vdonnefort@google.com>
Subject: [PATCH] tracing: Fix desc in error path for the trace remote test module
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

During initialisation in remote_test_load(), if one of the
simple_ring_buffer fails to initialise, the error path attempts to
rollback initialised buffers. However, the rollback incorrectly uses the
global pointer to the trace descriptor, which is only set upon
successful load completion. Fix the error path by using the local
pointer to the descriptor.

Fixes: ea908a2b79c8 ("tracing: Add a trace remote module for testing")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/remote_test.c b/kernel/trace/remote_test.c
index 6c1b7701ddae..a3e2c9b606eb 100644
--- a/kernel/trace/remote_test.c
+++ b/kernel/trace/remote_test.c
@@ -110,9 +110,9 @@ static struct trace_buffer_desc *remote_test_load(unsigned long size, void *unus
 	return remote_test_buffer_desc;
 
 err_unload:
-	for_each_ring_buffer_desc(rb_desc, cpu, remote_test_buffer_desc)
+	for_each_ring_buffer_desc(rb_desc, cpu, desc)
 		remote_test_unload_simple_rb(rb_desc->cpu);
-	trace_remote_free_buffer(remote_test_buffer_desc);
+	trace_remote_free_buffer(desc);
 
 err_free_desc:
 	kfree(desc);

base-commit: 5d6919055dec134de3c40167a490f33c74c12581
-- 
2.54.0.563.g4f69b47b94-goog

