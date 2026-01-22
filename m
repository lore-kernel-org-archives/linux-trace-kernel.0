Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AC23904EA;
	Thu, 22 Jan 2026 15:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769095876; cv=none; b=PgTq4ANjG0/0HcOe5VH/Ss7JLDdVRRnNU/aoRgzF6eHktDH4RwETeh6hZPp79nWpEQqxIs+gxK7ERTHBcViWdKCuB8pTYnLy9nDJ2KVkGF327vXMHp1eiKZYjAIyGpwAEwky5++2b7W9cHgraFqWwXG2K/hu5B1MMvztsBnlvq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769095876; c=relaxed/simple;
	bh=puESBhdhhwbIfUgoAjfBLvqVUvOFQ21fLWnTkElEf0E=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AEN7+gRAM2T9j2W2Y/hv7RGCm7jbNYspd4YhtpFKOnh49fAvW/UXJQESbu+mmHPTCZnmda0d40Zq1hEAB23NL+IHIlF4Ui/5EFRvf36Hp8aoa42WGInf9NOSNZObLT1OBzn8cNsl9mynzVgcU1+Tz04/3W7zvFjSyx2Jzb7demA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iwTUgD8u; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PFm1WMOS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iwTUgD8u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PFm1WMOS"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769095871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=puESBhdhhwbIfUgoAjfBLvqVUvOFQ21fLWnTkElEf0E=;
	b=iwTUgD8us6Heatbn2xbXxG84IVaYz84KLVOWjNxgMW3wJ5IcS5bH245Y5MxIMyMoN5GuWM
	OZVu2iZsqzsO+ao8dV6o/eENeFnc7tMdFjTc7lmIWdRjxVoHLS4DhnzWv2c1SLeMtCTwvB
	iKmz9i9St/2A0FKc5rLG3e4Wiw9qzzT3N4Zon9agPcmbspK3wdQ7sXYy6NxK+/VOT2t7SS
	a9IZ9Zd4w9zTioDQBYsf0SAG1Wj2kyCYgN39kNKj20mMSOlvO4JsrG9H7FsR2a/e90Gjs/
	cu+z+kWbPH/OS7IZ7ylCASo9/Q6tVkL10pDz2PhJnyTQNs6rdfwUfGkek+ZGBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769095871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=puESBhdhhwbIfUgoAjfBLvqVUvOFQ21fLWnTkElEf0E=;
	b=PFm1WMOS8qd5TyYpjP/YJ3cXDycDv4NvgsIspXuAUPCjPhBaaaptjLQoub21sNETxA1Tgn
	qlSDJMq5cKpk2GAA==
To: Wander Lairson Costa <wander@redhat.com>, Steven Rostedt
 <rostedt@goodmis.org>, Gabriele Monaco <gmonaco@redhat.com>, Wander
 Lairson Costa <wander@redhat.com>, open list
 <linux-kernel@vger.kernel.org>, "open list:RUNTIME VERIFICATION (RV)"
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 17/26] rv/rvgen: fix possibly unbound variable in ltl2k
In-Reply-To: <20260119205601.105821-18-wander@redhat.com>
References: <20260119205601.105821-1-wander@redhat.com>
 <20260119205601.105821-18-wander@redhat.com>
Date: Thu, 22 Jan 2026 16:31:10 +0100
Message-ID: <87bjilis01.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Wander Lairson Costa <wander@redhat.com> writes:

> Initialize loop variable `i` before the for loop in abbreviate_atoms
> function to fix pyright static type checker error. The previous code
> left `i` potentially unbound in edge cases where the range could be
> empty, though this would not occur in practice since the loop always
> executes at least once with the given range parameters.
>
> The initialization to zero ensures that `i` has a defined value before
> entering the loop scope, satisfying static analysis requirements
> while preserving the existing logic. The for loop immediately assigns
> i to the first value from the range, so the initialization value is
> never actually used in normal execution paths.
>
> This change resolves the pyright reportPossiblyUnbound error without
> altering the function's behavior or performance characteristics.
>
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>

I understand this is just to suppress a false warning, not fixing real
problem.

Reviewed-by: Nam Cao <namcao@linutronix.de>
