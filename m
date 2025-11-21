Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7418930BF73;
	Fri, 21 Nov 2025 22:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763763559; cv=none; b=K8r0F9bmSu098L73gdOvP+Crwqv1PUf/HwbS3uxD0P9J4Ului5dVowt289B5MNq7Kdo57hM+pcM0uKN15yW/397EulTnGQyNYNd35efgHlm/aJiR3+JhGIMAEQprjB8rgRn7jTzP1kTizs8Kkyo9djykkmzJBExwTGqoDKWN6gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763763559; c=relaxed/simple;
	bh=EaxdQWGITnBdiThWy2WehMzoiUDX3f/pxMeSm1aqDzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oMBiT89PqgM7DXZNsIzmCu8D6L7OZ9eN44hlZCIPz6SM1WRQ2U7krSKH498lCTWuAGcCY0GISGMf/P04cQJc8p0yexbFP1861WRuQd5SonU8/n1kHvvt0wmtRuZFgDFT70sOP/hvYfqWv4s4jRGBLQ154LXKoZ3qxh85fNFejz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=pYxPrMvc; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=pYxPrMvc; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="pYxPrMvc";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="pYxPrMvc"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4dCqPp5qCxz9v3G;
	Fri, 21 Nov 2025 23:19:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1763763550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fOKVkGMuDZOReZe6loIk0WKvOmt+GxuhvRca5+ckTPg=;
	b=pYxPrMvcp2ZyyxzEm85hfanRULQakOWRatSInW8G5j2NWGCZY0/24KAksnt6mM57mGjgTi
	PJAunC49AVkAzdChkNy1VqNtgRDsY06gl43JLfRQZ6q65v2HacU9PsY05qZBFCmW7b6VQN
	azabEu1UZG4byq/xWFAw2hqBJtDLhXd7/4Wivl45G2QX/jldXdTMW1KW0FnIZ1fhPDoH6o
	zLX8HzZ3p88CLwXLSRoOrB4ErM88xq5wVXCsMTInJFeDIXtVUBKNkNb69N8vg90C/BSBMD
	cnpOyVS6Fv59Bvt+giFDoAzuf4QZR5QD8Nztk8Jek5362lLM+aRWe/PemUnSRw==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=pYxPrMvc;
	spf=pass (outgoing_mbo_mout: domain of mhi@mailbox.org designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=mhi@mailbox.org
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1763763550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fOKVkGMuDZOReZe6loIk0WKvOmt+GxuhvRca5+ckTPg=;
	b=pYxPrMvcp2ZyyxzEm85hfanRULQakOWRatSInW8G5j2NWGCZY0/24KAksnt6mM57mGjgTi
	PJAunC49AVkAzdChkNy1VqNtgRDsY06gl43JLfRQZ6q65v2HacU9PsY05qZBFCmW7b6VQN
	azabEu1UZG4byq/xWFAw2hqBJtDLhXd7/4Wivl45G2QX/jldXdTMW1KW0FnIZ1fhPDoH6o
	zLX8HzZ3p88CLwXLSRoOrB4ErM88xq5wVXCsMTInJFeDIXtVUBKNkNb69N8vg90C/BSBMD
	cnpOyVS6Fv59Bvt+giFDoAzuf4QZR5QD8Nztk8Jek5362lLM+aRWe/PemUnSRw==
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhi@mailbox.org
Subject: [PATCH v2 09/13] tracing: Fix typo in trace_events_trigger.c
Date: Fri, 21 Nov 2025 23:18:31 +0100
Message-ID: <20251121221835.28032-11-mhi@mailbox.org>
In-Reply-To: <20251121221835.28032-1-mhi@mailbox.org>
References: <20251121221835.28032-1-mhi@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b2692439112c83bf2c0
X-MBO-RS-META: tdhg3das5fzy1c4oe1yg9ze6ui5mo37q
X-Rspamd-Queue-Id: 4dCqPp5qCxz9v3G

Fix typo "componenents" to "components".

Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
 kernel/trace/trace_events_trigger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index cbfc306c0159..4f3627060e59 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -644,7 +644,7 @@ static void unregister_trigger(char *glob,
  *   param             - text following cmd and ':' and stripped of filter
  *   filter            - the optional filter text following (and including) 'if'
  *
- * To illustrate the use of these componenents, here are some concrete
+ * To illustrate the use of these components, here are some concrete
  * examples. For the following triggers:
  *
  *   echo 'traceon:5 if pid == 0' > trigger
-- 
2.50.1

