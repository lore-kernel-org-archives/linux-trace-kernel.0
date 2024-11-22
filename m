Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D70D13B58C
	for <linux-trace-kernel@vger.kernel.org>; Fri, 22 Nov 2024 17:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732297705; cv=none; b=O1kqJfCkTG1d2LG+SLOxqaerY8E7m3RcKosrS37Ts9u+K6Kpid58thLlsGtf5fB/vdxNRE3esYa9Wh57liAW6kidldU8lwxn6/PGb+01SjzuMDWhV2AoRmSvMzCCiLaFF/okp0upZ6Z1Ah6E9vSMUeyLayovSHRb8sNj7zOUW7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732297705; c=relaxed/simple;
	bh=ohzwp247UbmMP1I+eZkVrW621hY8ktchQarpuk3HIHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SMrR+1HwY/6HZzzP6JeBtE7Ek4TWKa6sb3y1vGHYEYyzkhRZXcX2Qa/Hg2cGnQxNWtja5E6vyUknA36MFvH22l36DfsuyNSXjiNn8U05pVNgr8zi1g9tHSU88ECXO1xLu2veM0yuywDVkAJmbCSXGJ9PAvylKZhrrZXkQ6vI818=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qlHBvNLW; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qlHBvNLW"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-460969c49f2so741cf.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 22 Nov 2024 09:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732297703; x=1732902503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Dzn4IjnMnv34FVgwu/dFGi7pggQRg26ttbIci8IYCo=;
        b=qlHBvNLWBKpD3z6jf3YEGnrLlVNppSrOZqccnrw3ZYj5Uu2CBHjRXfmiHj0v40a/8p
         t40pcGfsG4xKT4HHsyg27g2HhrmE5xuZsKLUvk3fSQW4WoMGfuJiAkFWBlQ7NRwNyk8Y
         CDhr4a3PEooY5zHb5OWOD1eVE1Cjq+YSePr+SE+1aZv13sLKkiMgHpuKEfdR8PN32NDd
         65sKu2i2sfBLvSPjYegazSURbIWYM9+ueFLMEWi2kzOaJ8lTd4ejYNyjEGSDT9v6DnHC
         9YNh18UgR6hDhaIx2yq1VDC+lzNaWT89sqPhDugMZBEnxfH/aJq1w720ykxoFcOLGs5v
         6POQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732297703; x=1732902503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Dzn4IjnMnv34FVgwu/dFGi7pggQRg26ttbIci8IYCo=;
        b=jyEPgf94Z85HmTsw0FTBz23DxFswI4j3qRUbLrklQ+ese+5h8s1X29vb2J04YEXD7B
         bMDlHsaUduNZ/o2/MLg2HNTvj2JCBt468ODFjaP3/Jj/Ui1sgsBTjuHpSLD7haPZiJLB
         939dN0cZRyiVYPjiE7k5Es4ziZ5zUlIvfTL1spqysbWrAOoepTA+fmugwhkfq8o6bP0t
         MrUiZNxY+2sdJUI3d1EhZ6tmGPF31j47l5LwLclf6mY9khLvDVzu0Npe7JtF/62QVeM4
         E68008+ktXpsQt6eBNnLd5IVrq5v5yrY18GEiom1Di4M6kW1EdTkjcMtLObvMKw8TqIO
         TCdA==
X-Forwarded-Encrypted: i=1; AJvYcCVzcEE/Xl9oaEBbGIsJn0kAojia2dZ1y9OBG1jlO5EZMHolXYojRrWijmYW+HR/QVfl2EXsSPBFJ6bW2+duuSGWEfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkZZHTKuSnuUdr5EfQEjeXMtnPM/8shDXdRHP5G5WD/rH4nCyg
	drzKwJIbKPafCXhdsuXuOpFBASQK/1CMzuPfCzt7UIuYPtGLB9Lxz0o6/bt4vUrN8gEjI6dd5xN
	ILuFlXS22FJKY9EBoXwYywrdIXMC0Fj+4BMNf
X-Gm-Gg: ASbGncvXWQ+u1N8Aa6W7cB6zmfUD9gaOlqvfCSeBG9CI2xdzc0hLhNs2KgrkgXif5ag
	jaERC/gz8AOT3tfVZmbAcw/ZaNfhQ7YdPXe74NucY9VE5eqYZ1utpQLTdXi4EDg==
X-Google-Smtp-Source: AGHT+IHJYPuhBB5R2EsaOfV9PwicTxBNUev5vJnJ3t9Qj6dppnojbsdSrU/Uvzq+90nbzwcB66IiT6EpdiNZHyKRfKc=
X-Received: by 2002:a05:622a:607:b0:465:3d28:8af2 with SMTP id
 d75a77b69052e-4653d5d72b4mr4301521cf.22.1732297702894; Fri, 22 Nov 2024
 09:48:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122035922.3321100-1-andrii@kernel.org> <20241122110737.GP24774@noisy.programming.kicks-ass.net>
 <CAJuCfpFvHwjMDdFGjCfg+fta2=Ccif7XReTH6TpC+V+PZ1JmAQ@mail.gmail.com>
In-Reply-To: <CAJuCfpFvHwjMDdFGjCfg+fta2=Ccif7XReTH6TpC+V+PZ1JmAQ@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 22 Nov 2024 09:48:11 -0800
Message-ID: <CAJuCfpFy27B3B=4QvATTzaM44Ferf1scbt0JCdrCdj2gzo52+A@mail.gmail.com>
Subject: Re: [PATCH v5 tip/perf/core 0/2] uprobes: speculative lockless
 VMA-to-uprobe lookup
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, mingo@kernel.org, 
	torvalds@linux-foundation.org, oleg@redhat.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jolsa@kernel.org, paulmck@kernel.org, willy@infradead.org, mjguzik@gmail.com, 
	brauner@kernel.org, jannh@google.com, mhocko@kernel.org, vbabka@suse.cz, 
	shakeel.butt@linux.dev, hannes@cmpxchg.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, david@redhat.com, arnd@arndb.de, 
	viro@zeniv.linux.org.uk, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 7:04=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Fri, Nov 22, 2024 at 3:07=E2=80=AFAM Peter Zijlstra <peterz@infradead.=
org> wrote:
> >
> > On Thu, Nov 21, 2024 at 07:59:20PM -0800, Andrii Nakryiko wrote:
> >
> > > Andrii Nakryiko (2):
> > >   uprobes: simplify find_active_uprobe_rcu() VMA checks
> > >   uprobes: add speculative lockless VMA-to-inode-to-uprobe resolution
> >
> > Thanks, assuming Suren is okay with me carrying his patches through tip=
,
> > I'll make this land in tip/perf/core after -rc1.
>
> No objections from me. Thanks!

I just fixed a build issue in one of my patches for an odd config, so
please use the latest version of the patchset from here:
https://lore.kernel.org/all/20241122174416.1367052-1-surenb@google.com/
