Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F23D3A544C
	for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Jul 2026 19:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785439956; cv=none; b=q0abyhi7gLZC11G/xcTFBEyKTihOQu7J2F5qePWLysN0+5+OrQ+Kh9KanhU1yddbMO+HA6WRtlMhs4mDu43g6bN6eT6Cct2o9AnWNzVQaD6ANJv4GMjZzZefGtoXbwVkKdnq8mHz7bkh6oIyLei4Y7UXdETfsLn3wxPHLxMolaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785439956; c=relaxed/simple;
	bh=FVAkC+7LmP1MK7FCjI0hOZYPokCItuic/3GUX2deHnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5dzES3zl8U1dkEy0ej1/qX2P6wtFmoWq7QeosarhkcgnwvB+FLwqem5mBAWlvGwIb/uWseqV0WbDvPAcPgSZZLJWZt0h0CDHcnxAJQuiKH2uzXWCcVUD3Ry0cehqSAKCYhJW67zX8iK0IjLeS/7nxtnPhMcw7Os6aSkXXRGfZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTpPxLKO; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTpPxLKO"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84e0688b859so183497b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Jul 2026 12:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785439955; x=1786044755; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OaufhRrPIIlGU9PSko9eDMbVVZpm59g+vXiWTKqYEnk=;
        b=hTpPxLKOmjxEBxZIbXlISDB67vb3LXTvkaiLrFf3Qdw5GgCI+YBZrQJhwiqNGv5NLO
         DRNe30lgtdmBiQDx/Ckpm61JAtewMTB1IbkdCiaoNvERqpzhtjbkBKYugO9w45Th6Vi4
         Ckj6aqh/UhfWmIaosgYk/OqPzVv7XFlub/1LMVhicr/u0Fz8F78eAaFDb3IK+rYi0mZY
         P62T26yX5WfhG6OjdDj5pLPrdM8DuR3dlo8Kk2Mjy5c1JQbOp6C344rVYjm8pllFqjgI
         wiC47WrgWLSkZRY+RvRTCMWcyUViDAQAZOJXB1ifyZdoCdmRVe/jRYHT0/JVJgtI4cC+
         VN1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785439955; x=1786044755;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OaufhRrPIIlGU9PSko9eDMbVVZpm59g+vXiWTKqYEnk=;
        b=TVmuMJWkaBZwK0W9ASh2vG25PGlp35XYn5zRWqZFvoIYgeMf1b/KyN3Ogbb2xFTEOz
         F/ehN6pW0gRiOAgHs9y1NY76kX+hIYxhR2GCTRztu03Yj5fS1EgQef/nhV5+Nl8egHUo
         FcCrKOD97VTrSGXUw5/VJrtkhIQ4H4Pk8aTNGYF3EW/5X8BCYXJj7FHgwEBKa+++egs7
         lHgAFMccL8TM2+qGD2B1D/O8xC1m3tZx8bo5XEAsXcGd5efgC96XH5IQPK+HhW+nNfv7
         4zNYXWP7P1Q3cJLzgqDMPHLKzGKmoRg5TyyNS2eHFKVZo/etMTTu8bUwdGrVLpEtQook
         tsSQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpi9K3uHjtkQZRRWNEudMaqyMRWsctDL3V7C4XeGBqDd0GuU2BWjlEdo11B6GiBpPHJkFakASBwm51mLyd8XASgwzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvzdQdxYauaUr1K0N9bUUyILkO1m+xv/+GNFJoTHtRZJykWGnt
	UiopcbHPXoQEfGgR53EagjS6wJvl2jq0kmVvyZ9dwCE0gni/VqSmRuwo
