Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F50D3321BD
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763029939; cv=none; b=QGyCDA3pNaCASixCkOZfdcgpFZhB+9Xa19TNQvTN3UlflV2oSWMsUvB3KAtfLTYbrzHYhLRmkqGglPRAU7bv8PKjlyjmB3WjKjqJQgSyGVaf8MS30+iWriyvPEbtAsPfecGdAFY04X3YtRKgFXwI0c+kJ8hMmUoJuNVgo7XMoE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763029939; c=relaxed/simple;
	bh=/ez4viGQxwKl6xh/PPq/TWsOWmDT70HNbDNx4QUOYcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQCfcuuLUTrq9O4xmxsMo+PlvO/dHsuupTySPbVEs4cXCYn8tpZ2TAjxk9S9OfpjpzoowTmVWOx6cAS8/v/2GBlOqtICCBaBBQE/36IcZiqtak+2YtE1iGy9XjimSj5Lskry8o1YqEJsbjmwwcuzDL8duAwXuR2+ImUPaLpFEvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=tSNZuhly; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="tSNZuhly"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-297d4ac44fbso13317475ad.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Nov 2025 02:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1763029935; x=1763634735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QURbCPhZLgDFuDO50oTy4YxAU/M/cxLF0F1zsVf26eM=;
        b=tSNZuhlyAsQdCBROny1W2LKQ+njhOt2F7hJrDAVykMsiBZA2MsD9NPFanFer8ixnfI
         sdkBrAmS0uqU6umEqeHqPVbTAle0GYtByJLkmItLMttKPO8XRDP73qkQbC6Fk/Juwqd1
         shoafwuSzT7epdC6vUtw6oapaYnkQHyTNmWSRjPCqiEXdnAjgW6Z0qCiCt54EKdDGzRE
         pJp7ktXn2HGrXD+4hBvWl7fl6rjgS8nluU/PbinBDE7EejqbotPO8fLloqqISnl6HC23
         kq69ahcD1dtQNS+fzxbMp8d7RWVFJAwOohDH7u01gS0lzSvXcx7xY14NndQNP7hqGl34
         wiNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763029935; x=1763634735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QURbCPhZLgDFuDO50oTy4YxAU/M/cxLF0F1zsVf26eM=;
        b=PzT5zruOFU+N9ElLcaTEb1XRT2UlLD12LqCxvnzvVgYjMF2SrigOhXwbIxbVFFC2+c
         cjCmK8gNAYyr3U73YsxW5NOof36CeR/YsdRk1GJKEOS3aMUJ7fon4RRo61qKXh4jSdgc
         dEJoI4GCC6zKsXN6+pUBzPm7a+ukMeLu1Jctg0/u3j4kwHB/hLvP6TN/51b4hQqYUMTe
         VMmw1KBSHdkV39AJZpOBvyoixWT0as7EhR5Def3PXQtCx8Ef8tGalhhqNdyzsfpP4yQ/
         kfvH4/0kAY7r8Xuc9GPoeyA71pDmdYnbS1uwXqHj0P/sLUjSDaQIpd6ymhVaBsmDFvLX
         jclw==
X-Forwarded-Encrypted: i=1; AJvYcCV25Wx1qACwPm4HUMwbB7Arl/BIMiAi6w7p5GNOzk00VWtSmGzoq5NM6H42qnJ/QazBQ/2813xA2zWC2J/mQ6khQRk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6w7jDHmXCKBFk5JtWUq4qHBjEDbP0yxPCRi8I+zOguE56UpjL
	cNRqWnFChI5IHDCPHvjgk/W95xrgq3bXvuh8/JcOvQE65egilARYmDeW0ZHm9b3vwMY=
