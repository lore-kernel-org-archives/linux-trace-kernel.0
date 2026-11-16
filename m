Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794861221;
	b=KlqcqXFxu8tLoWSuvO0GIrPvaNwdlWoCgaCbT9rr3CHRbvMtiJFa0r2//M7BDc9kQjch
	 4CLXwChqvGBzYVmz2CNJrYiKvt80n85NEtOAKtHTF3X8xpiYYWc7aJP8Ll9kSz/5PjGE5
	 qZC94JL0PZ2hPvst9F+kpt2QcN6anvgsTEPDwPLmxr/9YTQErHzlb/4ix6RV7M+r3F0uM
	 LAv1PiqJOHtYI4+x8U3I7NNuaPtuJU4BGTW0S2xOX9GGLBx4GpczXfjT2G547oWHQVCvp
	 W5YdVwtxEnmCwQ4WIpz4GVlrFCwWzYErolJXGryRua82/UszkY7EopzQYKyyX7r73qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794861221;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=FRUBObM4vFL1TGf3o6s1ZDBsKZdTJ/3jimI0MzXw8Fk=;
	b=t18U6vO5Q3OZGcGgIZCMq6lg5iMiBOikaXoTzit6Z9c2H8+RmLpZ3tAgOiT1Q8osrGkI
	 8jP0JCNN75MOBZLX9pmV1xnrB/2Z12IgbpkgzjknNfbPUSPukMW4fGjrGMUp+EI8o8fi4
	 SYgYHI/iZZMSKMgtJ4UNWDYVzmdJOimjTpTZliGG/iWezhI+ORMb48gT1aJfFhIeNOx0K
	 x98MwgU42W1FB4HiO4GzkVOLpa7WXsGrLGZUf6ryOnfVyqWvaaOkgNRFEKfzzcEN1Qfak
	 ptpV0Cf0ATtDjgEDd7uPuLPS2ZjHmbhY0ZIL+1at6YbsHgAxLbOUehDdrb6G4MA+XYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=W8qlgedU;
	arc=none smtp.remote-ip=209.85.222.180
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2870E606A33E
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Nov 2026 20:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2870E606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=W8qlgedU
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-945e6d9ceeaso409930185a.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Nov 2026 12:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794861219; x=1795466019; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FRUBObM4vFL1TGf3o6s1ZDBsKZdTJ/3jimI0MzXw8Fk=;
        b=W8qlgedUXT2a/t6lhLP87IFTcy14JLKYa/mLodRolDlr9xZZQGxtW5Noy7E031dblU
         MZyTiD0CS6csrzNdM/y/kT9cZThOJzBfJnBjyuudT36134JK9rL5Y+cJlR9PkLw6In16
         I1GQFmpXC+GQjLACTJo0WVW99izKDBVRyEpioO38WVT6BB7yoB56iiO/mZo9HLJwUqYy
         WRepiT2m5sdFzS0WIaIky8pQ9PM9gsPwA3F1oZ8AlieRWNRm9qrQr3NdwmjMdkz0t3US
         NP5znb8aU6kvol1hpUX4T2gg8E0YcF+imIMZKWdgwp2eC1/JJZ5bvYf6eHZddNlll3GG
         nyWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794861219; x=1795466019;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FRUBObM4vFL1TGf3o6s1ZDBsKZdTJ/3jimI0MzXw8Fk=;
        b=DDrHCpQLzMNDAKNhWc/IOEDcj/WOfP496QTaVs06wDAL8HPqYKPCgb04LIz9QhgfGv
         sA8vwABCPA/ImGhvwQVh9WI2zpX6foXdYCeCa8BKDwYJTc93ZcVEgkGYhU5kzthkj8RK
         dIcYzhIblZU0ETFjtRQfMUKqe1hCUyBxyUvc0UulPfDSAUJPH/Zq9kCunYkUbZN9TVCl
         Ge/wtVatBqHGsLbhCct5giF57SGiC/ojltpCm11MDjGgzFTklYhTaFpC0Py8ja6UO2Gv
         MjT4S4YVblRrQa/cI5ktG7gfFoLF3+q38C3M5gChdY7KoLMnwH2R7lawOSxdL0uKsoNw
         gpkg==
X-Forwarded-Encrypted: i=1; AL+hErH/+A1MceQ9vC+RLtBQGCJaHRkbVzleGoVSOLuwDVxMpuaNb73ApNgf6AZCYZnCfVbwiheAS23gaju9qwKu99TUQhU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9IR011C/ARJbf0WKsBrbR3xuscTpaRjNCBh4hqqWBE0PZGexHX
	subuwk3niW5issoJXYOCTsLdDCttp7wM0bHB2bOLHAtjxidCpAUxyAVfRd+aMURzbYY=
