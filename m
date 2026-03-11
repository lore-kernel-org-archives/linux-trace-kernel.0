Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763F61A6815;
	Wed, 11 Mar 2026 10:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773224185; cv=none; b=H/3rVtCqJy0UUpuuEZgeuuBJwwCHPglvWcKmYbTFUg6hWq870moGj7TQEKDNK8tyeU8K4E14CTP4slpXj51iZxlIBlB/osewWljTun2SFN5LH6W1Hk9+PAx0WYhd0ws2un6aZN75q4WU2dUm/+Fo06ito5abNm0YSRm+KADPpRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773224185; c=relaxed/simple;
	bh=RvfSYNLElMKLWMTrIcGIpEfFedIm7sR5605pT5E8TW4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rG6OQ8J2bUg0SKvhosgRs8EjIutSEQ9SNJDpl3AKCXoZI6PrZ1BF2yh+GAtC9bX4j7eqslLMvNLm+qy0OSx0LP4jP7HX6faJ4EpnWbtW1GwaqJlePi6MdKoB+dtzTRjk7b4279RX95PLXDlE0beJfro8Fc4xlcNi5GB2vWCE5TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dds2+onr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jCwWqRST; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dds2+onr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jCwWqRST"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773224183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hxeKUDc9QjCqDON/eW8Bk9qdboaknSu0XzAkuFYRR0w=;
	b=dds2+onrw+AHhHOEH6ya9+PVEuyVLmLHXkCu1mbhJZBY33d/7e5xoehrfEh6Ocg2Ex6rCD
	pTFn/Mefg8AR4eQNXdSVTycXSeNUUV8yBM4aBpSm/OQUMUCqkRhB91GCok0eEz5XaihUsB
	CV3jcMi5zftOhVBYFIPQmRxyI5QAxeX6b9aP6Wtc7kLdyI0dVnfnULwdIcxSse04apfYpQ
	3DOaVVCIH7Ia9wmo2H5iQybr9NhcWo7ymYcu/VAHz0tsmXMGSoOnu9niN2eAcAD92hugwD
	jUfYvBqrrjnOjwIxJ1NC2ScGIrsPaByO/okGA6G/VX9Ygg4yvtzMCLXKvGgRjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773224183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hxeKUDc9QjCqDON/eW8Bk9qdboaknSu0XzAkuFYRR0w=;
	b=jCwWqRSTjwJ1k7VBKrN1rFItJV1vdihsNkdKqBwmTSMsaYQHxuKJNFAjehPxjqWYqQeNFz
	yJ4d9jhvpdcrpqDg==
Date: Wed, 11 Mar 2026 11:15:17 +0100
Subject: [PATCH 08/12] hrtimer: Drop spurious space in 'enum
 hrtimer_base_type'
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260311-hrtimer-cleanups-v1-8-095357392669@linutronix.de>
References: <20260311-hrtimer-cleanups-v1-0-095357392669@linutronix.de>
In-Reply-To: <20260311-hrtimer-cleanups-v1-0-095357392669@linutronix.de>
To: Jan Kiszka <jan.kiszka@siemens.com>, 
 Kieran Bingham <kbingham@kernel.org>, John Stultz <jstultz@google.com>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Frederic Weisbecker <frederic@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773224171; l=708;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=RvfSYNLElMKLWMTrIcGIpEfFedIm7sR5605pT5E8TW4=;
 b=wWaij6brVOy/ScaSfQaOc3vSS1u+SR8TOtX34laF6PCAFAMMBCXM7AvUuiNB5XQa6pHExGWUK
 VwF9oHl3cuaBz83iwRSKv78AL2wG3HK4eKbnBv6vEjpqPWWOhJnX2vg
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

This spurious space makes grepping for the enum definition annoying.

Remove it.

Signed-off-by: Thomas Weißschuh (Schneider Electric) <thomas.weissschuh@linutronix.de>
---
 include/linux/hrtimer_defs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/hrtimer_defs.h b/include/linux/hrtimer_defs.h
index 0f851b2432c3..e6d4dc1b61e0 100644
--- a/include/linux/hrtimer_defs.h
+++ b/include/linux/hrtimer_defs.h
@@ -35,7 +35,7 @@ struct hrtimer_clock_base {
 	ktime_t				offset;
 } __hrtimer_clock_base_align;
 
-enum  hrtimer_base_type {
+enum hrtimer_base_type {
 	HRTIMER_BASE_MONOTONIC,
 	HRTIMER_BASE_REALTIME,
 	HRTIMER_BASE_BOOTTIME,

-- 
2.53.0

