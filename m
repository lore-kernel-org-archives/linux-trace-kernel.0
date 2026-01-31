Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A212BDC29
	for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Jan 2026 16:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769876204; cv=none; b=uN1UnoUGMLmuuUu0CQX6Iw1NgPJ7esRUWs1dy6fED7LVhkFnS8gt3EfjovlAuHgzGMU8oDd6Cf9SYRay2NE4+2RHuklddIHB2Tn3A0JEVB8Wc38Nn2GCiTFF4SosXx5ZyVmefcKpoFZe8alNdRkfHFI1XZYbXFo5FRPH6ZBvxCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769876204; c=relaxed/simple;
	bh=VK9Pa6bSVZ2wX0vSxdh8PA9o16ssgUDKLaI9IEgywCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p50aTQUgchhGXce0Uhvgt3Vmy6CZYqWE/JkaIQwsN/ozJ6jutn6jqUkQW9Fj4j1NxaNvObLecpo3D75ILw5uH304DXr7iNXf959ElQHICUmpy86TeOVxxRH40Xq/RN8ia6hG1bphK2E+QrkpALiPui2MKqRWh3YZu/mpGxZLE8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJ7OVUD1; arc=none smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJ7OVUD1"
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-89461ccc46eso50823696d6.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Jan 2026 08:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769876201; x=1770481001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nZdfjr2YBB6Bg1S9gnKxkULsiC0x83ebbFEXgtKWVOQ=;
        b=NJ7OVUD1pA1QKFXc0lzZ838WyFQeOg3YXndf9vksmchuUOqZKypnHvk31JP5bgWjRo
         EbK1NhXf++9002Y3mV6KZ4EZdBhNi5+p0koURPA4t2QRuQm+RDd9cmweb9WJ9nZNFD9a
         9+qJcYR5MHm10hjHuyupmeUO1ONgqra2HjFL3BLp10dsk7O9R5tp92JmaIaBVylUG0HG
         Ju/aFZVBFAkyrJDUc3wjHuVTQo+d0j5alKTlwW5ptlumLOmDgmx+W/13+L6FwdTOCOOY
         RSBskJ4IkmnPjCFZqtLDv6T+RbHuZHDXKE7dkKp0qLClytN0WDE3bewrko7GCqMt+IGj
         R1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769876201; x=1770481001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZdfjr2YBB6Bg1S9gnKxkULsiC0x83ebbFEXgtKWVOQ=;
        b=b6gpEQlkD1UreE8yIByMyj7QGO3PjXZMk8nPVnzv1+DndxBL5B67HS/0CscYOQ+hbW
         GOS41r7KnvQDs733xTn3pzneMfUJF5hMuZlyizcF1ipgkux1sP+j4oskve+t4Tba83Oc
         084e2ExUvmDugThQyN0KPDEoLUdFy8HeGNZxc/vwfnSRN8PWHAI7c0W/vG60tNrU+ph8
         Ul6K3Jgfb/mVVKUqdvEdrTICKtLGK+on9X4Avw4vgVJiyHPPIVXbmi+AsBe3ibtAwUff
         7sCzYMuGtiEnceKxWomfGbCultvoPhsKip672I2/ZiC42scBjIQNSPR/6PHAeny9Cnlr
         EG0Q==
X-Forwarded-Encrypted: i=1; AJvYcCV1rVFr+QqUY+VDgYdZGln0DXrfhutIf8oFcMden2yZFXO5fNZyQQxJfCcmS2UfgADGxtXT74WM76uEyIN4E6HR6as=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXs5JE0ek8+1UnF3NgnKJpN0bFt0Epid06qw0QgXBly8wOgHYS
	mnCUPOjcD8Yo4pgM8DLwsYxotEPe1XocvXGBqOh8jwRB5mo0dspCbuEl
X-Gm-Gg: AZuq6aJz7UUtg26BPDOBKGN5IQSgQrdNauT25XGGr2KCGsjkkZIeFZX+2O7Llwa+8Ql
	MWC5Cf6X5DMQLjVXtNbZvOu3bPG+HnRnqdAlpXIek5fW708BH/JpVtfGICT/wGMUD1f/E/ZSiDG
	rBjmfEfV4x3nLXTx0/9OegUzWrlpdn9gVaHz7gFkNaRH4+0Hsj0mU3GK+wYmqhOGIVUspGdN5F8
	2EQ7sZwpXF/NjL0qg1a7HNiA04OeZ5ioya2I4py2gJTgz8tjC4EpH60H4hvaahHr/YVEZOmM/op
	iRvfxzNpaCcLGCL+xAYB5sUJdc8xzxY/qfFVJB6no6A3mQso3ufk5q3pXB/MssA2qolp/gUTkhW
	bAuVhrRlKRQmJRRMriYNR/EupMV8xK3tJoAr4E7UpA2rNri3yJ5ua/X7kEjuFCUScB4Oa3Hmp+W
	iKgKTBXhVbJzdS1PGcH/zLdaOytCTIr9XwzDzWSjogUJI=
X-Received: by 2002:ad4:594c:0:b0:894:7322:f1c6 with SMTP id 6a1803df08f44-894ea036009mr91543476d6.34.1769876200574;
        Sat, 31 Jan 2026 08:16:40 -0800 (PST)
