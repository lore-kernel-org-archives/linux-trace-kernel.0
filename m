Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B8B396D2A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Feb 2026 14:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772030614; cv=none; b=r7fY3LmdGEF1pMnq2achMIHgfuv0jNxDd3jAkHj5WDQOu5/JIc3hfCPfIjJPJjYp29OIXZmvBiQORo4FA2CMN2oAaCRFlg7r/o8ADa3sA1IppXRAol5BCDwGQg1BRoOMabCZ+Vm4Pb+jnlsQ5dFGSwpg1fQfD9NpJqazb6i9shk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772030614; c=relaxed/simple;
	bh=JHk303on0tH87FgVMmdu//2A2EJ68pOsAbk2jtfSs8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJkKL6ZxTpeGmpXUieFBAC81YHJtBZp5Rg5TqmD1lR7QAqQ2znXsMqoBB7DZOxOItZwra0r2MSGe0jV+WJptIVI6S2gfjxue5MK8x2Z09PfyMM/6mPusN2Yx/BwsQFt0Sfsad6fvu+lLQgBEksfkzeQufjHeIUtbf3WJuqoQPIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=t1djVl/i; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="t1djVl/i"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-506a3400f30so8545061cf.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Feb 2026 06:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1772030612; x=1772635412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=foY2Y5omQw20sTq6/J6XKrTrTufvDv+fOLstkti1G50=;
        b=t1djVl/iPQRVN8ydau/gloFLvPYLeBj3NAQsvuTSxKRsGcVR7pvgfrO2YsMihEAT48
         ey0ZOV9tfblTcVfcxp0ZYCZwczuWC6f1ARjG2e5AyNw6PZWaXTVN7Q78yd3iMQ9od4kv
         DgIyK/i454jAIPPyAJCu3CT6Q05qxMz076L2GDn8nMeTXUfheiAsDDgqbtT3OkUlgiRR
         LC/5UMLHmWCmJUHaCeepzNeRD0OD0JgA3BjeVCWDIBOBRShvs/agJyY1xZNeBrye+jih
         9lyJI6eJ0VW50faAzl5aepCMhFHMXWFW3uXie3yvGX9sO2d7CXrnE2lgfrwRa1XcaVP/
         HtLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772030612; x=1772635412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=foY2Y5omQw20sTq6/J6XKrTrTufvDv+fOLstkti1G50=;
        b=aoejzap9E706aVU2cs6P2YcfyEQJzlr8dfE1A8IOwt+GFWSrhTumsN3rvayv6nJCnK
         wbmEQNIGDFgYAh7OudZtDest9p2hG7dsM1HlYqV9cpGrm+6p2u2fPH4Xm/Db05ktIzBi
         cMbRR5DzkSkGB1Jb+AKlFdOGGoezmB6ktYtdcG0gxBxc9FgPNZtsxzx7XUmVl0Bo8lBx
         Z4qTDZLGJFMnn1l9h0AP9FbtS0HN8/6LDQCtqtdgEwcvjPW3tZdCIFVoMJ/EMnDBU0Bo
         lB/2487XErCWbDfit/B6tDCSYvLyKtTyZNNEIRGULvka1B5sA9wC72u47jfWtsFN9zqa
         7dPw==
X-Forwarded-Encrypted: i=1; AJvYcCVJ47x56LGJqTb0xPXdiONo75OcHY4El/HtF/t7pyIz1VnYiLr5gr85STgQhlhXzclRnTbGM9Q/K+9iLrVb25K0pks=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUzzjaVDyLqc/AFJHwndzo6c/tQrtucGuv73n87Mom+0iDvTnG
	HWh3Wh+/AcfndwsekCMVOjx/vUZ5KqjEKxtgweyAkAeiK74PQiohuQ08NMV3ZQox0M4=
X-Gm-Gg: ATEYQzyHJ9za3Ef2PidzdrI4ALfHo36HdgqGs2pDwQ9jhkKiqwv6RsjrIkkcEnBA1MI
	VSVZsiS25b8XHjEz2wgsJT/o1dHe3paZPBuRk2cOLvzI7e5OlVEhYMakGUZZwFOh4KRK3DOBCYF
	FqZdsQyNQe1pENwKbEhtA2o50ydISREOuFA2AZDpefda0eAv0Ajpesxz6WKQ0QpWA5Jw3GK16yQ
	c4bPq3klc3UlcTB3v5YxKrXCMwJ1uOr/b4zlM0v3IWBcHbApXhGDq8vVPo/tYFsojMl8NNp4BKa
	1nJ56MZ7aqlLWww4HIz/WouKJxfFdx0wXBQbbUZlBVCn+zKK2CO6kON2XsMGJw7I3Kuz6h73xMI
	FK4/3eGROawWKaUc/TVP5tnbzQGtFlGZZiNawqBZoN6H7W3nuPcTneOKSxTErmqX2yddsy4pYY7
	pRxxpO5ZZIBQsQnEmJD8iRICfkIUOmU6OeJ0OJq01cFDgBIDQNpfQs7GXwADx6tGVqt8HkYRqOp
	ajaQwMuFEy4KP/4m5QJ
X-Received: by 2002:a05:622a:1453:b0:4f1:e79a:1e0 with SMTP id d75a77b69052e-5073659bc05mr41895291cf.20.1772030611934;
        Wed, 25 Feb 2026 06:43:31 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d510a7asm123124661cf.1.2026.02.25.06.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 06:43:31 -0800 (PST)
Date: Wed, 25 Feb 2026 09:43:27 -0500
From: Gregory Price <gourry@gourry.net>
To: Alejandro Lucero Palau <alucerop@amd.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	damon@lists.linux.dev, kernel-team@meta.com,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, longman@redhat.com,
	akpm@linux-foundation.org, david@kernel.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	osalvador@suse.de, ziy@nvidia.com, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
	ying.huang@linux.alibaba.com, apopple@nvidia.com,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	yury.norov@gmail.com, linux@rasmusvillemoes.dk, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, jackmanb@google.com, sj@kernel.org,
	baolin.wang@linux.alibaba.com, npache@redhat.com,
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
Message-ID: <aZ8KjxdPS077aFcq@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <b704b05e-3e65-4a73-84c0-21557b0cc38f@amd.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b704b05e-3e65-4a73-84c0-21557b0cc38f@amd.com>

On Wed, Feb 25, 2026 at 12:40:09PM +0000, Alejandro Lucero Palau wrote:
> 
> > /* This is my memory. There are many like it, but this one is mine. */
> > rc = add_private_memory_driver_managed(nid, start, size, name, flags,
> >                                         online_type, private_context);
> > 
> > page = alloc_pages_node(nid, __GFP_PRIVATE, 0);
> 
> 
> Hi Gregory,
> 
> 
> I can see the nid param is just a "preferred nid" with alloc pages. Using
> __GFP_PRIVATE will restrict the allocation to private nodes but I think the
> idea here is:
> 
> 
> 1) I own this node
> 
> 2) Do not give me memory from another private node but from mine.
> 
> 
> Should not this be ensure somehow?
> 

A right I set up GFP_PRIVATE for this

#define GFP_PRIVATE     (__GFP_PRIVATE | __GFP_THISNODE)

If your service hides the interface to get to this node behind something
it controls, and it doesn't enable things like reclaim/compaction etc,
then it's responsible for dealing with an out-of-memory situation.

__THISNODE was insufficient alone to allow isolation since it is used in
a variety of scenarios around the kernel.  v2 or v3 explored that.

~Gregory
