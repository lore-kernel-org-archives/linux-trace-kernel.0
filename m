Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0129F33C197
	for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Nov 2025 17:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763487079; cv=none; b=nX7TI/LziI8q6cHPGuv1HSjmkfQNvtVFV7F4HNNmqoEumV8lczACEe1ry40gCnv4J1lXgcbyT8zDiEGKyYHh+o2dbQD876pV1DueI9hUInplGtEunQFgBWELvYGlYLH/z+5bit8EY8IOQDa9CvH6fLYWCxek5btmzr1SUxHAzP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763487079; c=relaxed/simple;
	bh=nhASVdDt4OdAwVAANU2bomnv6+IJT33HttvU1MpH8Lo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=S+3NhLQKarjWN5yfzHJ/oj9oLciHQF5hOF9vyIsPCnZa8WerkHunsr+DT/PUnWcKKXTXGFDgmkSh5om7swYB2v83WdCrh2QA3KKSMt12XfFuTXmPc7wwmw03LjXo+aMU99kvevMuervcgCzqL4TAWl9Md39/1B8SUQZSYbZQkRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLoGzHJf; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLoGzHJf"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34361025290so4413006a91.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Nov 2025 09:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763487076; x=1764091876; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jJZHPmpfAYK3kOvAYzdDDouNFc3+GX3mg/4dP4wkGpE=;
        b=NLoGzHJfgXsbAIpeLOuT6H6thcbOWsDrkYUlxHE9fk3EaW4cGSmISVyDK/gU6ynD88
         N14Z9t/iBYvcVGGUJmeap1tNlmbkLAjhKlO+R0Dgqq2Is/zEvq+xKgVPOz5ZG5yPGTNM
         ubaLmhdYov6TNgBBIgKY995lAQtqIcbwfnFAi76HWg7vURciDFf/clqnmsX/E6xwn9ys
         HhzeJjSb/w6tbMbCjRS5qTE6A3g4D5uSTi50vWEpjslAIkTDywlrFQRmUKQfGoaiFbgV
         Yoju0NimoDihKurn/a1/7eNFWW7gMu4HWdBJazse1O9QWcZTXqRrQHyNqfB+W5W3kNjs
         8KRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763487076; x=1764091876;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jJZHPmpfAYK3kOvAYzdDDouNFc3+GX3mg/4dP4wkGpE=;
        b=EHgQR6jN5N7p//AtoiWyGS8WVCp9STj558MGmpfSsi4ZmCthA8pJBBQpL2n5wlobPY
         iQINNHJFQDD3PoRyZRK8zoMRYAJAc9mToQYp2U+n787yNr6QAvDBA1r6LufonUsxNYNj
         33VolfUltB8pHNhaKs0IabNEsp2N/73045jm3y//XvElTkbDu+aqJT77cJotXbBjZib8
         b9Yds6CI9eagm5/FfNnCH4btATpndAisYm/ZYcY9j8Eszxf7D3sY6phtKQ9cVoNzjceQ
         1PPhDDfGNmJ3SKXgdb786wBZ0EPAQfQb0GCCnblCXp+4vRbqKtGcGerUB7CQnS8dQkd1
         hcnA==
X-Forwarded-Encrypted: i=1; AJvYcCXK9470z0HToI5vdXKJh5g4/6C7tspFapT46SlfWrF5+GcgWrn8Row3bE2Bz6y1V6Owq3o1NiLqRz4S0MQO4k52UGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqcpbY7mpjMdPDienuMFupGKMf2nLjLZnKIjXy0cJ9H31Om50q
	RHzRlFHteXOpLdfPFE9eIvqtOazzXP+QO1U0J2zfnrL8DNIaQIE1X5+qMpNAZw==
X-Gm-Gg: ASbGncvQXflOKizx/Vs3D/ob1LyLPVwi8k6KG+5XH9H1TZ3udrwwXAz0N0RYud3CmGL
	FAodXSnUTDaP8Ri6KSMoVTPXpi94+1eBOIamUKhDc/95HGqKG8epdsU7XQ03Zd4kd8z7f7GwYRQ
	yXjprtNBrZqMreNbAlC6qdNaGracS0JEY0OdM/rxAI76CiNSAiNcPz0iikeOTNOIt2cyv8S1GDY
	S/9yYd+H3nPftkQWw2sNMCTX0QmLcHX7oDQpEQrpI15mcyzN6KDfFS6438p2Nc1JZEprPjCoWJJ
	SHycjk5zMwH4dnp6QWO3s+upaT28r26Jgwgf+QiHJpCn343FhUwSnNx8Btpzkdfnp1+oh5dIhFw
	OmSbkAPOaPaimuxch8wG9WkOwwObp/kg6wr8u/VlXT5B+OWLiHT6VBl9c96S2KXRg9T1XNBg=
