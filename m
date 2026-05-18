Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404953D5656;
	Mon, 18 May 2026 08:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779094331; cv=none; b=MQ00fek9Gg7Z0CnRcl0GNgGa6wPGyGO5BTr87oUf9c7YxLqWQIfxDtoC49YlAbz8cyxdDX0jchep9SNTVEDg7XLQM+HDKD7VH/0rpofb1W1EOFgchB6KO37tsEWsWNIctfDVu34Zqqd5FoaP1pa8eJhZMDjwTuQbPk2DhN+Ynew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779094331; c=relaxed/simple;
	bh=tXPJNrOfsyZakLMY4F7fepRS3COxXKoji+7TvoEpI8k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SpOEr3ObQJhwZLZcPaplFIPnwDNlGULI7kVa5jLI0r10IOnZADNOcjXeBQ6xgaIO6vKrxQ/gEN0qF6pTdGQqR2Y/ImcH8/sbLkWkBLllfjIZKOYRORaK8ixhfRkyqaftvDJUyCLoQGcCWrhTdjxENAGIXuebXGd44CT2JS5p/m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PUI9T8rV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FaQc3Q3j; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PUI9T8rV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FaQc3Q3j"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779094328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tXPJNrOfsyZakLMY4F7fepRS3COxXKoji+7TvoEpI8k=;
	b=PUI9T8rVh76ZYBC6tYPA3oRgB82OI3qe8I/Mdk+S+7prz943K1ACmSMrjSQmGoYcN/0j3W
	iIzKyxaEUKg61Yhw9ut/adziCFO+FfbZOkvhPpdDljLYx+gzvpkFGERDIKcPk+9gY4vIWg
	14EuzYmWLAhLkLmFchIiEPEkGUh+frMqnKUlmGvU57BZaF2XvFOChL3gPvYxtmhi6jpdXg
	MYtX2I1WowGgkJ9HT3A0D9KgOCBEdzKc6UZGgq8FELjsqoXNevp3JNEQPBeTMfCfpXwK3j
	KVqSj0YlHl8TeIIV+biDPYFjxDvqcxGwZJVESSYb7PuHPEr6E5Ag+0TPA3TeSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779094328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tXPJNrOfsyZakLMY4F7fepRS3COxXKoji+7TvoEpI8k=;
	b=FaQc3Q3jftIymwXnP5kyIPFSxrmVMmzU2kcXj3P1R2ZDBdA3KnRN5KNXW5JYuFNPRjN88B
	lY6+CeH0OIOnWcBg==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Gabriele Monaco <gmonaco@redhat.com>
Cc: Thomas Weissschuh <thomas.weissschuh@linutronix.de>, Tomas Glozar
 <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>, Wen Yang
 <wen.yang@linux.dev>
Subject: Re: [PATCH v2 07/14] verification/rvgen: Fix ltl2k writing True as
 a literal
In-Reply-To: <20260514152055.229162-8-gmonaco@redhat.com>
References: <20260514152055.229162-1-gmonaco@redhat.com>
 <20260514152055.229162-8-gmonaco@redhat.com>
Date: Mon, 18 May 2026 10:52:08 +0200
Message-ID: <87se7p6qx3.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> The rvgen parser for LTL stores literal true values in the python
> representation (capitalised True), this doesn't build in C.
> The Literal class should already handle this case but ASTNode skips its
> strigification method and converts the value (true/false) directly.
>
> Fix by delegating ASTNode stringification to the Literal and Variable
> classes instead of bypassing them.
>
> Fixes: 97ffa4ce6ab32 ("verification/rvgen: Add support for linear temporal logic")
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
