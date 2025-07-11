Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5DE288C3D;
	Fri, 11 Jul 2025 11:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752232854; cv=none; b=gZiqUCJvsCqFYHynC9LkcXNZKM6QTOCZ2gLyiBxVGznu/nC+elQ7jrogrWXTW2wl85P/0Tjd2QNPN5JZ1en3U3VlA82A6xki5J1L+SUiBP/QyaGIIq5B7BjIDKFFfXetZkYnSJqCXmuYX6lFwSN//LHGVDAB9TVs+2S1ZTpnFa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752232854; c=relaxed/simple;
	bh=Jz7s8sBakGfUCPlPyB9Af+Ikv+D7t0QTUaRa39vvx2k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bovw0648NWYP++cbVOlZ+HGPDYleWNky6YoAgj2dhlTZcHMm2xkj3ahoneJENcmv6SG6EUy6JLnJqwm4kDgB/HIageuurew8uM3LIL2PoQcsd3Fm64lAmMA7DqqZcGq46OpW6ExQCtp9i/bjM2kgxcIOv9z4cj6JKs3+JuQIYHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HQAzsASf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gNfbaGxU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HQAzsASf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gNfbaGxU"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752232850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NIkiaKJf/NQm5hyEx8o1BZ87gDUPuWfsYM51wav2DCY=;
	b=HQAzsASff/6u81wFarD3SccfRb3qH/85jz3yGaaKCHRU/5ZqPubzEgVoqyMIrO1zB0FGpc
	E/TVJPrBMtRmAgnnjthHIn06XAkfpUuIQYTJdQI1hrdqgvB9hAcem+Ze2384kf/j1E6W/F
	U3se36OPxyH+zfDk++w2iMFyxG7eXxMHlW0DuFL7ciyJMcPRhYbhdCfh7vB+R/8m0M/1vN
	XXjgg65ghDfk6o+6mY74qMRKcdk4TOksAP0T3A6E4EaLnS0KbkO7M42RY+HCs3JhCv4CVQ
	xJe292VsMY7A8zIIo2g4R38dg+a8lCG4E6LJAiwLgGozaip4FzKooHx4qV2k8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752232850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NIkiaKJf/NQm5hyEx8o1BZ87gDUPuWfsYM51wav2DCY=;
	b=gNfbaGxUzG6SFWyDfKVGCHjX6CjoJ7TDZNha2kVQ2Y1wkB79PW/gBaikJ1rmCSjHFsYw9F
	Gjl1isUmzcftagCw==
To: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Mladek <pmladek@suse.com>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 2/2] panic: Fix up description of vpanic()
Date: Fri, 11 Jul 2025 13:20:43 +0200
Message-Id: <23a7e8add6546b155371b7e0fbb37bb1def13d6e.1752232374.git.namcao@linutronix.de>
In-Reply-To: <cover.1752232374.git.namcao@linutronix.de>
References: <cover.1752232374.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The description above vpanic() has the wrong function name. Fix it up.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/lkml/20250711183802.2d8c124d@canb.auug.org.=
au/
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 kernel/panic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index 6a1823c383d0..2a499facde13 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -307,7 +307,7 @@ static void panic_other_cpus_shutdown(bool crash_kexec)
 }
=20
 /**
- * panic - halt the system
+ * vpanic - halt the system
  * @fmt: The text string to print
  * @args: Arguments for the format string
  *
--=20
2.39.5

