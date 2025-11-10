Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EDA303A22
	for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762781218; cv=none; b=Y+Zd3NYlZjJRCefr6lu05WqwR3Jz8C3ml7OQFQ2U3oPuUvlC+KarIY01XVk7caXGtRo05ccIhhvAqh0KPMQpVMitW9nbzaqYoLd8jmcTpl7/UtrUE+RN2a3ERMSSj3r+2RNenMwrHlfEOc4vUQ5al4t+OrEfjI137HPNSbVJIP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762781218; c=relaxed/simple;
	bh=7zBlKI19nm4l57l+GSpU34xDjL4DbJLxfBwZWCrg3No=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wu07nGpzMrPbrVpM0IrD14+vgG2OUfjlpoVu70OYtklo5/bOTDb6dKz9cagI2Ij6DELnnNxjmtKTiXcPoSuBN80jlzmDqkRyt2rNEmrqH4qhsqkEVFCVm8PTqDNTYJoUBEwMsLjKfTHctnVvT9bhniT/OA6mV6tnBXnisnLqGis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E5qqUFsl; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E5qqUFsl"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b7277324054so431904666b.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762781215; x=1763386015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WhaZSZSH3JxixsGOb3+NSOpxTTK16V/bDeAhAAUpFzE=;
        b=E5qqUFslVJXWPHhafsxsLihzT2Hp1H7ZL3bmTpHc1vF2FQcxh/aQ06ldMfj/Vuroos
         6hElXI3/nIMU2tmAI7rb47W4ouuJ2zEDvb8xbb8ffZIju8HaIU51HE4S6tnw71CNQ3Bf
         SgKBbPLG2cJ7UoeLIsWfFCk78xyOgWyvCGN2fFCZjODv9YM0tjvAzWt8o0pPmpRbmKjq
         5gvS9Pg1mDvRrHYdnSJIGr093yv9UAsFVNVIGZbrH8Ga2I9QDAIM+z0ttJolmmxcgcpQ
         aZjjcynCrC/094+Dg13xfDzZR5iiIEW/g6WMD43PJ1HEEajIHDCWJfXyimpxSn2TnjQ4
         JyOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762781215; x=1763386015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WhaZSZSH3JxixsGOb3+NSOpxTTK16V/bDeAhAAUpFzE=;
        b=Lfe3V0y/9b7SnWbVyyy0FkASzUVepoa06MUZTy8C6/UxQXLr4JTNIfBGmLDJdn6uIQ
         Yyx9SkYyOBX3Gz+jihfzP0lrDv2hudoOMqL9X2MjApXINyFpou1lonIdtMi78pFIWEOQ
         h9r5gngaNS+t4YOf9GIqbXRbW1a5RQEcrE9qT5IPdbnBxCtCRN9SiNX34Ze7bKfXZa0P
         wtebZFMtspLQdFAwOkY/nIKEvEZ71qvQsRtwYihNvKimDyAxN11emzKyZgd0sk+lZSxC
         qAtjpC6LlQ9gZhqUqIOCBaUykQ2OxfEr5HZxQOS5fQ/SoOv+4oH5TIzwIHOdBGgu74CT
         q9JQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkvu+CbPWQ/CI+JveZZLyYQLoDmSfoVhxIrt65Ng0gN8FOJg8P21Gy34+XzLul6Zr93+FRIHrfUkHTV6AWelmgQ5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSK7TBbyuKr1DyrrCg0rSZKi1nl/nCKM/tFZ7TQMeHWZNFsxWv
	3oIFrj0gjZWpILtSAf3jMQ/EGvfJtrOk7XJkbdNvktnu9n4Jcr9n1y4155rb3gSpktU=
