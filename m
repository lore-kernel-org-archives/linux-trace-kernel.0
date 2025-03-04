Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFB725F996;
	Tue,  4 Mar 2025 17:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108200; cv=none; b=MQk/ijIzG69py4rNe4NsMgmK/GgwiVQNn3IlSJKgjozy6QJYeQRFu9WutzXUrIdgCt3SUKvd3b8OUAnNVr9CGDlo3kC6aGHo4SZdhACNqFQvPUiLZSpXhKyfuHw3OZSillAJxbSdVGwcAPuwYH0au7zUr6b4pLJlg+9LfGDf5TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108200; c=relaxed/simple;
	bh=Vy6aO++eSUX6F1uUf/GKjf51P70zh6k7VBsjfxHU6SU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OS1SPN1cuAkjSW4X2FagdrXFkEm8mUz1wAYVttCGbKlmTRdcbXDAW8MSVviA3wJOV7giQNpz9pmWgnVsRPS5gSwywqyl5YuuzWGQPpgtLvn1YRUJCuMeGX/RwTRil2lPXCaRQKhYDRvHb1pipTYPwp1UU1fgP0ir07snCnkyOTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3020CC4CEE5;
	Tue,  4 Mar 2025 17:09:59 +0000 (UTC)
Date: Tue, 4 Mar 2025 12:10:53 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Costa Shulyupin <costa.shul@redhat.com>, John Kacur <jkacur@redhat.com>,
 "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>, Eder Zulian
 <ezulian@redhat.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] rtla: Save trace when option `--trace` is specified
Message-ID: <20250304121053.06b84874@gandalf.local.home>
In-Reply-To: <CAP4=nvTCVLa5MzBbJVz=S_ZiDoJ2hY-8fM+uRnGgumi0sFivWA@mail.gmail.com>
References: <20250127170251.744751-1-costa.shul@redhat.com>
	<20250227200623.60f20571@gandalf.local.home>
	<CAP4=nvQXaFmemBeW8U3U9zTMK0gVYvp23gfq_6ALsBJPTXt9Uw@mail.gmail.com>
	<20250303150351.28007ad1@gandalf.local.home>
	<CAP4=nvQ9pXYtihL7HTTRK=EzUEubtWbxDr78JswksSo-wa7zYw@mail.gmail.com>
	<CAP4=nvTCVLa5MzBbJVz=S_ZiDoJ2hY-8fM+uRnGgumi0sFivWA@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 4 Mar 2025 09:16:11 +0100
Tomas Glozar <tglozar@redhat.com> wrote:

> =C3=BAt 4. 3. 2025 v 9:00 odes=C3=ADlatel Tomas Glozar <tglozar@redhat.co=
m> napsal:
> >
> > So we need to stop tracing here, before we save the trace, if we want
> > to do that. Perhaps combining this with the cleanup patch [1] and
> > doing the stopping in save_trace_to_file would make sense?
> > =20
>=20
> Also, the patch will also save the trace if running with -a and the
> threshold was not violated, which is not what one usually wants, e.g.:
>=20
> $ rtla osnoise top -c 0 -q -a 10000000 -d 5s
>                                          Operating System Noise
>=20
> duration:   0 00:00:05 | time is in us
> CPU Period       Runtime        Noise  % CPU Aval   Max Noise   Max
> Single          HW          NMI          IRQ      Softirq       Threa
> d
>  0 #4           4000000        37712    99.05720       10998
> 555        7624            0         4011           34           2
> 4
>  Saving trace to osnoise_trace.txt
>=20
> I believe it would be better to add a new option, something like
> --force-trace, that would be used to save the trace even if there is
> no threshold violation. -t/--trace and -a could then be used with the
> same semantics as before.

As long is this is what you expect to happen. I just wanted to point out
that recording the trace while it is active means it may never stop
recording. If that is OK, then I'm fine with the change.

-- Steve
