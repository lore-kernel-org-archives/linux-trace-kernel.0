Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983C1377EDD
	for <linux-trace-kernel@vger.kernel.org>; Sat, 30 May 2026 21:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780175966; cv=none; b=rcotcGB6m0ECL0zdfX2iRAoW7KiZoTnPwtPKBoBuXovFZXu4rhO96rFinTNLbBPL348afWfFlGaJf3UjN0+jzzhbVgpUeMC7yIn6afPT9UlD1p033BOQj20ssIKIdalyblQtP+5yy1Hy2EYeZDP2mXcA4nzL2q37YBPuUg6WVA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780175966; c=relaxed/simple;
	bh=I9Udm9Yo1c0vCK7YiKGXpVtlOK9+rwu8IYxI4GRRnrI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FrxY6NJ9gJzdFMaBUcOEYdAW4d8oluB/g3bXaeASPH3wiSNRQ+aOryYgyri5/FVF3Tsv+h3lDHrmDj3/0EC2RIUTICgOG3lWCU5yCpsADHAJG2pOXn8pKWZCbIYlSzR3M4HlQQ+vYOH0uPyp793hI1AeS5Eou4Y9rwzuuYY4Wuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GqT/J1AU; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqT/J1AU"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-45ef4223be7so961724f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 30 May 2026 14:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780175963; x=1780780763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kd8Ei42IzmODs1+3O5kaicD7KHsdMF4sqDHyZmAfuM=;
        b=GqT/J1AU+uozbSriocPLVTuOhScqImMAYooDikU13voVf1668nADunsElNFmFUvDKI
         f/a+b8nWV69qOI9Bhz+Tpq8rEVRXDfeHv1jSNpt2sX+yTm9Y5LZDi1sexEkRu9oCht3s
         8p/emWSN/OFNNYx2XD+7ls60ZgyWJE0INasUAmmMDwBY22YL8V+byWShmHnzoXVawkYR
         5N7F3appt0RSsnSAA6u01TUNPFi/lV1ovqppCOhaczOsP4DcQ8qhnxuue5YByduVg4AI
         uQXRftzqcIHVD06KFQ4OkfbCOaAZt3kwUj/aruMcGiLVYe6tLPeEZ7T8B1nTo495zIsQ
         TvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780175963; x=1780780763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5kd8Ei42IzmODs1+3O5kaicD7KHsdMF4sqDHyZmAfuM=;
        b=i6alFuf1y6b504HpfSKKfzGBXp6M2bYTXZCaWd8P/QFIolT7n+uy7s/jOmWwtHjMhG
         jya5rUbVVi4famofeSolR4MWJYa65iDDsqvtgPQ7xpt0mupewxsF0fBaieIgU9ZMCZSS
         vvX/v69RFQS+48Y/hjtBwepdKFUXiMlsoMjyhm5R3t7Ctx2W0aJEbsOwc21W1riHum/1
         +hp36gxrx953gTQOtqOKcp2Zn10s4k3YeDWpsUtZ94PneJp7T/t5c3el4W6uCjB+LXU1
         KQ2EwpsKKdC0Mx3xdTd1mKS2YkwN6mIDV8HZur09009tXgquVnOoRvhDss3aaTXKM1vS
         eyIQ==
X-Forwarded-Encrypted: i=1; AFNElJ+OElnoY5sFGIDNTSpQT9atxcETey0Vep6XNwdcBOHiLqsCOZS48lUGp8V98aHaU1wSZxXJHEBIktuKpXhwCrbLyuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGRw+K020DThF+mz/U+q0eTOPMk1loqAxcTo9D2J/mShi/4daH
	f+WYFQcomNL7nkb6cFtviSj9Dm1/c7mEItdOU1NTlzKDx13oprDiT/yN
X-Gm-Gg: Acq92OHo1nBTh55/veF71qtpWHZrJRGqAIHMgkksDdAtzhGo9nYPoUae+pDwAVSOG5P
	LfCMi8BbWdOAVv4erHlkGDdk6Bqr6qmeQjNtK0Ii81etMQo/1wjBJnmhkPqsKnLPQMp1AVZA1Dp
	tnzJQyv2VBNqr/BTtp6aAuBLGV9Qj4Q5BN5N42kTXKGzjIOKGcWx585OTnkuo31yfVtL/WMtwrC
	3X5YBf2LZ/FFzqVBE7IoKYiNc0W6eh42Bf4TsJ2wsoqRjbCQlAhAOGBUyh62uVE6XaLgMNLDo2L
	UAyXVmudVsyBbynVnefGQtWPAew1wgBtrbkqVvMZiQC1W3IMkKb0cPNt+N+XyYxM6YVnDPrQRj3
	udFXmLBUNkZo5IKddyoJNqunN5APLbLjryMKhQCgvhHo9y+dpSPK7p9YmNv3vJXxmiL0cHa8XRD
	GiafIu5GvQjZXi1whN7MZN8zKfDHD6vPdizD+YwU1iRUCLEv5S5Vc9O7yUOthadqvT99ZMMiO8Z
	EsE2btGWQ==
