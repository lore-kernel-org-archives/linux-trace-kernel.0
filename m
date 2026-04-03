Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F13A3AE193
	for <linux-trace-kernel@vger.kernel.org>; Fri,  3 Apr 2026 13:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775222856; cv=pass; b=dzmd4y1fg3euGuCF3z0SSCzvKHb0sQc9lt5SALI/4rWsYcDGn0wpkpWwKZKfItdmTAqDGsqZsTv6w6rqfNTP1efPHUiZvxHMdqRWef+9BjFeyr7fh2P1pUn/KZuaqwJkkMnzalFLVGUt9pz184sGUmlgH+v3yl3a6d/7BykyDT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775222856; c=relaxed/simple;
	bh=u5aZYLglLR2y0VL5RObQhknUHMYSLmH9b+G9V9Pt0TI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tM1Vz4p4U/EdCJKA68Uw2RAKZHKFbPRz65COc5I4QSE0Sx0Xc/VRgWuIu8QgqRu69z78bVpCMcZ/Y+l3O8L2IGNWEn3G1eMaPYrXtU3FFneVmAYro07FhRTBPioF3IviBdPnlE3xrdIJoWiUIh1URIK1Ub3nvBTtiggMnXltT1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMFtJL7R; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMFtJL7R"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6500eae6d2fso1915473d50.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 03 Apr 2026 06:27:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775222854; cv=none;
        d=google.com; s=arc-20240605;
        b=gZJN6G98Fh1wRqBtxUD+rIMjnmxtaZyGAyaXoNlCQMP6ZmSkhvUjN5ItOMAyVgdGxr
         xr6eziqXV6xtAJXaGSqk6s6cxGC2fGzKk484AZ8kCwOEhuWIL09nBFkdWH8sPlpA2yaV
         nrEL6GwonJg4FyHf5at270PX/4puFv27wQAnoQucGbDllkW0ZsmOHdwPYTcydnDOXC6u
         UUjYBJpSSc0mpHTbp1MNTQ/LfhgkTtkwgIR5rnciC6V/1KZkByALGa+eyuW4hTWGLmb/
         l9l7XGnYk+WU1GVh3ilsdoU0hICde5EWfLqZpKFtb9wcDpKUnpwfiXB9YWcVMsWG1xEV
         QBwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5CVFkoDCxGsxXBj8bPmZ7vpSl4MJkw0Z6mvu33ifBL4=;
        fh=dams66zrlx55fiazyiqnlKOgHEtdyzs4m4Jrc1xCjc4=;
        b=Md712HWBawt4u7Bxo8xtfr2yHguTbFsXP0ttkrcq1AVxYmxzBk5dm1oQDD2FU2Ol29
         nevMQkebBHk0yOaD2W6edgf5Ln+TMWXQcAIpQtrcGgiGW0mNKO+aAvfqrCUjtzeLxsfR
         LVfmGaSqoK6qLmmjQy31K4ujutODTj7o1stj6jWEgIkUhsYvTV5zl5DnvuW7uSqwbMX3
         7zpPSafbDnKbDTwReiWLcaP6RvuiAmaj0LCCHpDI3A/8ziCTRCTr5v49jgOblJu55Xjb
         pkk7rxlIqgiKnLPnW2e+TGj4Xk7GhrW/B1VS8rqv1mY1S0pezacowK3KnccMzZLlMZf6
         lSDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775222854; x=1775827654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CVFkoDCxGsxXBj8bPmZ7vpSl4MJkw0Z6mvu33ifBL4=;
        b=IMFtJL7RJt6rXfN0Zw5+J7H4TLEmptkinuXMpteD5eHFKiIX8NdwHG/p/o0XsBr/0b
         RwZEQ5zlH41GoxaijM+s52jftbbHguPd3Zw273KEwGh0D4qC2gDPF516JyCeWrF5xnIl
         5ZkGIFJGrKyWU8543gsCvuIsnUyxkmJzsfW9mjfMeYuamnZm6IGfxp7hHryvfn4fjFHk
         kzbWxXztOQYWTd4eohM1p5Pv0vJubLPb0rzNGWfMbo86pvL9ymlfJ9CAH2f/+5fChInM
         exlvqZPkMWW1eGCUb9B5jezbedViX+FCKtVP7BvLTkexTpqRXD+vj2gqf0vrAyY4cHLL
         j75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775222854; x=1775827654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5CVFkoDCxGsxXBj8bPmZ7vpSl4MJkw0Z6mvu33ifBL4=;
        b=dOsi4Z+72GTBfiWBFOkCVD34m8oX6+oVTjMLxFLRuUN/LLfd72cScibAznv8+PS4Pj
         6zuGaxQ8tHtNvPQaMfSJexyqsqJebz2BLhLM2CIEEfbPZvu9tyDxnBDk4Mt4/lHiXcfR
         RNHqEQS9VCAiyBa0ONmo30qvlC55eJ7IMjQw4jhVRntmFoUsm1d/1XFlS/LiqSg+E0ql
         5IkUGwFOy0CnihUGrLTx2ZvVHpcEmmUT8u3gKwZoC19l21dmq6Sw73sjW7GImOe0yNI8
         oo/OsLBVzheirloRuR/wLoscekAGRE6pUp9eiYmhR2FyhGQNKd9I7iw91/gdFt2J4W85
         R7Lw==
