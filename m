Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A369381AE0
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 19:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783710520; cv=none; b=Y2SV5NpRz4JiqXWU1ALri8lchP+eVyDMA2Kotrao689Trj/sDEAD7Fv4zCYSUMZ/J66mxUw478MBGRZlNpWd/yNGSXD88FM6dfDUwUa1UXQ0Bt9mZOZubNqpY+kkhXaoAfaZ3OaOgEHlDPYb/1Z3YLbcwVPOTD/pZ52zW4Oiup0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783710520; c=relaxed/simple;
	bh=HnhvpODSykZGd0gC/qYJbWWYfTQ/iP5eixsH8/fLwto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4innG9d6q/jsWXxY2pZff8Q8jAlBTpBJR5Xkp+5iPJBy7O2mzWOMc8idQFmYJ09JKa0AOoXutUzDcjgA8ZHRUtnjUGMlbtzHEzx2thfx167Dh/4r6sk1cDMe/3p3Y5+99Ay2Wf01vVbVtGUNQtBKTiewtVLkI/8A798IGyo/bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=VDEsCTjK; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="VDEsCTjK"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51bfbe05683so7626881cf.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 12:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783710517; x=1784315317; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iFtVuusRSG4YUFzvnh+nyLwKm1T7E76ZywXpwPdPfD8=;
        b=VDEsCTjKsnadZV20yXTb3QGwgp50ACDuZI7J4yZKKnWBo4OT84PTfoMP3kJg+oiBdH
         1Gqgrx4jhlPhVKge9W66xtJ9wDRTc4izjFCCt+rN7ATcsy3EiHWmIIUOHQpkcQ4H0GhZ
         5URDPxsY2v+WopdI1n/n1b+Owcaxi9ivJmVR/hXxWrQgqOmaEpJvYRwnsKEJuNbIQ0ZD
         Ya4AYykxXANS0WeLWcV4bDUTBCcLPPI6gJWBW3WrN+Pvpd641O4GCIqULVwXv1BP7SOl
         9Sa7C+VJCErM682fW2glWudhoGDS2rJYRwzNYg/PxJ+zhe4VZ5Gw1/VP+IiGeOB0MHea
         NHcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783710517; x=1784315317;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iFtVuusRSG4YUFzvnh+nyLwKm1T7E76ZywXpwPdPfD8=;
        b=bvwDChEVJ8DAuR5Zmq/49A5jBVORqHrN5aoDYKIQmqIkHCtkZD4xImJvifl6Xrz61d
         o808HHG7WCOo71g0EayYyPBeRNL4jXFp9vulZUcXNBIxsiNzHlYr7s8Ub5dzhqspQlp+
         U0CuBJEaEnrU21fWSTymPHychrHrgByNgxNyMYrltDBMMQqESEH9lxzi0PPkxxoYoI0Q
         J7RCNSzjAJ8ZiOflahdGfyD9weQ76j8CThfhDnLMgZI3YZO0paoeLKUg5Bfn8hmVNg7b
         G7Tg61EAgxUGwlb6sTEOMTz15gW1Q+K8qDF6SRC/W4uwip9VHiJXhlGGPmV6dAspEv5t
         ooQQ==
X-Forwarded-Encrypted: i=1; AHgh+RpY8b/VpcoBg2b0SCxkEMJMoX97WMsU0O/rBGsacxgI4iTh9AFlAZY/bNHHP/Lf4N9ZXgECJ4HeS0azp/Wz/l646R8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxst3pEeNxXP1gETFt/35WRhhthZ3akJUYeRYTzA55qLdoFtaJI
	dh5iTP3sIL19dA4VCOpLpq8mGKx9qPuNSd8X++arAajXh4WyIz9kqyeXfCfTrC7ybtE=
X-Gm-Gg: AfdE7ckmjGmBAZSydprzh8r9mOUonRGuUWVhwsWSKzyceRer9qLQsZgjfVhht4fJ7t7
	Lf/fezDkcTt+yCjgVco97e8g6V6DZn+D79BBsAx9nX2HnjR5Zh3A7souzoFe1w9cwg84zA0QlUh
	S3q7Ejz2hH9Gz29rhlIEEAhSMNkQDoJLw39r84Dr8Udg5apwpxI/UXz8FPzjAn0FzMmJGD3l0pm
	biY+CjgOEgI1uLp+JdMTQUEznoJmHwIVnYQe6tf2M5C3VKPvSXRlJhQC02Q8VqAC2s8/Hxn9mUe
	DZeWWNPKZAf+FQ41XhlRFzK//Wwj8ySJdT12ZnnmzOZQD8fpHYfZ8bVMLyR8FsvXFtNaeV1jvCL
	j7anFrSMZSOcjc5u+RtyHTfBzOtOu3WTqPHAY/TqK5hKNqck4bz1yKC7kC5kpJCqsgBmhLMAhxG
	FyC5qkx0BdXbllbhrm1Y9B3AvzccuplrvA+OTfNS/Rwvse9IdnOiEqZkmCbJAA9P45/lTE
X-Received: by 2002:a05:622a:1818:b0:51c:b900:513d with SMTP id d75a77b69052e-51cbf280a8amr2226311cf.53.1783710517321;
        Fri, 10 Jul 2026 12:08:37 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd7c1da1bsm47847566d6.30.2026.07.10.12.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 12:08:36 -0700 (PDT)
Date: Fri, 10 Jul 2026 15:08:31 -0400
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
Subject: Re: [PATCH 22/30] mm/vma: move __install_special_mapping() to vma.c
Message-ID: <alFDLz9_oSSvHTuJ@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <b3254231831037ca3e9757e3e05c90072e04a6aa.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3254231831037ca3e9757e3e05c90072e04a6aa.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:33PM +0100, Lorenzo Stoakes wrote:
> This function is operating on VMAs and rightly belongs in vma.c, where it
> can be subject to VMA userland testing and allows us to isolate it from the
> rest of mm.
> 
> The _install_special_mapping() function will remain in mmap.c as a wrapper,
> since this is used by architecture-specific code.
> 
> Doing so allows us to isolate more functions in vma.c for the same reasons.
> 
> This forms part of work to allow for tracking MAP_PRIVATE file-backed
> mappings by their anonymous virtual page offset, as doing so allows us to
> isolate and keep code that interacts with this together.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>
