Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311E137C90C
	for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Apr 2026 21:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775598673; cv=pass; b=XjF2nHhT1tzQ3SNC90BIyuyfN/HVvaWyS4L/TLqSoJc+j17MoCN23/jWjaAhGmQgLeOZRQKi8W0OVEDWegui+LIzRG+tj6kZaVcwuK3SMi5WviQ9Kl3jZLc6mL/NqprNz8sXcXamigpPYCBe/IQZG43Shnu7sZLukb7Nh+F4yzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775598673; c=relaxed/simple;
	bh=0jj/lwdErrCiTfj+2QvqNW2WVQwYN/lnIlZWQxS2RZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FFkWurr//4+1DzJ+b9w7wkvUajzcIPEX3Q9bIysrAkXu4+n2VT1ZDLGczEI43dve8bVZiSo3askdJw0IwUZ8Mqx3Hara5vhrEvS+6Mx4tGk0d5ezsguixi83CocSAFTUzkOXczPQWIPp7NiWIJAepDK0vXLQjEF4gN7oKUbAk1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GYZdt2s8; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GYZdt2s8"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50d6b393d60so102861cf.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 07 Apr 2026 14:51:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775598671; cv=none;
        d=google.com; s=arc-20240605;
        b=S7he5hdkpQ30NKht0xcpE9AUbmdySKi54qw3ksiqIx9yP9ETlqPAczrUSdBorwjwh7
         EaQNO21vzhkBruV+APxcqoJMZrJd/H1pKo3L4TQQBb9jQVjO4uDFGEqmo7ettkgQyr27
         pOKQSzfQOwscKdtNnX5XJnrN2RVaaAHXz3VAdcx+B0FAQ4HcN57oImV0OHuAMrbiutIy
         poswoqj6zLuhW5QuNpEtIBW9/WRvw6UsvBmZcxLC5ZsKSy6nvY1sxM7VmLytKFnLaA6b
         OP1jZF+sng44FlcSH4bHPerjZ7VoFWM9cOK1WmSElyYNHbbiJ6lr/aIiAGRIyvZwdOYy
         Kkmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Gaxd0JUvuI19hIXHFFbq0Nmmwdg7JnIiT63vLMwEkLk=;
        fh=7M3TfWd1h1QsxE2Sd8LPmgyBYGXLuEhRjePu4Np+jt0=;
        b=ehn4321dpmzpslUL0bROaWHjNfZNxMqbcTkeshr3CVlli5w1UbhTfIif3JaY4+CTQY
         jixhThDkwkRp4tmcyZGFSQQ0JtL7oKjQfZeVtImiBnPCoZxtcFaBgDxJVJ8Ll2hjiyfF
         FZ2D8MiszcBqROWYFw+ie3tZnQXRSqc4vHbbqGWqhrKXuO1SWHpe+ZyqwDqQR+6jbKJH
         4XnZAeCw8Yoj3xsuxxGVodAKFjdZPuUOVI3Y9rXC1hC3MMJxr0NG80Ix6MDUykqb0pcs
         AXbD4mBgwK/QI5wVCES7+rZTlDtqPlQLWoO9wUpBSNSP/10lTLKbMnior6zHmdr04Dzt
         J78w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775598671; x=1776203471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gaxd0JUvuI19hIXHFFbq0Nmmwdg7JnIiT63vLMwEkLk=;
        b=GYZdt2s89mWfsScrFlLBod5RkZHYiE1ZiaNR+q3fxhLZr/u6xO9Z1GyctsomOc2mKj
         zKkaCgYrv+hHEhSF63dwvqr0zYptOKzqQH1Cv45g5c50RXSYDOyKgRdc2mNrHshJEkkt
         lUDNSLMBTyj4F/pPFm7i0InhXz+kL4TPULfItNCz5Mu6d9MvE6m8jktST/Ctk0itK4k2
         vL9OLU1XPcaOb3O6MG4jtI7iNZMFPclvsOsko3TdZCDMUEjScwe9tHU6YKNOw62iD637
         10Q9TxMcb9j5RsHYWQMtlYFhf0lTZvrHnX8q3WpdoHdovvCZPq+guqqh1QVW3ghhHN/4
         xZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775598671; x=1776203471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gaxd0JUvuI19hIXHFFbq0Nmmwdg7JnIiT63vLMwEkLk=;
        b=Xt7JQ2ZJF8Y0yjNlzBFpH0NDj6vEXjmeAy9EUU/0s5JT+f5YqC9WqjrPnE9Uxxg2Bn
         uDquF7KN0W1jZb7RMaU0ug8bTYyEdqNolMbGoV8PKhC5afDG5mRppe6ksFJSc9ki5Azt
         /eUz9E54dt7uXM7jvvS0YdQEBdq1VB279yrs9imDpZhTHcUyQB6rlKmMKtBOYJnWwPhD
         8pKZyheHSJbWQb6/C0gNtNZvC7UUsiA44mJtixKUEPZxeBXfOmPYOgYHbygmTrGBm2Ji
         uuDKgRfaK8Sq9DugrEQzTyuHkZJkugbU66+YuQteHHxXicuU0L7tO/h4dh1kDsXSiWu6
         D9rw==
X-Forwarded-Encrypted: i=1; AJvYcCVY1JLAA3ut5oDHoHSrBDrCWGd6RgntReylfMQFDB6ini6mWkCSiLh7Yh8qy5FbHWy9GFCJkK0o0ExcDMWXROnByzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzupK4qLJGvHniPduPlrPOgsWapuSyd8yRQTjV3sU/SzoOwTEGT
	NpYtY783Ksk+uywQvGxJcFQXLMduUf/R0CzUC+BHCs1CJIddbhCukDJt9+NlWqsj6y7D3rpI1yV
	Sa4qWq1ZxoPf39ZyUC/KSOPMhsDGiOP8pFeCa6dgs
