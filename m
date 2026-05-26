Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DDB3BB136
	for <linux-trace-kernel@vger.kernel.org>; Tue, 26 May 2026 10:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779790757; cv=none; b=RKLVk9wCEdzYxl5g3yFi1wNEndYiIqSYBd79D1DoGmy6422ryD3k1i/S06P3ci2C7w9d1jhElfPaNTFb/XSW8yhqoWKA7cdIITV15exccoBzGS8UZUvpnltiYF0WdCC9r+5Nk9lZREbpe2YYB1RQjcsSkAsqyWSmi0LswcOZf98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779790757; c=relaxed/simple;
	bh=Mv0336LtkxkdmT3tHI8+xO/UWoOgdHGWU/88bHn1sWQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d11J80HwuzZ/uvBspIADc9SZ50BJ6BJmld8qlCAyCzW40kR5TMgw9UIDfeuBC6K+7dkd3FBHn/taLyHjYeiM0hCm7HZmoDfqJRBbGDCQcftsNLV1pKSexgeFeP3Pv5kZzr3CYGVo6CTpIlc1YiUw0sXjnUNETElFMwg6GO+3HYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8bqRsuX; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8bqRsuX"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-45ed18d8a1bso755146f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 26 May 2026 03:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779790753; x=1780395553; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ANl8ykqwWKxjIsrGaHb1jC/Kd54Mc1gEi6wPr9vgtcU=;
        b=c8bqRsuXVPLhEUSHy31/8MmgAb+fkatJKZTcyU5iKC32o8Xo4SbXRaGZNWttBHtEGM
         EnZaqJouFz/yLVfidsuu0Wpb4/B5pzMfiyV6zUxu+OdCpABRrKA3JlS0qSVnck0dhT5H
         C/SyHsqTKxVUQ4IsWybsWw3vH6WiqvkK76txhSEOwhxoUaxeSRiXcFa9kvtC3L1uppwa
         ZnahLHrvzHFuc7vGj+YGIdWF+Xlbzn5QNpizNoKi28IH/E/1QnV16eTm0fJI4RNCbcwT
         fdXiA5EqgkBYlamk2gwov0H8k0o5cWnhantwdTfwMSncMxAYY+TPJghj/DGkwNl97Jh7
         TsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779790753; x=1780395553;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ANl8ykqwWKxjIsrGaHb1jC/Kd54Mc1gEi6wPr9vgtcU=;
        b=XXtggqkuwQF8z7lVoOtobC5QxStkU8afA936fUzOwxQzb7HHaSGKEi5P1cnbaotn/q
         O72I86sRqJd2Ke+izqP36QSkwoDYIuy/phx0PownEy/jo75+vAH/JVQEPaWA6Lrm6RsN
         mgfBemnLBbC4a3JtZn4k6nJ9Dakhjiql4gI57+OKJrHUiDknbEskbOzANMIxXROLGIhC
         0UIRTt26vIqoxSYUvKpDcMHnuoxFkd08AIANVCjrkuCFLKorEy0QW1QuWB1UNWFRLJnX
         01Q2lcNK9avsPUUo1Ysh5NzGsoDFfRvW2asmdqBnthUUIluzUFJdbinN/xJfoIzgpA3Z
         Qb7g==
X-Forwarded-Encrypted: i=1; AFNElJ96TpJDbYGukCgGQXZpUPZNdCWDIWdakXyTGYHsBGS7FP0eDaYNrEWYlQIG45u24y5yUveN9oU/mmgwOsdjvkHbQzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfAKWr14nwCXpXDTxGa2bT/vUibQ6OV0R1oJE1nXMzvsHevTVV
	N3lXMKOjo9SYWJBQComMhIeHNl2+RfLrtWFexPDJncsof48dVQosHkBY
X-Gm-Gg: Acq92OEVRmo4BQRTKW12fVjMr9LeZ1N+qfCuMcU7Gzp39SWTIyBNmQy1di6zMV+qgnE
	tA7CNAHqn/qQz1vy/Z14dpOXmItlJmD255c8SyTeZsbejoPDY8nzVYtijpIK9ilFhq1AfF8WXOd
	JQep3cQgfh3K8aZXqFPKQ948FRxM+VIGENZEDC0LmeTvKbKpeb/HQctErWBXNYBZ4is51C2MdQ0
	I/7jK5H/xy8ROrEDTs7JSt8N12+dIVQdU9SJuDUw0vuyAEZtwHTcex0/KL6f1vhU3VVxkO19F9f
	RJ1AgZ5FeQVquCsfkjspDGnpTENpq3fXFQQLY5d93E8rO69wqBKK8gvHlSC9kLp52XBtiqi0EpD
	RVQJuQfZjNHiL8LcBZUCNAGQNvb/uyzzEfa9GTnQXc5Vh8Jtg00IKvsd286l4U0/LGu53Kkx8Pr
	uXFKsgKIKLkwJH5PE=
