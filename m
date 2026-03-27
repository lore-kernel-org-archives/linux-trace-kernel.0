Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5B7394470
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Mar 2026 22:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774651325; cv=pass; b=CPCzAk9Upva2uXgvzS+eYoutjvmpnMUNrred2WnbzE95uD5sKzAzo4QXiEh9iQzeatSnK0msDTAPqim0PQmg/GHyQ1it5mbrCvInkJ3eJqp+G9m93o96OHqnDLrGE6WGwgDgRJ6KCCMQevHbo0JQ9HGZqRY4vxjIlHaEy5uQVWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774651325; c=relaxed/simple;
	bh=IxQSSOkmxjUiH6NbONR0zkZYZXaMZrRICytjG4QVyxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PuCqJy1XGNDAdUq3gDBdOxgx4QHs9IEVKUXfBWWQL7CsBvc8qo4y6OfcjpVTcIzb2WWoCs/Vn22dGv0/QpgBaXpu+eZrc6sjvneuAYa/dbtBBJ34eTjwgUCEIr8Qwk8nNXbvc2Vh09SkpKrNfvqkw3Bm0wDYUpdiCjI7o/Yjfpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GaOjsv/Y; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaOjsv/Y"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12a695044a4so3202883c88.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Mar 2026 15:42:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774651323; cv=none;
        d=google.com; s=arc-20240605;
        b=CmYor+WmH/5gfBf+tVs46u5gjNX9JSBi0s7ip5jDnJbkhP7VbDG9zV0tu72dSiQ4qC
         utd9k0MsjDkaJ/I1L9Azq3PzA3+OxC+8XODUVh4X/K65j0bHz2HntaUHp7/M3twcLFPx
         PlHyhxbTnR5NaDJME/oWMCiiOKeJ/F8c6utpFsEhniSquTOviUMXBCzx4UkiTrQs9ytZ
         EtH5Hl+kI7rghT2nFPkFdLJdDoxMcz/Q0N2uRbavx4nPUPv38YSZQEB5+F4cPCBok3AX
         BbYfL73GJFdvUn4T8m7opbnmT3QfSl3HvWmNkNRwOYj+CoqSt3mB+eMItUgoCKLyaapJ
         TeoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IxQSSOkmxjUiH6NbONR0zkZYZXaMZrRICytjG4QVyxw=;
        fh=KRvFATtG+lCnpsVjkBcaLMcwFEaA6SiRSqICTDnUGtY=;
        b=bQrb1Rb/LAXcCNEKuPSVZqIiVhboXvCziC6xIsYRlF8lvcyDBDDdLUKIV8vggP0i7P
         5qlXzmmkufBvm5pxqkLVA5/2BtuCnEg5fAEdF8WoZG04EtxgG4cokaB7TcoJX6XvKlzG
         gmghCCvmZ6dJsl4cSDk+OZDPbWqSekRZHBUC91+Pau7OFbsBY/tYq+7Q7ib2+QT2w9iu
         tiOJADzfWJdYvIqDWqSAzdL0E8zZ6YUSw5HeyrPUsQi8c25u86KaomMKSjwi9hyUxD0L
         Z5xgOTMyCzAj+FZKtyZG6N2Ve9hDydIScsZuvn3CjOIPocyiH0VzrP1ueavKNmC02eAk
         Mt2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774651323; x=1775256123; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IxQSSOkmxjUiH6NbONR0zkZYZXaMZrRICytjG4QVyxw=;
        b=GaOjsv/Y75Jf5XKz+3p0wMoDV4OczFGFaqWJlIzc3FplfbQFh09pyvaAcHbn/bw9YY
         FU4qhoBEksQiuHNr8XTLRVkYbQfhnHnSBx78QMqbrvX110pnoN2LoKQAsSLW091oFHq5
         IjNw6UNWZzexejPZX1uyn/G8aNkrSW7jE1oA7iWHG8PXm+cKP4yT9+zFWS+UZpz3aYUD
         7YvYSSS1moQR1jhDqD/6dylgJJ5nR62OJWuPmhdTeoKN9GPtFUFzhDpr9wFMVaDzX6vl
         hP/r8SXmK3hwduu/9yWcs6Mgck8jrCjdF0TTY07OBqcoLnIFJdA8MRyOaWFzjgBtfoqX
         7WRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774651323; x=1775256123;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxQSSOkmxjUiH6NbONR0zkZYZXaMZrRICytjG4QVyxw=;
        b=KnVfhXfL6C7q414RYYukWBj6AHj/gINwTj3N3pceywn+AZJX1cX+DqypEUXcNS9SRD
         j2QuHv47LL14c5s9Fdu5jZzyNVquQ32M6zPNT6zCqHQ/AqyoCyWd1DkPcMafhJoMP6pD
         jas875vhG4BFhWYAhWCB7CwxhIWFkf3r5biLqzkWfQvs10Xdr1DxV/HDUMsHvaUt87SR
         a0Jj6XqR9G63EaORIFnk/g6dSvUeGi5i0kzzxf3iedeZ6DXRdfJVMrZZzzC3fz9a1VNx
         8cYj+aPvgH3DJLftwy86YjYXmXOQWi0u3KNFsa/zHs8KWCSIqkLialQAANyuMIdoHANX
         4v3Q==
