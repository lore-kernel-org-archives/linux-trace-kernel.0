Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811EC344DBB;
	Mon,  4 May 2026 08:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777884271; cv=none; b=lTWPOfaBf6bkTWE2ZykMlYdafaj4GPtiG/CEAbwtgHlxj3/ACos4vNVGtWOKUiA6wPeAPhPNSRmaw2BEk7pyOvkp+/vvNLD4FupKaPAF7cObXaAIZ2xylS9uHub6pPH/FjMXJm8Dg0ZWZKJtacqAAk3iSeNAJpMmDtn6yBs1tZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777884271; c=relaxed/simple;
	bh=AiWJplmtRwaNNvT0mko0TxImv1OBky18ajSf42vi4ZE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hqumni0SLTgz7yHHiOdekYzfXZvoH6D3ftRl5fM31SNQYWgRC15WKUzF/HWqetepXHpPAbks5KSHJfOUFmG/W1kgx+HnL3kSaBkfLyI+nkmllO/QZz0IBELEZjWlqY7j/mteY2PEbrTp3JH+I7TbDiGHuz2lEVhtl/V4mRYJffo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u6jtH/ZH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eki0nMlc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u6jtH/ZH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eki0nMlc"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777884268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AiWJplmtRwaNNvT0mko0TxImv1OBky18ajSf42vi4ZE=;
	b=u6jtH/ZH6SaLWbQgsoGQ6qsn+3Q4cCYXnpU8v3pcDRvIkTHzwSNi87Yyq6ZY9lkHwnyBok
	T1TdXngDD/j6vP3xWQCh09UmYH17U2Q6K+5pf68MTHG4m2APrthrCEcXqzme/quSZBrPD6
	qfOCdSGytIhAAK0p2Gww7CtUzr2pacdHAn+C6CbNhRyxLGoTolfgwpImtPNsqptjhiwpWt
	8EWYM02iOKa3i2aLhgO59ketLg18tJf36rBCSKmmevoAqzIoOK7KH6PM3C40s6H3vTfG1i
	aDdjqIhE2KiD/25PbK3/zC3hgJuGTgSjVAji+UHJ1Ws3QGDSYFBJtXYgObnVcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777884268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AiWJplmtRwaNNvT0mko0TxImv1OBky18ajSf42vi4ZE=;
	b=eki0nMlcrqh6glznxmuEQs3MtlrEc08wAe2uZ88UZdwcCbKN0yk4tyhAb8CFh4Y/zFXbwh
	tY+WKC/003/BmVAw==
To: Gabriele Monaco <gmonaco@redhat.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>
Cc: Thomas Weissschuh <thomas.weissschuh@linutronix.de>, Tomas Glozar
 <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>, Wen Yang
 <wen.yang@linux.dev>
Subject: Re: [RFC PATCH 07/12] verification/rvgen: Add golden and spec
 folders for tests
In-Reply-To: <ffb994110f4ec8165aa5a3e7cd83a57beeb609f9.camel@redhat.com>
References: <20260427151134.192971-1-gmonaco@redhat.com>
 <20260427151134.192971-8-gmonaco@redhat.com> <878q9z1up7.fsf@yellow.woof>
 <ffb994110f4ec8165aa5a3e7cd83a57beeb609f9.camel@redhat.com>
Date: Mon, 04 May 2026 10:44:28 +0200
Message-ID: <8734071s43.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> Do you have any other reason to prefer "state_d" in your example?

Because "state_d" is what my dot renderer displays, not "state_c".

> Either way we are opening for confusion (like in your example), so if you
> believe throwing an error makes the grammar simpler, we could also go down that
> path.

I can simply add a check that the node's name matches the label.

> In any case, I would make the label definition mandatory. So my current sample
> model is wrong.

Cool, so no work for me then.

Nam
