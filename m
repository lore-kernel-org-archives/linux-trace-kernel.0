Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B1B3126BE;
	Fri, 21 Nov 2025 22:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763763557; cv=none; b=GDTFHedqJB4I5y891lOXL17qTP7PffS+Pfh8rToIL+JRo438hI/Wl1E2+d/ADoYQjrVmFZckWGXQ8VRf3KWyn6zyHJAyCgKxCIer/0ygdd3SAsQg33oMlEbDwoumVKtjGCThw8X85DTPh9ixkeEkRtruo6B+H1jRPWW529/97/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763763557; c=relaxed/simple;
	bh=yubC8PuJvLF4/uWHY4mN+kjRTeCm/EFGciqabiOoPgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CASD4M429yJQiMa2K6gFp+2SyiB0g3l52DVQnnbW7kNczZ8GlqGS6mNhKeGWxDz3qYRUifS7VHjOgRpnyOjV8oiWSXxA3rWrBuct0KuKdaN6asEL9wgvW5Ikdvf5WK95rt9uMoL8Y3oAEKwdbOPrg14FXqcEpBIg4Ww0Gy9/W9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=kf8bsl/q; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=kf8bsl/q; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="kf8bsl/q";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="kf8bsl/q"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4dCqPt3430z9t7y;
	Fri, 21 Nov 2025 23:19:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1763763554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rV74SyKIOeyPnRNVk/rDsjW3bGAcoUJBRPo2AjvLfoo=;
	b=kf8bsl/qyDqgemmM1cZ2nnINJQqP32juoIYpjdpyzAGthGQxHYo16pptQOoKyMWDe8vseU
	yt2KsZ+Bw5dnBfVCC1o7zCYFoJ9XxEN0zf6f0JQRplgZJP+jzz7WEmZIkC4QzOC9pOwfel
	wu5WxlusBr8U/EGNfZ1X5lxOysc5cVnRugglgnOGVKI8QkdpPwhTj5V4ruutzgVco3UEwy
	rAKDY8klq0dlS23TquBWrCD03bn/2KEHNCdFIfGcsoUJwgGywYlxp4eLB2nVaC3eA30+ij
	m6e6CTgANYmCGNd1LsTydDEDLC9yZ/MRn9s2LppOVLtanLQe0dZG7cKYG3EiIQ==
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1763763554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rV74SyKIOeyPnRNVk/rDsjW3bGAcoUJBRPo2AjvLfoo=;
	b=kf8bsl/qyDqgemmM1cZ2nnINJQqP32juoIYpjdpyzAGthGQxHYo16pptQOoKyMWDe8vseU
	yt2KsZ+Bw5dnBfVCC1o7zCYFoJ9XxEN0zf6f0JQRplgZJP+jzz7WEmZIkC4QzOC9pOwfel
	wu5WxlusBr8U/EGNfZ1X5lxOysc5cVnRugglgnOGVKI8QkdpPwhTj5V4ruutzgVco3UEwy
	rAKDY8klq0dlS23TquBWrCD03bn/2KEHNCdFIfGcsoUJwgGywYlxp4eLB2nVaC3eA30+ij
	m6e6CTgANYmCGNd1LsTydDEDLC9yZ/MRn9s2LppOVLtanLQe0dZG7cKYG3EiIQ==
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhi@mailbox.org
Subject: [PATCH v2 12/13] tracing: Fix typo in trace_probe.c
Date: Fri, 21 Nov 2025 23:18:34 +0100
Message-ID: <20251121221835.28032-14-mhi@mailbox.org>
In-Reply-To: <20251121221835.28032-1-mhi@mailbox.org>
References: <20251121221835.28032-1-mhi@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: hkunoq1uyywj9zxif4q4eq7wymf76acb
X-MBO-RS-ID: e32cc73331b7fcaa25a

Fix typo "separater" to "separator".

Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
 kernel/trace/trace_probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index bb67f6a2136c..2f571083ce9e 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -517,7 +517,7 @@ static void clear_btf_context(struct traceprobe_parse_context *ctx)
 	}
 }
 
-/* Return 1 if the field separater is arrow operator ('->') */
+/* Return 1 if the field separator is arrow operator ('->') */
 static int split_next_field(char *varname, char **next_field,
 			    struct traceprobe_parse_context *ctx)
 {
-- 
2.50.1

