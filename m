Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57131369BB
	for <linux-trace-kernel@vger.kernel.org>; Sun,  5 Jan 2025 12:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736081576; cv=none; b=JMMrBeJuvWriAr2ejGVGtKZDIcxwJ+zWT2OdIn4lhXARH5uhclrdO9I43LnHvPIaLLPNt3/RIBe7BLUmGTfSGlS64mJ++ITtsTMaALFlUH9Tz10VnvccDq/v6Fei17GLKfu+Em2D8fzGMBuNQxtAkKIFizC3HGZPjGbXSu7vR7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736081576; c=relaxed/simple;
	bh=5UfF6jzmGPHI0cPnrn6XRUmUTB4P+KEml3GX6b/5tzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jLB+qLQKSNTEPcUar7sYSHQvf2KLLK6beSs63b3iu03Z2y3oaOHSDFUIW5d/Ko14abkBB55jj58MPjhNkoy9ydt2ISVP/DpzLfaSh06lCMYY+GswtftbvFc1ZYuuVC3QM/d/jjDIOQrVhi5FljdxjJVMNARgSsQqjeXMVx23VKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p0fvjz8G; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p0fvjz8G"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21625b4f978so106575ad.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 05 Jan 2025 04:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736081574; x=1736686374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9CZd9YA/vxsfF1o+1S6lXa7zVfnq9bHCryfS5okIqnQ=;
        b=p0fvjz8G8GHDKm7wNZ5uN4aXtc0sbHW3ZH83tqC8wj/Dm9I/MK6sjE5i8VUWtFMygv
         ntdIAUOl4O+aoZ360zxFewIUNbfPjEENqig0/Eu0Z9Y9+lsXijGphyOTbvl65VzYvsmM
         9m8ej/YJYljPXtcDR/sdl8i3WA/IkIu2vTwKp6A11qFAfFGgA130wn2bhVOs4/spko/C
         z49U0XnrMo7cC8K4ns+z/bdjPl86MT/u/T+tf4lzrlj7VNs/G5i/gac/DdvAYTkXZnOz
         BtUnzYNh7fF15HJQdPonD5TZXqntIACLneIvdWiSU0DmdtGSdTMp0cIZP8X7HsldCXSc
         Y/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736081574; x=1736686374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9CZd9YA/vxsfF1o+1S6lXa7zVfnq9bHCryfS5okIqnQ=;
        b=iHu4d2od/P2OZTGV9RWL5vTiOAVQmMFVvK2RBlD90h4eNz0cmcybLPNyDGA6aDnAdx
         K8Lrw2a0hrWCBjEucVR76Du3FsDVxkGiHz3UKJ2oJ49wTfT8tOBgQPtG4Ex88fzda6BE
         Zohs4XFxEiuy22DRc5Sb/EYCcrm7jJL8/8MvXNGZsvpdtBLNYsyUoXM9ZyGwAjI+Rp0V
         SOA7YlN4CntphFISWZIiIBFguNkyCShoJVol4nrETUW5qkBIBDvJiS41ZtGi5TFBAl7x
         5ewsxmozr89HOFG7nljtq6ONM+yPqBOSHwXqRw7RwwCRStJxT1q40AZv/kKumb01I3Au
         M8ag==
X-Forwarded-Encrypted: i=1; AJvYcCUBqsgOdCWfvq+Qv2UbH5unB+xxPOUMuhWEgRIaBSz3xy3tWCHEYJiMtQJC41bDrOU/ojCNb7TV92QfxmkV6RiqJAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqhRyAhDDl/BRniSi6tXQeeUPRfeJfATSL3iUxywAzxjabh8yi
	YtfUYde+ji/W6U53mwGvB4rKUqzB9ihtTnsc0ouQPpSciL0O8GBpb/I5E7TpRL9aDTPNkSepCIq
	GwbeXJyV7cOwqq2VOaej6bAj2/Peaaw70uQ5k
X-Gm-Gg: ASbGncsH4TGseKYXmi/giFVF4RmBUm19IoEpFMW18ZEvumyWwhwW+ddNb+8GKRgGwWT
	zsZZpL70B04ckmPDsyQimywup3K73K1LynvPd
