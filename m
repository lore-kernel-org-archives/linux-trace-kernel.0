Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D874832ED27
	for <linux-trace-kernel@vger.kernel.org>; Mon,  6 Apr 2026 10:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775473090; cv=pass; b=mbVRZ3LEspBlThQwEbFOZBE9skRlFvfov5XjtvSQxXucmEpBjs+Xmocx9bVsFSOuSiUGbuuAEOh/w3o6de5cPIknGT/woEc6uCpfivjMLWNP7xv4hg+vipRSgkWr9nHgsr/c9O57Ukw4GT9URrVlGjljNnK/R+vkXBOecrXldWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775473090; c=relaxed/simple;
	bh=KeMAFzLFrGIxkUSWTmdTJO0MCX9FTfYruj6uWs8QBjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lv8347tyd3JtlDPWEioAect4k/ejcEDoRlKqOYp170UqKDEAdc64eLD9elpm0VBAIqSYn0ZCm/X6irWprRoWDrImpIPyhbQgEevotMiBGO9D1uoxm5e0bUSU0Ddslh33doOH9Bi03b2fypN9Kt4a0wREe0YSXDUYtdcNxRud86M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PICvgEH3; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PICvgEH3"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6500040ef83so2374925d50.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 06 Apr 2026 03:58:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775473088; cv=none;
        d=google.com; s=arc-20240605;
        b=dHoTIFsQIH1KpnEY4V86ZxHpK9ubim5mR4aQo/8E7M+45JlnoPu51M9EB7JYEP179P
         7LON7y5skQkGiT76J3Ckj4gKyWGMN28p4iqrqhVeDI1ezgpYm3tQQbi9fHFzRkMyDBV9
         Z+N1xWd9XjkPnVYe0UYlUYCm4MkOMytv+8LH5Aho8XtsLqDoQcX+/EYE28Ie/JqG9dd7
         0f/jdBu921a63l4zaBMZ5h8sD6H/1TqXo17XEQ5tzQkF2cwZgKFP2ZB30ZzYsMu4/zXN
         lKemmO3pR2OikDJDMKlQ8YWd4tCJRVXGcgKd2qrO2WNnCrkXE0PK9mI+QlCgG5pZovlF
         k7yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=23p+wdS60pXtBpNvZkSzHr5OzahO/ZfsvZCv+StoNBA=;
        fh=aTNaUE5J166fhGXidY3kmUBnG4Qm2+oWTNC3q4ZEaQA=;
        b=WI31rD7JxEQMjMW2ulBWVYpWVlRSfZ7FRISXH6pPXlD72aarVHA1WL/3phhbMGtm6p
         qwxHeiskdd31/twZ/YW0sTAXA/l3bU+fXtDpmS4n/dFafNDhX+PtwoZtVYs83ZIYSI2e
         OX5FcaRp5GcPfuipypD1YZ+aYEy+rSDHW1TBRCq4p+WQQ63vuxXqE6SY3YVM/1cU9IPd
         glRIBY5cPObqZsoYAjr0QFxQzaB14QV2S/cx7GX5bpzjq+Hy5df7aXruTccknbu3JF47
         SRFVhTZLTslaN9lPa9lDSH364xXIqJJOzF0ED5wSoJQSU7TMJ3RpKv/iqE5GeO/zVMAp
         YzOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775473088; x=1776077888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23p+wdS60pXtBpNvZkSzHr5OzahO/ZfsvZCv+StoNBA=;
        b=PICvgEH3Aqo4JlF4Yn2MC+MS6TAmKNY9U0p/v0YNLFnBZJuXzixlR8UyzCFgCamAg4
         DZpQreX2d+1R8I1x+RLvHJ+8s12yedFqlomElfPovotJgmilDeaM2cQChJs9nstGPDqu
         uB6w/uGnRcy19lo0V0l8LBZ5hB8kEFqBOEC2s6Bu+tgOHF5BmIPlal1j1xK4b+Xg+jYC
         2wBVY17ffKYfgozT5f+7fEjml/kg31wr0gMH0nh/HkguiqMpfnN1sDO4yOX9OSP75Hss
         1meCr88nV3GNMi5F3e36sDMllzeAo2i0lVmUW42lZQwWkUa9rSJLW+r/XKZ7O91UAsGl
         ueRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775473088; x=1776077888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=23p+wdS60pXtBpNvZkSzHr5OzahO/ZfsvZCv+StoNBA=;
        b=Q2Rqc8FY6syGXdW3euAchDD/+Didbmk8iImBvXeObW7fn6qEvrXIjtGhRxwHZTEddI
         yFzmq6Q93KnHfRshKGQZkKQ2V42D8ryS5JijHuaygB3I9n6F8SpduZI//tOtsL9wsCsV
         Ujsd5RNyMkr2vOYljns8j1Q+Y7BR7G5TZNh4bCSb4Qu6nPD1Ca5vsxkJSHZpUSoPcKaG
         VL98u2JHW+kHPI81gajZh+zjmrQ1d6jiNIpQnbnCS/4i0T2khM+Vmp6RB/PBBZLfr6QV
         eRX6+ILTYDc8qSZ0m88gyt270fIJ5bewH/BCP0FQjfe89oUOsXUn8HcLakOzCNlJ4dfM
         WGGA==
