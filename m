Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2482F28EA
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 12:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773318880; cv=none; b=oNKaOw6eluQZLsBQgxUZpSqgJExo4IlUzD+QnJ0yyiaHUB/EpDlBdBflA/FvBTojXqa053HBSFyPqxue92XN1Uz9DjXVC9vOMFOdnvSb0t+ucT1wOFBlVmuvy/o+xJG3PtpS8FtbGgLvIR4o2nMPtRArWqAViK6VAi3xW6OHBJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773318880; c=relaxed/simple;
	bh=APBW+HdbDJGC0qi66ebGpgzi6a/5pJAPmLFyIpoPoUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4dZQFz3XRnrwxZwbTuF6HbMOeIwqyvyARh1DaYk7J4g23j7KqL90iziVea51af7XKb2xeJoLCD9OEJs3PVycwG2Hn8hYkUTrzzDzEnCZcV/SstIZ33AHhPkWBztFSz0nlEs5TQqTA+STMbKGUNj0+YCq4Vu0gILSbeptwRxvKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ownQHuOT; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ownQHuOT"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8cd78a4ce8dso120861885a.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 05:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773318878; x=1773923678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ULg7grqreMOX2MMOX7z3yI5zs+73GrCTo1UP0N+hYkE=;
        b=ownQHuOTOoTG7P5CNB7JnKZ3YS6g/Kj+BPvHDxppydLUGu0P9FeCYCozpvrx+M0CvO
         6zQiTL2JTFDUIfRCZ9f6CCGls7LKo13jawgowaQLhPAh/yZrtsyaWL2k7d7XXUH460n2
         0Uxloj5c2y7Pb//ALmD0enI1ADfzsbNbpXJBzR+TpxF0z3V0pCXM/1wTaCy7HoJUxCTn
         uxAXPrvwy7I/0WQExRWhrFpLrCOjdwDbT2BnZitDU9ZthhtuIq+DOd+95U2kp/6iYjuD
         ut/cf4QpMNxMFY6pqgBQBfZXAuwC5O/8KD+P0aKFGwlu5yOwXjQ0xIYL9iJyV+JfI+g2
         hYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773318878; x=1773923678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ULg7grqreMOX2MMOX7z3yI5zs+73GrCTo1UP0N+hYkE=;
        b=vxNWogu7sqCBqphVKO9nafNBSTnM1Nuvh8dFBJFdcE0HfkqcHdpwtyTdqLhPVZump9
         4/cu1d0MRL77o16EOp71H2vBEh02Fk3ni5tvjbZIw2FOkl0SNefslkoE+yguJ731NsR7
         TI6iEPpcvocg41+YWHgNnz/TC1HyyOc00OyacEFwRy2TW1P0PeeCD5hXCftHI6zXx1KZ
         G4hKNpgy2ShOD4nRGpdtEG77E8Px8pAwwrb0X/RJ29kCGxT3SxSBl4GpzlWxznGIw1hu
         RZxpvk/pEolkkgZKz29pxREwBe/fRN+QhBaRjMsnhj3RSBTZIiqYq1qC7ggMb/up06m3
         abdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKBk94Pb+FTnuhMQUV746or6sJH0ZcDFEEdOzjAOTsLr6JjRmcIEvMuzSufPX0OjYgpoKBsniM+hHLzvGKQmeUE+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4wzjroTnzriRc3n1qocXKJINDqfMCavbNX71ybs0X+m59jW3e
	O3GV4lZoNeKuSNzyzbkcmiF98P0QAh+MNYbz9q9WCPJqOtWP2vdQkvZ+umqQe+XoY0k=
X-Gm-Gg: ATEYQzzEH+wYVqfECuJ6Qbg3YtvKimj0vinxWQXCboiPm6/L/N2Vl3tw7AKohLb30Oj
	0fri6C2uF6bw6oux9ECD7FFECR0qp0tLvcITIVvaFkFQJoJs2eRams2AZHjuAA96LtyQviuH+sD
	uTD4O5tqp1IYP7le/n6fhV80BBMKKLz9x0aayLQ/gf5UFupWOreC0AHGklCc7UslxBog5fUkqN7
	VPYuI6MvGTYUFkXdf94/9LmDTAR4zOwEo8BtV5LDRx725TgFQPWPg/7GkqYgSgeomEnqpWSEXXt
	Tw7mvcF0L8QUpOjygCc8rf1vB4tzjmhFCPcO4McwYt1DJnQU78FyTM2h13C6GwGT+FVG/Z+iGs3
	1KeUeb4+LIejZnHq7Dg5XdopPgewy2b8BKZrcdaTn79oUplOASDKqTXtCK7pC68FmjfvA2nZ2VX
	deqdl1A8Nfnki9i/Da6lbYa6pHxqWMDuKIsECTqwU1UEz6LRS+aOOYMLKyWBDqJTO/rex51IOq7
	yuBZP8B
X-Received: by 2002:a05:620a:46a8:b0:8cd:8938:eff9 with SMTP id af79cd13be357-8cda1936a90mr737651285a.1.1773318877767;
        Thu, 12 Mar 2026 05:34:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda21346a0sm323887785a.34.2026.03.12.05.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 05:34:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w0fFL-00000006ezF-1zix;
	Thu, 12 Mar 2026 09:34:35 -0300
Date: Thu, 12 Mar 2026 09:34:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Petr Tesarik <ptesarik@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev, linux-rdma@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 7/8] RDMA/umem: Tell DMA mapping that UMEM requires
 coherency
Message-ID: <20260312123435.GH1469476@ziepe.ca>
References: <20260311-dma-debug-overlap-v2-0-e00bc2ca346d@nvidia.com>
 <20260311-dma-debug-overlap-v2-7-e00bc2ca346d@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311-dma-debug-overlap-v2-7-e00bc2ca346d@nvidia.com>

On Wed, Mar 11, 2026 at 09:08:50PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The RDMA subsystem exposes DMA regions through the verbs interface, which
> assumes a coherent system. Use the DMA_ATTR_REQUIRE_COHERENCE attribute to
> ensure coherency and avoid taking the SWIOTLB path.

Lets elaborate a bit more so people understand why verbs is like
this:

The RDMA verbs programming model is like HMM and assumes concurrent DMA and
CPU access to userspace memory in a process. The HW device and
programming model has so-called "one-sided" operations which are
initiated over the network by a remote CPU without notification or
involvement of the local CPU. These include things like ATOMIC
compare/swap, READ, and WRITE. Using these operations a remote CPU can
traverse data structures, form locks, and so on without awareness of
the host CPU. Having SWIOTLB substitute the memory or the DMA be cache
incoherent completely breaks these use cases.

RDMA in-kernel is OK with incoherence because none of the kernel use
cases make use of one-sided operations that would cause problems.

Jason
