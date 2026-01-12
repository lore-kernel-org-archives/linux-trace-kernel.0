Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3026302CD9
	for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Jan 2026 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768232459; cv=none; b=qSCOaB9Ubu3jdCBF3wFTlzQvx8xjP6uVceODRcccLcIdEIzA44I5k5wQ7YxZgnjJ7mcr1+EVQEIWOjK6Fqhnijc+1RTPypQbFsLmz8VKjLBN398APoFSZaZuks5PLtLVRWHf1KP1nOuURgjG6+b5Ox6Q2G0z6cyEeaogQRQXpF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768232459; c=relaxed/simple;
	bh=Gumagb2Kelv1gToIkJNxiJ7CnRF5JhGc9vpKxcqq6gI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R3Q+QxEntnDvk/cLQ82lmkzAE9PPpV+ZXOay6K/H09xaFg6kFXhc0GpUG6IlJQhol9p88GOxxJVF+02OHFvYjUmU9X8c9aVOKGxLhnyngqqIVmAq23NNJZqEyGCEZqml+EciadwdHBCMQPKcY5JoCTmz2tbvReGiRj1pVAtJu3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FMwMQsSc; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FMwMQsSc"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b8704795d25so184601666b.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Jan 2026 07:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768232454; x=1768837254; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2qapUBTgVNiqcTXmWdBy92/Srtil3uAAM7XaJAm2tpE=;
        b=FMwMQsScvMFMXyu+pC4UFVIiyDewS5BPwcDiO7oQ3hiesiytsPTNch0V7ECa94XaCU
         rUVqEetlyjOevNThuZvhSewoPxyM8LYEmU5+/UBTtQr+vRhbIZ1PdhfHaFGqX30P7QTy
         fYSJhLrn+uZ2bKHnz/OMNnzCrtRi6kwAqDTMPny9B6cdnVHVRdKvP7mQ0aYOIEIW3jCo
         LhbiHaoQwy38Wi8TLcxnGPVScbtUPmT5ZVN8/YDvFaDmPlPaOV+vUyiXNibUb7Fl0Bnp
         Sdve6YFtMtMp7Fzcj+zHlY0gliWEjz5Y7UdKLDzstxCxyjH/3lJjhKgsdq+pXttHpP38
         jMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768232454; x=1768837254;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2qapUBTgVNiqcTXmWdBy92/Srtil3uAAM7XaJAm2tpE=;
        b=VPKtg0SHjbnIBuB+dt6o+Ii4kUoHZ3+d1j/eJl6Sf9xQMDh8CimP7fU2PhSABslLmy
         4mpVAPoHUkV9TJrnuvLrBCszpUyL6GS/eg0xIq2Ake4t0cF8Dknkt459ahZ4FeAMOnM8
         46MZHH6/9scBTRq2O68cvResTv+NjIZJFY8UhFYuW57m+6HGcgV+PwV6VefLivAxsPq5
         0mxRFGWYe5HDPrE1Vh7ROUuXQsyQCxNCJBMIq1oJcnUotgv+E9R0PvNoGVSwo/xjTHDe
         3ZiFYGs2YXwSa9rUd0ST+XO2eBgR86wma+xSGOOShbxsB+HvnDg8MTbVWMxVZv6vPs7r
         Uqxw==
X-Forwarded-Encrypted: i=1; AJvYcCWQ0xTBDvl9jouUMsBRHX8G3iIltGlPlsO0ogcxrae6inIVlWtHp9TTCdpzZqjYMAo3DCbqwZrfz5Fc5TIEhrEzX4E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydt0tbNz8VP4R+wzga8Q4XmAZcdG0O59d74KKP1v+S0elwcYxf
	TT74mTCnrIQyxd9DNptnigj+DLcLwCKkyDdVzaDf+vwBQe8UYwaTwTcxFsDUEf1mPixIKZO0iPT
	tfglDJIHkr/7YQkXuoA==
X-Google-Smtp-Source: AGHT+IHYpJ+ANWMsEPYGdlwYlVceaIe7xjP0Mb8XSqLVAMvUK02djlwbBFkmzuZ0j6VKF7A3vEi+XuD+bATUtIk=
X-Received: from ejchw19.prod.google.com ([2002:a17:907:a0d3:b0:b76:da45:a7c3])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:fe0b:b0:b73:6d56:f3ff with SMTP id a640c23a62f3a-b84451d416cmr1924364766b.20.1768232454411;
 Mon, 12 Jan 2026 07:40:54 -0800 (PST)
Date: Mon, 12 Jan 2026 15:40:53 +0000
In-Reply-To: <20260112132238.GDaWT1ntPxY8VD1hlH@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAH5fLgiPdBEN7mjgK64u19VGE_AWghTnCCHYuQQuwnTdvDaYkw@mail.gmail.com>
 <20260112122236.22214-1-fushuai.wang@linux.dev> <20260112132238.GDaWT1ntPxY8VD1hlH@fat_crate.local>
Message-ID: <aWUWBfKhP8DvzhDl@google.com>
Subject: Re: [PATCH v2 1/6] uaccess: Add copy_from_user_nul helper
From: Alice Ryhl <aliceryhl@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Fushuai Wang <fushuai.wang@linux.dev>, akpm@linux-foundation.org, brauner@kernel.org, 
	cyphar@cyphar.com, dave.hansen@linux.intel.com, hpa@zytor.com, jack@suse.cz, 
	kees@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, luto@kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, mingo@redhat.com, 
	peterz@infradead.org, rostedt@goodmis.org, tglx@kernel.org, vmalik@redhat.com, 
	wangfushuai@baidu.com, x86@kernel.org, yury.norov@gmail.com
Content-Type: text/plain; charset="utf-8"

On Mon, Jan 12, 2026 at 02:22:38PM +0100, Borislav Petkov wrote:
> On Mon, Jan 12, 2026 at 08:22:36PM +0800, Fushuai Wang wrote:
> > > strncpy_from_user() succeeds even if userspace data does not contain a
> > > nul. Then it reads length bytes.
> > 
> > Yes, but if there is no NUL byte in the user buf, whether you use
> > strncpy_from_user() or copy_from_user(), you need to manually add
> > a '\0' in the kernel buf to ensure it is properly NUL-terminated.
> 
> This looks like a bunch of churn to save a "= \0" line.
> 
> The more important question, IMO, would be whether there are cases in the
> kernel which *miss* a NUL termination, audit them and fix them.
> 
> That'll give you a better idea whether such a *_nul() helper is even needed.
> 
> Because converting only a handful of obvious places in the face of thousands
> of copy_from_user() invocations in the kernel is not doing anything useful.

I'm getting the impression that strncpy_from_user() is the real problem
here. It should append a nul byte.

That would also be a lot less error-prone than the suggested new API.
Requiring a length of N+1 is not the most immediately-obvious API.

Alice
