Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5975439EF35
	for <linux-trace-kernel@vger.kernel.org>; Fri,  7 Aug 2026 15:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786117532; cv=none; b=qZL4PllXQVZ1gghhFJssjP0bipnsxmDeSMLsgmOws4fwoAT2A2BrDOgJ1tRzZvceem9qSiiT4l6caa6DQc2OiiKV2r1Qi3b+Yh2hkUnZi6XacgEmNJ1Hoz9sw8Dx0aFbV9oQIdgCKZOz6Voa2XRPg7+hsWOrXiBmnQzqwEWSKMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786117532; c=relaxed/simple;
	bh=Ek3pTZqQvm7qk435X2ebWHZF1j4UDu6RIlWcOQUp8gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRcLrxAcSvoolBYadh9SHrPkRo3NM5o/bagv+t1FeD27UZTT67iV2cci/Ov6fSh2x94dGfYCF9Yv4fsRFWG9OWqB9o6YxAEHuRi7T6RuUP820NhYrTmpJO7I/ypu924HhCIBLxVzKEjbDMOzbHcrMM9e23ZLvoORl2s6tq1mnpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QCNF/iRQ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QCNF/iRQ"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a17c04563fso4045577a12.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 07 Aug 2026 08:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786117529; x=1786722329; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aHCw92KXAlA4YbfTRDT8QawrMa/113X+G0Ur1NsGMR8=;
        b=QCNF/iRQmTp7E5vDGvCflaU/RkDNaZBYsYqP56yR12XGqYw0UBiF/3pqDCIwSbhfJV
         gCZWQikzRVyLNEldRNszwdEHFGBsH72/QR1LbA/ynWbX3+gxBaAxL/GtbC0toYA8Q+Q+
         W10uDSVCdNf1wie9yqeq0PqQuXf4QkTVFfsfJOhnuuA0asZWWBoDtlJTsJyu9uyzSV3X
         DroQkgEXQiayeGh4QuRfrsDvXYWUliBVZ4ZokloL/qK6Kd0SUwDf02qA4vgk7OXT5YSX
         KAuLLGUq/bpvyZDjDuKgT/9b+2Bml4mQziVSyRyPOeWbVS5XTtBXDcmmgmXhFaoNBW6d
         v1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786117529; x=1786722329;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aHCw92KXAlA4YbfTRDT8QawrMa/113X+G0Ur1NsGMR8=;
        b=fy9bVIL5BdciqxSUWV/3t5YV7S/S9tv1Z6MIQ6f0dkwQtFy/7aQxnn97KtGKiHfk7+
         uOe7YPUZFyFhalQDn01E+zFSnmWBWdBWZTmrhJxsrIycfEHJgvx5aKwbCHSRZ/boBy+k
         kV+KdH2AE9UxOZXUn19zh/glBdIejh9oboQqNyOdkdjJWlOAdGOoShPtN2CJvZOskSFZ
         oR1PzLY85lYi4H3S456PCXRZY4elOkOM2FYX/+JuYsBBXhX5fjC68hA5eBZtebhdUF93
         pFuIZXyYSbI+1QwSpY+zix7bAJpMubdzp0dDS4WYamP6FgoZnSx8NGJBrOIFxHz7nhm6
         7Oxw==
X-Forwarded-Encrypted: i=1; AHgh+RqxyWvLHpc5I/uL5AjgkrPUZm33TQMXrwh2CP8NuxhZjS6zpCG47/2SNktV+7dJhem4peJhM7ZmBQvoqAMTjIt0l8E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi+8NuCmprzyqnbMg+aqgL/d90PRf+XbQq66UXKsM0RGjtjYmY
	CGlwWL6ZZ8E3l80eT6lL4FqaDZ+ciFzRDxjbUjusBZvCPasLRe8Rq4HA4Lx42bewwA==
