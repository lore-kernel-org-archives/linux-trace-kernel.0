Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE553815EE
	for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 12:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778848345; cv=none; b=tpu7Ek184TC8gFAWZtxpNnhRoH6Yw4MLkch2fSUqRfDjMGNxX0bvm+b8tYKKJFX/NDbS3g42MriRgJJfcM53dL/z4fncVEHH8H4B1fbJ9iEWxDJpkNc8kDuODlK4kcZk10YRMvl6CncE5e2yhpkud/pDrx+P0asN1dQZJ5NB1FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778848345; c=relaxed/simple;
	bh=Of7ZLPaq/6ravJ5G/ZeLrIyaLyCJZRNYT6/T2Q/LAFM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvRzCfl8zCncYp2E8M9V+xAGakMMHG1PMZRObO+nHJSlYPDdrUsiIauFeowG6BomPptFjxG0Rq3uKn5/OSYj9V0lFKvAekPSEs2I9RRmk5TpFvavgNvknkzx7EMycxT4Z5FCU9JAIh2SgqwWWLmOmLD3Qswi4Wj+oW9Vpa3M8zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=API4J+HW; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="API4J+HW"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43eb05b1875so5412899f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 05:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778848342; x=1779453142; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KHm8mTrTqx/p4mqwv7bqPTURn4DDyo3QX4UkvLGKpYM=;
        b=API4J+HWHN0kCSmj4BVtukJ1RqNLrAOnIc7xu/c8V3nkyWglhVLph3GP+Y1xxOGYy3
         aD91Tm7Bij8LfULZvFt6ZRh9KJzgyrrlKE59K2L6/uBuyuiqRdDtBAEkwCSYCzM5PMEW
         ry8vWNdgQRbnrbG8XSTI5RK6Y6kv8YUkRHVCOIV+ig/neZiWSI77mI8wJMQx/TUcPKT0
         CaIfmvuc1F5/D7ZNXd29uWC633XRs1HtKCBUWIOdv+QOt6GF+ouYXfJlfXklbivbAWEr
         vEe7pNj5HXxMVJxB4xnH0bvEVYDNy2fGuaT6e79zi5TqetkaASaWHQbLiyPqC6y2uEkD
         ybog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778848342; x=1779453142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KHm8mTrTqx/p4mqwv7bqPTURn4DDyo3QX4UkvLGKpYM=;
        b=WW9zKWsb4k3KOYc7hWyBa/TdqLsURXFQ3PfRfV4t1ycgdhWZSBKiWNIAphCacgYAHK
         AtlgOdpI2cFKobQSZs2WZLuexrbmEjdATlr9oOX/RkBqSqr1I8bW9SM90isVhCSjwSS2
         77UHUlIjKhTRCEj51D5no0Jbtu1ci2qDMH9LivjNisUEBdeSZqP0sGnAfbZYJJk0O9ih
         nO6+sRrbzUYBAVltVjgtE4BVWBjZXd+ZAPDqr9C6mUAJQZ6jPBnPCTbiq3yfmFv9SsmR
         VFnaOqLKH4iI+CtwrwFrYh8znvk+XyCXlBF8MPW9YsCg03xgwd7lcwWJJKPPhKehAgaA
         IJQw==
X-Forwarded-Encrypted: i=1; AFNElJ94OcJOKekMgs2CrEEAgpeAFudn75xNbUTIqGQFihKIw3bjNRog9wTFhAQ5W6vw0a8dIpnaebeAY7ILOfE0S1+2iqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwYOOyzKqAaWEEiU50lZiMpXXfw6SfEF62KT6WXuSFwQTTFqpn
	9pXety4lAUmFwcVxSSvfSYL4YszlVlPJ9MsV563oysobLqap2i9kfxLd
X-Gm-Gg: Acq92OEO3IvN6EMkYm/t5MmIdung2Jpakj7JhLoCpo9oBlaXDaxp04nX2J2AnJpGpLN
	63Z0XzzXqFGajsiT+6h2W1dFha/c7KZ7mFHk9t6AXFbPKXseuxeJqy6wXxTkWjx1iL95TwCO5Kl
	4bZfguJMAd3ntiVxtwdQxmbl1EtuXSKgPU4SWQ3raJ7hCghWGfezzaDi5lvYQcCT+5WBxEljIEn
	Jh/QVesPbkOx3LEsG1HgbZCOM4qlo4nc9doIobfc6UHSe0ooV0UITQTHDuBYiOSFVy4KbueFOX/
	D/q5CJ0ifokd512kSI4g9ZFe3JcaYLl70kljWKetABKTllxmsPcHAEsHVjwo+2q03P/KPxcKzfj
	MNcBJhHkE2zn/4f32KFjJoS9yMkrKC65IDV+oVBPoZ/k3n5PUoaCb2+LdHtq2hm3e2lsNncW8Fd
	s4e7ir36WiVj+/lwk=
X-Received: by 2002:a05:6000:2c0c:b0:44a:46bc:e5e2 with SMTP id ffacd0b85a97d-45e5c5b3980mr4763657f8f.9.1778848342307;
        Fri, 15 May 2026 05:32:22 -0700 (PDT)
Received: from krava ([2a00:102a:4039:3341:dfc:8dc0:b9c5:81b8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe0fecsm13524671f8f.26.2026.05.15.05.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 05:32:21 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 15 May 2026 14:32:18 +0200
To: bot+bpf-ci@kernel.org
Cc: oleg@redhat.com, peterz@infradead.org, mingo@kernel.org,
	mhiramat@kernel.org, andrii@kernel.org, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH 2/7] libbpf: Change has_nop_combo to work on top of nop10
Message-ID: <agcSUowckidZEIr5@krava>
References: <20260514135342.22130-3-jolsa@kernel.org>
 <430564f1eb4e1fb284b40510811502671e4aa8ef59afadddd546e4286402f760@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <430564f1eb4e1fb284b40510811502671e4aa8ef59afadddd546e4286402f760@mail.kernel.org>

On Thu, May 14, 2026 at 02:55:25PM +0000, bot+bpf-ci@kernel.org wrote:
> >     libbpf: Change has_nop_combo to work on top of nop10
> >
> >     We now expect nop combo with 10 bytes nop instead of 5 bytes nop,
> >     fixing has_nop_combo to reflect that.
> >
> >     Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> This looks like a bug fix for kernel/libbpf integration. Should this
> include:
> 
>   Fixes: 9734c3ac2f23 ("uprobes/x86: Move optimized uprobe from nop5 to nop10")

I think it should be this one:

  41a5c7df4466 libbpf: Add support to detect nop,nop5 instructions combo for usdt probe

jirka
