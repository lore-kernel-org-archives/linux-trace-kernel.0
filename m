Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D5030C610
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Feb 2026 18:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770142412; cv=none; b=pITSXTiE2QAdZmZndcuEYrHDpdGrxg2FUx0J7zMW/nQoukZFjkQX1MkTmuOUGLVJy7vRy28xiUsn/EDcXFS/pjWCfSlOeAKZooGxP5zcGY0GichGJChLjOGzc9ATcDpJnHWbvYsADB+CS9tzdOMnyt1wysaItX1OSo4sBgTCuiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770142412; c=relaxed/simple;
	bh=RgOdFHuomUx5cdPp0JGsemA2d5RVP7tNLyg3IMDaEeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=muaLEntbXr6K58RrbIAX3gFBD5pq86sFFzxkEZ8Zr9JiX5XL3o9nk75UKdcoxw1y3etDnTJmTpSEuc6NbhCiG5sgj9TUFuiTi5EOp+JizbCEsB5YCK51fldNTaL2H8VHuMQAbR6kIWCzt4ywaZm9lMS9xwEorHifOmWGS3gC0rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=oEtrnln0; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oEtrnln0"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-505a1789a27so30772101cf.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 03 Feb 2026 10:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770142410; x=1770747210; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6rLJUepMBePw2/6rYXVBVUlKVexPKPCi+MRpKxp95Xc=;
        b=oEtrnln0aEZ4MV0c7yM9IqhjQJwWubUZvYjG0eYwfhve6jxrNk4n8MxL3DLkkdoP9b
         kx7SpDoUiUgB/4j4FXTa6wT/5bJVCntjPC+YUkAUjjM6JEBFbfzRRcDfbnYL1Ty/K6IR
         zDjTnSTQ4a7xN+t94xh6VTJzVcusgQX1Fa5bp5oMdFJfiZtqO0IAbWOiZS6Ym7+PMAlq
         cs8vA05/EjHp4IAd54Zbkeh8JO4WWepY2cxXHjcYHu/8BYZI/R+r1j72G3yWN9nmRCvi
         js2ObNs8hhOsQVCVMR3dJ1LPwj8TX1NDKqnc8QzgnP9ykQxeOXuhpYtDczTB7OV/IRyr
         3yvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770142410; x=1770747210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rLJUepMBePw2/6rYXVBVUlKVexPKPCi+MRpKxp95Xc=;
        b=iOa4qRhKUOwnTUg2Cp2Z1D8RNon1PIDJ5ewSjv30lE6SzhhyecXU8oulZlBKpex1Ch
         5PCmHy4aeX2UDfxokMEEHQfmxcskgZrRL2EhpphoMZRjICNJ0QuUpxkbaQIvja07Xlqt
         RwjtS9OtNQjK6JAfBpN+FfYnqtjpuAYLgTkaoNimfj4+cGFFQtrv7+ssRY+AYZi6HVWa
         +Av12PYHPn82qwMUgYFa/1hwpvQ5mPVlifPJKHw8F+w3gzmu6AfKz6uKObDJeubBFHp2
         PzDHCwyP9+orXmXmufMJAn640F9EVeks0JPYY6wrCbWyd0lXl1Ynej97TC4C5AJwkkyx
         jZwg==
X-Forwarded-Encrypted: i=1; AJvYcCVDRhBhpy5KyVTk1DZq/RA6bYuiYyMFsBQA6mOuAXsH/TRcPvPhVDb0S5k1DJQ23SXo3CvVkNqfwvn/aoGWxKqEzyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYPXRk9YVkPxWbpmPu90gfMW45vd7Ks9ksvJiNhsKIzDfSRvHK
	oLa9XxgStoiFcoHI3s8CLH/2f9YGHwCr0G8bLgI+jq7NEYvjRP1oQMZSoTR+sZCkzWs=
X-Gm-Gg: AZuq6aLZ8Ypu8uSHtwbtuzERVSvJi0kBNzXUN4/uyps+j9/KTzZAw0jWtudn6HOt87P
	2iS99wFcw8Jj7Yj001MWbeGR7OHMIA8lpiCE4Ct+E8xnD2uBV5Nz7ckZvvzqX7EZvPBw8OigaNU
	3Q9sGLPVMWB8NicDCEDCsL46awYbpisEAT0tkXxGAlJqM9xa/deDC7whTI3k5emOr7XnsKyU84O
	73MTLvLMyqgfX9igDc6DTE3ILqbZOscAbv4/SyV3Y0FV03TP58Nlm8FIrLbYdJ/VpdqOK2MSRWY
	VusaBTjG5qsWrit7z1m8drTrIp3heA/i81v6z2kftV/WheI5FMdfFn9xMhlDcuUwNvfPlWmvEqT
	cU+Ly6u6NmfbTducCbalNGIukXTurPeleY/qwY3QGJA7LCYmFt3p9wqwPql26Mr+1GVjH2NZi0a
	SDucJ58/AF2GMmbMoacdXb0SsQpaAQk++MBmKVT+MPQfd3qrv8qwCpYbWPoH3d1afiUBs=