X-Gm-Gg: AR+sD10pFjLPlknXunCi+J9mdsza+OeDFPkQrtk4a4Poa8PtsOhe3mGpro4Az3s+Iae
	URMb8u7XV159XqyIuIcQI+pl2JbqLjqGWZg9PfLnh1uCZHacjzktxEMHCaeWDuiaXuwnd3CwjZD
	a7muQ44oEvkpW9id0j85Hrx6IUjZS8qWIqJMJjuqpXW3oFqV2BSwxGrxSlHjCFFZrGtel/2GQlL
	Du2X6rD1GW6VA7hOwl4Npf7XMeqPnigZsxbIEOr6XpWDjEMVKhsW+L/TYA6c0pPrKHP4BiAk9YE
	iUGr4Hw0geIihPprc1ZqDYZDl6gUX3nx5VFeWXsjG8BsSxrIDmIDFDN9YiEV4UCd81quD7g0i31
	77JBJ2NGYMZV4G7LWPSHz/otPs1MqFRL5h3nLqCmnEi6CrppROlkFf4aZod3vUbGYlkcx7sqkHH
	DXT+oZTtGi64ReifoR3cb3BmeSatAh4eW+U+APwd1nCXU5+TFFjk8HtKaSAjXK
X-Received: by 2002:a05:6a00:c82:b0:84c:518b:d915 with SMTP id d2e1a72fcca58-84ebc4022b4mr3494498b3a.65.1785439954744;
        Thu, 30 Jul 2026 12:32:34 -0700 (PDT)
Received: from google.com ([118.150.148.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e9fe240acsm3526682b3a.7.2026.07.30.12.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 12:32:34 -0700 (PDT)
Date: Fri, 31 Jul 2026 03:32:26 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: will@kernel.org, joro@8bytes.org, akpm@linux-foundation.org
Cc: robin.murphy@arm.com, nicolinc@nvidia.com, cychu@google.com,
	hhchung@google.com, amitamishra@google.com, marscheng@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, jserv@ccns.ncku.edu.tw,
	eleanor15x@gmail.com, kpsingh@kernel.org, mattbobrowski@google.com,
	song@kernel.org, jolsa@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
	memxor@gmail.com, martin.lau@linux.dev, yonghong.song@linux.dev,
	emil@etsalapatis.com, rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] lib/sort: Clean up sort_nonatomic() and
 sort_r_nonatomic()
Message-ID: <amumyk_cHcffv9CC@google.com>
References: <20260730181216.2709088-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730181216.2709088-1-visitorckw@gmail.com>

+Cc maintainers/reviewers of kernel/trace/bpf_trace.c

On Thu, Jul 30, 2026 at 06:12:14PM +0000, Kuan-Wei Chiu wrote:
> Remove the sort_nonatomic() and sort_r_nonatomic() APIs from the kernel
> library.
> 
> Currently, the arm-smmu-v3 driver is the sole in-tree user of 
> sort_nonatomic(). Because the array size being sorted is small in

I just realized that I missed another in-tree user: sort_r_nonatomic()
is actually being used in kernel/trace/bpf_trace.c.

Looking at the bpf code, the array size there is bounded by
MAX_TRACING_MULTI_CNT, which is set to (1u << 20). I guess sorting an
array of this size in a single go could potentially cause scheduling
latency spikes on certain configurations if we don't yield the cpu.

Because of this, it seems my proposal to completely remove
sort_r_nonatomic() and sort_nonatomic() from the core library was
premature.

Please let me know if you think otherwise, or if there is any
alternative approach for check_dup_ids() that would allow us to safely
drop sort_r_nonatomic(). Otherwise, please disregard this series.

Regards,
Kuan-Wei

> practice, there is no real risk of triggering a soft lockup. Therefore,
> the periodic cond_resched() calls provided by the _nonatomic variant
> are unnecessary.
> 
> With the only in-tree user updated, the _nonatomic APIs are no longer
> needed anywhere in the kernel. Removing them effectively drops the
> wrapper function and eliminates the may_schedule branch from the
> innermost loop of the core sorting logic, slightly simplifying the code.
> 
> Kuan-Wei Chiu (2):
>   iommu/arm-smmu-v3: Replace sort_nonatomic() with sort()
>   Revert "lib/sort.c: add _nonatomic() variants with cond_resched()"
> 
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |   6 +-
>  include/linux/sort.h                        |  11 --
>  lib/sort.c                                  | 110 ++++++--------------
>  3 files changed, 34 insertions(+), 93 deletions(-)
> 
> -- 
> 2.55.0.508.g3f0d502094-goog
> 
