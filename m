Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67EF3DCDB3;
	Tue, 19 May 2026 07:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779176996; cv=none; b=lVLcUjaps3PZbb64uqHYJmhzPCBZ3ILA2c438BCwHS+rTUHUaR9HjoOvRN960MyUBTZrXrQV6GaakyHacP+pGKNWlhYAcbccGGPpRT1cFsNWghq+BqXjPsADvPLufQFKG9w+6MLTdIN+K6/NNXQ34qEsawRLjmtSQ36R2f/7tx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779176996; c=relaxed/simple;
	bh=OKQEX2OO7x7N4m5y525SEyY23jWDAnZ7nUMi7MZaXes=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NxbHAHTZBNOBXumk2gFj8K/gNJSv6HU+IEscroaTzALmaVfJ4kqmmWFRk6dLrheN7CX3tTSRo1H3IktSx5lNNphgN7VM6v9VCElJm3jsfpFBwHbuiIurlTaUXw+1HvtqOfq3RaWUVzIWS/xvfoonW9liQ1eEFVa+UUH0XSRFD5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fM8DCq9+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a3aklmvz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fM8DCq9+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a3aklmvz"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779176987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wXFR9pVoFi3l4DAqaL4FnBGXHNwqTy8gPmZSxSwfvWc=;
	b=fM8DCq9+6kXd/rIlEi1j8NCZX9/7xL7B3BlUtbaJX1J+FshV8MOS6O9M1x/w3zOPT4c66N
	MAcukkAXu1GE+R7btLu5uTKXZxF5DjwYpYC3tCKZWkdlFXiZQLTUqJjJBvpc3TiksMp8Ly
	NHvsjok9gSvuueuUbvs9WJomfs5YWLbP/scmeCeNxhtBZQ913j7UaCugjtNFRSoJuGLQNC
	4hvFjXDwOIdTqPfGJyueN+r5PXdrQ+90/zlxYRJaOibrU1qg5iXN5iR4GKrrKA5BSWnNwg
	mw8bGAxfyqZfW2P3OTxSR8+50W+0Qcmt3B6dE5nLQLizanM5qadn6N9Vr6w12A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779176987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wXFR9pVoFi3l4DAqaL4FnBGXHNwqTy8gPmZSxSwfvWc=;
	b=a3aklmvzAvALJWhpgCYaSluUpOZE43J65KHGh5ZK6Jrs0al30rpszLMOLfSDJ08YajNq4a
	DcFK4KSqmbsWyLBA==
To: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 0/3] rv: rtapp monitor update
Date: Tue, 19 May 2026 09:49:32 +0200
Message-ID: <cover.1779176466.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

A couple of minor improvements to the rtapp monitor, making the monitor
more informative to user and update the allow list regarding
clock_nanosleep syscall.

Nam Cao (3):
  rv/rtapp/sleep: Make the error more informative for user
  rv/rtapp/sleep: Update nanosleep rule
  rv/rtapp: Add wakeup monitor

 kernel/trace/rv/Kconfig                       |   1 +
 kernel/trace/rv/Makefile                      |   1 +
 kernel/trace/rv/monitors/sleep/sleep.c        |  18 +-
 kernel/trace/rv/monitors/sleep/sleep.h        |  52 +++---
 kernel/trace/rv/monitors/wakeup/Kconfig       |  17 ++
 kernel/trace/rv/monitors/wakeup/wakeup.c      | 155 ++++++++++++++++++
 kernel/trace/rv/monitors/wakeup/wakeup.h      |  92 +++++++++++
 .../trace/rv/monitors/wakeup/wakeup_trace.h   |  14 ++
 kernel/trace/rv/rv_trace.h                    |   1 +
 tools/verification/models/rtapp/sleep.ltl     |   2 +-
 tools/verification/models/rtapp/wakeup.ltl    |   5 +
 11 files changed, 318 insertions(+), 40 deletions(-)
 create mode 100644 kernel/trace/rv/monitors/wakeup/Kconfig
 create mode 100644 kernel/trace/rv/monitors/wakeup/wakeup.c
 create mode 100644 kernel/trace/rv/monitors/wakeup/wakeup.h
 create mode 100644 kernel/trace/rv/monitors/wakeup/wakeup_trace.h
 create mode 100644 tools/verification/models/rtapp/wakeup.ltl

--=20
2.47.3

