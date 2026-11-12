Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794484296;
	b=0NKnH9KD+5H1sY7UlsrG1Ya00Zp3tN4rCuonevndpT8fW9Hv0cqwoBp8EPWWq03/S0z/
	 jsxpnoLGTYjZddxtykcSqEcaU50ZbbIYZBWf//gfx/+k3Qg679SQRIvPcIf4wNRKSB87j
	 m+q3J4qY1lC1GfF1caivaYxkd5S2Dsu2CF5IcKcZ/DDDR4dIZfMALiVFhGUMuQQkCeciT
	 baO8Bk52mhrbzX15fdxfRc8fuSpQeUDOcvZS9I5COTCUf8iGciZGbq9/dszwAXbFU5Lxb
	 7JxPnxZw19alZUPMm94oknt+xJ5qd7eKuSrR5QZFBH1ttVOysQfj1qDdzdWrp4Tl48A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794484296;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=L+9OvAGkA5co8PTaVpf/WHREVpFJgAvJ9utwws7KxK0=;
	b=pE/r2YzySY1g5rTZANpG8kAFjsWdWEP4LhuWlCyi2IrHd9Id4BNxEUOqIdC0FbtzJccB
	 vr1wL+Y12L4dmJna08+Ke0Hco497k8oDywm7iNDtVyxhTu5xLWQtUy+dsIrsmlRcqXIM8
	 QLu/6lCdRZhuLnaQ34AqX2pKGcvxY7eKkOB4v0mbRXb6GuFkLVIM4maSLTms31/M3sgUt
	 VHfKuoMR+sNFPy/XALgcs2lNbQqca95xgvWHc+Uaw7/0C6sZH+mGuIHN2ec4V0gRVX3Y6
	 7Qt95rye3YLnAOUyljZuXVf8kvRshxR6XFQh1+F1LcSiTw/t6rFu9a7iPVTSC5Jv2CQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=D7pI2T9a;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DC8606A32A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 11:51:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79DC8606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=D7pI2T9a
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a549cd7fd2so7313705e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 03:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794484295; x=1795089095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L+9OvAGkA5co8PTaVpf/WHREVpFJgAvJ9utwws7KxK0=;
        b=D7pI2T9aUlHUPB3rv6sO+Ov1nRrCVtdz1sKmcQ207kMrfnwO5xoLhaLFuNbGbc5clW
         clwEAKnGyjMJ2LLwb2wh1aM4aMxl+rixQrXW3MY1icYmfNkt/ZzMeI9ao7dxVIxRO4He
         8jZnfMnsZIvSeGrZPU9MRqkyZB+W65uY7ohwyGDLOVxP6CDhoUpMjEs3F082Pgy/GG9j
         FHtKk3iaMvmV18s+orFsSOOfahlQcJ1lss+O8QKnEJ3P+4mJsi0GrbznkXGj7jy1KX4c
         uDCuazl+Hz/TkjbQH4xBiEveaqiAKiFvr3OELpZjTq1APfpIx9l2vrbyPXv4LFYobk1b
         do0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794484295; x=1795089095;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L+9OvAGkA5co8PTaVpf/WHREVpFJgAvJ9utwws7KxK0=;
        b=b3O6tCcaswsRNM6jwbWtWo7JhXXYiy25bCE1p5Q1l+OhTOZnXIynWoOr1rR+GY2/0K
         Lb3ayT1kHrndm+2tYuK2/pQys58zaHuH0enLZozsu/4OQ/J2u4gOiqFU98h7fqWCmdTY
         8KnBEKGVr9hcHMwdh6Mn55jtNEKnmP/lUvAOX/n530FXFqgRXFF+IJP4KuJTW1+ynJLj
         AokPa83uGGulSiPgE3OFiPSdACnZirg9Nfx3l/tS3+Ysai/4D4qLGBVSOup1erkes0YO
         W527xMAEipFhETAni/l/RJ7Mx2sUHfAAvdUu8fN9Mo3Z0ZJMKbaWQkZ/VCsWwaes7QIF
         74RA==
X-Forwarded-Encrypted: i=1; AL+hErGuLkVOEepCaLkyg2OYEJKOelWWZwNS+Tuic7R0LJit2xdrf18of3rkPCFjq/4GqhEGWCDrG4FUMJtJqMSz5kM1cSA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+T8IlKEVqOAtzCPCvN9uAYk/h1I0lvs+C+Hur01YCFaLGohQE7
	JyNj4aSH2HYTSJ0j+UZrS3TtD4AtvJEZyZ76b5ALc/ccv0Lm/R5YMjcr5FvcKDhM9w==
