Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9E433F7;
	Thu,  1 May 2025 14:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746110568; cv=none; b=OqzmYwO51lHu4hAqlD8TP2JV9i5AAsG9ocfbsOzje95Um9NY6yqOZpxqJF9VhCMdSLz7DIeUjgaABLgKnuTRRWHnkt/Am+C8aJu905kNu33X95u1wTiYGx3lsEegeQ7sJ2cxATc6jV1nSYmETRQGSuARGk0B04/66zPPzFW38CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746110568; c=relaxed/simple;
	bh=phwLu/CwA3EFUTFaKXenpAtsrYjMpcL8VpXNUSokPOM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uCxWyVtKshegQeEF+EfwZ1qagelBiejex1aZbSgg7mC7K1mS5PoMnNVbCt0q3Nc+YylxxAi+I57pyjfP7/LxkUcqj2Atx4yh9LE7j37TKYdeg37XLf27tnuapQuEy7588+OZf9QvwPgq+JmSjo1s4NDxf9oof7/gpjBgccO2yL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B52F1C4CEE3;
	Thu,  1 May 2025 14:42:46 +0000 (UTC)
Date: Thu, 1 May 2025 10:42:51 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Costa Shulyupin <costa.shul@redhat.com>, John Kacur <jkacur@redhat.com>,
 "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>, Eder Zulian
 <ezulian@redhat.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] rtla: Save trace when option `--trace` is specified
Message-ID: <20250501104251.46c2e1fb@gandalf.local.home>
In-Reply-To: <20250304121053.06b84874@gandalf.local.home>
References: <20250127170251.744751-1-costa.shul@redhat.com>
	<20250227200623.60f20571@gandalf.local.home>
	<CAP4=nvQXaFmemBeW8U3U9zTMK0gVYvp23gfq_6ALsBJPTXt9Uw@mail.gmail.com>
	<20250303150351.28007ad1@gandalf.local.home>
	<CAP4=nvQ9pXYtihL7HTTRK=EzUEubtWbxDr78JswksSo-wa7zYw@mail.gmail.com>
	<CAP4=nvTCVLa5MzBbJVz=S_ZiDoJ2hY-8fM+uRnGgumi0sFivWA@mail.gmail.com>
	<20250304121053.06b84874@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 4 Mar 2025 12:10:53 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 4 Mar 2025 09:16:11 +0100
> Tomas Glozar <tglozar@redhat.com> wrote:
>=20
> > =C3=BAt 4. 3. 2025 v 9:00 odes=C3=ADlatel Tomas Glozar <tglozar@redhat.=
com> napsal: =20
> > >
> > > So we need to stop tracing here, before we save the trace, if we want
> > > to do that. Perhaps combining this with the cleanup patch [1] and
> > > doing the stopping in save_trace_to_file would make sense?
> > >   =20
> >=20
> > Also, the patch will also save the trace if running with -a and the
> > threshold was not violated, which is not what one usually wants, e.g.:
> >=20
> > $ rtla osnoise top -c 0 -q -a 10000000 -d 5s
> >                                          Operating System Noise
> >=20
> > duration:   0 00:00:05 | time is in us
> > CPU Period       Runtime        Noise  % CPU Aval   Max Noise   Max
> > Single          HW          NMI          IRQ      Softirq       Threa
> > d
> >  0 #4           4000000        37712    99.05720       10998
> > 555        7624            0         4011           34           2
> > 4
> >  Saving trace to osnoise_trace.txt
> >=20
> > I believe it would be better to add a new option, something like
> > --force-trace, that would be used to save the trace even if there is
> > no threshold violation. -t/--trace and -a could then be used with the
> > same semantics as before. =20
>=20
> As long is this is what you expect to happen. I just wanted to point out
> that recording the trace while it is active means it may never stop
> recording. If that is OK, then I'm fine with the change.
>

I just noticed that this patch was never applied. Is it still something to =
add?

-- Steve
