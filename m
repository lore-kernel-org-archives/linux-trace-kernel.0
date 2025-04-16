Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31A7227EA1;
	Wed, 16 Apr 2025 04:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744778252; cv=none; b=L5rHpCRJBUme31jm73faCM2VTNJfwXXpCiP9KoN0pyUHg3ZXiAeI40kmRmNt9ppY8dBDNXYfpyhPOBl6pcJPO3LVkMUy8/i2xhXVdSYcYV6U57wxalI+15YkmYZuf2tP1354BVd6vFGJ4vysmX9/lZFWmA8Jj3PBzdCVs81RAJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744778252; c=relaxed/simple;
	bh=9bu6rBLd0HCxUqj1juKJjrh06FKEo5FKOQzLLdgqbIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2s3RYB3gIuwQz1cK6NCnSe39OzaglrnCgKEYRXC2N9MAK3Oyab6gImrnhM3dZr0gAdO9ITGefecx71nhDP6J6uyJIA2Tb/1iWnpV0g4/U5Wm3k4sSYVJaJCacYsTlqfBMdB8dloaGQJYINVnLBrKerc33XJ6SgCbfZNnKL2UE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1nhRqawg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FBFb7fEE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1nhRqawg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FBFb7fEE"
Date: Wed, 16 Apr 2025 06:37:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744778248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vWYHcx008rLBCCCBMeHvsvm8swmXbtCNA99TsGr+FoY=;
	b=1nhRqawgK1pJGI2edKh6iyMr0VfDgfUZYx6Nii8RE9Oo9HTL0UQdV5FuPEzyEf8WL5ltnD
	vq5ayjv6jNQGmazC1qpFav0mwtPGvNQfGvFS1HWwlWSLkmWXZ0zUQnrlQGIUkok61BNB7S
	HcXFsLANCgrf+bxhuC+ywlzCTvOZ6ljBb1AT2mol+fuoEEek9jupin2bTvl6xS+G6byoXU
	SCFszOOSFCijgk7T+K0MQNkCQcQGG9ABpTaRy0Nh37FXhj08eLecE/Rj/IU+MIWn88GPmU
	4rJu6nXC8AcTJNE9Jsy/AoF5VBIFKY8oCUpTVhpWeU5cnbIqTf4zOPuJMIzC6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744778248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vWYHcx008rLBCCCBMeHvsvm8swmXbtCNA99TsGr+FoY=;
	b=FBFb7fEEzwYMRGMdNa5nRKHAOjCOeWfqR1heoIq8OOoB38ca79hgXYCw9UrWcVLwVbwz45
	MnvIZBJeJUldUwAQ==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	john.ogness@linutronix.de
Subject: Re: [PATCH v2 21/22] rv: Add documentation for rtapp monitor
Message-ID: <20250416043727.4c1KgDrO@linutronix.de>
References: <cover.1744355018.git.namcao@linutronix.de>
 <9d5b01d8bdff50081d6ad17be0474c8c355aa139.1744355018.git.namcao@linutronix.de>
 <67d9e857fd4fbfe590c9472f1c74b6f22560d952.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67d9e857fd4fbfe590c9472f1c74b6f22560d952.camel@redhat.com>

On Tue, Apr 15, 2025 at 03:12:23PM +0200, Gabriele Monaco wrote:
> On Fri, 2025-04-11 at 09:37 +0200, Nam Cao wrote:
> > +  - `RT_SLEEP_WHITELIST`: to handle known false positives with
> > kernel tasks.
> 
> Is this what you call ALLOWLIST?

Yes. A colleague already poked me off-list about this error :(

> Just out of curiosity, normal kernel threads are not forced to follow a
> VALID_SLEEP_REASON but need RT_FRIENDLY_WAKE, how are tasks like RCU
> and migration not following this?

Because that's how RCU and migration works, they are intended to be woken
by anything.

It is also possible that people deliberately design their userspace
real-time threads to be woken by non-real-time threads. For example,
pipewire has a non-real-time thread waking a real-time thread to do some
non-critical work. That's still okayish from real-time perspective (but it
is better if the non-real-time thread just does the work itself).

This monitor's warning is not exactly a "here's a bug, fix it". But more
like "something seems really wrong here, please investigate". People can
decide whether this particular suspicious instance is acceptable for their
case.

The initial implementation of the monitor didn't have this allowlist. And
we had a bunch of warnings on the rcu_preempt and migration/ threads. We
decided that due to how rcu and migration works, these warnings are okay.

> The monitors are not designed for deadline tasks, any plan to extend to
> those too?

I haven't thought much about deadline tasks. But it could be extended by
changing "RT" into "RT or DL", if needed.

> Other than this, nice explanation and monitors, thanks.
> 
> Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

Thanks so much for the review!
Nam