X-Received: by 2002:a5d:5d85:0:b0:43c:f7e5:817b with SMTP id ffacd0b85a97d-45eb36b24a4mr31134597f8f.19.1779790753288;
        Tue, 26 May 2026 03:19:13 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6c9f58dsm33726127f8f.5.2026.05.26.03.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 03:19:12 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 26 May 2026 12:19:11 +0200
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Olsa <olsajiri@gmail.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv3 04/12] uprobes/x86: Move optimized uprobe from nop5 to
 nop10
Message-ID: <ahVzn3lyY38Il8c2@krava>
References: <20260521124411.31133-1-jolsa@kernel.org>
 <20260521124411.31133-5-jolsa@kernel.org>
 <CAEf4BzZ+MToBKJS9Vdu=YZrX+2kRpUcmWejVhuoqhtu-ijqDAQ@mail.gmail.com>
 <ahDIVTM5WfVqiYE6@krava>
 <20260526091944.GB4149641@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260526091944.GB4149641@noisy.programming.kicks-ass.net>

On Tue, May 26, 2026 at 11:19:44AM +0200, Peter Zijlstra wrote:
> On Fri, May 22, 2026 at 11:19:17PM +0200, Jiri Olsa wrote:
> > On Fri, May 22, 2026 at 11:50:44AM -0700, Andrii Nakryiko wrote:
> > > On Thu, May 21, 2026 at 5:44 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > > >
> > > > Andrii reported an issue with optimized uprobes [1] that can clobber
> > > > redzone area with call instruction storing return address on stack
> > > > where user code may keep temporary data without adjusting rsp.
> > > >
> > > > Fixing this by moving the optimized uprobes on top of 10-bytes nop
> > > > instruction, so we can squeeze another instruction to escape the
> > > > redzone area before doing the call, like:
> > > >
> > > >   lea -0x80(%rsp), %rsp
> > > >   call tramp
> > > >
> > > > Note the lea instruction is used to adjust the rsp register without
> > > > changing the flags.
> > > >
> > > > We use nop10 and following transofrmation to optimized instructions
> > > > above and back as suggested by Peterz [2].
> > > >
> > > > Optimize path (int3_update_optimize):
> > > >
> > > >   1) Initial state after set_swbp() installed the uprobe:
> > > >       cc 2e 0f 1f 84 00 00 00 00 00
> > > >
> > > >      From offset 0 this is INT3 followed by the tail of the original
> > > >      10-byte NOP.
> > > >
> > > >   2) Trap the call slot before rewriting the NOP tail:
> > > >       cc 2e 0f 1f 84 [cc] 00 00 00 00
> > > >
> > > >      From offset 0 this traps on the uprobe INT3.  A thread reaching
> > > >      offset 5 traps on the temporary INT3 instead of seeing a partially
> > > >      patched call.
> > > >
> > > >   3) Rewrite the LEA tail and call displacement, keeping both INT3 bytes:
> > > >       cc [8d 64 24 80] cc [d0 d1 d2 d3]
> > > >
> > > >      From offset 0 and offset 5 this still traps.  The bytes between
> > > >      them are not executable entry points while both traps are in place.
> > > >
> > > >   4) Restore the call opcode at offset 5:
> > > >       cc 8d 64 24 80 [e8] d0 d1 d2 d3
> > > >
> > > >      From offset 0 this still traps.  From offset 5 the instruction is
> > > >      the final CALL to the uprobe trampoline.
> > > >
> > > 
> > > I'm sorry if I'm slow, but I don't understand why we need that second
> > > cc at offset 5? Isn't original nop10 processed by CPU as single
> > > instruction? So it will either be at ip of nop10, or at ip+10, no? If
> > > we trap at ip and in int3 handler +10 from there while we are
> > > installing lea+call, why do we need cc on byte 5?
> > > 
> > > I.e., I don't understand how CPU can end up being at ip+5 until we
> > > finalize lea+call sequence? Can it?
> > 
> > hum, so I though it's for the case when you do unoptimize+optimize,
> > then you can have cpu executing the previous lea and hitting the int3
> > on +5 offset.. but as pointed by Peter (and you) the call instruction
> > never changes, so now I'm not sure why we need it
> 
> So I missed you did the second INT3 in my initial reading.
> 
> That second INT3 is absolutely required *IF* the CALL can ever change.
> However Andrii pointed out that once the CALL is written, it will always
> be the same CALL -- there is but the one trampoline, it doesn't move.
> 
> Therefore, the second INT3 is not strictly required.
> 
> Does this clarify?

yes, will change that in next version

thanks,
jirka
