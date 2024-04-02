Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0135315E96
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Apr 2024 04:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712030857; cv=none; b=ZyfNooUlVjm/e0wjA1eRW/m6clkUhvrVxW2UPtB8loWAff55jD2L5Jh0NyIFe9pXEO2B/2aNkVE5hmmAFdwJiY8zhuQlGAv+/INZ0iZ6tOrIy1RaZB3klAWNozmFa8WjIRlVABvmMAFYXxq5RIWALKWu4iUsG2gUgawvLbuj4QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712030857; c=relaxed/simple;
	bh=S5pOtFaXWTZ9drUl1IGdeRTY03Dh2DX28whh4K9thQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aX6FhHmNayLLckWE1bdnJByDwXSlfty3tD/VaPvhe313qmZYFOfmERSgYhFdahvvKXy3OglKKiQTXXoBV0sd4b0NuDvpdp21h4nR6uwjGBIahnC5on1SU9nNKHhBZz9w0uOTr5D93SNFhtDsTpFFv1Hw5qExEbmvEpGZfQEIBg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zbTJ4iUs; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zbTJ4iUs"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4156ae9db55so97715e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 01 Apr 2024 21:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712030854; x=1712635654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZBWjXNV+ukFYBM6SnOc07suCYCDWH2HqRzY2rUjBLg=;
        b=zbTJ4iUsMslgn7kTVDeCmGYoEMExnO3fe49V/ZFe7gRydnyOUQciy2V8IjO9PQHiAo
         f7FSJsHfZAbClhaP4dZ8cubPGcVZ+PQi7xIzcRgyOiqK+Vm0QMrYWV/S0K0EguH+IBLo
         r0OwIs7l+2aM/XbqTzY3A8p+mpvzeMPspw2OgKSO0hFdi08LWtGJtiVlfNOYZuslTFjs
         mIXu0F/qIk5Jwr2ZODX+IXcSSMIYEr3otrvztyZwaegwp8dZq3BkSjhWnCE2kB1uaquS
         4mGYEWbJ9WU5bkPvG9UZWD01jjXrdCpgJjgOhf5mteWn2ti2JuRzzawTCdR8wBOUw/li
         KtPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712030854; x=1712635654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DZBWjXNV+ukFYBM6SnOc07suCYCDWH2HqRzY2rUjBLg=;
        b=fQ6mWnBWlJrftH3P4ilppWxR+c0tv7ms5wxwXCiRKN/F964lf2GYT2LWjeEM+bC8t3
         ze42bSLk6wwvWKJ9PoyGJt5iV5oGAw4hhjT1QJGcbE2LUuMl0FfBqMZVClioJh7L9zVL
         DuFBW4tdeMkcAkb1JkIzSV4b3m0gik+m2AlcJzlnjwQq4UjFvJpgko39cMu7wxEyZt+p
         +1V49yomvBXUbukVPYi1Sy2B9Ua5fRWY9JqxFcg2GEqddQbfycWAv08Nxqj16ewSKaqR
         vF2ouDb9T4EF3NtPoAEyEFJhtBekw3HJxjxiQg1crIlBJsrzXS+wGeHshemPKBD8l/8j
         rvhQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7GYL13jLerrk5p9ZXnFVu2K1bU+cGmUP4NG0qJYvXofyTS5k5FVz4fIfiGhrq/cFKhvlZ17uxECzSlk/ts/7k+kcF943ZHSYH58JhmJdYG4xm
X-Gm-Message-State: AOJu0YyjdiPsNc2PN2wHE566QpX7EVs5C9mwq0clottI0jEptUONgyxA
	1HcpFEmvjSI8NpttHw0cmUL+J+DuvJ5+zVxJhDTF0lv5hxGjh16Tm2vzIEcypQMwLP/NCmzhqPX
	lhHiQlDPH5a9E+8C1bsShiG4tVqXekIQQZKl8
X-Google-Smtp-Source: AGHT+IFySGf8Ru8vCkM5wQVTeOgNnN+X2acwQrfk019Ub2hqyb57NNeXzO4CL4BJZpMyCPNeydNs/OxpDN34ONprOII=
X-Received: by 2002:a05:600c:358d:b0:414:1ee:f375 with SMTP id
 p13-20020a05600c358d00b0041401eef375mr713615wmq.0.1712030854163; Mon, 01 Apr
 2024 21:07:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401232946.1837665-1-jthoughton@google.com> <20240401232946.1837665-7-jthoughton@google.com>
In-Reply-To: <20240401232946.1837665-7-jthoughton@google.com>
From: Yu Zhao <yuzhao@google.com>
Date: Tue, 2 Apr 2024 00:06:56 -0400
Message-ID: <CAOUHufaQ-g6L5roB-3K0GamuS3p9ACpPj9XM-NF67GgrjoTj_A@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] KVM: arm64: Participate in bitmap-based PTE aging
To: James Houghton <jthoughton@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	David Matlack <dmatlack@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Sean Christopherson <seanjc@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, James Morse <james.morse@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Shaoqin Huang <shahuang@redhat.com>, 
	Gavin Shan <gshan@redhat.com>, Ricardo Koller <ricarkol@google.com>, 
	Raghavendra Rao Ananta <rananta@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	David Rientjes <rientjes@google.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 7:30=E2=80=AFPM James Houghton <jthoughton@google.co=
m> wrote:
>
> Participate in bitmap-based aging while grabbing the KVM MMU lock for
> reading. Ideally we wouldn't need to grab this lock at all, but that
> would require a more intrustive and risky change.
                       ^^^^^^^^^^ intrusive
This sounds subjective -- I'd just present the challenges and let
reviewers make their own judgements.

> Also pass
> KVM_PGTABLE_WALK_SHARED, as this software walker is safe to run in
> parallel with other walkers.
>
> It is safe only to grab the KVM MMU lock for reading as the kvm_pgtable
> is destroyed while holding the lock for writing, and freeing of the page
> table pages is either done while holding the MMU lock for writing or
> after an RCU grace period.
>
> When mkold =3D=3D false, record the young pages in the passed-in bitmap.
>
> When mkold =3D=3D true, only age the pages that need aging according to t=
he
> passed-in bitmap.
>
> Suggested-by: Yu Zhao <yuzhao@google.com>

Thanks but I did not suggest this.

What I have in v2 is RCU based. I hope Oliver or someone else can help
make that work. Otherwise we can just drop this for now and revisit
later.

(I have no problems with this patch if the Arm folks think the
RCU-based version doesn't have a good ROI.)
