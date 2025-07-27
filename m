Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C184B1D7995;
	Sun, 27 Jul 2025 17:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753637485; cv=none; b=BTCFZsVlA+0F5u2Us1uOk3dpd+isPD5dpKurVvBgoSAMZlYFBC4sgW1NdaBtougkG5Kh16tzXOv61zYsq6WzjhTC72x4XxhLuq6UKXH6sCD0h5z7wI7LpYqni88JKRJ+6Zv0f6CzsNz7YvuGPJrklUjBAdFg71mI7zYMcE6l/20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753637485; c=relaxed/simple;
	bh=k2xccX0Y8Ao1H0mbk1zEZnxQmtGY599vzJY7tf0+/LU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CD5sPo6Km6rQt2oiJx++5cFzWqd0lkbzz1W6OojGhznFMGJzcPvzRZUBpAi+qWShlc4SemfFgVfuF55KKnJmxHnYItVxMHPQzzishMPAbhniQAglXVVQrQXyi77yFvFUsd2xTVkvrh4ckhsxypIn0VWpvx7/2mSn/JeWbG5nVl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FN1wojhf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C9jDvbti; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FN1wojhf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C9jDvbti"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753637481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nBNpckoxR68awXvvXJgFQ3zYPo4X0L8GySiPwun3zDI=;
	b=FN1wojhfJ5KZ9yghnPmv4BkeilGfH7cdPGdsIwDyjhfVbR/cB3kJ3ozkUV+wra69e75zek
	IMmG8gYeGzjlbfqjZ/HxdxQfcq1vgVExXu7lEG6USgzUCrrPFHlUPf1SigKSUZr9LXsA06
	GIi6CivIfr1ebBML6a0vuA0GzYjvdR1/mozD4uDpqBOfxNZQ48nypAh2DK1mPxcLMaDIBx
	YGjuzpBsDamNo3U13spMkl+tJXnUW5n3LYucwwfcIqmsIPBo6xumjFCM1r1w/eFGeOifGM
	V8iZZCxYojnQqDHBKYiyWm6KaoYe241d6onkZBpOOkee6qMZ9g2Cflns6RKkow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753637481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nBNpckoxR68awXvvXJgFQ3zYPo4X0L8GySiPwun3zDI=;
	b=C9jDvbtiDPAis3wm41nHXaMS0QFU/YufOCj80SKmj2AOcHjbB1xSZiMnlatoqE0jk0OdSx
	Yu5QVRRiokexcjCA==
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 2/2] rv: Fix wrong type cast in reactors_show() and monitor_reactor_show()
Date: Sun, 27 Jul 2025 19:31:13 +0200
Message-Id: <b4febbd6844311209e4c8768b65d508b81bd8c9b.1753625621.git.namcao@linutronix.de>
In-Reply-To: <cover.1753625621.git.namcao@linutronix.de>
References: <cover.1753625621.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Argument 'p' of reactors_show() and monitor_reactor_show() is not a pointer
to struct rv_reactor, it is actually a pointer to the list_head inside
struct rv_reactor. Therefore it's wrong to cast 'p' to struct rv_reactor *.

This wrong type cast has been there since the beginning. But it still
worked because the list_head was the first field in struct rv_reactor_def.
This is no longer true since commit 3d3c376118b5 ("rv: Merge struct
rv_reactor_def into struct rv_reactor") moved the list_head, and this wrong
type cast became a functional problem.

Properly use container_of() instead.

Fixes: 3d3c376118b5 ("rv: Merge struct rv_reactor_def into struct rv_reacto=
r")
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 kernel/trace/rv/rv_reactors.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
index 106f2c4740f2..d32859fec238 100644
--- a/kernel/trace/rv/rv_reactors.c
+++ b/kernel/trace/rv/rv_reactors.c
@@ -86,7 +86,7 @@ static struct rv_reactor *get_reactor_rdef_by_name(char *=
name)
  */
 static int reactors_show(struct seq_file *m, void *p)
 {
-	struct rv_reactor *reactor =3D p;
+	struct rv_reactor *reactor =3D container_of(p, struct rv_reactor, list);
=20
 	seq_printf(m, "%s\n", reactor->name);
 	return 0;
@@ -139,7 +139,7 @@ static const struct file_operations available_reactors_=
ops =3D {
 static int monitor_reactor_show(struct seq_file *m, void *p)
 {
 	struct rv_monitor *mon =3D m->private;
-	struct rv_reactor *reactor =3D p;
+	struct rv_reactor *reactor =3D container_of(p, struct rv_reactor, list);
=20
 	if (mon->reactor =3D=3D reactor)
 		seq_printf(m, "[%s]\n", reactor->name);
--=20
2.39.5

