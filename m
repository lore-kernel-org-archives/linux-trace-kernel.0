Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95993314D2
	for <linux-trace-kernel@vger.kernel.org>; Wed, 23 Sep 2026 07:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790147956; cv=none; b=R9Hd8grqc6voss6pAf2+aj3Fj9xbDb91pro/NFtLAG/5EK4WZdczmypqMicLC2iNNdTqy6VeNK8Ntkz69KTzEOgoCX0nmPje8Jg1F/hhnP5WVSCUOtEyZEBReuEtWYKTRNOHXEVUirmrKYQfZJm3dFWol0p9T1uXvSVdQ0gMNbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790147956; c=relaxed/simple;
	bh=j1hCu+jY15X6BUAf4yCgLTDgQcAaaAfbVZB9aqvZ5ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KxZ/M+eASFt03RA/UtMiyVj8VjecMWhbFmCtb4c+pZUsFFy4oHWD+kQd0zfPcMaj5NA8+Gut1WFzkIgV4B6IQRa9tVnOlEulwR05J9V9tHeHuBzusGYVPviXHBb20jFSYpdZEIguLClthb6diKtBQNCTYolbOFqrGNDSODrvejI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lNLqIEk2; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lNLqIEk2"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccf3ca626so2901665e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 23 Sep 2026 00:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790147953; x=1790752753; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B/NJ/qQV3GavhIw7zMhjhCHgSAMMGQo7bvQEHRt/hLg=;
        b=lNLqIEk2H9yjM4OrsUCAKuyBGEftMZncNzQffzVSYkjZXR99e6u2IqpJirPhLWHOgx
         ID4PuSdbd1IY6YahNw5tuo3nRdJN3LvndHNr+31gKF9Gly639TdyAQdWL0WIylXYwzj+
         1ujdhUnl07VCZaqTxyaj8A0MwnC/l/2NqL9cOmouhMTe9+f5oesqgRXlJRFoMQhPSmmQ
         kUGfGmkGvBy6a/yZGQAVAaGWyeKuePDNsDQRHJVd/duOQvLPYp1VqWiOXnSXjdvZYiyq
         LXCRb4Rp5rpYeC5S2Su85zHmGNV1xthzaImtkpFGeNPUxH91JDC1ehrpSokxCPYvUvdF
         +P9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790147953; x=1790752753;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B/NJ/qQV3GavhIw7zMhjhCHgSAMMGQo7bvQEHRt/hLg=;
        b=R/oRQcLrHqFX6O4krre34EqW3o+2tQdujtTwo+WnDTqjN8+sxreXQSjN1hqEgcug9U
         t8IIVUJmfLmmDzjMJESEJTnnzaC66hkwkDN998sn/8iZSo/rj8EX+SDfiEtZrqlMnRJG
         yLQDw/LMki/XXM2fPAPP49JVA7IflKuUKn7SwC1eImJ6rCeHsOX2aBZCaPMgUvOnaYKa
         uVkBoWo1ANRAJvrP3JDtcDDzLAnP0ARJOiRUvNqRvnOGjcNvD74EnXp3TpeRYPmSjxz/
         QB51jSwon0+o3zAkmh/wJxAJLLnYVlsgSaENNxzrQZqGxSQEOiJOp+CWkjD3vcFwUsyH
         thSQ==
X-Forwarded-Encrypted: i=1; AKwUvBwcXguxD804kFgE0K8O+S4ru6lggdPAKsnnQ4f6GSmN5+n3NanjlmCUziQfgnT1Yo+I0nZm8vrmAXySb0ZgxIJ/kBc=@vger.kernel.org
X-Gm-Message-State: AFuF++nOGfBQZNxxnBvaVuVc+VzIuuY3Vz8hNo/oBlg6Bj6GNVd/0ygp
	MbcLVurUP4sKbBVup6pqRGCBOOf1ME0L3UJVGR2e1hRo+OGRH3bVSAe3dTgoZwdN1A==
X-Gm-Gg: AYBFou13H1aEHUcDilJ0CBJUzFceiE5HFvoISfxcgVdT9tx90EETLDE/EFwoV3tVm8T
	ruxuoOC+adkZF0HTtsDfvLsNH3CNQ4fa6Mb34ASTI70+THPDs+h1LyweoWmykd17R+83vCD/XkT
	JxtS3HHSfxo9wMhJ8wSr32jOfbE7Kq/Gda6e7EEA5s3UHuHshL3SzHh9+IjqVofr/mwbbcGQmcd
	LhGSgrY7Wpu/m5oiV/BcMbLbCP2CVsZyLP6iKIqTz3DydRt3EHJtNIpIA5ClpGwuj/kRv/CGcGF
	iNGPP+zd8UWCTvTAzhD5kKLmE2E4vYs9oiKXH6F+b2U+Gtnfbk0lqEFOwgLbxvu2jpSaShg8ZPw
	CTnbMyGD15rd8vz8k6mByMJ6/ky5tHCW8gmpuHktvFmZC/CLe+Uq+pv/ibdbrsZRKXjwcV5xnBz
	SjghIoVKXnwhbmZO9Bmrxd40XKu7x3wsVFzq46uHaZh7QJhtJ6guOrOxCwLi05XFAQ8vy/6BAIT
	d3kj+QDJBCmIQ3QaaL8IMBp7vZULomIHExqrAn1sthFcPPewZ/frw==
X-Received: by 2002:a05:600c:35c9:b0:49e:6777:da79 with SMTP id 5b1f17b1804b1-49fdf13e6abmr21259165e9.26.1790147952586;
        Wed, 23 Sep 2026 00:19:12 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe0c4054fsm32770425e9.3.2026.09.23.00.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 00:19:12 -0700 (PDT)
Date: Wed, 23 Sep 2026 08:19:08 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: trace/simple_ring_buffer build failure on parisc, sparc64
Message-ID: <arN9bPXyZFt0DV3H@google.com>
References: <5574c9e6-9ed2-4ee6-a2b2-fb6ee81e83a1@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5574c9e6-9ed2-4ee6-a2b2-fb6ee81e83a1@roeck-us.net>

On Tue, Sep 22, 2026 at 08:57:05AM -0700, Guenter Roeck wrote:
> Hi,
> 
> when trying to build parisc:allmodconfig or sparc64:allmodconfig,
> I get the following errors.
> 
> Building parisc:allmodconfig ... failed
> --------------
> Error log:
> Unexpected symbols in kernel/trace/simple_ring_buffer.o:
>          U __atomic_hash
>          U trace_hardirqs_off
>          U trace_hardirqs_on
>          U warn_bogus_irq_restore
> 
> Building sparc64:allmodconfig ... failed
> --------------
> Error log:
> Unexpected symbols in kernel/trace/simple_ring_buffer.o:
>                  U 
>                  U 
>                  U current_thread_info_reg

Thanks for the report. I could reproduce with clang. I should have a fix
shortly.

> 
> I always thought this has to do with my environment and/or C compiler, but
> it seems as if the problem appears to be generic.
> 
> I have no idea what causes the problem, why only those architectures are
> affected, or how to fix it. If anyone has an idea, please let me know and
> I'll be happy to write a patch and/or test it.
> 
> I disabled CONFIG_RING_BUFFER for test builds of parisc and sparc64 for
> now, so this does not directly affect my test builds anymore. This is
> primarily a report that the problem exists, not a request to fix it.
> 
> Thanks,
> Guenter

-- 
Vincent