X-Gm-Gg: ASbGncuqtcOwGHribmGglFZ34ONL3qNUKZsrNBymCD34mRPzBahE9lDDUIRIpRJqbJ4
	nDCunzYl6mXQfV/3EyYpedocnE01JRURZD6sye7WCsCrM79MfXlnQDoh0Yae6hiFIoER6JPG1rD
	evMfj2t/NI4HF+LojxppbXkVx+TVed+jkpEJW0n/8y6ZYIy7f+yLyf++OL6ZRqq8ayqxjU5AljF
	SgWJmfcR2HkBEjkX/as38DjMM4148ratbUEQz+We/H75fvep0O5iM2LwJPTP86Wp9ml7HRdjMFE
	5V9Q7AFj58STgcWQndQxk8sHnLlgVAPv/PAGCkMthUf+N378iF6LmK5ZaV5VamTVFH4X5d9GaC4
	Kp9aDA9CpQjXwgPWUjOuphxUPpy8WMrAfJRq28pE+LcX8Mn5c/jpMxK9hp4IWzZc1xRJsct7LFV
	BsamgFaFl8LMgXcA==
X-Google-Smtp-Source: AGHT+IEFvin7sLruegH2ZxQ0SW44BHRX6xFr54ZAVGaHqC0y7M8M930cBHeCWlcadsxgJM1CQZ9cXw==
X-Received: by 2002:a17:907:7b96:b0:b40:fba8:4491 with SMTP id a640c23a62f3a-b72e0310d6fmr928514366b.17.1762781214802;
        Mon, 10 Nov 2025 05:26:54 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97d43bsm1129492566b.45.2025.11.10.05.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 05:26:54 -0800 (PST)
Date: Mon, 10 Nov 2025 14:26:52 +0100
From: Petr Mladek <pmladek@suse.com>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: Petr Pavlu <petr.pavlu@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] kallsyms: Prevent module removal when printing
 module name and buildid
Message-ID: <aRHoHMJYAhSoEh1e@pathway.suse.cz>
References: <20251105142319.1139183-1-pmladek@suse.com>
 <20251105142319.1139183-7-pmladek@suse.com>
 <kubk2a4ydmja45dfnwxkkhpdbov27m6errnenc6eljbgdmidzl@is24eqefukit>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kubk2a4ydmja45dfnwxkkhpdbov27m6errnenc6eljbgdmidzl@is24eqefukit>

On Fri 2025-11-07 19:36:35, Aaron Tomlin wrote:
> On Wed, Nov 05, 2025 at 03:23:18PM +0100, Petr Mladek wrote:
> > kallsyms_lookup_buildid() copies the symbol name into the given buffer
> > so that it can be safely read anytime later. But it just copies pointers
> > to mod->name and mod->build_id which might get reused after the related
> > struct module gets removed.
> > 
> > The lifetime of struct module is synchronized using RCU. Take the rcu
> > read lock for the entire __sprint_symbol().
> > 
> > Signed-off-by: Petr Mladek <pmladek@suse.com>
> > ---
> >  kernel/kallsyms.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> > index ff7017337535..1fda06b6638c 100644
> > --- a/kernel/kallsyms.c
> > +++ b/kernel/kallsyms.c
> > @@ -468,6 +468,9 @@ static int __sprint_symbol(char *buffer, unsigned long address,
> >  	unsigned long offset, size;
> >  	int len;
> >  
> > +	/* Prevent module removal until modname and modbuildid are printed */
> > +	guard(rcu)();
> > +
> >  	address += symbol_offset;
> >  	len = kallsyms_lookup_buildid(address, &size, &offset, &modname, &buildid,
> >  				       buffer);
> > -- 
> > 2.51.1
> > 
> > 
> 
> Hi Petr,
> 
> If I am not mistaken, this is handled safely within the context of
> module_address_lookup() since f01369239293e ("module: Use RCU in
> find_kallsyms_symbol()."), no?

The above mention commit fixed an API which is looking only for
the symbol name. It seems to be used, for example, in kprobe
or ftrace code.

This patch is fixing another API which is used in vsprintf() for
printing backtraces. It looks for more information: symbol name,
module name, and buildid. It needs its own RCU read protection.

Best Regards,
Petr
