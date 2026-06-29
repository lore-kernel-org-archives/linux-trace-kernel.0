Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C053A42E00F
	for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jun 2026 17:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782753089; cv=none; b=mM81fCRmmBD9f/6gsQaz1QKH4JNQelIkpVOzj9yDKpJRy/iXBjzmrvjGWKYylSF1Em7bZpQ9pZhsBdDf5BNWHiHpJne7wLgaN76VigSSIXi00ShEw5UB7SDFjGS/laLe6pfJRD3t5wFWI+YKLzgwnJKN6OAcaURAq84VYV4L3mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782753089; c=relaxed/simple;
	bh=NzS+Cir/zCg/P5bHO1uwaI39NGJ0soZPEUZf3jpz04g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nm9mP7TcADiljmQ711PadDHZooY85PHoJki3p6dUqnYwCMAlSrVJQdqSF8VctfSrZ96aRW+rQbaeJhmXtoWuqNNOYUeOXBT4HPdK/SgkF58EsLojNjvbjhmnugPeZCmCOviF/IJ1PYTUk9QXMFwsLhDxLAVsnt6yb6nPNrhgYzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=kRN6V9UH; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="kRN6V9UH"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-519eced8cbeso52128951cf.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jun 2026 10:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782753086; x=1783357886; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C6+KY00whvPT5nv3+mPk4rrEbELgRer0MfbyQfoaO+U=;
        b=kRN6V9UHAwpM/B7ZQj92hJHopNqlsQzIOmXqJMvTamcPlxklFV0LvQy3QWNM1QP7Cg
         GH/B6j4NR8EjGWtJ7y0rtEMD72lM/Ol3O+kcCCLmBYgCUwpCnz6M1Vza/HDIPhr6Ho4g
         FS0AYtSrLnOR62Sl4+Fp9dyFooraqcXxfpe7UwDAsCQUNyQjDBIydzrxtTHhX8muDIPl
         2ceKAx0MDUrzb4lVg5ptX3iKHFRgKue5Hj9zJmMze7I9Iurb8+M5gdBoW3w835DtCSQO
         1zERXqGaVZ5i0l6HUbCKx7j/x3Ayfyuf747TFFD7HbgApsGBKGgEEuj3GQDHNhvWC4aK
         pBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782753086; x=1783357886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C6+KY00whvPT5nv3+mPk4rrEbELgRer0MfbyQfoaO+U=;
        b=gzzD7fg+2sZl6SKq3PmmxKQwznfDzCdbZaWep4WAFq350Upc5HX6s/xlFGxv/NMPWL
         paUcrOiGdzCj7cSwIE4BB0iYfP8GN2BWn7JjQsiwOFxdhPoZEAC7X+Ql9m0tbBT6YZE+
         9f0uceWjcj6GXdV+racvhtv7jTqtmIGRZOx7kw2OqBIx5U/VYiB4NPY+Yv7EcuRsX2NV
         m+DO5DqvOQ88TepdJ+U1pQ1kcfUEdJD511ewsxEjdFVMykdefd/t/s9v0+iARU0Yx2B3
         izd/ndnaJSgh1Yt3lclbpQJYEqR3xsFDoMUKyxmuRY64OnsO9NaNOiuHTV8ZXQTk4f5t
         2wRQ==
X-Forwarded-Encrypted: i=1; AFNElJ91NhmHBmBvlhSrUkPcsAQSUl3L3tXy8JqZc25imNv/EqpKLeK8CGhTjh/joucNdPCajzxOx9gNPwOJvOXjTuwY6KA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNd8OgwoF2OYy/bmykuf9D9UtuEZJdOFird0NG8Ql8d9+p0dSW
	gobfhjMl7PMVy+ZABcUp2RkV0mYEStA6BuWOy5XZBJpri5BrjFp5fubnWCrIESSYNGs=
X-Gm-Gg: AfdE7cloCdg09XvpjbpCaajT8SINHSdppBbsBybmbmbHnFPsYJp/+dtihVBk0p0Stti
	9L09fm18D8SfniFrRsJ4iTZm2vtJp0QlUxVzBUSJLjNCR68G8C9t8R04NzWaHtJDOVC5elWdvFk
	coY8xPTIUkwv3GKBDQWFJ7LyWwTwe1IctGsyoJTUdPZnhNWQSZ6Rvuk/XrH//3owemOxwCkwW2Q
	9sdduYryrYTLJRzbJFA0PLPzeJ3poFwO5kwNuunXM5Xh4Jpyx2ddSau9IRT+NiPqHqvcuIOqRe/
	GL/wXuKiOnqxX+rTYbdbOn1gNuub2SkEm3LMRpw9CMrGkZn72o/mzB+IDiI+5CyjCy/FpN1+W2u
	bYj1/QdVpRwYO0ierBEUEKSdfLxwPaUEEed/DzJcGTxJTq471M2OatOoIn7nN5tvFIeBKH+2/TN
	pNyS1SP0xJ9aXczJWf/9o+vZO0InqdxF44xYfkRlrji//cV5ZZf5q9ByPOpurEAFSUkTQBDvzS1
	VhBs74=
X-Received: by 2002:a05:622a:420b:b0:517:58f6:29c3 with SMTP id d75a77b69052e-51c107f633bmr2561751cf.32.1782753085667;
        Mon, 29 Jun 2026 10:11:25 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c1080d4dcsm934601cf.5.2026.06.29.10.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 10:11:25 -0700 (PDT)
Date: Mon, 29 Jun 2026 13:11:19 -0400
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
Subject: Re: [PATCH 05/30] mm/rmap: update mm/interval_tree.c comments
Message-ID: <akKnNy64lhNqPtLL@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <80d482a927b2e9862487b812e0ab48ebc1289a70.1782735110.git.ljs@kernel.org>
 <akKWvnU2Ua-8ceSb@gourry-fedora-PF4VCD3F>
 <akKfAl-wdIAbexNR@lucifer>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akKfAl-wdIAbexNR@lucifer>

On Mon, Jun 29, 2026 at 05:41:16PM +0100, Lorenzo Stoakes wrote:
> On Mon, Jun 29, 2026 at 12:01:02PM -0400, Gregory Price wrote:
> > On Mon, Jun 29, 2026 at 01:23:16PM +0100, Lorenzo Stoakes wrote:
> > > Update the file comment to clarify that both file-backed and anonymous
> > > interval trees are provided, referencing the relevant data types for
> > > clarity.
> > >
> >
> > Isn't this self-evident by nature of the function definitions?
> > (one takes a vm_area_struct, the other takes an anon_vma_chain)
> 
> Well you see you're already hitting up on issues there, they both take an
> rb_root_cached and the vma_*() ones do not instantly scream 'file-backed' do
> they? As VMAs are obviously used for buth anon and file-backed...
> 
> But later patches fix this stuff :)
> 
> And I feel it's hard visually to see where one set of definitions end and
> another begins, which was really the motive for this, as trivial as it is!
> 

Fair enough, I scanned the rest initially but trying to wrap my head
around everything as i go through one by one.  Generally this really
screams "fix the apis" not "comment the bad ones" - but i suppose that's
the whole point here.

It's definitely an improvement either way.

Reviewed-by: Gregory Price <gourry@gourry.net>

~Gregory