X-Gm-Gg: ASbGncvBJwxusXgofz94IgB1B6cy08huQwx8nMkTY0B/Inj3655BrEE4gE5O0azihkL
	syLL6WHfDzL6EZY9z8+vGFByinTKrmY7m4fD4FNLM9ljaEAtdoJT/Nl3JP3wvSbtGtbXfoiW5/a
	3Xy23B3lx3CCaPjcZYZMQFXE7JlDqr9lwHO91MMzkyAIIZdqFA28jSogzs25tiSJBYK1K8SfHym
	yOes9uY1/Dqhc1QmNQscadcYuBgtGDeyVdEVSLuH6XUrQ0fe6nTiI7UG4z11d6jQrU3Y3feF6Im
	eemguJ0cosem5Xheh4KVA5Acz2VCnUusxEinjqJL/IhebETlftpD3EImbKGNNJnnISPyuoPDngN
	kXvcqzr1FVQtjFV9eiVxy4BKZcM1v76hCRLGySKhjM7yFbZZGZ9twj2F4rrGXbtUaxMLcWM6rtP
	1tzYWbTJUjac0vMNAE8MXbODe7IUAbRrXCBkGqjXceRIZNVXPhpGs=
X-Google-Smtp-Source: AGHT+IHZRVqKk3Xf4AoXPh3RQ9USehQ1ClsNRN+oJOsjTDjAvAY9LII/LH2yTXr91VjJoLaVXeTfMQ==
X-Received: by 2002:a17:903:1af0:b0:267:912b:2b36 with SMTP id d9443c01a7336-2985a51863emr28237365ad.23.1763029934984;
        Thu, 13 Nov 2025 02:32:14 -0800 (PST)
Received: from dread.disaster.area (pa49-181-58-136.pa.nsw.optusnet.com.au. [49.181.58.136])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b0fe9sm20457965ad.65.2025.11.13.02.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 02:32:14 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1vJUcd-0000000ADSS-414B;
	Thu, 13 Nov 2025 21:32:11 +1100
Date: Thu, 13 Nov 2025 21:32:11 +1100
From: Dave Chinner <david@fromorbit.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Christian Brauner <brauner@kernel.org>, djwong@kernel.org,
	john.g.garry@oracle.com, tytso@mit.edu, willy@infradead.org,
	dchinner@redhat.com, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, jack@suse.cz,
	nilay@linux.ibm.com, martin.petersen@oracle.com,
	rostedt@goodmis.org, axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/8] xfs: single block atomic writes for buffered IO
Message-ID: <aRWzq_LpoJHwfYli@dread.disaster.area>
References: <cover.1762945505.git.ojaswin@linux.ibm.com>
 <aRUCqA_UpRftbgce@dread.disaster.area>
 <20251113052337.GA28533@lst.de>
 <87frai8p46.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87frai8p46.ritesh.list@gmail.com>

On Thu, Nov 13, 2025 at 11:12:49AM +0530, Ritesh Harjani wrote:
> Christoph Hellwig <hch@lst.de> writes:
> 
> > On Thu, Nov 13, 2025 at 08:56:56AM +1100, Dave Chinner wrote:
> >> On Wed, Nov 12, 2025 at 04:36:03PM +0530, Ojaswin Mujoo wrote:
> >> > This patch adds support to perform single block RWF_ATOMIC writes for
> >> > iomap xfs buffered IO. This builds upon the inital RFC shared by John
> >> > Garry last year [1]. Most of the details are present in the respective 
> >> > commit messages but I'd mention some of the design points below:
> >> 
> >> What is the use case for this functionality? i.e. what is the
> >> reason for adding all this complexity?
> >
> > Seconded.  The atomic code has a lot of complexity, and further mixing
> > it with buffered I/O makes this even worse.  We'd need a really important
> > use case to even consider it.
> 
> I agree this should have been in the cover letter itself. 
> 
> I believe the reason for adding this functionality was also discussed at
> LSFMM too...  
> 
> For e.g. https://lwn.net/Articles/974578/ goes in depth and talks about
> Postgres folks looking for this, since PostgreSQL databases uses
> buffered I/O for their database writes.

Pointing at a discussion about how "this application has some ideas
on how it can maybe use it someday in the future" isn't a
particularly good justification. This still sounds more like a
research project than something a production system needs right now.

Why didn't you use the existing COW buffered write IO path to
implement atomic semantics for buffered writes? The XFS
functionality is already all there, and it doesn't require any
changes to the page cache or iomap to support...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
