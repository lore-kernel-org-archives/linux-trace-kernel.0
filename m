Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF86134CF
	for <linux-trace-kernel@vger.kernel.org>; Thu,  9 Jul 2026 00:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783555568; cv=pass; b=D+3iYjWeqmcocSZV995jXQwbG53Z8RUROZBPahf9Jf3HQPE7HMCFCXEkbFmWvA2aA5IfLJALJ9NBk+nOezxba0fIAbvklL+bWq3kzojkSnXKuPh20EYWs3J3MX33ad357oqncLZgzWO3qs6Pw0JNFmQijF4J6UcIcRQoOmGN7BU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783555568; c=relaxed/simple;
	bh=yJaHiIAKdt59/nUs88AHXAG1seHCynr9U+jmRjUBOEg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xr8I7gO+FBZwTiL8OSr00MP+2+VWZooOFx912C0lL86rIGo2mBSyp540K2GSgFj8qb3BhxqLjFM0s/A8e5kA9Mu+WIO4IgR5FbHTESxTpmY0WZu3Evb69KzgQiwJ7rjJN+fIHul5UObb8eal5IhQe27HjmpuYpdAmm6PauxsI6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=km73nMuQ; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="km73nMuQ"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cad8076b01so15237165ad.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 08 Jul 2026 17:06:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783555565; cv=none;
        d=google.com; s=arc-20260327;
        b=PWrDkn9ggjjnljYS7c3ZCBatx0lm4VC0Y7SPJIG8Qlss2iJdMsp7E0040ZWUBz0FdR
         oC1AIeYK9rwqt/Ug8Ha3TBLnyllg7jIeXwc1rSrFy1CaK+nXx2/1vj6oN0noDANnm0y6
         yuiq6HZeexewOgbwWHiFdUQc7W37Tmdx/kE9NOfieQevJB5Q2UefUewR8xObdchxiLTE
         FL/NPj3uaDkB/sY2ULmgi2xxQZW4l8MgDONCfLvcBVeI6tRDqF4BcvyXGAE29h8Ls8zt
         Oeh7SRHfsuxKsRUygz3FE23pRVmk512Cvn1BkFhUGH3uIm5dcIaExVFQgbNP0lO3/EkM
         0uDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=yJaHiIAKdt59/nUs88AHXAG1seHCynr9U+jmRjUBOEg=;
        fh=42CKJyeSfIYLvr/k05BuwSeLdzHCs48eQkp7ZJJMATg=;
        b=CUGHz8JMa6lhdu9h0goEhKtToYTvQG4RWbEqQK3cTbW5jTBgSnBCEm0fNOFKpFq4IQ
         LCCNxl/plkdJJkt92AsrKALQWNt8we96L25JIuJIqdEQjKKOcSFQuOuuqq9xlC23boM0
         8IT5EGvrUu7vIimrXXNL64bJhFyJbAux5uSBy7JgD85ATjhRzONYhRsGkZ7LR8OX/DtW
         YHN076tnVPQNq/2to/3qqw6v2O40yBVkjLazms7kpDberWWXvmsRtjlJiyqR5SX9MLeI
         hJz7VDHBwYvT1vEjFf3icR4v+GvFGWVlN2tjY1iUFQ90fVSaxmYbJEoJn5kc+KhyzEsG
         u02A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783555565; x=1784160365; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yJaHiIAKdt59/nUs88AHXAG1seHCynr9U+jmRjUBOEg=;
        b=km73nMuQirX6WkgaiDewtefUUpLqHsLA9lhojmRVu/O5GWXI+qspHLrIcP28hPedd1
         IdrQ4w2WUGkGZnfsvZbX4i/0vv+f8zy6UYrbx+r+6VAltUS4BsKAcMEEAqGPcoKiR6RJ
         oJPaYYcMOCkbcbYn6DUg2jPj6RwRgKn8b5KjbPN0LTaLwabP3wAFOO6JrbWd8+/V2xJm
         8qmB+NxqEb/SagF5FxCEtMVuCK+ov8IPbs0gvdfNk2TGZa0FvtOnzr4ElVQGCDXTFRjv
         zpPIU07tYAE6O/XcExlihB295hDnRUteCnX4/vklcg+GnLTnFl9WQaUB6cAitmsgQsSS
         bmvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783555565; x=1784160365;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yJaHiIAKdt59/nUs88AHXAG1seHCynr9U+jmRjUBOEg=;
        b=EIrX1Cqi7yr3suDfL5BIAcdBFYCtDtv4DNseCnJuliflACo1K2bI5Wrd2Ve/Pp4SZW
         ymzWB0Ql2nciJ36Sq2eSdb4Rb9nNKO0CrV7Sg7PDqWbGjOx1YEXfgQ86Jnx0o5vsfnV8
         AAKoqxkAUvk5SYsrNP9tNfU5KbDrcPTraAvULhMOTfBqniqDFAm5gkUZWg7zbQz1ykQ1
         AcxMhkeZd/MyXUx5N8mkjF1PwlvtcCOYoY266/luRtGL5K9XocVLCxjTXNWgGIgcrG3H
         Mk8dH+j684Jvcy1GLLa+gN489IRTGRpNsTwPufw6Q/FStftIT8BCvTbbL/Jugr+r7V7r
         MM5Q==
