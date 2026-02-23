Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5479306B05
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Feb 2026 16:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862924; cv=none; b=MnaAcDTBVfXjx6gzbOU35AsQm6OgMi8x7E9Ki/aLRvktt32xUZ2UvPPcFjtNPtzRka2FtPwH73DTr/f0ZbDl/vrqtPBlAfJNg/cRmWdtIi28miAo1WkY0Q/koGh0YetctnrtxFe8z+gnQdjYyiEgm6pO0Vug+PkLg65sYGR/Z3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862924; c=relaxed/simple;
	bh=EnsbfZuxC9RIxnGqfBuxuj/9JrH+GEm1z2N32vhH5LU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Du6L/06LbHnTCuFUml56k36w1dr5gsd6FbhR9U01JV8md93uW/euYv6zwZpD9qwV/ZuGq3/IByQvHx4qX/kI1Hnh9pOM06AsTSt16pr8EEW+uesZuaG2zxKAk7NZ3sOuFWepHwBqCCsrg4YY1HP+DfZsK4TOyZQaKmAuYwU75TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=BsPhcHiQ; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="BsPhcHiQ"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-503347dea84so49217451cf.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Feb 2026 08:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771862922; x=1772467722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hp6xyKYDxr6lXYQA9JHTZDh6ckgrNYb0tSD8kTJSDxQ=;
        b=BsPhcHiQGsO4aoJboaOZn97P6uBmWUfSjz3Od8jXn/z1O+Gnwj6js3XjU09uVlsnSB
         9zRAzlb9E5oo++sFMpDsKG0UH7a0/+s8tFHwHbczUDpVVL9KM3CI3mfmBljlKYBt+xX3
         l/nCtNXkxQJLPWl+OlSUT5LRiz6tuDrFGyiBDeq8dQ7GRvow1YoSDnDsDs0Fs/MisV0S
         pef6NHm9kuIXh+HpG6hX+aDkR5WJqhM3HXtKt6Z9YnWCfjtHaRaVi2jxBnF5h7M0Wjmi
         CG9Ii/EHnmggQMJVwfnFdJ9p+BX2e0arNJHAjIt8QmHCCXxWin+Jseb8pDRwEVgXjGvF
         MeHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771862922; x=1772467722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hp6xyKYDxr6lXYQA9JHTZDh6ckgrNYb0tSD8kTJSDxQ=;
        b=Ros5TpZMCoaQQWPdzR34zq0pcpjA5YynfxtVTAAj9yDGLnUP/7hlQm+8FDbNSg8dyG
         1AeYxMGZi105LlWxEwiZ32tfBbDxaozW/rW/5+RU01yvyJ5JkU9awraxTwRK8oJMLjRV
         kb1Z1Hhotrx9MGl82ql2VyJ+/gR3kmYl/ZZzO+r/DHzcO5x3CO2vOGIsfvzQ4LVmoIMy
         cpL/NhWh9cwhF3LImQHgAejCTPYgmvTJi5avIsM6ofJ2YI1ouHXq9jPqSLuyy68IRlqm
         AMIEnJ5nXDHXoYu/q0HpRHFcztU166nmVb079TbfTKLSZ0pErEbQ6hIsP448JvNUQv4z
         k4ew==
X-Forwarded-Encrypted: i=1; AJvYcCWwbNHFeQYYFScsoXbkwM8jk0qEXSNEgp5StmL9TF5WFliuUDyGbWP97YC3xvB7HLiA1exiYesOCCaoYixkLVp4X0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwtS+xEuA57LlsMgConf73xQgnp5dyZXY44hDywA7ths+XIuW+
	EcI3onmUTD2DRo8LzYblU9u6SHcRFkKuZ9rfvLlQH2gob3ey+yL2qhPnphFOJ1crzzc=
