Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794858736;
	b=MC+GaUAASSslI0H3SISL9CgzWRShUVSWT4289d36ie4JtbCE2UuwwXwJI8X+kyVVU39A
	 LpKPF5oTOPtmyd34HjK0Sctdz9Cdo9x2ov2c6JOPNG5gvfn6uEryS9svd1Fqnp6MNMu2m
	 N/K7osnv6fJ+0VElBNTlLjKAv2tAci/0qrS7isEefLtqVoQJa2y6a72h6btEkp8FEGm7C
	 O3bMlhPjdcveTV5NE13pAMv67emMddsDgXgSFsQkHFyMGvI7//Wj6ufx3WK7quUO20hyf
	 TR0crODYA2j11qNJm9TsV4k84+80nwLYHQaCWeRIVBDZBmxYmJIK8Hp7W8vkCdp0rbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794858736;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=jqnrRoTh5TcWr/Py+gEgzzX7wdMhzTlFxFkfLcpGuJM=;
	b=u0qIyGTidTXuolqJLCjaaUiANFALGNujXA+WYPFcQs5BlTxR1KDWTo87s+cuexZ+eurP
	 r8tLGCbrj3lf6gqE4+BLB0/MMIBrczatnoUpu6rJbSWz0t8E8EfM3RRgOAgPrHfmwKn9z
	 h1iudu7I0C1gKy6Asgreet+6LMSbKSzPYW9XrzkffmPbhmiuaKqB1+YTfh3lMOVBj5XFH
	 C0SHRmMIaWOpYLMPbl9UuW30IciyNHcJKnAVXE7SQ9s9AleGFNLm1Llf649DvtIaACVlx
	 2fvQSsRbzxAQjbyWbDnKz9zsxiD7DYgeCQMzocg9ITalJXEsyubo+Zh36LZOSj+7xIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=YcqWJI31;
	arc=none smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B82606A330
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Nov 2026 19:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18B82606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=YcqWJI31
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-55d2dcbb905so19718961cf.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Nov 2026 11:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794858735; x=1795463535; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jqnrRoTh5TcWr/Py+gEgzzX7wdMhzTlFxFkfLcpGuJM=;
        b=YcqWJI31Q3We3zqNvL52aNkFr++cowdUSJ0aOSCLtCZgOyPTfxfZMV4aawKPfLKj7g
         4m2sGeUiA0CXGadMrFuMRIl89TE0lacup406nbrhvwqwPIX8FxoVlYidwE8/s7P7Wszm
         OrbfdLGk33YGmzpkBYmsq4F3Mxnt+4Lu+TymHPjdbgW2SfeAeQs52uRWqh/1XVhhLOxn
         GvpMlDfLIXvCkNJG/BKPMpLBeKmXfFzSUPrKKeUURMUv+fsornqCLKr9GiRTo2LK7Tab
         rlciZWXd7u0mEyCoyMVRbS74CtgQ2ZcTLr22IpH7H7u3DgVnSQkVWAwVkGPORAQHY8UQ
         R7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794858735; x=1795463535;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jqnrRoTh5TcWr/Py+gEgzzX7wdMhzTlFxFkfLcpGuJM=;
        b=pk9aNmIIdsw9DPelqKbKrg1elkn4TyVMK+m2vS3fIlNjb/6rabzt7/aCc+UI909JGp
         GS83DHapvGgd3YZAVlQeGGhmaQpgGguwAk24rSgDsAtzkm53bXE57WZZOH+KqWc2Vhjm
         OLVPNr6em/s+XCmVKeKbUGU/1kYq6isZMqg+dyQ2VuoJCLsQ//7oPy1+RArXIG0wKGAb
         U+FOfuxczc4E5Q/u3g4XdJDPaALYYGWgdw61DTmaHUYeHkz1XmEIv5kaTazb+cKMcEUx
         KpxYyy8hOfspQgNEt3zvpVIAhw8RYzwSHpnp7ISFCbLJf22JR5FOGXCxb6G+qgV/mWAt
         YISg==
X-Forwarded-Encrypted: i=1; AL+hErGaVBbuAze060JCkNctlho0on9U24nhXedlJs5DZ99ooEoIlFqHiy7+i8W6fHW2mFZmuJbPtgc7MZ+uVPP2SAoK3Ig=@vger.kernel.org
X-Gm-Message-State: APuU4Z8m9e7dha/H282dBTUp7BHotIOEZdK4gznGLSiwA0JQ8puhGV0e
	f03hVvKwqtMPUvM7zz1RVWkTVIrquVYkF6vw8D+uQvYuoOGpkd64eXZnn9Fd2ckGzuw=
X-Gm-Gg: AYBFou0A72k8BjZSGqgkYiegsO8ffCnBseR8sPq7EgZRWhWR2pozJ21pR/mxvaqBAX6
	R0YRSRv4HoaKboq5TlZU4SvYF7AFbq0QIYs+vyZ2gYh5srgd8Pjp52Z0kGPNYrnhPNs65c8pBd5
	GFJ4I8G0vLm0IZ8J/XMyHtqsA7VrwObw/FPzLw4RXCCsVccx9K+PZh0acfCx/T+K1cdh9Lg9m9N
	fuZtfRkZiF2rBVhLGCqVPU9kiAGGqHeeyDqhiHZ45nO00b2b3rlpeQRQQ2CgDPbuHiNt1O8V4zm
	qQG0lIgXBXLifCpHIs1RflemWE6KRzaUWTWltmxdhD6la2kyaPB4rlO58eXOuOPxsc/7fABVNjJ
	e9mbz46j+usQ+FhX5zoRMWgn4vo1+Yj9i+bUFJA/Aedp4nCeM8ip0odcYNQMcFc1pwea0TnJW8d
	Bt0ngnjsPTXKKj8GOG7up4+HA103IL5AHwWtF6OQZkNAKr/6Dbfhj4EHGMMaAtSKZULTQg6TsfD
	QKPClyLu3D6D3KybmSO/3BcKgKUeSrw8T+Zd8kHMsd4FUYyS6UWjAI0oDil5AOaWJPpEwEB7vwn
	EWf2zA==
X-Received: by 2002:a05:622a:13c6:b0:55c:c7ab:4445 with SMTP id d75a77b69052e-55cc7ab469bmr121785021cf.29.1794858734926;
        Mon, 16 Nov 2026 11:52:14 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f8319d44bsm48973876d6.4.2026.11.16.11.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 11:52:14 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xT2kP-0000000ALbT-12cG;
	Mon, 16 Nov 2026 15:52:13 -0400
Date: Mon, 16 Nov 2026 15:52:13 -0400
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
Message-ID: <20261116195213.GF2452510@ziepe.ca>
References: <20261106131829.3228926-1-cui.tao@linux.dev>
 <20261106131829.3228926-6-cui.tao@linux.dev>
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
In-Reply-To: <20261106131829.3228926-6-cui.tao@linux.dev>

On Fri, Nov 06, 2026 at 09:18:27PM +0800, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> IOMMUFD_CMD_HW_QUEUE_ALLOC pins up to max_npages pages just to check
> that a user supplied queue region is physically contiguous, and the
> page array for that check is plain GFP_KERNEL.  The size comes from
> cmd->length, a u64 that is only overflow checked, and the array is
> freed again as soon as the contiguity check fails, so the allocation
> can be repeated concurrently: a 1GB region costs about 2MB of
> uncharged memory per attempt.
> 
> Every other iommufd allocation that scales with user input is already
> charged, and the pinned pages charge the mapper at map time.  Charge
> this array like the rest.
> 
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>  drivers/iommu/iommufd/viommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
