Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B303631D723;
	Mon, 17 Nov 2025 09:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763370374; cv=none; b=FkZ6p8aHPu5p5Zpi1FDfdi7m0Uo+KwsiQB1qnoqotHrzmKiIgznMbfNEHR2c13Ixd4n8AeiZuZVWAt35Uy/tMtBWT6gHukMMsMQmAoc2Mzc+Nz43/EDynnwF+mTQCTnmB1yAtVLFnEX2zOEKrhhG9DYrp5sILLisP1U6z7NdZVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763370374; c=relaxed/simple;
	bh=/NwBDjVVUy8M95oW4t0VyB+rYpiQLpyE5trJNDZhnGo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lTR03Wz5Hl+L2GCFLyZooVpYFL0ItAFUKlEpRK/XEsuczToBl952LyKBHVXMRHN00Ef+OJH1XMWe1SqVNUmpslb72MRbwGNsG1ElM1HsPu3+q9u7cAQxDDoVmTT0VGtGu59X+fkiujsxTf7dys2OemzTwYXYqrtrMZghKviZbyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KSGtMbM2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=980VUoBS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KSGtMbM2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="980VUoBS"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763370370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bDQj+RBjUBccjtLkdFvE7AwPnofbE4gpOpbKbskgOHQ=;
	b=KSGtMbM29jWe2KhIZggOkZBJ8/4dgSG4z6tuHbhCErLkciuIgOtQO4n8Da63ER7ti0Aekw
	7W6Wpwylf8u4MTUfysUjoKV6UcF/rlbkfQmkUWgtr1siL5oOIPeF791A7OT4PrA3fTESVq
	oS+0rbaA9NdPo8keMJYdaiJWklCmoGyisout0YHx88UHUoHNKZXHZU62UKj1Uin5FyctVm
	LpBGbDaZkHuMMat3kE288bVwf97tdrB9AiLPCUvMg9Nfy5PhnccmvxZ5tjGwpF9f2KlYRC
	k3Y1ZI+xopgrU6eYAweMn5Byk8SCZfFeWY9vemCqmV+KY3pbMt+gxvMXLkIYmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763370370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bDQj+RBjUBccjtLkdFvE7AwPnofbE4gpOpbKbskgOHQ=;
	b=980VUoBSOLOQomjf7y0ARwF8LweNmioDa418NiZ/O4m7/z81YF3HOBp5ZRoOsntHwmzOll
	WOkTG4Yx9OuwsBDw==
To: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v2 0/2] rv: Tidy up with auto-cleanup
Date: Mon, 17 Nov 2025 09:06:01 +0000
Message-ID: <cover.1763370183.git.namcao@linutronix.de>
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

 kernel/trace/rv/rv.c          | 102 +++++++++++++---------------------
 kernel/trace/rv/rv.h          |   6 +-
 kernel/trace/rv/rv_reactors.c |  58 +++++++------------
 kernel/trace/trace.c          |   3 +-
 4 files changed, 66 insertions(+), 103 deletions(-)

--=20
2.51.0

