Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D8C27A92B
	for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Apr 2025 16:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745857472; cv=none; b=UJ1tWadCVFuKJKixkB9crgpysFoZUQ7SIhezNHL8y27FbZMKMHg1875SCKu1OtZb0gjHL8y+wAYrZjyxoWopU2eo0dmZ8w5/AyQ7+D3JX3tyhgQ9oqvHr4A8T+vr2wrOmhr6StiWlSAd/fGmMSYQQktCici70qep3iJOFbbd0B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745857472; c=relaxed/simple;
	bh=gx7RtZXtXcXDCgsMk2d3JVtds6JRV5t+fEp5vL+9MQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=AIG1byE+CzZOh6hv0pxriBxW1myIUph8pWWjQSjjj+VBDVncA+fbdXR33P41ZlJ8vmIlLTE3vh5yir1v5q+KFhkxjUq7HKVx9Gu7LiLQyJBQaqOcFp+qNbqeRDSAHje3ixH71Ryb6NAuF31VuOLauMcFbM+QWAVfklysNp9e/ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aJpdQ0V9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aJpdQ0V9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745857469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KRdiWHlG77Us6l2oFM6nu2eUggr09dOOElY1pvowm4s=;
	b=aJpdQ0V9ZxPSTTOwZ4GMj4oiAIJEoR7vBQM1KeADhsY42PV4K3a4q5/1vYTnjKRKWAE7wL
	B+eArxsWeIootTRZ0IshGaQShHSFSU1aLOIQ9M4DsSsQXJNeFZWD9QB6rgWzsVNiTfHZ50
	LEfrC0jslxwTMX7bNd2D3bmuIJpH5as=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-Lte2dbGzP0WXKf9EkqaMqw-1; Mon, 28 Apr 2025 12:24:27 -0400
X-MC-Unique: Lte2dbGzP0WXKf9EkqaMqw-1
X-Mimecast-MFC-AGG-ID: Lte2dbGzP0WXKf9EkqaMqw_1745857467
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4768488f4d7so70275561cf.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Apr 2025 09:24:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745857467; x=1746462267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRdiWHlG77Us6l2oFM6nu2eUggr09dOOElY1pvowm4s=;
        b=DtPCxsckst7wHegJC3XV5v9WAltv6V1wqEaNtdFesoV1S1gvkH50zZQ7yjM+WjLZkR
         +Vhh3Mk12s5P+3Pm8TRDHowuphBT0tnSxBwQCzLd3BVhOrMlHHzb7HrHRVuUeJCoJh+i
         IcQDGSKdUaRtqein6yKgDdpiUTPqo7S8lwmKJh5UivDiOalwiwikCX/uTeoAV2gP6IYk
         POJ07OGQ7pqYZFiq+4EbmpcCupXThqP1lkHesreaWDfFCfSLJ5GnTLwXwZaN2sU49LOX
         J0+5pCl33tGoeC8iO+FHhDn/9IUaP+0uuOFYfB2WD+1w6HaqKaGTqsUa6ep3YQPPswUx
         w9Hw==
X-Forwarded-Encrypted: i=1; AJvYcCXr1pHt9tnYTgtrNh1moYWgn97yUyvTNsFbFj4PPdkczUnUIEzzP8jjmbstwQKt+Zi3na/prI/+up1IAECg/wne83M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl/d5C8vJQPYXFGTE7tJFrB8oPOk+8YwM9O9cSV9An54fs0kWW
	W4gohvkec+s5n9Pp89/wLQ9YmgBEEvMgMphzAdbBioBAzBw42YTdExLsSxvUBb8yQxO72h0a7Yo
	16e5WmCSjvb1BbrSRVsuTCPEL8FQzrVlKa7munD+bCgj9N++mkF2oe4o291k8RD3OS9N0NQ==
X-Gm-Gg: ASbGncvhBD5P1itgUNvsfHJFOKYtObilyc0VPDsXGQ8S7N2o+BjlkdLezEZP5kBTWDh
	jiR9GhbJ4EUyEFoZ338yUOPmYtkRsXK9aQadmWpB6sFILJ/eIH7N5KDLUl3NMQydHsVYB1J15Ss
	mTJivkrX30to24/uDIUZhmgZCnyUHpNNeEYyv1x2IRlGBa3Jwcr92IDTLzs2wXoGHPd3TWgRy3r
	NNiiEjLnT8H2wQD/wv6lCrtHqHXIs48dwLCQfU70eKjhaYCHQsg0SSP4NnY8kJ1EZ/rvtBFizlz
	Lwc=
X-Received: by 2002:ac8:5885:0:b0:476:8ee8:d8a1 with SMTP id d75a77b69052e-48025238433mr189998681cf.45.1745857467087;
        Mon, 28 Apr 2025 09:24:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbtfAYJXqWijuqC9qE1XAYSFE+Ms0Ul7NtVdmGjB5I/RjjP9FCiSLL88Eit0raUnSdKc6qiA==
X-Received: by 2002:ac8:5885:0:b0:476:8ee8:d8a1 with SMTP id d75a77b69052e-48025238433mr189998431cf.45.1745857466831;
        Mon, 28 Apr 2025 09:24:26 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47e9eaf264dsm70223561cf.10.2025.04.28.09.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 09:24:26 -0700 (PDT)
Date: Mon, 28 Apr 2025 12:24:22 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-trace-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>
Subject: Re: [PATCH v1 05/11] mm: convert VM_PFNMAP tracking to
 pfnmap_track() + pfnmap_untrack()
Message-ID: <aA-rtji7ujQgckbM@x1.local>
References: <20250425081715.1341199-1-david@redhat.com>
 <20250425081715.1341199-6-david@redhat.com>
 <aAvvQ1h9bg11hiqI@x1.local>
 <bbadf008-9ffc-4628-9809-2d8cf104a424@redhat.com>
 <aA-n9hvSX9JLsRM-@x1.local>
 <7a26e29c-d889-450a-a5e1-ce671f09e4c8@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <7a26e29c-d889-450a-a5e1-ce671f09e4c8@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: G1m-EM6RHr2N1vjvTWwzBlT328bE67SIMaYdygSUZBE_1745857467
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Mon, Apr 28, 2025 at 06:16:21PM +0200, David Hildenbrand wrote:
> > Probably due to what config you have.  E.g., when I'm looking mine it's
> > much bigger and already consuming 256B, but it's because I enabled more
> > things (userfaultfd, lockdep, etc.).
> 
> Note that I enabled everything that you would expect on a production system
> (incld. userfaultfd, mempolicy, per-vma locks), so I didn't enable lockep.

I still doubt whether you at least enabled userfaultfd, e.g., your previous
paste has:

  struct vm_userfaultfd_ctx  vm_userfaultfd_ctx;   /*   176     0 */

Not something that matters.. but just in case you didn't use the expected
config file you wanted to use..

-- 
Peter Xu

