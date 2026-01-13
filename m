Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEA136BCC9
	for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Jan 2026 23:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768347878; cv=none; b=fUDz2E3AZQxANaeLt3kgPOuQZQ1jw27VJ0FJr+zS9yCqILYJSvUAvl7ScI7f+7q0RL3NH87TF9Db9gOVifH81q2AutnepmiaJPUlxmaOxqWRzhW0rgbScOAFEvUN2mtvDSb3CZCR8J35xhuAj4byqh/2/R5L+bBcnb40OXu2JEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768347878; c=relaxed/simple;
	bh=naWJNIFRQlEdpMHmk5ownLngDFSb+6b+Xjr/XcBcU3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fgJ6hoi55VeIf2tl4pUnRzUMiLZkmgZezW2jlgnS3Cqy8KWpnHsZ+Lsz3SjwpRBGn2WQoKHaeaDXTi1jZmnyso2Nyk1QAby+LQz914MTsMgKw6+sqyBrB4IL/+5NacH1slYMCxIvQPne18xY3A2GP0NB4G/O43x60nZ4xyCfvWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEDNyfpP; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEDNyfpP"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-432d2c7a8b9so4374693f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Jan 2026 15:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768347875; x=1768952675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=naWJNIFRQlEdpMHmk5ownLngDFSb+6b+Xjr/XcBcU3c=;
        b=hEDNyfpPmk7rSlHY7ocQAO5eIShqlrfcBBUJ3bzBlZmysJw+HGu7hP2lDP4Yno+W/C
         xtzbkpVzU16BM/JlLbCscKV3kqzEhi5nTFWgZv8dSdApl0QrzDZUqN3Cu3dEhbbJEt27
         qNwchFflme1TsAJLLvIlTgisf9Q/MnSI58q5LpPBaTutlOT+H8bQAY4LuA5OA735uqb+
         Ujjq7uH7U7LuJtLTjfvul5nlk8k0pu0HFJ/cB29B1aCioHSObW4cxKOnYQZXUIB6UVyY
         me/8rNkgVWvTzxodP3W+crtPd0CrX9jb0rEjhKmmakkFrMIw0OMyIUjyUIMOVIps1BCq
         LsOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768347875; x=1768952675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=naWJNIFRQlEdpMHmk5ownLngDFSb+6b+Xjr/XcBcU3c=;
        b=FPdPNw7HySDOmrfIFE5OWcATZP68UxWdb9q1PTCT7VXUEEKdm6WgTHwTeSkpprqqd/
         YRS/m31irtCF6oe+X0+y8UZTaJB0wb3NUCpd1gPZd1JL5uEuGkVnHmGbbW+aXEUxXsa1
         4cpqRYY0EaNfReO1li/ddh0x5CbVD7pqlMvjCYtvXoH3OckbZGRWASc47aIxzyEdBi6Q
         //frAdSUAlpBBl04pYxxb73Pj1TvPpzALEYFC4lmAAK2w0I4h0JId+HxPeHYQpZ4FRq2
         onb+6OIeKSsdZU1iJpCbtb7je7/IR34mP5olL/hrC5lkcvQb9SXbjS3uXDcLCXLh8qr0
         ng7g==
X-Forwarded-Encrypted: i=1; AJvYcCV+/zt0X/Mm2FA7jEMzesRr6twAUE382hwTzuuE4qBebF1KGBoD6MzTy46ThEaBl1jveTVj0+RUzHAxpCDNLIg8WHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVebNPxsWSkx2eNocM/2B/HCdwbFC2a3FkXPZUMWU/QdQjfN1u
	PrkkUyQh2IR24qKYWDJX7kpQC0u3c8TN8pBctcyu77wFES1RtEmFiMI8IrIXUi4Xt1dPWAZ04XO
	R5fMY0spzeEtJVSA4cS/FM2noTpqIIv8=
X-Gm-Gg: AY/fxX467Sdtst84v37SOdGD2AtKGMp7cb0OCc5RzuSCxwYEzVCQ41JHYL2v20c4vc1
	BSMmqbmVKr2xH4kzeqTCPsm0X01j+eWjl3U/nNaSZ5po/KffHc/FZ1fdY/eekPbL+WNYLsSuevz
	UbDyhbHH9fxV5LO6VdNjYvlsiynlhC49M3K/KAfpYLphtqEF+W5e+RqHqlV136YVyrWGI82UDEV
	xVLAwlky3qjbmflmCVaDo3ipCJ8hH9IKxNJ7rvIyEsQm430VT4ZH+35WdbqVTB0gNrf8UtfvKbg
	ug+4YIm44nma5/JUFG47lD3BAxJ7
X-Received: by 2002:a05:6000:2502:b0:430:f622:8cd4 with SMTP id
 ffacd0b85a97d-4342c5576a2mr546852f8f.49.1768347875049; Tue, 13 Jan 2026
 15:44:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQKGm-t2SdN_vFVMn0tNiQ5Fs6FutD2Au-jO69aGdhKS7Q@mail.gmail.com>
 <20260109173326.616e873c@fedora> <20260109173915.1e8a784e@fedora>
 <CAADnVQKB4dAWtX7T15yh31NYNcBUugoqcnTZ3U9APo8SZkTuwg@mail.gmail.com>
 <20260110111454.7d1a7b66@fedora> <CAADnVQJ_L_TvFogq0+-qOH=vxe5bzU9iz3c-6-N7VFYE6cBnjQ@mail.gmail.com>
 <20260111170953.49127c00@fedora> <CAADnVQJiEhDrfYVEyV8eGUECE_XFt7PGG=PFJRKU4jRBn-TsvA@mail.gmail.com>
 <20260112085257.26bb7b5b@fedora> <CAADnVQKvY026HSFGOsavJppm3-Ajm-VsLzY-OeFUe+BaKMRnDg@mail.gmail.com>
 <20260113142340.xEFFVvni@linutronix.de>
In-Reply-To: <20260113142340.xEFFVvni@linutronix.de>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 13 Jan 2026 15:44:23 -0800
X-Gm-Features: AZwV_QiZTOkqU7DSGKGdqwRyoCz_0cyvCLSbxWK4R4mCP4W56GAgkxLydSRDg94
Message-ID: <CAADnVQKMR6kkqC5JQceg6A8F6qSd_cYQE--1ToxwDUxTytPbGA@mail.gmail.com>
Subject: Re: [PATCH v5] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 6:23=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2026-01-12 09:19:58 [-0800], Alexei Starovoitov wrote:
> > > Now if you are saying that BPF will handle migrate_disable() on its o=
wn
> > > and not require the tracepoint infrastructure to do it for it, then
> > > this is perfect. And I can then simplify this code, and just use
> > > srcu_fast for both RT and !RT.
> >
> > Agree. Just add migrate_disable to __bpf_trace_run,
> > or, better yet, use rcu_read_lock_dont_migrate() in there.
>
> Wonderful, thank you.
>
> Is this "must remain on the same CPU and can be re-entrant" because BPF
> core code such memory allocator/ data structures use per-CPU data
> structures and must use the same through the whole invocation?

It's per-cpu maps.
htab_percpu_map_lookup_elem() returns a pointer to per-cpu value
which needs to be valid for the duration of the program.
Not much else.