X-Forwarded-Encrypted: i=1; AHgh+RrAC/U9ZTJnZQuaO4GlxOZuvscWytVGsNTvyqKlOsGBGNN9Ot8fmOjI01TlC7gRXsjsTnV3oSCjNG/zD/Z9QJHj/Vo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFWGKh4Kpb8CNJGfvHQI7Nq+wgK0+po4VdXARRQ7QC9CK3NrlK
	citW3Bz9NXgPWxZc1NVQ8dPFbas0LYhjk5b1T8VOrZVxC5JK2H+BLMUJYBQQPqF7tbhW36hL1Ts
	9TERbooFlTHi21oaMBxlHI97xDuM8rUKV00ib22WI
X-Gm-Gg: AfdE7cmsATFZ1ysF042rmr5R75hFBnlnVJJ6ASyj5yNsnD1zXF7+V3giQDAqhvSVLG4
	8/6Tdb65IUKSuDv+KQ5vd0a8BKl+VT1o0wtlQCkURW+vt+fppsbtv5YZojneJwhiCQBHz3qgMRq
	G5n0D446jNLysqDCc0syKDyby2lD+8lll1TmSYGjYMcLGyZm7Y6Y3izG2nGK00XTpUOEYX8Fx0Z
	rpdAl8KZRv3WJaH+Bv9ejO+nykBGG86MKWv1LjJbpqnZUc7xfGJmMIGrFxNfWTX1rGxvpfppOEX
	xFAjLXSn1DVT9Pe7DWKMEh9jvVmbyuYOa6A7SLJDomUxSBOP4q6Uv26DKaXeTtNduY0LGA==
X-Received: by 2002:a05:6a21:7482:b0:3b4:669c:ee32 with SMTP id
 adf61e73a8af0-3c0bcbc1353mr5760887637.37.1783555564841; Wed, 08 Jul 2026
 17:06:04 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Jul 2026 17:06:04 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Jul 2026 17:06:03 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <eedf589778aaab33e6df2ad6556dcde536e13460.1782735110.git.ljs@kernel.org>
References: <cover.1782735110.git.ljs@kernel.org> <eedf589778aaab33e6df2ad6556dcde536e13460.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 8 Jul 2026 17:06:03 -0700
X-Gm-Features: AVVi8Ceg-PSWltTScKU18ZF0mdbBsNHDv0s-VKhIaqzjwQ-q80D6zfZMKk_VWII
Message-ID: <CAEvNRgE-JJAzC0jp+bY8+e1+gYSH+MjT6JqX_DfCcpaxOM-Dtw@mail.gmail.com>
Subject: Re: [PATCH 15/30] mm: introduce and use linear_page_delta()
To: Lorenzo Stoakes <ljs@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <linux@armlinux.org.uk>, Dinh Nguyen <dinguyen@kernel.org>, 
	Simon Schuster <schuster.simon@siemens-energy.com>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Ian Abbott <abbotti@mev.co.uk>, H Hartley Sweeten <hsweeten@visionengravers.com>, 
	Lucas Stach <l.stach@pengutronix.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Clark <robin.clark@oss.qualcomm.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Thierry Reding <thierry.reding@kernel.org>, Mikko Perttunen <mperttunen@nvidia.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Christian Koenig <christian.koenig@amd.com>, 
	Huang Rui <ray.huang@amd.com>, Ankit Agrawal <ankita@nvidia.com>, 
	Alex Williamson <alex@shazbot.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Dan Williams <djbw@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	"Liam R . Howlett" <liam@infradead.org>, Matthew Wilcox <willy@infradead.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, SeongJae Park <sj@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, 
	Hugh Dickins <hughd@google.com>, Mike Rapoport <rppt@kernel.org>, Kees Cook <kees@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org, 
	linux-sgx@vger.kernel.org, etnaviv@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
	kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-mm@kvack.org, iommu@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	damon@lists.linux.dev, Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>, 
	Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"

Lorenzo Stoakes <ljs@kernel.org> writes:

> It's often useful to obtain the number of pages a given address lies at
> within a VMA.
>
> Add linear_page_delta() to determine this and update linear_page_index() to
> make use of it.
>
> Add comments to describe both linear_page_delta() and linear_page_index().
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

>
> [...snip...]
>
