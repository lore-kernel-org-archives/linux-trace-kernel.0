Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E29E3806D7
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 19:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783711253; cv=none; b=U9Y/wRkPaCYviHRt6ocSPEl1sELyzRJ5Ssj6ukCvrAluvo+bKCsT14UYADxXNwsUxh51EJS8CPknCjx7S1lwtB/jcNxV4jQmSXPXLiN9WV+B2CwN4j6jc5MvpSk7oyByHqYoQManI2BToISRsjcl3NaV92tzpYoYY8csVIC+/sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783711253; c=relaxed/simple;
	bh=bX34iOgCjAyoyd0wtccoyCGEJ+0E8xtv6sAci2MgTt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXCZmfHF4oZ5gpp4gYZzcDwqRp1Lzo3og5XV/VXwW84E7eAD8x8/Z5R+yqs13NQ1P/7sDF5CFW4w0aFqRzYDZWDNt6y1eSbyPjd8Gr/wcfHnySUNEbxQ0f5Eq8SUddfmPkrrA4inbLFbirzVR34aiKgixX56DUBNCAL5ZeRyC78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=QRHXydDJ; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="QRHXydDJ"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92e5c92c389so65821485a.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 12:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783711249; x=1784316049; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xFW+QIJ4JFkYmnZudtxzUHG1gsom4gRJfGrSXFnz7n8=;
        b=QRHXydDJ5/nQOc8HvU3q4OunBP6vz4zthUIJ0dkwyXxVO/A5OI0D3B5US7tjGhkA0o
         2Y4iy8tprf9PaAxfkB8E4J4KUFOeR0hOdpRHpcm/3cq9mk2PpgAhLGikVu9EtYdys80y
         7CThLFBj6rKv8qfTgGy54aok4Gk/KcW5DYg5XZSEaB9mevnpFZmmPoMZoGQD8l3/rPMw
         ZWbB6ttvdjuCrPiV0APso8CbgZXYVm2zeKU1oT4g8xXhqPRqb/WazBgSs8BZvH8o4Nfm
         Yu9bvipGLMh3EB8pwlFHBEsrUFfGTNGooltP0RM3rBS+KU3LKl86QIqefaM9ZlDcZqJD
         Iv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783711249; x=1784316049;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xFW+QIJ4JFkYmnZudtxzUHG1gsom4gRJfGrSXFnz7n8=;
        b=GDwD5AoeIZwKexjRcyXSorsH2m/KfzLTpbVJo953ZT43cRZQffN9c7lPrShtkhiByO
         LxkxTDK2rtvQ3nWbLElCZGTvzUFWf1kOXYxC/uj5aoRqrcjmcHmFV/L+3+h7Nkk9Sq4S
         8tNPs+1Flylvp0C6Kv9KfWKXQi1y/8q93Ntd0aoCpp7/5B0LpBSoshiZ3c50en46m4aN
         Eq27MTPNndxKJ60ciPviwq4CyPsyLn/DYVbtfnk9t20vrpLu46s8e0IALl+DhJkII4uU
         fbhx6xNXjcW7AwvBwK8JJk5S64agSDBqWQRko4hu7okBkyiyYxh2zKNpGiRwfb4yUmAE
         G/Ug==
X-Forwarded-Encrypted: i=1; AHgh+RoWjdS410u/MFH3xLKGrIQhXNbn2O3AoFNc4znAV0FbnNJcjC6UND5rTCnh2Le2p9k7UblHBKFBi6trT5S4u24/VtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIbBVZa4L9CQEoBQg2uBQ8DfZA/Ebta3KVAfb3eZpYor2uacjo
	a5G83HY9GbcAk2/2/HdSnSIFhee/gE7+UZfsiaBocysORv4PfCOuaDDx/kirgDrsf6c=
X-Gm-Gg: AfdE7clojJfRdEtCVZymec+pJ+78SxRUR3Q3NyYKyaZ+bMjxf9kzt4euBX7833Gtd0Z
	zpzSXvjhew/dbwJx5bMQFMcQdpdDjA+eJKkeNMoA3BPH9K3iXmCwHfIKnvx77f21rfEKH2kRjHQ
	TiA5fR20HWMTghuZcNHwyMxYCo2YUleDXGFohcPO731lw8sInUEs9WYZUQdMnFK7YoElOgBvNnC
	ACz4jnylQhLxWHufgp+y940X8H8NBc/omwjFDJc6k0Cn+EF5g73rCPPFQ7y7Nogtr+/5pMgh063
	BNbCl/KhrBg3U/tj5Zzw4Af5p4jshWcMtsvTrsZeWnYzUetEEpIYw04rO5vtmi3RYJ98rTa6aFq
	RoAYvwHPbKIPot8xOid/s6JTk5qNIPoLRlze97XOQmZ+CWwMPXnqDyoLc9W0qso8yypJjB0uCHo
	wVEjrTSR7pLOhZ+wHiXhgyAYncISc+D1SVwk52KylvH3qjfC/eQvurxrOZjxiIUEbm622v
X-Received: by 2002:a05:620a:44c3:b0:92e:c117:5ecd with SMTP id af79cd13be357-92ef2d107efmr56266185a.77.1783711249227;
        Fri, 10 Jul 2026 12:20:49 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b8b3f2sm268883885a.13.2026.07.10.12.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 12:20:48 -0700 (PDT)
Date: Fri, 10 Jul 2026 15:20:43 -0400
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
Subject: Re: [PATCH 26/30] mm/vma: introduce and use vma_set_pgoff()
Message-ID: <alFGC3Vq-sbf56lV@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <37f4d951897641f304dba26f6f91ade03a50eb01.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37f4d951897641f304dba26f6f91ade03a50eb01.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:37PM +0100, Lorenzo Stoakes wrote:
> In order to lay the foundation for work that permits us to track the
> virtual page offset of MAP_PRIVATE file-backed mappings, we abstract the
> assignment of vma->vm_pgoff to vma_set_pgoff().
> 
> We additionally add a lock check here using the newly introduced
> vma_assert_can_modify(). This asserts the VMA write lock if the VMA is
> attached.
> 
> We also assert that, if this is an anonymous VMA and unfaulted, that its
> (virtual) page offset is equal to the page offset of the VMA's address.
> 
> In order to maintain correctness given this assert, we also update
> __install_special_mapping() to invoke vma_set_range() after it's set
> vma->vm_ops (which determine whether the VMA is anonymous or not).
> 
> We do not use vma_set_pgoff() in vm_area_init_from(), as at the point of
> forking, we don't necessarily have correct locking state.
> 
> Updating vma_set_range() covers most cases, but in addition to this we also
> update insert_vm_struct(), compat_set_vma_from_desc() and nommu callers.
> 
> We also update vma_add_pgoff() and vma_sub_pgoff() to use vma_set_pgoff().
> 
> While we're here, we drop a BUG_ON() and update insert_vm_struct()'s
> comment to reflect the fact anonymous mappings can be added here.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

