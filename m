Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F24611711;
	Thu, 25 Jul 2024 16:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721926113; cv=none; b=F/0ryGtXsLL+zLBzGBjMyDG79ONevJK0WY4hp9tN7lElfCfsR7JPHgaril6xhdh7CBwzNgke6oWvnB1HeAnAZzfb6JmREaOPfh0w8a3cRZbS4TVPADltj1h56KSfqA7rR5G75deMXFtUt29o7TEyn/ikTsIIhy4DIvQG56R6e6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721926113; c=relaxed/simple;
	bh=r259sq61Z4l77qCTYaT0H8XdbOSWShHwDGzQp27SP7c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AWwC2dOhHa8lzIH+cFbtzJrIJdQPPHf5xXxP/haqRlKP8wHFXu0bRdOrz7gA924AUSbfJF2EerewWgTKwAw8nTE9UShDzgb6pZ2oF82LY5McLGMn+0ql7i3yyB+BJs6xOTi051DOW2fDaeIZ9jCSiU/IHg6fKcxxMCVUz0YGQgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6299CC116B1;
	Thu, 25 Jul 2024 16:48:31 +0000 (UTC)
Date: Thu, 25 Jul 2024 12:48:51 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ajay Kaher <ajay.kaher@broadcom.com>
Cc: Mathias Krause <minipli@grsecurity.net>, Masami Hiramatsu
 <mhiramat@kernel.org>, Ilkka =?UTF-8?B?TmF1bGFww6TDpA==?=
 <digirigawa@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Al
 Viro <viro@zeniv.linux.org.uk>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, regressions@leemhuis.info, Dan Carpenter
 <dan.carpenter@linaro.org>, Vasavi Sirnapalli
 <vasavi.sirnapalli@broadcom.com>, Alexey Makhalov
 <alexey.makhalov@broadcom.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>
Subject: Re: tracing: user events UAF crash report
Message-ID: <20240725124851.645981d3@gandalf.local.home>
In-Reply-To: <CAD2QZ9bTrQ1p3zTZOXe6Gk4Xq8kjYSziAYAdbTrvRSZzAGPY9A@mail.gmail.com>
References: <20240719204701.1605950-1-minipli@grsecurity.net>
	<CAD2QZ9bDcQ46jOAc_Hxy6sG5-N5RPxw4zPuLK6R+M_GhxZR+=g@mail.gmail.com>
	<5083301c-6dc9-45c9-8106-da683ac6bfbb@grsecurity.net>
	<CAD2QZ9ZxZ+mjfju2JMw3fPATNNWkqT1p97QxXgeGo54AFzQ-Cw@mail.gmail.com>
	<CAD2QZ9bTrQ1p3zTZOXe6Gk4Xq8kjYSziAYAdbTrvRSZzAGPY9A@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 25 Jul 2024 21:45:03 +0530
Ajay Kaher <ajay.kaher@broadcom.com> wrote:

> On Mon, Jul 22, 2024 at 5:38=E2=80=AFPM Mathias Krause <minipli@grsecurit=
y.net> wrote:
> >
> > On 22.07.24 13:13, Ajay Kaher wrote: =20
> > > On Sat, Jul 20, 2024 at 2:17=E2=80=AFAM Mathias Krause <minipli@grsec=
urity.net> wrote: =20
> > >>
> > >> I noticed, the user events ftrace selftest is crashing every now and
> > >> then in our automated tests. Digging into, I found that the following
> > >> is triggering the issue very reliable:
> > >>
> > >> - in one shell, as root:
> > >>   # while true; do ./kselftest/user_events/ftrace_test; done
> > >>
> > >> - in a second shell, again as root:
> > >>   # cd /sys/kernel/tracing
> > >>   # while true; do cat events/user_events/__test_event/format; done =
2>/dev/null
> > >> =20
> > >
> > > Tried to reproduced on 6.10.0-rc7-100.ph5+, only getting repeated out=
put as: =20
>=20
> < sending again after correcting alignments >
>=20
> Mathias, thanks for reporting. I am able to reproduce the 'KASAN:
> slab-use-after-free'.
>=20
> Steve, let me know if anything wrong in my investigation:

Hi Ajay,

Thanks for analyzing this.

