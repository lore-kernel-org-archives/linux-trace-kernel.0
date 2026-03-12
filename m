Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6051DE2B4
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 12:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773318142; cv=none; b=R1Le7mmjAk7CGz1xAMfaR1KZuRGHrWdm5fjwAlw3r7Haavfa+eTSAwUhRSZr3xj9+UEJqQlLHffhpPq2aIDpwEhQFXhfuiQJtuvtUKl5Ik1Z6OkWFtWhKCRUm4P9Mz/RsA6QwgvToEdDK4WRP04Cy7sV0OPFXFQOcHAxVGTHkd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773318142; c=relaxed/simple;
	bh=CIqUqdezJUt7fx005uAPCwnbutghZRMPmBs/ZUdJIEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLGuBU7DF/C3bkI9fch/nkVGwpjT+LStKxvYLRRQDxWYWElwa1RyHUd/cF7EXqYkSQJSllrH/If4JkHJhMvttYDgBqz4gJ1w6zXhZWpOTlqEIpH4Y9q2rVIoxtDUmLe4SvM3/K8LkNn5TBQjjDLbAJbTMxFNSjHFBgKz6QwjZwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=MwlYBpil; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MwlYBpil"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-899fc265126so11256846d6.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 05:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773318140; x=1773922940; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TimmS2+Pbosg7L15RHI5hJFu+i/J4kMKaqKEQ2F4CiA=;
        b=MwlYBpilCBpxEAvq6qqNanb0ptmdzz/WPEGMB0vpfqBd97XzKUsrUnv6AYlPg547Eo
         6wLkvsZx+gLApph423a9TXB/+qJj4L8RbgHwBsQ7ki3ySBoKisz+BfrSxlmyAhFxy1y7
         MkoD3Zwq6jRtuC2LgwELoHu20730d8eIGQPPZBGtpJ11c9qVOkOPeNFUQSbo7Vwjp8uF
         yCxSaiPoQH0VpSLcKwuYk4X3wC3c2l3S83qe1WRTb08h0Fcs4pkaV89NmNFgp5AeuIx2
         YWXNeeCZbTNZgccWYyu+7hsdZ+UuxucjYfmgOLItAUYNww4ITvwix94L4gHlXgX7eYMj
         bIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773318140; x=1773922940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TimmS2+Pbosg7L15RHI5hJFu+i/J4kMKaqKEQ2F4CiA=;
        b=TxSTmOUuniIw1EQE1nZ59kE5xLiCheyYgGBKIt27RYo1s9C/FD4Hn/oPTJ0/UkI3oU
         J7IZsMdwpYNrSFCN5/Fum0ExeXM5Ii8Xr8h7o29M8hMeIp0/7ADLZ9IJ5yOryLpulqUF
         VILq5HQpecLtIlEfdAgLxG1ylYW6mmL9IbDs9tNg5lYJoFg4MU4oapBrL2x1fwx8XEK2
         WT+ZBl1g13R6o7BiaPSthfSxqro0jRmicPihMTGoaqv5XkLv5ZgBJ3UAyUc1oQQ1z8GF
         vYmi85IbjHgoYfwLQMAk0WOdYsF2cfQEFIzCoCvd6ccV189oS9m+E5Cq+dWFtURHY0Tp
         uH3w==
X-Forwarded-Encrypted: i=1; AJvYcCUgjKfoVHgEAR+N11Pkjs5cA+FyhfQK41UbGSr/8kGXZr2VPaRDQJMBf3hXHZOhu4ztF/zBEgTiNIcs5smL+fijIsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxTh9VPry1GM1JXocSH0LiZN38KXD624cTE7rCDnJKBHUQcJkm
	79EECXs7N0eSF3g/3v4LYCipLz0m+mRfkBnA0WaJuo+DqKtwm1Kd8raD9NGPU0IEj+Q=
X-Gm-Gg: ATEYQzyxSNGz1sq0t2XyJ+1tYFZ0FNTemEURx7RDCkrAy76773nFznYgcsD6+DsM3Hc
	cg6s5Dod7OC6ma1dhjbAcymSyfFhw6Wj74dzzr4a0Uycxt80WGibIbAen/XSc/yhOqrjiJt0zdn
	KDCEYW72CASrhvoRAtniuyVVGBBahsHVcNXl9rrHRVDYuNQvRA0naazftpk8SkO1REuKiOt3S2Y
	wZrRqJNV46Gv2rytdljFkxxSF1mWhA//T5cNVzDOXyo6HH92alDl7E7+dtYvsTJLYyo5eX4Gr3V
	TOlh8oH4/Pi+qp85PRz2X0YTdqeVQvgnF1e2KI3HARVr7onhPBNcSGtk6xxoM8Li1TRf8edZAt5
	GttV9UVT7umGweVATh1SjW54wEsB+gnN0LYnc0HHn70ZO/jwAzmBEDy2vUaeAxH1ZHETXu/TVov
	KBGV1OFpvYjwfz49b4BTgXzpwpKVj9xdRF9DscOJfEjAuH7SH/VHSqQBbMSqVtkCBwSurgO29wo
	EOxyFvd
X-Received: by 2002:ad4:5aeb:0:b0:89a:149:bef8 with SMTP id 6a1803df08f44-89a66ab8864mr83684736d6.47.1773318140521;
        Thu, 12 Mar 2026 05:22:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65cfd520sm33832386d6.36.2026.03.12.05.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 05:22:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w0f3S-00000006euK-0fs1;
	Thu, 12 Mar 2026 09:22:18 -0300
Date: Thu, 12 Mar 2026 09:22:18 -0300
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
Message-ID: <20260312122218.GF1469476@ziepe.ca>
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
> 
> In addition, a given region may be exported multiple times, which will trigger
> warnings about cacheline overlaps. These warnings are suppressed when using
> the new attribute.
 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/umem.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
