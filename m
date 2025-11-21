Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8083813774D;
	Fri, 21 Nov 2025 22:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763763542; cv=none; b=knNDgKUKyI3f1Hu02wNB9Blhu937PPaEs+UrTaK7SNSEbBn1bY2WTtHD9DtmL0E3MjqbdSQ52dPD6gdVS5gemI/c0V4HbC1ooBYFhq8qNTbRmijtEveJdRRGyaw5JfR6fbTaG62+rW1UqPsRqaIHD8xh3FyIB5ZqHIxK1tP2zPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763763542; c=relaxed/simple;
	bh=Jz59EMt7EQDG6nulzGt8tT9HxAi12+Xmi/CEBcxL+wY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VngrdeC3/zng7mrCYrP5JDBRSvK5I+iGImIKLtViY/NqJzoUQ95Wrk+9I6mr5/KZLnDfEDpUkFxKhle3mOJN/EbCykCqQ5hJOW6U3Ul1aDXvfkE45mUpeZLRW/l+gwvBv4gj+/RGGbTuE28XSxxCAHzzIKh/JVSAk8rf9ww8dhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=YiuwcyRE; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=YiuwcyRE; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="YiuwcyRE";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="YiuwcyRE"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dCqPZ43CPz9tDq;
	Fri, 21 Nov 2025 23:18:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1763763538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uZHRg2pQMaIIxiGgAmrnBhb1+iKzZj54LIYMk2UxPbw=;
	b=YiuwcyRE/ozsOR7VxkNoXbXkPRPn6FnhNULDe+/8lC1Aa0AyGAfdxbP8X4xmwNheVXFs5b
	yUdhQ6ovjDjbUC66Mau4AWlW4pjbUKe28YGwThgVVuAf3UqxWi9AYiI8D9e0W1TJlTUgrL
	ar6DbOY9zIt9ZNIN4FLxWQqyOZ/ySIGfD7/aHaakDnv30yGanqOBDyqgvwO/RTOjcQQrkj
	LAMzWJqO35OACHI1VqpJBJuCyS2LUK+gY0fLLOC8jEFRe1hcdgXzHI6TtiKOqvNrF185hR
	a7dsuGmvXCeWuJ2Qj7fVcOqRGPtGgQFbviBurNKKqS+tNxgtNEK5IoYOoDPStQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=YiuwcyRE;
	spf=pass (outgoing_mbo_mout: domain of mhi@mailbox.org designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=mhi@mailbox.org
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1763763538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uZHRg2pQMaIIxiGgAmrnBhb1+iKzZj54LIYMk2UxPbw=;
	b=YiuwcyRE/ozsOR7VxkNoXbXkPRPn6FnhNULDe+/8lC1Aa0AyGAfdxbP8X4xmwNheVXFs5b
	yUdhQ6ovjDjbUC66Mau4AWlW4pjbUKe28YGwThgVVuAf3UqxWi9AYiI8D9e0W1TJlTUgrL
	ar6DbOY9zIt9ZNIN4FLxWQqyOZ/ySIGfD7/aHaakDnv30yGanqOBDyqgvwO/RTOjcQQrkj
	LAMzWJqO35OACHI1VqpJBJuCyS2LUK+gY0fLLOC8jEFRe1hcdgXzHI6TtiKOqvNrF185hR
	a7dsuGmvXCeWuJ2Qj7fVcOqRGPtGgQFbviBurNKKqS+tNxgtNEK5IoYOoDPStQ==
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhi@mailbox.org
Subject: [PATCH v2 00/13] tracing: Fix several comment spelling mistakes
Date: Fri, 21 Nov 2025 23:18:21 +0100
Message-ID: <20251121221835.28032-1-mhi@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 39e2412f2b1a6bbdced
X-MBO-RS-META: ud8rxcdeym1zszr5xfb17jq9nci3ihuo
X-Rspamd-Queue-Id: 4dCqPZ43CPz9tDq

Fix several spelling mistakes in comments in the trace subsystem.
No functional changes. These fixes improve readability and correctness
of comments in the tracing subsystem.

Changes from v1:
https://lore.kernel.org/all/20251116210302.141405-1-mhi@mailbox.org/
- Split up changes in patch per file
- Base work on trace/for-next instead of trace/master

Maurice Hieronymus (13):
  tracing: Fix typo in fgraph.c
  tracing: Fix typo in fprobe.c
  tracing: Fix multiple typos in ring_buffer.c
  tracing: Fix typo in ring_buffer_benchmark.c
  tracing: Fix multiple typos in trace.c
  tracing: Fix multiple typos in trace_events.c
  tracing: Fix typo in trace_events_filter.c
  tracing: Fix typo in trace_events_hist.c
  tracing: Fix typo in trace_events_trigger.c
  tracing: Fix multiple typos in trace_events_user.c
  tracing: Fix multiple typos in trace_osnoise.c
  tracing: Fix typo in trace_probe.c
  tracing: Fix typo in trace_seq.c

 kernel/trace/fgraph.c                |  2 +-
 kernel/trace/fprobe.c                |  2 +-
 kernel/trace/ring_buffer.c           |  6 +++---
 kernel/trace/ring_buffer_benchmark.c |  2 +-
 kernel/trace/trace.c                 | 10 +++++-----
 kernel/trace/trace_events.c          |  8 ++++----
 kernel/trace/trace_events_filter.c   |  2 +-
 kernel/trace/trace_events_hist.c     |  2 +-
 kernel/trace/trace_events_trigger.c  |  2 +-
 kernel/trace/trace_events_user.c     |  6 +++---
 kernel/trace/trace_osnoise.c         | 12 ++++++------
 kernel/trace/trace_probe.c           |  2 +-
 kernel/trace/trace_seq.c             |  2 +-
 13 files changed, 29 insertions(+), 29 deletions(-)


base-commit: b668bb6dfc3a72a98994671898af28c39bd3cb6a
-- 
2.50.1

