Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C734F1C6BE;
	Wed,  9 Oct 2024 10:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728471441; cv=none; b=oMAIVTLOLC72xSaZu1M/lwhgAuIZ5lWGr0Et8hF+tWQeszpzBHpiC448OSqjNKT0aUyv6bBw9L6wzy4SURomFfw3gUp85IaAHytZaJW3hyCZfwUAt1rFc3OlCeHK7wRwu8jhqKGv/PnWLT6a0eXviGKSga6QXWXvakfgoL8182E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728471441; c=relaxed/simple;
	bh=032ziiroQTiNKVawf3Wn8Zdl0dIKkOZPqEzlfNUst9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kcgz2gjoiumYkUSrv+B4Pyj0ctgV8AIK3Iv+gdPriPN/XiuplfjqywGabH9Wl49h/8nMaGgMyyCbLI+wz6p+ST9lOjCKXBc4FJ6YGTPnWFeFk5xWiTxY7BfLh9iAqVGrSfR8KqKKD+DqVCjsLFz2XCeeX4nPbhD7aBk4n0prfLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xmlcLvkV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KNnoJu19; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xmlcLvkV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KNnoJu19"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728471437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Vkl75nSoihF4r5UGBNtRtcHj1AUP5VT9Ah3G70neEFs=;
	b=xmlcLvkVj/n+hn5pJRvkgi5ESkA88PLftWrnTW2J69OS63cyJ1AUc0CmrjszlEh9zfpRUV
	LlA6GkGcqwDBcL4/ZORiPahfIqXOowLoy2BkX1jP+5PfCGZiaMGUBxVUm1qyWnGV7zjfzJ
	iWdvPT+/QzeL8iexRAboBP4kijRk0xXamGlz3B8UzYJ9YTcMthMXO9LcSSP31pY/SmzTEz
	67dlTT7wggItgwU8O9RE9U91Ik1z2SeJR7c+CTo0G11dKD4J1t8FUMoowjP38fhcvN3gMy
	+XsqidnP3zL4GVDEB8hDIjG7Sh9fOVIaXyJmiCQOtQDj3yGCs/nJTmHvb5A1Wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728471437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Vkl75nSoihF4r5UGBNtRtcHj1AUP5VT9Ah3G70neEFs=;
	b=KNnoJu19Nv00iejIUriVVffmSwyMtzgj9WaBesY/sCsOHI4hjvMU54yRZkAoBoRGdka0S/
	bx6aj/iEztaPtuAQ==
To: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	tglx@linutronix.de,
	mingo@kernel.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	ankur.a.arora@oracle.com,
	efault@gmx.de,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 0/3] Lazy preemption leftovers
Date: Wed,  9 Oct 2024 12:50:54 +0200
Message-ID: <20241009105709.887510-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is a followup to PeterZ'
	https://lore.kernel.org/20241007074609.447006177@infradead.org

in PREEMPT_RT we had initially "LAZY preempt" this then morphed into
PREEMPT_AUTO and is becoming "Lazy preemption".=20
These are the tracing bits from that time that were used up to
PREEMPT_AUTO. With RT's RiscV support, they also contributed
PREEMPT_AUTO support which I just updated to current edition.

I used to have ARM* and POWERPC*, too support for the "LAZY preempt" but
this relied on assembly support and I dropped this during the switch to
PREEMPT_AUTO.

Sebastian

