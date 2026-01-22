Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4668634FF55;
	Thu, 22 Jan 2026 14:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769093021; cv=none; b=AGeRPznjjVUErYfwwUuOqX3TCw/yciBInj48myFzNQz/jJfe+D2q098b85NZ/IvF/ffApkgxWwzY/Kyymn6gikWSvFSJ1tol2DM0VxiKXp11wYjMtLuZtgpCx1/ydxJcGFlPGU1KSs+Rur+I03/ok/FEjXHBHjXRv/TAyUtIB1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769093021; c=relaxed/simple;
	bh=1knOfDL4BgBzv0Fe2WoK8w6OQ7JZrvTtqwsF1kB2BrA=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GAuiCGCkG188K7R0x6AvqLcvVlDMy8vb66FWb4LAl0izWvYQv6rk1m7OFkOIHdxQL0NaY4VKWbF52ct2Ny2Lvz9RJy9CwfIfCRuyZUoHqACNuKGD1/RPApEeoJ/ekOHfZkFXGXiABH/Ukz/oVpDPGb689POOOaKhmkbHwBpGtYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HUfVSIVA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f++KMlZz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HUfVSIVA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f++KMlZz"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769093017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1knOfDL4BgBzv0Fe2WoK8w6OQ7JZrvTtqwsF1kB2BrA=;
	b=HUfVSIVAZQurc8GUU5O/bCHVQOkRJOqmCgUYzRE0kEfUnEXqCGJYv+mdJn59NEvj5uS9CW
	fXdBuyQACEy7p++duMxnBZS+XDGS+98p/kRJfiARWhVY9C/r9/rwVHWnzGI1bCYXhep4mU
	M3he9bk4qKayLzvLlf+Pv1auU4xAZ7X+rybAAbl/LvFGvDs3HYW90bVaC6hUs+KU66Fqs0
	O1J8moig+5Rmw8KENhBVxULU9YKL7N+9aJpMtEjuPDtsivj5RzWhMVD8N7xuWTHm1LzhQn
	vqXKYdttT4Cj2qbkxzsTEHBn6tN5Xa/CPnrrY7oBTftjI00mBXP4HoKzsG0DMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769093017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1knOfDL4BgBzv0Fe2WoK8w6OQ7JZrvTtqwsF1kB2BrA=;
	b=f++KMlZzQuv/FgXVPP88l2dp+LyBk76TRq2ZbWJo4r1HdMXDGycc6i3qH8FcZ2cbRHt/f8
	q53JREoA0g78ijDA==
To: Wander Lairson Costa <wander@redhat.com>, Steven Rostedt
 <rostedt@goodmis.org>, Gabriele Monaco <gmonaco@redhat.com>, Wander
 Lairson Costa <wander@redhat.com>, open list
 <linux-kernel@vger.kernel.org>, "open list:RUNTIME VERIFICATION (RV)"
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/26] rv/rvgen: remove bare except clauses in generator
In-Reply-To: <20260119205601.105821-3-wander@redhat.com>
References: <20260119205601.105821-1-wander@redhat.com>
 <20260119205601.105821-3-wander@redhat.com>
Date: Thu, 22 Jan 2026 15:43:36 +0100
Message-ID: <87jyx9so6f.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Wander Lairson Costa <wander@redhat.com> writes:
> Remove bare except clauses from the generator module that were
> catching all exceptions including KeyboardInterrupt and SystemExit.
> This follows the same exception handling improvements made in the
> previous AutomataError commit and addresses PEP 8 violations.
>
> The bare except clause in __create_directory was silently catching
> and ignoring all errors after printing a message, which could mask
> serious issues. For __write_file, the bare except created a critical
> bug where the file variable could remain undefined if open() failed,
> causing a NameError when attempting to write to or close the file.
>
> These methods now let OSError propagate naturally, allowing callers
> to handle file system errors appropriately. This provides clearer
> error reporting and allows Python's exception handling to show
> complete stack traces with proper error types and locations.
>
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