X-Gm-Gg: AYBFou3yFd4hknBB8mjOCC1X6Tmk2+kp3+tWyrj+A+naLEtT+7yJBHJBRGNSgrYNjtM
	MlolnM4FviKI2Sk8161EZmaMIjeTWGUhEnUc+wfGVMYDEoK+jvIRn/NDtslv2Iaa5xLJ8OGTJj9
	j/fdlXZPIzz7MLo06XsvqwTmTKuJGSrvWqbCpoS7RWclxdKSK5F3jsqGWoBc5TxAMUckqGcgsRx
	YSTqYRkFZWbXpscOSBnCO4kZPseTUrMl2ouNfy5mpuMd09LsPsdawz55H9J207FzC61Q0ljOZhd
	rDSc4VezbrGsSzQfz2dSsXLwIVfO+5qmmtXRXqg+RAmRqiNxT7X60y1usjwCEiS4+jULcDvT868
	fThP02zWJikvI8DXb4msEirMcHhYdSdrq3UlsOgTwMehqdrFt85ozSf5bsqyu/ZK0x9gZQEGgkz
	aL2Hwbun7HB3hF1IitNOwLZQxMCKPifwJ4rxFsISmAG7gddWkZOucClu2hehYScSs5OxrTIKEfD
	vgCJKDYp/9ifl3lJOe1ME4UJSaO7sYciXpGUN0vK0mSw7tPTgkOZiR2kWQf6eha/X55g9yA2VXt
	J+Ascg==
X-Received: by 2002:a05:620a:46a6:b0:949:733e:ddd8 with SMTP id af79cd13be357-949733ee766mr1034555085a.54.1794861219140;
        Mon, 16 Nov 2026 12:33:39 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c804f9esm930800685a.11.2026.11.16.12.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 12:33:38 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xT3OT-0000000ARJs-2rZa;
	Mon, 16 Nov 2026 16:33:37 -0400
Date: Mon, 16 Nov 2026 16:33:37 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tao Cui <cui.tao@linux.dev>
Cc: akpm@linux-foundation.org, dgilbert@interlog.com, mkp@kernel.org,
	loberman@redhat.com, jmeneghi@redhat.com, kraxel@redhat.com,
	vivek.kasireddy@intel.com, mst@redhat.com, jasowangio@gmail.com,
	eperezma@redhat.com, stefanha@redhat.com, sgarzare@redhat.com,
	rostedt@goodmis.org, vdonnefort@google.com, mhiramat@kernel.org,
	kevin.tian@intel.com, axboe@kernel.dk, linux-mm@kvack.org,
	James.Bottomley@hansenpartnership.com, sumit.semwal@linaro.org,
	christian.koenig@amd.com, phasta@kernel.org, joro@8bytes.org,
	will@kernel.org, linux-scsi@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
	iommu@lists.linux.dev, io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org, bobbyeshleman@meta.com,
	mathieu.desnoyers@efficios.com, robin.murphy@arm.com,
	mason@kernel.org, aesteve@redhat.com, tjmercier@google.com,
	harry@kernel.org, vbabka@suse.cz, cuitao@kylinos.cn
Subject: Re: [PATCH 5/7] iommufd: account the hw_queue page array to memcg
Message-ID: <20261116203337.GA2481588@ziepe.ca>
References: <20261106131829.3228926-1-cui.tao@linux.dev>
 <20261106131829.3228926-6-cui.tao@linux.dev>
 <20261116195213.GF2452510@ziepe.ca>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116195213.GF2452510@ziepe.ca>

On Mon, Nov 16, 2026 at 03:52:13PM -0400, Jason Gunthorpe wrote:
> On Fri, Nov 06, 2026 at 09:18:27PM +0800, Tao Cui wrote:
> > From: Tao Cui <cuitao@kylinos.cn>
> > 
> > IOMMUFD_CMD_HW_QUEUE_ALLOC pins up to max_npages pages just to check
> > that a user supplied queue region is physically contiguous, and the
> > page array for that check is plain GFP_KERNEL.  The size comes from
> > cmd->length, a u64 that is only overflow checked, and the array is
> > freed again as soon as the contiguity check fails, so the allocation
> > can be repeated concurrently: a 1GB region costs about 2MB of
> > uncharged memory per attempt.
> > 
> > Every other iommufd allocation that scales with user input is already
> > charged, and the pinned pages charge the mapper at map time.  Charge
> > this array like the rest.
> > 
> > Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> > ---
> >  drivers/iommu/iommufd/viommu.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

I'll just apply it, thanks

Jason
