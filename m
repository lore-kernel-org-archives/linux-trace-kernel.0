Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5A913AA26
	for <linux-trace-kernel@vger.kernel.org>; Wed,  7 Aug 2024 16:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723048785; cv=none; b=VuXTz+iPWuzZ5Mz4Upbg4JekNpT2ejCW64pdExevVHrNKstJC5NxoJSWbzqjUVM8QwkKo8aNALNuRFQUOhmYaA87tb/cfxdmI/AmiPL3G9LSJvVQMmo7dx5ymF35iYRR7fw5XafNEf/Uodb/US+fv57il725NJjnwBDh27HtgwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723048785; c=relaxed/simple;
	bh=LPdAnUCvP/1/42vQX7gvD0FSLRCj53R2KV60JM7JR70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNmVqlU30abbUhJ2CJFGAGxQd5vQpk7ugdK7aj4DO9v8amzHFlbqtYdm08JesdqxmlfYldL7lBHI01my7Ntv+wtiTgqZSLLsWPA2KvuzqyT26dqYzYa42U2RxCq/I9ZpkLrk3IRb15L1yV9cDh0cSXDLi/AaYiD6C8HK8fuAfXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VWMiSgvb; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VWMiSgvb"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3687f8fcab5so20494f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 07 Aug 2024 09:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723048782; x=1723653582; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QHW1mxXo99BTncFCV2Od8EwldJIdp0HcoBntkRqHPbI=;
        b=VWMiSgvbZ5ssFRaWVBcm4QTnPYHerHzX+4ssnUmW9E/o8i8sSbdSxFxNyXJiRImFSU
         9bQ2v5PBhgn1aSHoB14w/YCHMgakE3de+YBShsWGH6HjmXHXCev2q+ifO3YnwD+27zPC
         OLdu10sP9OTRPfaTg5z2w18CdJujADtISwN3eTZlWIhGy1CpvIBrbiimvNCt8ZN/VQ1J
         StO5fdqmvNboPQTih5r+M8VvMjy2zA5vlzGxulR7IBXRiasXSFVe5MtydOnstQGVVUNj
         w7TPOmO3UscUTMU8Sly7YdHDA7UtocH4DNP+1L85wXikOyFMHkHw5cniXfpl+mE+e29k
         cJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723048782; x=1723653582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHW1mxXo99BTncFCV2Od8EwldJIdp0HcoBntkRqHPbI=;
        b=mXlYUrFzgQuKhE6qCkAik1zLb/ZiodY4U0KdjOMXujRPdAIlFdIE75HJOidfl4aKbl
         wqYPca8O+82Xnrg5pVGTQT2Adkog0YPv6aUIw6NSBQ+vCoV5k/Qy63xRtwMRohs6Trio
         EGzUgTNVy6FCzkaAFdncp0ZXvxwq1kyd4ipK8nIv7ubPHIPKgiBSPVOWuCpnYbXKg4Iv
         N66gzbV2+Kpo8UOWIRiGTvDguJTobGCqSeQQu/Bb66ClUO3UF5CL3bfYxiYriGdppDON
         ky5cG/NVE+Lg5cCNvYO6Y6YE++PKxYQAaybCRsD/w1pSyNnnAQZ+VGD175tUxvwtVQ9j
         xInQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIL+3VqmZX3VUute9RyMBVGJVXVXC9A62aSGq5SDxsncaWGJMtXpWJ5n0mvYQmEJ3cs/P/s0to7sZ1zIwaYb6yy1a6uTusoAWdAw44SkHKCpOl
X-Gm-Message-State: AOJu0YzP2sRfS8X/9LJc0KAKBvrBeE3cNy0Da7I9hYO1rZAWY9dn+H2x
	WBTMZlTYesQlWOF9g5o0L8x6KAuJdpL2arE0L6fXLdumqVxcdb8QNjr6ry7oJw==
X-Google-Smtp-Source: AGHT+IFpj8OAf/zU2P5H1nf7aSDiDGP+hlwNCJGS6cZvB3Vvk1HpMfsIAD1gNsJAlgupqm5KpgXoAQ==
X-Received: by 2002:a5d:6d49:0:b0:368:36e6:b248 with SMTP id ffacd0b85a97d-36bbc0cc71cmr14259786f8f.23.1723048782179;
        Wed, 07 Aug 2024 09:39:42 -0700 (PDT)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd05ad0csm16751056f8f.79.2024.08.07.09.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 09:39:41 -0700 (PDT)
Date: Wed, 7 Aug 2024 17:39:37 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, kvmarm@lists.linux.dev, will@kernel.org,
	qperret@google.com, kernel-team@android.com
Subject: Re: [RFC PATCH 00/11] Tracefs support for pKVM
Message-ID: <ZrOjSZ_JfcaLnCgh@google.com>
References: <20240805173234.3542917-1-vdonnefort@google.com>
 <20240806161138.3a91c04a@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806161138.3a91c04a@gandalf.local.home>

On Tue, Aug 06, 2024 at 04:11:38PM -0400, Steven Rostedt wrote:
> 
> Hi Vincent,
> 
> Thanks for sending this!

And thanks for already having a look at it!

[..]

> > 2. Tracefs interface
> > --------------------
> > 
> > The interface is a hyp/ folder at the root of the tracefs mount point.
> > This folder is like an instance and you'll find there a subset of the
> > regular Tracefs user-space interface:
> > 
> >   hyp/
> 
> Hmm, do we really need to shorten it? Why not just call it "hypervisor". I
> mean tab completion helps with the typing.

In most of the code we do refer to hyp, that's why we kept the naming here too.
But yeah we could expand it.

> 
> >      buffer_size_kb
> >      trace_pipe
> >      trace_pipe_raw
> >      trace
> >      per_cpu/
> >              cpuX/
> >                  trace_pipe
> >                  trace_pipe_raw
> >      events/
> >             hyp/
> >                 hyp_enter/
> >                           enable
> >                           id
> > 

[...]

> > 
> > 4. Few limitations:
> > -------------------
> > 
> > Non consuming reading of the buffer isn't supported (i.e. cat trace) due
> > to the lack of support in the ring-buffer meta-page.
> 
> Hmm, I don't think it should be hard to support that. I've been looking
> into it for the user mapping. But that can be added later. For now, perhaps
> "cat trace" just returns -EPERM?

Yeah, I am sure that's something we can make work. But definitely not a priority
as it is less reliable than _pipe and unused by user-space tools I believe.

For now we print "Not supported yet". But happy to modify it to a EPERM.

> 
> > 
> > Tracing must be stopped for the buffer to be reset. i.e. (echo 0 >
> > tracing_on; echo 0 > trace)
> 
> Hmm, why this?  I haven't looked at the patches yet, but why can't the
> write to trace just stop tracing and re-enable it after the reset?

I could reset the buffers from the hypervisor with a dedicated hypercall.

However I'd still need a way to "teardown" the buffer, that is unsharing it with
the hypervisor and freeing the allocated memory. Using that reset for this
purpose was nice even though it implied to stop tracing in a first place. 

Perhaps `echo 0 > trace` could reset the buffer if tracing_on=1 and teardown the
buffers if tracing_on=0?

Alternatively, I could use `echo 0 > buffer_size_kb` for the teardown. But I
prefer the former solution: interface users are more likely to just 0 tracing_on
and trace.

> 
> > 
> 
> -- Steve
