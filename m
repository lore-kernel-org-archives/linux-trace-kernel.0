Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16E9289E04;
	Fri, 11 Jul 2025 11:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752232853; cv=none; b=rlbMh2l74BwLrlAGgqff3/eXBJl52g8JvU+UjoBYbBEY8YuMGJT4GudiXmiPqtcBvWH91xr/OBapL7HWU8JmaLSKvVcihqJQgreNwc/DQJPaz5VAabD2ObwD1nVG4GH0R/EusT9ZAJ8KCm8ey0nfjA35zwMDiL/XOGHAFO+qh2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752232853; c=relaxed/simple;
	bh=e8T7P1yrozhAd2ukdWzjFRzw4hTd/X5DVBLy6bQt0k8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=apgubrV3o1xpwYj4fkFqdiBW/ejMYSRLVzJQKIhNk6bZrTijcDc9dPacmqlY774U0jYuTanZWi4Aug1r3f53ljQ+K0odWkAikVvyEvAwQz+xdl9cEDAOVng6yuCqW7ecYWXjikhKvdCbmqAwAA0+RubPtScxkX0I/4rXqzMG094=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X4qrIzZF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ftL6blIr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X4qrIzZF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ftL6blIr"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752232849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=f6fWKmXP6VT+62cMI557/cX12KC3q6GtXM+DS8J1f+0=;
	b=X4qrIzZFGe/qyE3Bvh0d3WCqHft0cQXBwvxRwRqdQ3D66poI80yWefZV9J0CCaSQCYT4rv
	hTGeY1VFy/5JmVSsQ6qEx3cnf0d5tFvPuJ9HiPK3L9qHTiJieNbwzyh/rO9tP0ZBccrOQ/
	cjjROIGX2QeUjh8i/xQRQfINvJ7fwB8rqCN60zoyTfeCLf1eCS+QBxZFKdzaXn7d38WStj
	tAjiRWS+61DhPsLPiDG22dc+h1BBlCNf76H2P1FI/v2rQyRkSifQTUGIjK9kFND2b3MvQC
	2Oi43oOe1bc4LRUvHkGZmS4ZSl7bdvGlPkxLWQFbK/hct7Anl3H+sk8lv3+F5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752232849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=f6fWKmXP6VT+62cMI557/cX12KC3q6GtXM+DS8J1f+0=;
	b=ftL6blIrgL8EvCDn9fuuAt3lcwpyVWaQ0hr23FznVVGFTR6Qjeq3p5P/ggyvdJ12xRxAPb
	zzZ/6eSkuJhN4PBQ==
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
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 0/2] Fix up build issues with vpanic
Date: Fri, 11 Jul 2025 13:20:41 +0200
Message-Id: <cover.1752232374.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

The newly introduced vpanic() has some build issues. This series fix them
up.

As the vpanic() is only in ftrace tree for now, it is probably best to let
this series goes to ftrace tree, if everyone is okay with that.

Best regards,
Nam

Nam Cao (2):
  objtool: Add vpanic() to the noreturn list
  panic: Fix up description of vpanic()

 kernel/panic.c            | 2 +-
 tools/objtool/noreturns.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

--=20
2.39.5

