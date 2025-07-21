Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F62283FC3;
	Mon, 21 Jul 2025 09:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753091252; cv=none; b=OG7bK9osogJsJnvPw4eP7Jr5KlRTUgtb13JfaQtygNihRGfsUH0kh810RV3WujoSkF2XNFlcLFdfd18NTc/pLhSYJ34kLqi085rFLGvk2ViGk6moAlbT4SOJZa1as0dsd1aO0HGnfuAw9o6HZVRm+pmVHjyQbSZHEMLb8idAs6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753091252; c=relaxed/simple;
	bh=7X+JDKnS/okCWrUZLdeZVOV5eH+Kwj8gqSMwhjegf40=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p14/jVbNGV7JTnRFtlwx2AZfaR6jQ6A5345amYSN8EfThhjdnfg0e5+5t8ogrq+tjT2owbdvu/cjW+WA8TLqgCX1eHJIMR4icVbgl087x7njm8eEoENKmBQTV7DCWMCG2PBdYLD3ElpdwidDXU6ZNRS2/k0JHHkvqe/u4stb7l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Hkmqurj/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s/1jfdqY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Hkmqurj/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s/1jfdqY"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753091249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=exDP0K2ghmuDZQrav3SKlw4J85LtRUfXjBEkd5gZGXs=;
	b=Hkmqurj/8XaaFA4GVK+P6Vj/fvn4JP1y/GgDBfUidgSnRPVPrqjxBT8fmF0ap/URQhaN8d
	AfrrRKmBi+ioqB9A4Qddtr/OtwnaQDofPdSorwopNt0P/nTw16cw8u2PzFBsx9xPYYtgaf
	QVTwRMMRjXcjYEg2VMmDqO9mj6nmo9p2rnbTbqYtRvbXk9JwmFoK0BcGKKqWCCMWpIXbUb
	TS55xNS+jZqpYSET5Ia5DCKj22UAuHMrOtSRsj81LNgcuIuIzovyr2XXl6K2Kh6n4MBnQv
	6Ye+lYdJ7Uxqy/QrcAlJhtn6L8C5PeBWgk14uOrsA6zA/mTismOXAvmBEYm8KA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753091249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=exDP0K2ghmuDZQrav3SKlw4J85LtRUfXjBEkd5gZGXs=;
	b=s/1jfdqYZnh+UHZdamqK2+7g1nFYmEzx4oR0XScQLhMgYac7nZTe7JpwFi1QdUH4JHMKBe
	W+22ndRxgn0hItDQ==
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 1/6] rv: Remove unused field in struct rv_monitor_def
Date: Mon, 21 Jul 2025 11:47:08 +0200
Message-Id: <68e223323b11aad9934344ec1764337b2f18c080.1753091084.git.namcao@linutronix.de>
In-Reply-To: <cover.1753091084.git.namcao@linutronix.de>
References: <cover.1753091084.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

rv_monitor_def::task_monitor is not used. Delete it.

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

