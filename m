Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927041CAA6E
	for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Mar 2025 20:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741637068; cv=none; b=jXyhYY3lho0d5n3wClCTg23Q0q6SkBN9uttIwtVPzbgsPKwYskgfJxHWrooM3F1Y3e3CEo9irrV16kNZEUbZfasvH7orQ9r6qioOiaK24l73kk+9wVnRpWay1J83EnvFcuwf0cTOd3NWmMcfls6V2zletSd0Z7KySWJjXwxdsyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741637068; c=relaxed/simple;
	bh=0I46IlE0eevSTbe6HgNGjPfeIS7xnB2S0NKk5f7/Yc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k5Cc1nVHmDo8/AYep4WVlIyvAw4M0KkV/wmMqkW3O88MVLCZf2wz8lkKf8V3k8KOX+bbZdzNKiHEUl8pMlE+7v4aEtOkdvelXLkGL3FdlWQMFc1qmfIWaWpN4fT4/396KCseoxo8sbVsdUXGrEzuNi/33heGelF3GmsHGP1xnx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GtXG+r1W; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GtXG+r1W"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741637063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QKEtd75rPVsd5FrismUxBPw8k8s1SS03XckANZg+1No=;
	b=GtXG+r1WybhFG2HKhJ7aHeW77ftOlVxjTPYaAYsDDuUGptrFh/SC3CD9t/w0lkzmykHP7g
	GW8lywhzdbjgt9w/9LtF4Ra2PFBu/zLqGgB/1TJn0ihD9qx4vze2d43ncGATfiOrVHA+UZ
	jFeCO4MV7fzxxoCxl5vHqjC0chqYdVU=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing/synthetic: Replace deprecated strncpy() with strscpy()
Date: Mon, 10 Mar 2025 21:03:58 +0100
Message-ID: <20250310200359.450172-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strncpy() is deprecated for NUL-terminated destination buffers; use
strscpy() instead and remove the manual NUL-termination.

The destination buffer 'buf' is used only with kstrtouint() and must be
NUL-terminated, but not NUL-padded. The source string 'start' is also
guaranteed to be NUL-terminated and meets the __must_be_cstr()
requirement of strscpy().

No functional changes intended.

Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 kernel/trace/trace_events_synth.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index e3f7d09e5512..4b51f74897b4 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -207,8 +207,7 @@ static int synth_field_string_size(char *type)
 	if (len == 0)
 		return 0; /* variable-length string */
 
-	strncpy(buf, start, len);
-	buf[len] = '\0';
+	strscpy(buf, start, len + 1);
 
 	err = kstrtouint(buf, 0, &size);
 	if (err)
-- 
2.48.1

