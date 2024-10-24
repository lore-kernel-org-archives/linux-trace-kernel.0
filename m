Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C3B1D5AB2
	for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Oct 2024 16:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787299; cv=none; b=P5NuyWsZR3ak7p7EI6a9F9JmaZlZ/5VL7VBYqjO+F6W36IaXraxMfyU2s0aAH/2NILZt5ce7WBK1l+r3ayldSiLJ7N6spkFP6jL18ma2rC4ASHbOFpCGZyuV8PpuVZ8clfs6Nv32LuzeupqF6rwoCIsL0S/eN9Cknq8sIgfwDO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787299; c=relaxed/simple;
	bh=BAMyVf69I0HQ8TnNfDk6Bau81x3CTlj07KBYZ5ws5Tc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lFOLooCjTtiXe+12hvzzk0GWLy1gpISCejnjOOfKMzc+692LCTHB53Fv8dss0gTEBL5UgWxoLOVQxPIKTT5F2Dk4nN3+KGRgJelugiHY363wi+bHRKbhRn0fXUVH5zpBm/K47KDDoyoQriks6n7+W622U3tRkEeYjV9tOjp5gz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VqXhsCtn; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VqXhsCtn"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4315a8cff85so485e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Oct 2024 09:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729787296; x=1730392096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BAMyVf69I0HQ8TnNfDk6Bau81x3CTlj07KBYZ5ws5Tc=;
        b=VqXhsCtns+ufLmDPexYhJarMnrxej8oSEXMijBEdGNWB5jJnDjohC3Jb+4GoTg3Uxf
         PsFFFznWc/x/B+FkXDKaCPGu7SZqFve/jC5gRe9vjFDDzSUdq+bXwyDp/9IAZKD5YtjW
         nHR3Gz0/VwKGJK5ZdoeyepW/FPyfli4Epi973EQjURGDu9o7DpD7O99ggmy3LZuSVO8I
         0bVxpRft3EaFw6T5U4CZPuB5qzM3xzhLgMiWM/O5KGV8u+s8In5kvMV2q9YQvnRKCGoX
         musX8hLLTv4U7JgpJz0rcqkLzpywXOs9u6mmTnGXXqwfdiF+KGleUpuqyPgiqxtC4cXp
         oooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729787296; x=1730392096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BAMyVf69I0HQ8TnNfDk6Bau81x3CTlj07KBYZ5ws5Tc=;
        b=EidefIvZV+7oSP5jA2AhsR7Cjo+mLFRu93he4b66ke7Ebsh1zxPXTfT8RkVkPQNHzO
         A1+xaGRuVxEbqGFLExsO1OY/5QXYJsZDyN9m2/sMUbQlQ3HMtoWXNbhzk5wf+2n3tPCG
         82FzGiZLwEKPgl6bkKZjwSv2/1lJjhYtRofDbJ6e3FohP5yWGJJ+0PUF0e6LnpirqPgt
         wACCb0CW3zRlkUW1r55RDUSLqll4CugZ/mct0jLCTq01TqtJlgh1P7RLAhqwQ0xfFZPt
         bBXfhYa0x9n12xQ+SjEufe4/2cgWhDt2HWKYTsKsokbqGvWQu5EcL8smQqWDwCOwtGqG
         uvCA==
X-Forwarded-Encrypted: i=1; AJvYcCX4dC0dS5UcEK7jOz4+55CIi8SS85HrPSh9ctKT5GfNCSQLfESbSMx7qKmYRJpNROByU3gsjPqA2YmPxC5RQ4HgV8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwJZEWAMoN8J6gc4ko6yUb6mo5KTFOWK1527Tyw/dzKHTqJ7e9
	uW2jttyScsy1SxOg2CGzR01r4wW7uAuBSY2Snhr2MiS7aLGBk8+ncqF5hAjwRv+IizXYj+CqJ5R
	CJdi1wUbEQCvWYQlMo7PpDtvmGkCtKrlG3enkekP/7vZkT/2eF6Yw
X-Google-Smtp-Source: AGHT+IH6GaCTFse8PHhR99yRvdJU42XjOZhxxrVWX7RUwgX5aK9xyEy94yBYp/VrB+JAVrmpWoM6bBGXa7q1ktnK+/A=
X-Received: by 2002:a05:600c:b8d:b0:42b:a961:e51 with SMTP id
 5b1f17b1804b1-4318a4ace7bmr5573175e9.0.1729787295526; Thu, 24 Oct 2024
 09:28:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010205644.3831427-1-andrii@kernel.org> <20241010205644.3831427-2-andrii@kernel.org>
 <20241023201031.GF11151@noisy.programming.kicks-ass.net> <CAJuCfpFMhoCmqGJMU2uc4JHmk9zh88JzhZAeSz3DgvXEh+u+_g@mail.gmail.com>
 <20241024095659.GD9767@noisy.programming.kicks-ass.net>
In-Reply-To: <20241024095659.GD9767@noisy.programming.kicks-ass.net>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 24 Oct 2024 09:28:01 -0700
Message-ID: <CAJuCfpGxu=z-2Wsf41-m4MQ6t7DjfiiWXD408BW8SjTfx0NGTg@mail.gmail.com>
Subject: Re: [PATCH v3 tip/perf/core 1/4] mm: introduce mmap_lock_speculation_{start|end}
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, oleg@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, 
	paulmck@kernel.org, willy@infradead.org, akpm@linux-foundation.org, 
	mjguzik@gmail.com, brauner@kernel.org, jannh@google.com, mhocko@kernel.org, 
	vbabka@suse.cz, shakeel.butt@linux.dev, hannes@cmpxchg.org, 
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 2:57=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Wed, Oct 23, 2024 at 03:17:01PM -0700, Suren Baghdasaryan wrote:
>
> > > Or better yet, just use seqcount...
> >
> > Yeah, with these changes it does look a lot like seqcount now...
> > I can take another stab at rewriting this using seqcount_t but one
> > issue that Jann was concerned about is the counter being int vs long.
> > seqcount_t uses unsigned, so I'm not sure how to address that if I
> > were to use seqcount_t. Any suggestions how to address that before I
> > move forward with a rewrite?
>
> So if that issue is real, it is not specific to this case. Specifically
> preemptible seqcount will be similarly affected. So we should probably
> address that in the seqcount implementation.

Sounds good. Let me try rewriting this patch using seqcount_t and I'll
work with Jann on a separate patch to change seqcount_t.
Thanks for the feedback!

>