X-Gm-Gg: AYBFou1z4Ej95oJMtsWKlrCn+xgJElcrBTH/kpUrXCCjJz+u0DdLfYlRJSm2P9AwE6g
	Q4uMgeWFqkG87eR09bRaS0W+X9YVUVnAncV2iW2mGw0lvDmMMqTPaQhUID1VF1vPUH0RBmzPzZb
	wQK+8tRpGYEP9CZlRR2iKCKfYNCbpRUWswxglh08L3TBB4eMHiEXUzbbCkr3mIHsI/lVg28GAKD
	2e5NQIu/9r/RXeuftPl0h84zlBslbpD1caGNvVHcizw0HZQuB5FkCu+tAPmZhrrXSTRkPme+yXh
	yAx9qH3LOXv8HNxuvXBdnlfMxl6qWQJ43WJrd5A9XF5F1kFC7LVakXfdB5rvA9OugyJYt2gx0GG
	1Bw+IxwqM+/6U0lHWnkaEJrj0/W2i/iJX0woSyhrOLGFbjQqE0PmQ3sHouSXdTGwb+A20eCrcpW
	R+IhtE8p0RZq2VVNp3a7Fp/oCThvKnGZRiAOn4JkUHEQ4GuYyznVN4IVI4Uyt8twRx8DJ2XrqiZ
	ftjPgotkhV/GG9USD02pca0dslRPHSmkx5OTMBIMWy4axLOM28aI45RyLZQay1Pi8jIQXnfOvTQ
	pH/ZF7yJYQHIqFw+BDgKz5yXhoADUREYrE0dneQwgl8lM8pHMM7LDyal47hkMMPqOA==
X-Received: by 2002:a05:600c:a31c:b0:4bb:53e4:a7c5 with SMTP id 5b1f17b1804b1-4bb53e4a861mr3753135e9.14.1794484294459;
        Thu, 12 Nov 2026 03:51:34 -0800 (PST)
Received: from google.com (0.182.34.34.bc.googleusercontent.com. [34.34.182.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e251c26sm63991125e9.1.2026.11.12.03.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 03:51:31 -0800 (PST)
Date: Thu, 12 Nov 2026 11:51:28 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Breno Leitao <leitao@debian.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Steven Rostedt <srostedt@redhat.com>, kernel-team@meta.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] ring-buffer: Handle a reader taking the new head in
 rb_handle_head_page()
Message-ID: <avWoQGaDrrY9z9Cr@google.com>
References: <20261105-ring-buffer-head-moved-v2-1-05da40cebccc@debian.org>
 <20261105155729.0f9c7e4d@gandalf.local.home>
 <avGQnBjyUMwunknT@google.com>
 <20261110025202.78c8c03a@fedora>
 <avRuXVxVrp-Kjiqj@google.com>
 <20261112061423.59e02261@fedora>
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
In-Reply-To: <20261112061423.59e02261@fedora>

On Thu, Nov 12, 2026 at 06:14:23AM -0500, Steven Rostedt wrote:
> On Wed, 11 Nov 2026 13:32:13 +0000
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > Yes, now I spent more time on it, I believe it makes sense. I looked at what we
> > could do and I'm trying to use a temporary RB_PAGE_HEAD | RB_PAGE_UPDATE. This
> > link flag is then only converted to RB_PAGE_HEAD by the outer writer. I believe
> > this would fix the race entirely... However that means the reader spins as long
> > as the buffer writing is interrupted, which I admit is far from ideal.
> 
> But it is only interrupted by interrupts ;-) which should be fast.
> 
> No different than waiting for a spin lock whose owner got interrupted
> by an interrupt.
> 
> -- Steve

Yes hopefully it shouldn't be too terrible. But, as we disable interrupts on the
CPU doing the read, it's sort of propagating the latency from one CPU to the
other, which I believe wasn't the case so far, since an interrupt could
"release" the reader by setting HEAD.

Perhaps I could propagate a -EAGAIN back to ring_buffer_consume to temporarily
release rb_reader_lock() and try again there? But that would be a bit intrusive
as most of the functions are returning a ring_buffer_event * and not an int.

The attempt is here [1]. Sashiko had something to say but I haven't processed
yet how bad it is.

[1] https://lore.kernel.org/all/20261111160624.1294946-1-vdonnefort@google.com/

-- 
Vincent
