Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AC12F8E88;
	Sun,  7 Jun 2026 07:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780817409; cv=none; b=eR00Uxn09OZaBI6Lef9iQgdA5tT3cDI16R6wz/IbZxxjD7JY4ZpDl+2VboZPYOvxvh4kD3JiTuYXZMfJDo2CYMLYvZTLajE3XRGnH/pBTSB07OI4nnaKkvmlYhe6zh2L1FQzs4qUns2YcplHp5CIhr/azHWRy9H+VAeuf7u7CVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780817409; c=relaxed/simple;
	bh=EJS7A/wEAmBTsJQ6NcrhhgNvyUPkBirlnep1mxNluuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nYyxjUfBw1xRwBcwavkbp+664OtKQBmcqtZ4k9IY5o71LiYySm8EOHDyj4R71SFlK5Y5+o2ptFIGt7n40i4fmalcBX0breF3AOV/7ULxY8lRQ+MfIDjUmR35OE+ckV1cflvWIxSUIgI3Uua6aaY8Rwv8NzY5fOEfOqy4+son6wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=O+Pr5+tE; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="O+Pr5+tE"
Received: from hwang4-g16.. (unknown [120.244.199.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id BFA0D42049;
	Sun,  7 Jun 2026 07:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1780817081;
	bh=2FQxyjFfMjGMU2Su/NTyLwgvdlIjIUbAZkH2HU6daJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=O+Pr5+tEzURexoklTb6DT1ypm/jxJdItKVAGwChozCPjrs2UzqXy4kNY96X3JLD0w
	 9PGDNlHqQFPjzAd6O5HzpYoPV0wQwmwUo0Gq8cGW7BeQR6AKndMg4MxoFFpTrIw9KR
	 yR0qkDvm1J0OFpaKl6aavi3IO+hK4foenUUMLkMIkUGLac15+W6hktUu54cZ+Gbj7B
	 AZonphXryYJPBrjmDfFR2aUadQseY9R/eJV9pDRaXrOEjgYXqrma63To8mBiVesV3p
	 5xVBfPIlObC6gqZkekdCZu5yzHape1KMuHG0dN1clVbzOdZ4VMp/zw8/YjVoNWhox0
	 TWFAMKP+w7gr1EktSP9yHKlY7bx+bZLHDVFGQlaY0sSrmLXnxtnT/qGDVJ/U+BVw3S
	 bUk5T68Vai/LsqWl3wgS7vboadiUbuKnjiv1umaucxlIp7LlpeTWio5Hc2Nua4zwHZ
	 M8nz3a/KWIOBFkPw4mb2ekufdRn/ucClUCd1pNyXqRDQJmALeG8kuZoGnQpuBqlPPh
	 eeArDZeL1eSt9xiDPhFMLHhXX3UCVbrowiYKzmSKYAcvj4lR3paSRGeSECfQNc+h5a
	 leTgE+EptypLF0IYM38CpOIf6xMOhRxDxvig/L04lGciYdCLtAg2zMMSY60AEvQCK3
	 ouzs0aTIuNTPJ7nulSlhGPkc=
From: Hui Wang <hui.wang@canonical.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	pjw@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	shuah@kernel.org,
	wangfushuai@baidu.com,
	linux-kselftest@vger.kernel.org
Cc: hui.wang@canonical.com
Subject: [PATCH 1/2] ring-buffer: Fix event length with forced 8-byte alignment
Date: Sun,  7 Jun 2026 15:24:30 +0800
Message-ID: <20260607072431.125633-2-hui.wang@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260607072431.125633-1-hui.wang@canonical.com>
References: <20260607072431.125633-1-hui.wang@canonical.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When RB_FORCE_8BYTE_ALIGNMENT is true, rb_calculate_event_length()
reserves the space of event->array[0] for placing the data length and
rb_update_event() stores the data length in event->array[0]
accordingly. As a result the whole event length will add extra 4 bytes
for sizeof(event.array[0]) unconditionally.

But ring_buffer_event_length() only subtracts the
sizeof(event->array[0]) for events larger than RB_MAX_SMALL_DATA +
sizeof(event->array[0]). As a result, small events on architectures
with RB_FORCE_8BYTE_ALIGNMENT=true report a data length that is 4
bytes larger than expected.

To fix it, add the RB_FORCE_8BYTE_ALIGNMENT as a condition to subtract
the size of that length field whenever RB_FORCE_8BYTE_ALIGNMENT is
true.

This issue is observed in a riscv64 kernel with
CONFIG_HAVE_64BIT_ALIGNED_ACCESS set to y, when we run ftrace selftest
trace_marker_raw.tc, we get the weird log: for cases where the id is
1..100, the number of data field is 8*N, but once id exceeds 100, the
number of data field becomes 8*N+4:
 # 1 buf: 58 00 00 00 80 5e d1 63 (number of data field is 8*1)
 ...
 # a buf: 58 ...                  (number of data field is 8*2)
 ...
 # 64 buf: 58 ...                 (number of data field is 8*13)
 # 65 buf: 58 ...                 (number of data field is 8*13+4)

After applying this change, the number of data field keeps being 8*N+4
consistently.

Fixes: 2271048d1b3b ("ring-buffer: Do 8 byte alignment for 64 bit that can not handle 4 byte align")
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 kernel/trace/ring_buffer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 56a328e94395..d9af2bbaf9c0 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -270,7 +270,8 @@ unsigned ring_buffer_event_length(struct ring_buffer_event *event)
 	if (event->type_len > RINGBUF_TYPE_DATA_TYPE_LEN_MAX)
 		return length;
 	length -= RB_EVNT_HDR_SIZE;
-	if (length > RB_MAX_SMALL_DATA + sizeof(event->array[0]))
+	if (length > RB_MAX_SMALL_DATA + sizeof(event->array[0]) ||
+	    RB_FORCE_8BYTE_ALIGNMENT)
                 length -= sizeof(event->array[0]);
 	return length;
 }
-- 
2.43.0

