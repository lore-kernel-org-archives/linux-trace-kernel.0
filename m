Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8A11103
	for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Jul 2024 13:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721914434; cv=none; b=IRcCUIutd8Vr2H4Bv+nYmvOU3FaezXQtO5genERN/1tqCmtp4BBPNcDIltC7wXQUTpaQ8SMBe6oqkUD7hmbnwtLmqWi9G8l9X6Qtr9VJZdxI8M/faU5VdD8NYH4V5rmwA+NTk+8LTLvGAVG52fHT1tDsHt+yjSZKNTHad12MqXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721914434; c=relaxed/simple;
	bh=vE8Qv2NK4dDLFDjfmnNk/PjRFSRVTKqRDKyVImc9oTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=teWpiMgYVUhRQwYTqIY/dgl+nIoGqiecPHlsxjNcjOfOxubDOagFiDid9YrkLWa7Y5ig/C1Mmrpn5EBfNdt07F/sOoY8eLEGzhtSEfs7qfLKwe6zUNP6GQn7plgRFmhHTDOrIwMZgSD5skqlQHRlvlw+VmGWOqJEiErjXOMdDyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VigwtfcN; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VigwtfcN"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ef283c58f4so1729201fa.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Jul 2024 06:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1721914431; x=1722519231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=77M2hqri16ATP/ZxqSsaB10whKzsKpo+yrsyGNUOEa4=;
        b=VigwtfcNUsZGNguvuH65x0XDmSJ0z1hbitc77A624Lt9diJZZuf2JDSOkAqBuBz8Jq
         oos45BR8i32/R754snbAZt1AXQOQdN4NS96VW2x5fIDlrCuIbYUsC6wQtv0cafOc7uA2
         m08YAR7iDd2fHa/msJB7UKZAHr0ZuKAU9kuys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721914431; x=1722519231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=77M2hqri16ATP/ZxqSsaB10whKzsKpo+yrsyGNUOEa4=;
        b=ccYgGbfQX1JPcpaGF31PhtyL2SA59z99vRfM7m2fJq2/xzEVT35gz1p4dgws1vY8gi
         3/OLoZAACiI9+PLxTZvhVoMS3EOnz1DuFLP93chi/evS7gMFTxLubEdlwoi1iaiyonz3
         pUUHs9R2dwq5Sy1qyCnssD52HH2sWu4FXne5JxuPBH7DBcBQzGS4VQvMIgMtRRqibVkZ
         lVUZZoOMKi/TiafacsiNtEXLmkescgSkQif2JFUl1FJ2202K6wlw43svUFsPE3uhxXoA
         Bz4AHJmKKkuaNLRk6aAbSkzaEnPeGSSruCr6CI88Ujip0QTwjlXryXh7yOfW7KIua7L4
         +SRQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1XUxd9O7KvLVmB5ZHTBhbg7dIJ4EyOnDioy2UHSuLANCt534XZfYxnF58dzhzjH1DkTfP832ziZKCCRIMR1Z/yXahAdBQTRdFfH+1og5jRTvU
X-Gm-Message-State: AOJu0Yy/Ye6UZi0DFbGIR2iddX4wLtNgyCRxKaUKNk508lZLdZSnTI07
	iNr2/GYQcTKA/U+LajItHDWwfkCFOiuNAxQmevFR/V7qYYyLXuwfst6p1hVavRoYegA3HyclEtW
	MD5q8Yobsy5sTLODdxb0CnHgCbBxpqZkX59jo
X-Google-Smtp-Source: AGHT+IHXqKat21C30UDCtMkJF310a/BsdFo4TaIYxJ8zuwxKOlSI+AmwUKOLe6n4fPshQAGO1SRooWaHm7jfR78CSW8=
X-Received: by 2002:a2e:8947:0:b0:2ef:3347:ee93 with SMTP id
 38308e7fff4ca-2f03dbf10femr15932991fa.44.1721914430939; Thu, 25 Jul 2024
 06:33:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719204701.1605950-1-minipli@grsecurity.net>
 <CAD2QZ9bDcQ46jOAc_Hxy6sG5-N5RPxw4zPuLK6R+M_GhxZR+=g@mail.gmail.com> <5083301c-6dc9-45c9-8106-da683ac6bfbb@grsecurity.net>
In-Reply-To: <5083301c-6dc9-45c9-8106-da683ac6bfbb@grsecurity.net>
From: Ajay Kaher <ajay.kaher@broadcom.com>
Date: Thu, 25 Jul 2024 19:03:39 +0530
Message-ID: <CAD2QZ9ZxZ+mjfju2JMw3fPATNNWkqT1p97QxXgeGo54AFzQ-Cw@mail.gmail.com>
Subject: Re: tracing: user events UAF crash report
To: Mathias Krause <minipli@grsecurity.net>, Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, =?UTF-8?B?SWxra2EgTmF1bGFww6TDpA==?= <digirigawa@gmail.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@leemhuis.info, Dan Carpenter <dan.carpenter@linaro.org>, 
	Vasavi Sirnapalli <vasavi.sirnapalli@broadcom.com>, 
	Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 5:38=E2=80=AFPM Mathias Krause <minipli@grsecurity.=
