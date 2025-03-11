Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9068F26281C;
	Tue, 11 Mar 2025 17:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741712734; cv=none; b=nOgS5NemXZdLo+/BqrAqrZrxpLaCuXwf1TnP7sCADabk/+IXZ9ftPmZCZpcg8HRU4mFixHT8/xqxHpqSdpZ3aZ0bcugwG3pEiyyE9artQ02DbwYuffWuwjrMV50S7QEnacFwD41i/Cy3e+Lhq7oxCYfVgfsXSij6K5YO9MZJlLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741712734; c=relaxed/simple;
	bh=3Z2iltAE/4VrC3oyqh5i5+JijFE/g4d17qkrSNt9FUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fcwM7JPUHDjhtJcksklTyzc/DIEGYmbuiSuqnOnZlX6i5xKC9kb/R832K9NzNjtmHqhX/s7oYcpqo3VqI9XqieWGhfMt2tGHg+nm+z61pCslA+ffJl5UOsNnYEAcyw3/I7erKamba4BG5jgwSyxtLLON999ANfk1uyDG1xk8u1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MhuwHS/J; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uLrkj+JY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MhuwHS/J";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uLrkj+JY"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741712731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gYBRTsnQ/JP0AXlABoV+8k2Ze4iwA+Ro2nblXmRQVU0=;
	b=MhuwHS/J93sgupT/vFWcNjuSLrtHjbPawVbL0zUsP10YROu2aDi/2N9TGxEn+JOl0fzh9R
	KHwxRDPxz/++ae66RDFenzdVYHEhWsuqj1pmOgFwzzxAJIEoe+CT1OZuptqmNFUSJn4Sz3
	fGPw1SW5N4gXN8V/IlQSW5uMWRWP1oTBZZwGNBNUpdyghQSkm7fhRiRMzuQe4nAJe61KAu
	0GX48u/bf/q4rIITvtxp9gi9Z0zhZTsy2ELgk7X2hvg7+N5uuhd3ngHnNkIlPA4bw3txBt
	OKBYkmKEJJFxc4P0xk1Rdz52WtU5mt8QabOgP8rgDX4k1vdDSG19QxEIBWzHpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741712731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gYBRTsnQ/JP0AXlABoV+8k2Ze4iwA+Ro2nblXmRQVU0=;
	b=uLrkj+JYkrulqr3wtLy6rzeWkCMoCJk3WULN7PIB0YcMDNZj/h4UjSs+uhpm6F9iiYwV6u
	15G9rHQcwocDCNCg==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	john.ogness@linutronix.de,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 10/10] rv: raise the number of per-task monitor to 2
Date: Tue, 11 Mar 2025 18:05:11 +0100
Message-Id: <8ebb6cc8f566eaf6c62eef8391e930dbac10d66b.1741708239.git.namcao@linutronix.de>
In-Reply-To: <cover.1741708239.git.namcao@linutronix.de>
References: <cover.1741708239.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There are 2 monitors to check realtime applications. Users may want to
enable them both.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 include/linux/rv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rv.h b/include/linux/rv.h
index 6de4f93b390e..224c2194f582 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -44,7 +44,7 @@ struct ltl_monitor {
  * adding more or developing a dynamic method. So far, none of
  * these are justified.
  */
-#define RV_PER_TASK_MONITORS		1
+#define RV_PER_TASK_MONITORS		2
 #define RV_PER_TASK_MONITOR_INIT	(RV_PER_TASK_MONITORS)
=20
 union rv_task_monitor {
--=20
2.39.5