X-Gm-Gg: AeBDievCDYTG2suc3KiHK7iUerEArYUfnktIBcDadCm34K3LCNTQ35MPhAkrZZZ3O/7
	wxpOfKWxM9oJUCPu9NFuGaf2bgG3iDeixsfnISKVAOYil+6OUnicneEgX/xkXd08OkG4ZTE0PTY
	v7y0Pvq09/lX0uvJi9IYiO8DtVEDtUBLGBzo/0iCHpEAOGnTQjohfNCZt3udaSCLO5Wwbt6mDDf
	xbuuM8Ir9meFqGGDfXARzX0NYsu6NbJ4VhIcFqU6wRMKHX2R7kHzMgVrONTbvN8tfOM/jXvuzay
	Bk6zqZ2y4d7kI3MBd40ivNkhGXpviYNdZw1tiw==
X-Received: by 2002:a05:622a:cb:b0:509:1d4b:f86f with SMTP id
 d75a77b69052e-50db3e1cb76mr314121cf.14.1775598670174; Tue, 07 Apr 2026
 14:51:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
 <20260326-gmem-inplace-conversion-v4-10-e202fe950ffd@google.com>
 <2r4mmfiuisw26qymahnbh2oxqkkrywqev477kc4rlkcyx7tels@c7ple7kdgpo3>
 <CAEvNRgFkusZeKxGctUpTTbYjdi7nZL1ZZar-gT7XRUOCZ2xtpw@mail.gmail.com>
 <CAEvNRgGm9icDK8sK5ZfqHEOEqSbvjwtihE4p9d3vpBq-NfVjmw@mail.gmail.com>
 <CAEvNRgEtigp7+PVDkyu_DH947CUqDt312d+P+hWjjd2fHONiag@mail.gmail.com> <yvfwexsub7nrogh67hzcsupbrkzer6a7kbeao5tlq4elrzc2iz@xrwdjd7p32pp>
In-Reply-To: <yvfwexsub7nrogh67hzcsupbrkzer6a7kbeao5tlq4elrzc2iz@xrwdjd7p32pp>
From: Vishal Annapurve <vannapurve@google.com>
Date: Tue, 7 Apr 2026 14:50:58 -0700
X-Gm-Features: AQROBzC6YaFafHUDv2MGa2x0Vz0Tn9NeKXIPzVzTFxz7s_zDJ7AzU9trGlNgYrA
Message-ID: <CAGtprH-kgRByFvvCYeWMXtsvpb6qpaWAo8k-3PEnioyPg-LEvA@mail.gmail.com>
Subject: Re: [PATCH RFC v4 10/44] KVM: guest_memfd: Add support for KVM_SET_MEMORY_ATTRIBUTES2
To: Michael Roth <michael.roth@amd.com>
Cc: Ackerley Tng <ackerleytng@google.com>, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	david@kernel.org, ira.weiny@intel.com, jmattson@google.com, 
	jthoughton@google.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 2:09=E2=80=AFPM Michael Roth <michael.roth@amd.com> =
wrote:
>
> > TLDR:
> >
> > + Think of populate ioctls not as KVM touching memory, but platform
> >   handling population.
> > + KVM code (kvm_gmem_populate) still doesn't touch memory contents
> > + post_populate is platform-specific code that handles loading into
> >   private destination memory just to support legacy non-in-place
> >   conversion.
> > + Don't complicate populate ioctls by doing conversion just to support
> >   legacy use-cases where platform-specific code has to do copying on
> >   the host.
>
> That's a good point: these are only considerations in the context of
> actually copying from src->dst, but with in-place conversion the
> primary/more-performant approach will be for userspace to initial
> directly. I.e. if we enforced that, then gmem could right ascertain that
> it isn't even writing to private pages via these hooks and any
> manipulation of that memory is purely on the part of the trusted entity
> handling initial encryption/etc.
>
> I understand that we decided to keep the option of allowing separate
> src/dst even with in-place conversion, but it doesn't seem worthwhile if
> that necessarily means we need to glue population+conversion together in
> 1 clumsy interface that needs to handle partial return/error responses to
> userspace (or potentially get stuck forever in the conversion path).

I think ARM needs userspace to specify separate source and destination
memory ranges for initial population as ARM doesn't support in-place
memory encryption. [1]

[1] https://lore.kernel.org/kvm/20260318155413.793430-25-steven.price@arm.c=
om/

>
> So I agree with Ackerley's proposal (which I guess is the same as what's
> in this series).
>
> However, 1 other alternative would be to do what was suggested on the
> call, but require userspace to subsequently handle the shared->private
> conversion. I think that would be workable too.

IIUC, Converting memory ranges to private after it essentially is
treated as private by the KVM CC backend will expose the
implementation to the same risk of userspace being able to access
private memory and compromise host safety which guest_memfd was
invented to address.

>
> One other benefit to Ackerley's/current approach however is that it allow=
s
> us to potentially keep hugepages intact in the populate path, since
> prep'ing/encrypting everything while it's in a shared state means gmem wi=
ll
> split the hugepage and all the firmware/RMP/etc. data structures will onl=
y
> be able to handle individual 4K pages. I still suspect doing things like
> encoding the initial 2MB OVMF image as a single hugepage might yield
> enough benefit to explore this (at some point). So there's some niceness
> in knowing that Ackerley's approach would allow for that eventually and
> not require a complete rethink on these same topics.
>
> Thanks,
>
> Mike
>
> >
> > >>>
> > >>> [...snip...]
> > >>>
