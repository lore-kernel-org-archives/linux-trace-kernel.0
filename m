Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EC0313292;
	Fri, 21 Nov 2025 22:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763763559; cv=none; b=n6MsdkiqB+Q+cFu+iNsXeWrHhhryoeQrh9GPISUssX610UsU7L9HK+Bh/6fuHNidGdJD+sew2IfESkzBNaC1ZhY1G38cnm1XL8P/RblRWakixUeT4KaufkW5EAIMfr4OykCJSrnJup0HwBDUxP6//lAYMStcblP7mxy50ciZ9fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763763559; c=relaxed/simple;
	bh=bsIqECAHRDz2N4rdA8e8Oi73XNLUkBlhW3cJ3/RG9Yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nPYfE1ePjz86RqUPo5/gw85gdy1H6SG49hTF0aeNVkqjf8A6k/ZG6oyxCqt82UEBAkIsYhOlc4iXtx3U4FhLeufnSe/ZB0ujn/OnsbVgYzCPW4AFcIDSEO22nwkl67eRGlMcurkn/heL6uLEUCm737rxxhwFHygMNAqwnFfzyHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=neuW80oK; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=neuW80oK; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="neuW80oK";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="neuW80oK"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dCqPv5J5Sz9t8b;
	Fri, 21 Nov 2025 23:19:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1763763555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vjWlk5rzxnZYDb+qpaON2ErsbXPFBKgjDWlcPSq9suU=;
	b=neuW80oK+iaF6AsMQezhLb8oUWIPXcmVFBFBTYq2duObi5MTvbxxx3bPytufeeIigcGx6v
	rmpCHbPaU4hcrxDN8Wlq9Dr9cKmvuMdsFK4A1M8PhoALGmPUFrN4ZJeBKr7pcwKCSkLdNn
	0t8zzBcFH2yRxvIiWVhl7IC2rxaFelak9LZKL12mfr/Gnbzk+AannXrZT416Tr7s0zjxY7
	DhAn945FSzPW24dPaegVO8qyaNgE7Qy+aDXW1MsjXYrdXIJGHsVGrnRnTQMFKJXStwcKug
	6pflC/xo2vyGiZmYcoRmc3PqekMvJrFL8BEb+5c4wfo61j/gw2lfbx2pklHZAw==
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1763763555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vjWlk5rzxnZYDb+qpaON2ErsbXPFBKgjDWlcPSq9suU=;
	b=neuW80oK+iaF6AsMQezhLb8oUWIPXcmVFBFBTYq2duObi5MTvbxxx3bPytufeeIigcGx6v
	rmpCHbPaU4hcrxDN8Wlq9Dr9cKmvuMdsFK4A1M8PhoALGmPUFrN4ZJeBKr7pcwKCSkLdNn
	0t8zzBcFH2yRxvIiWVhl7IC2rxaFelak9LZKL12mfr/Gnbzk+AannXrZT416Tr7s0zjxY7
	DhAn945FSzPW24dPaegVO8qyaNgE7Qy+aDXW1MsjXYrdXIJGHsVGrnRnTQMFKJXStwcKug
	6pflC/xo2vyGiZmYcoRmc3PqekMvJrFL8BEb+5c4wfo61j/gw2lfbx2pklHZAw==
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhi@mailbox.org
Subject: [PATCH v2 13/13] tracing: Fix typo in trace_seq.c
Date: Fri, 21 Nov 2025 23:18:35 +0100
Message-ID: <20251121221835.28032-15-mhi@mailbox.org>
In-Reply-To: <20251121221835.28032-1-mhi@mailbox.org>
References: <20251121221835.28032-1-mhi@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 7fdh37ssjrcsbzs7yznztipwcw9zqpcb
X-MBO-RS-ID: cf3835614649718851b

Fix typo "wont" to "won't".

Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
 kernel/trace/trace_seq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_seq.c b/kernel/trace/trace_seq.c
index c158d65a8a88..32684ef4fb9d 100644
--- a/kernel/trace/trace_seq.c
+++ b/kernel/trace/trace_seq.c
@@ -15,7 +15,7 @@
  * 
  * A write to the buffer will either succeed or fail. That is, unlike
  * sprintf() there will not be a partial write (well it may write into
- * the buffer but it wont update the pointers). This allows users to
+ * the buffer but it won't update the pointers). This allows users to
  * try to write something into the trace_seq buffer and if it fails
  * they can flush it and try again.
  *
-- 
2.50.1

