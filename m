Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A3542CB0E
	for <linux-trace-kernel@vger.kernel.org>; Thu,  9 Jul 2026 15:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783612564; cv=none; b=rGyTTHiodSGPmnNAqkI4lK4GhsXNTzkdVyaAsb7ZpW5GqzNXILIBVC9AgqSRsYTTVF2dLjgFzQz4oOXFQTbPGZ4E2Rs6ROx+yQF88bDelQAll24wx3r9z3z5iaRpkvZCe/sNussy9pknC8mALH0rHQ7wRa1gCzwOnmqgjVH8kNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783612564; c=relaxed/simple;
	bh=GOt99IJ7fgZPI8QmxyNzz1MEgzG9KnOmLnnihrfLrQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INg3p4c4SDxrEgW/VA9vXrLVCGjSoYt4HKqa/E0hQx9V7uN69Bu3YBKPZDYPkZcCi/yRGMJDIP1+ReZUJ6rK25ofXydqikkyxmC6Ar+EwHF7wfHyEpkMSo26Mu02KFNApFdo/6Dg7H2/iUmPyl8/kZnj1+4H8vY+YGbhG0yBqwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=sMpYtpBL; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="sMpYtpBL"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c05dcdf49so18759601cf.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 09 Jul 2026 08:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783612560; x=1784217360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QupnWz0oLATZw6wM2bylQaqDWCRhZF5lJVU8oFwJF/g=;
        b=sMpYtpBLCayfT80R4wzbFZw9l7ecn/vectK5E5n8YBo3056+zypO+Cc5p+yKRJvgIH
         D/H6T9Xrdz6iMSYSYJvVieLq3byHbILjhri9t9JTeNg3KDdjrBUV59FOiPGxnwtT9VLy
         HF1d3IK7IocXO7FJq05gOC0dLYoa87K4H1Npkig9QMat1/arxBuPsjrF4STTmp+4SQnQ
         Vd1Ce49g4dasiNP2aD+fvBhZQJshbx6AC4CXzbMk76CVDp6xBP46+fI2JhSkG6d84zie
         Pt83KOr106cJz+pCklgtC47DW1rTZUKmoVq5ykQpYsi9pRg2A/xacQcZB/ubsxgpernK
         7WxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783612560; x=1784217360;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QupnWz0oLATZw6wM2bylQaqDWCRhZF5lJVU8oFwJF/g=;
        b=E24PuAXpzr5jb3j/JQDn3kvKqxpjOrPFXG04CgDxXYTmbm9C3Cuyy8H0gBiTcUNAf0
         hZLGH/FbWa2bHy7RrqPmgT2V7AC/KhBfjWYwhmDjuEHWV9+HeTollw5x06x0+3KnutLF
         VBhOKVAcdDyhpMZrUqVm6W9wQbnpqIoxaeWIECaqL1k+CmJ4tx1dvb1P5NLv/m/j31WD
         AJ2EEZIkoNNfFFfVlciJr7SfFlnB4pWrNV0ps7RdlUmUCtgcPbuH2SIwM5OJ4zmKLXka
         rqoU8Alr8iM0bKLlOKVW0zNnafIX5+xObKZ56HnFD6muC35Y0kbtvYbq/rywQuUBmTkn
         UoFw==
X-Forwarded-Encrypted: i=1; AHgh+RpPgb48Rd6Yq4z8AGaBP2l+r29t/NRVQigbEf14RBEd5mhiaW+xFNf9or9Stk9Zk6+dhqlKvm+HbFP348kuIMJWn+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQS+WBHsL8tPbpV1TXV0G5Jf1zQXmJHlhsjKFXNoimLqQDQC/1
	hR42Ixz0fcw4aBVPqeJeRrgPdHfiplyCnrCmRq3/6r/WWBZ/W10o7/0tg/uvlhGqZro=
X-Gm-Gg: AfdE7clpaIq6+su5cgl5MPm2k2Y15ch1i2xiQ38x3wCNabXPsF8yZQxycK341vHWbx9
	8mtpxsN4ZSdYBCEwiiYHiyLFh7DVlffgMARLG3lYTCty7XFI7871Q661l25bsOdpmdVNbQeT2qs
	zW2WtVuJGIVCjRtzUq6F/v/LIHZsAQeMzlxLihyZDTrrHVHMznNC7gIbsn35yXeToMofi+w6i/k
	peLRyKmiWxnvrl+x5XoOC+Q4A7A1PuxPiDWDBPVBerEgC4IxscZUJ8OsOXCmPjK5/FggIO2M6z0
	O0DIDSbmgCwG/ezf4H4D0COR+wA7nIzRWxO03bxvtn66AIMAgHpk2N9mXK/GqcfQdYJwKLSc37G
	h+eTXFy/7QZeRXFuRDYuoEOb/yfbHHiqu7baK7Hlo5BueYNou2WTjA02YeTpNUWSRsLjY6PwXsb
	DitvvJnGAtGQpVPIeRZgNki9EWr//tIUHX+9Nx5jkC3/XDqwDAT3JNcSMzSMrknMsIIMgt
X-Received: by 2002:a05:622a:311:b0:51c:185b:29e0 with SMTP id d75a77b69052e-51c8b2ae67bmr82998651cf.10.1783612559586;
        Thu, 09 Jul 2026 08:55:59 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41d2d688sm169684691cf.17.2026.07.09.08.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 08:55:59 -0700 (PDT)
Date: Thu, 9 Jul 2026 11:55:54 -0400
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
Subject: Re: [PATCH 19/30] mm: use linear_page_[index, delta]() consistently
Message-ID: <ak_EivwcDDdn1Xvp@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <bf56e2e98b512962a2fb88900d535a0e9e6769d8.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf56e2e98b512962a2fb88900d535a0e9e6769d8.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:30PM +0100, Lorenzo Stoakes wrote:
> There are a number of places where we open code what linear_page_index()
> and linear_page_delta() calculate.
> 
> Replace this code with the appropriate functions for consistency.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

one nit

Reviewed-by: Gregory Price <gourry@gourry.net>

...
> diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
> index c09bbe04be6c..536c25d8dcee 100644
> --- a/drivers/comedi/comedi_fops.c
> +++ b/drivers/comedi/comedi_fops.c
> @@ -25,6 +25,7 @@
>  #include <linux/fs.h>
>  #include <linux/comedi/comedidev.h>
>  #include <linux/cdev.h>
> +#include <linux/pagemap.h>
>  
>  #include <linux/io.h>
>  #include <linux/uaccess.h>
> @@ -2462,7 +2463,7 @@ static int comedi_vm_access(struct vm_area_struct *vma, unsigned long addr,
>  {
>  	struct comedi_buf_map *bm = vma->vm_private_data;
>  	unsigned long offset =
> -	    addr - vma->vm_start + (vma->vm_pgoff << PAGE_SHIFT);
> +	    addr - vma->vm_start + (vma_start_pgoff(vma) << PAGE_SHIFT);
>  

Obviously correct, but was this intended for a different patch?

~Gregory
