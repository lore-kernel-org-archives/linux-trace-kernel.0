Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D85F2248BE
	for <linux-trace-kernel@vger.kernel.org>; Thu,  6 Aug 2026 12:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786019750; cv=none; b=YcYzwX7jgRntYE+dBLQqg8W7C7rcu6HlT7GkMBQiqCr+vZtdT3a1IqVvF92H91ZI42UAquOILjyLXlXu5Kgud4G419Aob0zYBeHCYmKnIdMdT0cSdP5R3dfNAaOllIe+5OcRn678IU7OBh4A03T7MVsCXzT5QL05TZCEsQX53/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786019750; c=relaxed/simple;
	bh=iuqm8IUhjhGQjcfwt27SIuyIUbPXiWsuLKm8o0NR6jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGc63oXbnlgSfkiua9ZtTqFZsbO12L9IId4Q2p15ASPNIc4zg5P+lUaQQvW8jE8Y28uvv99ShZNJ+femh6vt71/tlJcg4zJrNQdgXIYJYr9+qPteBSNJZVaHHl4HbsgonuqJT6Sc2PNWAmvWJt5v5BdA7rnBvQMijPVCDx6v2/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WoC3wsqH; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WoC3wsqH"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c15d111ca99so235840866b.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 06 Aug 2026 05:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786019746; x=1786624546; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/n69lRzU+/KobSt2jufolpdWS7t3iHXcIlRoKqP9Tf4=;
        b=WoC3wsqHiFCyALd27Kr1MJhldYEGJymlFlgD+PxOzP+Ocl/uAHS2+PP0UCDWft7XlQ
         KzBVaZ9/LJA76cMLnW3lqexITpEDYNiGvcR8/M9g5VzqwhZvJHARNn0c0pT/AB3QWavy
         pvBQ1akuub42DuSBaJomwgux1OlXsAwA4i6BGsiBErwwwx5SZreywaSdpm7hNBZ22ghb
         yJnWrmS/QrD7+KscdTAbyJ2hokfd1H8xVbVKkk4Edrn5mNRGJ0+VcjPP+hnHB3Rq8+Wa
         YhPyXIVqpgQ6H+7MozwsrvRowN8HM+bjHLcw7rwE/4z3XCKvJOxq6x/NMiMBHFTsIe4G
         6prg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786019746; x=1786624546;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/n69lRzU+/KobSt2jufolpdWS7t3iHXcIlRoKqP9Tf4=;
        b=hT4vvFSv4hAKsH3uypejlc1fk/AnQOy6vBDxVhUo8LO+BPhGgcCCtJc71oYOHcX4JD
         Ug1iLeHjyiSegDoXji3JI7OFK3vRnIUB87s+qLsTjw0xrkpL0X9KlUW66WFaRnaSTMLh
         tmpBtLs0+7AEL18eO2NxC3PcxB/Lc/cLXiLOQBZV/G6s6/lrDfKqOb3K44zQehipP6S0
         UREw4sk23BRjjhZY5/1OYxDP4diK0cImHF1jijHTQCAng8TKA6wW/saeSqWAM3i6L54z
         9NiXlhiAyErk9S8uUIdpvWGr2BtHlNf+6zr26eygunuiHiVRNViz1XbzzOx2Ded3GCIF
         Csgw==
X-Forwarded-Encrypted: i=1; AHgh+RrbnBgpnOPwKACF8RvOx3PQdBqU5VeW0Y/5hfnZa5GXI4783QzN+iAflgyFH1/AygWgYMWi1KYAiu1/r+8mlnWIDNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCTXLRe2qk8tEr6c3vP7ITKplbdJFrnTwEiSkHfYVAnvX0Q1oI
	e968hJCTfSktS7uobl85SzYen/uYH8bfBzCYAkS1RLpsD3lXyj7dyRVWZfP5JUtkPw==
X-Gm-Gg: AR+sD108f+x6UORAKm/1qY9bQRoxpvu+PHfA13IS5AsaSlqRk8SFvdUrClrzE2uQe2X
	CKDyIM5TY5XUGCP1nLlJWBcS06r0+BkGLh6ytoohoc+ueHtnDG9rr46963QjBMyOu3b4I7v1WfD
	gbaQXtmBdmexkPIVJkzEdKXLKTKEfCUzZqpnreXvzzr80oXo/3CpOoChVrerYwUuYupLVQ5c/MF
	3pxQpW5fjThzPWUhIZpOaBvq2YabgrjQa4RQ8KW2wfic4tF6H/Bg4W7rbeOYxfGdeaLwGD+BsHQ
	enj6VqdZ33q4df8zNc5gv8ppPC0mLWHP0jnbG3LP00ZqVyvDbV6n2YSIN0GTt5bcxmlZfb1haqc
	BBRxghag3nG8QFaFtroh+mA83baAZl/6vQy7GIdEeffXkVzXIkmC/l45dN2R/MXFGYFqJE3gDkr
	0TjgEdBbmNKUpZGvdK3CjMWawOzSI14wNdkJGxxUqIEA8S8or9EyGPNQrexR2YaIEdCJTxsi7GT
	9tvc0R8xg9zR62w0iBSUQmiWRBjPq04
X-Received: by 2002:a17:907:c00d:b0:c16:9043:7973 with SMTP id a640c23a62f3a-c2039af8befmr794258966b.4.1786019745003;
        Thu, 06 Aug 2026 05:35:45 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c203642435dsm244849866b.44.2026.08.06.05.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 05:35:44 -0700 (PDT)
Date: Thu, 6 Aug 2026 13:35:40 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Fuad Tabba <fuad.tabba@linux.dev>, maz@kernel.org, oupton@kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, mhiramat@kernel.org,
	alexandru.elisei@arm.com, joey.gouly@arm.com, seiden@linux.ibm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com, qperret@google.com,
	ardb@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/11] tracing: Include linux/types.h in
 trace_remote_event.h
Message-ID: <anR_nEDeWLYKIs7P@google.com>
References: <20260804112317.1937387-1-fuad.tabba@linux.dev>
 <20260804112317.1937387-2-fuad.tabba@linux.dev>
 <20260805165432.0118a513@gandalf.local.home>
 <CA+EHjTxZ1tBfau4eK-nOdqig1xwngzsq8YyHtiE-iAMkZpSF8g@mail.gmail.com>
 <20260806081952.5cbd8170@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806081952.5cbd8170@gandalf.local.home>

On Thu, Aug 06, 2026 at 08:19:52AM -0400, Steven Rostedt wrote:
> On Thu, 6 Aug 2026 09:43:00 +0100
> Fuad Tabba <fuad.tabba@linux.dev> wrote:
> 
> > > My ack still stands, but I wonder if we should just not use the include and
> > > instead s/bool/_Bool/ ?  
> > 
> > I'd prefer to keep the include, if you don't mind.
> > 
> > As far as I can tell, apart from the typedef itself, the only headers
> > built into the kernel that use _Bool as a type are a uapi one and
> > arch/um's user.h when it's built for the host, neither of which has
> > bool available, plus what looks like a leftover in bcache_ondisk.h
> > from when it was uapi.
> > 
> > The include also covers whatever field gets added next.
> > 
> > Happy to switch if you'd still prefer _Bool.
> 
> The reason I suggested this is because I'm not sure how much we want to add
> Linux headers to files built for the hypervisor.
> 
> If Vincent is good with adding this, then so am I.
> 
> But I rather have him give an ack before we do.
> 
> -- Steve

We have types.h already in several places in the hypervisor, so I think it's
alright to include it here also.

Reviewed-by: Vincent Donnefort <vdonnefort@google.com>

-- 
Vincent
