Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E0E427A0C
	for <linux-trace-kernel@vger.kernel.org>; Thu,  9 Jul 2026 15:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783612201; cv=none; b=CBXU4UyklyxO9PaqxCf0gnNKZyfNFuM12fgYMam7ez0+lqVL4QKbZknfqiD/2gO64XhfMGJHeCjEiUFe4DP1QFRK1XS9ixNvGQUPp8xlvrsIaN1y+s6TWHzHR+1QPgdYYi+7tHd10g3J1JyFm2QImOJm9c/rTuB+VtMfuwzX7+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783612201; c=relaxed/simple;
	bh=tF3dU5J3cOP7ny9iegybsK7rP7FD7pAbvMcJDVORdjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFgOTkf9x9NYt3DulMbGw9q16EWNHnpFi+33O6l82w4KLalL2kpk31olISsgPnnaZXSj6Jl3qrDdKgwPyVvdudRH2Hb6rny3LiFeg2B7dyhSUbDw7JMfF4388N9kq6KaF8ms9geKa6aagMlcG9EkqvoHM48iRidSheQm1luCMvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=idM4u2i2; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="idM4u2i2"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92e53581361so106530785a.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 09 Jul 2026 08:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783612198; x=1784216998; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jHzvbYEg0XlBnUnrRe2UmAXaT3jquo9NtkCgPzQ6hGk=;
        b=idM4u2i2GlBwxlx0x1l/uIG0FNyVC258opob2PsegtmlAI74wCwPj5VXohn2hLvjZz
         9lMRkKN5lz4sWnR6VKxMbqGRD6hf+lVzwkMxZr547YygIJoTsGHRXulxJ+QYoIeXIUjm
         M40YyS3cJHdrrI7nLvoV1Ox/AY1K8Md0GFkyziYhCdlMqDusfF0KwbGtbC+h0vbXEkkS
         ryfxv7F/KAGgGl9m/HCIcqaEi6MYYh1rVjYt+nZJO+uQMmGO8hWMD3bFwsSeBq41EmZa
         +jxIIobctljBTaoeai5jw6ZfjGGD5EcQGcT71M3FRABUn7J+ATdT5DGmDV8PJCHPM/r3
         c14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783612198; x=1784216998;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jHzvbYEg0XlBnUnrRe2UmAXaT3jquo9NtkCgPzQ6hGk=;
        b=RcBGq+qeQ29xRi6Q3rnnZjHyUDX1jVzoCvEhV9KIZkES5ZwGyRefFqU4BhowPgm920
         YDRcVeBHnM8ifUjh3FaZyf/Y3ZndedpExH5xalVdDFLsyGBBEW/ooIpDNFq0NjNLmjdj
         3c5UzKEDyJrSRYC7vOf7igofoPADmEX/CBFB/l41hQASOxM8hVq8+TrNirV9MXQUCZMq
         shfLBUsmeIk4Nt6utokmlb/AHB7qQFJV/mJxXpFHAbqIo/C4bw+0fsWHeYrwrmhxg0lg
         U5Fim1mDnWyxZj8tO88Ji2uU7y7N90XQ0qEhyvXZUluJbgk43iBVuqZGB4FEdF0mcDFn
         Vyzw==
X-Forwarded-Encrypted: i=1; AHgh+RrD3MjUhujwLGa+DF6CG4GItpERUA+sVkW4HT7LPfBjTidf7e8WiL2kyp6bpl+4DNUNINDQSvCQgjdPgg8bBeeeP6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwecUUcLOp/3iXugrAUzYhG+9hTQDVJXVE+C8czX3hDp3nSBtHr
	GP8l59OttcdB4BCTW5gAlUKCPaCYlzn3rrVbBey1hNl20RH9TNeQTP9fuywWZPKmuIk=
X-Gm-Gg: AfdE7clfXPojaIaQT/lJE2SMkFl2J7Q5W7XL0EMLQ6Qmx/ABvhO3UPAh0NutDEa/iO2
	U5rBb74nr620aMSApgXDiwnRzmv2UA3aLH837PwDRvL2hxMdwoFKaCm5mVT0bfpGvxUsVwW0hu2
	Xq3fwdL9eKx+bQwU6jZUjChZ5WuEzQvn3eRbpxfU3vvl7sEOlXSC7U6Ak3Op0XQjRvlmDloPRnN
	ONSM0A3iWWZEzFXvv2jRDR9WmyBk1tDVMJVunNfp8f0h/QFIHyrsUbBQOa+sbpVltwCxheY5L6t
	UjOE2MgcFQsy/6QJUB2Ud0bvQl763ZCTU1rSXCKbxvhc1GbfstbP6b2chNYgKoTLThhHPm0rSZj
	eGxSGvJeXqiATP+JQJUA5P/EHuHPVAiakYLRTM5MIcM0R+lbWIp6P8vNLdu8nYqvcpiJmMNSGNf
	KED967MlUQYQDYFRRtqHLpWGp1JuGh6/Z7JszW6LgrAM+Ox6MwAfOSHff4PNeh55V9lkL0
X-Received: by 2002:a05:620a:8017:b0:92e:c116:bf0d with SMTP id af79cd13be357-92ecf95dd8dmr807949685a.86.1783612198042;
        Thu, 09 Jul 2026 08:49:58 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90cbe3e2sm1689967885a.35.2026.07.09.08.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 08:49:56 -0700 (PDT)
Date: Thu, 9 Jul 2026 11:49:51 -0400
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
Subject: Re: [PATCH 17/30] mm: prefer vma_[start,end]_pgoff() to
 vma->vm_pgoff in kernel/
Message-ID: <ak_DHzxSA73zWkGN@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <ea87349d63205bf4c26ea79854f179a9bf8cfb0b.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea87349d63205bf4c26ea79854f179a9bf8cfb0b.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:28PM +0100, Lorenzo Stoakes wrote:
> Be consistent in using vma_start_pgoff() and vma_end_pgoff(), which clearly
> indicates which part of the VMA the page offset refers to and aids
> greppability.
> 
> This is part of a broader series laying the ground to provide a virtual
> page offset for MAP_PRIVATE-file backed anon folios.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

