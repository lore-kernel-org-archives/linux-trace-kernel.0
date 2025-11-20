Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615712EACF9
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Nov 2025 09:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763632521; cv=none; b=JlAUeIvsDs0Pzrc0Im+cZHzymLy3lmmd6HBQm3y4HEnfOB+AmwO+CRvhDc63hn9It/WTyJTGQMZwvz1BQpU9BEz2kOg3fj+kdibV9Hp47RfDDQAhFK5sUcgCpFloz34UxqklcRuw32a5jJIv9FHmSg+uStWU1FAhcx6xNv8BzO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763632521; c=relaxed/simple;
	bh=ArxGOMiOJjMc3O/3BTttrN1R0+lQiHUEPUxEsA7xDDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZX1gWnQW0hvQowAAJuxX7BxY9w+FKKCNtJW9E0EKiFFn1Gb1kmer55LzJYyL/SwHna+tE1S3i6eVEA3tDaN8d7097nWAnooV06/AI1aERDvyLmJq7rJCNYPzllbk8rABy5GLaFswP8VQBWMmP1TKfZlO9oK4eAG4pwY1SI/tll8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BD/dpW1E; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BD/dpW1E"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47798ded6fcso3824005e9.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Nov 2025 01:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763632518; x=1764237318; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XJ1a6GXdAz13/z+frt7ZsPUiHK+rVmDTT+AWenA3aKw=;
        b=BD/dpW1ExiBfp2b5vTZEnq2TkxI5CNKExMmZg5O9nhM1Ks/bFtXdkj0cf4jx9iVxKM
         fEiEQp3xzcbrN21TU5FFG3HkWOLOWnrJsEKwRjBMG/S12vRRqqD1QyZyDWPXzpMb12Yk
         xyNuX4nUoDXL1qTK0rIUBFRH+XxsyRwPWHtrQP1vPV/ZurHd74CRDOT/jCJBif5kkGcM
         6DovtP/Y1Q6gA1+m9Z5pmi25A94gygb31r7apm9nVGM/MsXxXwcqdArLVoNQyAFdvIRh
         lIEKs/K3fDrwFUDLcyrIkzxAK1ytHdGzXtULrhdsGwJvNtMTQ4qeVaWg9dp3GX0d/pcE
         uVjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763632518; x=1764237318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XJ1a6GXdAz13/z+frt7ZsPUiHK+rVmDTT+AWenA3aKw=;
        b=dTy9HEQ1xQSbG/iokVJiIcNmFKVbr2B9+QFqaOBfHi3H56dBO4F4u2zVdK5pAXTnUL
         22AIDc0F52RIES//NzxCqKLo9WjIec+0z6r2fVQh4JK6aDSoPsWEqU0KqQ6OdfnHPuc1
         TBz/AndiD5v6Q95rAmC7+SemzRQxMFUrjwrYT8EtQeIs9Zyg1v9EHdEGSxOcOpnPZU6g
         7zA4GFer+1QfZiWnWFdQp3AWyL9AQQ1QTxp+vkVCh7zwbPnp9OVBLMJE+KRHIcVdexGz
         pRNHxs7FxH67cXC71kOQhJNivScuETPOVfQib1I+0t2x/NoeYwb5XsUezYx+WqE2ri65
         Vusg==
X-Forwarded-Encrypted: i=1; AJvYcCUbS3M/FCvhA3PIom87PV7Xq+S63QtBQVL/KjdCp8OqUdXtKluWyf8ovrQP8kuqOyP9V99fZn4jt5ADwZ+6RutV4MM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsgan1AiyYAu92wYKBMv7mS+4TOGT4n9hOfrmg41U8YVqWcvml
	u4/QQtdFbdNRxqmmX8+CD3svx0zVqt2vdA5eE83KDwMzNYaOnWwXFhkSZ/s2MwqQoN/X8v5i13y
	8oOSJbQ==
