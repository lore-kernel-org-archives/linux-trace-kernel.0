Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D863BB668
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 21:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718467; cv=none; b=NCKqm/776L0fcl+bWW9DLptWI8GZU23DCcXMoGAu35R0LSzZVizuerfedbBNBDAyFcHaFXuCtTkkwYZBG54D4UwOGKpMNNDCUE/63bwQdiAjM5FoA1j3e0HLEqoY4FwDOS5NOwCraudeleP62wggdvcwnXfJUv3oIOaJqHFiU/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718467; c=relaxed/simple;
	bh=OrArmp546t2joLiGKmZojGNI2jG19j2P4RpxQaXcMQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3wJSMCppR2Emg4ipdPjH1XIKgKZK0O0REVT7M7TfxGfPJUE5xwm2/76zparDSHI8Op2yp6ILgW7Q59qQ9+nDTBYAmcbFYbPKBW6CyqTUGXEfMcLUU65YA6D4Hh1KjPf0/MPoQCn+MC21YPQNd9ufdC5T8KJxh0aS9JW0QnC43U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=WrsZLakZ; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="WrsZLakZ"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51bfb91795eso9176171cf.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 14:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783718463; x=1784323263; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kBOMvPUpfjw5N1/s9nVKhxGNiyKZIoN9dPtD8sVM7ho=;
        b=WrsZLakZJT/5oETG2Se79/v9kdjkpEQDr7Yp+OGw79X3NAKPcDAh1QSIBTgD1APIk9
         PcNtWnmXjzVyA/ekAuc9J1Ldf1520O+Ezw0w/Ib2rmg9zLzxvlAdRLVhZhEA8PmWUNiK
         TQNQjHvefwSfVxq1+ZCz986aNPT/4H/tI61eQYAsQJpO4szsu8Cjyex71k+0GpxpujLy
         wBnlnlMi5HipUbm2ZzOkDOrRTbcr6VJAyIpY72aJ/E32HuOp1s4SJDdzj0BVE5V3xg8/
         VUpFjW6w8Fy4sl1gdFaDfoPbhesiNrFc9fyD8+l3IKOSNiiupFoFQbmh3CqhrxND/l+7
         UddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783718463; x=1784323263;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kBOMvPUpfjw5N1/s9nVKhxGNiyKZIoN9dPtD8sVM7ho=;
        b=hHgF8pvEcHU453M+rn6CyAdHYwI3bD7Mm9HaFZgcUtTPVteQFtmvykUrOvOfNj5WsL
         nw1xd5XXBq/dJs1BmoJaMgH8MNUzVAi9lXYoUgMbZrD6h1D/hhDYiM5HMvmqmKsesHwb
         n2hdxeIUk6XoRMWgpZdgv59joWImPBfvDaJpZQZn3Ak+/W1zRvYXYlEmo0F4leKWHDvJ
         EuxYFh+PFyTuL6HErJ+K+dqH3tdBJ7ZoO6b6anGNl0uDT/SRFqsba681+KrLnv5rL90I
         cMjaaOA1QYOHdxjxbLf8GnVzA66HUrh3NPdXKVey4KbHugq1kQGODGp4BZgcBpCkGhpW
         uYCg==
X-Forwarded-Encrypted: i=1; AHgh+RrQ1P8hhHHuQ8fFPlqR+R27SknaXc/VRFxZzVh2/bMNT7ScA1BltBYpxGPmyU6ZXN0AR/DOXy/O4i6M5gFo7M5YrzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxSUatyI9Ch5JYlp6iOksLbwxTStf0dvIoBIVfqo0j/rKJ8MKf
	jt630rkuXJe/SolLrb4To0a/g6GotdwqnQcIIYe+XUF0GbQvlnxphR8WvNT/0EExe+U=
X-Gm-Gg: AfdE7cl7i1CUL7Y7ImTh7x9IGDtAfWbE89SWJ3DiYXyYlaRHKkf8hzWPMDqavMVdTxV
	zmg9flWvpYBvXu7smBOhTQ88h4u9/CAbf20StbT7iRPHTHGC1dnYP2vOzH89rBjIDde9s7yfdeI
	CRkhWM/el+5FavAIQOami6CD3a/8Y0PYaXh5/aRlU9Q9lEITjnEYq7RhoYAuCesubiZM5pLNBLp
	87gkryEAB+oBkLjcieMvPii6iTpZNQRGnWD23PItF+jAakQBKZZOeosQgzG56d3zoIUn6amfgeO
	wrz0VatSbcf0T4BDBkeJj0+pAKFnZAV+ttNSZP5v+HO5UzaZx4Oy7A3Y0Lx0ZMd9IpcPXbiYcw6
	yU863now0ADGkaNnN+VP4/Ah9ufMiSRbKHGlvDDI+Tp8p4SdILsnpu6Tho7aPfAB5s7zHM1nUhI
	Rx7C2zKyw6YtJP6egLSIAOBdvUlvf24EgFkbqCGVUhzEJK7iBk/sVf2E+BbRQOMAoFprdO
X-Received: by 2002:ac8:5ace:0:b0:51c:7b11:41ae with SMTP id d75a77b69052e-51cbf2dffb2mr6287721cf.74.1783718463047;
        Fri, 10 Jul 2026 14:21:03 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caaf621e6sm23894971cf.24.2026.07.10.14.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 14:21:01 -0700 (PDT)
Date: Fri, 10 Jul 2026 17:20:56 -0400
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
	Arnaldo Carvalho de Melo <acme@kernel.org>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Usama Arif <usama.arif@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, damon@lists.linux.dev,
	iommu@lists.linux.dev, kasan-dev@googlegroups.com,
	linux-sgx@vger.kernel.org, etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org,
	kvm@vger.kernel.org, Russell King <linux+etnaviv@armlinux.org.uk>
Subject: Re: [PATCH v2 26/33] mm/vma: update vma_shrink() to not pass start,
 pgoff parameters
Message-ID: <alFiODVaGwd_wYl4@gourry-fedora-PF4VCD3F>
References: <20260710-b4-pre-scalable-cow-v2-0-2a5aa403d977@kernel.org>
 <20260710-b4-pre-scalable-cow-v2-26-2a5aa403d977@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-b4-pre-scalable-cow-v2-26-2a5aa403d977@kernel.org>

On Fri, Jul 10, 2026 at 09:17:07PM +0100, Lorenzo Stoakes wrote:
> vma_shrink() is only used by relocate_vma_down() to shrink the tail of a
> VMA. Therefore neither the start nor the pgoff parameters make any sense.
> 
> It seemed we were passing the pgoff parameter solely to satisfy
> vma_set_range()'s requirement for pgoff being specified.
> 
> Since vma_set_range() is now isolated to vma.c, we can simply introduce
> __vma_set_range() which sets only vma->vm_[start, end], and invoke this
> instead, removing start and pgoff from vma_shrink() altogether.
> 
> No functional change intended.
> 
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Carry over from v1

Reviewed-by: Gregory Price <gourry@gourry.net>

