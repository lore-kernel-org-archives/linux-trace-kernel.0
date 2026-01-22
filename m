Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FB640F8C5;
	Thu, 22 Jan 2026 15:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769096106; cv=none; b=QVxuEM2lP/Z4Ihu9514d6X38jyku/9/cl2EiJxcsI9XwRmRoUpGcc6qZxwG0FBpbBBMvScIM98HtbJPMx5wcTK+0yXwHv19J1YUxG3e7Gh2w47ODod55u40RYw1BB3LEhf6U+BnT94+mwh34mKAdOa4dlW8sNBuU2/8o0lUmXgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769096106; c=relaxed/simple;
	bh=7zBif//8s2yiNTAiavmjXP5+52FXXihfqk10rJQH5RU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cmXzp7A5vPHuFAjoVGX8/Qfbzc6a6zuayTHC83LBwaOYgNEN8PINeAgWktPn9ph774xe6JEHt+hc/9bIo/+ZH5gFAQZ+FgBgUPbnYYWA5UZ2QVQhJONM7yaYkpAIsCCRlxWnpZIRsj0ykMxWaK7BnB5eWEou9KOEWBNF1biG/1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xQ4s5/sF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JJss4omS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xQ4s5/sF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JJss4omS"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769096103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7zBif//8s2yiNTAiavmjXP5+52FXXihfqk10rJQH5RU=;
	b=xQ4s5/sFg1x/SWWYJSaY/dcMB/np/O/hsJAVq2vI/i1X+dUQYTpwfwaSAZCBPZW367XCF6
	GnIMS5+dumBLTcVKPt7frZVtI+ZqsR1fKXqsW5xCB8ADaInwvaXHeL15O9cpxSAw9oZqQi
	9Pj73tdL+k7+JGBGSg2hpMfP2nBVtor95nw8aSCWSX5P08D46XMRH5KigEKHFoXVlZO7Cv
	idaOhIYyxhPvETWfq2V5PtG9FLh/2v3889YufCbQVsW44aBE5dp0FU/8pSjH2vnAWJkalv
	GhvzmXe2LzNZL8nwgWe7ZRmlZLKgtPQh3IOhHKtkShMiE4KGLzlrRq3+yvrm+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769096103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7zBif//8s2yiNTAiavmjXP5+52FXXihfqk10rJQH5RU=;
	b=JJss4omSOnjZSmY83/QxQkCo05YWmFESKIbXjzJn+SeDqkqpVRBUwmKCYYhYbHfY9e8bqG
	5k1QodRB+mX1jUDw==
To: Gabriele Monaco <gmonaco@redhat.com>, Wander Lairson Costa
 <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, open list
 <linux-kernel@vger.kernel.org>, "open list:RUNTIME VERIFICATION
 (RV)" <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 20/26] rv/rvgen: refactor automata.py to use
 iterator-based parsing
In-Reply-To: <b024746953391fbe87427f994a973a212c2fb445.camel@redhat.com>
References: <20260119205601.105821-1-wander@redhat.com>
 <20260119205601.105821-21-wander@redhat.com>
 <b024746953391fbe87427f994a973a212c2fb445.camel@redhat.com>
Date: Thu, 22 Jan 2026 16:35:02 +0100
Message-ID: <875x8tirtl.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> Just know that this parser is already quite fragile and we are planning a major
> refactor using ply with a well-defined grammar and tokenizer, like how the LTL
> parser is implemented.

I will get to it after your hybrid automaton stuff is merged, I don't
want to deal with conflict.

Nam
