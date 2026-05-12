Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCF23ABDB3
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 14:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595397; cv=none; b=G+o/Wc5XmKIyuOw/rUwfCWCzHwtT4XsnG85N/Zc+gKb7O8+5YrIqwD0upXKoJ5eyshIfVSXJbzEcWdpbDkxw5WD1PLglCHvxUtU3DPaTDtZWCbJemorqkya6FQwSW1iUY9ituBE+Fl3oa3Vms+a790UU2tepMa6HGYi/wH3rwZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595397; c=relaxed/simple;
	bh=+pvSXS7XVUpZLC4Qfn8lqGZRoGOJMlgvm+YiXmauHiQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TUuvXxe1RPKSt8eYaknSiXRM17dOKlgUOLCyEz4u42pEG4M8fjDD7V/zEmxFmZQEuNfHEftBdbOsplq2jUs541BhOm1qN+kXm29wW6Wb1ASnWHeoNmi6hFUK7bJKI3xoH2nxRklyJu8y8z8tRcC5zE/BqdRaJadrakoArtW19Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XHujWxIV; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XHujWxIV"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-48919890a95so36287765e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 07:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778595394; x=1779200194; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AjdMVS+Gqxj/UjkX/xDpQn17rf4oZGlc/0W592FJZA0=;
        b=XHujWxIVKNGets3sK1j6uYVrltxpvIAttI4VaNGEsuXFOJKAXig8a6Qp1Rj6QH8ykV
         2GQu8wMHzZCIOuL/D82cvf5hvmt4thBn3slbu94L84G0cvnbOl83aiFO3TzDzaAQtYXT
         ILxlRVMuPGx6LOFln+8a40jl+2D6sSFbbAIkn02A0UUURy5VZzleqiNdl5DWvO2sRcMV
         g0Wgy1MZVWl0Y5ZzBUxO1I7/+RiYRNyci8Ax9Vak6RovpnyHm7VxtQOJVVIZVlUxofME
         FmR4lY9WGZUjsTsaHBhMSEzgB84m1kxYNPafIwdI22P/2ZLoxl7nvoYWc5+Ra0E/4XgM
         yVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778595394; x=1779200194;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AjdMVS+Gqxj/UjkX/xDpQn17rf4oZGlc/0W592FJZA0=;
        b=C/LOJt0IRN3XcTOM2aP4yv4zhn2qEuXOLBZeh2ztWsVkZCQGiI0fUZqTZYO4KnwT/C
         KwmcZDpm2Ep7yTu6b6UBQDeP68u62eEvgy6Y77ruVBiJLqwxwDH7rTPQQxEJdrwP6VqH
         FrkeLDYIy9192LhTPBYfHMRQL7L44VZ8p0Bc/QdyKhaWCWq+oCSKCNgeL9dx9QnMj5te
         nxatyBfnvcO8Y7UEUjG7bwx0c+A/507hhB9sYsce0Kad2dR3yTNJraDokWk62rnyvwaY
         wO6f02bZmwsqCgjwr8sOkshDQTSYX4et52vyS7E2FlbxROCH5CwZ6Pd8aZgyEfEZWqzj
         ht2g==
X-Forwarded-Encrypted: i=1; AFNElJ82Vpt3kpRixzvSWWMTd2m4l/MEo+qLm03Aau4rYJMZVJmTKsf0qShBLzKT0PceqRqwbbl48bekaj6K6tOSkRD5WFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAL1vrLlkYhYYdy462HGxVOiv59go/Zi/1TmkfY1CZafY/hUn9
	ha0cypKDDBxTgTkujw5YMjE/Rk9uSMiM2UH18pgWW8QVAJRVsirJQE42YZ19I47CV+gmcK8Fp3y
	0sjIrpHspAuzaYy1XORHoGQ==
X-Received: from wmbhu22.prod.google.com ([2002:a05:600c:a296:b0:488:c686:2b56])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:18:b0:488:b811:51c4 with SMTP id 5b1f17b1804b1-48e51f3c4f4mr379715275e9.25.1778595394169;
 Tue, 12 May 2026 07:16:34 -0700 (PDT)
Date: Tue, 12 May 2026 15:16:14 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512141614.1759430-1-vdonnefort@google.com>
Subject: [PATCH] tracing: Fix unload_page for simple_ring_buffer init rollback
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

The unload_page callback expects the return value of load_page() as its
argument: ret = load_page(va); unload(ret). Fix the rollback code in
simple_ring_buffer_init_mm() where the descriptor's VA is used instead
of the loaded page address.

Fixes: 635923081c79 ("tracing: load/unload page callbacks for simple_ring_buffer")
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/simple_ring_buffer.c b/kernel/trace/simple_ring_buffer.c
index 02af2297ae5a..38cf9abe0be8 100644
--- a/kernel/trace/simple_ring_buffer.c
+++ b/kernel/trace/simple_ring_buffer.c
@@ -431,7 +431,7 @@ int simple_ring_buffer_init_mm(struct simple_rb_per_cpu *cpu_buffer,
 
 	if (ret) {
 		for (i--; i >= 0; i--)
-			unload_page((void *)desc->page_va[i]);
+			unload_page(bpages[i].page);
 		unload_page(cpu_buffer->meta);
 
 		return ret;

base-commit: 5d6919055dec134de3c40167a490f33c74c12581
-- 
2.54.0.563.g4f69b47b94-goog

