Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63A11C862D
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Apr 2026 00:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775608441; cv=none; b=DjN/2gRPoUn8ofdo2xM9S1bmWweVrsKk2gXirBLlOt59Qv3xpRlDnKh5mnfbWLDI0UBur4i1jc+5svGh9h+shSmUw6Y9Y7rCHsBzKX+njGk9mYMxkmCOLLOPKiukGy3NVtdTHiZQRPTwjpB2Y85Y964rCFnOIpk9epkKiGQx77w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775608441; c=relaxed/simple;
	bh=J8lObzK2Uu3gpSZOZmzqAZdfXNnRkzBYDt7uUjpmnZM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XhMKSWwvY2WZkrsN0xLAIjda9hNiLXIk8kITA7iZUfUMEPNmPVLRh8IZXffGn4g+yx8+eL8E78fSzRKpFXSSbVuhsal6/2Am/j9dQehg8NK20j02k/uiJbg5O9tBVYt/2xMfUIan/4Cv/zC6zkYwha2e4101grTDgxmMpU0RDZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cu84yI5u; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cu84yI5u"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82c70d1f65aso3227730b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 07 Apr 2026 17:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775608439; x=1776213239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aDLo9VPnGDiQNlFQzI1xTSPzRXpWtFJbtAFYR59HS10=;
        b=cu84yI5uGATzgiiPJMHlB2b0nhG2G745ru0KXCVeLcnRULppZ2atz/7LGlUVA1T6ge
         Xlz8DVcTJ5y1RcNb9A820K3AcKvpEoEpMr6pGTSvoPJv6s945P+GvNM6MWt7woSitMXp
         T8tCCYunhRtgjd/46Vx4uYK58GWIV2G23Mh2Bau9hZqX8eC6sSL7+2+5TVGhFLtb9/PV
         MdNvmlUUvIRZ8lHEmztn8tuURuQdJCRarztpoMq2KGvXcg4aPaSzgycxcE6CE4o2ZY3F
         FzSpn81daFM0nkUBc53ApcCjOE79XVBGcSzWJNegoU1LVQH+lfOWjLq+szrVicNjpxlx
         I//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775608439; x=1776213239;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aDLo9VPnGDiQNlFQzI1xTSPzRXpWtFJbtAFYR59HS10=;
        b=bx42OokoPk8i+QyV6uzNfDiDZuvCRoDlMbHjhNHkRXLKf2u/Az1TxNEcO4S40j2H+1
         +x+oC6cSVtAVihdBlWIqXbQLr/3xFrqrIkTy7r881DXibyTj0deR78bPdPT6a6ND/gJK
         lS4FAm9uacNjIvRvHnWM3uQ7ifmZi0X6br2FU+7B6Nij7bek+M06B12UfkEh68kTrYhd
         waSmcVlwk0riLh5dZFDFQwTxgR06+lLITWBpGj+DisV+v/uZkCrkoOb44x1OqWFYzSuW
         1+XK+jEQVRrI0ef37IvEgFvWb5fI3hb3XW0wGyoXW6KLwgj3CHq43UiBmbiZB9X0bdmR
         I+/w==
X-Forwarded-Encrypted: i=1; AJvYcCXq/yuRjc7dWdgg3p66dPJ66fOc2mDUeOXOqw/kFOFEYYEUowvkZ01p2LpLs8gLrlS4VSBX6iNhJSICfiVTaCnWnh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YykFep+AmB7mVXbkL/iIIWK1RE2cqTEuK8UM3kHxHnvn9ldTSUv
	kOxuhPyBKjuCZg8XcOLgDMOoeZ6hH5bejwIx4wcOHfxF0CEnV8Hq6Z94Jy48ez1dHySETW7nOyg
	a0O2l5Q==
X-Received: from pfbmt5.prod.google.com ([2002:a05:6a00:6e65:b0:82c:6e7c:ac61])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3011:b0:801:eee2:45b6
 with SMTP id d2e1a72fcca58-82d0dac592amr17920681b3a.24.1775608438815; Tue, 07
 Apr 2026 17:33:58 -0700 (PDT)
