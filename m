Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150853403F1;
	Tue, 19 May 2026 13:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779195896; cv=none; b=Gti2W2x1lzoLoI4Ilv20nnnCM/ZMbiecA+tYj/WMBIZQAiyHIUq92WreFj6gpd1vfhtVx/8YgP9b5nBPhcsWx/hRNzNMUARkUutKgo/dTg1H/bX9NHHEUZe4HWEt+01i1vVWGr6IopQkJ2EPFG+EuzifaklB64eI1Ihm5RrvuPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779195896; c=relaxed/simple;
	bh=WhQ+uCYmR0tjf1L/JYukhT+q9+gPG7Ic/uoX5LiUHvQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fmEOGzUr5O1FOBh+Rb2Ay0NGlMip/W3kOsboqkJ9I/JfStNtItAuorkjaXO/TUgdaTV7JnPAzqbGEN5WZBajxkG57XyJ2j6k0MvipsrjtvqUhnwHmHimNnbB0N/9lOrzvnPkfzPaVZIwRM7Dfg5GPGaV9C20FYZQlbaNwVGKzfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2x/0RQW5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t5vH33Vn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2x/0RQW5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t5vH33Vn"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779195893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WhQ+uCYmR0tjf1L/JYukhT+q9+gPG7Ic/uoX5LiUHvQ=;
	b=2x/0RQW5/tB9KR1IO0+l3xuD8WKFc8pJUrk0n/k7hRfUfoCyItofsrjXPllaQdwrEJwkeg
	bUs+MHttT5KAHkv4h0qklKjY4PzCBFHBINg7/Pi2GpXnK77HF0JUrUO+rYg4sbCC74HDE8
	PW5HZcqN74C5mJ1I7Bq+LM96+3XPyaYpycHf7TFantPuIOS8ZATkSfyvRzX0tj+AZljjEa
	ivXDJYsbFqsHWLxlq5a5utaa+FTuDTtFqLcaTUteuX7oppf8dDFGMAOcU5ROgiWbzbsz4o
	OsWFCuDd9k9L+2qHhPrdwE+Ge8X4OoCGFYPczIrxxeksyfPtLk+hQmNdLO0ntw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779195893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WhQ+uCYmR0tjf1L/JYukhT+q9+gPG7Ic/uoX5LiUHvQ=;
	b=t5vH33VnYWU14rGdTE++Xpe4w77qAMRPCeDJn3nqISGPyfd2UUD4UHHFsZI/1qeedD/jr1
	Pp7Ibqv4BYxKW/DQ==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Gabriele Monaco <gmonaco@redhat.com>, Masami Hiramatsu
 <mhiramat@kernel.org>
Cc: Thomas Weissschuh <thomas.weissschuh@linutronix.de>, Tomas Glozar
 <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>, Wen Yang
 <wen.yang@linux.dev>
Subject: Re: [PATCH v2 10/14] rv: Add KUnit stub to rv_react() and
 rv_*_task_monitor_slot()
In-Reply-To: <20260514152055.229162-11-gmonaco@redhat.com>
References: <20260514152055.229162-1-gmonaco@redhat.com>
 <20260514152055.229162-11-gmonaco@redhat.com>
Date: Tue, 19 May 2026 15:04:52 +0200
Message-ID: <87fr3n4kjv.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> Add KUNIT_STATIC_STUB_REDIRECT to allow those functions to be stubbed in
> a KUnit test. This is useful to catch reaction without creating a custom
> reactor and going through the effort of setting it from a test.
> rv_{get/put}_task_monitor_slot() rely on a lock, but this isn't
> necessary during a unit test, so simply skip the calls.
>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