X-Gm-Gg: AZuq6aJm5Id1H1c4cgDczDIoMCCWM/lZnvAhpapBHzD/10idKDs9Iwr0ESPzPdPind/
	bc4Ax95DHs/q5vlCVbH6U/Q7rxQGKq412MTVB9EyHw0J/qhHxwG1ttoNOwhebMMSaiMSCzQuWWV
	RmGD5EBgOG6lpKFH4Svk+CJhBU4qEmcCDjZIWEdY0wjI6jHPzcNWmKLw8vo6p7BdlkWnNPZb5yx
	DXQq99LjqZd22bESzjJsvAH5T0q+gGKsaL0OQhWryOitl28Dyb1uDeq14hdF/FyESZ5cTQyM+co
	3poFL3sZR8KE8Js7l9P1TBD0gDtmf6kkQChWSdZQvYm81gvnEhWOE6EINQCTJX3Gp0QWwto8v/H
	moGo6oKh+zZ9r6NtJG+G03xLQZXkoHHoBhcJ5BUmLy5qCtVIIurax6f2LawkmVOOvtCNmolRC4Q
	CXj0vrHm7AQLYt4N2Y/P12gso0Td1mFHoDQbc9FaRY8KngonjP9fXAuIqn7TYhiKIopqIUsVIFc
	/v9/ErgSAwQ/e6cp9T6
X-Received: by 2002:a05:622a:1922:b0:4f3:5835:e946 with SMTP id d75a77b69052e-5070bca9868mr136790871cf.55.1771862921369;
        Mon, 23 Feb 2026 08:08:41 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d54000fsm71259831cf.10.2026.02.23.08.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 08:08:40 -0800 (PST)
Date: Mon, 23 Feb 2026 11:08:38 -0500
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org, damon@lists.linux.dev,
	kernel-team@meta.com, gregkh@linuxfoundation.org, rafael@kernel.org,
	dakr@kernel.org, dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, longman@redhat.com,
	akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, osalvador@suse.de,
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com,
	apopple@nvidia.com, axelrasmussen@google.com, yuanchu@google.com,
	weixugc@google.com, yury.norov@gmail.com, linux@rasmusvillemoes.dk,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, tj@kernel.org,
	hannes@cmpxchg.org, mkoutny@suse.com, jackmanb@google.com,
	sj@kernel.org, baolin.wang@linux.alibaba.com, npache@redhat.com,
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
	lance.yang@linux.dev, muchun.song@linux.dev, xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev, jannh@google.com, linmiaohe@huawei.com,
	nao.horiguchi@gmail.com, pfalcato@suse.de, rientjes@google.com,
	shakeel.butt@linux.dev, riel@surriel.com, harry.yoo@oracle.com,
	cl@gentwo.org, roman.gushchin@linux.dev, chrisl@kernel.org,
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, zhengqi.arch@bytedance.com, terry.bowman@amd.com
Subject: Re: [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory Nodes (w/
 Compressed RAM)
Message-ID: <aZx7hsVNU0XOCCiG@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <c10400db-2259-4465-a07e-19d0691101a4@kernel.org>
 <aZxqP7J1kOClQUPQ@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZxqP7J1kOClQUPQ@gourry-fedora-PF4VCD3F>

On Mon, Feb 23, 2026 at 09:54:55AM -0500, Gregory Price wrote:
> On Mon, Feb 23, 2026 at 02:07:15PM +0100, David Hildenbrand (Arm) wrote:
> > 
> > I'm concerned about adding more special-casing (similar to what we already
> > added for ZONE_DEVICE) all over the place.
> > 
> > Like the whole folio_managed_() stuff in mprotect.c
> > 
> > Having that said, sounds like a reasonable topic to discuss.
> > 
> 
> Another option would be to add the hook to vma_wants_writenotify()
> instead of the page table code - and mask MM_CP_TRY_CHANGE_WRITABLE.
> 

scratch all this - existing hooks exist for exactly this purpose:

	can_change_[pte|pmd]_writable()

Surprised I missed this.

I can clean this up to remove it from the page table walks.

Still valid to question whether we want this, but at least the hook
lives with other write-protect hooks now.

~Gregory
