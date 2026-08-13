Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3490F47B436
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 13:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786626719; cv=none; b=g7VRd8iUg12+A6sYs6dmEAfr+vK2vHI3+OdVvYRoAqfFfbSDfq+8spO5EQLrHr+3A16SvX9WMb0X0azxbVFgeSGpTZeLrvCP2N6qUc9FFD702ielBlembBshp/VUHI2lfTKItsUoZkk8bonwqDmnq1xt7cMLx6AhXHNmoaAbUas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786626719; c=relaxed/simple;
	bh=RnyxOYCwhQgTKJ1d8W1Pm0f+ZLeYf+TecB/avfsb4Jk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UjFpatzxKJfpDkfTzvd0gXE50as0ectKTMWJ2FxSYydrOfDf0SM3jZte5szRviSkYUxMiSQXJvIvQEysvbrN6psRtqllfmsOWBLuh2Gngq/FLk0KStB8KbPYPALXdPWMnyqGW7Vw5H7GUxJh6gYANkWzgj/EmnuMUIMW+db1168=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sGHR2iyn; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sGHR2iyn"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-495474a5fbcso19769445e9.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 06:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786626716; x=1787231516; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mYJnf32SraedkkQAhf1lNG9n6MN2rsucTWkpU2qB8LU=;
        b=sGHR2iynkyES4Xrn8XksWr32EK3390m5CYr3Unl0uI9YG2YUhaiZTGXe1bUWB5B5vI
         2p6FV38iRtAfv/uCFYte1HZp043bSyqSIbGYYGyIfFmiqoFQmVqoGkMcePzZZ82SBQL0
         oemJDA8PIqjqOXWZqeI6M1ZydItRtZ66lpCrtBCZGdOkwKxvwihB9TjiiJZHACvzgzNn
         YbHj84Hfl1uhVSRKpSy2g/HO4svUHRBvB7F4b4oRAwsW31L5qdDkeNNO0ZuTk2s4ejPG
         Q48bpZRlCAJ9oDS7MNv6xo2MuKy8bodi3aEmaGdyyt5Eub5cE7COITg1HHPrHv+LMTHE
         Pvsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786626716; x=1787231516;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mYJnf32SraedkkQAhf1lNG9n6MN2rsucTWkpU2qB8LU=;
        b=azlFKs8RF0nPalQDV+KqWWorHACV6v8m4Cf4UKCI6k4vRuzh/3hP66Io7nFGYinHqD
         P9KfOJhyZ5wwSPe1GIajfRQMtQflBFC34WYEDspIlnTEHopL/TmwXy38PbyJiymQX1o3
         5sku+70GPMkQT279qdgSy0t4LrEsprWWXxBR5tFLX7BDpVKmOx00RYwFw7ZRee1uhFkq
         P8MBo8HWrZvPzHbS993ndc91hVo6QpgJW+xQctXdJD78gbYUvuQtmnGJ03yCOA6nDdlK
         zVwxFR9eEOIO4rDTg7LW0ZrYtIonC8qm/mZQ78RqmLOAqNmNI3Dnv/N3SGujiX7BQ9U/
         /O5w==
X-Forwarded-Encrypted: i=1; AHgh+RqZTRiWpukS2xBCP2Y/BQcabEFGn4JUL9YJBgkSvXDlg+QPw6fPUMLWzzrDjm0IXjzxcTZfvSIwcgUmhOEzZKFKjGs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3m/5I15RUqvy5/ofJjyBygaQavR0gqyaz4sa3xEM4C4i6KDEz
	jknHKZ0vktZ5sMHXndy8BVzBN+ncXbR/cWaszMFcYi6uJrYYoswg9u/qefWEg30mg4pPJVoeO5z
	X1mN2ApYX/rGpRiR5qMK5Zg==
X-Received: from wmbds12.prod.google.com ([2002:a05:600c:628c:b0:493:bccc:32b3])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1394:b0:499:51cc:4e57 with SMTP id 5b1f17b1804b1-49982158b47mr55151435e9.0.1786626716251;
 Thu, 13 Aug 2026 06:11:56 -0700 (PDT)
Date: Thu, 13 Aug 2026 14:11:43 +0100
In-Reply-To: <20260813131152.3589632-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260813131152.3589632-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813131152.3589632-2-vdonnefort@google.com>
Subject: [PATCH v5 01/10] ring-buffer: Free cpu_buffer::free_page with subbuf_order
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

When sub-buffers use an order greater than 0, cpu_buffer->free_page is
allocated with subbuf_order. Use the correct order for
cpu_buffer->free_page.

Fixes: f9b94daa542a ("ring-buffer: Set new size of the ring buffer sub page")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 2667992f0aa2..a3d28b2e2c94 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2631,7 +2631,7 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
 		free_buffer_page(bpage);
 	}
 
-	free_page((unsigned long)cpu_buffer->free_page);
+	free_pages((unsigned long)cpu_buffer->free_page, cpu_buffer->buffer->subbuf_order);
 
 	kfree(cpu_buffer);
 }
-- 
2.55.0.691.gc56d675ccc-goog