X-Google-Smtp-Source: AGHT+IEQrU5uwPDP3B0D60MQHHmGXSAeXE5fv7FgIePf1xPikPaNbxxiXR2fp/Zl+qVssNoTrpyjFQ==
X-Received: by 2002:a17:90b:3843:b0:330:7a32:3290 with SMTP id 98e67ed59e1d1-343fa751ad3mr18844371a91.37.1763487075532;
        Tue, 18 Nov 2025 09:31:15 -0800 (PST)
Received: from dw-tp ([49.207.232.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345af0fcc0csm1694884a91.0.2025.11.18.09.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 09:31:13 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Christian Brauner <brauner@kernel.org>, djwong@kernel.org, john.g.garry@oracle.com, tytso@mit.edu, dchinner@redhat.com, hch@lst.de, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, jack@suse.cz, nilay@linux.ibm.com, martin.petersen@oracle.com, rostedt@goodmis.org, axboe@kernel.dk, linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/8] mm: Add PG_atomic
In-Reply-To: <aRcrwgxV6cBu2_RH@casper.infradead.org>
Date: Tue, 18 Nov 2025 21:47:42 +0530
Message-ID: <878qg32u3d.ritesh.list@gmail.com>
References: <cover.1762945505.git.ojaswin@linux.ibm.com> <5f0a7c62a3c787f2011ada10abe3826a94f99e17.1762945505.git.ojaswin@linux.ibm.com> <aRSuH82gM-8BzPCU@casper.infradead.org> <87ecq18azq.ritesh.list@gmail.com> <aRcrwgxV6cBu2_RH@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Matthew Wilcox <willy@infradead.org> writes:

> On Fri, Nov 14, 2025 at 10:30:09AM +0530, Ritesh Harjani wrote:
>> Matthew Wilcox <willy@infradead.org> writes:
>> 
>> > On Wed, Nov 12, 2025 at 04:36:05PM +0530, Ojaswin Mujoo wrote:
>> >> From: John Garry <john.g.garry@oracle.com>
>> >> 
>> >> Add page flag PG_atomic, meaning that a folio needs to be written back
>> >> atomically. This will be used by for handling RWF_ATOMIC buffered IO
>> >> in upcoming patches.
>> >
>> > Page flags are a precious resource.  I'm not thrilled about allocating one
>> > to this rather niche usecase.  Wouldn't this be more aptly a flag on the
>> > address_space rather than the folio?  ie if we're doing this kind of write
>> > to a file, aren't most/all of the writes to the file going to be atomic?
>> 
>> As of today the atomic writes functionality works on the per-write
>> basis (given it's a per-write characteristic). 
>> 
>> So, we can have two types of dirty folios sitting in the page cache of
>> an inode. Ones which were done using atomic buffered I/O flag
>> (RWF_ATOMIC) and the other ones which were non-atomic writes. Hence a
>> need of a folio flag to distinguish between the two writes.
>
> I know, but is this useful?  AFAIK, the files where Postgres wants to
> use this functionality are the log files, and all writes to the log
> files will want to use the atomic functionality.  What's the usecase
> for "I want to mix atomic and non-atomic buffered writes to this file"?

Actually this goes back to the design of how we added support of atomic
writes during DIO. So during the initial design phase we decided that
this need not be a per-inode attribute or an open flag, but this is a
per write I/O characteristic.

So as per the current design, we don't have any open flag or a
persistent inode attribute which says kernel should permit _only_ atomic
writes I/O to this file. Instead what we support today is DIO atomic
writes using RWF_ATOMIC flag in pwritev2 syscall.

Having said that there can be several policy decision that could still be
discussed e.g. make sure any previous dirty data is flushed to disk when a
buffered atomic write request is made to an inode. 
Maybe that would allow us to just keep a flag at the address space level
because we would never have a mix of atomic and non-atomic page cache
pages.

IMO, I agree that folio flag is a scarce resource, but I guess the
initial goal of this patch series is mainly to discuss the initial
design of the core feature i.e. how buffered atomic writes should look
in Linux kernel. I agree and point taken that we should be careful with
using folio flags, but let's see how the design shapes up maybe? - that
will help us understand whether a folio flag is really required or maybe
an address space flag would do. 

-ritesh