X-Forwarded-Encrypted: i=1; AJvYcCUgOKkwvOs/LTikyCTO7Y5AxZVW15/g2MWuTKBQm0+ETo5FgD9zUJtFvf5CdwfWFLy3bhLAHEuNTXF9tBGIIs21AWA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2GQS8RuypYY0jbWqte4ba+IyDJVArzN3ThzWqpsVhS/qeFeGL
	sX7XbbjltyrMxit1NNrgcRJKzON9LV40pVhBWbBi468vkfwn0AZGdNo0YQnsifq4cUBsF1drFOU
	L+rrlpuSnWLy3mChS6fW2IAgCFmluv1c=
X-Gm-Gg: AeBDietGeu8xq0N07niL786uSh6QGeMFOqzIm0ShtDZb94DxDe+btXq9njKM56D//JW
	BD6Nmnc86KKqw350NuZxFAN52j19vNBxsb1gDwnp61yXk9ks0RwvJ8ZXlvaYrs9Mol7HgB/ScGa
	fEhotwyhnnuQQ1gzZwpB7tJaIBFoxul7XuPbZF3hou6GPolmEMg3RL6V/0TuxWELOlI68zFK9jP
	I/qmlRdcLR65NHtf3Hbny0ZHuNrsQJlufrdLfkE8lj6r7T6Dngw6nhPHxk/kjem44WG0GbAB4+v
	neYkJztQ
X-Received: by 2002:a05:690e:4146:b0:640:cccb:1fd2 with SMTP id
 956f58d0204a3-65048766844mr2643914d50.33.1775222849700; Fri, 03 Apr 2026
 06:27:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402092607.96430-1-laoar.shao@gmail.com> <2261072.irdbgypaU6@7950hx>
 <CALOAHbDnNba_w_nWH3-S9GAXw0+VKuLTh1gy5hy9Yqgeo4C0iA@mail.gmail.com> <3036842.e9J7NaK4W3@7940hx>
In-Reply-To: <3036842.e9J7NaK4W3@7940hx>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 3 Apr 2026 21:26:53 +0800
X-Gm-Features: AQROBzAhqUn0C4z5t47fiWttRpelo5Bwp2NUuCrYH7DZ2fW1KBFq_ETr6BE5IqE
Message-ID: <CALOAHbAx=ne-ByCXF+4ehLYX9+3a5BDjHyUn=owmEJNBFXOthg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] trace: Allow kprobes to override livepatched functions
To: Menglong Dong <menglong.dong@linux.dev>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, kpsingh@kernel.org, mattbobrowski@google.com, 
	song@kernel.org, jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, 
	yonghong.song@linux.dev, live-patching@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 6:26=E2=80=AFPM Menglong Dong <menglong.dong@linux.d=
ev> wrote:
>
> On 2026/4/2 21:20 Yafang Shao <laoar.shao@gmail.com> write:
> > On Thu, Apr 2, 2026 at 8:48=E2=80=AFPM Menglong Dong <menglong.dong@lin=
ux.dev> wrote:
> > >
> > > On 2026/4/2 17:26, Yafang Shao wrote:
> > > > Introduce the ability for kprobes to override the return values of
> > > > functions that have been livepatched. This functionality is guarded=
 by the
> > > > CONFIG_KPROBE_OVERRIDE_KLP_FUNC configuration option.
> > >
> > > Hi, Yafang. This is a interesting idea.
> > >
> [...]
> >
> > +/* noclone to avoid bond_get_slave_hook.constprop.0 */
> > +__attribute__((__noclone__, __noinline__))
> > +int bond_get_slave_hook(struct sk_buff *skb, u32 hash, unsigned int co=
unt)
> > +{
> > +       return -1;
> > +}
>
> Hi, yafang.
>
> I see what you mean now. So you want to allow BPF program override
> the return of all the kernel functions in a KLP module.
>
> I think the security problem is a big issue. Image that we have a KLP
> in our environment. Any users can crash the kernel by hook a BPF
> program on it with the calling of bpf_override_write().

This feature is guarded by the CONFIG_KPROBE_OVERRIDE_KLP_FUNC
configuration option, which is disabled by default. Consequently, the
user must explicitly enable this option to utilize the feature.

>
> What's more, this is a little weird for me. If we allow to use bpf_overri=
de_return()
> for the kernel functions in a KLP, why not we allow it in a common kernel
> module, as KLP is a kind of kernel module. Then, why not we allow to
> use it for all the kernel functions?

By leveraging KLP, we can rapidly deploy new features without
interrupting production workloads. Accordingly, this feature is
specifically targeted at KLP-patched functions to maintain that
seamless delivery model.

>
> Can we mark the "bond_get_slave_hook" with ALLOW_ERROR_INJECTION() in
> your example? Then we can override its return directly. This is a more
> reasonable for me. With ALLOW_ERROR_INJECTION(), we are telling people th=
at
> anyone can modify the return of this function safely.

It is unfortunate that ALLOW_ERROR_INJECTION() is incompatible with
KLP-patched functions, as this limits our ability to perform fault
injection on livepatched code

>
> WDYT?
>
> BTW, this is a BPF modification, so maybe we can use "bpf: xxx" for the t=
itle
> of this patch. Then, the BPF maintainers can notice this patch ;)

I agree with the suggestion. I will update the subject prefix to
"trace, bpf:" in the next version.

--=20
Regards
Yafang
