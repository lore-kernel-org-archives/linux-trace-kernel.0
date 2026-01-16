Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B08334107D
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Jan 2026 16:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768580737; cv=none; b=l6QUPnCnecVKh5I8+8weMkQvOttGrLYb8bGkDiaCvdC0omCPteFi67is3PVLgT2wiSkNXRy4GsFdyf6rPOt51DyTY451A+eqbKgBUKZ8JvTHU3VgiNvaeYSvxAQMF42UON3eaNjO0PqUhI/KZz6AhE9ShJLT+RNjRh2cIx/6BXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768580737; c=relaxed/simple;
	bh=dOKj0/JK7OfvnTn0dixbyXshDUTrP+3ndLaxK3a9PWo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYB/BXaikxRqyqlEfgfmwWCghMb2q1NV6coyuomXaWaVxh0dKNWjLL29rb7VbrPaimf2yvxE+yZmQJvVYT9tlUXdhZ8WpSOLnjJdfgqHomLS85xNwcwG+sD3p7dI5xdFuBsLiXu3F3HFY5UKuHdtlDS0CTSdg/K9q0MGJGJrdIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcrL0aEv; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcrL0aEv"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-480142406b3so10909885e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Jan 2026 08:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768580734; x=1769185534; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vvgJzVvJv7PbyEtTqGfnd9wooDAN3oVwv00PlCPZZ2c=;
        b=AcrL0aEvytlNQWXUuRUxGYiS/zZSJSo/ugnf2pBLntmt5vIgRHS4ySffKvdArYy3EL
         jvs61HcLTIDVfAfMrgZHSU9HY9nLUQOhnIcxlYfPihYxqKFgPuo8aOc7PjfF3Aigfzc9
         smOh0DmZScbAJDa1IiYLu3mKWi6k/dzxX9yLPWf30UfcTzliAYFRX4IZYH46fjJryShA
         wG2PVKdFbMZqdAfoe//BBnoCCB/h7fAPXFXE0vg4wvdrNiq8vxitDplEBoLr74yVWllZ
         +w65oIdaYcMMksXUyw2ne1E0cY8bCZVjq/Aux2Zn1x/WEcaZM3EB7wBk4okywhZXb+Fo
         e+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768580734; x=1769185534;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vvgJzVvJv7PbyEtTqGfnd9wooDAN3oVwv00PlCPZZ2c=;
        b=mImV3tsslNRxPLsGXVKcqgjqOVMiTIAOeTUfgLV/KdEI5toM41tVRYna4G0hZpHsAa
         oaq5RFYLDWQbl6ETv8S9vFwz9U5sAw6rzQRayuGocb1yfEvFbGeKiT6LfMu9gqhWHJyw
         zuc5waUNJAcCL2ABp/wYewwjkDKw0Z5cWDTwKJQF78vZTXBgpmI/2ecmUOdK86vOCCgd
         6tv2tls6Q9NxNLYb1s+plZxA/an+4RSl7CmtxMYwYWT3e48maoK0sOAYqm2MGJNjVB2W
         LgBz1Oih5IVZhje3X0QAvUp0uCD4dlQY7gY5oGJM3jmiBQambM8lwbjdEgOIpzCMCEmG
         mPsw==
X-Forwarded-Encrypted: i=1; AJvYcCUvezQq4nnUdlTaVUcjrUhMc+CYOgWk/Bm+Di1p6FF7uysgOynPiRQyCOQXJZZdf0YuS9eNnAh5H/P2nGx8Ex7jnDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2bzS88DTbqk52wOLcUApXTsPapEmRKZLY1GVne6TGrM3jQVzu
	H26UDE654st8uh7kek+R0Cn589gfW2CcH2L4dxMjj0u4OtiTK+FVsNo5
