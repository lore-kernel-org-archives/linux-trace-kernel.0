Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B31B3A2573
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 13:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773408237; cv=none; b=ePKPtfiBOTE20vJYNg3gfA/syFzAH4L0mHitTkYo6vxjmVH4f0NDE2C7yFMzUl6ZHPXo+old4+Klr3XQTfH0QjP0iXq6a3yph87fH4wUoGpMc6qybwmj7pfRtAINUc18DUo2pdP0bNLyNP67YGZTj8qsEk3+F/3tzSYQ+R9ClGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773408237; c=relaxed/simple;
	bh=ZtHwRVLIvoDuwE15SqsQokaOwa/XA5uaZPU2Mzcfynw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=qfAwUhrXoLx+J9WKWz3EQEjGXvyXuw4RMw+VnztXAk5DzKgefG0481afMgghkjrBNtHi/z2TWtKJMV3rBawkDT3Ev4uhli1BVmyFm90R19sQ7/ye2TLuFIJsMyTDb86tPxi7DQjjas/Gtl+4gr2o/sK+4PaL4jta6jlvp0mR36Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hDy32fcv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hDy32fcv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773408233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R7HlaCIiaZDqWdp+o834N7JPGX2olX/c1Y000VF8Mwk=;
	b=hDy32fcvLxto/oa9GoacJCB7j2l1Jv5689OLc6kBGZfDmtLzdoGYkhGQ5+AZlTUIuW0/A+
	lVfhIcibs7iTEwHvphXvlsDBtpFD/c9CbNCTqVWRpHuR5kNmH8Hu9JgBICicZR9p+bv5gS
	m/SHuYFVo/Hf6JzMXOBHBFLJdU0luZw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-YEhLQVDeNKGDtlXvtIegbg-1; Fri, 13 Mar 2026 09:23:50 -0400
X-MC-Unique: YEhLQVDeNKGDtlXvtIegbg-1
X-Mimecast-MFC-AGG-ID: YEhLQVDeNKGDtlXvtIegbg_1773408229
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4836abfc742so15242325e9.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 06:23:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773408229; x=1774013029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R7HlaCIiaZDqWdp+o834N7JPGX2olX/c1Y000VF8Mwk=;
        b=YvUHtBKlHy15BsSXhdYtHFGc1Mhy0t8IEFm6BsBJId7pSFGFh2Hhql8YbSm0KdPqFJ
         lewtOCDVfLsRwsg/MtoiisCgU8gQbQMJCe8Z+ES6+prQkCYBTbFLS64CxDaJCzjXZhHN
         w+TaqUdq8LR05qrM3XUgC/TfUxAQfQ9zupVSzrRvuddex3nlf1A/8DWFAGkTXaAc/yyq
         pdXB+WM3tnAO6xqDbf8WeAQnxiBw1D+H5L+9YNbyLtYhJjtO0NN2xFqv8A8/DidBt5jP
         wpbEinf5/JwX1OqGRdxaBD81PZVQ6uzomsnburyvGyq3FduOXAlw8f/2bP+k64TU6NFd
         0JTA==
X-Forwarded-Encrypted: i=1; AJvYcCXx39znt5gYgqwPFFoWbrjK3jDlimSuEwBx2duEbL3Qn6QrSdOwMj6uoBGVnmjjJp9nWG+sscuqr563ltkKtI/2GPw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1ZFoimXphw/lMf+Ofxul2TekZqoNqxnlhQ2kMUeFi3ZhMa8r0
	MOO9lPo8s2yuU8Ox7sEMRyci7lQ2GAoCq7BFPsbxeaxkc8RgZEEWPLIVjF+RZYOY/DDR0FpqbAF
	nHaJa38LzQrzW6YvUYPFoXEZQKQ3RtnfiwdJmNdBQddtj9BTov/wFpj4rKUm7qIRU5amhargj4w
	==
X-Gm-Gg: ATEYQzzc2rW7llCOLjQJK6VNyb+uNwFN9fXzHppqSnCI8UxcZue2rNv4EehZjtLrFGR
	QH9feWXNRqHpWf8r6gHx62+L35aPjQL0bEGRiMF4ic/Bfiv7uMR76rvRW/HrE87PfXYgaCf7FcE
	TE6On/49+/pcI53W/5mBmiT6dFocQnhCiXe9XYK//25K+leOLssZn3ozIA+ZIuJdmZCTJXyFh1u
	0lgd6qFv77oN6Rnsh+WpZcq5WfdqGLBGDqrLHN8LkKXBS7anINRRqrlRe6/mtboUPQjWcVwPYnX
	2+PvER4/ivAvtxqdcyQ8lb0bu5E7rghmgY5Eim9karJZe5btTcYmUtpaiadwDpUjk6dre0ECTlz
	dPDjofUC3OHt9llkW+n6uHdE4O1dBOj38Y7X156IV/FMfgGSdULs=
X-Received: by 2002:a05:600c:8b46:b0:485:34b3:858a with SMTP id 5b1f17b1804b1-485566d2d66mr52863235e9.11.1773408228600;
        Fri, 13 Mar 2026 06:23:48 -0700 (PDT)
X-Received: by 2002:a05:600c:8b46:b0:485:34b3:858a with SMTP id 5b1f17b1804b1-485566d2d66mr52862635e9.11.1773408228148;
        Fri, 13 Mar 2026 06:23:48 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.82.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48557784c18sm51257345e9.4.2026.03.13.06.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 06:23:47 -0700 (PDT)
Date: Fri, 13 Mar 2026 14:23:45 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: gmonaco@redhat.com
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>, Juri Lelli <jlelli@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Tomas Glozar <tglozar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v7 05/15] Documentation/rv: Add documentation about
 hybrid automata
Message-ID: <abQP4ZwPZsBJ0TO4@jlelli-thinkpadt14gen4.remote.csb>
References: <20260310105627.332044-1-gmonaco@redhat.com>
 <20260310105627.332044-6-gmonaco@redhat.com>
 <abKX1XO4vqY74uA7@jlelli-thinkpadt14gen4.remote.csb>
 <4620e92b1c7f4d87f192a017f3026dfc17bcaef6.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4620e92b1c7f4d87f192a017f3026dfc17bcaef6.camel@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _trgAfRm2MOOqlvULarMV3aEx-ahMnvmLY3OiQcVMd8_1773408229
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 13/03/26 14:05, gmonaco@redhat.com wrote:
> Hello,
> 
> On Thu, 2026-03-12 at 11:39 +0100, Juri Lelli wrote:
> > Very minor nit, feel free to ignore, but ...
> > 
> > The formal 7-tuple definition includes 'i' (invariant function), but
> > unlike other elements, 'i' isn't stored in the automaton struct -
> > it's implemented as generated code in ha_verify_constraint(), IIUC.
> > Worth a brief note clarifying this design choice so readers don't
> > expect to find an invariants[] member in the struct? Here or below in
> > the example C code section.
> 
> Thanks for the review! I haven't really thought of that.
> At this stage we are not mentioning any struct element (it's purely
> theoretical), so there shouldn't be any expectation from the reader.
> 
> Later I mention "The function verify_constraint checks guards,
> performs resets and starts timers to validate invariants according to
> specification".
> In fact, also guards are not represented as part of 'function', I may
> mention after that sentence something like: "those cannot easily be
> represented in the automaton struct".
> 
> Not sure if saying more wouldn't make it even more confusing than it
> already is.

Yeah, probably. As mentioned, feel free to ignore, it was just a
thought. :)

