Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3172D8377
	for <linux-trace-kernel@vger.kernel.org>; Fri,  9 Jan 2026 16:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767977669; cv=none; b=Zspd5pcevojHt/bzKV2aITc+OsfzOo5wTfzTzGVifpnKppDtrN1GNEGgQDp489C+RSYbbzlKl2THiGdvqbUwm22jb34bjQ/crErkXWZ4xnGNVSNArs2Wp9i3BQwgQImL19ovrFhLjYvaPCVg5NwmeIUZUv+Eg7giz5Kcj/J0bKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767977669; c=relaxed/simple;
	bh=8Bi0wnXNNoO6BUdS0PfFuCedKJjgtAMsXms/52+KB0g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U1Fh0xm58UkFnKOcYXvhktMeMUEg30N6hmB0Y5Pk6nIC1xmV+BJynA9Nub/TiI87+eL2pWe45b2aV6ZaTQAIHhy6CtIT9+Km8e+Vb7lEEO5niXT0/lqODutXU8HRywv6o2mIlbbzYcZr3S+3A4WF3B/OI5kH+5PXGDKJsClbGYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GV4mq/zX; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GV4mq/zX"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42fb8aa0c3eso400763f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 09 Jan 2026 08:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767977667; x=1768582467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWjDb7yk2PJrpDy9G76TtUQePp9Bz/8mN/oD8ydAWuQ=;
        b=GV4mq/zXz1ObnEMRPn8wQ3e9jbWQpP4Mz2UGdM7kLKA6hwGjWHIYJEM51MBWhcUYHO
         QgBFUt5p79MAHnw37p24laOYETwgHFW8HWU7og8ftvCv+PMf8R5d+cTsc77PtoDnhZeh
         kjBwDA073b7iq2A/u7BInu1V4ux2+cXUvafHqv2ymOryyzJYjsmAceQ1wqnZvYO2gEk3
         x9bHWqH1pMXpTM+chL/sG5iCN/xmAPWOf5FcrdkNsKxOlmyBBa7qFg1hHdqISI4PI4HK
         K/MO0xAykpyGZG47QKtktYWZQf8Mv3k8AeoiO4Ut9ETi9H2VD0MWcwklHUS0gbdCOfFQ
         2MpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767977667; x=1768582467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nWjDb7yk2PJrpDy9G76TtUQePp9Bz/8mN/oD8ydAWuQ=;
        b=I5FnoW/hy6+uq1SWBtblwHrLetZsnRSx4nDfOWaIRgUJFmB/PgZlBEgHAcb6kstQK+
         hm544tF7if2Tcvp8Iy3G7DAvud0QbJg9p2SIHtAzGPxXkR7aetUWvioWseFtYlvUlQbA
         68W6aEXvplZQYR08d7dZbOxg5Anl4jeJa/BBtVoKGbo8aMcCgi2ZReKaygCicrRPj+Gb
         0Xsis1vXWYti5uWw02QoaCswPQbJ+C86lcGlhmP7xOt1qQl//EpQk3sSv5EFUgQn19Q1
         +IUx3afmdXLAHtE8uovxae32UxMBAKAUK3zkGyj6DoXJtg+gbYCFajLuxaiSoGVueaEe
         pIug==
X-Forwarded-Encrypted: i=1; AJvYcCX2FZ/lVc6b/WIdpx8HCSRYIUSTFZdNI+ow0lFKDM2ijd0432PBDh723hzotaVXjpVDA2vn1m8jRtvi/CwpluPM3AI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzuUzbKh6Tiyz/0LO5a2VdtZzBKU5MOFcDnLAxtCydS+iS/n4c
	0oA2mgE5JUFrz1N7EuMi8Q2I11jzFVUQVhb9ZcPqVTvDU+fNaHX1JZd84OLltpDw7r6r2DufG0y
	/Exqb
X-Gm-Gg: AY/fxX5DTdSnNr+vseLurB+yggK3SJNlr9iO2v8wpSpzG7jwLz97kx5TkDos9CEZaBx
	mO1ZQkbj7Wk8V3nP2Xa45ekQFLjZ2Hv6ZdxQwAij2SAwtc52SmYXDtwEljvlxXgzDfmAkgZLtvC
	D+i9/gKTbK1OVbKLhTl4VUiEUtY4DXuXMzjRiBM73FSjyFG0HdXol14270ohkhPIOd/dvaR0nXp
	WqEngi77GcVoc5qNmUr6Beq99NGKXtmWPMTqi2Y+QITTOvpLaCKDlo1+iKu99VDz52mFY5skgg+
	5ush0EZSJ8jdh0ijxEd/NGjNCE84fJO4RcKn3RrFUDMBI8rL9JlUwQqgyAn7VF6HIbyMnIeMEZI
	1gNVkVY3cRPtcPBMtfQxCWN3tAtyx7uIvp2UkrI99I6qrwfxL+yLdg75fwJq+mBNn65+8Tkjdrc
	o94E7mUN2uA/7w+y/V+IICSo3bEcmKzF6PWbuY7/SmP2Op8LqygRHFPQ0frcXO4+Fa4J2jURDvX
	JEG
X-Google-Smtp-Source: AGHT+IFG2ZorT+yxyJ5NBPvYvfTR4y6bLlncZmb9SB5fsFuF81d8MrxzFB1XL1V3NoA55qYcPCf7Ww==
X-Received: by 2002:a05:600c:4e86:b0:477:5b01:7d49 with SMTP id 5b1f17b1804b1-47d84b3377amr68838595e9.4.1767977666780;
        Fri, 09 Jan 2026 08:54:26 -0800 (PST)
Received: from mordecai (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f6ef868sm214237245e9.11.2026.01.09.08.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 08:54:26 -0800 (PST)
Date: Fri, 9 Jan 2026 17:54:23 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] ring-buffer: Use a housekeeping CPU to wake up waiters
Message-ID: <20260109175423.70ba42d7@mordecai>
In-Reply-To: <20260109111506.66ad545a@gandalf.local.home>
References: <20260106091039.2012108-1-ptesarik@suse.com>
	<20260106170405.425f469e@gandalf.local.home>
	<20260107085009.58fcffd4@mordecai>
	<20260107105137.4cf9a67e@mordecai>
	<20260107111709.0d115cd8@gandalf.local.home>
	<20260107111935.3befc296@gandalf.local.home>
	<20260108093932.252f6bc7@mordecai>
	<20260108115800.7a7fc8a7@gandalf.local.home>
	<20260109095756.13deb429@mordecai>
	<20260109111506.66ad545a@gandalf.local.home>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 Jan 2026 11:15:06 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 9 Jan 2026 09:57:56 +0100
> Petr Tesarik <ptesarik@suse.com> wrote:
> 
> > I have removed both "inline" and "noinline" in v2, leaving it at the
> > discretion of the compiler. If you believe it deserves a "noinline",
> > feel free to add it. FWIW on x86-64, I didn't observe any measurable
> > diference either in latency or instruction cache footprint.  
> 
> Please add the noinline. I went through and added strategic "noinline" and
> "__always_inline", as well as placing "likely()" and "unlikely()" and
> dropped the cost of adding an event from just under 300ns down to less than
> 150ns.
> 
> This code is called during function tracing (hit at every function call),
> and yes, every little bit helps!

I'm going to wait a few days for further comments, then add it in v3.

Thanks for your time!

Petr T
