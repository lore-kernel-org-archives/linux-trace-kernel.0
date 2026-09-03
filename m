Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1FA4A3D25
	for <linux-trace-kernel@vger.kernel.org>; Thu,  3 Sep 2026 17:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788457329; cv=none; b=a+PSgVpWF4R+dB535cXZWHU//MjSTZg8YYsXQN1ccQkIDWRMzlOQhQXj+H+AiX8oRz8By9wg8HYbZrzRoQnKgntHuhTuBOf7JCbkmAtNkns4/g/61GGYT9GqXIlT5PJyagydhAQzhHmrah9ITmJQpZfIej4lXFphvRbrvuNNNkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788457329; c=relaxed/simple;
	bh=0c6h30lvNuwZCKR0KcWCDjNBuyr8IdwzE21BpfW1KxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HR2nyPq4H1ZaWv9+thVMXCslTBdAXv9Fff3nC5IMrcZPhACQsczVOIAoEsR0TfjgjdLSFkfwWR1W3Ij31ttoilI0zkga7tXys5xpLUNgsmrtCLa1QYStVJI4SgdsLPo2KUqKt1NC/TlQ5xjC/ZCyQRmq2tc6hJVHCi9VxRWfzN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nCRJtRYl; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nCRJtRYl"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47fe89fb333so100378f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 03 Sep 2026 10:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788457326; x=1789062126; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/QcOMac4m+jPNu8ZvLbuOuvzBr1+9wApKD/IVdlK39Q=;
        b=nCRJtRYlrHUibT9QrzLsa+Ja8Ks81TN8Wc/Ktsf8hpjnY/8n90QnfECqwd4l5qcdvR
         XICEOoib0YjuSt/JljL0HFJpsG1+qaCKTzu4Os4kaCNDDQtaZAF2TQjiUhjNl2a7Y7G5
         4LLdntXOs4mBRPjuAHCvFZcawtLPMbs4bBNzuFeWwgQ/TaH59PFGwZhvlkpz5tcJDT4F
         vVkwWu3AbG/wHowkeKNqvJYhXqe5WKdeo1SXyT067DU8jUqO/GGOAVTLcwrNIGELZgSu
         PuSxIE1FmgbEHvaOKCHmb2mITjdHHoQyMsuLLgiAvCFAiZNjzrEghG/XN40lb9Qr61Et
         Z1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788457326; x=1789062126;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/QcOMac4m+jPNu8ZvLbuOuvzBr1+9wApKD/IVdlK39Q=;
        b=SkoZymp5lBkZqZXNyrGC1RjeSKJkCmteeHeeqKAFc1G4CphYBcam5F7ljy4PgVUedr
         O30QJQTQC7bcrTVtiS0FBQPt7Nb0+4T0btkEuXiOayHbFuhZxb+SWx6TQY4ZLGl2Cx4k
         Az7nKgAnhPnWIOEWFMabyXXnbApaj98goptIMOsxc9v1PeT+80/qkpPw4r+hyWarBltc
         6+kszbTKS04r0pF72lChO5mjUo0F5kraWS9IRybr37iZhieDzkQBCJToTAbvy7hw+Eq3
         jV1kDi+FWBOtP+NZroqzjKxIgrpqXf/ybGPluIHl8NbDYi38teUrtImaN2LEFpaejKut
         RWHg==
X-Forwarded-Encrypted: i=1; AKwUvBxpTnnHsNqvqtV13zoQgwN8NllcjsDBm3WYncsH899HTarGxqgxhn4mLEc+CKub9oZbj8uXdWhzEz79IqDOv8TMC2I=@vger.kernel.org
X-Gm-Message-State: AFuF++nrc2EBreSybUEtrv7oEx1EO5BOTT9cGEhPX38vlYMGMqxfSyla
	BnNoN4Gjt54AriP+4VKQQ3lMdvaqwXnKsHgKKMC3vIcJBMfgly1Vuv/hoMnY6AvDhg==
