Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7639D2D0C6B;
	Fri, 11 Jul 2025 13:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752239869; cv=none; b=fELSaZT36pZBatLeiY0HZpX5QYLX+HU2ZdziAuCT5i0a87jbTRWQGhP2LL5cm5xe4jPJnzvpEj/lv4LYp6SvJlHCMF3N0El4ezqJPIaYb1yWprrQj2W4kZggioUeF5vout/ErOFSbR7ir7GfkRTZH4WjlN/UbNnQNduO8mihBAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752239869; c=relaxed/simple;
	bh=GRA74LOTuk1uJOCrkdqqWrOoo7DoiAXzeWM1+TSA8iQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tZgoXEi8G+yHxw1kmXVBSSw2ChBgQ3yu439ZcA+Vzq033ipue/oTcd3johUxHvrmNCSxA0eBjAHE3cu9ILwmgqllfcXhOsW2h/2j3hQNFigstXLT/F50lcuMLrTAtmpcpQYdJQSK14wSTivPG3ZlpVXnSzeO5/6kQ25k/zHpi4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qeiQ04HQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ah5ugfQ2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qeiQ04HQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ah5ugfQ2"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752239866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3k27oHJLKOGmZgBLMjFziWxaMQVkPvdeaqKeFOZO54M=;
	b=qeiQ04HQTEuW36RpeVVh21dOiizfEWeSVwhombKJRZyYbxPdt3EuQxIDygF9q4y/guUTDD
	m+UfpWFsDYVJJ17oqrHVDF1aBWxHiRMxeIlQZNooOD8WsSaT5kjnEJQzCPqenM4KAgo6gi
	8qjQfWAUcylmma3E3W4zyaLivdEwjVyD3FyrT4dYyhWImLAt+rTcVmwZemnSZEYF9RBiMd
	zSTjv+YtsiN90xxp5XOZ6BtaTwooVnZyAF8yTl27xbNjA3tz89gb3p9R0jLGTPEc+9WqL0
	K3+24aasYg6azjl1RpuUX2N3v9QPRP8sqx+HRuDPxP2dboGvlc+NnXdIR48ddw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752239866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3k27oHJLKOGmZgBLMjFziWxaMQVkPvdeaqKeFOZO54M=;
	b=ah5ugfQ2ogqEqgmBXFJPX5EokUlSA8iZ7La6kLb4jtFwwSulJgYAZFRFNzMqzUyIb73reo
	1bhTRClm5JTr92CQ==
To: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 0/2] rv/ltl: Support the 'next' operator
Date: Fri, 11 Jul 2025 15:17:36 +0200
Message-Id: <cover.1752239482.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

In the theory of linear temporal logic, there is also the 'next' unary
operator defined as: next time, the operand must be true.

During my initial implementation, I thought kernel RV monitors would not
have a use case for this operator. Therefore I omitted it.

However, me and Gabriele had a conversion off list, and he may have a use
case for this operator.

Therefore, implement the theory completely and add the 'next' operator.

Nam Cao (2):
  rv/ltl: Do not execute the Buchi automaton twice on start condition
  verification/rvgen: Support the 'next' operator

 .../trace/rv/linear_temporal_logic.rst        |  1 +
 include/rv/ltl_monitor.h                      |  4 ++-
 tools/verification/rvgen/rvgen/ltl2ba.py      | 26 +++++++++++++++++++
 3 files changed, 30 insertions(+), 1 deletion(-)

--=20
2.39.5

