Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1CA4052A6;
	Fri, 31 Jul 2026 10:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785495578; cv=none; b=cMr+wm685j49SN35lQf2pBHdvXDHbwYG8kVyrrpL8A9Wo9Y2nBwbXHdnKRzGdNe9XTM6CGua0Ay1y/kWclNDbfDJq2C4/FI6qk1Fg/BGwOW7Hbys+3sQVbjJRTDLeR9gAEuv1K0cQzLRRj4TutczTbCoevIrJkCS1kcbM/c3cf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785495578; c=relaxed/simple;
	bh=upwLOtqlOSwtLR8J6PAJGxklTNcWRiucZxwNFxXYTdQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GFOiknIZHj9iG/NTQ1UCFubKiC4rjsLbXHTFBFIJK+HJN0mvVoXXrrRR752ehNLTWr1mv61tQNRlPTqocvNdTKB8WQnzBVW3ammOUPA8ppaIPFro+NN672G6MS+jxF54Z48a39WOVA36Q1vWGNwRfE8qyNuYD66MjzPAO8Wvs1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=04MWaCfq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+4G4vOBC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="04MWaCfq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+4G4vOBC"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785495571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=upwLOtqlOSwtLR8J6PAJGxklTNcWRiucZxwNFxXYTdQ=;
	b=04MWaCfqLr5r/YHxwmC0hncGDiU73CHc8SW3umiJ6+Eu4t0llpeTgi9fAYtc0y4vw1Pnv+
	XjUnpFLU+UBEgqOc6eAIudUTtYFc17zwk+eI9oevKPHaPNfSdEwh7VfyXkyDkyt2vRNG24
	r5t9qE1Ag35gYOPkNP6X8VtdXKOT6kiKhzNyjE0sWh9UmGlkbYoj1dM6W10MkbUVhGGE4G
	Tyj4qD6TiXk290YAkB1BwLHKvw5jSsprA4ptJf8oxnzhFqZiBXjX+wP0JU9r5YveUH4AiV
	TksAi/QeNhtai07ZUcCKpxayJlPdYtqb5q5IgxIOusg4OAFD1LUqb2qWiqOfWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785495571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=upwLOtqlOSwtLR8J6PAJGxklTNcWRiucZxwNFxXYTdQ=;
	b=+4G4vOBCq3LUpvyHIeOiLVDzEcFUNIgquxyW5sLj22ORtLaKNUNqkdqiuov61bRwf3Etog
	saMxZtJ9uTCs9tCQ==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Gabriele Monaco <gmonaco@redhat.com>, Masami Hiramatsu
 <mhiramat@kernel.org>
Cc: Thomas Weissschuh <thomas.weissschuh@linutronix.de>, Tomas Glozar
 <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>, Wen Yang
 <wen.yang@linux.dev>
Subject: Re: [PATCH v5 13/17] rv: Add KUnit mock for current
In-Reply-To: <20260723074534.43521-14-gmonaco@redhat.com>
References: <20260723074534.43521-1-gmonaco@redhat.com>
 <20260723074534.43521-14-gmonaco@redhat.com>
Date: Fri, 31 Jul 2026 12:59:30 +0200
Message-ID: <87jyqbo25p.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:

> Some monitors do not only rely on tracepoint arguments but also on the
> currently executing task.
> This makes it more challenging to mock events in KUnit.
>
> Define wrapper functions around current, the functionality is mocked
> only during KUnit, an additional function call is avoided using a static
> branch unless any (even unrelated) KUnit test is running.
>
> Rely on a global mock_current variable that is set only by the RV KUnit
> tests and cleared on teardown. Unrelated KUnit tests that happen to
> trigger RV handlers would see it null and use current.
>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
