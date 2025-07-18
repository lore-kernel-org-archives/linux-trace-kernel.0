Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076052F50;
	Fri, 18 Jul 2025 14:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752850700; cv=none; b=fBY1qGNwMqKGGbDX8dluwemTZ2CJn3nuwwCy+Rw0rYzgPYbxxBCT+S9l/QNzDhhXLWqC2rZfbQ4/zK50ACYlNdyL5TLpPiMW00mn4owq0Umcpmb3S4hGuZDXuMFafaoO8tRV5Kt/lS0w1bNon0aBky5IFjRnTceL5zH5pCfn/pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752850700; c=relaxed/simple;
	bh=wWSgIbnPetVQBeDGNiF9Yoz9AinSTyA9IF+vtMzclfs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WiDVxB1rory4HchtyMLKE7zaHMXSrREOCp/0YLHMGJMIjWY1ISU7rxJIE7ot1AXOdp3+PAmYO/1tikSZhQwVtQT1RpqA+SrscW4T6yqp1S/Db2+8SGWt0NxkAaOKlVMeHGbxaFUFKzBcqMkUgIEwk1ilfQxszO0GrnuFKzJr1Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u/VEsiU+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i2aq5h80; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u/VEsiU+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i2aq5h80"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752850697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=m3GdAv4vPjjLhU/AUk+zqDQSqSHqQaAQXnxfz7uKxHk=;
	b=u/VEsiU+qRldtxCc7DQ/LNdGlZUMRLndFxDpBr1WFNkG1BRDrTdXPzhrVvDuYk4sQG0cyx
	Sgcr/R0x3Bo204zHZOyi17NPwqSwhbjV/0ZzlbfW6L608Oify02sRi8RNZoW5UtUCV1yRt
	QTLgpfVydFFd1tNO4mup0l5cf+NKsiStG+j7KLZsUPEhUZgDmQC896kv5jHWiHca1BvLdh
	9qa/bB9EV2PtlDjN5ncMkhIO4BzrfXfTxB/Lt2Z6STjuXQuaySuDUJ+d05jiBJhSCRqyI1
	zWj8UhxKcECDjyd7/sbfR74BeSEPL9j6BT5x0Tb0p5ctbt9ExyFxrcGGnX993A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752850697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=m3GdAv4vPjjLhU/AUk+zqDQSqSHqQaAQXnxfz7uKxHk=;
	b=i2aq5h80yGxyYb7/oOFaueNfyjQ62pFSGsVaR66HB0bNmJYXHJMeWLiOfFJAWBPXiRUH1K
	PV7T0WicFBCH+yBA==
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 0/2] verification/rvgen: Fix variable definition generation
Date: Fri, 18 Jul 2025 16:58:09 +0200
Message-Id: <cover.1752850449.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

The ltl2k script generates a variable definition for each node in the
abstract syntax tree. This may causes compiler warning on the generated
monitors, because:
  - Some of the variables may be unused
  - Some of the variables may be duplicated

This series fixes these issues.

Nam Cao (2):
  verification/rvgen: Generate each variable definition only once
  verification/rvgen: Do not generate unused variables

 tools/verification/rvgen/rvgen/ltl2k.py | 33 +++++++++++++++++++------
 1 file changed, 26 insertions(+), 7 deletions(-)

--=20
2.39.5

