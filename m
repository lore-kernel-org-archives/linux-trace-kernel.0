Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E601BC8FE;
	Wed,  2 Oct 2024 21:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727904744; cv=none; b=JiCCuTC9QUirhd1ssu7fb3cQkZO7Xkd4eRCfpHL9dd2ME7E7J5bz216DLmY9J+wMg/XLHYrYK8ykGP8rnzQM+i99w5ZUOX90LKqSSsB90hlHQn3R1rYqG7Eynd7vHhI4kAr1dRXfD+BYF10ksIcUpArVThwLjDPoekTVuD2LJCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727904744; c=relaxed/simple;
	bh=JFyO5QBBFZtIWWWibmX5p/OlJSVIM41iQwEIvpv80a8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j4VEOh0u1uS+H1nkAJir/oLAY5Jc7ft7ZXoZALm9Omub56c1tgxo4EZXexKSCUK3IaZn7Iwp378NDgz6g4nrcaaC0ZD3RDf4vskmxDKnIC6pXq5n/QTCa2iVqIIB69svdXn5MXIAGBIM795RwvDoMqCaS6oxlrCsIygx2N1m6Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7WbtM6V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7WbtM6V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23221C4CEC2;
	Wed,  2 Oct 2024 21:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727904743;
	bh=JFyO5QBBFZtIWWWibmX5p/OlJSVIM41iQwEIvpv80a8=;
	h=From:To:Cc:Subject:Date:From;
	b=b7WbtM6V6dz97d0L2oyO0w0x4IglDQGYiWpCjC19LN5AGCgB3m+X0D9Epjhvz21Kg
	 tabGGNGW0fKs/mdM5a+oA1U+koeob0RiU3jUmMr8dgDUEYOveTun4VTTrMb6Fh5JVi
	 oyKyh3f7QHPRzVShN6ivEbmA/FSC1AZQYzKwR8zS0/ZHTanqxsJsyLgdcutgH/kdAb
	 +eZbMqu/u9I0Vb/xap7ODonGe54Z8XE2R8UU+YbUE1NRuJ+qQfNMg+J7Z0E8wZKjsG
	 OIeZVDRV+c95LxXSf0H9gw9mZIjizLawyNYmrfMTZ8LSmnXYZyIcF0B8aWAB/QmazD
	 Z/eAKDXbTTD7A==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>
Cc: linux-kernel@vger.kernel.org,
	Sven Schnelle <svens@stackframe.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] parisc/ftrace: Fix function graph tracing disablement
Date: Wed,  2 Oct 2024 14:32:04 -0700
Message-ID: <5962b9e161b2b9296509c3d65c7f16c11b07bd16.1727904678.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to an apparent copy-paste bug, the parisc implementation of
ftrace_disable_ftrace_graph_caller() doesn't actually do anything.  It
enables the (already-enabled) static key rather than disabling it.

The result is that after function graph tracing has been "disabled", any
subsequent (non-graph) function tracing will inadvertently also enable
the slow fgraph return address hijacking.

Fixes: 98f2926171ae ("parisc/ftrace: use static key to enable/disable function graph tracer")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/parisc/kernel/ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/parisc/kernel/ftrace.c b/arch/parisc/kernel/ftrace.c
index c91f9c2e61ed..f8d08eab7db8 100644
--- a/arch/parisc/kernel/ftrace.c
+++ b/arch/parisc/kernel/ftrace.c
@@ -87,7 +87,7 @@ int ftrace_enable_ftrace_graph_caller(void)
 
 int ftrace_disable_ftrace_graph_caller(void)
 {
-	static_key_enable(&ftrace_graph_enable.key);
+	static_key_disable(&ftrace_graph_enable.key);
 	return 0;
 }
 #endif
-- 
2.46.0

