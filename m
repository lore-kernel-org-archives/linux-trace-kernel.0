Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB035EEB3;
	Mon, 21 Oct 2024 15:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729523590; cv=none; b=U8dMSD2b71NRa3j4jqnWDCbdJnbqCjgXUXwzkKvqcN9YOZhLHVUXWNF3+/X6o+J8TheUHvIXvEl6aMFLKdKBtZU6s4jjhmuvjwZ4Ijap68MM+2A8XxmThdOEHLl2/QnElrLAjPCIL0GAJwOIjSoqA1GaPaxhwJskMpRgcr4QDRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729523590; c=relaxed/simple;
	bh=2AKw56P/tViNVJdwOECZveIh/P6MkPNPfSKa2q43zSU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FX801zkcjyY7UYNCTEqcLN7+k9ZEfImQiaH/KaXP5e6ylOsrtWDknarXEFFCByox/cIBIArr/ZsVQwyT1BnjMb6NQ8YfoODziFE//HZ8cZ8pl1r5bNdU/IUmF2ShyRiComsaR7spvQ8it8fj3gFpOPSkPq3a5+YednKnlPa5aOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=du58+yYD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uqgGrCyN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="du58+yYD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uqgGrCyN"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729523586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b8YSql3xP0SHoPJurf2xbHM8Q3BHoK810vSQxF0qUds=;
	b=du58+yYDfq/DjnitNbVpmoZ2jpmHYqyizWoSJo5V5RzBF+T9yHo0Lf07HvgatKG4u7ZyVp
	MfsrTiGWgw7SXcWi04dnRGKAxGu6fhH2Z1fDAHbTHhFXsRNFbfgGh2y3jY9cMayVj3PtRw
	SCztr9bEzDNVuAI/tDOskE1w1pR00agW7KpSxTf2pIbAVA1VG4/xx/5y2mj0Ar1qGiJiM2
	JQVjn1EBUuS3SvWPQ1BYdExXgz4Hodazkf/KvXEM39qKJLjVKN67PjqmrorRoyKVxEca04
	hJSyMv+uQjrdtm1AWiVYkTAqif1fopHpmctLGgTa5QKtKPZ5NbKW5a5ZyZg/3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729523586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b8YSql3xP0SHoPJurf2xbHM8Q3BHoK810vSQxF0qUds=;
	b=uqgGrCyNMrKNOLykncvCj6sfnT0b4+CHzIghG+TNUOjyPOk91RsUt4mw3yUEvJTdefZsBl
	qgE3xPhaJQR1bUCw==
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
Subject: [PATCH v2 0/3] Lazy preemption leftovers
Date: Mon, 21 Oct 2024 17:08:39 +0200
Message-ID: <20241021151257.102296-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

This is a followup to PeterZ'
	https://lore.kernel.org/20241007074609.447006177@infradead.org

in PREEMPT_RT we had initially "LAZY preempt" this then morphed into
PREEMPT_AUTO and is becoming "Lazy preemption".
These are the tracing bits from that time that were used up to
PREEMPT_AUTO. With RT's RiscV support, they also contributed
PREEMPT_AUTO support which I just updated to current edition.

I used to have ARM* and POWERPC*, too support for the "LAZY preempt" but
this relied on assembly support and I dropped this during the switch to
PREEMPT_AUTO.

v1=E2=80=A6v2 https://lore.kernel.org/all/20241009105709.887510-1-bigeasy@l=
inutronix.de :
  - Added IS_ENABLED(CONFIG_ARCH_HAS_PREEMPT_LAZY) to
    tracing_gen_ctx_irq_test() to only record lazy flags if the
    architecture supports it (Ankur Arora).

  - Added a bit of Documentation for the additional context status
    (Shrikanth Hegde)

Sebastian

