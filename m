Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FCA1AE0BC
	for <linux-trace-kernel@vger.kernel.org>; Thu,  4 Jul 2024 12:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720097794; cv=none; b=pSLH58rzEi+E7HhlJHt3tu7WuudAYqpmf80/xRNaLPHbOlIkVHSGhpIRzQ/dOxCnbOcLNOSXWCp5N2lr3V3M6N6rkhepYg8DZJIBkj2jDmwanvsyi14/qc0UXZWKUYGPUSA/+MrsL0aXYdqYPKJkrdRK6ykOibuMAcBiABhUvwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720097794; c=relaxed/simple;
	bh=/9zLhHeUel9AqeBH7jq/R8SwhtzjDAix34n+9uznz9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBtbZdNAxm0zP9hohGnnQRNoXyvYVBJwJCWatH/jlMYEOCQfgAFY5z5XZfx/6eReZUq176Bbv3MeYNLqDg/2eO55ULhp1GfrS6qt8YWgKllt83vbwfpBF4XyAAmtjYlwzJwZl1SWfyApHlpaA2nG8rKhi+p+ihtoKF5wdjIBKvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=spbv8AnV; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="spbv8AnV"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7021dd7ffebso353435a34.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 04 Jul 2024 05:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1720097792; x=1720702592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cjid4GTFzfR09h4v9US7cG+cmJ1miiJzUsalhJBWqP4=;
        b=spbv8AnV9FT9T0wVcvYbWI5jm9ZEFPsgAB8c2YRIzqCQIS7BQ+YUTWvwLv0RgsU+b1
         6lwhZv3+C8pKfcwkjRc4AEi8xUQMToSTW72wpoi1qRM55/qVRCKDDqu7acGCXFqxnp/s
         sOeiSBlN26RI/iuvHL/eN1+k0+0MnedrEH5W7/C8QjdUYA/c9RqBmgWktR9Fh1lki0dr
         kpOkFKu/xP3E5QpvdGdsVB2hL2v5WynkZ3+62Qg91BehL7ipMKUcMh66jf5mom2IYO0S
         syA3aXAaRyfu0N08c9mJM5ogA+KuqobkY90PszY+wM1ZKeSnaBvYccQxZQsFMifLuKZX
         9eDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720097792; x=1720702592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjid4GTFzfR09h4v9US7cG+cmJ1miiJzUsalhJBWqP4=;
        b=wKEAM9r/jTW5rTe9ViRdupOeJ4h66z3bKB6ZGl8NpPOr9pn1pjQTExS5b9wqnCQC+j
         it3yXf9kTSZNwqg/MpjFsQavKIvIJJo+9pzbJT/PglGd16KwNO5cpobVKx3oG1+hMU10
         t9wUXvPc2TFdjH4cOOEFVtuur6iTmP4XFH8KUK5PfleslEU/LEExXj2zRV3OOeI/3uas
         KHEYolUaTVWyCu3vGgT2LnQGLKlmC14UVCUBwkJ0ThObw7ERq0gpAyL6QDxlrQQ3RmQ4
         Kvp4nHXq8k15OTZGGHqHjI8jHPP7ZFMwQoOiXb67llfeWw5e8gpjauBHhZdWHj4IbJOO
         XqGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdEyyB9QL/8ZSTZZDsze+NInSWSjh58/0tdTFLCGUR9wI5DyBvumHyQW6yOdxOJ7Drty7/dJ1SJoyOuCV3h0o038QDEP8Vv/kO1U2+Xrxja/QT
X-Gm-Message-State: AOJu0YzJG38MjLWMF7ngHezLt8Q33g2ss/xS++g0lQTMFaskXVgb0Elh
	FGNj12RPSwZIU5t0gK+vX8yW45ZnoSXkYUF4yrZ/VplO/iTqmaVop6xGBep916s=
X-Google-Smtp-Source: AGHT+IHHEKbhN34mmx22VmG12egb05zVh7bP1Nwrq7g2TDcyoxukSUTmEnpHf209XtQt5Suwgnd4Tg==
X-Received: by 2002:a05:6358:714:b0:1a1:f9fa:bb7a with SMTP id e5c5f4694b2df-1aa98c51e16mr116888355d.16.1720097792230;
        Thu, 04 Jul 2024 05:56:32 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-76148ca3d12sm806521a12.33.2024.07.04.05.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 05:56:31 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sPM0j-003rAh-2f;
	Thu, 04 Jul 2024 22:56:29 +1000
Date: Thu, 4 Jul 2024 22:56:29 +1000
From: Dave Chinner <david@fromorbit.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Hongbo Li <lihongbo22@huawei.com>, muchun.song@linux.dev,
	rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] hugetlbfs: support tracepoint
Message-ID: <Zoab/VXoPkUna7L2@dread.disaster.area>
References: <20240704030704.2289667-1-lihongbo22@huawei.com>
 <20240704030704.2289667-2-lihongbo22@huawei.com>
 <ZoYY-sfj5jvs8UpQ@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoYY-sfj5jvs8UpQ@casper.infradead.org>

On Thu, Jul 04, 2024 at 04:37:30AM +0100, Matthew Wilcox wrote:
> On Thu, Jul 04, 2024 at 11:07:03AM +0800, Hongbo Li wrote:
> > +	TP_printk("dev = (%d,%d), ino = %lu, dir = %lu, mode = 0%o",
> > +		MAJOR(__entry->dev), MINOR(__entry->dev),
> > +		(unsigned long) __entry->ino,
> > +		(unsigned long) __entry->dir, __entry->mode)
> 
> erofs and f2fs are the only two places that print devices like this.
> 
> 	"dev=%d:%d inode=%lx"

"dev %d:%d inode %lx"

i.e. every token in the output should be space separated, and no
commas between values.

Any other format makes it difficult for post processing tracepoint
output with sed, grep, awk, python, etc. Every token then has to be
split into name and value parts, and then the value has to have the
comma stripped from it.

Having to do this is additional work when writing use-once scripts
that get thrown away when the tracepoint output analysis is done
is painful, and it's completely unnecessary if the tracepoint output
is completely space separated from the start.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
