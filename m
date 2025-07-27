Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639D91865FA;
	Sun, 27 Jul 2025 17:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753637484; cv=none; b=S/BjhOzB7AJX4BN0xvJloTFpP+YvkdzST3qU0eBQHXzjNP5ebolwiuHKj0AxX6Hf69H3vBWWfKe/LTT0WtacmWE6ozxXmk1ysg7KnrtL/7kqViUbpITRkNiq5liYOMbLtLKBkuRjIjGQhcRmlcvns0tUwldrqY//jmqaTaKTPNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753637484; c=relaxed/simple;
	bh=/cjBrV9XX6aheBgnSXdb2dlIEWOdCP4YiAwEzH2kDQU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rLAcMidhG88Z9Nj5SuAI+LHGpqcaY5911kTA5JnO42p3D34vqUBoLjC7MDtuFjXH9bkraNe1Q61N9OCku2BbecW7K2ZFj9vIDWy+kfAk3mPM1XcYg0APMDi2Lj59K32HI9OsuOP/zhfz08GSrQo0C2oIWf8pysEefgH9aHtub6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hxN/1DjN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dGGhLxBj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hxN/1DjN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dGGhLxBj"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753637481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q0LdXBryZW5wmd0Uo5zcrklSnbN6Ze5FvNPihrNQlxg=;
	b=hxN/1DjNHPwzfwv7/fXE3zZX/Zg1w/UIZta0pyWkUGSrrI9ic+TRn67YuO9L7NUt2yvDYo
	Vu5om1XWkDa3hDdCYQlDp8pHiZjnxmra7/GjqDXDsgX9Ydoq8KvpsIx1H36Uuwgr9bFIQS
	W2oDT3WlkeozgoIQc4+aO0T5m4wfRL/Cm+jPmrcQ8OfJPP5tSu36hYkUY9G6WRuB2j6zbM
	+FwDT9ONaXIliqa7S2jkd2kjBK9lKKGzG6ohzCBoZrqMROe/pTws6awj59CvjSdgodffcq
	OqrsSKBPA7H14bwwpLON1b5O39+F3ZrQ0SXTLx+VdQRTjv1kVnocu8VVUuZRgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753637481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q0LdXBryZW5wmd0Uo5zcrklSnbN6Ze5FvNPihrNQlxg=;
	b=dGGhLxBj2cdEpezP/ztuu8a90g8TLcRlbq1w2r5SdiNbmzCDVctiY5nuXl9Tp5GJneQQPg
	lDBJ/TUO57EIjyDA==
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 1/2] rv: Fix wrong type cast in monitors_show()
Date: Sun, 27 Jul 2025 19:31:12 +0200
Message-Id: <35e49e97696007919ceacf73796487a2e15a3d02.1753625621.git.namcao@linutronix.de>
In-Reply-To: <cover.1753625621.git.namcao@linutronix.de>
References: <cover.1753625621.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Argument 'p' of monitors_show() is not a pointer to struct rv_monitor, it
is actually a pointer to the list_head inside struct rv_monitor. Therefore
it is wrong to cast 'p' to struct rv_monitor *.

This wrong type cast has been there since the beginning. But it still
worked because the list_head was the first field in struct rv_monitor_def.
This is no longer true since commit 24cbfe18d55a ("rv: Merge struct
rv_monitor_def into struct rv_monitor") moved the list_head, and this wrong
type cast became a functional problem.

Properly use container_of() instead.

Fixes: 24cbfe18d55a ("rv: Merge struct rv_monitor_def into struct rv_monito=
r")
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 kernel/trace/rv/rv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index 2ac0e8bf4e60..1482e91c39f4 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -458,7 +458,7 @@ static int create_monitor_dir(struct rv_monitor *mon, s=
truct rv_monitor *parent)
  */
 static int monitors_show(struct seq_file *m, void *p)
 {
-	struct rv_monitor *mon =3D p;
+	struct rv_monitor *mon =3D container_of(p, struct rv_monitor, list);
=20
 	if (mon->parent)
 		seq_printf(m, "%s:%s\n", mon->parent->name, mon->name);
--=20
2.39.5

