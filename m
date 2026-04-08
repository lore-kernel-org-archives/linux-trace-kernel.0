Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB01362120
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Apr 2026 06:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775631130; cv=none; b=ofapOgzouNNeDx1wyYDszcA0pW4O/+vOz5f/HhiueQ/+rkUk2LXoLEnP1Vok5jNIEa485E/3OBmiDI8lQzcKC07maad3r0+e/cVQRsQNCLso7QNakeBUNvcHHLh5akujrYCGWCQ4PhD/B84bdvuJuMqWsZvmvXhOXqKUvYXLxkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775631130; c=relaxed/simple;
	bh=fVLaWWJM/+DrhOdY/IjJLlsijZLtkkmzv58xVpgX79Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kwNIm9al3ctsvWSQWcB0qorjynjaL76H8IVx11qN14AJMHv7+RaIiax0LntAp4pnbSoPJ3KMIUJ4IDfUAQBMTjQFuPLoeh1/QM4AwIzemxWsURGHnUT73+eba9kv4+NIvdV38gcblFmsdCGaKn+Xq1434x/6mg9gFQyZ1t/h9VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jymV2QsF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jymV2QsF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D44C2BCB6
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Apr 2026 06:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775631130;
	bh=fVLaWWJM/+DrhOdY/IjJLlsijZLtkkmzv58xVpgX79Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jymV2QsF7wM3fzUjlvZ8wxD/dh1uoEt8jxsUvTGWgs2pbCcWhVyXLk/Ll2Sq/xSqj
	 BxuuWvWT7Xgt8LOP/BP4EQzD9VGSKyyWQVp1v0D8xOuAo2fnIQ0Oe4xpojFwWB7ASV
	 EiFImJuaSZKnhnyMfryF6DOhf7NSknL2DaAUbyNcrnMlookJcnJ//SVw8PbJN2mtyR
	 oCjjCo0IN30hSIEZWJJGrBfldeadh1eqV48nzH9hLREIX4SoaIzpN7o8DcRq6IWXxC
	 iECJNvkdEt+4eL/Ienpmxq+35OgvlHHfuvzQ5qoWTFs879dHvjSWWETF6MfHFeR7Ui
	 Lb4PL6XSe83/w==
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8a016799d2cso77165306d6.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 07 Apr 2026 23:52:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUgBkanEhIJXjmfkls0oBjQ5pLM9SraUdR96Nmj9qM9Jp4+w17KxT8nvexG9b0MoN0LQaF2whHRpFYRLhgCDCasHu0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx+LOWiJ7Z/cB8h2RVF4UAgFI5LdfmAHgTTT2flNyhM5alik3K
	va26pF+y6Ih0wi4+dqX4wgig6OC8U89ejvtv/9VeAig7ms4EgNphl9cmj5hwWpfXRnds4TaTPmR
	qhZlra6tFXIo0qEOGYkivgt18V/brAD4=
X-Received: by 2002:ad4:5e8e:0:b0:8ab:48a8:9c34 with SMTP id
 6a1803df08f44-8ab48a89c80mr152901466d6.0.1775631129483; Tue, 07 Apr 2026
 23:52:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402092607.96430-1-laoar.shao@gmail.com> <CAPhsuW7Y5KksWM49TrGH_Hohaq02XO8qs7G99Y6D8=0usLFSrQ@mail.gmail.com>
 <CALOAHbDG8=eUV53kF+xn=izs2rpydCk=a9RznU-EEOzmkB8mQg@mail.gmail.com>
 <CAPhsuW73qFybHgOnZ=oFC1PvdWkYWDk7gsAoiBXe4xWYagPrmA@mail.gmail.com>
 <CALOAHbC0hqk+yrUZay01EBRNOHgyj1MAavzNK-06XJKK9ARMqQ@mail.gmail.com>
 <CAPhsuW5MN6ikKmxgqby5RJ3_gvjJ4B77X74OvfbTQoFO8iUgzA@mail.gmail.com> <CALOAHbAmTAfamStF9sZtO6efWYJ1sbXJp3PbsVapZf7dba91ig@mail.gmail.com>
In-Reply-To: <CALOAHbAmTAfamStF9sZtO6efWYJ1sbXJp3PbsVapZf7dba91ig@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Tue, 7 Apr 2026 23:51:57 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6ZnCQQw8A=XzR1T4Vqd-iF9+D_uXS8tfR23pgsDHKEzQ@mail.gmail.com>
X-Gm-Features: AQROBzBx8p57X8T9w4WknOECT-1edMnaV15eNk4cujNUDGJ6oJo3VQ-RDwm4ECM
Message-ID: <CAPhsuW6ZnCQQw8A=XzR1T4Vqd-iF9+D_uXS8tfR23pgsDHKEzQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] trace, livepatch: Allow kprobe return overriding
 for livepatched functions
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, kpsingh@kernel.org, mattbobrowski@google.com, 
	jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, 
	yonghong.song@linux.dev, live-patching@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 8:14=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> w=
rote:
[...]
> > We can define the struct_ops in an OOT kernel module. Then we
> > can attach BPF programs to the struct_ops. We may need
> > livepatch to connect the new struct_ops to original kernel logic.
> >
> > I think kernel side of this solution is mostly available, but we may
> > need some work on the toolchain side.
> >
> > Does this make sense?
>
> Are there actual benefits to using struct_ops instead of
> bpf_override_return? So far, I=E2=80=99ve only found it adds complexity
> without much gain.

Yes, struct_ops can be more powerful. For example, we can use
something like the following to modify the content of /proc/cmdline
with a bpf program. AFAICT, this is not possible with
bpf_override_return.

Note that this example doesn't require kernel changes. This is
actually a fun example. I will send the full code as a new self test.

Thanks,
Song


=3D=3D=3D=3D=3D=3D=3D key logic of the livepatch module =3D=3D=3D=3D=3D=3D=
=3D

static int livepatch_cmdline_proc_show(struct seq_file *m, void *v)
{
        struct klp_bpf_cmdline_ops *ops =3D READ_ONCE(active_ops);

        if (ops && ops->set_cmdline)
                return ops->set_cmdline(m);

        seq_printf(m, "%s: no struct_ops attached\n", THIS_MODULE->name);
        return 0;
}

static struct klp_func funcs[] =3D {
        {
                .old_name =3D "cmdline_proc_show",
                .new_func =3D livepatch_cmdline_proc_show,
        }, { }
};


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D key logic of the bpf program =3D=3D=3D=3D=3D=
=3D=3D=3D=3D

SEC("struct_ops/set_cmdline")
int BPF_PROG(set_cmdline, struct seq_file *m)
{
        char custom[] =3D "klp_bpf: custom cmdline\n";

        bpf_klp_seq_write(m, custom, sizeof(custom) - 1);
        return 0;
}

SEC(".struct_ops.link")
struct klp_bpf_cmdline_ops cmdline_ops =3D {
        .set_cmdline =3D (void *)set_cmdline,
};
