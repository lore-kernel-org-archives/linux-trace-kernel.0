Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058EB383992
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 19:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783711572; cv=none; b=pTx8hlW/K5NjbO88sPJUqSmPaz8B58RBigTbbOrbK2ZRy/0AiEJiIOy8id1xtFdEjxEOr1K20h2Vf19DmiTTEdfHohU4WwtlkmIlKc1BNKjQhY7npx1DtEQ/eNjkrmQit0DkLawuJ09zRgfQUlSFOBKZNFs6IspMFDARy5sMwsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783711572; c=relaxed/simple;
	bh=QOojT1E2vhWM7tSRUHih+fCOI5zTfyzCTjJ63JRhM4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IvMIR3JnZXjaVqwRbchQbtjYctaA1ODBGWFv+j/Ac7FLNdeKvjbYbgEv7cecSKuhXqC4M9Bpih79M+7VWrVCCmNJQ2s4AYBdXmGPw2KMiyv8T82Umamh9ROL0Bdc65zq+GipoBIws5zQlg9JCk+9f7yi7DZx7wweTcV8K9hC/5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=JSdIBqch; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="JSdIBqch"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-920f33347f5so69163285a.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 12:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783711570; x=1784316370; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aHwFumUUjp1dZn3azv3jRxV2z4/4b2Y11BxxEMyANyA=;
        b=JSdIBqchaCZzRpVvVFADvkhLqPbo4riC3u3E7LJTjQJEp3ijohFzNRsv/Ar3IFHr0p
         Mgna+YkhbQptUtgzcKE1rXFXzJH0ybY7998QFsViwyK0BKzu4ItUhKCr9EPz1RzDyFUk
         5F+ufu8Zkb6j5fe6FBWqj6gIh+IbOersauvLQgeuBd3smXFKae9Fc0CKxkvx8N5mH/wu
         qZTOvBYrHE5AiXd3tFVSmGirGrsaSHqkJrkXJKZR98f2HBWe+2Oxn/KWNU5tlMo+LVbv
         zha9plSVmVVp2lxIomakTAh24E70ZstVCW0PT4Wu5Il3I5pTKNw6aoYAhb/Dw48KtgSW
         yEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783711570; x=1784316370;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aHwFumUUjp1dZn3azv3jRxV2z4/4b2Y11BxxEMyANyA=;
        b=c+Ldga1YNjgNVNFbulSdcJ+5L+L7MCnjxu+FtvvPyDy1gXiz8nblrvXHUmJSesf17T
         zAgO0Z3xlO+QcemqN7EStgY7v3fXT5lchHI5B7hd+dfUKFMNoQLPaCupq2T9DMLMifqL
         sCOZH32P1TXxYRkalWtaSRy8ov1OaNp7gz5lFotq0T59FNS+Q6wE0QAVysI5x/goa4zn
         y7aCmrnqG4MmZ8W5sjvjgdJBrjkCBOh9iK8tUu7/BYEkgJgLZ97o9/72KQVqIh+7c84B
         pNhBs3QVOhey2V2y/pJHvbhpqlAleTkinDji/cn9BXvipff+g52q0xVPsKI83uuebhqB
         qTFQ==
X-Forwarded-Encrypted: i=1; AHgh+RqmSloQ9ulipRF9Xbo6g0h1jszBgTY+0p/FMHM79cueS6D02/79+UXhfgCcFIWrHC+7U5Ed5i39sOlXETmnVJbxpJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdoacC3UKeVN+8iwzHER4xh79F+/YFulMMIRKrL3HCXsZxd3e8
	Vnok3u/B95aLa+BSiRmIqTnSTGwmbz8y5cT09fEV9rsfbfTqaj3f7V+/BGl5/VWkUzs=
X-Gm-Gg: AfdE7ckzclCPZ0VvmSo8AiRNar6dKMiBn9vSCxE/sSpVX727AaUgBtLaivkbcOWSbyZ
	PxvlwQFESbJBvqPOicIWGfLOHavQioKHtRwvutb+7gKXRV+zb8xAGL1K+TVGn2DxPCrchB45MvK
	YM8vUpq2oamd5+hbCtY6X07UoZSEuHFrj38/PUTBYu77oh9a9czyhfASL8tap0JvCHEM4VLRlt7
	repiOEnQIYHaPKKYJ4J0V36v3iN8vDJMDJ8/rAtg5EXkBZnV6RMhXN+qXdXT+xVn53eQFqbxwv4
	hbWvjeXV7umNgtsgg3EvmCNViBgkI6QgbSpepQ4/Apj/Z/lJJngD590edAX+ZGDTfM6NsvN7QPH
	EQhw96qgMBVH7yD6VlzLIajuCgDpBi8kEwJGEWoUV3qR5fkUV4A6pOjInOYN14axQebl2VtHQwu
	w1NXV0kki/THO/JhtcUPmcNjM6ryq5kF+VZDEKMtFrWhhBkovDZwaCB+6I0jJ84i9Y0+CbtEGgC
	e1MNL4=
X-Received: by 2002:a05:620a:2993:b0:915:8502:f7f6 with SMTP id af79cd13be357-92ef2b575e8mr66564685a.35.1783711565033;
        Fri, 10 Jul 2026 12:26:05 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d37540sm265182485a.38.2026.07.10.12.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 12:26:04 -0700 (PDT)
Date: Fri, 10 Jul 2026 15:25:59 -0400
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Russell King <linux@armlinux.org.uk>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Simon Schuster <schuster.simon@siemens-energy.com>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>, Ankit Agrawal <ankita@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Dan Williams <djbw@kernel.org>, Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	"Liam R . Howlett" <liam@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>, SeongJae Park <sj@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>, Hugh Dickins <hughd@google.com>,
	Mike Rapoport <rppt@kernel.org>, Kees Cook <kees@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
	linux-sgx@vger.kernel.org, etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org,
	kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-mm@kvack.org, iommu@lists.linux.dev,
	linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	damon@lists.linux.dev, Pedro Falcato <pfalcato@suse.de>,
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>,
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH 27/30] mm/vma: correct incorrect vma.h inclusion
Message-ID: <alFHR3fg8K1-SITK@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <22d0f4e3fe11f6fd1312734e242d008267ad142c.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22d0f4e3fe11f6fd1312734e242d008267ad142c.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:38PM +0100, Lorenzo Stoakes wrote:
> The only files which should be including vma.h are the implementation files
> for the core VMA logic - vma.c, vma_init.c, and vma_exec.c.
> 
> This is in order to allow for userland testing of core VMA logic. In this
> cases, vma_internal.h and vma.h are included, providing both the
> dependencies upon which the core VMA logic requires and its declarations.
> 
> Userland testable VMA logic is achieved by having separate vma_internal.h
> implementations for userland and kernel.
> 
> Callers other than the core VMA implementation should include internal.h
> instead. This header does not need to include vma_internal.h as it only
> contains the vma.h declarations, for which the includes already present
> suffice.
> 
> Update code to reflect this, update comments to reflect the fact there are
> 3 VMA implementation files and document things more clearly.
> 
> While we're here, slightly improve the language of the comment describing
> vma_exec.c.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

> +/*
> + * To allow for userland testing we place internal dependencies in
> + * vma_internal.h and external VMA API declarations in vma.h.
> + */
...
> +/*
> + * To allow for userland testing we place internal dependencies in
> + * vma_internal.h and external VMA API declarations in vma.h.
> + */
...
> +/*
> + * To allow for userland testing we place internal dependencies in
> + * vma_internal.h and external VMA API declarations in vma.h.
> + */

Do you actually need 3 copies of this comment or just one copy in
vma_internal.h?
