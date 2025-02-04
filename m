Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8298B20CCE9
	for <linux-trace-kernel@vger.kernel.org>; Tue,  4 Feb 2025 11:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738669487; cv=none; b=XqTsW8PDiOfFk3FQ44P/TQKJUiP6Wwo1Q6M04kWzdmAPjBklV8I1s9Bt15WUuNtLevlbGvpIF0Ovy1VRxuNiM7Wz0+inXz5cea0sWHbMbtUVI50LOG2kfheR8r1OUKPhhaasK9FhBQrJF4/s9EKFXySC6WqOLU1fsoANfzvTe8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738669487; c=relaxed/simple;
	bh=mN7tslh+i2S6HSh5V2VOg1tYyph90nCPYwFf0QHyu/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pFfeJfMQuRNFqdnR+axXdGxwsGzRMAKscO3z+nmEgqajO4O1qYGcxI1A2X03GsAU9HYJHoJoS23E5r7vOOTN6Bu3ydK3hggbbCjjk/sVNnxk4EXrg1PXToF/s9LeHmOn+ukPkRMincODEwiRuwHTFTt6k3ScNsFDE5Dk9IWO73w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AdS+m7rU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AdS+m7rU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738669484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s9iIjxxwva3fm5ewtrniN91za3PWyU6iE2xOK2M8hJs=;
	b=AdS+m7rUeMJE8fX/y4b69XwAmkYdT/0M/Q4wl8vmY0zk63fKfjqgMyfjzijaRQSMAJ2tmk
	ino4d2HsiMmmpftCfiUDXwYU0KO3uAFwUGew2s/pfkiPQx6sgIGMV5wXYkOAM6R5oe+dtJ
	JiVhUV2rCRWzabVkjOD6xbk6XKLmHi0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-BdKZ9WA9PNei5-GedFHo-A-1; Tue, 04 Feb 2025 06:44:43 -0500
X-MC-Unique: BdKZ9WA9PNei5-GedFHo-A-1
X-Mimecast-MFC-AGG-ID: BdKZ9WA9PNei5-GedFHo-A
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2f9c34c0048so1787059a91.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 04 Feb 2025 03:44:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738669482; x=1739274282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s9iIjxxwva3fm5ewtrniN91za3PWyU6iE2xOK2M8hJs=;
        b=u7pWDSa9S50Fjmqr4cMYqB/cFL1Yyt+fm+dvbMzAHqK9MZTyKFOdid02OA74hRb6ol
         UqMHUyLKXXxYMgZBbN8d96RnvxR2vkpOVU2WLZOYwYduwDiX+MoXg1tLgWAksyqNl1x6
         VGxtqffHpuWh0orLFuu31Ej3NWffReLqnx9Rv45he8s2A7AtqbcYOrc0ywOcjhcgPAYj
         MjSfQ/c81QCwBbHwln0RfZlnlw6RcoNm3FirqPHjCsBdILgcmgpIMf41BCymk2Y/x2BB
         LeiOsSr2IxkoWQnN8UssmryxRFYbwwgcB9U6ixUfn8aOkjnokKJXzBWcP6ivPS8u5JVp
         0B3A==
X-Forwarded-Encrypted: i=1; AJvYcCV+K5xc+/kALm9T/4lRG4ckjXc/9TUgGFlwse4/9PvjFBD7qFYlNu8Skp5gspLcSGIaGnpjiL9H8vKypwWXBZQro1o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7MzWMdQjSUC68GuUFZR273Ld03hiSxMjQaa1aliig81M8tuvU
	rLjeDxYf5o0TZK70t7VFsZbo2sEC5H90QmSYX7NdghQWXfHUw6iOagyLk2Cl9/7zchvh5MrWSZM
	D06380xbiJGhui8WTFbw8waojy+LCyZq/rfRhna26l8AoZ9rAaTXq7jM8lTFds9Jx/3e4ogLh2S
	RTB5uNRhHvEz9bHVT1UYeOVyIUK/dOOK9raW8nFz520FB5
X-Gm-Gg: ASbGncv7LLUzUvaQmzdUjuMeMwTlyFgnqsmkjC2hvVs04gWSbe4GO46Dggl9DZygy5p
	idpe3wFmXRqIkfSSC1Qf3XgrGGV67pMnBkM6nEvC+ElCgLdf3wehQraMoaENDEJgJJI7xVtug3S
	qcP98LC4hzGY/F0UnSm7v/