X-Gm-Gg: ASbGncuUCz95Zx3cN2PrQRJ9ZXt7fzf6y9cHjXYVrOFPZVbVkz77RpJOxYRNpzg8R50
	XkdHYiSVEpeDpqWnpdMiJWD5wLGLJMVDWfE8ToCjAVzjhbJFUm3pf+2ibOnMe2HyiHaPX+bFpGy
	hr/PHXBNvVZKnZkas9H1R5uPGYJIlGZyD3Ck8rkmCA3p99LkBlphh5PRD4Hs3PIiNLtNGCLhwaQ
	WOj00nqvFJ32AmO2GU0+K8OxdB08Auo3gdvz/qjZ6Fc6/0af3e+fDSxdSPfiSgNzZa7VrIaP+H1
	mNKabXKoMXh4WCihQzWWhlq/KX/98XkoffqpLZS0p2E1zp0BoWQAw6AMudNZnrgZs4JChIuqeWQ
	MKMIZJCfFZpe99pGjYz8MpsTdSR/FkfeLqL7lvyjjihk2FF0tvdrBzHWijw6ksjCm1kw9HgQfIi
	mZm8/it/uRVSk9RmI/UrPG+jLf4sTXdkZeurE5uevvheapIpWnHQ==
X-Google-Smtp-Source: AGHT+IFJRNp2sRsVEs1GlQW6MJTcF2zwsPsEOfrLSK/NN3A774PXikUBAOOjBZgY44x25hx3cSpDQg==
X-Received: by 2002:a05:600c:4ecd:b0:471:114e:5894 with SMTP id 5b1f17b1804b1-477b8a9b267mr18043455e9.25.1763632517489;
        Thu, 20 Nov 2025 01:55:17 -0800 (PST)
Received: from google.com (120.54.38.34.bc.googleusercontent.com. [34.38.54.120])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b831421fsm37963635e9.10.2025.11.20.01.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 01:55:17 -0800 (PST)
Date: Thu, 20 Nov 2025 09:55:14 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, jstultz@google.com,
	qperret@google.com, will@kernel.org, aneesh.kumar@kernel.org,
	kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 19/28] KVM: arm64: Support unaligned fixmap in the
 pKVM hyp
Message-ID: <aR7lggObvo-2Yrg5@google.com>
References: <20251107093840.3779150-1-vdonnefort@google.com>
 <20251107093840.3779150-20-vdonnefort@google.com>
 <86ecpurq13.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86ecpurq13.wl-maz@kernel.org>

Hi Marc,

Thanks for having a look at the series.


On Wed, Nov 19, 2025 at 03:38:32PM +0000, Marc Zyngier wrote:
> On Fri, 07 Nov 2025 09:38:31 +0000,
> Vincent Donnefort <vdonnefort@google.com> wrote:
> > 
> > Return the fixmap VA with the page offset, instead of the page base
> > address. This allows to use hyp_fixmap_map() seamlessly regardless of
> > the address alignment.
> > 
> > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> > 
> > diff --git a/arch/arm64/kvm/hyp/nvhe/mm.c b/arch/arm64/kvm/hyp/nvhe/mm.c
> > index ae8391baebc3..75014dc7d82e 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/mm.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/mm.c
> > @@ -239,7 +239,7 @@ static void *fixmap_map_slot(struct hyp_fixmap_slot *slot, phys_addr_t phys)
> >  	WRITE_ONCE(*ptep, pte);
> >  	dsb(ishst);
> >  
> > -	return (void *)slot->addr;
> > +	return (void *)slot->addr + offset_in_page(phys);
> >  }
> >  
> >  void *hyp_fixmap_map(phys_addr_t phys)
> 
> This looks slightly odd. fixmap_map_slot() should return *a slot*, not
> something in it. Can't hyp_fixmap_map() do that instead?

That was fixing hyp_fixblock_map() at the same time. I will move the
offset_in_page() in both callers.

> 
> Thanks,
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.
