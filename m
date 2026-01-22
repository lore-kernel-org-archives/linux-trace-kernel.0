Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29FD2951B3;
	Thu, 22 Jan 2026 14:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769093173; cv=none; b=rJoBUTIFLMW+3QBASjHIh9cTWRxCxgQJxxXPi9pZ5lJ5gtXfiT8gUnDNufY/U5t8GluDjww4pizCDp29Z0eCIkFsaXVTCIZFc/5+TqJMobXIqfaHFl7nIzFLXlI0wNYiM7Ji+TlpxXi7gmgQWCBOJAj6p3vsKskmW4gVVY0pv8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769093173; c=relaxed/simple;
	bh=fX5FV+RPiqDK2QH1UZXDzdFcnWGhslVFIzkkeFeSTM8=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tHOtpLs2s+aWTQcCeANFcSsEcvtIb9b6HVa+B1QxON4k94zxzlXqF6t3nug33Jz0AXtV6dA8/nK16eYQ2rdqufD88BG1inc0shfAoAThh1snSGWiyhC3zMDx4KiT1yBCsesIK51MBsTRhLsrZt8P5Cr9HQ3I/1lXKRH5qz3vHM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v506WAT1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gof4spi5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v506WAT1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gof4spi5"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769093169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fX5FV+RPiqDK2QH1UZXDzdFcnWGhslVFIzkkeFeSTM8=;
	b=v506WAT1LBuXAmL7paA9lR1PiANT7vJpje/1wkXJLKW8TPSs6XWARCMoG0xXBAWiiynR4z
	oFSYw+gEujP4ypH02mxH6WTjNVqm9huHabB65jpRJxKxSswHvcjuDm9tECoJAC2w05RpOn
	+3dJPa7hFAWkbWy5zZSwRHhBAVCAMbtuiMP4ayvOGTOIkDGUgzAl3GIs+KMyZT2rT4LgOi
	83aG/JNyFiIH9GJwH70x+BHcPkglSgy8fpRVKQ7TrupjWWqM8ez89day0Q9dyBmiN6SUip
	VK8Gp+z/WHMk1cAE3+9/subeOXsYO7CcHbUAStL6XrWfqG63pCAX+rZQbwkj7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769093169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fX5FV+RPiqDK2QH1UZXDzdFcnWGhslVFIzkkeFeSTM8=;
	b=Gof4spi5tmYWjdwLVyizMrYMpmKCRSWqRpkpVSdyVgO6nTLkNk1K4u97Q06dQHFrOUQyoB
	4OGfEFRKegjy1xCw==
To: Wander Lairson Costa <wander@redhat.com>, Steven Rostedt
 <rostedt@goodmis.org>, Gabriele Monaco <gmonaco@redhat.com>, Wander
 Lairson Costa <wander@redhat.com>, open list
 <linux-kernel@vger.kernel.org>, "open list:RUNTIME VERIFICATION (RV)"
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/26] rv/rvgen: replace % string formatting with f-strings
In-Reply-To: <20260119205601.105821-4-wander@redhat.com>
References: <20260119205601.105821-1-wander@redhat.com>
 <20260119205601.105821-4-wander@redhat.com>
Date: Thu, 22 Jan 2026 15:46:08 +0100
Message-ID: <87h5sdso27.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Wander Lairson Costa <wander@redhat.com> writes:
> Replace all instances of percent-style string formatting with
> f-strings across the rvgen codebase. This modernizes the string
> formatting to use Python 3.6+ features, providing clearer and more
> maintainable code while improving runtime performance.
>
> The conversion handles all formatting cases including simple variable
> substitution, multi-variable formatting, and complex format specifiers.
> Dynamic width formatting is converted from "%*s" to "{var:>{width}}"
> using proper alignment syntax. Template strings for generated C code
> properly escape braces using double-brace syntax to produce literal
> braces in the output.
>
> F-strings provide approximately 2x performance improvement over percent
> formatting and are the recommended approach in modern Python.
>
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