Received: from pc ([2600:4041:4491:2000:27cf:ceff:6f56:5b3e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d37412d4sm84497356d6.36.2026.01.31.08.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 08:16:39 -0800 (PST)
Date: Sat, 31 Jan 2026 11:16:37 -0500
From: Seokwoo Chung <seokwoo.chung130@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, corbet@lwn.net, shuah@kernel.org, 
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 v5 1/3] docs: tracing/fprobe: Document list filters
 and :entry/:exit
Message-ID: <ttsritlbnf5tpqvwcje3wgcjiri72thxo56c7y4ppjkpnw2c2d@tjvwfmxh2c55>
References: <20260118011815.56516-1-seokwoo.chung130@gmail.com>
 <20260118011815.56516-2-seokwoo.chung130@gmail.com>
 <20260120155340.2dac7fab@gandalf.local.home>
 <wqpijkdwziafpuci6js5mtfzro46bre4z7une547crcdzrlm67@kd4fgea5m6ov>
 <20260129093508.5064b3782a40811cbcd8cb7b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129093508.5064b3782a40811cbcd8cb7b@kernel.org>

On Thu, Jan 29, 2026 at 09:35:08AM +0900, Masami Hiramatsu wrote:
> Hi Ryan,
> 
> On Sun, 25 Jan 2026 15:23:17 -0500
> Seokwoo Chung <seokwoo.chung130@gmail.com> wrote:
> 
> > On Tue, Jan 20, 2026 at 03:53:40PM -0500, Steven Rostedt wrote:
> > > On Sat, 17 Jan 2026 20:18:13 -0500
> > > "Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com> wrote:
> > > 
> > > > Update fprobe event documentation to describe comma-separated symbol lists,
> > > > exclusions, and explicit suffixes.
> > > 
> > > Usually, the documentation updates comes *after* the changes.
> > > 
> > > -- Steve
> > > 
> > Thanks for the comment. As you noticed, I sent another patch since I forgot to
> > put log. That said, please let me know if you want me to continue on this
> > series. My apologies on the ordering. I noted after Masami mentioned but I
> > misordered when sending. Thank you.
> 
> Sorry for replying so late,
> Can you fix the kernel test robot's error? I think it is almost done.
> 
> Thank you,
> 
Hi. Thanks for the reply. I will fix and send the next version.


> > 
> > Best regards,
> > Ryan Chung
> > > > 
> > > > Signed-off-by: Seokwoo Chung (Ryan) <seokwoo.chung130@gmail.com>
> > > > ---
> > > >  Documentation/trace/fprobetrace.rst | 17 ++++++++++++++---
> > > >  1 file changed, 14 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/Documentation/trace/fprobetrace.rst b/Documentation/trace/fprobetrace.rst
> > > > index b4c2ca3d02c1..bbcfd57f0005 100644
> > > > --- a/Documentation/trace/fprobetrace.rst
> > > > +++ b/Documentation/trace/fprobetrace.rst
> > > > @@ -25,14 +25,18 @@ Synopsis of fprobe-events
> > > >  -------------------------
> > > >  ::
> > > >  
> > > > -  f[:[GRP1/][EVENT1]] SYM [FETCHARGS]                       : Probe on function entry
> > > > -  f[MAXACTIVE][:[GRP1/][EVENT1]] SYM%return [FETCHARGS]     : Probe on function exit
> > > > +  f[:[GRP1/][EVENT1]] SYM[%return] [FETCHARGS]		    : Single function
> > > > +  f[:[GRP1/][EVENT1]] SYM[,[!]SYM[,...]][:entry|:exit] [FETCHARGS] :Multiple
> > > > +  function
> > > >    t[:[GRP2/][EVENT2]] TRACEPOINT [FETCHARGS]                : Probe on tracepoint
> > > >  
> > > >   GRP1           : Group name for fprobe. If omitted, use "fprobes" for it.
> > > >   GRP2           : Group name for tprobe. If omitted, use "tracepoints" for it.
> > > >   EVENT1         : Event name for fprobe. If omitted, the event name is
> > > > -                  "SYM__entry" or "SYM__exit".
> > > > +		  - For a single literal symbol, the event name is
> > > > +		    "SYM__entry" or "SYM__exit".
> > > > +		  - For a *list or any wildcard*, an explicit [GRP1/][EVENT1] is
> > > > +		    required; otherwise the parser rejects it.
> > > >   EVENT2         : Event name for tprobe. If omitted, the event name is
> > > >                    the same as "TRACEPOINT", but if the "TRACEPOINT" starts
> > > >                    with a digit character, "_TRACEPOINT" is used.
> > > > @@ -40,6 +44,13 @@ Synopsis of fprobe-events
> > > >                    can be probed simultaneously, or 0 for the default value
> > > >                    as defined in Documentation/trace/fprobe.rst
> > > >  
> > > > + SYM		: Function name or comma-separated list of symbols.
> > > > +		  - SYM prefixed with "!" are exclusions.
> > > > +		  - ":entry" suffix means it probes entry of given symbols
> > > > +		    (default)
> > > > +		  - ":exit" suffix means it probes exit of given symbols.
> > > > +		  - "%return" suffix means it probes exit of SYM (single
> > > > +		    symbol).
> > > >   FETCHARGS      : Arguments. Each probe can have up to 128 args.
> > > >    ARG           : Fetch "ARG" function argument using BTF (only for function
> > > >                    entry or tracepoint.) (\*1)
> > > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

Best regards,
Ryan Chung
