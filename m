Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F372066DE
	for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Jul 2025 18:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752777366; cv=none; b=FJdKE35zs66E1TPRDe7dS+hO9oF+g3URqeMHPhFf23uoF5ULpPb1ie6U/TtcQa+bVbYnejyQfqWcrEmiH7S3I+LdFg7uu5L+LJblhaPg9iHmCeKszch8B3cSXJIbf0ehjHJYt+TE9Gc/T0/V4dGdXedd0gJ2UO9JWVsIMj/R2fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752777366; c=relaxed/simple;
	bh=nT1GppLNav7xgnl/ObI19ndyqjnUwbm8v4pO3iyByg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CIG+fUgfAW/BwuyNNUhSsxojy6ZPyhVBN87xZOJqoZ8YhuUjCBjgZCG6SU+Or/fPaTCOIR3yi2qH8q7i7l+r5uPAcVYw+ycqG/wuvpqNBK6xSnOyDDr7/gQdFVkzzA32a1HuL0j8G7y3LuAMuzrH/wKxKfoLqrjHFgYa5zVZ5E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QqG4lPDd; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QqG4lPDd"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae36e88a5daso234056666b.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Jul 2025 11:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752777362; x=1753382162; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aieKFP+WlFpL5D5yzi8pvP6vZRe7mbkNZOfzzhMJB0Y=;
        b=QqG4lPDdGI52mriQlxm8gkhkDgRBvkKYlwsLoDdItzckUU/QrCT+p1yMZgdVVF/4nv
         fs4CsRKSBFXm7GWA3TzoGboMvVvI6keB1x8xis0nuT7Fq084ybRfz4r8bmDFzVFj5zj2
         2DAzkRHb/IVHCcI2GExgraOVw2NzNEugQT1/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752777362; x=1753382162;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aieKFP+WlFpL5D5yzi8pvP6vZRe7mbkNZOfzzhMJB0Y=;
        b=b27LFnBZ5DNoBvQswpbATP8Elj5ibDzN6Y2D3gV1oc3Ti2HRIs30DhKYJ2B92Yfh5/
         lTasBHVJvkiE5oAfclvkBro0kn+Eu1fSCZKBwvnOphQYb+bzeonGmcG6w7X3WLQBZFm/
         riFi/LoUDBGkzoiM4XKYkhi0ZFhs/jDQqmUUVE0qM3QdZOL7nQazxIdf4j4tUa+XJGah
         /uv7knLdhdiZHiVNur3dpViqXeUUc6MGQgAJy/9IpBjUWYMnG7FbRjrB/nLStHUSVyQZ
         CDWBWpFjg3HjqSL2weZZfPCFac1m1c84YLeHg7cFaRJu9Q3R3kciXvBOdwhB5kWeKKTo
         OapA==
X-Forwarded-Encrypted: i=1; AJvYcCUNQN/9DTJ5SztXoy/xh8693I1iK9CQdryzEgvNoEpTo0GRltnwCZUw5lZk8thaLuXTLb3FoQj8RJegRVPrEfJSmlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL3OypWhifguMcdh7Yo3uSw/An+BCkMYzsbAA7nwR1IsvKV3v1
	6NPX4xrSoBzjUOtDu5a33qwg1rtFwYlLq2kukVjtp2KrXYVGTK/dyW9ETWRtjVSGYXJDegY3f/e
	+c+kS8Mc=
X-Gm-Gg: ASbGncsIHcc36x92JCHJSz3NzDTFwuAN1Le7rSD84lx+bAvmEvB/lhL5y6J2yaz4cDf
	0J19oXGZ80ldyl5Fwv+XzyT/xbebIBUcwAAMmJrIJVFaNV9urZ6m5P86I/1APTRYRfyRN724DqR
	DjvNhm3PTDFr9WrN63Gh351gN+wbaVBhxSQGWO/eBwTNR7oxmGKGf6DIJBlt2EyQ5rmjKecbv8O
	59CjjbeBS2lMVdcntOBK5vdrCabQUG9vS5muXUK3n0qB20m34JIxyx4zuzwESc0MjYe3iF1k4eg
	mSqedrmTy8a5+ZaGa6gkBSpP4Y31AjXlROJzGUYlY4qZVZwWwjCxz1jL5+7yyMX45AIXnzCqHlg
	fWaCZolpem8oKcZ1DU0Ug3osoLiLO3xuUVABvyQDt37VG0m2Fe5jIh0fw4LlybSQq5kwqsSzj