X-Gm-Gg: AR+sD11NTQr3uWdsNiGIxjhhdlLBwBPaCZleKSqabXigtkIbkdpc5t3ChdG722PAklB
	QySLaXI7sHgWksnmL9EK54KxvDu4E5TdexZKTpDtAp/+tmLuN44r/TGUFnPP7M6pMej6j4bo53m
	mw/dj+lJNIFJrYt2X3mHQWEKf9b1tLQurJOaEB5YdiD8p1tvGnRyfg+6Nms8HJGBJBQxWczuooB
	KqlZYDerceHpX4NNRf3n0kmHy37jjXh7H9tMOdNZdF3NCTUaCMGFPuT3cKUqKf0rYjGRO+qgLQH
	RTe/67wCwGoCElbCQ6FIrlSYDkdIa5/Dg/qqS6DhsaPfRX29WI51dtEbPCYUkmVdvgbzZsZmNHK
	fEgEfL7mwNwHO+5nnsPeaVrPHgNIC9unzvOhDJoVtY4uWdH2PEDAcTl3gNtzX3QuNvoJMib3JjZ
	n/x1xEaa13QibwHYEQP/ikBTGBATABcNgGj0YA/Px8OSkny7NZwxXYir871EQWQq0UNQ+eiXpQL
	SOZTsSv0Sa+isYdTA5CFYodzum3Iaoh/VrMuJpUIzE=
X-Received: by 2002:a17:907:94d4:b0:c20:367b:acae with SMTP id a640c23a62f3a-c2073431341mr473270066b.32.1786117527762;
        Fri, 07 Aug 2026 08:45:27 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2080cc3963sm67670466b.50.2026.08.07.08.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 08:45:27 -0700 (PDT)
Date: Fri, 7 Aug 2026 16:45:23 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] ring-buffer: Prevent resizing of persistent ring
 buffer
Message-ID: <anX9k8x67m4Cdw5n@google.com>
References: <20260806211306.3704194-1-vdonnefort@google.com>
 <20260806211306.3704194-2-vdonnefort@google.com>
 <20260807111808.d5dc1a48b080d241100f4a57@kernel.org>
 <anWT4heM5Z--A1Mo@google.com>
 <anWosNi-U8lVqBZP@google.com>
 <20260807104526.38430aa2@gandalf.local.home>
 <anX47awNHC9caDN_@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anX47awNHC9caDN_@google.com>

On Fri, Aug 07, 2026 at 04:25:33PM +0100, Vincent Donnefort wrote:
> On Fri, Aug 07, 2026 at 10:45:26AM -0400, Steven Rostedt wrote:
> > On Fri, 7 Aug 2026 10:43:12 +0100
> > Vincent Donnefort <vdonnefort@google.com> wrote:
> > 
> > > On Fri, Aug 07, 2026 at 09:14:26AM +0100, Vincent Donnefort wrote:
> > > > On Fri, Aug 07, 2026 at 11:18:08AM +0900, Masami Hiramatsu wrote:  
> > > > > On Thu,  6 Aug 2026 22:13:01 +0100
> > > > > Vincent Donnefort <vdonnefort@google.com> wrote:
> > > > >   
> > > > > > Dynamically resizing a persistent ring buffer is not possible. Disable
> > > > > > the feature.  
> > > > > 
> > > > > Is it true? Of course there is meaningless to resize the persistent
> > > > > ring buffer (because it makes the buffer none-persistent), we are currently
> > > > > allows user to resize it (like for resizing unused persistent ring buffer)  
> > > > 
> > > > __rb_allocate_pages() in ring_buffer_resize() would call for a persistent buffer
> > > > rb_range_buffer(), which IIUC, is just reusing the same ring buffer pages as the
> > > > one already in the persistent buffer.  
> > > 
> > > I have just tried and if reducing the size works, increasing fails in both
> > > rb_set_head_page() and rb_insert_pages() with a warning, which I believe is
> > > expected.
> > > 
> > > We could improve that, but it feels like it is a lot of work for a meaningless
> > > feature which we should just disable?
> > 
> > Resizing a persistent ring buffer to a smaller size may be allowed, but I
> > see no point in increasing the size. Making it smaller should allow us to
> > give back a portion of the persistent ring buffer for general usage.
> > 
> > -- Steve
> 
> While I see the appeal to reclaim that memory, I don't think we have any good
> interface for that. There is no nice way to get the list of pages that have been
> freed and we have no control over what part of the ring-buffer is removed.
> 
> Also, as this memory is from a reserved-range, is there really a way to re-inject
> it into the buddy allocator?

free_reserved_page() would do actually. But then it is definitive. 

Happy to implement something like that. That also means that the instance can be
actually freed?

> 
> Perhaps what would make sense for resizing would be to support a CMA pool as a
> persistent buffer?
> 
> -- 
> Vincent

-- 
Vincent