>=20
> [ 6264.339882] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [ 6264.339970] BUG: KASAN: slab-use-after-free in f_start+0x2b5/0x370
>=20
> This belongs to  f_start() ->  f_next() -> trace_get_fields():
>=20
>     trace_get_fields(struct trace_event_call *event_call)
>     {
>         if (!event_call->class->get_fields)
>         return &event_call->class->fields;
>         return event_call->class->get_fields(event_call);
>     }
>=20
> This happens while reading 'events/user_events/__test_event/format'.
>=20
>=20
> Allocation:
> [ 6264.347212] Allocated by task 3287:
> [ 6264.348247]  kasan_save_stack+0x26/0x50
> [ 6264.348256]  kasan_save_track+0x14/0x40
> [ 6264.348260]  kasan_save_alloc_info+0x37/0x50
> [ 6264.348265]  __kasan_kmalloc+0xb3/0xc0
> [ 6264.348268]  kmalloc_trace_noprof+0x168/0x330
> [ 6264.348280]  user_event_parse_cmd+0x57b/0x26c0
> [ 6264.348286]  user_events_ioctl+0xa92/0x1850
> [ 6264.348290]  __x64_sys_ioctl+0x138/0x1b0
> [ 6264.348295]  x64_sys_call+0x9a4/0x1f20
> [ 6264.348299]  do_syscall_64+0x4b/0x110
>=20
> user_event_parse_cmd() -> user_event_parse() {
>     .
>     user =3D kzalloc(sizeof(*user), GFP_KERNEL_ACCOUNT);
>=20
> Link: https://elixir.bootlin.com/linux/v6.10/source/kernel/trace/trace_ev=
ents_user.c#L2118
>=20
>=20
> Freed:
> [ 6264.350333]  kfree+0xd1/0x2b0
> [ 6264.350337]  destroy_user_event.part.0+0x313/0x450
> [ 6264.350341]  destroy_user_event+0x129/0x1a0
> [ 6264.350344]  delayed_destroy_user_event+0x62/0xd0
> [ 6264.350347]  process_one_work+0x621/0xf60
> [ 6264.350359]  worker_thread+0x760/0x14f0
>=20
> static int destroy_user_event(struct user_event *user) {
>     .
>     kfree(user->call.print_fmt);
>     kfree(EVENT_NAME(user));
>     kfree(user);  <--
>=20
> Link: https://elixir.bootlin.com/linux/v6.10/source/kernel/trace/trace_ev=
ents_user.c#L1510
>=20
>=20
> Race condition:
>=20
> Thread A i.e. event reader able to reach the f_start() as the path is
> valid. Thread A waiting for lock. At the sametime, Thread B has
> acquired lock and removing events entry followed by free the
> user_event object. Later once Thread A got the lock it tried to read
> address which belongs to struct trace_event_call (struct
> trace_event_call is member of struct user_event)
>=20
> Thread A (read event)                      Thread B (remove event)
>=20
> .                                                        worker_thread()
> .
> delayed_destroy_user_event()
> .                                                               ->
> acquire event_mutex
> .                                                        destroy_user_eve=
nt()
> vfs_read()                                         .
> seq_read()                                        .
> f_start() -> acquire event_mutex      eventfs_remove_dir()
> . (waiting)                                          kfree(user)
> . (waiting)                                          -> released event_mu=
tex
> acquired event_mutex
> f_next()
> trace_get_fields():

What really bothers me is that refcnt logic. I'm not sure if this is an
issue, but the fact that you can inc the refcnt without holding the
event_mutex looks wrong to me. I would guess it would WARN if that refcnt
was incremented when zero, but there is a window where it gets set to 1
again. Too bad there's not a way to do a refcnt_set_if_zero() or something
to atomically set the value but warn if it's not zero. But then again, if
it did get incremented when zero, there should have been a warning then too.

But I don't think that's causing this.

Will look further.

-- Steve


>=20
> I think you have added the following check in f_start() to prevent
> this race condition, but somehow with eventfs still some gap to race cond=
ition.
>=20
> static void *f_start(struct seq_file *m, loff_t *pos) {
>     mutex_lock(&event_mutex);
>     if (!event_file_data(m->private))   <--
>         return ERR_PTR(-ENODEV);
>=20
> -Ajay

