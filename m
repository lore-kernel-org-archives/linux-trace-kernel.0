Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62ED2E427D;
	Thu, 24 Jul 2025 17:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753378424; cv=none; b=ZpBF+YUNkvXrWNJB1rqR6O5sVkZkErwR+RxyyBTvL/ef7/dt2Mop6M4c/VpNN9aRgrh4323gxMl/XgQAlPyv/L/y4SCF0kStWHfv1aY71LYAW/BlgM7oZ5sHcBPX5FiaWwDbMoBlmBG/FvH3YO49N6jbC96Pa1p3xwPFf1/Nxe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753378424; c=relaxed/simple;
	bh=I3/6S9Q4JL4ymfy4KfW14+bgzgWaBRaN8C64bbCJT6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZJ+tcvlo6cgNhF4P0NgiI453kRRvw/0Czw2GDRpM2hOE54Hs3kVhTaKtnX5VwqOGORyEuKWTPu9b/1vMfB3XlTKot+q+GLJXPdcrgFszmxnLbBYY5qDsTCvQpoSjoKaM5t1N/g56e2Q/rb9h97uSH3gyE1e8MfpIQLXTWORZ1uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jYE0xeyJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RAOL7mbf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jYE0xeyJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RAOL7mbf"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753378421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pqwf5o73kCLdf5NSJ0f43js37vB+8seX7MGAGCT2bTA=;
	b=jYE0xeyJqtnKoyddMJdPPcyqq1yhcRNHn8jCZ2rxSKEmtAPAtB/pXLqUMJZOrMKhKBkaJ7
	XyjiSRxJwab1aOxIA2fT22AeBHcoe+/XZHYS0Bj4D7MA6qIz38c7z4hVEJeF9eKWGr0ttd
	hMagITbGDRlpUzdvvlzxkrLfPqQVbmaMAkNn3I9S9rZM7bm4NPsdlFp4w9W37rwapdZBVm
	46eQSxt6g1EHQv51a9T3/OU89BMImAqyOQPv9NEbqrqmB9psB9ubFrKHztAHPI5lBCJTXG
	xa6p/bHe8sYPPe7YjkrRjmVrsanUQPhMXNfo1e2vVnargJtx5r2p5P3uwn8Tcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753378421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pqwf5o73kCLdf5NSJ0f43js37vB+8seX7MGAGCT2bTA=;
	b=RAOL7mbfYpfBFMo75nv43iaSfjH3un5CcU3TcmsgNfavisZOZRFYx/rHEC7/BB3i43K2cq
	ouvSe2zgSafn+UDQ==
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v3 1/5] rv: Remove unused field in struct rv_monitor_def
Date: Thu, 24 Jul 2025 19:33:26 +0200
Message-Id: <502d94f2696435690a2b1fdbe80a9e56c96fcabf.1753378331.git.namcao@linutronix.de>
In-Reply-To: <cover.1753378331.git.namcao@linutronix.de>
References: <cover.1753378331.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

rv_monitor_def::task_monitor is not used. Delete it.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 kernel/trace/rv/rv.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/trace/rv/rv.h b/kernel/trace/rv/rv.h
index 98fca0a1adbc..873364094402 100644
--- a/kernel/trace/rv/rv.h
+++ b/kernel/trace/rv/rv.h
@@ -41,7 +41,6 @@ struct rv_monitor_def {
 	struct rv_reactor_def	*rdef;
 	bool			reacting;
 #endif
-	bool			task_monitor;
 };
=20
 struct dentry *get_monitors_root(void);
--=20
2.39.5

