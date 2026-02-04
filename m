Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21309230264
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Feb 2026 12:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770206798; cv=none; b=HtIiBqJgB/+9pl6ITGo6YOJ49SAoZ8I6saGJg+kQpkkZ1eQPnU9UhyXVWiNgSRRIlHWlL/Vc6I8GbciQZulgfwtCZ0vTyt7z5y86dGnfqtfUeTaNp5k1atNMTv7FJnrzVleiE6YRommiqN1AZp58eYODZKQ7BEx5h1vXjZqhiTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770206798; c=relaxed/simple;
	bh=QnV/TAO3PB8Ks7yar9W78MenuliEnRk+97gYLv4hR9U=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKfBMVo5OPBcruZoI4gplWlrGBRVX0838g92rcf5gmIUnFQE8Ku2kEpuWx4V3TeozkVJ0cR60A3O84g8B2U4XsM7ba7yD77AwsalWK0F4SpJOL2+1oCXlSnfEdlfDmM5yat0WiL7BH/UuGTC8cYfJr3vNS7HywwkuM5Pa4lox9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQL1E4+d; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQL1E4+d"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47ee76e8656so91210735e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Feb 2026 04:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770206796; x=1770811596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEJDHoe5qzdBp3+fKXnUn93mD9J2yFQM7Phlh1lPXME=;
        b=cQL1E4+dMc1/jWO3ppmcQjR25j1g+Omp+YqgPmlyAU4IBubsK9s4gh7Y8z+3qX2mfn
         w2pn6cDLq/7pXTTif3Pks49jPmEEx2D2cy6isla0cfFDo80heDQ9edXjqwCQSUSXWn1g
         wg8b7IZZ6iFuE43yPMf7nYOAd9h7J/d4z97CqEqsHMEtBlL/rJDnoI/q3sACv7Y7nydn
         4EKe2xOKQ5C57m6bPLA8q98GAvauz97uEd1e6rBJWOBF69fnTojtwSQZ34WbAnv1mzat
         YARseSXfOcAAVmDpudrSF8lgGHoWQ3/se/v6IfDyeyTrRSH1gce5lPEi6wY2g/s/wjv7
         iQ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770206796; x=1770811596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZEJDHoe5qzdBp3+fKXnUn93mD9J2yFQM7Phlh1lPXME=;
        b=L053gpMaAuirngyuN4PtrO+4DicXwUdROBiyruHYpoPt7Qsy5voqqfKblGqVwObOL7
         m+5x67xccSrWSsGT/I3JzI+WViUwTnXbF4QNd8jqvWjfpLl8F1QpqUndQJllGDP1vkcB
         6PLrzWpnEl5pENEq2fucWc5sbKAYDP05HIVh9dKaCZcV1eU08czH0zMtSgd6OwvfXsIo
         jWBgaix6KUlD2Af4uj7vYJ/jQ1+dW1VPxr3fBib3XZJnRV6VuZMG1A5YBsO2wD5iunQF
         k/bdJX4X7vnOjLDzjv0s0agIik1pWSVuRKKLz6xB3y4XHVLMQIxgf9oxdvJXL8M9nh+D
         W70Q==
X-Forwarded-Encrypted: i=1; AJvYcCWKGhZgchnp164OXE1DqfStiTi8LZpW0OgPqKMF27wX25ApxJ/apjS2ueMzBCSgG9ykoZtuaqzYcnqlGpWsLRwX4/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAnvdAI+fVp/TzfPXNmo6x6Ils71GhkHKY7iunA8cOVWv7J0OE
	Sf/oYc0S/wmvO0dFbrz07MbtsCsUvag5QS1dGhuX71RmQ0Kuf2wPQoxC56ozX4wl
X-Gm-Gg: AZuq6aKok37NffFqX4pHd/8tmXyPiCU3i4MqjSZY4pKMT9c5jP3Ruj0gZFk4bY/3EQt
	CRofOLjAjiBN5uP1S3cXP+iTLkqcKhVHgY663A0HdLrF0gXdN8nmFmkreeKLdZNBGXpd3X+Xbgd
	75wpQiSWSTQBl+xOo2Pfb8ru8EYkYI4YRkIK64rw5PFhp+XKBjktENrfzVRhzG+bJ5vuGUU5JL9
	CzOUODTkvIVZ3pn/QK8jbIacv+x70fpc3xsH0fmmimxqTaBxg0zX+3na88HzPxmpiji3Rmb17Bl
	Z2yWVQz3dhQyvJMUuDt4e1imJyH16naL1880BoPDX/Yp4426+qofdY2y73AXY+0Hw1pSrCImwyj
	yUAPHh2/sUygt/TMeeR3jFWhSjOIhsYDKnzBQQ6v5ovcGnShspvAdr3pF7SXm
X-Received: by 2002:a05:600c:a00b:b0:477:7975:30ea with SMTP id 5b1f17b1804b1-4830e971be8mr29415615e9.29.1770206796194;
        Wed, 04 Feb 2026 04:06:36 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483108d7b1fsm56256845e9.2.2026.02.04.04.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 04:06:35 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 4 Feb 2026 13:06:33 +0100
To: Steven Rostedt <rostedt@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>
Subject: Re: [RFC bpf-next 01/12] ftrace: Add ftrace_hash_count function
Message-ID: <aYM2SdcuODyygPwv@krava>
References: <20260203093819.2105105-1-jolsa@kernel.org>
 <20260203093819.2105105-2-jolsa@kernel.org>
 <20260203104032.582709b7@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203104032.582709b7@gandalf.local.home>

On Tue, Feb 03, 2026 at 10:40:32AM -0500, Steven Rostedt wrote:
> On Tue,  3 Feb 2026 10:38:08 +0100
> Jiri Olsa <jolsa@kernel.org> wrote:
> 
> > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > index 705db0a6d995..6dade0eaee46 100644
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> > @@ -413,6 +413,7 @@ struct ftrace_hash *alloc_ftrace_hash(int size_bits);
> >  void free_ftrace_hash(struct ftrace_hash *hash);
> >  struct ftrace_func_entry *add_ftrace_hash_entry_direct(struct ftrace_hash *hash,
> >  						       unsigned long ip, unsigned long direct);
> > +unsigned long ftrace_hash_count(struct ftrace_hash *hash);
> >  
> >  /* The hash used to know what functions callbacks trace */
> >  struct ftrace_ops_hash {
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index b12dbd93ae1c..be9e0ac1fd95 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -6284,7 +6284,7 @@ int modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
> >  }
> >  EXPORT_SYMBOL_GPL(modify_ftrace_direct);
> >  
> > -static unsigned long hash_count(struct ftrace_hash *hash)
> > +unsigned long ftrace_hash_count(struct ftrace_hash *hash)
> >  {
> >  	return hash ? hash->count : 0;
> >  }
> 
> I think this may make it less likely to inline this function, so let's just
> add an external function, and even add a "inline" to the original:
> 
> static inline unsigned long hash_count(struct ftrace_hash *hash)
> {
> 	return hash ? hash->count : 0;
> }
> 
> unsigned long ftrace_hash_count(struct ftrace_hash *hash)
> {
> 	return hash_count(hash);
> }
> 
> And don't modify anything else.

ok, will change

thanks,
jirka
