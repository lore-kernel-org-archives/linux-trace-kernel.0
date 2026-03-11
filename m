Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0663829B8E8;
	Wed, 11 Mar 2026 17:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773248863; cv=none; b=kZssC0xYI/VWmXfFgZNCzzEuIU9AKHjlgJT/ahw0QkGhqjL55eI54h/TbEE6U3FXXAxt2o72dTJ2M5QRbx5teFnTnAmdEkoUrEtrGjjBaNB/S7H99dBW7y9J3gtrMUgYTLlXm6P3WYE7wUvXmJv9zNLakfNt0CNDVBtyeXMOj1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773248863; c=relaxed/simple;
	bh=UayDErFrqX+6bUGGNWuA+D1rTtSRVoiUK//SNTGbT0k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VpSw+pf7BW234pKlWsyBReswq0AQFC2Sp5pMmjpEybZGlLdRtzge5dQ89NPaUHfqSJcMv5ORSIut03p97IL0YSD6GF8X8Bm56C/3iHuhs6fTxoknPtPW0nPVsIUS760Ee1uDMQcwre2nTcaWcTr1BWYdT+z1yBITRTOelyRsyxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 231251402D8;
	Wed, 11 Mar 2026 17:07:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id A1FB420029;
	Wed, 11 Mar 2026 17:07:31 +0000 (UTC)
Date: Wed, 11 Mar 2026 13:07:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: David Laight <david.laight.linux@gmail.com>, Peter Zijlstra
 <peterz@infradead.org>, mingo@redhat.com, will@kernel.org,
 boqun@kernel.org, longman@redhat.com, mhiramat@kernel.org,
 mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/3] disable optimistic spinning for ftrace_lock
Message-ID: <20260311130743.63c997ec@gandalf.local.home>
In-Reply-To: <CALOAHbDqYjJngQmmOaPRA=k4Bb8Or39YNp5R98f_op4dti2_TQ@mail.gmail.com>
References: <20260311115250.78488-1-laoar.shao@gmail.com>
	<20260311115426.GN606826@noisy.programming.kicks-ass.net>
	<20260311125350.1d89341f@pumpkin>
	<CALOAHbDqYjJngQmmOaPRA=k4Bb8Or39YNp5R98f_op4dti2_TQ@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: 9mrf31qg4h7m9tqjxfegmm6binq5oqkf
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: A1FB420029
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19WKkTKK+uo8nAi1XnCns1EMZcOLvIB4nU=
X-HE-Tag: 1773248851-38586
X-HE-Meta: U2FsdGVkX1/oXpD0uOn+FTDSCn/L7v518E/xxP6bHysOBLN1UO/mdlK2jo/7e1t502juxHgmaXaeYQoj4BbzaBVgNcCftImxyM99vZicdzF0e46HUVQV1QfAW+eF1cfeGk5Mw2W+t4uNoZwYg7F60VlRq8fPzR2L6UIEBwskhtI0hf1KhLu0zYTjQyD8zKaQH3OgG+VdfVJgMwHrZmFXEopzNomqwsmYY2ptBPKDGlIfNEdWpGV1d6i9YpFIDAqgm0pdZRqySvs+SLsRuxBeOlyob5BarbhNKcUqvohDmqbv+Qtjw16DFz+6n7QI29o1uBzajZRY/mPBfF+wHLZXnzwLz/LFwT2h

On Wed, 11 Mar 2026 21:40:32 +0800
Yafang Shao <laoar.shao@gmail.com> wrote:

> > The code needs to drop the ftrace_lock across t_show. =20
>=20
> It's unclear whether we can safely release ftrace_lock within t_show =E2=
=80=94
> doing so would probably necessitate a major redesign of the current
> implementation.

The issue isn't t_show, it's the calls between t_start and t_next and
subsequent t_next calls, which needs to keep a consistent state. t_show
just happens to be called in between them.

>=20
> >
> > Although there is a bigger issue of why on earth the code is reading the
> > list of filter functions at all - never mind all the time. =20
>=20
> bpftrace reads the complete list of available functions into
> userspace, then performs matching against the target function to
> determine if it is traceable.

Could it parse it in smaller bits? That is, the lock is held only during an
individual read system call. If it reads the available_filter_functions
file via smaller buffers, it would not hold the lock for as long.

-- Steve

