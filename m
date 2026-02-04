Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D25221F0C
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Feb 2026 12:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770209238; cv=none; b=Req6mVXSuHcZo1bRIv4Nkzs9UW1NVBmNmaVfmmmAPBuZG7ERn5ZNUQqUHFl8WKQ3WQF+3piMhebaC7+St0mt/PdvvRpHsD9LyhFpwF76hHpxX98mRE/kgLHBNt8eyKxuKF5htVuWV1MevV/5KzXJCWZh7W2MCksXvQcrg9IrhKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770209238; c=relaxed/simple;
	bh=sIl8zPvTMavW7op27NWntwAoYxbkYCvD1OGJGO1W/G4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbPXcnjC4mpGnCKawrTA43gl2his5GWbscKvWap2zNYqSLRX65Vn/dkA5HtPY6kT9EhqkrH3hCAR67qs743CWa9lJn13k4zmxNuGmIPF61n29X2aZieSXHtWAq1wb8UGOSiApXUmghNCWoZTtVrLwjfzZGUMcwtufi4MH4thhvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GW4VHNlj; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GW4VHNlj"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8947e17968eso77446436d6.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Feb 2026 04:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770209237; x=1770814037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+U8LpVemtW+m+yu1KTxoehmwVgUgV8X5ud3ORfVCCrA=;
        b=GW4VHNljJYFgI4mruLbg7vYCpHKew/dRjvlqzTeNn86+wrDMfx4zpIj/dioyccLJXP
         XACl0ggJFwCgkw29MoP/25q6//IrEkYd5b1PaWKqIt2jogVrM5cjO4x8m4SXMm5gCTeq
         7+sRa7wqOIMHi2uMMWQ4hgsHW3KpXETuwQdLYmSxbznzYiFF/OpfJ5wYd2+ZEE/Uq1FI
         Y4nSEVvDEDY7SKTbbuouPMPgd9Kb81K7EZt/IwblUTd+zVebhGIivCskRSb47BFJPge9
         pAIPD6qNA+nYIkrf2Ayi8x0N4WX83p8Cy9t0L1BJVFY9mZOU1Aekk1WQ1812YLGIQSQW
         a64g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770209237; x=1770814037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+U8LpVemtW+m+yu1KTxoehmwVgUgV8X5ud3ORfVCCrA=;
        b=imDQ5BqZraRLrdO/aHNSLPMwBquXrbER1RIrvYDkkpGN2NbCMkF7N7MhERQOnEZvhZ
         2taJecgaoZq+4ay3b+KeQnkiyR6xepgUVvIlwrbHHwk9y1F1A5LydRPWGd+NlgE8yr7i
         RaOxHtCKsKuPHwlXWUQa86ta7yIn0v5CSG/y6f3RWDb/qAWper1zQItFqWBPmcTdblZx
         ejbVsX1LkkFDHM/B9G6+iNcP03SCkbDTEO4nQ7m5Bt+9a1IqagCSNa/D26XAffeSTpX6
         QIbRON0Q9OnllU6vU52keM1TpzJy/L2cJvnzmG2m4feHq7ffzvImQScxzzsW/Va77iSM
         Dw6w==
X-Forwarded-Encrypted: i=1; AJvYcCXO+1D0M54p2bWll9s4SyPp8QwaGt+AepOHJ9pJruNTXdOt/x9EjbYoBlThOJIt2drc/5NNLftsdewoEiE1+GnAhSE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7aDGyAwAhQP6AbYpxb+fTWSoIxZkCS6ZcVa/feApqKhtrSODz
	i43RJIouq3T1hgCpOEyloXppEPU1pbg20BzjLmf1Kzty6CGD1jLoPtV8qz0I1OS/WfM=
X-Gm-Gg: AZuq6aJ8wX1VoePyGf0UDnx+LQZrQJco+7n/lErToXEXEMdqxaN6gtpvKIFBozok/Yh
	v5WZPWrBQYRnrQSo6dqicOFtKF0J3MMn6+Ap0Z7NUCoF/f3IgmQee0qe4fnUP4/49Vac2NwWXTx
	mIzH0WQfVTpUn7/jEc3dcsDZpc20ufoyCP5prqQh5Ney20CMPn8vhYbExLSrhQok2tbsn9atVx0
	UAA7TuDTh7M0LmWJCtXEmviEBjc+YzmHYpmDzDWH3F1CkhYWk1yvBsla78z6qx7x35IrwEeI6Iq
	4I2WKcbkvOfmf1JTXhmDlv3xzgnhnfidCyNavH7myRbSlKcP1t7obvzPIT+4Eo/0I73S6yGaDEZ
	kHFif6xoPSfps49EQTTzFj0VRo6MXzQB/tMhoFJscXJlZyRWpnrC7VWie7j6ChSN7Rx5qstlomV
	liOMm/uR9eFhk1bhz9ndL8t6YrgTZyqPm7qUM5B3bgnQA+K3qyJ9KDI4zFn51QlfsrMxk=
X-Received: by 2002:ac8:7f4d:0:b0:4ee:5fc:43d9 with SMTP id d75a77b69052e-5061c0d57d6mr32950401cf.16.1770209236488;
        Wed, 04 Feb 2026 04:47:16 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5061c14815asm18573661cf.6.2026.02.04.04.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 04:47:15 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vncHr-0000000Gzio-1QmV;
	Wed, 04 Feb 2026 08:47:15 -0400
Date: Wed, 4 Feb 2026 08:47:15 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Alexey Kardashevskiy <aik@amd.com>, cgroups@vger.kernel.org,
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
Message-ID: <20260204124715.GA2328995@ziepe.ca>
References: <cover.1760731772.git.ackerleytng@google.com>
 <071a3c6603809186e914fe5fed939edee4e11988.1760731772.git.ackerleytng@google.com>
 <07836b1d-d0d8-40f2-8f7b-7805beca31d0@amd.com>
 <CAEvNRgEuez=JbArRf2SApLAL0usv5-Q6q=nBPOFMHrHGaKAtMw@mail.gmail.com>
 <20260129003753.GZ1641016@ziepe.ca>
 <aXqx3_eE0rNh6nP0@google.com>
 <aYHGVQTF6RUs7r3g@yilunxu-OptiPlex-7050>
 <20260203181618.GY2328995@ziepe.ca>
 <aYLOZIZU0nwk+0UN@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYLOZIZU0nwk+0UN@yilunxu-OptiPlex-7050>

On Wed, Feb 04, 2026 at 12:43:16PM +0800, Xu Yilun wrote:
> > Which means we need VFIO to know what they are, and hopefully it is
> > just static based on the TDISP reports..
> 
> I don't think VMM need to check TDISP report. The only special thing is
> the MSI-X mixed pages which can be figured out by standard PCI
> discovery.

Either that or follow along with the guests's choices on
shared/private.

We can't let VFIO mmap a private MMIO page, so it has to know which
pages are private at any moment, and it can't guess.

Jason
