Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C871F3911DC;
	Thu,  1 Oct 2026 04:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790829756; cv=none; b=ffWudsqb72QwxXDZKBPU7H7hnYxvZW7jTGbgshIlfKzVo2rVFhkimaM9zum+8yKD11e0QqcBJsUB5DFZaxIG1RgHtH/6MSsrT8hbBTPbP4LeHY0z9wjAISFoPrQlL3+zf33vsPqnqfPnI2ydjkhoUgys2RcordPHJGMWZoTwXkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790829756; c=relaxed/simple;
	bh=soniGsb9mp6R/Kr3BulVBJf1MUfaSP6Z1J9D6gZy3f4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fp60pfRZGQE28fj4uiuQFqHNHFezYbVbRMxesI3if3HFw1lbSWSgQPVwFaeVlol4zgPXoscgeU7Vz9G897H/5I2ckbIJ8AAVhBloAtIJ5dHnmpvK/j5hS+zThJA1wG2Ah93Xw57tLj9niOvO0407or0BPB8ckE39iJHwcIWABX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dw+gelSc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f3wMTIUB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dw+gelSc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f3wMTIUB"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790829744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AnqG8ToT92aYugLvayMx46xXmF6dmHVYs7M05iuaJhc=;
	b=Dw+gelScNAyu+FZo2pGhos2hjw6WjmWw+h/hPJu86TASvVKKCA8pHZLqpP2FogV+6ewKQR
	yipqeVVdRTYNymKp1AXpLwdt2y2ZzYah4gOrXOTT4RJiWvKO/W9eEPTH20UJsqupGFbhN9
	OXtaSgJPMLfA46v1+z96Ea0nw5n/xYoHWdsZ6L7pZgniFJ1MVABsNYE4tkB35DMTSXni17
	93yNoZP4OKbNM8OymYFhwuw7do1izQPynxZJlwe0YtIOQ8Oh3Q1uQJz1Lrn2x/dYXQbxER
	89H4waW9oKCdDgmOYQGwfOQUTDoxoV1EQl/HNSnu0i419b/4q2ArKgr+BLYVng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790829744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AnqG8ToT92aYugLvayMx46xXmF6dmHVYs7M05iuaJhc=;
	b=f3wMTIUB4NmdOD0K+p6u1AL4TRlNhBKxW5ebVh+YvxWRDBRyvf4yjPJ1ehE6DCFG5Ib+er
	OnE1Eks0yfQ7QSAA==
To: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Ogness <john.ogness@linutronix.de>
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH] rv/rtapp/wakeup: Use "rv_this" the rv_monitor variable
Date: Thu,  1 Oct 2026 06:42:18 +0200
Message-ID: <20261001044218.3508990-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Commit d9e4c61a12dd ("rv: Use generic rv_this for the rv_monitor
variable in LTL") renamed the rv_monitor variable to rv_this. But
rtapp/wakeup monitor was late to the party and missed that.

So for this monitor, rv_this is an empty struct. The reactor fails to
work, because rv_react() checks monitor->react and sees NULL.

Correct to "rv_this" and make the reactor work again.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 kernel/trace/rv/monitors/wakeup/wakeup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/rv/monitors/wakeup/wakeup.c b/kernel/trace/rv/mon=
itors/wakeup/wakeup.c
index 01b47416f24e..2e803e79181e 100644
--- a/kernel/trace/rv/monitors/wakeup/wakeup.c
+++ b/kernel/trace/rv/monitors/wakeup/wakeup.c
@@ -128,7 +128,7 @@ static void disable_wakeup(void)
 	ltl_monitor_destroy();
 }
=20
-static struct rv_monitor rv_wakeup =3D {
+static struct rv_monitor rv_this =3D {
 	.name =3D "wakeup",
 	.description =3D "Monitor that real-time tasks are not woken by lower-pri=
ority tasks",
 	.enable =3D enable_wakeup,
@@ -137,12 +137,12 @@ static struct rv_monitor rv_wakeup =3D {
=20
 static int __init register_wakeup(void)
 {
-	return rv_register_monitor(&rv_wakeup, &rv_rtapp);
+	return rv_register_monitor(&rv_this, &rv_rtapp);
 }
=20
 static void __exit unregister_wakeup(void)
 {
-	rv_unregister_monitor(&rv_wakeup);
+	rv_unregister_monitor(&rv_this);
 }
=20
 module_init(register_wakeup);
--=20
2.47.3

