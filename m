Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534175;
	b=eRl6PmYjAk59eLRVOLEFI3MeIC59r5NXBGEIvXIXY2c/ntXd7hvIZm9ZXN5n8ZDhYUvP
	 Kn5gD1Oi9YgqWw2pzlzVVI9EvWpXaEELIQ6dQgbMfYM6baQn3+tiBNfFhRMDJsc5r4Mrf
	 Jd1zabEVm7Ss13xdo8f/gl+Zy2VGctrRin/8HcDZFlCbxUdcC+eFlt0Zy8cP1EsclsZr3
	 QzgejGfsznzr2ZduR5aT1EOjffOQIsatYJghSk/xP/4dHE2HHfqomO+HVACSmeiM0V70T
	 bowLJQyEVmetvfTT7i/pRQYOMVbxSJHtNYIIiLiJY/W2VZahwKH6/+2Me321sxWkl7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534175;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=no3TwPGFG1MxOrMJHLzWszxB/ksmfixALujtZxX0S44=;
	b=N+L5K2PcqstwbtDYdN3WGCY/FEHNN3z2YVvUs7VFw0M7Tv5+YPUz3zJnAg/rz4/3q/re
	 rOQ6UW3SBXs+JEkcsFP4l9PE0lKBFb69cO8YsclCCdnCLNhx+cbOKkrYBRWaWVTHhr+j1
	 zfTYpw68PiBZ4AqQgI3IkPXg3qyESoGPWYzCufjNRnVFPHTkQaJiTCc4pzwlzGHG+xiqB
	 +eAEvP170VGyeZG6nfyJYj32LBRnhGQruSWh7XmjBf7C8mTxskoWoRd4E9D168s9CQjsf
	 awQE477D2YVnB1NeQ+WSrAuWivlyBT1T7XJRYcY9D2N9llcjhFPObAgzIS/lOzY5NSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eMbKAB7j;
	arc=none smtp.remote-ip=209.85.128.72
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1425360A3814
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 15:29:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1425360A3814
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eMbKAB7j
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a70b42bab0so45414385e9.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 07:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795534173; x=1796138973; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=no3TwPGFG1MxOrMJHLzWszxB/ksmfixALujtZxX0S44=;
        b=eMbKAB7jkcVpM+GkrKCRY0IoSMH9fabXB1aZjeepFzGopapSu+UVZuRvl4SFY/ux9I
         4bU+vzTMFjGnmsKnX4t9jkfQjRtVBiHCNA0b5/E15MO95Euoki6Vh1Byn9HDvg5p6XnZ
         cJFh19iQm8QPLvMJlpdZ/741v6vQRF828blOSfg6zaeOb6/2v0/O4McUVqbxjN1MiDMl
         SDUoyq44edM6NxKzegmadM4SD45sSF7whHgDznv2TzAdHO0WaJz6dUNZ83BaRhXBLmBj
         LFXVB7qZ3WKGnDpYhU+5KGucthy8cEDM/ojPo3hfmfPhiJTLoxwSv0FY7kxKGgabdCV6
         r5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795534173; x=1796138973;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=no3TwPGFG1MxOrMJHLzWszxB/ksmfixALujtZxX0S44=;
        b=vgiVBbK2erNRwiTBfoOwHAAOhgmkXLmuItH2DtKkWYl8lG8Uw03qWetIBWdjVqmtmV
         jT1k9fin3nZHEZVYqu2m8m1kNzyxzkYW2Q0B9wEVBfWaD+4Wnxk5qUoO6z32y+bcm+2/
         XISplOx23a6syDxK171I7jbYC323Bfm5fPmZmWfYzXWI2zQmB+oxenpLZ7yBd9gZPRbM
         F/FRKvWaNgxsiyOm+yLqiEYukReo8y3wvTL1sflpeRw1r+LUiulPwfAUg/VEj/FO/sgB
         kyph8LaWWgrM7kc5AUa9TUyyvzEueKy13a+fFuXz8MftSzSRxg7YtG76nMZ5709rsfu5
         V/Fw==
X-Forwarded-Encrypted: i=1; AL+hErF8yvUryb5YFN1cnDKbA3sVTCdnRrKqCwbo2es71iBdQABWdoSWFZB3U5dZu8kSEM9xHlrWnZ4qCn1+CV805a97EiI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+tuYGLlBoZ6N0HEju45Qh6U3XcaKKrUZXQZFNjg2XkaMY06pvG
	yffWd6/5a2w/J60lN/r/L/sbToa4gRmbrneoSVWgPiPJdOGGIO2QDgSCBI4TfA8KNuX5ZEYfwiZ
	KVDt+AdhrvvUBsLBvgeQn6g==
X-Received: from wrxg18.prod.google.com ([2002:a05:6000:1192:b0:49e:4855:28f6])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:2d42:b0:4ba:7a0:7b67 with SMTP id 5b1f17b1804b1-4bb8613a0b1mr234995995e9.3.1795534173080;
 Tue, 24 Nov 2026 07:29:33 -0800 (PST)
Date: Tue, 24 Nov 2026 15:28:39 +0000
In-Reply-To: <20261124152845.2233401-1-vdonnefort@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261124152845.2233401-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261124152845.2233401-16-vdonnefort@google.com>
Subject: [PATCH v9 15/21] tracing/remotes: Use ring_buffer_capacity() in trace_remote_has_cpu()
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

trace_remote_has_cpu() calls ring_buffer_poll_remote() only to check if
a CPU is in the trace_buffer cpumask, needlessly polling the meta-page
and waking up readers. Use ring_buffer_capacity() instead to check CPU
membership without taking reader_lock or triggering wakeups.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/trace_remote.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index f23d3386da29..3926871924bd 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -351,7 +351,7 @@ static bool trace_remote_has_cpu(struct trace_remote *remote, int cpu)
 	if (cpu == RING_BUFFER_ALL_CPUS)
 		return true;
 
-	return ring_buffer_poll_remote(remote->trace_buffer, cpu) == 0;
+	return ring_buffer_capacity(remote->trace_buffer, cpu) > 0;
 }
 
 static void __free_ring_buffer_iter(struct trace_remote_iterator *iter, int cpu)
-- 
2.56.1.809.ga0b61035b5-goog

