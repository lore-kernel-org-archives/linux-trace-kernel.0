Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D273B381B04
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 19:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783710785; cv=none; b=U0m2WwrHyzXwFbPC6E9LRAlOactoy/v46vbni67Zbgmjg/Q4E4hS0UCmfXqi4dva3hRq7iowmw2JG4NeW6m40UuiGS8ZZc2qFQJWZQ6wXjVXmYwiaRYAk9bAjKeTMxUbkKxCGMTKcEvQrI7Ujb+i1+rCVsIdW3hRtm+gOa0wx1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783710785; c=relaxed/simple;
	bh=mbUpbN9JA5TocILiu7DT262VDuT+uIcfX8rdIywuDIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9Ro39ps71ArSPezMVhOq2X8TCz1FpY2LBmY6mJKxxSOiDo4ASs3GDqReD0HOc7w/2ugIP65qiaR2tE42EFe5GDJty4rGv2FhG8x2gCbUhFAqWiG1v9NO7PGQs63NAuNO+uQXMc7VrQOrR7oFma6v7nb983Ica1SQFyibGpX+VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=mUx1VT0P; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="mUx1VT0P"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8efb708b1a0so11491436d6.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 12:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783710783; x=1784315583; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Zl1BBUQ1SVF8WlDcAjuqmqY9e/JVxV3t5chHRhyKtnA=;
        b=mUx1VT0PIOg/xwhlOTlIJEriNCZxkdBJZVjc9C5uxphAkNM8EEs2imYn5i1hgOnvX4
         xwXlqQICD+cOrqA5hIZZbrZaES3jwUi5ChfT30etJK+PoH8/mA2cDMsBTFHDmhUP0FPt
         z/CMZnu4OqUu+aiDWu+sem1azbKqRtlmsXojxJbFE0lsZeP1Hr3d6/Pr6CVkhwBKqRN5
         ogd26C6iV69u+TuQzA1Fh2frC1svhr669/Z61r8cEK1brwL4XRueu3Ptbu8FgsDJfzXO
         2DGBKApV0OVyOjSpaaYZ0h/o1TqS/+tA7LhRSCDGyE0WzhLeouwLG22YQFz+ZET9fA/U
         n8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783710783; x=1784315583;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zl1BBUQ1SVF8WlDcAjuqmqY9e/JVxV3t5chHRhyKtnA=;
        b=qIKKxFX24GSLzME0ZpBYfnREN5qtW9RinwVAfZTzLbTgrxPaU8sFoCyPtvz7hEvErd
         Ik94gUhTin40eYfXKl2pxVtJC+r9AKMb8FWYaRdSe7r03AEsRxJ8WP4ktUttZ0hCqvnp
         wzOwiZELpTHLXBneH2fCQ462Joh2stj6L2n/b5I+fcnvJqD+4WsBDJkZkxKgMrD0+6Bo
         B7D87BuPwLbaRZ7KKURjNzuiLfsEnC7f8w3nr49HFvuAKg6gRgLXSGBKIcFerCQfPR+K
         zdJssUFtokq6T8Ry/q5MGUzNQ8Ahpc6j8cJrrdHP5pef46nxr+k9eiWqZ5EyOqpYmHT8
         52yA==
X-Forwarded-Encrypted: i=1; AHgh+RrisJF4zlCUlmL7ASvvr9QEhwMoSkGoRuJHmltRNmu069L3SBOdHfpdcB4rWJbF6nyGVUUUU1ToGdkPwIyxfiHWqbs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr4CgJakyr5ad19k1rXsQTI6Mc6NANLIOuRAzBU69H5H7fi8px
	OD2R8o072JJFahxLuhtvVM0mm2CPJTwi2AEkYLAdxnZ4gyH5wD2TjsERjcSm6uNyyOU=
X-Gm-Gg: AfdE7cmbdIXSVJ6T8I82K9UdtBBTJvR0Ui8zLA4B70xx0+Mxw744uvm1AGXLheL1yXz
	iR+yJMLk687QVpvQvls8woKKU8x0vLzh46CgLUSvrSNPn0D35WrbQM1U9jS8jZzsFBaE87KZ0e8
	6V1yPJV9D1tqPoWPfEWEqvZAjsB+Tm+7ELuNxUaFh4mmU4IURIc5ldWBFjwCd2VAEJMJbpfRps8
	K+bFnrkfUYv1MMg/RqHpcWIwMr0gugeCoMdB3ZFti72xVqmwZwEHXobUxa2j1HlF7/tlemubzRg
	t2QBUjLh2WjI7lsPauSGdqv8ZvBY/3k0cdb2VSXUokUYzmZFDNe6wuCEpofzFAT4e7xTS2cs20j
	yaeX8vJRnHBrlLDHM9+t8rZEdOwmZTeWrj2zRPeptcfKuOAuz75iSbcUO8jmGfPoZltLNoSknrs
	Vm3WXLPrRXhsmdhSUEG0RUPBYRoPY4VjO+xonWYgIm5KJgaXGpbKf2EzzdnJ8UiXBkslmf
X-Received: by 2002:a05:6214:450c:b0:8f0:9d9c:52c2 with SMTP id 6a1803df08f44-903fe450e5fmr5228126d6.5.1783710782628;
        Fri, 10 Jul 2026 12:13:02 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd87c9128sm47321526d6.45.2026.07.10.12.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 12:13:02 -0700 (PDT)
Date: Fri, 10 Jul 2026 15:12:57 -0400
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
Subject: Re: [PATCH 25/30] mm/vma: update vmg_adjust_set_range() to offset
 pgoff instead
Message-ID: <alFEOTiJw2g--9F1@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <910f7b5be78232304dc7ca01cd57c6f5ca8f3d13.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <910f7b5be78232304dc7ca01cd57c6f5ca8f3d13.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:36PM +0100, Lorenzo Stoakes wrote:
> We are calculating the pgoff as an offset, since we have vma_add_pgoff()
> and vma_sub_pgoff() available, just offset this value directly and use
> __vma_set_range() for vma->vm_[start, end] values.
> 
> We take care to update the range before offsetting the page offset, so the
> adjusted VMA's vm_start and vm_pgoff are mutually consistent at the point
> the page offset helpers operate - this matters once vma_set_pgoff() comes
> to assert invariants which relate the two.
> 

Given the prior code just did it in 3 lines of code with no special
dance, there's a presumption here that this is done in a critical
section and no external actor can see the inconsistent state?

(i.e. range is updated but offset is not)

Just think about this from a bisection/debugging standpoint.

> Doing so lays the foundation for future work which allows for use of
> virtual page offsets for MAP_PRIVATE-file backed mappings.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>
