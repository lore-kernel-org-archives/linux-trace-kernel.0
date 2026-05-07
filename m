Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ED2332EA2;
	Thu,  7 May 2026 08:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778141474; cv=none; b=AesbjzRLsQrSSjQSz9Zz+JF4sHZoygt7ab5SeEmJSgI4oAbSnUpupGPJ2kT0Aqlz+sDDvOer4ikZoQtTwb2zrHWn8Q5mrabPGQ4tpU0bgeneHsW/PSQJy+b+fWy7qg+0K4Fjsv4sXCC3X10ZOa3XxG/NZ+8b/CSM6YuYwVuFyms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778141474; c=relaxed/simple;
	bh=ulAUUks7Wyi1piWGSHWQXZ2vI5FDOhERQR8nMItbYgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZd7mQUlfyZEjljlyIg/OoWmcCCF6Vq/5t6V+0VNxDnllfYxGADVKgFSxWwOpmCCMYYeWisy8HLY+lSeiAzGx5IqVxw1xQc/EGzBV7PEumManvl6N24ZgkTUKSnn0QcNMThqYMJL34UhsPgd/ijDkAyRFpSnoo5kRxgweBkEFag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from ipservice-092-208-105-007.092.208.pools.vodafone-ip.de ([92.208.105.7] helo=nb282.user.codasip.com)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <martin@kaiser.cx>)
	id 1wKtp6-00000000bpd-3KE3;
	Thu, 07 May 2026 10:11:08 +0200
From: Martin Kaiser <martin@kaiser.cx>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/4] perf/core: fix typo in a comment
Date: Thu,  7 May 2026 10:09:07 +0200
Message-ID: <20260507081041.885781-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260507081041.885781-1-martin@kaiser.cx>
References: <20260507081041.885781-1-martin@kaiser.cx>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo ("swevents") in a comment.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index bcaf175f3ded..2ca27547bb74 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11444,7 +11444,7 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
 			/*
 			 * Here use the same on-stack perf_sample_data,
 			 * some members in data are event-specific and
-			 * need to be re-computed for different sweveents.
+			 * need to be re-computed for different swevents.
 			 * Re-initialize data->sample_flags safely to avoid
 			 * the problem that next event skips preparing data
 			 * because data->sample_flags is set.
-- 
2.43.7