X-Received: by 2002:a17:90b:264e:b0:2ee:f80c:6892 with SMTP id 98e67ed59e1d1-2f83abb3532mr35198328a91.3.1738669482356;
        Tue, 04 Feb 2025 03:44:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFT1215YnlE/ZrpMQgdXRPpcUHi+R5LKcJT0ZErl0b04QYANkPy1LfVqSEokWJgpg/IOvaQL+JB/pyKlW4LRIs=
X-Received: by 2002:a17:90b:264e:b0:2ee:f80c:6892 with SMTP id
 98e67ed59e1d1-2f83abb3532mr35197867a91.3.1738669477224; Tue, 04 Feb 2025
 03:44:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117125522.99071-1-lukas.bulwahn@redhat.com> <20250204113614.GD893@willie-the-truck>
In-Reply-To: <20250204113614.GD893@willie-the-truck>
From: Lukas Bulwahn <lbulwahn@redhat.com>
Date: Tue, 4 Feb 2025 12:44:25 +0100
X-Gm-Features: AWEUYZlGlZEjRarXyn4DMZdt0GYLGOVYedjIdYC8RRdsZP_eC31hKcwXeaYXrKs
Message-ID: <CAOc5a3O-8wrQq3oNJC+H9ncFt0yxcm4O+QSgPk4QckF6Ak5pGg@mail.gmail.com>
Subject: Re: [PATCH] arm64: Kconfig: Remove selecting replaced HAVE_FUNCTION_GRAPH_RETVAL
To: Will Deacon <will@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	linux-arm-kernel@lists.infradead.org, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lukas Bulwahn <lukas.bulwahn@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xXXS4um3Tl67HxJnSXxxIadIPZlx1hLQMEkLTJ5cXnQ_1738669482
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 12:36=E2=80=AFPM Will Deacon <will@kernel.org> wrote=
:
>
> On Fri, Jan 17, 2025 at 07:55:22AM -0500, Lukas Bulwahn wrote:
> > From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> >
> > Commit a3ed4157b7d8 ("fgraph: Replace fgraph_ret_regs with ftrace_regs"=
)
> > replaces the config HAVE_FUNCTION_GRAPH_RETVAL with the config
> > HAVE_FUNCTION_GRAPH_FREGS, and it replaces all the select commands in t=
he
> > various architecture Kconfig files. In the arm64 architecture, the comm=
it
> > adds the 'select HAVE_FUNCTION_GRAPH_FREGS', but misses to remove the
> > 'select HAVE_FUNCTION_GRAPH_RETVAL', i.e., the select on the replaced
> > config.
> >
> > Remove selecting the replaced config. No functional change, just cleanu=
p.
> >
> > Fixes: a3ed4157b7d8 ("fgraph: Replace fgraph_ret_regs with ftrace_regs"=
)
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> > ---
> >  arch/arm64/Kconfig | 1 -
> >  1 file changed, 1 deletion(-)
>
> Hmm. There are still a couple of CONFIG_HAVE_FUNCTION_GRAPH_RETVAL guards
> kicking around:
>
> include/linux/ftrace.h:#ifdef CONFIG_HAVE_FUNCTION_GRAPH_RETVAL
> kernel/trace/fgraph.c:#ifdef CONFIG_HAVE_FUNCTION_GRAPH_RETVAL
>
> so it's not clear we can just remove the option from arm64 without
> breaking ftrace_return_to_handler(). What am I missing?
>

Will,

I believe you are looking at a tree, which did not include commit
a3ed4157b7d8 ("fgraph: Replace fgraph_ret_regs with ftrace_regs") yet.

A quick look:

$ git checkout  a3ed4157b7d8~1
HEAD is now at 41705c4262aa fgraph: Pass ftrace_regs to entryfunc
$ grep "CONFIG_HAVE_FUNCTION_GRAPH_RETVAL" . -R
./include/linux/ftrace.h:#ifdef CONFIG_HAVE_FUNCTION_GRAPH_RETVAL
./kernel/trace/fgraph.c:#ifdef CONFIG_HAVE_FUNCTION_GRAPH_RETVAL

$ git checkout  a3ed4157b7d8
Previous HEAD position was 41705c4262aa fgraph: Pass ftrace_regs to entryfu=
nc
HEAD is now at a3ed4157b7d8 fgraph: Replace fgraph_ret_regs with ftrace_reg=
s
$ grep "CONFIG_HAVE_FUNCTION_GRAPH_RETVAL" . -R
$

Once commit a3ed4157b7d8 ("fgraph: Replace fgraph_ret_regs with
ftrace_regs") is applied, grepping for
CONFIG_HAVE_FUNCTION_GRAPH_RETVAL should not have any further use of
that config.

I was looking at linux-next at the time of writing that patch.

Lukas

