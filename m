Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38DB41DDE0
	for <linux-trace-kernel@vger.kernel.org>; Thu,  6 Aug 2026 21:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786050801; cv=none; b=thsrJ7D2MFLyVely/75VjxaCdRugUlD4dXXF7euNUUHfwUtjyR3K8NPR76GeZzRxnvDHAwrGMIcm+DB4IVd1qAV7BRNfBYkCutFytANSnxVgQEX8uvST9QRXFV5NoyYQJkIxQmQ+PcyT7oan/a055DxlMJTmVlu+q+kgYyfL6uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786050801; c=relaxed/simple;
	bh=QABeFqv5vm7y4l9zYcsDQh/2hptTBzOFxvoQQTklkNk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q1HdGQvUrtLZczXTvjInM5gpbCAiZvjB3rNMBrsTZ5PoW24NboLNLYFKS857/LcE80/Ok8UrFAgV1Jj1YKAHGkLFSpcYOVUIqhHJqMQL6nba4AOCBdVNND4ho/zZ4+49/yzlv1lJG0PVbMWsgMKLA9ryrR82MtpbBL39/Sdd864=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DuXiSy0q; arc=none smtp.client-ip=209.85.221.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DuXiSy0q"
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f810c8aebso1450634f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 06 Aug 2026 14:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786050798; x=1786655598; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZDpTMgs+MuJW7J1fuvMNA6XwWWg7jUXIYsnAB+W7ptE=;
        b=DuXiSy0q7a9F91nhgHJCOmMGbXWV+jtmSZyGzmmMGgY0TLVy3C7bDU4+dYYTX51lmO
         ZzjDaJU8oN6Xol9+oCRVeflBeQn3zxUpjNFnXAf+K7ATPhiUfd9g76oj+y1lD1bUHyrm
         N2tj+kYjRgmk3ibIZ5BQT1C4xw4BZUexeQL9UQvIKXCEkSqmRmsdbcGPC7NAQICvP3tb
         CZlP4Vf2dkDSzaVg5sZq4Bz8j74gB7iEt9lpCPR82XaYZ4SWhEwROXcVVSkx/PTKzC7E
         xGjVPzwk4UT9cmPCoI3D2M2bHWAytO2IBao9USUTPZFkh9sBB8YTYSCmfwpGy2Id14JF
         b8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786050798; x=1786655598;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZDpTMgs+MuJW7J1fuvMNA6XwWWg7jUXIYsnAB+W7ptE=;
        b=hyEAFrmkWl9AeAsw+Jy2Fq6c67Q9a8h5UmX7l0gtNY0L+kHYXGCbquGQbyH18uDTo7
         sUmi+BbEPyqO822pggaCV/TtNVJiBdR+0RTF7BD2Qx1F/Co65IW1XTRcQ0dM15yJVTAQ
         WUup5bKXNtoQp8o/4l/j2HuMFT7lH6v673ujMnhXUcr5OZ423GHIw3Whj3GZlUrvZOH+
         vXAXthge21XvUw+m4piSLge9pwKbJWIDsgP2hWc4TBrIvc2ZAF6ejorsJVj7/DVt0h2n
         AAKV0GTAI3uvN9UCiD9ku+3agxDcgoews/kRDpg+DbDb0VXIZiulw6cJ++dJ8H3VI0f6
         cqXg==
X-Forwarded-Encrypted: i=1; AHgh+RrbfO0Rd7TEviYEoVPHgvR1z6j/DGvEPs0vvXsNEzI8RPLxFmmD1bqwxywpbKtPHjmzB/0BPwkMTgaQd0DMiP0w3Gs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJfBcWbzFQAGJBEW/CJYqdDE+7h2UYrTAsw503yZYpTl4v25Nb
	fqUH7eCoqdpSuajOmIPraNAkE5TeryjGJMzd1f44havZera5cEfXjQnUqTlif3VF8WPNe5V4yI9
	0BubibVBsRZebhIB+DR+0NQ==
X-Received: from wrtw18.prod.google.com ([2002:a5d:6092:0:b0:47f:6d55:abcd])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:adf:d006:0:b0:47f:9171:bca2 with SMTP id ffacd0b85a97d-47fec62a14amr22660270f8f.27.1786050797658;
 Thu, 06 Aug 2026 14:13:17 -0700 (PDT)
Date: Thu,  6 Aug 2026 22:13:02 +0100
In-Reply-To: <20260806211306.3704194-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806211306.3704194-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260806211306.3704194-3-vdonnefort@google.com>
Subject: [PATCH 2/6] ring-buffer: Prevent subbuf order change when resizing is disabled
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>, 
	syzbot+e0cc44465d6bae735679@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Because ring_buffer_subbuf_order_set() frees buffer pages, we can't
allow it when resizing is disabled. A non-consuming reader is at risk of
use-after-free (rb_advance_iter()).

Return -EBUSY on resize_disabled, matching ring_buffer_resize()
behaviour.

Fixes: f9b94daa542a ("ring-buffer: Set new size of the ring buffer sub page")
Reported-by: syzbot+e0cc44465d6bae735679@syzkaller.appspotmail.com
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index afe75ad2bbf2..9bc467c4dbbb 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7360,7 +7360,7 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 
 		cpu_buffer = buffer->buffers[cpu];
 
-		if (cpu_buffer->mapped) {
+		if (atomic_read(&cpu_buffer->resize_disabled)) {
 			err = -EBUSY;
 			goto error;
 		}
-- 
2.55.0.654.g21b8a5bc05-goog