Date: Tue, 7 Apr 2026 17:33:57 -0700
In-Reply-To: <nmy5polcxfnn3hoircsiqarxmzlulwwq7w34okanccntp32v56@h2eac44agovv>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
 <20260326-gmem-inplace-conversion-v4-10-e202fe950ffd@google.com>
 <2r4mmfiuisw26qymahnbh2oxqkkrywqev477kc4rlkcyx7tels@c7ple7kdgpo3>
 <CAEvNRgFkusZeKxGctUpTTbYjdi7nZL1ZZar-gT7XRUOCZ2xtpw@mail.gmail.com>
 <CAEvNRgGm9icDK8sK5ZfqHEOEqSbvjwtihE4p9d3vpBq-NfVjmw@mail.gmail.com>
 <CAEvNRgEtigp7+PVDkyu_DH947CUqDt312d+P+hWjjd2fHONiag@mail.gmail.com>
 <yvfwexsub7nrogh67hzcsupbrkzer6a7kbeao5tlq4elrzc2iz@xrwdjd7p32pp>
 <CAGtprH-kgRByFvvCYeWMXtsvpb6qpaWAo8k-3PEnioyPg-LEvA@mail.gmail.com> <nmy5polcxfnn3hoircsiqarxmzlulwwq7w34okanccntp32v56@h2eac44agovv>
Message-ID: <adWidf8UgZeYctr1@google.com>
Subject: Re: [PATCH RFC v4 10/44] KVM: guest_memfd: Add support for KVM_SET_MEMORY_ATTRIBUTES2
From: Sean Christopherson <seanjc@google.com>
To: Michael Roth <michael.roth@amd.com>
Cc: Vishal Annapurve <vannapurve@google.com>, Ackerley Tng <ackerleytng@google.com>, aik@amd.com, 
	andrew.jones@linux.dev, binbin.wu@linux.intel.com, brauner@kernel.org, 
	chao.p.peng@linux.intel.com, david@kernel.org, ira.weiny@intel.com, 
	jmattson@google.com, jthoughton@google.com, oupton@kernel.org, 
	pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, shivankg@amd.com, steven.price@arm.com, tabba@google.com, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
	forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
	aneesh.kumar@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 07, 2026, Michael Roth wrote:
> On Tue, Apr 07, 2026 at 02:50:58PM -0700, Vishal Annapurve wrote:
> > On Tue, Apr 7, 2026 at 2:09=E2=80=AFPM Michael Roth <michael.roth@amd.c=
om> wrote:
> > >
> > > > TLDR:
> > > >
> > > > + Think of populate ioctls not as KVM touching memory, but platform
> > > >   handling population.
> > > > + KVM code (kvm_gmem_populate) still doesn't touch memory contents
> > > > + post_populate is platform-specific code that handles loading into
> > > >   private destination memory just to support legacy non-in-place
> > > >   conversion.
> > > > + Don't complicate populate ioctls by doing conversion just to supp=
ort
> > > >   legacy use-cases where platform-specific code has to do copying o=
n
> > > >   the host.
> > >
> > > That's a good point: these are only considerations in the context of
> > > actually copying from src->dst, but with in-place conversion the
> > > primary/more-performant approach will be for userspace to initial
> > > directly. I.e. if we enforced that, then gmem could right ascertain t=
hat
> > > it isn't even writing to private pages via these hooks and any
> > > manipulation of that memory is purely on the part of the trusted enti=
ty
> > > handling initial encryption/etc.
> > >
> > > I understand that we decided to keep the option of allowing separate
> > > src/dst even with in-place conversion, but it doesn't seem worthwhile=
 if
> > > that necessarily means we need to glue population+conversion together=
 in
> > > 1 clumsy interface that needs to handle partial return/error response=
s to
> > > userspace (or potentially get stuck forever in the conversion path).
> >=20
> > I think ARM needs userspace to specify separate source and destination
> > memory ranges for initial population as ARM doesn't support in-place
> > memory encryption. [1]
> >=20
> > [1] https://lore.kernel.org/kvm/20260318155413.793430-25-steven.price@a=
rm.com/
> >=20
> > >
> > > So I agree with Ackerley's proposal (which I guess is the same as wha=
t's
> > > in this series).
> > >
> > > However, 1 other alternative would be to do what was suggested on the
> > > call, but require userspace to subsequently handle the shared->privat=
e
> > > conversion. I think that would be workable too.
> >=20
> > IIUC, Converting memory ranges to private after it essentially is
> > treated as private by the KVM CC backend will expose the
> > implementation to the same risk of userspace being able to access
> > private memory and compromise host safety which guest_memfd was
> > invented to address.
>=20
> Doh, fair point. Doing conversion as part of the populate call would allo=
w
> us to use the filemap write-lock to avoid userspace being able to fault
> in private (as tracked by trusted entity) pages before they are
> transitioned to private (as tracked by KVM), so it's safer than having
> userspace drive it.
>=20
> But obviously I still think Ackerley's original proposal has more
> upsides than the alternatives mentioned so far.

I'm a bit lost.  What exactly is/was Ackerley's original proposal?  If the =
answer
is "convert pages from shared=3D>private when populating via in-place conve=
rsion",
then I agree, because AFAICT, that's the only sane option.
