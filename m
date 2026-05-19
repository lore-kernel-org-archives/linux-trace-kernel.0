Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2126831B824;
	Tue, 19 May 2026 14:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779202317; cv=none; b=FOdGFUO8IhSQjVHq4w6yxlJB/h/Gu+rD7rAczCEcz/qCfF7+ZJTdZVPe2mAS64aYRNUA4iBX5+uR2jukSG2vu/5zEj+g7FmFwqpLnzTpGLdUlQpqtOA6Q52pcd14X/CJ+UHSQ0omEla9X5LYGfigW8jkxY81UyXzXpOPNeeJCVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779202317; c=relaxed/simple;
	bh=5uOCjv3XL2+gGMOET/+YNfHidpQIdcDHrukuPi91850=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ogNvx+hYvVylRV1CeVws5YK8Vk5RJxoNHGz4020T2wmoUySwBH82XqCZBmGv4H+uJZJ5CjtQzUl/GhBxc9OzNdAnkzp7CuekwcV/qedhdYlXZShMfZgu0NpduL2eptADi0uhwK9Hodbg+2zOfZtJ60kRqWH5b+bo1okZiPnSSa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lapsrqat; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S6wWy4B3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lapsrqat";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S6wWy4B3"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779202314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qiNKad46M4VL2dK7id+ENRkHhuZKkBX03MbvcbZ1ZIY=;
	b=lapsrqatXPqIOcg0D6OJHKxpTIzYu0ovAqacs5tQ4Pzm0redqd1khzg4yLGDPxDGbf64WQ
	YseCt3moYhUOyCm7S3zq7KA79K9DZEaDvQz3Jo2Rhn4+8QQQyDIRA0zDlfS0KOfTwSZR1V
	fUwqCMj4yRmMWinFMI5qu5kzboTq//YqnpOhcALsaSfv0fklBNcJ5juZGHHx7GTvtvNg57
	ikOb1BivC4cHhu8yRyDSTQtN5dymrC+ipD1va6U2uo4bkcnWTswBZ+9Hb3lj+0EBzvSXds
	qhD6xnDRn2TxtnLhFS7v54pe8Is428LeLD5AEr9KG1Ytky0NvP/I7M7kcS+YGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779202314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qiNKad46M4VL2dK7id+ENRkHhuZKkBX03MbvcbZ1ZIY=;
	b=S6wWy4B3PhBPMmzOXuxNLbJl3Jy2UFqQzWQKVtlTLgJP+Pk43kcNwp1IxF7BtG5yYF3Ac0
	UVAERfJMuNJTEgCg==
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] rv/rtapp/sleep: Update nanosleep rule
In-Reply-To: <5af6afbfa32ede2db7f21412c8c21831f0eefd04.camel@redhat.com>
References: <cover.1779176466.git.namcao@linutronix.de>
 <a2175a6647bb88797ad8275eddb4b20b749474ec.1779176466.git.namcao@linutronix.de>
 <5af6afbfa32ede2db7f21412c8c21831f0eefd04.camel@redhat.com>
Date: Tue, 19 May 2026 16:51:54 +0200
Message-ID: <874ik34flh.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:

> On Tue, 2026-05-19 at 09:49 +0200, Nam Cao wrote:
>> CLOCK_REALTIME is the only clock that often is misused in real-time
>> applications. The other clocks either are safe for real-time uses
>> (CLOCK_TAI, CLOCK_MONOTONIC, CLOCK_BOOTTIME) or are unlikely to be misused
>> (CLOCK_AUX, CLOCK_PROCESS_CPUTIME_ID).
>> 
>> The rtapp monitor's purpose is warning people about common mistakes with
>> real-time design. However, warning about all clock types generates too much
>> false positives.
>
> I'm fine with the change, but are those really false positives?
>
> From what I understand before this change we would report any non-rt-friendly
> clock type, now only realtime.
> What we are skipping would still be true positives, just so uncommon not to
> justify the extra complexity, right?
>
> Or do you mean an RT task using CLOCK_AUX is a false positive because likely the
> users weren't even trying to do real-time?

CLOCK_BOOTTIME is fine for RT.

CLOCK_AUX is created for real-time use cases, so the monitor shouldn't
warn about it. But this clock can also be arbitrarily set, which can be
unsafe (e.g. you want to deploy the air bag in 10us, but someone changes
the clock and you have to wait 10s).

We probably can detect if a clock used by an RT task is set, but I am
not sure how complicated that is, if even possible. For now we are
assuming that user won't do such thing, then CLOCK_AUX is fine for RT
uses.

CLOCK_PROCESS_CPUTIME_ID is a strange one and shouldn't be used for
real-time. But I think it's obvious from the description that you cannot
do real-time with that.

Only CLOCK_REALTIME is a mistake people often make, probably has
something to do with the deceptive name.

Nam
