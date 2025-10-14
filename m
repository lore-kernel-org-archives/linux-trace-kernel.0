Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8F752F88;
	Tue, 14 Oct 2025 05:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760421129; cv=none; b=GSQ4iF2fSR82Fc4UMX69yV7RD1I+yOKgiGhSLPJRvMVSuoS1TANyvQ1ASyiCzPQ3KdJI3H7F+sYX2zZaoFa58cFVTEX5IHG+A1NqBPugwuHSFj7Sz7AEFvppVXzEuBOOahKjsdkWHq/gffK1e+WCTfyADPsMmb0he5+ndXEO3UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760421129; c=relaxed/simple;
	bh=rbGY7hsNZW/Gi92aeoA6ZkT6cOMkgjgAqpGxtROcp2U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pBF/v2rZFxZRC5o1WlB9S2bW90UwQx1V4Y1ICjLdtGIJxA1PCFPkw1MqXep/2zMB0lJ61S6lqsohCQgkwtHywr36/2cVEI+u9bnUsPOd6B8EmWqNjDPCnjstNOOYUUUcCGVV0EWJ9d8b6TXHWrhoxBc5e/pi0n2fqfNpsWXj578=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ycq5VY40; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k5wjehNw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ycq5VY40";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k5wjehNw"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760421124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Cbrizgz6WPfeMwj+czbdKF5T2U16SbmHYGAnizEg+vY=;
	b=ycq5VY40KUWYbIc/AX+OEXq33R4g6FFkD8rF7w4TJAo7vN7wy00Oi6AJHWe9CF6hjg4r++
	7ijo5+zPv5F/j5CLbc460PL+N4SN5SO2LzTNcFJHIn8YzFCgdhiuIpsp9/NguePNebEG0g
	Tu/Wb2dB0nZPbtYVcpNBK8KrJKKtuA5HHxDMj85vRI1is24jwzZPibGbjZFXEB4Cz241g1
	aOSJ9FhlsAPBwJ90i8FBzqNiStsAjXNn/t4H+1xXK+qiYwsLA8AOPILVWRjNiX9Vc3SbPT
	RPYhHjQ7oT7gXfHjx3hb81STL543bFmCphxMVvmLybvgxx9VjPBoDgiOSoMpTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760421124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Cbrizgz6WPfeMwj+czbdKF5T2U16SbmHYGAnizEg+vY=;
	b=k5wjehNwvQAXpyuVzwofHCnAvKBVYGv9jNAsmIz7UHNzIT+HtgCte7OkVMtBeMrfdcwA8u
	FvrtdvtB7s1rKUCw==
Subject: [PATCH 0/3] rv: Add explicit lockdep context for reactors
Date: Tue, 14 Oct 2025 07:51:55 +0200
Message-Id: <20251014-rv-lockdep-v1-0-0b9e51919ea8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPvk7WgC/x2MQQqAIBAAvyJ7TlAjD30lOsi61VKoKEgg/j3pO
 AMzDQplpgKraJCpcuEYBuhJAF4unCTZDwajzKKVnmWu8ol4e0rSOvQ4rLHKwQhSpoPff7btvX+
 okYcCXAAAAA==
X-Change-ID: 20251013-rv-lockdep-6acdc510260a
To: Steven Rostedt <rostedt@goodmis.org>, 
 Gabriele Monaco <gmonaco@redhat.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Nam Cao <namcao@linutronix.de>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760421123; l=1144;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=rbGY7hsNZW/Gi92aeoA6ZkT6cOMkgjgAqpGxtROcp2U=;
 b=OWXRZxtpRS5N6vHKBEn+fGBPCt2eQH5ywoIhglpcmAQbdPX2za5gXvDVJItlCcECAyyvgPzMo
 zxNZjUvfiLCAZ/XonWfOOLpyPiuMchOBpv7fnVE3JmWKMNId/u2lOsJ
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Reactors can be called from any context through tracepoints.
When developing reactors care needs to be taken to only call APIs which
are safe. As the tracepoints used during testing may not actually be
called from restrictive contexts lockdep may not be helpful.

Add explicit overrides to help lockdep find invalid code patterns.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Thomas Weißschuh (3):
      rv: Pass va_list to reactors
      rv: Make rv_reacting_on() static
      rv: Add explicit lockdep context for reactors

 include/linux/rv.h               | 11 ++++++-----
 include/rv/da_monitor.h          | 35 ++++++++++-------------------------
 include/rv/ltl_monitor.h         | 18 +++++-------------
 kernel/trace/rv/reactor_panic.c  |  6 +-----
 kernel/trace/rv/reactor_printk.c |  6 +-----
 kernel/trace/rv/rv_reactors.c    | 22 ++++++++++++++++++++--
 6 files changed, 43 insertions(+), 55 deletions(-)
---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251013-rv-lockdep-6acdc510260a

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>

