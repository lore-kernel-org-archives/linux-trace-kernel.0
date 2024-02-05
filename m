Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40887134A3
	for <linux-trace-kernel@vger.kernel.org>; Mon,  5 Feb 2024 09:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707126246; cv=none; b=GEByvmONFwJ/TiMioNzmYNcHofufqtgEZVt8kM7Q/U1mkZpTfH/sSsx2lsx1S6wYePLurQCylnyPZoNzt3D72mFV0qdaC9Hy750EFwJ6DHOl0bGnF6vhgJ1lS2amzg2/S3QjUke4/88FwDs5445myo+AEGjNyylHdt7noZVQwY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707126246; c=relaxed/simple;
	bh=+yO2XqpyNgbvfc/TzbsFxkAniaErxMeuh58ZQ25HP88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqd0gbV18nfqx0SG1RIrfMDh11oLnP1QOSsZXb4hYZZx/y3g+rtcPgQuQtFCg44UuRb86GDb/GKCn+yv3PuCqI0q7Ha5+xogEg99RfkO5PWowWaEpEoj/iJav/3Ikdwyf3MF8psmTzo3D2m6rifqWHgio/t2xtTCaPUscuW6dUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M3IMwIOO; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M3IMwIOO"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40fd72f71f8so5581265e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 05 Feb 2024 01:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707126241; x=1707731041; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=10BvlSMBOf9L9WLyXGyppPxhsknZ/PTNIDqct2oe/RY=;
        b=M3IMwIOOVPqpCCWejLCdKt5h98OTXYRo4MeCUy2pLfHODx6Nl+3Q95OzXpD4Jabc9p
         cXU7haPM3x8BdIOLYqFp4SBP55x4QIddjAxgcCZO6apYcc0XMQMJk5ijIdj0CFIfxJmT
         7TG//tUARSfF9VlweFrEktdieKN2C3kQAw3HHUTeiU8frekHBgd/rXGPkRhpfM4JlUcd
         bxWLCb8muebcJBTqTr0rbr/o4PEGkY7IeRd4acZY+f8FNCbWZcwZvxdo8fks130pgHJv
         ZpYtmgpfMjfYsUR3RzuRjajLq6HIuL35pICljMtww6dG2bmP0+LKQjH0jEgtYgfOADVe
         n1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707126241; x=1707731041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10BvlSMBOf9L9WLyXGyppPxhsknZ/PTNIDqct2oe/RY=;
        b=CunkA9RsTTIGWxbp4HWAV601Y0P2ay+Z+cSnOguvUbkELCS9kxARhhaWCThD/n1KvT
         +DLPaTAmy0Jkw5LZx8jRK++LngceTSwmaWEi6BgbEkQJMyyUHaErEiGvy4v4zGg/fb5B
         RsAuVAYdo24Y1oQFISodn+fs1uRTq9E0J0yK/4buzXhLg2pfgpTV3BZtkeg/z5pAqARE
         qD8hqA2Juby0JOH5C0UvM+2grWRIiyXxExDgvzp58553XWHIaFxJWdu+ZcP1FxM/JtLq
         hqvzRPZv/8KaDXOdTEkUKEEYO0yzlx72WSitv/kDAXVd3LBCgM490C8pHB9DRebDZpM3
         BC6Q==
X-Gm-Message-State: AOJu0YwfJLqxxC6zN4WRPK6G9rD9TXXe7DzVo4aLGp43/T+Ui+SHOfyR
	XOHy0SuEmcb8GGWGt4gdLrlGbVmQ+XB7qoyOYOntj3eU+QjWkV9PpNcy+ngn6g==
X-Google-Smtp-Source: AGHT+IG57hSnEtL5HNUd+F6pM2/xUxxBNY/XxQni86ftTiBIdaM4ODjwVxglQWvQnbVa7YOfRVj/WQ==
X-Received: by 2002:a05:600c:4ec9:b0:40e:fb74:c514 with SMTP id g9-20020a05600c4ec900b0040efb74c514mr3697897wmq.7.1707126241361;
        Mon, 05 Feb 2024 01:44:01 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVPAZ+NrGCEUjPrlYnpnZfjMPyCmuW+1SJ8CuE4hbzCoPzygRgIDUwn5QLPZrdL7x2V2csRUuveuvmXScAVdblgH9ZIracKB5oQryZSw/ZL0mtZBSFa5sEGMxHBpjaeet5f1YH0iUe15Hy/65c+iHaLvEr5BxVmCIqSfFdOVHxM7Z/SPb+HZ02aF2hv18x9G+44SlkxZFpxLMKDhfIvuauZaFTnun9UlMWI
Received: from google.com (185.83.140.34.bc.googleusercontent.com. [34.140.83.185])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d6604000000b00337d6f0013esm7622180wru.107.2024.02.05.01.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 01:44:01 -0800 (PST)
Date: Mon, 5 Feb 2024 09:43:57 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	kernel-team@android.com
Subject: Re: [PATCH v13 2/6] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <ZcCt3U11JeiZOyPn@google.com>
References: <20240129142802.2145305-1-vdonnefort@google.com>
 <20240129142802.2145305-3-vdonnefort@google.com>
 <20240203193351.76bbdda9@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203193351.76bbdda9@rorschach.local.home>

On Sat, Feb 03, 2024 at 07:33:51PM -0500, Steven Rostedt wrote:
> On Mon, 29 Jan 2024 14:27:58 +0000
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > --- /dev/null
> > +++ b/include/uapi/linux/trace_mmap.h
> > @@ -0,0 +1,43 @@
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
> 
> That is "the header"?

I mean the header of the "bpage". But that is confusing. I'll either remove that
mention or just say it is aligned with the order of a system page size.

> 
> > + * @nr_subbufs:		Number of subbfs in the ring-buffer.
> > + * @reader.lost_events:	Number of events lost at the time of the reader swap.
> > + * @reader.id:		subbuf ID of the current reader. From 0 to @nr_subbufs - 1
> > + * @reader.read:	Number of bytes read on the reader subbuf.
> 
> Note, flags needs a comment.
> 
> > + * @entries:		Number of entries in the ring-buffer.
> > + * @overrun:		Number of entries lost in the ring-buffer.
> > + * @read:		Number of entries that have been read.
> 
> So does the two Reserved words, otherwise I'm going to start getting
> error reports about sparse warnings that check kerneldoc comments
> against their content. Every field needs to be represented in the
> kerneldoc comment.

Ack, wasn't sure it was needed.

> 
> -- Steve
> 
> 
> > + */
> > +struct trace_buffer_meta {
> > +	__u32		meta_page_size;
> > +	__u32		meta_struct_len;
> > +
> > +	__u32		subbuf_size;
> > +	__u32		nr_subbufs;
> > +
> > +	struct {
> > +		__u64	lost_events;
> > +		__u32	id;
> > +		__u32	read;
> > +	} reader;
> > +
> > +	__u64	flags;
> > +
> > +	__u64	entries;
> > +	__u64	overrun;
> > +	__u64	read;
> > +
> > +	__u64	Reserved1;
> > +	__u64	Reserved2;
> > +};
> > +
> > +#endif /* _TRACE_MMAP_H_ */
