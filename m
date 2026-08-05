Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D063147DD71
	for <linux-trace-kernel@vger.kernel.org>; Wed,  5 Aug 2026 15:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785943963; cv=none; b=ox1fJdVEED30xbMSSCVANwb0nzSmdHnphMGYbwx9/KiMHXA/4LJvum6mT8JWuK6LDeCfdsB9tibojhIVhoZJa+pUy0YsHvLXXEmrirzAv42/W5KvuRMbbJsOhGqGd4gB7jl2mv2UUphQBA7luAtmQQEeeji9gUMMd7+berSN3BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785943963; c=relaxed/simple;
	bh=fSfHKUXXjeuaF5GoHZqzt3ghM/ntROBEcVxwVLLKf5c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=U+RLXfUB/4C8H/DgmfYJF4nQTXQviAj8Hsb542jbVPrIxQkbHduoQSVx/Y92VkEt6MYW6Qctdbbg0JYu1iVd1UNuVl7KKqoilh6bsOA1EUvKuKAaKxM1OwX1ED3vYdxKySGM0XcAL9NgQzm5YjXafch1pXJ3xG0MjEelKltdvpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=stizqqRa; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="stizqqRa"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-496b61bd846so8873125e9.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 05 Aug 2026 08:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785943956; x=1786548756; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dURYyTAr3xD5Ug+KUce+nub8IT6QTcigszEQZYZJDrw=;
        b=stizqqRanQgIpndQuGOLsWECD1eUKSphGBcuRy9HaX7RvLdQAeBkQTPHvabUKA8hfM
         9H5FlYe9l2D+Bvc61C8ae0/JTEc9i0P73nXSZJLfcYcaUZkVoVOH+kHnEiqI0FKojpUM
         jnD2zGqeC9f35TdYO4ttmecm4dg7al1bpIavSfuoDesmWtbxCYY2ih6M/E3R13u5mJBi
         HSqq2X8Bth7811djhAb17gR01dmYkJhdfeBBPYAFIzq9Ge+ogTeAgcQl50qbjHKA3ptz
         LcuV5JohOUXogHZ2UZuLpvHTIMSsGtTq2/GL9cdWuPBJvn0XpWMNaUcs9gZJFFKwezCR
         AOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785943956; x=1786548756;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dURYyTAr3xD5Ug+KUce+nub8IT6QTcigszEQZYZJDrw=;
        b=cPLpoe1rtH3xPcuDr52xmsZkY+kx7Ij6KnXAGqPzs4LfPjb/bl5lftZ4sWl2C+yosk
         OH9Qs5v3pN7vb4n8FYN+j0xj5RNQ+UuKc4K5Pqrnn+jbhVaKC8wt6bL3xeEyU0Jv24wR
         4juHXN8JHbQOGULR8PPxfOm3WIjscQY3Y45b3aPHW9H7sVwxk9h/EoZ2OPTwfLd0b3Wa
         37H2RztvuLJVggmg5rvu9wnYB/bIIQQmtcV0TXCMMPKyaKSC7WJd8OZDxV4Dz4AuXmvw
         6alq739QST6u1oHS4q26Xpf/NIpQZWPF7KjJR9iYJ4GULfvLl4S+iCDVTj2PfpxTXK18
         tYxw==
X-Forwarded-Encrypted: i=1; AHgh+RpSAJVFmPY1GUa0pyWbwaJDF4IxiOEYAz7piCkATnnAHBWDjA0jxzTTbeHgPsLLUFmnud9uj4MY0QuHcL+wtLdNdyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFQUlMM+eUptsr39urXmAmyXXYCvqohD9NREGGy30ad+kkzr2f
	ExYWzYlXkN7KFYbXHzGsU8MpVyHYmPbsWrVqchpWSUN5PGqzGLd7XFyMBZ0A3wziasfjoIt1M0S
	ZOc9gGO+1lB0E6oNZaQBlrA==
X-Received: from wmby14.prod.google.com ([2002:a05:600c:c04e:b0:495:3c12:fb52])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4595:b0:498:952:e276 with SMTP id 5b1f17b1804b1-4994e79e377mr64342435e9.8.1785943955841;
 Wed, 05 Aug 2026 08:32:35 -0700 (PDT)
Date: Wed,  5 Aug 2026 16:32:24 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260805153225.2096152-1-vdonnefort@google.com>
Subject: [PATCH] ring-buffer: Prevent subbuf order change when resizing is disabled
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>, 
	syzbot+e0cc44465d6bae735679@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Because ring_buffer_subbuf_order_set() frees buffer pages, we can't
allow it when risizing is disabled. A non-consuming reader is at risk of
use-after-free (rb_advance_iter()).

Return -EBUSY on resize_disabled, matching ring_buffer_resize()
behaviour.

Fixes: f9b94daa542a ("ring-buffer: Set new size of the ring buffer sub page")
Reported-by: syzbot+e0cc44465d6bae735679@syzkaller.appspotmail.com
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 8e2485bb3aa8..414bca2121a7 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7358,7 +7358,7 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 
 		cpu_buffer = buffer->buffers[cpu];
 
-		if (cpu_buffer->mapped) {
+		if (atomic_read(&cpu_buffer->resize_disabled)) {
 			err = -EBUSY;
 			goto error;
 		}

base-commit: 075b74841bd0065a3bda3440873c747938e69b68
-- 
2.55.0.571.g244d577d93-goog

