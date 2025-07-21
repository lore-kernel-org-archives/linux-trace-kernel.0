Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3473028467C;
	Mon, 21 Jul 2025 09:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753091252; cv=none; b=ZLHIeJBQxD5Af4lJSUSAPdJWgr44xNfVh/DbcsxBsDQ9880DejzOz23p0ZkXwggRsgkt58hSvfs+zsOin501cyDoKlUfsCkIZvgevsRJB67r3546zUv/Xnw1xnrnErYuWoJ7IUUkcYSydv9Kqmt/7rqo2akd1rs6eI1ZFeA8skk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753091252; c=relaxed/simple;
	bh=alEaX+RCVci7hUWxprHCHOy7fFTQhRBHImcI1C41/x0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cKgNlDOICB1OcJJ4mbHxouI2/kSbnFppz0HymOwJE1Fn/wYXDgQSySWB2StsB40nTW+S2iej/huFy7znXOGVw9ed4cVXVD1OCqcvC7KYMy2QTBp58b1RSN8AMa4/22kTwAfMNJ6yxehJhXynRLYeC1MGTeZy5g71s5BlXHOnVUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SlNYkm6r; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Jo88pU0p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SlNYkm6r";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jo88pU0p"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753091248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9vOqUJ+7zWlhDCALBcxwXCtMOa5SQ7PxhbTqHYBjdkg=;
	b=SlNYkm6rRij/gN2RE6EdhfpAhjos7O90GY7yOrij1ejS9c2WN/5/60gbPAr7srwPc7cOYV
	W+w46lGO7dv1F264tP+zABc4xrB7M2kd0gG9cGYF5Uc07o8olmOI+nL2bSrS32DyraBnDz
	tqDX0aa8Vt8g1WsvfdXGMA6nyYCiLHo0iunOIhUiwHjQBYs8NiT5M6YJ49IN2S1CjCqbmw
	6B2FAl7hIeqEB4RBEI6xTuVsId+8emu0ZqR1aa7mTgRfS/XGYONjWOKZhrrhbniIoUg0oD
	ev8KESb5URWT7pi5Vp/0Ldi1wvj8Us9jXkgKAsAhpe3idwehBtGbzoK21kDvXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753091248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9vOqUJ+7zWlhDCALBcxwXCtMOa5SQ7PxhbTqHYBjdkg=;
	b=Jo88pU0poqKLtqlBADI+aX6AX6Hb4QYDOpXUmTxG2MunlttHAVZx+BKT9G95h7A24MpXrm
	cGrTu+0aC970EPCg==
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 0/6] rv: Clean up & simplify
Date: Mon, 21 Jul 2025 11:47:07 +0200
Message-Id: <cover.1753091084.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

This series removes some redundant code and simply RV.

Nam Cao (6):
  rv: Remove unused field in struct rv_monitor_def
  rv: Merge struct rv_monitor_def into struct rv_monitor
  rv: Merge struct rv_reactor_def into struct rv_reactor
  rv: Remove rv_reactor's reference counter
  rv: Remove the nop reactor
  rv: Remove struct rv_monitor::reacting

 include/linux/rv.h            |   8 ++
 kernel/trace/rv/rv.c          | 210 +++++++++++++++-------------------
 kernel/trace/rv/rv.h          |  39 +------
 kernel/trace/rv/rv_reactors.c | 178 ++++++++--------------------
 4 files changed, 152 insertions(+), 283 deletions(-)

--=20
2.39.5

