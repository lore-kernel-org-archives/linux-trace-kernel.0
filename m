Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E4E33064D;
	Thu,  7 May 2026 08:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778141474; cv=none; b=i8Znv1Q5hKD1QXeJJFmOjOnVyt+HTEpohnNYiL5p6WRx1YzyuSBGqf3gHLhtMp4TnELniArsz4lKefTyGlA2rjzoOM+kBMkO305EH69ms9EO4JpcxOx5AdtJl690OTldkghWmWyXgx8AA/incsr2WbQ7agHv4N9NQpErk9hrE6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778141474; c=relaxed/simple;
	bh=Sf+b50bBbnslB9aHDO9F+9bhfskSkyV6JYne2Dn1urs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fahka+Ufn2AjNpewB4tgqpd3iOxSa12vD7gxJ/dSc37APRViAG02L5Sf5Y3ePV0IMU5+pUhXHCK54mim5bogU/9Lucas4XPFdwNvxFTD5r4fRYA4qCR3XXfiQJ/nd2DeWobCNqWHQ3BM8mGuuujGt2WZt5ipz1HY9deEFVqUyXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from ipservice-092-208-105-007.092.208.pools.vodafone-ip.de ([92.208.105.7] helo=nb282.user.codasip.com)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <martin@kaiser.cx>)
	id 1wKtoz-00000000bpd-3RBx;
	Thu, 07 May 2026 10:11:01 +0200
From: Martin Kaiser <martin@kaiser.cx>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/4] trace: trivial: fix some typos
Date: Thu,  7 May 2026 10:09:05 +0200
Message-ID: <20260507081041.885781-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some trivial typo fixes for the tracing code.

Martin Kaiser (4):
  eventfs/tracing: fix typo in a comment
  perf/core: fix typo in a comment
  tracing: probes: fix typo in a log message
  tracing: trace_fprobe: fix typo in function name

 include/linux/tracefs.h     | 2 +-
 kernel/events/core.c        | 2 +-
 kernel/trace/trace_fprobe.c | 4 ++--
 kernel/trace/trace_probe.h  | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.43.7

