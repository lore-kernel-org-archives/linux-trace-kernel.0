Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F1631815E;
	Wed, 15 Oct 2025 10:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760522887; cv=none; b=BEBrgFiwOiNsCg1obH4b+NQnOSXb2eOosAsKoDW9EoaQ0Ywi54Lys82SKIDx4Z1wKDIh73BqQ+voZIE/Lmjk0u1yAbJ2VHsY98yPIjXld0JBYu56Nfncxl12wxoG+3XuioLlTKzE+H8R4O/jYl5OgSou7IXF+acWv0+x0nvZJHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760522887; c=relaxed/simple;
	bh=tX6dRWPtnSFDvBJeGpVATS0oadDPcur/wTBZZ/4DhfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJc4W5C53ZzEyq2iu5cTi/GxEEykE4fp8tL299z/EyhIrAtl2vccBXNdmKjaeNFN/lgghF+yNGbI7C/uCkE9+nMcRk/fK02MS3AoiVmx3MKRYD9nGq3HJznWa7Zds93DgXdhuoRUldn2DxN3LbvrzNNzUI9wmsOMsq7o4fmvwGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fTBpvPOI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sqvU9ZSB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fTBpvPOI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sqvU9ZSB"
Date: Wed, 15 Oct 2025 12:07:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760522877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p+olsH6Bix+Xu/kjcbtzJkLw5J+oNjtziXup8TlzvXM=;
	b=fTBpvPOIi0p0eWg6RlD6AUm4kNQKd4KWfjspEYDpsxq0ImqM1vSnNBBZiZKOcZMSrxQ5gb
	0DYmtH4FEM6iExQho9pp/SkgizWFXqVROF5NMIu0aqvOdHziOC94UwZssmDnVj+mV7Zo7L
	yeS12y81kGHt33Xhsf0Qv/f44SxbFg4QYdB/ce5ZgVL+cx75smlCyG5S1oaKlL0BwgAzuk
	V2aGOZamFRI1zw16AWyNDG1aWpkicicrPUIYHpix2T55HQ9/bLVjpx2EO6hJdfKonWeN9H
	77caL6k9GxqTrfOyjKwFIHFu1qKEy19eXLXUyzgG83DfwXeQAJBQR2fBeenGQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760522877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p+olsH6Bix+Xu/kjcbtzJkLw5J+oNjtziXup8TlzvXM=;
	b=sqvU9ZSBMM96C4GJC3LDWzK5toeE4fkewMZzfiqacGKGcwazyl/6++NHPO2AtEzOCYF5Q9
	V1uyFpA+hPtyjTDw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] rv: Add explicit lockdep context for reactors
Message-ID: <20251015115714-e8e69ed8-a5e4-4139-8d6d-7f2487674e68@linutronix.de>
References: <20251014-rv-lockdep-v1-0-0b9e51919ea8@linutronix.de>
 <20251014-rv-lockdep-v1-3-0b9e51919ea8@linutronix.de>
 <87qzv6szku.fsf@yellow.woof>
 <20251014094206-80eb5d6c-e4dd-4704-a40a-e2d0461c2185@linutronix.de>
 <4d0467cf03f4b818a40344b6ec8142582c26a876.camel@redhat.com>
 <20251014140813-692b312f-67d8-4f11-99f9-73d5d8d34c87@linutronix.de>
 <ef1503b097e6113cec24f2c20684635fe1337260.camel@redhat.com>
 <20251014160719-f5a075fa-7cdf-4367-8551-05cf7715a3e7@linutronix.de>
 <1014118845296ead20fc1f8ae64c4fa610d06bc0.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1014118845296ead20fc1f8ae64c4fa610d06bc0.camel@redhat.com>

On Tue, Oct 14, 2025 at 04:50:18PM +0200, Gabriele Monaco wrote:
> On Tue, 2025-10-14 at 16:18 +0200, Thomas Weißschuh wrote:
> > On Tue, Oct 14, 2025 at 03:45:39PM +0200, Gabriele Monaco wrote:
> > > On Tue, 2025-10-14 at 14:51 +0200, Thomas Weißschuh wrote:

(...)

> > > Leaving for a moment concurrency quirks aside, a monitor that is reacting
> > > should be done for a while and can be marked as not monitoring before
> > > reacting, instead of after.
> > > Trace handlers triggered in the same tracepoints should, in principle, be
> > > able to tell they are not supposed to run. This at least stands for DA
> > > monitors, but the same idea could work on LTL as well.
> > > 
> > > Of course this gets more complicated in practice, but perhaps suspending
> > > monitors during reaction can be enough to allow these lockdep calls without
> > > risking infinite loops.
> > 
> > What would it mean to suspend a monitor? In my opinion we shouldn't sacrifice
> > the accuracy of the monitors or the reliability of the reactors while trying
> > to mitigate a theoretical problem.
> 
> I don't mean to really sacrifice accuracy, DA monitors are disabled after a
> reaction. This comes from the assumption that the model becomes invalid, so
> whatever comes after might be meaningless. Monitors restart as soon as we are
> sure we reached the initial state.
> In this case, it already doesn't make sense to monitor events triggered by
> reactors.
>
> LTL is a bit more complex, so it might make sense to continue monitoring just
> after a reaction, but I'm not sure how useful that is.

Ack.

It is still possible to manually re-enable all monitors through sysfs, correct?
That is needed for the kind of testing I have in mind.

Do we still consider these hypothetical tracepoint loops a blocker for this
patch series? In my opinion the usage of lockdep does not exacerbate the risk.


Thomas