X-Received: by 2002:ac8:1402:0:b0:4ee:42e6:a5 with SMTP id d75a77b69052e-5061c1ae28dmr1930741cf.57.1770142403217;
        Tue, 03 Feb 2026 10:13:23 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ca2fa55983sm22226185a.10.2026.02.03.10.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 10:13:22 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vnKtt-0000000Gaft-0KdL;
	Tue, 03 Feb 2026 14:13:21 -0400
Date: Tue, 3 Feb 2026 14:13:21 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Ackerley Tng <ackerleytng@google.com>, cgroups@vger.kernel.org,
	kvm@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	akpm@linux-foundation.org, binbin.wu@linux.intel.com, bp@alien8.de,
	brauner@kernel.org, chao.p.peng@intel.com, chenhuacai@kernel.org,
	corbet@lwn.net, dave.hansen@intel.com, dave.hansen@linux.intel.com,
	david@redhat.com, dmatlack@google.com, erdemaktas@google.com,
	fan.du@intel.com, fvdl@google.com, haibo1.xu@intel.com,
	hannes@cmpxchg.org, hch@infradead.org, hpa@zytor.com,
	hughd@google.com, ira.weiny@intel.com, isaku.yamahata@intel.com,
	jack@suse.cz, james.morse@arm.com, jarkko@kernel.org,
	jgowans@amazon.com, jhubbard@nvidia.com, jroedel@suse.de,
	jthoughton@google.com, jun.miao@intel.com, kai.huang@intel.com,
	keirf@google.com, kent.overstreet@linux.dev,
	liam.merwick@oracle.com, maciej.wieczor-retman@intel.com,
	mail@maciej.szmigiero.name, maobibo@loongson.cn,
	mathieu.desnoyers@efficios.com, maz@kernel.org, mhiramat@kernel.org,
	mhocko@kernel.org, mic@digikod.net, michael.roth@amd.com,
	mingo@redhat.com, mlevitsk@redhat.com, mpe@ellerman.id.au,
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es,
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com,
	paul.walmsley@sifive.com, pbonzini@redhat.com, peterx@redhat.com,
	pgonda@google.com, prsampat@amd.com, pvorel@suse.cz,
	qperret@google.com, richard.weiyang@gmail.com,
	rick.p.edgecombe@intel.com, rientjes@google.com,
	rostedt@goodmis.org, roypat@amazon.co.uk, rppt@kernel.org,
	shakeel.butt@linux.dev, shuah@kernel.org, steven.price@arm.com,
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com,
	tglx@linutronix.de, thomas.lendacky@amd.com, vannapurve@google.com,
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com,
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org,
	wyihan@google.com, xiaoyao.li@intel.com, yan.y.zhao@intel.com,
	yilun.xu@intel.com, yuzenghui@huawei.com, zhiquan1.li@intel.com
Subject: Re: [RFC PATCH v1 05/37] KVM: guest_memfd: Wire up
 kvm_get_memory_attributes() to per-gmem attributes
Message-ID: <20260203181321.GX2328995@ziepe.ca>
References: <cover.1760731772.git.ackerleytng@google.com>
 <071a3c6603809186e914fe5fed939edee4e11988.1760731772.git.ackerleytng@google.com>
 <07836b1d-d0d8-40f2-8f7b-7805beca31d0@amd.com>
 <CAEvNRgEuez=JbArRf2SApLAL0usv5-Q6q=nBPOFMHrHGaKAtMw@mail.gmail.com>
 <20260129003753.GZ1641016@ziepe.ca>
 <aXqx3_eE0rNh6nP0@google.com>
 <20260129011618.GA2307128@ziepe.ca>
 <586121cf-eb31-468c-9300-e670671653e1@amd.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <586121cf-eb31-468c-9300-e670671653e1@amd.com>

On Tue, Feb 03, 2026 at 12:07:46PM +1100, Alexey Kardashevskiy wrote:
> On 29/1/26 12:16, Jason Gunthorpe wrote:
> > On Wed, Jan 28, 2026 at 05:03:27PM -0800, Sean Christopherson wrote:
> > 
> > > For a dmabuf fd, the story is the same as guest_memfd.  Unless private vs. shared
> > > is all or nothing, and can never change, then the only entity that can track that
> > > info is the owner of the dmabuf.  And even if the private vs. shared attributes
> > > are constant, tracking it external to KVM makes sense, because then the provider
> > > can simply hardcode %true/%false.
> > 
> > Oh my I had not given that bit any thought. My remarks were just about
> > normal non-CC systems.
> > 
> > So MMIO starts out shared, and then converts to private when the guest
> > triggers it. It is not all or nothing, there are permanent shared
> > holes in the MMIO ranges too.
> > 
> > Beyond that I don't know what people are thinking.
> > 
> > Clearly VFIO has to revoke and disable the DMABUF once any of it
> > becomes private.
> 
> huh? Private MMIO still has to be mapped in the NPT (well, on
> AMD). It is the userspace mapping which we do not want^wneed and we
> do not by using dmabuf.

Well, we don't know what the DMABUF got imported into, so the non-KVM
importers using the shared mapping certainly have to drop it.

How exactly to make that happen is going to be interesting..

Jason
