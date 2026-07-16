Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BC43AFD1D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Jul 2026 07:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188538; cv=none; b=FAhha/cvx5kG/0t5iWKzTl+H9Suaaa/E0Aa91MPJJJq7R+X7OmR+HcjkLPi7QvfBtoN10GU3T44a+q0MxwPNez5eSk6u1+CCL+0CypNVDKk5G13c4isL/FFCP1WfDhFcVtWXgeQjWB7t9ccWDUEQrQyVw4TzF8OhZ6SRVwPsg3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188538; c=relaxed/simple;
	bh=8fSqIJp8bmj4QNP51WwCWnPBxXImaMWxcfMGsKoGgB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUA0MDtg5SNtmZ2w6mGjSJf6GDMFDzH38d664/DqSkKVCWCeSxDJteANXZrqu30xd9QB/Cy8ZOIgO1eRoJpNV2NNB2WOp9eVtuTFCJKFBJJrKETvsFCnWSJP21pUoXCx8Wl5LZdPiLK3REQ0zWog4gni1JvAhOpV2N7IzjAJ5CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=drj3c19X; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="drj3c19X"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4953ddae026so9790585e9.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Jul 2026 00:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784188535; x=1784793335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pwWen5JZFgQiTbR9q+fdHesMEu5bIUUbjBJE32zRKsg=;
        b=drj3c19XlBl+jeYJmgymtUdwYtoLjtcriiKrHOCHej+gnZlf4QJEQ9IFI0uwPYMEum
         AIB2ql5VGtSNwW8mVo1oa11lcoMm7c2lEvel6ZqUM6qFifiyWY6QCTdUw5JGbi9t2iOK
         iLZlHPJ6lHdkfQ/azm2NIllcpUY0kUqfKMwu+iZ8NgQxwj4o8UHPOSZAlpDLVc3QVmHt
         ETnCEoqZBKpKGoHg3OVHJ1mRlxAhgAUZ9T5Pf/5jCjDgd9bTUqmsWHM3d2X9jLDz510c
         PtZhnaetRiwiBSR308F6VioUJVm+YPg3kT8fZ2qj73WTCTdtcDl3ghAlSRVH2qdVxK1n
         UCIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784188535; x=1784793335;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pwWen5JZFgQiTbR9q+fdHesMEu5bIUUbjBJE32zRKsg=;
        b=c8j5smOBmx3+cipfst022Zf6R7FpMhFOj0eyfSjLvKW6lYTo1g0GjEAnOohD+e49qH
         lMevHcJ1fp106tpnTa9mmI4k8bNEBKLLMbqrreLdOqW7vpg7fgE9ol/oPo8Qb7JFdm+p
         fug8tonckPoRUdrx8LznEsZoUv0kxBYbnCAPozrv4zBRVp9o4HRJljUqBGcxqFo9wZrM
         aeK3t4fyqEa+17iNl8/AZ+LSvV1n9L7AIOCU402kMjRNGJ3Yw2kkMkBVCr9U2BTsJY1z
         mkOEPhWXILH8jnpB1uMVnKKwKzlDT48waGjVhrXcHeB6U0f9UhFQSW0BmDVfQowklrlu
         bO8Q==
X-Forwarded-Encrypted: i=1; AHgh+RqwGeW3ZxDlGSG5fR+L5zpm+044keZOXmR4uh1MiGFwB3wtzMZJleSnq0UF+8+M0RgVZzuN2aXwvEIshknolKdpdb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpgPyV0DajHYpewiikcKGOnE8hHRT+CAUpZzwQE4RwLdCEjGna
	YGZLBdQ5vcueN+10zKZjW5Vz1JI9+JhxBmbLqK0FoIexMmJ99w6pPS5AhTPhGfwN+w==
X-Gm-Gg: AfdE7cki5Wz3V/9dYRbI59McHh2e5ioYnE284iTL1kU7qicpfElwq0z/G02mfX0vyut
	S+Ij7xtB6NdRH9j3cgCBvsyza/Z6nqdmj81ow6m7JozlC1cf5iBdxsa0GANXPq6mAsnQbFqpr/5
	lGwE+pHGJZrkLq+VyFAOnrAZ7EhmoyeGPPXt2sSiCFETMyiWGykW1OsN0h/Jyw7IAgz1cSuGWZq
	vDMvYEFNgOZ2+lrqTZTC+//BTxGnv+97HsGcu2MAIgubBka9e4/2IRr7fIQxQOPUULYOQDOSLJb
	0OvYkqTsD09VDMrHhcgfMxC1DlyIUau6ryFa4mO+gzKxRmrOf1LXn8PwEqsHYZtXjTx6vZRDY18
	p59JoAAZK/VldSe87HDDUjratVbOClXL8pWRmvrCFuFMTKF56ePFTmH3I9pZb0gF95Gz1SYUntY
	64bPtmXyT8KEC0Vy5g8Lx17+8Sx/FbCN57SrZ3+0LiUlnhfSao1nw=
X-Received: by 2002:a05:600c:15d1:b0:493:f6f0:d61e with SMTP id 5b1f17b1804b1-493f8837fb9mr121070505e9.37.1784188534530;
        Thu, 16 Jul 2026 00:55:34 -0700 (PDT)
Received: from google.com (137.69.77.34.bc.googleusercontent.com. [34.77.69.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541e8c2a3sm45279645e9.7.2026.07.16.00.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 00:55:33 -0700 (PDT)
Date: Thu, 16 Jul 2026 08:55:30 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jackie Liu <liu.yun@linux.dev>, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Propagate errors from remote event bulk updates
Message-ID: <aliOcliJWcruun2z@google.com>
References: <20260715060448.17674-1-liu.yun@linux.dev>
 <alcsNLVLhWOH3KbJ@google.com>
 <f9050a5ba183da3c9071c5be5172c4e814972836@linux.dev>
 <alc11bkkDvpaqYrh@google.com>
 <20260715141956.6baf0134@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715141956.6baf0134@gandalf.local.home>

On Wed, Jul 15, 2026 at 02:19:56PM -0400, Steven Rostedt wrote:
> On Wed, 15 Jul 2026 08:25:09 +0100
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > > I checked the v2 series. Patch 02/18 handles registration failure cleanup,
> > > and patch 03/18 changes the boolean parsing in
> > > remote_events_dir_enable_write(), but the loop still ignores errors from
> > > trace_remote_enable_event().
> > > 
> > > Would you prefer this fix to be folded into your series, or should I resend
> > > a v2 rebased on top of it?  
> > 
> > Ha yes my bad. Then no, no need to send it separately. 
> 
> So should I take this patch and send it to Linus now?

There's a v2 here [1] with my Reviewed-by tag.

[1] https://lore.kernel.org/all/20260715074455.3897-1-liu.yun@linux.dev/

> 
> -- Steve