X-Forwarded-Encrypted: i=1; AJvYcCXqxS8rO93zAh46KN7yOwvPyNbK+1eN5zHSQm2eBLcNyDs+QgVdDqV75+mU7TX//GsMHTDewr+3uX41/12WkHzZf3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLMgToU1k98DbL1vqVue8w0wXvBIRXhkaqAB2vINdttEvVbyt3
	xEarWyhdmcXhYejfXXE8KfleUtPtOqNnAV6MRzmJ1Z38cv0ugxobVrpqJjLCT1mfhanq+jf/c0a
	niojmzVq92hn7VQpfFsvtpJMq6HEKTnM=
X-Gm-Gg: AeBDies6gCz372Zk5kS1qrx4+kWLwZmikjj2mpbp+umQ3xELDm3xMDEPwfgirKMGxKW
	pMZ/8HfwV82eP63001tdlliWdPHP9FPr7ZSM9KmyFDxkh1s5ObZWehxa0QhvuSGVi9H7nqIjgLh
	6uRsiBaGhJX91+ycLqs55HVwGHZvV62tJm1HCA/SjkDVbJ0ZV2XrqHuynpe/OrhPcMrqA5usuDg
	aBvZV3hxiGA+NuR2mApTMY3CP4Vd+fIc6LmDcBIZ9u+hcgv/KniWntFGFwhi5xLz0A+1Ztfnczo
	/WHmSeMim9WpA1wLBRs6Mtz0TE7xB2D/R92eYE8osfVpd5YUiQ==
X-Received: by 2002:a05:690e:484e:b0:650:3831:5728 with SMTP id
 956f58d0204a3-650487252b7mr8448323d50.27.1775473087931; Mon, 06 Apr 2026
 03:58:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402092607.96430-1-laoar.shao@gmail.com> <adNGXfRI84mZrUSs@infradead.org>
In-Reply-To: <adNGXfRI84mZrUSs@infradead.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 6 Apr 2026 18:57:26 +0800
X-Gm-Features: AQROBzAl0BcDhENrlTb5JpJbwT_YJ16rCE4wk9DxJbKmVNmRtDNxJ6Ti_Yessu4
Message-ID: <CALOAHbBM0YNr3vozKxAwVOyBdZq5S376uwZBpfxNujhzV7cM5Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] trace, livepatch: Allow kprobe return overriding
 for livepatched functions
To: Christoph Hellwig <hch@infradead.org>
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

On Mon, Apr 6, 2026 at 1:36=E2=80=AFPM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> On Thu, Apr 02, 2026 at 05:26:03PM +0800, Yafang Shao wrote:
> > Livepatching allows for rapid experimentation with new kernel features
> > without interrupting production workloads.
>
> Myabe it allows, or based on the rest of the mail not quite.  But that
> is certainly not the intent at all, the intent is to fix critical
> bugs without downtime.
>
> > However, static livepatches lack
> > the flexibility required to tune features based on task-specific attrib=
utes,
> > such as cgroup membership, which is critical in multi-tenant k8s
> > environments. Furthermore, hardcoding logic into a livepatch prevents
> > dynamic adjustments based on the runtime environment.
> >
> > To address this, we propose a hybrid approach using BPF. Our production=
 use
> > case involves:
> >
> > 1. Deploying a Livepatch function to serve as a stable BPF hook.
> >
> > 2. Utilizing bpf_override_return() to dynamically modify the return val=
ue
> >    of that hook based on the current task's context.
>
> Whol f**. now.  Is this a delayed April 1st post?

You're already in my spam list. Don't expect any further replies. Feel
free to keep your verbose rubbish to yourself.

--=20
Regards
Yafang
