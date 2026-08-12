Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF8025F7A9
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 15:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786548815; cv=none; b=uhGc5oqH/TgD2dcI5JaZfiHHIgKkjz9g+mrAOfj70im4DEMCQYp6GopMaqM73zf59AGVnM9dRKunyo2orsRpTzeats21lUGvudGfsooYJ6a4P6kU6TB9hs20SfDFVE5erGFsgxZRh8/FhlFJPrlEhIXd8jhnKqeH5nkbNj/EGJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786548815; c=relaxed/simple;
	bh=RnyxOYCwhQgTKJ1d8W1Pm0f+ZLeYf+TecB/avfsb4Jk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f96fZhpdYhBrM6T58xkRVMsIDkrSS+ybX2uDMfiJDr3cswQlmj9cN79B18ju1QRkjeyebL4dLSUtvBMco/zbcdPswJiHvpXLMWPxIIweIygExe6DiWL2Qg94om+tk8lJyVrY2vw1KxoChnSV0Usdyjdrrt36YMuBWV70I0FdNXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fSEVNOCw; arc=none smtp.client-ip=209.85.221.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fSEVNOCw"
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47f7039fa59so897636f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 08:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786548808; x=1787153608; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mYJnf32SraedkkQAhf1lNG9n6MN2rsucTWkpU2qB8LU=;
        b=fSEVNOCwALQXTxgKUxiKYdnSAiBEzYPzLmS8z90WjTf5zJUwHOfFEnMAOo38KBwRzX
         KyiqX/DZ5/MArOvDwPVxvsGDvgUJsDoYQmNj1+baQJO1zUckDsHym1G1SCUD+IdRopHd
         8E+11kmkxKQQ+fwsNyasagrzvsI1WHyzGOeiu1adkhzxX2aD2exxe2bYnwhGKUwllgs6
         3al/kcDSOyKvJUe+Dlzel2ZMtjJ182m6zOfM0+00iJUbmk2wxl92Zq9Uzx4CJJwRmZ1+
         GFvDA4vbHiCaGYYfHbHbG6H0iYsq40j+KPCGoHLgOwJHN6AoF7/CighkM2lDCsZEW+54
         WaGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786548808; x=1787153608;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mYJnf32SraedkkQAhf1lNG9n6MN2rsucTWkpU2qB8LU=;
        b=feBlswDIHaKGGJzSOCw/s7YmFd01VoCIBLPiVfwW+02aJop+iLpOVe+zq1gkKQx5Q/
         /CCTabYFKMMkHzmiHL8OWXIG7g6c8V3KZ1LYTSkDelhrKMH/XkkCbqXsO4+YBYgLYhY5
         SNmYZwiY4HoCodMwefNpI3t2ehl/LjCKynE40ThljZbR/fcnd06DRkzYRRunbGOkh97R
         JJhFVnpSGDo9ZaPgWeaUlLNDaABH7Frxzhr5e5sWRV14q6mi0ctC9DCHyX6XSpd4QlI4
         vZ1k/s8nALPfjkOkg/wqK8veD07OEGazCgA8QaVFWP9EJniMui0l7n2Na7os1CIL6nce
         WagQ==
X-Forwarded-Encrypted: i=1; AHgh+RqDGG0WbkZPDGkgwsxaf+QqHonb8fMumt1I9LhdqFRElT7aaI3Ss0kiqIkxo/IBIaxNl1iJkcav8wu1UkaGrM7ae4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YykTJp7MdyXIsIIZ+gMDVLiNGT9iTsmD/iHyIQWhGNwzCzm0r2y
	Im3ZZdnY6oFXOY7kQZ/76XGQMJAoNe+fyZjUk+8sjkbi7gtg6HjE9ESlsQ05pD8rv3PjPr5LCDp
	RPM3dqY25MaE5fFrf93CtGQ==
X-Received: from wrms2.prod.google.com ([2002:adf:ea82:0:b0:47f:ffcf:7045])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:188e:b0:47e:81aa:3832 with SMTP id ffacd0b85a97d-481528f7238mr7770005f8f.16.1786548807933;
 Wed, 12 Aug 2026 08:33:27 -0700 (PDT)
Date: Wed, 12 Aug 2026 16:33:02 +0100
In-Reply-To: <20260812153311.2328812-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812153311.2328812-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260812153311.2328812-2-vdonnefort@google.com>
Subject: [PATCH v4 1/9] ring-buffer: Free cpu_buffer->free_page with subbuf_order
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

