Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0908320E03F;
	Tue, 14 Oct 2025 14:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760451502; cv=none; b=PzX4y/RVGQqPWRGAmgAUIiXuhFDw50qq1VQCiuZ18x3kr6zmk3ikqYxlLipi8n5p1TR8+ZXqi/1z4SiE3Tun/5aNk3sDSAwkVEc+vDpE53FEzi3fSjDb8Fb/CNRyoWLOj+iEySa2zs35T67SvxbiRlLBu0ByA7ES5FZRv2S2COw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760451502; c=relaxed/simple;
	bh=5snj9My2QSM0dtiT56JIRYIy8ffkHfAfbWRs7lYjNoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZOB5XfKQHeWBIEW9Okp6d18EnKI+UyPqRguEQLhHGhlge/VmWZDASaolLuYvcH3jh6H3XaGX+2Gqu0YMWWEesynczpcFMYJ3fJVtPwbQLUb4kTVivyN55owxNVAf9/LP0+fMCzV6uXmtwn/f5KOqJNqNoBo5XKw9DnIdAAj5hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h0mNarJ3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WyzEPo7O; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h0mNarJ3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WyzEPo7O"
Date: Tue, 14 Oct 2025 16:18:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760451498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3OCZOYOLjihIB8UBgGUQzEYdAZdMGmP3BT+nzfdgAkQ=;
	b=h0mNarJ3RAeeYcbytkzDKBYFORbfcHqbKK5CSbijo1jPVWWfdSVNhToMjN8pb4oGldFa52
	BMb2wcOPvNKrBl3fTmA7PfiU/xY5gVj6FACmN2pu6LyJlfrgcNxGYFaynvmJZ6tXa7/T8d
	aA3AAB4A/Janhp/yZ9gz3XLDozFqo6eSHYCl2jgAt9IN6o19d1h508bzwS8Rq3JD0MppKw
	xtYrjReBKPk6lACDt4e+7tSMn+nOR448mtlIqXIqOOd8rwVPLZNBamr1iZa/bi8rGAMHvH
	HNFqMIS9Q4SiEdvg02IlhOIHK9c2wyhASdu6AZkr5wiaeW0H/jENuzJVBfbDGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760451498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3OCZOYOLjihIB8UBgGUQzEYdAZdMGmP3BT+nzfdgAkQ=;
	b=WyzEPo7OusZqludNOfuhXueH09Ov5UkCCMtFFcS6LXtlJihzWVyU95d3MVIWseADtDQogO
	5XqCTtkJtvxvlQCw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] rv: Add explicit lockdep context for reactors
Message-ID: <20251014160719-f5a075fa-7cdf-4367-8551-05cf7715a3e7@linutronix.de>
References: <20251014-rv-lockdep-v1-0-0b9e51919ea8@linutronix.de>
 <20251014-rv-lockdep-v1-3-0b9e51919ea8@linutronix.de>
 <87qzv6szku.fsf@yellow.woof>
 <20251014094206-80eb5d6c-e4dd-4704-a40a-e2d0461c2185@linutronix.de>
 <4d0467cf03f4b818a40344b6ec8142582c26a876.camel@redhat.com>
 <20251014140813-692b312f-67d8-4f11-99f9-73d5d8d34c87@linutronix.de>
 <ef1503b097e6113cec24f2c20684635fe1337260.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef1503b097e6113cec24f2c20684635fe1337260.camel@redhat.com>

On Tue, Oct 14, 2025 at 03:45:39PM +0200, Gabriele Monaco wrote:
> On Tue, 2025-10-14 at 14:51 +0200, Thomas Weißschuh wrote:
> > I can't follow here. lockdep can indicate problems, but it should not
> > introduce
> > problems on its own. So preventing the usage together with lockdep would be
> > the
> > proverbial head in the sand. If the tracepoints called by lockdep are an issue
> > then we would just not call into lockdep in the first place. lockdep
> > triggering
> > these tracepoints should not be an issue in practice. I don't see a
> > bulletproof
> > way to prevent a tracepoint handler from calling another tracepoint, except
> > maybe extending lockdep to also track that.
> 
> Forget about it, you're right. This leads to not using lockdep inside reactors
> in the first place. We could even have notrace versions of the lockdep calls
> (I'm not sure lockdep itself needs them), but that's getting horrid.

I still don't understand why the tracepoints called from lockdep are worse then
the ones called from the reactors themselves? Any solution should also apply to
those. Especially as even the simplest printk reactor runs into the same issue.

> Leaving for a moment concurrency quirks aside, a monitor that is reacting should
> be done for a while and can be marked as not monitoring before reacting, instead
> of after.
> Trace handlers triggered in the same tracepoints should, in principle, be able
> to tell they are not supposed to run. This at least stands for DA monitors, but
> the same idea could work on LTL as well.
> 
> Of course this gets more complicated in practice, but perhaps suspending
> monitors during reaction can be enough to allow these lockdep calls without
> risking infinite loops.

What would it mean to suspend a monitor? In my opinion we shouldn't sacrifice
the accuracy of the monitors or the reliability of the reactors while trying to
mitigate a theoretical problem.


Thomas
