Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82A11547CC
	for <linux-trace-kernel@vger.kernel.org>; Sun, 12 Oct 2025 01:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760233803; cv=none; b=Dzq0PX/BERwRVbtDMSgVR972+uwydHcceq7xJ/qSb8yZBvBAmEB9WGNBLzA0s1lek+nQ6q6WcyUbsK08o1V5Csob1WeHrjn7CH8nmUMKBLFFbF1v6nJoq5Tfexy/lwJ82JIjKzplYef5fdh0EC7Us636I2LZj2G0WTKcBkusKRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760233803; c=relaxed/simple;
	bh=GwEwPqxRUTg7MFQelyNf4d+Vw8oD9w/6xNdsusLFnAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5XY0GBYvDRNPVvIbno0KrbfvDDjchxo1gDhbQD3nvVALOX9LCckyGDkeEisKyrAPaSQYf0jkiblERZt9mdhAL6httI1YTbyQBezM8dORQ/Qr/t2dRUZW4jwfMopJCdQDHDpjTP3aPsEABN4K+kJ7virO+DlSSVR3nX8FLJ12lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ef3GKUQJ; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ef3GKUQJ"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-795773ac2a2so35126716d6.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 11 Oct 2025 18:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760233799; x=1760838599; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pXc8uJoaf03/WrAtzQqCEQN2vdeh87i/2lbcZm6q1bg=;
        b=Ef3GKUQJp2HQKhHd62GInU5p2GvxWiMemGJPMjxYprfBqqtYPT3bV26rF7WFWFzTFe
         4EjLC6V5PrDiXaOaQQA6y9TNORlhuNI1T1nEsFzrXViv0pKHHfJdWvEscVi+Jz6ex+uE
         fz9PrWE7VX42SgjYP9LhX3mQmweUDMVC0qY1cwLEo/Hg0UnZ61IM94jnHrHHwNLQmB8m
         Ht49cJZjdttFvZGedefV2bAVqilphEq4k88FqNN6brJokn6UHo+fL6Xh8JhY3M0CC8Hk
         EKfRQfR6wnFQIoOx4EqLNZkhqPZM2rIFd20p64OxoBF04oTQDqwAnWKBHhFTwwZWoq+p
         69CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760233800; x=1760838600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pXc8uJoaf03/WrAtzQqCEQN2vdeh87i/2lbcZm6q1bg=;
        b=M2vQYNTxxzLuYSg/zDCfKC7vGPun23HEm7HVxUhoM6YgYO0dMHgxaZBFedyRc4ryt0
         b/FbcTsb6QNXlUMOd2cGYcQMb/kFZLffc9ki5LjUzIQ76Ez3Dw52dKVl7LHY6V/z+hma
         dlfq1wKp9EOUWIqXP4Dyws+hs9nD2oRh9TtO3DuD0ZNgGCnOTxeW4lClqur7nSjWsh9Z
         OgJ+D9FZnqctU5WMifIg1/2rWNtKJNNQMl2dxT6wJAGHP69EqVYa6Ev+UVDxHuuEwyzp
         s+Sp42atgp82JctIIC0OxGW4V8/vkNcHDeP2hTL6bxf1REnD+dtopT3Ir/TYWiiHHoEh
         FJ2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXV9n+DDnspyL2rC6f89bP4ZW3TePRuMg0VYqkO6M1DR/UcLfgx+jMM99IPQdoItWep2ssaJy8AEmC5g/JVVrR2pRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcITaf9WGNdVPeUHzMxoM72YV9GiY+NZqI7kbWzb4c2+7V34TY
	6uxXUx8SNs9rPPpUn2OLa8LZ5rPR16iNJfUpxSCZ0ljXJ40mfKUIrSMD
X-Gm-Gg: ASbGnctKOgpDKLUT9cB0CN1yRpQNf0XDptuED7MA34/0UCQ9KmqfLkVPwsLTvEfA11o
	xadt9YjXM0MxiRlSDsNXbCoRyTFMEtm28GCUp9oGnnL3W+kKqgELJ3sLOWYrn4MMdZyhVjZbpq5
	2BQY7V9TyRXnJyxo/URBdxKKhD2Sp9GvrDzkQECmCNLhaRlHWtZtZeku5h/uAdGsLiFrDQLs7NL
	vmmG1AZDjlryMH1ptn+fDljwoZoa9caY1lhR4o30qQ8OXfsZlycpbjSw0xYmB1mQ4CcE6MYjBR0
	ugRKy5uXTMrESi8aGhxxDwJKZEH3bPjgUxa3ZzJ140Yg1e5AIVQDLfQPd3WtrNxw0fKzvNmLnBY
	TTtOzPALa7dxKLSNB/G5uFWJ+ZpYTGAAyYynDCJyQO1WbvPfKhRWFN092hgYI
X-Google-Smtp-Source: AGHT+IE9eDjN8qiC2CBml63k30/pJPBpkqgYgHXrbEQP5D/Xfz4Ph8hYr31jfcSgiLzmPEPGXHXV9w==
X-Received: by 2002:a05:622a:1828:b0:4e5:6f10:5aec with SMTP id d75a77b69052e-4e6ead5afcfmr225132761cf.63.1760233799442;
        Sat, 11 Oct 2025 18:49:59 -0700 (PDT)
