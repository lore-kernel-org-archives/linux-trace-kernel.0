Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C3F33F8BC;
	Tue, 21 Apr 2026 19:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776801418; cv=none; b=oqs9Lg758ZBOGaPq3+9Ns1aYeYB4drxw7FIKG8/nyRk/6JokR9pGkcl5/S8LxlYVVlFqvpAVBI2vhBMTYyahczpHUc8m00Oz8S7OJDEWUDFOQlCo6/VdBHbj3HQgyaVFygASoRpHNRGy1u1kuko7uGCOxx0b+/fI//SkLlqi0aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776801418; c=relaxed/simple;
	bh=niCvdpm0wIZP8xZOBBO1+jv6evBcb0YQHPiyck+Lfmc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SnDyL1JnwyvfTgRS39t2cZoyrmkZX3Yl77mdYY6xCzMiBtY2ndU7VHilpy2yzZhRxTaXmgU3/VMH+tLh09DFaEanyWlN7dWLC1Zyvf5yzLPJcrOWsJOxZQaXjFcACpoP8u6mL0KH4+RoRbSx5xEGVk1xQYEUH+zkgBkRJpP6erE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id E4C681A0D32;
	Tue, 21 Apr 2026 19:56:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id D5E6E32;
	Tue, 21 Apr 2026 19:56:52 +0000 (UTC)
Date: Tue, 21 Apr 2026 15:56:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, torvalds@linux-foundation.org, Arnd Bergmann
 <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel: trace: do not generate undefsyms_base.c
Message-ID: <20260421155647.328a3ece@gandalf.local.home>
In-Reply-To: <CABgObfam470W_Cq-jFHXc7H=xkr4CRMOGrbuLd-HtkepvwA3AQ@mail.gmail.com>
References: <20260421100455.324333-1-pbonzini@redhat.com>
	<20260421100209.7535e26f@gandalf.local.home>
	<86ik9k1jqs.wl-maz@kernel.org>
	<CABgObfam470W_Cq-jFHXc7H=xkr4CRMOGrbuLd-HtkepvwA3AQ@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: hegu7z8n7ikj3xmhmo683hs41zgtzbtx
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: D5E6E32
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18wC/StXPrugJH+/7DwLdkoiVbXk504UAc=
X-HE-Tag: 1776801412-919911
X-HE-Meta: U2FsdGVkX1/ADf7IUcOjthzU1uO5cLrwCa5AQnUqtxi0W0jihlpfCCHWo3Wm2VAhMzk/UZv2v0xe0VWc8fcExLV1QfgDB5giGCQVFntmor07F7dwA7Pit1MlfhmaWaUs3awSCnECMm9MA/VMTJPBn//CuUSowAnxEbA1Nv6lmzw8SqAVwhT5/vkwH7L5QS8RT6FR7deO/UMkooq70lfHkWYjqn/dvwdsjMbeb94vRllnhUeaijWv7DAoET01o02rZWYvoV+bLBXdjpN9pF9SQ7qRR6c4vOp+WIVYmxF9Z0SycHY1KI89XOTTddl7qim7goXOOUTaU0dKQsgdVD3HisyW91jQsfDuCZEwUlNy6OptAf3NpO8d9Uh1qmq3jNOf4IQ7q7D2TzBawC0ynS7MbWMTmKc6fhandXv4j6v/IK4=

On Tue, 21 Apr 2026 15:21:19 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On Tue, Apr 21, 2026 at 3:18=E2=80=AFPM Marc Zyngier <maz@kernel.org> wro=
te:
> > On Tue, 21 Apr 2026 15:02:09 +0100, Steven Rostedt <rostedt@goodmis.org=
> wrote: =20
> > > Marc beat you to it by a few minutes ;-)
> > >
> > >   https://lore.kernel.org/all/20260421095446.2951646-1-maz@kernel.org/
> > >
> > > Although he didn't Cc linux-trace-kernel@vger.kernel.org :-p
> > >
> > > But anyway, it ended up in my internal Patchwork. I'll take his as th=
ey are
> > > both pretty much the same patch. =20
> >
> > On the other hand, Paolo's patch has the SPDX tag on the new file,
> > which I forgot to add. Your call, anyway. =20

Ah, OK. I'll take Paolo's.

>=20
> Yeah if you want to get the best of both worlds, take the commit
> message from Marc's and the code from mine; he has more complete
> trailers whereas I have slightly cleaner formatting and more comments.
> But otherwise it's not a big deal.

I'll update the subject and change log slightly, but otherwise, it's your
patch.

-- Steve