net> wrote:
>
> On 22.07.24 13:13, Ajay Kaher wrote:
> > On Sat, Jul 20, 2024 at 2:17=E2=80=AFAM Mathias Krause <minipli@grsecur=
ity.net> wrote:
> >>
> >> I noticed, the user events ftrace selftest is crashing every now and
> >> then in our automated tests. Digging into, I found that the following
> >> is triggering the issue very reliable:
> >>
> >> - in one shell, as root:
> >>   # while true; do ./kselftest/user_events/ftrace_test; done
> >>
> >> - in a second shell, again as root:
> >>   # cd /sys/kernel/tracing
> >>   # while true; do cat events/user_events/__test_event/format; done 2>=
/dev/null
> >>
> >
> > Tried to reproduced on 6.10.0-rc7-100.ph5+, only getting repeated outpu=
t as:
>

Mathias, thanks for reporting. I am able to reproduce the 'KASAN:
slab-use-after-free'.

Steve, let me know if anything wrong in my investigation:

[ 6264.339882] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ 6264.339970] BUG: KASAN: slab-use-after-free in f_start+0x2b5/0x370

This belongs to  f_start() ->  f_next() -> trace_get_fields():

    trace_get_fields(struct trace_event_call *event_call)
    {
        if (!event_call->class->get_fields)
        return &event_call->class->fields;
        return event_call->class->get_fields(event_call);
    }

This happens while reading 'events/user_events/__test_event/format'.


Allocation:
[ 6264.347212] Allocated by task 3287:
[ 6264.348247]  kasan_save_stack+0x26/0x50
[ 6264.348256]  kasan_save_track+0x14/0x40
[ 6264.348260]  kasan_save_alloc_info+0x37/0x50
[ 6264.348265]  __kasan_kmalloc+0xb3/0xc0
[ 6264.348268]  kmalloc_trace_noprof+0x168/0x330
[ 6264.348280]  user_event_parse_cmd+0x57b/0x26c0
[ 6264.348286]  user_events_ioctl+0xa92/0x1850
[ 6264.348290]  __x64_sys_ioctl+0x138/0x1b0
[ 6264.348295]  x64_sys_call+0x9a4/0x1f20
[ 6264.348299]  do_syscall_64+0x4b/0x110

user_event_parse_cmd() -> user_event_parse() {
    .
    user =3D kzalloc(sizeof(*user), GFP_KERNEL_ACCOUNT);

Link: https://elixir.bootlin.com/linux/v6.10/source/kernel/trace/trace_even=
ts_user.c#L2118


Freed:
[ 6264.350333]  kfree+0xd1/0x2b0
[ 6264.350337]  destroy_user_event.part.0+0x313/0x450
[ 6264.350341]  destroy_user_event+0x129/0x1a0
[ 6264.350344]  delayed_destroy_user_event+0x62/0xd0
[ 6264.350347]  process_one_work+0x621/0xf60
[ 6264.350359]  worker_thread+0x760/0x14f0

static int destroy_user_event(struct user_event *user) {
    .
    kfree(user->call.print_fmt);
    kfree(EVENT_NAME(user));
    kfree(user);  <--

Link: https://elixir.bootlin.com/linux/v6.10/source/kernel/trace/trace_even=
ts_user.c#L1510


Race condition:

Thread A i.e. event reader able to reach the f_start() as the path is
valid. Thread A waiting
for lock. At the sametime, Thread B has acquired lock and removing
events entry followed
by free the user_event object. Later once Thread A got the lock it
tried to read address
which belongs to struct trace_event_call (struct trace_event_call is
member of struct
user_event)

    Thread A (read event)                         Thread B (remove event)

    .                                                           worker_thre=
ad()
    .
delayed_destroy_user_event() -> acquire event_mutex
    .
destroy_user_event()
    vfs_read()                                            .
    seq_read()                                           .
    f_start() -> acquire event_mutex         eventfs_remove_dir()
    . (waiting)                                             kfree(user)
    . (waiting)                                             released event_=
mutex
    acquired event_mutex
    f_next()
    trace_get_fields():

I think you have added the following check in f_start() to prevent
this race condition,
but somehow with eventfs still some gap to race condition.

static void *f_start(struct seq_file *m, loff_t *pos) {
    mutex_lock(&event_mutex);
    if (!event_file_data(m->private))   <--
        return ERR_PTR(-ENODEV);

-Ajay
