Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72E43502BE;
	Thu, 22 Jan 2026 14:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769093210; cv=none; b=eFlud1ND6+LgE6/BKdXEM4wylwvCsU+CWkEWeKUtEniqxLFPp/HyOi8XbwVk/eWwqCTH5Bj0PE6mMq2wG0gYdi9EjfrKUQcWi4UWaPz7lRf1Q+sMSPRZBuQTPW4CmiDogUOq6pOK30oihK/f/khrohs7Vka7ZkQvwqUHqPzDi94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769093210; c=relaxed/simple;
	bh=c90EgR9tz3kYbFm256cpLtlKiUhXIItUtyO9tWf0cgI=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hgt9RqLOjx8B2KYay9G/1EmcxBCN/vG3UFr7UszCV4fXuKj8apS50hq5MKcrvU3z9W2w+qwYN6JudoRtIaLT+PZf4u3qEC0Kq5YIkNc4FDxPMKdBLZctafmKlxyu+E/4xXfMclvt0RSSnGuhQpatSpU4gD+VBRCOtghhumFQS4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z2cNFA/O; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IKAcjwKO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z2cNFA/O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IKAcjwKO"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769093206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c90EgR9tz3kYbFm256cpLtlKiUhXIItUtyO9tWf0cgI=;
	b=z2cNFA/OT7tQCje3rhSCCiWqjlUN2VMbX+GXDYulcSok0It8VApg4JOhXU5aStV/S4jLfU
	6Tu060mptpVeKd8okLUx98hyCDtEcfwPAzYvrljBxfBilkdfmcCjnJQKrjoneevPknvPWw
	ZhLK/SWiIp1bx/+oRht3xt0d9Jh6Ngw2yToD3KOUuOPRSQGNewAhvSvJVIbtEngnRqx2F9
	Qi3FxkTzFolkHBuFEw7bi+aJIENfVJIKvB1anrHllw1MvrLAmxC86kWcdzCSfH4M1LjDTY
	CjAIMGbpcHT27Ilp1gvUo48B0XK7fthdhKKuq1JWjREehsmlqH1EfKN1tj6Zmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769093206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c90EgR9tz3kYbFm256cpLtlKiUhXIItUtyO9tWf0cgI=;
	b=IKAcjwKOST/n+ANOY6vVEoYkUi0fqcEEWlGBPfc1GE4IJrTrjL2a+apBi1aMIaogUCpzqi
	t8xGT5fwdbUDFqDg==
To: Wander Lairson Costa <wander@redhat.com>, Steven Rostedt
 <rostedt@goodmis.org>, Gabriele Monaco <gmonaco@redhat.com>, Wander
 Lairson Costa <wander@redhat.com>, open list
 <linux-kernel@vger.kernel.org>, "open list:RUNTIME VERIFICATION (RV)"
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/26] rv/rvgen: replace __len__() calls with len()
In-Reply-To: <20260119205601.105821-5-wander@redhat.com>
References: <20260119205601.105821-1-wander@redhat.com>
 <20260119205601.105821-5-wander@redhat.com>
Date: Thu, 22 Jan 2026 15:46:46 +0100
Message-ID: <87ecnhso15.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Wander Lairson Costa <wander@redhat.com> writes:
> Replace all direct calls to the __len__() dunder method with the
> idiomatic len() built-in function across the rvgen codebase. This
> change eliminates a Python anti-pattern where dunder methods are
> called directly instead of using their corresponding built-in
> functions.
>
> The changes affect nine instances across two files. In automata.py,
> the empty string check is further improved by using truthiness
> testing instead of explicit length comparison. In dot2c.py, all
> length checks in the get_minimun_type, __get_max_strlen_of_states,
> and get_aut_init_function methods now use the standard len()
> function. Additionally, spacing around keyword arguments has been
> corrected to follow PEP 8 guidelines.
>
> Direct calls to dunder methods like __len__() are discouraged in
> Python because they bypass the language's abstraction layer and
> reduce code readability. Using len() provides the same functionality
> while adhering to Python community standards and making the code more
> familiar to Python developers.
>
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
