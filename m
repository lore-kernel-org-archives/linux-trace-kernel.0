Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F7E3ACA7E
	for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Jul 2026 16:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783441568; cv=none; b=Mzr7skcF+NPcOViK/mMyna4Vh4PJQwjMIqxG+JmLnzHsjjL69OtZKoEIZQkPX47geZ47s+l84rWwLc427viW0k0bPzSiq44XBoqXU6TNvwsZ7UwVnmZ8WgcXJibPwelvaAnaEyS9VmM8vGiEhWNp+x86rd0qvg3av6RmTxRw6yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783441568; c=relaxed/simple;
	bh=lrYSArpP0iVuUgDVG3d1222jafWM2daRLlBprnwN79M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHpBnTLquCq5pNTSYMuZDra01ZbXuvn1TfK0sMbL3cva1JBzaAb0k5fkO7eQtV2mFL9fpjFm+gpAE+OMTiOnu60KXkAjKNoAeWd+weS8FKIUeYllkaTVqTeMZV5mWC6jQVADX9JONh1ipdVaUxKf62EIbCrxBRqd2jaZsEsX6pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=eDqMHtOO; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="eDqMHtOO"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8efcfdb2b43so33290456d6.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 07 Jul 2026 09:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783441566; x=1784046366; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Abd7yWEQE6Vuyzvr8uj66ic6dsI9yDvEtRp+r0f0v0Y=;
        b=eDqMHtOOKnZ2WodO1jnQZJ790kEpTIDI8WuU+/mtNr5ibVX299F7ZakW6olp8PyAFO
         roxmiG7G+NToxYzzQQPwxJRwcqw5Hp4FroxVqvucMZTpqhJreYpmSbr4DME9G0+JNOwk
         0FqJcGS95j5Lwv+uX7ayJk6W+z04XAe4mAKrxPqnXBU3h3RUJU2V1S6dD6B0mSI9eauU
         w9hhZfwt46Lf6MzZQRePSEZFnjg+zaMKIww/rAcT6yzuCEGTy9SpoYoM1E0c7DjdlwHZ
         fk97uJYdOH2dY4c9NVrjW0ueon860oDHARuEQE2SFZoGRDyE4SbsSzEUqKYQ7UvC65uL
         /XvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783441566; x=1784046366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Abd7yWEQE6Vuyzvr8uj66ic6dsI9yDvEtRp+r0f0v0Y=;
        b=L0dekzJNYCw9xHEXuHG7tGcIWHZYkig28LQd3ejpJuxjjUk2pglYMRUmk+LrFuBiFz
         1UQx8NcxgeDtQiFkb9UZ13UDlgYceK7+wbHcKNGkZkoR54U+NmaLq8TRk1dd0fadHlbc
         f4MAmN7KbqmhitiAcudoyiCXOBJdeQS4UAgooaXrlJrPJvmjQbik2ivJi84+SQocbFiF
         XDTJ/cH2+dTYp54BAJlAnY8BEogfGoSOUIMiB3/tzAdEbK8Z4o/J6Hi9l4zNFrCxaWAo
         kSY/p3opCPPDGlnlx9Sr7JkGX7Au2koOPX0YCADSOOVOb3ozFqFctHqqSMjzosxiStv2
         vjVA==
X-Forwarded-Encrypted: i=1; AHgh+Rp9P3o2IQURmv8p0upot8b6f+HFGEnkixPLdzq5B+t3inKHSepHXH4u368pdNOXVjEEvkJWs12DijaEHub/9vIeDB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJMGuzUQQoxOx4XFETUSRryC75UqbVCvptuOHSFMAdDx8vRP2Q
	6PDp+R1uSSkGVQ2NFaNs19EtYSBVjNqKaSjzMJaaytkcJf0GdO2QmWHipHDlEDLW9ks=
X-Gm-Gg: AfdE7cnyev/08MdvU+DXQIZhRN9LEmiXD9szRIXLtjco1nwMWffrHQdRM+lRGKjzVdf
	OV4xh6SDYQwzw+Sn9mgXMvHHqz2oAiFLmozO16frP9NVt/pFw2lbm1TSlkz2HE32CZUhUqbd7KR
	ssh7U8BQwWu2FpiLuxf4rtz3u2yuL20kNhn8NiuEowOrhBvb9TYNF0Q8bmGnev83IRD3DoXeRJP
	iSskKH+J4T73GO4jH8YHLVp595AzbOOVUBh2h1ukdE1e8F9UeWFL9FxnrrsgJQct5yDqjP4Jh/+
	dVcbxKuUIhK59cw0olVpDOnVvN/r7pwmToxOMIlw+fWrm2Mo7o2jqc15QdtwyZ/1zdrGApQS4R0
	Sx0++6tvCIjHDZpUp0A5V3nnfBiuLMnSyip4U5oIG1IzZCllhh8S4t3X5qMw1zABGOXyKPPItGv
	+h2v0p2zBgXdixtaTkT1qc43H2enE38b/LzKA2+CtL2MZ0qCWylkKuS7EMETXaUM4mxjD2I4Jb+
	S3VQac=
X-Received: by 2002:a05:6214:6011:b0:8fd:6de3:bbaa with SMTP id 6a1803df08f44-8fd6de3be6emr28372996d6.64.1783441563961;
        Tue, 07 Jul 2026 09:26:03 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f46f306123sm181382626d6.20.2026.07.07.09.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 09:26:03 -0700 (PDT)
Date: Tue, 7 Jul 2026 12:25:58 -0400
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
Subject: Re: [PATCH 11/30] mm/vma: introduce and use vmg_pages(), vmg_[start,
 end]_pgoff()
Message-ID: <ak0olp9zA6ERCXtO@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <f7b4f8a611ab4d36eb3cf2e394610a3744a93895.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7b4f8a611ab4d36eb3cf2e394610a3744a93895.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:22PM +0100, Lorenzo Stoakes wrote:
> In the VMA logic we often need to determine the number of pages in the
> specified merge range, as well as the start and end page offsets of that
> range.
> 
> Introduce and use helpers for these purposes.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>
