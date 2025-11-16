Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA01D1F874C;
	Sun, 16 Nov 2025 15:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763307329; cv=none; b=bzuvPvZ3Q/lb0dtYkhrtgVSPiHPHXAzPs2BI7Cp4vl5v12SB7x6nfzmzYvvfqtyRhjHnIWOtWJsYOe/pufJ6i70rFInM/3nyO5+1owuJyxIrNeSkJ3201hJG7dyGICGv/DojMvJDdUxxV7CtG9KcagE+TLLI0E6T8VlGFEz+tlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763307329; c=relaxed/simple;
	bh=L71o680i+cJJw3jVVSENtT3KBrXJSluIBQ4cUmjd/mw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SyruT2SNLd7onUyaRI1cSUlBYx9JeSVPH4ACRa5XbpR7xq16Di3lo4Fsh36XUbGlQGfXovYtqgY1geWX8QaqLDZQ7J/nXObK1YImHf4jCEYiQfTpfFdFatIJdZeAWBBYG3Csu2TFBM5cpg1LbzYoZlEz4jWKKKi+eThSpRWwWhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ozM4HJzT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rrYtmo50; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ozM4HJzT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rrYtmo50"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763307319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yTIS55D7/NCRVInJa3JzQCEqaBnv8fqrcNyQbZBu418=;
	b=ozM4HJzTS0+5f9cP3rI+7ifB42R3yrT1qqyXkQbH4QNBtxfq+C50zWNQ9FCI35aHgLJzwp
	CJvlU51guk5pn/hEchsapKfrSoso5SODr5oc+TJfKDJLwgczqOosTBq4WRfdF0r+XZXGLl
	OTe5od1xVFeJfydt1+Rk6oP+ifsJUDOiidkyqRzBqxGvlcQMz5m8Fo4CIEEGBhZUoJn+Lz
	KaXcH3qoTXojm+aFodCL2qSX9dL0GpbS/pbTeNkCR4RmmhwgdpGXgKpU9RBI00ho94Xp84
	OE1/+beTqTm1NxwiBqv/M9E3ewcADYKxpe2glQWOw+utVgOOazWFctkOoqMOAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763307319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yTIS55D7/NCRVInJa3JzQCEqaBnv8fqrcNyQbZBu418=;
	b=rrYtmo509/L1kEjKTkmI68wSY2sAS+yajohRPl7FP+dQP2RDIYLYmFzw1WRKSxJvIRax65
	UKJf/N6xkYEVdcCw==
To: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH 0/2] rv: Tidy up with auto-cleanup
Date: Sun, 16 Nov 2025 15:35:10 +0000
Message-ID: <cover.1763306824.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series tidies up rv code with __free and lock guard. This is motivated
by a bug:

https://lore.kernel.org/all/20250903065112.1878330-1-zhen.ni@easystack.cn/

which was caused by a missing mutex_unlock. This series makes such bug less
likely in the future, and also reduces some code lines.

Nam Cao (2):
  rv: Convert to use lock guard
  rv: Convert to use __free

 kernel/trace/rv/rv.c          | 104 ++++++++++++++--------------------
 kernel/trace/rv/rv.h          |   6 +-
 kernel/trace/rv/rv_reactors.c |  58 +++++++------------
 3 files changed, 66 insertions(+), 102 deletions(-)

--=20
2.51.0

