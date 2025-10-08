Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBC822B8B6;
	Wed,  8 Oct 2025 00:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759882772; cv=none; b=LzBDDJ1A0CRa/Miq2VvYN8872vPGsXHrKMItk4nV1NmY/CCyk/uk4h/dRAdRpm+kiOa5hj/VuyGkGM3Hv/dw0dNpCKhzggP9zzQ7rpvkm3oFG+rGon6oV4gTIZuj1p9lRG1c3vqCQxvU4gVKn+tXLhe3lG2qO/Xc/dIpV5RfYZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759882772; c=relaxed/simple;
	bh=BN8cuSEBg66C2lF8YtmhtyuvN4mkZSwQNm7AYTmbIB0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fmkqM95OLOVvgGdXJogNu1eci4Lq1tcNOT3jYgVq790JZNuM7O4WLBYT1UKMo2W8B0so+ZlhCD3pgM9LtnEeOFJKcraTyikHF4tSSUxt/YUgzmjVhfKK5fsMCv9fwGkVbUiX+4WnqLCyL9OwEMVqYVXefvTKS6K6iWh3eU+RZ/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 3137FB8BB4;
	Wed,  8 Oct 2025 00:19:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 2C8D020016;
	Wed,  8 Oct 2025 00:19:21 +0000 (UTC)
Date: Tue, 7 Oct 2025 20:21:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Runping Lai <runpinglai@google.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Wattson CI <wattson-external@google.com>,
 kernel-team@android.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Luo Gengkun
 <luogengkun@huaweicloud.com>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [PATCH v1] Revert "tracing: Fix tracing_marker may trigger page
 fault during preempt_disable"
Message-ID: <20251007202113.1ce212a9@gandalf.local.home>
In-Reply-To: <CABgk4RSxm8mNJcRn0HdNH3+Y=VDL5gNVvyhhR26wjBme+i5X-g@mail.gmail.com>
References: <20251007003417.3470979-2-runpinglai@google.com>
	<20251006221043.07cdb0fd@gandalf.local.home>
	<CABgk4RQwGsn4CdP0K+_7A0j7RVOiHNfoF1ESk17wEuzCea16pA@mail.gmail.com>
	<20251007154308.5b158d04@gandalf.local.home>
	<20251007163141.1034b120@gandalf.local.home>
	<20251007174208.11fd02da@gandalf.local.home>
	<CABgk4RSxm8mNJcRn0HdNH3+Y=VDL5gNVvyhhR26wjBme+i5X-g@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 2C8D020016
X-Stat-Signature: rf5cg3xifex3t66bs9jw94qdiqjq6pbu
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18Rc+590qhmKGx8oRxPsAh+DI/ZSCruAn8=
X-HE-Tag: 1759882761-301618
X-HE-Meta: U2FsdGVkX19GlOxcxf6tQkRlJFy//VkzJRGPw+yeonaZjGjSxCkZNGrqaYnW7OkiliRr3vV4EWAzhhxMCTYJ2Kl4quFViXj8+IC0IVLevaIzctQ3GZPFwq7BUAyYIgTCksJgIXfbbrWSh8EXRqe8dLUlmRCtL/2XYrepW460cw1/2HnZuzP1vOl5CfKWxWjcSqqsEZk8hkPTmgUGc+dSRKnuVnfD6NW6NGMaHq4nMpkAC6YzblhL23pGt1OmeHheF2+zDq5pfwxGJABj+7mFG9+NQAq+WuBXRCvRhf50rn3ux9bOroiMx6+bEQUQWhtPJsVxKq29N1sRcsSBy1/U7g7o3Of81g85SvYfptJKiueTM5gh8+FhPG+67jcL/iXdIBW81v2XE4qG2TWQu6kflQ==

On Tue, 7 Oct 2025 16:25:41 -0700
Runping Lai <runpinglai@google.com> wrote:

> On Tue, Oct 7, 2025 at 2:40=E2=80=AFPM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
> >
> > On Tue, 7 Oct 2025 16:31:41 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > =20
> > > +static void trace_user_fault_buffer_free(struct trace_user_buf_info =
*tinfo)
> > > +{
> > > +     char *buf;
> > > +     int cpu;
> > > +
> > > +     for_each_possible_cpu(cpu) {
> > > +             buf =3D per_cpu_ptr(tinfo->tbuf, cpu)->buf;
> > > +             kfree(buf);
> > > +     } =20
> >
> > Oops, missed:
> >
> >         free_percpu(tinfo->tbuf);
> >
> > here. =20
>=20
> Hey Steve,
>=20
> Thanks for providing the buffer-based solution. I tried it and it
> fixes the problem!
> However, the first experiment, adding pagefault_disable/enable()
> around copy_nofault()
> doesn't help. Still having the same problem. I suppose the issue is
> more than pagefault?
>=20
> Can you please suggest the next move? I can also do more tests if needed.
>=20

I may need to make this patch the official solution.

-- Steve