X-Gm-Message-State: AOJu0Yw7/FYEzv25yKWDFsWDP07J2tLjXNlbW+KT1g0XOO+D4OzPftyY
	2bpFsWsOc7+msJWH0lTH1vdhB0qOzxsB8QVzWbKuGKTVVjjMcStHN8Dg7ASt3DbnyzlpULuyOyj
	F8tkZMdvjDebxh0Ecga2w/ILk1LyY/XUij141Xrs=
X-Gm-Gg: ATEYQzzpCQMcoCB5BtowzxOJujRE273QbQQr4fQpH3+ZJhfZbdyvL4wxDELUMVPIJrS
	y/KzuSfvey0qbd3gT3vhR4eCpiimeVA3gy2fyyg9Nc3ZPgOqutebQoBuvt5DrfikO/wC8rIeSLP
	wCfOZhOr+U67bbTJ4jqXH6APDxSnAXB6fuuWnsin3nIfziHRvH0B6Q31tltq9DIAbjpJ4SLAIWD
	/cLh0Xcckr3ajj4ODv5RRWpMVq5/qqJoxm9GqOpfCvNpUUd03ZeAz4wmBjwimwNHcE5wFDsgjPK
	MLpVK2QuTg+WxRNizEJ3nGDWZe3TyagwCWZ96X0M
X-Received: by 2002:a05:7022:305:b0:128:bc19:813d with SMTP id
 a92af1059eb24-12ab28d7b1amr2187393c88.27.1774651323199; Fri, 27 Mar 2026
 15:42:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324221326.1395799-1-atwellwea@gmail.com> <20260324221326.1395799-3-atwellwea@gmail.com>
 <20260327150634.5df3cf4f@gandalf.local.home>
In-Reply-To: <20260327150634.5df3cf4f@gandalf.local.home>
From: Wesley Atwell <atwellwea@gmail.com>
Date: Fri, 27 Mar 2026 16:41:52 -0600
X-Gm-Features: AQROBzBNrQWL3GPFF6jl3SgQ96HMHPRZMl5piGlughJYpNYaPtjY6bTvSCloM2s
Message-ID: <CAN=sVvzFMC1m2aGT23aRpPpoddBVP59mQBmEsQyEPKBYm3J_Vw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] tracing: Drain deferred trigger frees if kthread
 creation fails
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mhiramat@kernel.org, mark.rutland@arm.com, mathieu.desnoyers@efficios.com, 
	tom.zanussi@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

Yes,

This kernel command line reliably reaches trigger_data_free() during boot:

trace_event=sched:sched_switch
trace_trigger=sched_switch.traceon,sched_switch.traceon

On an unpatched tree, that crashes during early boot before userspace.
The call trace goes through:

trigger_data_free()
__kthread_create_on_node()
try_to_wake_up()

The stack also shows the boot-time trigger registration path:

event_trigger_parse()
trigger_process_regex()
__trace_early_add_events()

With v4 applied, the same command line boots successfully. The guest log shows:

Failed to register trigger 'traceon' on event sched_switch

And /sys/kernel/tracing/events/sched/sched_switch/trigger contains:

traceon:unlimited

I also verified patch 1 with repeated trace_trigger= parameters:
before the patch, only the last parameter was preserved; after the
patch, both triggers were installed.

Thanks,
Wesley Atwell