Received: from gmail.com ([2600:4041:4491:2000:4a9:9d37:4046:41e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e706d5f704sm49290051cf.26.2025.10.11.18.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 18:49:58 -0700 (PDT)
Date: Sun, 12 Oct 2025 10:49:55 +0900
From: Ryan Chung <seokwoo.chung130@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>, g@gmail.com
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com, shuah@kernel.org,
	hca@linux.ibm.com, corbet@lwn.net,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 0/5] tracing: fprobe: list-style filters,
Message-ID: <aOsJQ3gMcg5oKy94@gmail.com>
References: <20251004235001.133111-1-seokwoo.chung130@gmail.com>
 <20251008095111.5732b065dcebe53fc80063c5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008095111.5732b065dcebe53fc80063c5@kernel.org>

Hi. Thanks for the review.

On Wed, Oct 08, 2025 at 09:51:11AM +0900, Masami Hiramatsu wrote:
> Hi Ryan,
> 
> Thanks for update!
> 
> On Sun,  5 Oct 2025 08:46:54 +0900
> Ryan Chung <seokwoo.chung130@gmail.com> wrote:
> 
> > This series aims to extend fprobe with list-style filters and a clear
> > entry/exist qualifier. Users can now specify a comma-separated symbol
> > list with ! exclusions, and use a spec-level suffix to select probe
> > type:
> > 
> > - funcA*, !funcAB, funcC -> entry probes
> > - funcA*, !funcAB, funcC:entry -> explicit entry
> > - funcA*, !funcAB, funcC:exit -> return/exit across the whole list
> 
> 
> Just a note, it should not accept spaces in the list. The space
> is the highest level delimiter. I hope actual implementation
> does not accept spaces. So something like:
> 
>  "funcA*,!funcAB,funcC"
>  "funcA*,!funcAB,funcC:entry"
>  "funcA*,!funcAB,funcC:exit"
> 
> 
I see. I will adjust the code so that the parser reject any whitespace.

> > 
> > For compatibility, %return remains supported for single, literal
> > symbols. When a list or wildcard is used, an explicit [GROUP/EVENT is
> > required and autogeneration is disabled. Autogen names are kept for
> > single-symbol specs, with wildcard sanitization. For list/wildcard forms
> > we set ctx->funcname = NULL so BTF lookups are not attempted.
> 
> OK. So "funcA*%return" and "funcA,funcB%return" will fail.
> 

Yes. %return is only accepted for a single literal symbol.

> > 
> > The series moves parsing to the parse path, documents the new syntax,
> > and adds selftests that accept valid list cases and reject empty tokens,
> > stray commas, and %return mixed with lists or wildcards. Selftests also
> > verify enable/disable flow and that entry+exit on the same set do not
> > double-count attached functions.
> 
> Thanks for adding selftests and document, that is important to maintain
> features.
> 
> > 
> > Help wanted: This is my first time contributing ftrace selftests. I
> > would appreciate comments and recommendations on test structure and
> > coverage.
> 
> OK, let me review it.
> 
> Thanks,
> 

Thank you.

> 
> > 
> > Basic coverage is included, but this likely needs broader testing across
> > architectures. Feedback and additional test ideas are welcome.
> > 
> > Changes since v2:
> > - Introduce spec-level: :entry/:exit; reject %return with
> >   lists/wildcards
> > - Require explict [GROUP/]EVENT for list/wildcard; keep autogen only for
> >   single literal.
> > - Sanitize autogen names for single-symbol wildcards
> > - Set ctx->funcname = NULL for list/wildcard to bypass BTF
> > - Move list parsing out of __register_trace_fprobe() and into the parse
> >   path
> > - Update docs and tracefs README and add dynevent selftests for
> >   accept/reject and enable/disable flow
> > 
> > Link: https://lore.kernel.org/lkml/20250904103219.f4937968362bfff1ecd3f004@kernel.org/
> > 
> > Ryan Chung (5):
> >   docs: tracing: fprobe: document list filters and :entry/:exit
> >   tracing: fprobe: require explicit [GROUP/]EVENT for list/wildcard
> >   tracing: fprobe: support comma-separated symbols and :entry/:exit
> >   selftests/ftrace: dynevent: add reject cases for list/:entry/:exit
> >   selftests/ftrace: dynevent: add reject cases
> > 
> >  Documentation/trace/fprobetrace.rst           |  27 +-
> >  kernel/trace/trace.c                          |   3 +-
> >  kernel/trace/trace_fprobe.c                   | 247 ++++++++++++++----
> >  .../test.d/dynevent/add_remove_fprobe.tc      | 121 +++++++++
> >  .../test.d/dynevent/fprobe_syntax_errors.tc   |  13 +
> >  5 files changed, 349 insertions(+), 62 deletions(-)
> > 
> > -- 
> > 2.43.0
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

Best regards,
Ryan Chung
