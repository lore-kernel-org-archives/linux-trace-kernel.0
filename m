Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697903DAAB0
	for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Aug 2026 12:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786366634; cv=none; b=hTYR6zECY5iWgWl9jkp+U72pYLrs+ATQhtAD7OpgbUlNnKB8iV8Fr8deblMd4i/mFGdlIIsNuVA+pDP2VrO9jgNc1hmUHCAoWD6Ufa6hdu8053gostFifCK8c4nqATQS7wqNnpY6gercsoZTbW5Q0EADcIbSiPUyJ6BkruHXHZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786366634; c=relaxed/simple;
	bh=OCC11WT+L0V1cHbP4680wTmAV6r/xDAuXXa+GfOkaho=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cfV9sqO0DQzarUsGoFQrCyIDJWpRkLYIFvArx4Nr/V4jCsji3ZpnsN/Yhym3F/kv6ouD+WnNCmxQZQ2wAOf/RDbHHKL9NcuJWIeMFZAW2uch55QNvMBKartdmhEdbov9jWm3oujpN1DKhp2svmmVrnqv2DH200/f8ktm/+h4uCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ltpfSQt9; arc=none smtp.client-ip=209.85.221.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ltpfSQt9"
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47fe85684b9so1596596f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Aug 2026 05:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786366631; x=1786971431; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lnUv13X3Cbui6u5X9Nc10vpxGzYNp5ZKvp/hBJ6VPvY=;
        b=ltpfSQt9LvjupofvlFrot0h/SEchKxW2d7XN5MCEBUWfsIsN7iz2ZRhL74eZKi6pjf
         56YoktfmsEVYXVsbqCGy3NqlDZzJQzWa1rCV7YXwUvxwt20x+NS5iY+NjA8VQpdZBGw9
         Jp1LJ/wwUKWsUBsZfUibqABo09QkZFQ0cjhbv/X6hkTV149Q4+QjmvNgNYG8brwU4XTd
         8TJzc5Xmuo8nwRjIHKpu0FhyJPt5znMyxns1Z7t5QB897Oz5XmyXLWWMIcewAX4TNCr/
         U1zwzEk4oWcPUnhyVhaUwHIKs9CANMz4RmCnTwOY59gAuMNYHRyQHCx8XeV0WQfSuDfx
         PXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786366631; x=1786971431;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lnUv13X3Cbui6u5X9Nc10vpxGzYNp5ZKvp/hBJ6VPvY=;
        b=Wy9cjx09wAG6kGWEvQy4mw95AhzPtZ/9Gh7R77ai6RE8oHOvHqdy0cdcrEqr15qIC+
         JXZNlnWXaxnxe7w1fpG1VaPBV4z4lSDOxLwR5u+dK52pyY8K+BX2XL/wpp54t3aH1sFE
         snSqBTyVnWUJcpThg55LHaPaqgbOdK2/03VasTpoy+cd3+x2t+vbbFy37w7oHjnlHX7j
         witw+bWBtLoxSqmFoaW8fPYAtcyPT8Uxb1k7+UdfDkBgrEbbXJevzk9l+ucfQ6zQuVC3
         EB6j/SmC1tRnbQkqcor66szPSg8luneR/pRD9sALbZcLL/Wb997sb/t27SyszDI3dGyp
         JJGg==
X-Forwarded-Encrypted: i=1; AHgh+Rp3e/IyZkrJSPoI+34gFLQxszbabcuMjK009VSUjGdnUInZIgxdTxNJcKX9p6rQKs68QaHz84ZvBD34pguEfDWvU9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyY7QsCV3LZ9Xox+T97GoBLoO1TBEnsKPlC+mA/h8QBmNpdrsv
	hmY1XSVsNaC4Q5Pu7C9Rh7KNGNr1OgGtSIeHiLDgs0u+up2pxniIjlHs3DpwsVsgTA4RWIk3TKt
	EnGDXZV5EyAhqSlfHjb1L5g==
X-Received: from wruj18.prod.google.com ([2002:a5d:6192:0:b0:47f:87c5:6f9f])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5850:0:b0:47f:7964:9887 with SMTP id ffacd0b85a97d-4814565ec16mr2541620f8f.25.1786366630409;
 Mon, 10 Aug 2026 05:57:10 -0700 (PDT)
Date: Mon, 10 Aug 2026 13:56:30 +0100
In-Reply-To: <20260810125633.3344684-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260810125633.3344684-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260810125633.3344684-4-vdonnefort@google.com>
Subject: [PATCH 3/6] ring-buffer: Free cpu_buffer->free_page with subbuf_order
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
index 026658c70351..ac5f5d9502dd 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2654,7 +2654,7 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
 		free_buffer_page(bpage);
 	}
 
-	free_page((unsigned long)cpu_buffer->free_page);
+	free_pages((unsigned long)cpu_buffer->free_page, cpu_buffer->buffer->subbuf_order);
 
 	kfree(cpu_buffer);
 }
-- 
2.55.0.654.g21b8a5bc05-goog