X-Gm-Gg: AY/fxX42EwRELrHZM4KdezgcnZhQZHkbDn/DoNqPjyJDKbt0fCxK6PIzbkhAIHzbfa5
	tV83PYTxhLCH6+yQ1aIoxKF69n8owO+5Pxex8rHIgyiAiH3iAF9hzpExmxathjmHwVMzhmzLYBX
	8LbD2NrqowwF2DgnNuNeeOGqldEVHAfAACmtK+/JcfKlwtX1089eojjXQdthIrNZA44fZCy4UUj
	dHujTTuSVhIs9I3ZAn0E/gY3rpR2+vdJBPjC6a8MY2jiDvj3mzbEHETobiXykckyzg30VF3Z1D9
	XbjrRmiu4F3asp8IzA2TmozoeSWrprvcifbwyeUjCnbPOTdG/SBqaFc7elxQohMJwDf65yWQCk9
	tkNdTFaNn9degXr237e0IBE9sJo0d19llz7dm6Dn2OR8vczMOzCMFxj7fPGhxfYSxwhb2JHG/mQ
	OJe4o=
X-Received: by 2002:a05:600c:1f12:b0:471:14af:c715 with SMTP id 5b1f17b1804b1-4801e2fc37bmr38539825e9.3.1768580734380;
        Fri, 16 Jan 2026 08:25:34 -0800 (PST)
Received: from krava ([2a00:102a:400f:3ccc:ffd6:980:bac0:cb06])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e879542sm53017165e9.4.2026.01.16.08.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 08:25:34 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 16 Jan 2026 17:25:31 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Mahe Tardy <mahe.tardy@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next 2/4] x86/fgraph,bpf: Switch kprobe_multi program
 stack unwind to hw_regs path
Message-ID: <aWpme7kBw9xyzRFP@krava>
References: <20260112214940.1222115-1-jolsa@kernel.org>
 <20260112214940.1222115-3-jolsa@kernel.org>
 <20260112170757.4e41c0d8@gandalf.local.home>
 <aWYv6864cdO2PWbb@krava>
 <CAEf4BzZ-sPD4UZF-TL2ep-zQOyeOC3K5XC2o3Gsx4Q6XpN-zQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZ-sPD4UZF-TL2ep-zQOyeOC3K5XC2o3Gsx4Q6XpN-zQw@mail.gmail.com>

On Thu, Jan 15, 2026 at 10:52:04AM -0800, Andrii Nakryiko wrote:
> On Tue, Jan 13, 2026 at 3:43 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Mon, Jan 12, 2026 at 05:07:57PM -0500, Steven Rostedt wrote:
> > > On Mon, 12 Jan 2026 22:49:38 +0100
> > > Jiri Olsa <jolsa@kernel.org> wrote:
> > >
> > > > To recreate same stack setup for return probe as we have for entry
> > > > probe, we set the instruction pointer to the attached function address,
> > > > which gets us the same unwind setup and same stack trace.
> > > >
> > > > With the fix, entry probe:
> > > >
> > > >   # bpftrace -e 'kprobe:__x64_sys_newuname* { print(kstack)}'
> > > >   Attaching 1 probe...
> > > >
> > > >         __x64_sys_newuname+9
> > > >         do_syscall_64+134
> > > >         entry_SYSCALL_64_after_hwframe+118
> > > >
> > > > return probe:
> > > >
> > > >   # bpftrace -e 'kretprobe:__x64_sys_newuname* { print(kstack)}'
> > > >   Attaching 1 probe...
> > > >
> > > >         __x64_sys_newuname+4
> > > >         do_syscall_64+134
> > > >         entry_SYSCALL_64_after_hwframe+118
> > >
> > > But is this really correct?
> > >
> > > The stack trace of the return from __x86_sys_newuname is from offset "+4".
> > >
> > > The stack trace from entry is offset "+9". Isn't it confusing that the
> > > offset is likely not from the return portion of that function?
> >
> > right, makes sense.. so standard kprobe actualy skips attached function
> > (__x86_sys_newuname) on return probe stacktrace.. perhaps we should do
> > the same for kprobe_multi
> 
> but it is quite nice to see what function we were kretprobing,
> actually...

IIUC Steven doesn't like the wrong +offset that comes from entry probe,
maybe we could have func+(ADDRESS_OF_RET+1) ..but not sure how hard that
would be

still.. you always have the attached function ip when you get the stacktrace,
so I'm not sure how usefull it's to have it in stacktrace as well.. you can
always add it yourself


> How hard would it be to support that for singular kprobe
> as well? And what does fexit's stack trace show for such case?

I think we will get the bpf_program address, so we see the attached
function in stacktrace, will check

thanks,
jirka
