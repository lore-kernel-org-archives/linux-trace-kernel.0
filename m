Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FCD811E7
	for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Jan 2024 17:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706032105; cv=none; b=PH4AamKhRrBuZAKBprbTX4zZ3PDxDt4xvnylJ/7+W5IRCqYGZ37yTwPg+5Ir2EoOzzHd5kfKWbFwXmP9UjyQm6TzX7g25vMUAx25U+pxXYvwpGbRmFMdXrbknSzwmCATIYxMhJ53nUggfxgPtNo6tmIKqfROqhVqjX8KWD+hwUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706032105; c=relaxed/simple;
	bh=e0ydZacl+QDx2XYQpkp+o4Ojg/EMtv8b8XWhwgcKWoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/Kaa9fFXGJyFWAPTBzBEiKC5JzxXZeNcX1VLoUzriF18xW8yoapPZy66EtH4lAGTS7rE/TyJoOsqPC1hDbWjL5eJkjnmf1z5PyuZL0FzAS/wqFYovXtvJYlbeTXtrwMFc0JjWjS48taj2SA8P8K5m6AFlBMEGEuyUtVoCU3mzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qjY43geP; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qjY43geP"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e76626170so51267665e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Jan 2024 09:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706032101; x=1706636901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9NOEsfAi+dCuYvyEvTRzmh2vuzrG7B1XkljieNVSYmA=;
        b=qjY43gePKhg+/yt+3ygpzkR72uhH5M79GIs6kIiUX5n/qR+l39U0AMpZkDp5iMjo83
         oc8KG41ldkCvV/dJIvoxlnr+6va6C0+eaXuwdAUAUtpOtlXlFVgbnB4VbhMTRN9hP2up
         uKD2ljXzJsOb7uZqb733Z72kJ9peOHjrMHlO4LObGbNRL3oO6iUD6nPfJVYhf+T/9uj/
         nQZTTbAOX10p7EAtWJ2gBW8h7RHOo4NwwE87poSEctzs6elD8mz5YoWvaGMyv4ZJMO0f
         B32F2eRkL6AibcLRdvICErQiLqiiK+Mbu0ve7CSRlHNoGl+qjy68WMBEwD/9yv/fyPAy
         xroA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706032101; x=1706636901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9NOEsfAi+dCuYvyEvTRzmh2vuzrG7B1XkljieNVSYmA=;
        b=uTw5lTTStiWns2MY8lfyWCbt/ipv8MrirdBEZMiHEiZ5gRBxzmNICSx4JnIkqVJfHN
         3taqAjIJgCbVen3e3O5Eml+PGW0p9N/8KV6E1FwmKPRLcqpwj1ustR9k6juZKjOTERhD
         NvLlyAJGv5M8uqWx43BbukiHV2FAoL0dZ2nwv4DQYbn5MUXl+iYWFp01YQ6ajri49xL6
         uXbUw5ItKchDQlhmnSceeAufOqqd0nG70OMPS508JueZBqJ1oByEcJvqD6pBYlP3duP3
         JEsL+RYEnehyX5fnQxSXN3s79zTSTneoBpenRc4Jca1zt6oKT3x29XUq+N88pHul68BB
         1Nzw==
X-Gm-Message-State: AOJu0Yw+3AR3Ff4idBUxXeioJjS70RNmXK8uoloEROXMFmqfyBcs4U8j
	HVwHZVhWmUqHzhbrjsqhYXwuEd1YWjaOxNFz+F34Tr6yOECH5JcAx/houJeyiA==
X-Google-Smtp-Source: AGHT+IEiIkfDLcT3YuMfeEsh95Y48Yx7/h/rH4r9le51ClmhlAM3satP7axp4ZVi759/Jpz7JXt6VQ==
X-Received: by 2002:a05:600c:68c6:b0:40e:448a:91ff with SMTP id jd6-20020a05600c68c600b0040e448a91ffmr333697wmb.168.1706032101493;
        Tue, 23 Jan 2024 09:48:21 -0800 (PST)
Received: from google.com (185.83.140.34.bc.googleusercontent.com. [34.140.83.185])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c499100b0040d6e07a147sm41630126wmp.23.2024.01.23.09.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 09:48:21 -0800 (PST)
Date: Tue, 23 Jan 2024 17:48:17 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	kernel-team@android.com
Subject: Re: [PATCH v12 2/6] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <Za_74T-IJWAa6fny@google.com>
References: <20240123110757.3657908-1-vdonnefort@google.com>
 <20240123110757.3657908-3-vdonnefort@google.com>
 <20240123105149.36abf019@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123105149.36abf019@gandalf.local.home>

On Tue, Jan 23, 2024 at 10:51:49AM -0500, Steven Rostedt wrote:
> On Tue, 23 Jan 2024 11:07:53 +0000
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > index 000000000000..5468afc94be7
> > --- /dev/null
> > +++ b/include/uapi/linux/trace_mmap.h
> > @@ -0,0 +1,44 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +#ifndef _TRACE_MMAP_H_
> > +#define _TRACE_MMAP_H_
> > +
> > +#include <linux/types.h>
> > +
> > +/**
> > + * struct trace_buffer_meta - Ring-buffer Meta-page description
> > + * @meta_page_size:	Size of this meta-page.
> > + * @meta_struct_len:	Size of this structure.
> > + * @subbuf_size:	Size of each subbuf, including the header.
> > + * @nr_subbufs:		Number of subbfs in the ring-buffer.
> > + * @reader.lost_events:	Number of events lost at the time of the reader swap.
> > + * @reader.id:		subbuf ID of the current reader. From 0 to @nr_subbufs - 1
> > + * @reader.read:	Number of bytes read on the reader subbuf.
> > + * @entries:		Number of entries in the ring-buffer.
> > + * @overrun:		Number of entries lost in the ring-buffer.
> > + * @read:		Number of entries that have been read.
> 
> 
> > + * @subbufs_touched:	Number of subbufs that have been filled.
> > + * @subbufs_lost:	Number of subbufs lost to overrun.
> > + * @subbufs_read:	Number of subbufs that have been read.
> 
> Do we actually need the above 3 fields?
> 
> What's the use case for them? I don't want to expose internals in the API
> unless they are needed.

subbufs_read is gone, I just forgot to remove it here :-\.

The two other ones are used for tracing with the hypervisor. That's why I
preemptively added them. 

I can remove them and add just append this struct later ... or just overload
this struct with another one, only shared between the kernel and the hypervisor?

> 
> -- Steve
