Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C73C428470
	for <linux-trace-kernel@vger.kernel.org>; Thu,  9 Jul 2026 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783612250; cv=none; b=FuTQb3Aiyd3YbBcVbXzU0l9cGsziDIGXHg4sffu8zyv4/Xdb7gOELXO8nLf/V/htggUynWW1Ciq9tT1+W2Cxnj6bpvMkKfsLOzVIJ8uThEef8bQiAI+5WbJRm7snw9spdUWWdWm014tNVjdq/RQXw7Dtk47/s9D2EplkbbvwDO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783612250; c=relaxed/simple;
	bh=ooFqL0kdzm3Mqvprf/ktKH8mQbzOh+NePJH/rGI4MOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCdTxCQrqE06XlgfUqTCtxYshT8eK6wVLBthG7ePiz0sStG3AyxCxwyDRMyFFyM/cNGjwZZVURKombZOznCx9ItxcezP42VHoQWrbcW7eVBii7Ir8z4Z0H+D//TGYTFiHZ+vnibgAwqZdzjOX826OC4f5B5yF+Qa7U+3RtifZrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ICpnBr24; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ICpnBr24"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c21495722so9129771cf.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 09 Jul 2026 08:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783612247; x=1784217047; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4H58DRU6wxIzBQ0PfS3OOFxFy6X9tDniNwjExlFI+ak=;
        b=ICpnBr246mLQLo6J/c6CeHFuXpKGWS+yv4AMt5rkdjgStwdTQfBJeXld2RX9OS3KxS
         T1XZ0CZwHP2uMMpYQIu2MKkeDygOdG4vvodfYMESBetFa3AfxSeYFwNvlLie36mOY3Pe
         R0zqfTMG7doZsH7uhykqwy8Nm9me5EkINJlDDHbizdvgrmWeujiQ50g8XcevN63m9l//
         5mkwF44uINVA+qtg/OwITJbeeF57OE3ZcrBkL7593XeWfd2UC2z64c+0gHv4j6EjbdwG
         /lRYBkU5BmTRVIw6iDSpw0UC5XgIySiXza1IeRpgrqXZdoRKJ7ISY10E+5yfZZzerBSO
         5HLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783612247; x=1784217047;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4H58DRU6wxIzBQ0PfS3OOFxFy6X9tDniNwjExlFI+ak=;
        b=pZZv6aMk6ZZyDCh/TPGnoDaCnlVx3yPQ9U5qkHEKne35uqynbpxamPevcAUG9W0FsA
         j04eERXCUkqs8y+mZAt0BlE4wd3PpuYRI37Ngcu3jEYQY/X5tYjOBINjNqPRRy6Y78Hv
         09pfEfZ4jnBE1MAAy0scKyL2bIWhaBJD3cjoQgOl1H6Yj/E49eBB1XhFet+v9Q/wSggF
         jQCWsYonAkT729itC4I8kjDkNCQY5BO+Trwy1MOd12Blh/hr5eFG1qIqbZDX7mJumxFX
         +cAvjoBlAclu7HTEfHTaWh/FGCB+QLAIEz3UbW0D86yyWjx+dVjaOLTCvWs8u7k6zCUa
         YO0A==
X-Forwarded-Encrypted: i=1; AHgh+RqPQLIn395nGX4s8iDcBErHA3ln2jpTs4gePqT0pWhYN9rCw0IaB+oU5RCKGHO3A7qpd8TLxFGgikwWu2KQxwccQDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcD5YoZzbMLbWkVG8PoaQOCZ0Y50v5MaWS0WcmjZB4RPSvp2GE
	xX+MhY0H2o9cebtXl8AJ/RSbDb6YBq0T4bRJD6I6ySGPare6nVA3CR8Yz6OgHl19DIE=
X-Gm-Gg: AfdE7cl/8BrGD3gPXbDK7AUtXAOmOp84KjjyxyAxFKdQ3RRTFCkThp6WjJOP6tLvxFN
	3J2EXLQQlFCZQGOe+/sl1WehBiD1nNw6KV7YKvz+tvJMzH/oUIDoMsgtwryF9ljJ6PIbpGhTNnK
	BudfYbsDFb5cHUox2gcxgqRjsjlQNzkvbuB5CbDMJ7VCHiFrFKEdDn2R7ga58RX/4wuYAEuJFEk
	U/mt2ot3JGUBG4VfUmIn63KMEcCCJJdtfSnsmeZgeVEVxlyqW5JSOBm9JcwfQff4V3G14s4HRd9
	jBh1Qc1lb6XMmHf8SCqmpiuFbQrlO33uVh5QFmQLNYhxp4PxszB+h61EmRu2L6Ys7Gv7s2Ljm6d
	KGZNHoFdqDqbD2Lvm6dO/ygdRXPxBiUWXOOkGvbiOhvqmgYJ2gfzFVuDUkfFVdy22LD/LuBNQ+I
	u8c3tT5CLVZ5RBCOG1f/N51kJ9W2lptrx5aVJy5VyAirW34M4GWuj27F9UqlmOO1Ds+4ak
X-Received: by 2002:ac8:5f0a:0:b0:51a:8c9c:7f52 with SMTP id d75a77b69052e-51c8b40a675mr79940341cf.69.1783612246884;
        Thu, 09 Jul 2026 08:50:46 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c4202366csm161049781cf.30.2026.07.09.08.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 08:50:45 -0700 (PDT)
Date: Thu, 9 Jul 2026 11:50:40 -0400
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
Subject: Re: [PATCH 18/30] mm/vma: remove duplicative vma_pgoff_offset()
 helper
Message-ID: <ak_DUDt-1tb-V3b2@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <10671c2fc5d0dd4e3bf497181923e63e46053df1.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10671c2fc5d0dd4e3bf497181923e63e46053df1.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:29PM +0100, Lorenzo Stoakes wrote:
> This is doing what linear_page_index() does, so eliminate it and replace it
> with linear_page_index().
> 
> Update the VMA userland tests to reflect this change.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

