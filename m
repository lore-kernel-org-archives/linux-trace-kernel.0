Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5203B4EAA
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 21:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718222; cv=none; b=trvHuSCgX/5WpLfr4N398GIo/yYwC0z28AFK8347fKb4/d/1duDuKxvpJk4G4yenrzFSndbkrxvUOaaXQ67hLsx6vY3krkjWGw5U0WRsdFAK3+K9XJSZU5gWFBXG/SaaB7y1o8G0BCLzQHsfHRkVluF2ZvdOtiKDYJILMfGFgts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718222; c=relaxed/simple;
	bh=5KPNhmwijDAsBGeZ64JTaNX2be8iS/2XlIFbwRyt0OU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rsXvmAOUINa6sRR4XDdOYrMf/bjxV/CS0DZFEGnNuSvYAsDD9F1ERFzp3FMLezhSPx8ssD3+O4cDWmXrVx7eUdAV1jefIX+k3KQgFN4tNBI7L2UdPWNGncym7A3tnXkQ09URpAh08WGiezggFRMB/yuuUPws4iPe9UDqsUg8T7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=f/kdUXzM; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="f/kdUXzM"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92e7632b193so88539085a.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 14:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783718218; x=1784323018; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Izor2xUYDxPFma+uXVb9laI9dziDM9wo4fE46zQgxzc=;
        b=f/kdUXzMb2qWPpwwvad/8EYxamc4UUOFPk6xkydd1ucvTpaXYqQBlBQGUqhA8OFDbZ
         KR0Al1I/+Sync8Xz0LPdD3Zne4SknvBQi1MAkzQUeMuGhXNkCPIcAGis+Yrq2ygRvvKh
         JKj5rsBWQEfa3P01qVdY4yZ0teyxJWke26vOvFErAmAYeczjbpmtBgYNVPt4epu41eEd
         39AqDiGtIcJXq1ogs2PUTAMZjHfvJSggFzMI2zGs5ozekFT4LCt2ele6sai/0LHk/3WI
         UVy4WRy+a7s6vPnL0ksZFRiRZOJLWggISmGMWgAhJyvrSq1iSGrtiuwvIoX3cd4ziNQA
         aadw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783718218; x=1784323018;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Izor2xUYDxPFma+uXVb9laI9dziDM9wo4fE46zQgxzc=;
        b=KCqvknpSBJ42fZfQoiUivSi5RzMbESZ1VC6O1j1OVKae8IX6dej+fKz6qRWzfHJaql
         aJA3aKZEipIEuVXrpkU3T2ZBlAE0/XOwizUzHYE7eo6XteWGwVDb3wM6RGDuDGf76woK
         vbvYHN45oSbIigatgRX+qKS81zLS5ua8H89GC9osEdzkT3lsLU9fo9Eh2D6+zmOg1mv+
         nVqxL1iVGmeQ4DQbNMSX6JQdRK32FWqDWyAehQeAnPkD+nQ8PpKTD7nJucPf8Pu46Qn3
         h6QArSgDRI2bG4igIVG5cfoQpP+k5RjcwrSvKU3bPqfbQRhGh2fKvEHTFXTfLXf+2Xzr
         fgbg==
X-Forwarded-Encrypted: i=1; AHgh+RogOk3IORUQhu+5Td1PgpN4BHVsZzThIek1i7dS04/IxxeG7sVL/LOcGnp8pjB2ExD8mWQyY1XkU1zR3TWl0eRqKY0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7vegCTDkhXAbYkYc6ECcmBu1R5pO+yaN4Jns9BncGovJMGFnF
	ox1DwBwUy9TpHXQoJVba/Bx1YVcXGExAn3aaY28MWfT1gRitr4tczeajoCUV/fmfTN8=
X-Gm-Gg: AfdE7ckQbsaZo7vZIr+tnTJ0oYFlyag6yikjSBbGM9oc3QPyx3tEpMJeBfy2pnUkr+f
	SnOQJ02BpuHMAcmzhoIH2z1/fazBUm/j+h8EInAzxJbz/aq4v1XvaCEL/Mnd+avhtwFFgmGP16Y
	xxOj51et8KOl0EDbVhNffV3vHh0LrdrPkAjfWY0mRxNu3Zh/Bc+B5cCI1fzLXGQudH/nr5vnY3T
	s2XbbPfRNzBJmiJhUVF0oRAc31e2G73b7K6s6kHjwIBi21+6FbcGO2YTfA8C1Aa06qfEDqJI6BW
	shoujjXTu4AowYoGSRWy1LEoZ4dzw0Mal2iwjivjpsj6bZsz524irJdcIthH9J/qwYtzIweLVWp
	V9iymw7sMDzvk7ROkRltSNpLIKxE3WMAW6M0noASasS/YERjazocJZ1u/Uf8NusPyJTi2VpVBgv
	gNQPNJQtmOjydn3Hdx3kznlPtRWQ/SrfpkmO5Mv0l/PkpmmniiHWbsFk/zPJ0xLy0rCBrk
X-Received: by 2002:a05:620a:2691:b0:92e:72a4:f290 with SMTP id af79cd13be357-92ef2b3518cmr83584585a.19.1783718217777;
        Fri, 10 Jul 2026 14:16:57 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd80fe218sm49983646d6.33.2026.07.10.14.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 14:16:57 -0700 (PDT)
Date: Fri, 10 Jul 2026 17:16:51 -0400
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>,
	Lance Yang <lance.yang@linux.dev>, Pedro Falcato <pfalcato@suse.de>,
	Russell King <linux@armlinux.org.uk>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Simon Schuster <schuster.simon@siemens-energy.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Dan Williams <djbw@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Usama Arif <usama.arif@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-parisc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, damon@lists.linux.dev,
	iommu@lists.linux.dev, kasan-dev@googlegroups.com,
	linux-sgx@vger.kernel.org, etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org,
	kvm@vger.kernel.org, Russell King <linux+etnaviv@armlinux.org.uk>
Subject: Re: [PATCH v2 11/33] mm/rmap: rename anon_vma_interval_tree_*() to
 anon_rmap_tree_*()
Message-ID: <alFhQ71-WGGHo1sJ@gourry-fedora-PF4VCD3F>
References: <20260710-b4-pre-scalable-cow-v2-0-2a5aa403d977@kernel.org>
 <20260710-b4-pre-scalable-cow-v2-11-2a5aa403d977@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-b4-pre-scalable-cow-v2-11-2a5aa403d977@kernel.org>

On Fri, Jul 10, 2026 at 09:16:52PM +0100, Lorenzo Stoakes wrote:
> To be consistent with the newly renamed mapping_rmap_tree_*(), rename the
> anon_vma_interval_tree_*() helpers to anon_rmap_tree_*().
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Nice.

Reviewed-by: Gregory Price <gourry@gourry.net>