X-Gm-Gg: AYBFou0EUr4SAF4i14ktJJBXgXfsyVBcHvzqW3+L2dZ4L/uVI04xg33A5h/ewj/cfjX
	ZUv7gNKY9xoA6PPEYm5BQ5dUCIGQnzV3cKDHQ/Mq7OGXCeLruYDTvBSDRFaTItDPnLSx5BOBQUG
	nybYTHrwksC0brZucM2pq6h92MhJIfee+NNdyFzJzq8l7MC32mvvOHy+pU7hKpaHRDjgFsoI5nY
	wdBtkBdmTpElObuqvz/VwEMKtTEjZGnhLwSyNw+jBJKIpgew4Tg1El4VD5K3xXu3JXZpqktAPJQ
	NpIIo8TElzJomYvhBNKSIqTx7sGGpEHKswqX7MMGcjPuq3Kkb649bbas7jsXH3vvB9cVAXZcm2k
	YZD+FVbbsYeTAlxLAIffNVtigONKIafmW/3FnZ5ssUUCvZEXh2fKbVRa8wYURK7YiSK6dqjBdNF
	ToUFork1jBR6veq6Qha/DIwrzK7ByN55gAs0m5dhNf3gWatcIaZdc05ZATEj3SvGnboGstH5hdd
	/33muO2kwUXQSQMgbjA6eyGsc3hthcIYQRllUghfjc=
X-Received: by 2002:a05:6000:4b03:b0:485:81b9:f09e with SMTP id ffacd0b85a97d-48586c2faa2mr1582388f8f.0.1788457325756;
        Thu, 03 Sep 2026 10:42:05 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858791bddasm350031f8f.0.2026.09.03.10.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 10:42:05 -0700 (PDT)
Date: Thu, 3 Sep 2026 18:42:01 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: Add checking nr_subbufs to persistent ring
 buffer validation
Message-ID: <apmxacws0NlAdcAu@google.com>
References: <20260903132728.7fb27d34@gandalf.local.home>
 <20260903173823.4D61C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260903173823.4D61C1F000E9@smtp.kernel.org>

On Thu, Sep 03, 2026 at 05:38:22PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Integer overflow in per-CPU ring buffer metadata calculations due to 32-bit arithmetic, leading to memory corruption and false validation rejections for trace buffers larger than 2GB/4GB.
> --
> 
> commit dffcd0268ea5b9908d6dadacec8d07651bd25ceb
> Author: Steven Rostedt <rostedt@goodmis.org>
> 
> ftrace: Add checking nr_subbufs to persistent ring buffer validation
>     
> This commit adds a check to the persistent ring buffer validation logic. It
> ensures that the saved nr_subbufs in the metadata matches the expected
> nr_pages + 1 to prevent mismatches.
> 
> Closes: https://lore.kernel.org/all/20260901164836.D962D1F000E9@smtp.kernel.org/
> 
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -1856,6 +1856,11 @@ static bool rb_cpu_meta_valid(struct ring_buffer_cpu_meta *meta, int cpu,
> >  		return false;
> >  	}
> >  
> > +	if (meta->nr_subbufs != nr_pages + 1) {
> > +		pr_info("Ring buffer boot meta [%d] invalid nr_subbufs\n", cpu);
> > +		return false;
> > +	}
> > +
> >  	buffers_start = meta->first_buffer;
> >  	buffers_end = meta->first_buffer + (subbuf_size * meta->nr_subbufs);
> 
> [Severity: High]
> This is a pre-existing issue, but could this 32-bit arithmetic overflow for
> very large trace buffers? 
> 
> In rb_cpu_meta_valid(), subbuf_size is an int and meta->nr_subbufs is a __u32.
> If an administrator configures a per-CPU trace buffer larger than 4GB, their
> product might truncate before being added to the 64-bit meta->first_buffer.
> Would this result in an artificially small buffers_end, causing valid buffers
> to falsely fail the bounds check on reboot?
> 
> A similar pre-existing issue appears in rb_range_meta(), where both variables
> are signed 32-bit ints:
> 
> kernel/trace/ring_buffer.c:rb_range_meta() {
>     ...
>     ptr += subbuf_size * nr_subbufs;
>     ...
> }
> 
> Does this signed multiplication overflow for buffers over 2GB, causing the
> ptr to move backward and potentially corrupt memory when written?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260903132728.7fb27d34@gandalf.local.home?part=1
> 

hahah, yes we know :) 

https://lore.kernel.org/all/apmwYLVIxX-C21aB@google.com/

-- 
Vincent