X-Received: by 2002:a05:6000:cc3:b0:45e:da7f:b26a with SMTP id ffacd0b85a97d-45ef6b742ccmr6735580f8f.33.1780175962826;
        Sat, 30 May 2026 14:19:22 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354cf0dsm13276363f8f.17.2026.05.30.14.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 14:19:22 -0700 (PDT)
Date: Sat, 30 May 2026 22:19:21 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Eva Kurchatova
 <eva.kurchatova@virtuozzo.com>, mhiramat@kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, jpoimboe@kernel.org,
 samitolvanen@google.com
Subject: Re: [PATCH] tracing: fix CFI violation in probestub helper
Message-ID: <20260530221921.50d958cf@pumpkin>
In-Reply-To: <20260529195134.37d4f5cc@fedora>
References: <20260524154301.21119-1-eva.kurchatova@virtuozzo.com>
	<20260528164902.1bb985f3@gandalf.local.home>
	<20260529200826.GO3493090@noisy.programming.kicks-ass.net>
	<20260529195134.37d4f5cc@fedora>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 May 2026 19:51:34 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 29 May 2026 22:08:26 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Thu, May 28, 2026 at 04:49:02PM -0400, Steven Rostedt wrote:  
> > > On Sun, 24 May 2026 18:43:01 +0300
> > > Eva Kurchatova <eva.kurchatova@virtuozzo.com> wrote:
> > >     
> > > > When multiple callbacks are registered on the same tracepoint, probestub
> > > > will be indirectly called via traceiter helper.
> > > > 
> > > > Pointer to probestub callback resides in __tracepoints section, which is
> > > > excluded from ENDBR checks in objtool. Pointers to regfunc/unregfunc
> > > > callbacks reside in extended structure however, which is not affected.
> > > > 
> > > > Registering multiple callbacks will result in a #CP exception due to
> > > > missed ENDBR in __probestub helper on a CFI-enabled machine.
> > > > 
> > > > Fix this by adding CFI_NOSEAL annotation to probestub declaration.
> > > > 
> > > > Fixes: d5173f753750 ("objtool: Exclude __tracepoints data from ENDBR checks")
> > > > Signed-off-by: Eva Kurchatova <eva.kurchatova@virtuozzo.com>    
> 
> > 
> > The only place the function address lives is in that __tracepoint
> > section. Since that is explicitly excluded by objtool, it figures there
> > are no actual references to __probestub and the function goes on the
> > seal list and the kernel explicitly scribbles the ENDBR on boot.
> > 
> > Then, if it ever gets used on an IBT enabled host, *boom*.  
> 
> That makes much more sense.
> 
> > 
> > I agree it would've perhaps been clearer if there was part of a splat in
> > the changelog, but the issue is real afaict.
> > 
> > Also, I do think this:
> >   
> > > > @@ -356,6 +357,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
> > > >  	void __probestub_##_name(void *__data, proto)			\
> > > >  	{								\
> > > >  	}								\
> > > > +	CFI_NOSEAL(__probestub_##_name);				\
> > > >  	DEFINE_STATIC_CALL(tp_func_##_name, __traceiter_##_name);
> > > >  
> > > >  #define DEFINE_TRACE_FN(_name, _reg, _unreg, _proto, _args)		\    
> > 
> > could do with a comment, explaining why it wants the NOSEAL.  
> 
> Yes.
> 
> Thus, the above change log is totally incorrect and should be updated to:
> 
>    tprobes uses a stub function of the tracepoint to allow fprobes to
>    attach to the tracepoint call site and have access to its arguments.
>    The stub function is called __probestub_##_name() and is only
>    referenced as a pointer in the tracepoint structure so that the
>    tprobe can have access to it.
> 
>    The issue is that the probstub function is only referenced in the
>    __tracepoint section and objtool thinks nothing calls it. Since it
>    explicitly excludes the __tracepoint section, objtool thinks there
>    are no callers so it puts the probstub function into the seal list
>    and then the kernel scrubs its ENDBR on boot.
> 
>    This becomes an issue if someone were to use a tprobe which will
>    register the probestub as a callback to the tracepoint so that a
>    fprobe may attach to it and get access to the arguments. Without the
>    ENDBR it will make the kernel go BOOM!
> 
> 
> Then have a comment in the patch with:
> 
>  void __probestub_##_name(void *__data, proto)			\
>  {								\
>  }								\
> +/*								\
> + * The probestub is only used for tprobes and not referenced	\
> + * anywhere else. This causes objtool to think it's not called	\
> + * at all and will add it to the seal list which will remove	\
> + * the ENDBR causing issues if a tprobe is ever used.		\
> + */								\

Isn't the sense of that all wrong?
Maybe:
	Annotate the protosub 'CFI_NOSEAL' to stop objtool requesting the
	kernel remove the ENDBR because the only references to the
	function are in the __tracepoint section that objtool doesn't scan.

-- David
 
> +CFI_NOSEAL(__probestub_##_name);				\
>  DEFINE_STATIC_CALL(tp_func_##_name, __traceiter_##_name);
> 
> 
> -- Steve
> 