X-Google-Smtp-Source: AGHT+IHciodcFQVjmT698fnJzDpwi9S5kmw7TDFHddXHLMi5wlNqFhISSwvFbrnuAE7XCbJMEmcrcw==
X-Received: by 2002:a17:907:3fa7:b0:ad8:914b:7d15 with SMTP id a640c23a62f3a-ae9cdd85e21mr812666866b.7.1752777362097;
        Thu, 17 Jul 2025 11:36:02 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e829e6aesm1413874666b.145.2025.07.17.11.36.01
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 11:36:01 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6070293103cso1901592a12.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Jul 2025 11:36:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVamlaqEGKK+W1/gM/kELkeSCqDIGvGGNzcWq2MMAq8i1XURp4BoIUSiBy4n0Iy4XbLQGmlBcRIelCSdtuJegQ+Flk=@vger.kernel.org
X-Received: by 2002:a05:6402:34d6:b0:608:6754:ec67 with SMTP id
 4fb4d7f45d1cf-61285bf3730mr7487110a12.30.1752777361408; Thu, 17 Jul 2025
 11:36:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716123916.511889-1-bhupesh@igalia.com> <20250716123916.511889-4-bhupesh@igalia.com>
 <CAEf4BzaGRz6A1wzBa2ZyQWY_4AvUHvLgBF36iCxc9wJJ1ppH0g@mail.gmail.com>
 <c6a0b682-a1a5-f19c-acf5-5b08abf80a24@igalia.com> <CAEf4BzaJiCLH8nwWa5eM4D+n1nyCn3X-v0+W4-CwLg7hB2Wthg@mail.gmail.com>
In-Reply-To: <CAEf4BzaJiCLH8nwWa5eM4D+n1nyCn3X-v0+W4-CwLg7hB2Wthg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 17 Jul 2025 11:35:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=whCDEuSH7w=zQBpGkustvis26O=_6cEdjwCanz=ig8=4g@mail.gmail.com>
X-Gm-Features: Ac12FXw_kNIbTRokcm7T_S0XklVgvPSebW7F_Vtc8CMTkt7DzdcMPhb6rT3qzqo
Message-ID: <CAHk-=whCDEuSH7w=zQBpGkustvis26O=_6cEdjwCanz=ig8=4g@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] treewide: Switch from tsk->comm to tsk->comm_str
 which is 64 bytes long
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Bhupesh Sharma <bhsharma@igalia.com>, Bhupesh <bhupesh@igalia.com>, akpm@linux-foundation.org, 
	kernel-dev@igalia.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com, 
	laoar.shao@gmail.com, pmladek@suse.com, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com, 
	alexei.starovoitov@gmail.com, mirq-linux@rere.qmqm.pl, peterz@infradead.org, 
	willy@infradead.org, david@redhat.com, viro@zeniv.linux.org.uk, 
	keescook@chromium.org, ebiederm@xmission.com, brauner@kernel.org, 
	jack@suse.cz, mingo@redhat.com, juri.lelli@redhat.com, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, linux-trace-kernel@vger.kernel.org, 
	kees@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Jul 2025 at 13:47, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> But given how frequently task->comm is referenced (pretty much any
> profiler or tracer will capture this), it's just the widespread nature
> of accessing task->comm in BPF programs/scripts that will cause a lot
> of adaptation churn. And given the reason for renaming was to catch
> missing cases during refactoring, my ask was to do this renaming
> locally, validate all kernel code was modified, and then switch the
> field name back to "comm" (which you already did, so the remaining
> part would be just to rename comm_str back to comm).

Yes. Please.

Renaming the field is a great way to have the compiler scream loudly
of any missed cases, but keep it local (without committing it), and
rename it back after checking everything.

Then just talk about how every case has been checked in the commit message.

             Linus
