Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6284285045;
	Thu, 24 Jul 2025 17:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753378424; cv=none; b=bm5TkyKaNHwdjlV0XOiNyP2GDDdQ9NHe4Ux4oe1oHfGMd6jvnWlfuHr3eYhXnQHQWfNuteGvVIMPpggKhiLdpcmnwl2FJDFsiv/kYQAX12YCTUZA1hw9Ndwb8IgXYYSEIQfmNR1opOB01S7RN+e4CNIdnF0I+cV0uuNCUMoQcYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753378424; c=relaxed/simple;
	bh=ZCce7phPjE4947Xyo7IR42v+oWOE7DL6Rt4pKdAbL/E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rM0ATIVMqC7L7Y09+RwxvlEehWWrw5V20YDpaFOYujZhAetKm5XVFBl6TsCkASfWBAzqaYzSUlHgQ6u9wrQWEkYAmQFsDwkP7YuoUQp+BYOGh6LTmZwm9bdSlQC236GuZi1BN3XQJjml0MpnztlJin0rPkEano4YHiMdrFgcE5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eNKTxluf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lnbkr5aj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eNKTxluf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lnbkr5aj"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753378420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ecIx0VsYcsSf9GefnB4fe7QvMLugE0/RcIht7INmAJU=;
	b=eNKTxluf6dLaSgbwAkMC2v4IgjghiqnZgzmLgXqh/myDjzDlQ08f7rhBD5nKjC2zhIez89
	mffOoFUHoFB0fz/XMTSqDN0NOITJVEiW+B7DZADJj1T+GHgT+RB4Giv+E5Qp8b7oHBo9DJ
	fYTMju5+GhYeyKBntH/GhUCnWUjrtLcSChiGuVuRstNT0tyw0DSXIxdeaWBO7vm5SZYdRe
	JTOG93SjoHhyQVIBv9SgnzT+dsmkP7oUYZlwzN8+vx+SzI2zcu8R0LgkuJVer9Vk7avJF3
	8V5oTjBBDnsAR0CztZyE2U0Rn0y08i4x1Ppy5p/QpQdq5kkOOShL1Lv3bsa8zg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753378420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ecIx0VsYcsSf9GefnB4fe7QvMLugE0/RcIht7INmAJU=;
	b=lnbkr5aj2HgmwvlqzAT4ZtZlCYZkaDmp9MdjPZLUnUeHBniwLamH/EME7hvilD4eWMQeOf
	i1uzzD7iODzLOsBg==
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v3 0/5] rv: Clean up & simplify
Date: Thu, 24 Jul 2025 19:33:25 +0200
Message-Id: <cover.1753378331.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

This series removes some redundant code and simply RV.

v3:
  - fix up a unused variable build error

v2:
  - drop the "nop" reactor removal patch
  - clarify commit description of reference counter removal patch

Nam Cao (5):
  rv: Remove unused field in struct rv_monitor_def
  rv: Merge struct rv_monitor_def into struct rv_monitor
  rv: Merge struct rv_reactor_def into struct rv_reactor
  rv: Remove rv_reactor's reference counter
  rv: Remove struct rv_monitor::reacting

 include/linux/rv.h            |   8 ++
 kernel/trace/rv/rv.c          | 210 +++++++++++++++-------------------
 kernel/trace/rv/rv.h          |  39 +------
 kernel/trace/rv/rv_reactors.c | 136 +++++++---------------
 4 files changed, 148 insertions(+), 245 deletions(-)

--=20
2.39.5