X-Google-Smtp-Source: AGHT+IEHA5ba+jpkkdNpDLtsolTeg8E9FnKLL/jtGaf6DdgcjgXXRiauZ5nf4OWT8s7tM+6ZsYXlno3RjzvbYUw9zeI=
X-Received: by 2002:a17:903:120d:b0:216:6dab:8042 with SMTP id
 d9443c01a7336-21a62b6ffb8mr1842805ad.12.1736081573755; Sun, 05 Jan 2025
 04:52:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <86eba318-464b-4b9b-a79e-64039b17be34@lucifer.local>
 <d48193a3-65fe-4aa9-98f6-dd5869bd9127@citrix.com> <9878d90f-faf3-4853-9a79-a21b4f58ab4c@suse.com>
 <Z3iX2mNtqSYrvYPT@bombadil.infradead.org>
In-Reply-To: <Z3iX2mNtqSYrvYPT@bombadil.infradead.org>
From: =?UTF-8?Q?Marek_Ma=C5=9Blanka?= <mmaslanka@google.com>
Date: Sun, 5 Jan 2025 13:52:27 +0100
Message-ID: <CAGcaFA2Htgu8w6S_Zuz2zn3FwpaetZRbY8n0CWEdh07YfMO==A@mail.gmail.com>
Subject: Re: [PATCH 6/8] modules: switch to execmem API for remapping as RW
 and restoring ROX
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>, 
	Adam Williamson <awilliam@redhat.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	lorenzo.stoakes@oracle.com, akpm@linux-foundation.org, 
	anton.ivanov@cambridgegreys.com, bp@alien8.de, brendan.higgins@linux.dev, 
	da.gomez@samsung.com, danielt@kernel.org, dave.hansen@linux.intel.com, 
	davidgow@google.com, dianders@chromium.org, hpa@zytor.com, 
	jason.wessel@windriver.com, jikos@kernel.org, joe.lawrence@redhat.com, 
	johannes@sipsolutions.net, jpoimboe@kernel.org, 
	kgdb-bugreport@lists.sourceforge.net, kirill.shutemov@linux.intel.com, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org, live-patching@vger.kernel.org, luto@kernel.org, 
	mark.rutland@arm.com, mbenes@suse.cz, mhiramat@kernel.org, mingo@redhat.com, 
	peterz@infradead.org, petr.pavlu@suse.com, pmladek@suse.com, richard@nod.at, 
	rmoar@google.com, rostedt@goodmis.org, rppt@kernel.org, 
	samitolvanen@google.com, shuah@kernel.org, song@kernel.org, 
	tglx@linutronix.de, x86@kernel.org, 
	=?UTF-8?Q?Marek_Marczykowski=2DG=C3=B3recki?= <marmarek@invisiblethingslab.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 4, 2025 at 3:07=E2=80=AFAM Luis Chamberlain <mcgrof@kernel.org>=
 wrote:
>
> On Fri, Jan 03, 2025 at 07:58:13AM +0100, J=C3=BCrgen Gro=C3=9F wrote:
> > On 03.01.25 03:06, Andrew Cooper wrote:
> > > > Hi Mike,
> > > >
> > > > This commit is making my intel box not boot in mm-unstable :>) I bi=
sected it to
> > > > this commit.
> > >
> > > For what it's worth, we've found the same under Xen too.
> > >
> > > There's one concrete bug in the series, failing to cope with the abse=
nce
> > > of superpages (fix in
> > > https://lore.kernel.org/xen-devel/6bb03333-74ca-4c2c-85a8-72549b85a5b=
4@suse.com/
> > > but not formally posted yet AFAICT).
> >
> > Now sent out:
> >
> > https://lore.kernel.org/lkml/20250103065631.26459-1-jgross@suse.com/T/#=
u
>
> Thanks,
>
> Marek, Adam, can you try this patch? Although the reply here is for
> another future series being worked on the fix is for commit
> 2e45474ab14f ("execmem: add support for cache of large ROX pages").
>
>   Luis

Hi Luis,

I suppose you're referring to the issue described here
https://lore.kernel.org/linux-mm/CAGcaFA2hdThQV6mjD_1_U+GNHThv84+MQvMWLgEuX=
+LVbAyDxg@mail.gmail.com/T/
Unfortnuetly this patch didn't help.

Best,
Marek
