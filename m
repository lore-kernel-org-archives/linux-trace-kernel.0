Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C268E37F8D2;
	Mon, 25 May 2026 11:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779709506; cv=none; b=trtzVjqdKml2j1trgnj1UvtyFsQufnX1CX8snNabs4N8THeQb3vb2P6zr7RJi3G/mfTRz/KItQrXwj1yDdoNec4XgQlNt4E+TvDmvgSVvpWij0OXwuRXtuKYKa4kTVNASRZXJUpGuHgRanCAUlnilV2YQfZiuwriwD7+KZ42leg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779709506; c=relaxed/simple;
	bh=Fy+o+yFUkbYxuybP+y3xpdokqB/aTnvfTfvsE4KQGxw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G/1f7yramM5XrVp7MHz8yu0vnLl9FMpGMandpLDZoR1eHjJo2w+FLp5z/Rjnh1fmykismWI6x79bgR2n+mWYI7fQ2lpxVAL3vetu+qQ9zuA52dJxTCkI5G2Cs5Z8qqk6otGq7zJReVlPS9fo4jAeRTtn97T2ZV4VCOzCOfZet9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SwkUNsmx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2Xf5QmIY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SwkUNsmx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2Xf5QmIY"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779709503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3MYfEbS6aF+Gqfmw7JpimO+7hAE3piMO9mTD7g9tv+s=;
	b=SwkUNsmxBwfuC7r01tGM3wYoAqwq8ZEEikuUgfA3FLb+JmSNGO28B/5al2oiJspa51L6Pn
	Apk8sSezb/cZ2DNd58C8a2cYB8a7bn7+taxGNegBbqhLxR3PqoGK3gf9Xil10q0ZbKe9w6
	g9IXPQWukulQI2pRpzQdjUDiBz6DRZrXAIrXBebf5+3PqtC+v+QDMtEbaUNgEqXIkMlX+y
	GG1/RYSbLjXgixErS66idn/GBWZQzA+9V2TnTGfVAnPHWK4J5pHtVAWKclIG11+0PnCcFO
	9LAWjNKwOzXauXG3esafpSUAHUTl5PUqU0c6Rtt7ll/rUq0ebZUZuC0SFAIAyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779709503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3MYfEbS6aF+Gqfmw7JpimO+7hAE3piMO9mTD7g9tv+s=;
	b=2Xf5QmIYlIt+7OP7TuqPe+UF3urKESXnYkXgSVfWPNF2dv1+qJgOqMCynl1pjUsB887pGk
	/ZyLYDckFZU843BA==
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] rv/rtapp: Add wakeup monitor
In-Reply-To: <fb0c1a36b4e773c65591bde2ef31c48711d30163.camel@redhat.com>
References: <cover.1779176466.git.namcao@linutronix.de>
 <bf775af281cb1540d51ac9a8531b45e723d73226.1779176466.git.namcao@linutronix.de>
 <fb0c1a36b4e773c65591bde2ef31c48711d30163.camel@redhat.com>
Date: Mon, 25 May 2026 13:45:02 +0200
Message-ID: <87se7fiugx.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Gabriele Monaco <gmonaco@redhat.com> writes:
> Looks neat, so the idea here is that we are looking at the same events
> sleep would react for, just from a different perspective, so it does
> make sense to run them both together.
>
> You may want to set
>
>   depends on RV_PER_TASK_MONITORS >=3D 3
>
> in rtapp/Kconfig. Though if we plan to add more per-task monitors we may
> need to find a better solution.

Yeah, perhaps some sort of list instead of the current fixed-length array.

>> diff --git a/tools/verification/models/rtapp/wakeup.ltl
>> b/tools/verification/models/rtapp/wakeup.ltl
>> new file mode 100644
>> index 000000000000..a5d63ca0811a
>> --- /dev/null
>> +++ b/tools/verification/models/rtapp/wakeup.ltl
>> @@ -0,0 +1,5 @@
>> +RULE =3D always (((RT and USER_THREAD) imply
>> +		(not (WOKEN_BY_LOWER_PRIO or WOKEN_BY_SOFTIRQ)) or
>> ALLOWLIST))
>> +
>> +ALLOWLIST =3D BLOCK_ON_RT_MUTEX
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 or FUTEX_LOCK_PI
>
> So here the events and atoms are similar to the ones in sleep, but since
> we fail on the waking event, we are going to see it from the perspective
> of the waker task, right?
>
> But are those really equivalent? Why do we do RT and USER_THREAD here
> while there is a much more nuanced set of conditions in sleep?
>
> If I understand it correctly, sleep can monitor some kernel threads but
> this monitor does not, is there a reason for that? Are we just not
> interested in the waker for kernel threads?

Urgh, initially I had a patch which drops kernel threads in the sleep
monitor, but finally I decided to drop that patch. This is the leftover
of that.

You are right that we should be consistent and consider kernel threads
here as well.

> I'm not sure if there is any better terminology, but "waking" task makes
> me think of the task that is about to be woken, though it can mean also
> that task that is waking another (what you probably mean here).
>
> What about using the waker/wakee terminology?

waker/wakee would be clearer.

> I see the kernel (events/sched.h) uses waking as well, but it says
> waking context (which a bit clearer to me than waking task).
> May be worth running it through an LLM which can produce more
> English-native unambiguous wording, or maybe I'm just flipping..
>
> Also please document it in Documentation/trace/rv/monitor_rtapp.rst

Right, thanks for the reminder.

Nam
