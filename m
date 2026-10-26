Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793054554;
	b=ztOO/T2BRMc4adM3OriiqG70jf3gqeoq7sR0Kxpl9dhvSLAY1RNKYlbBWRidMubY9PCP
	 t98bpWBBwVjgrqO4q47i0kzGC7wRtKWWnqRtzmtpc8bsYvwgdV1JrHPQeGnakE33xr+Ls
	 lqSDyF0OfRMo+vatB9GMv6i8z5Klet03Kv2ZSumFRU+jrxYwGjM6OmWCNgvxE2SgwhQFA
	 JSHE8DwPScGQRC5WkJjMGc77rcTUpUBq7H5V+NkfleGAt13X33wkewfUNewVUVQa49L8Y
	 rjsc8eiFSyYCHu17044u9Y+McViSb1wyRTBsEtKew8qEmF1HwAJlxc0JxJ6qKI6F27g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793054554;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=1g41ScjhVwvRbzMcxKIfOWek1hrUNmo67dv5vjZ2E34=;
	b=td15Qa1lRtumjN4jPg+MxSpj/D7YV7raItPhyNDooiw1+CUqz27NjmF33ATL54jzt3s4
	 kpdnm7ZUCNaaHN+BfAgBOFQJsTwOGiBHPJSlzS8vumo+N0kUtOszkxsXUF1r6LWvegbuJ
	 6OoyJeNlRyLh+vDIpuga83tRjLjmGl0roxlvCsTh3VGAggWoj2H0irztWiVYflwBfmW/T
	 KKlq+l3S4XFYyaeOo6o6EC489qb400e6JO2G37uWxjrvtc0SVbN7yIOHhNXG0UQAiqNvO
	 q97lgMYq1CnowRiuUOkL5Zk5HlNeNpuEIAeSblQQrql10RV6s/uEeIhfRi3Lxw6wkMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Ho8+h6Mf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FBF606A322
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 22:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53FBF606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Ho8+h6Mf
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c4395d31228so525983366b.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 15:42:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793054552; cv=none;
        d=google.com; s=arc-20260327;
        b=Fuyt+xOpSyd6gl6UxAATvRXmI4eKxZTYpnWsV+f8CbioYBvyXryP7KkDfL02SqgtNS
         nLoUoIQqQnolCM0dSbIb43eGYf8aB9AMOY7U0gzyLnO7w/OsvkDDIsNmyFN40NNXiBPZ
         5zRFBVyVMNHOW7dh9dJz0YI1KblWWfe8dZ9LqxHvlV12oaJzWZ2dvx14bB0tDmsC2lI1
         ZlYKjIVXc6prW7xmGAp487kCCna/IgWV0QkzcrlQ2bn3S0El2eFOyv506RXDyneYBiOY
         1prt0cBIlrzxdJd5jP3W+aIcR2B1CCUqU0dI74jwc6vXQPjGPByl069lTl5nDUoEZkSy
         T7ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1g41ScjhVwvRbzMcxKIfOWek1hrUNmo67dv5vjZ2E34=;
        fh=6GMCJT9JqWZazRyYAZc0Z/Fj6d3rq96PhRyso0E4RIc=;
        b=D9WHd1cpM0m3YuOyIKzdgGCOjSa/MkNtUfwW4S+tqsUALtTNHclpj4nBVh0ikZb6dH
         BEA2Rbgd0XWQMWp5HaXdVhiozXjzZBhTmsfT8XuUUcA+12FaTjGJC0ZkgRGz2zNV7YKb
         qvl8Bx4Sustz6tqMAwNqVYVsxk5xRm4RzUfUmgwNp4HZ2UhT/z3W/5ajhcOUW3e9EE4r
         RnsqPAWsf7MvGuYypxlScIRHT58jRgfn1VG6+6BZGRMDYG3914Py/jKdFWZReTX7lCes
         PrK6QfAyRWfEymfUgc6r3Pv2qrnGywkfW69U14sF9ugh2awU2ruSHpsQ7Pur+CkarOGI
         l4vA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793054552; x=1793659352; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1g41ScjhVwvRbzMcxKIfOWek1hrUNmo67dv5vjZ2E34=;
        b=Ho8+h6MfzfNYBnYXWcB1Csn7RkH5FDAzc185C3faxOFFVI5Ip8rPZvUVVS9a7mPz36
         24gi8R8N3yA+KvfwmaRReqCQoQsNezGiPP1Bp7GiihlQBrxNS9eCbaY93g0l7+W+vIC0
         voQ2Heu+uMnZMYR6TuMnUotBhMhKn8fZO7YhZJ/VGMtSyWbiopW5EZJQ5vT2/6dOt2QP
         h6y7P/JEcSU5qhjYmxEPNqjJ3oooD2zuidI/sWorRbLSpg0w4GfbG7VlXLnZBZNxscre
         60kjozBonZXdnmTiD0g6qsMUd7kqNlcLdjiG7bhzjYU1/2dfEHHIUzSVvBAgpzwQCCET
         IiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793054552; x=1793659352;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1g41ScjhVwvRbzMcxKIfOWek1hrUNmo67dv5vjZ2E34=;
        b=qPO4Sy28No0mtmdCufomyD2zc83Jip/VOTGluQonnPMnILFEUk43iKNjJqK7n8Po9m
         rcy3TSD46Demhm3JaS/6AplDWO/+M3rCaC84FKbQP97PuhnkbOaabGd/YojbpTmRPocy
         m4yZgawFUBhhSc3s0U067uLcYcvIANAYB2TgKQh8yc4rXIr2c5cTTwU+XnwRtwcYN3AG
         xbCA5NZtVBo+Rvzjd7yBA82VCCVe3mVXeSPBBXaCMik9va7D0oKFo/D27+1XjwT5QuLJ
         3XGX2M7DVBVLb92I9Y5INxXr0daMKuf3UkhbsBdlsJhKWbzbFL6l3EI6pL90eCPUrKPf
         8zjQ==
X-Forwarded-Encrypted: i=1; AKwUvBxAPFaRBkIhLbiNJ3+wgercl6lzhTk40i6KOqiAgX9LOa95OhPATt9wtAbImomdndyLZV4ULAxp8toJx/44BOUh5Sg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLiYSfgFyFooCNb6hrxZioVyZ+1kiUfCFx54xMUtICQ57m2SpHU
	RAcEibxJbNdu5Kpbv7a3+QYEZ5lx3yyIaESF8l82WbjPgO89CkIWr3VxQ3PT+ZNQC4r9oJqV3At
	kLkbnVtfMNsPC+HpeRcXhgWtwl1agx+7G8NBwEOlL
X-Gm-Gg: AYBFou1H9DpfDrQmtBuuRPg564dQLc5bfksHBC1H7Kjlust7faIriJoTCAWjDWgR5Fp
	wlTe/LUmCb3l518w20NOWLYb/jwo7Daz5OhLOkWw3jkcObtF9HHWUm2Oosi2gngD/fdg0BuQKvf
	C2wncGLllOC9qb+gPdq6vtvmTopsIx3pUo+9+4hERA+CiLTh5jmhAXNmm1OQYB7MCNfA0AceC7p
	tndZG7aZZIxs6enAisE5BdeeemBTH2BdFvpW5m9h/Ul3k0u3s/V+m79U7Fu2SudZ3wmhNOM26I7
	pQKtxUVg/YFjXbDm2HOsgC2dZp8YpNIyb0uaVl8gp95vAPdalMwDIZXrsx4PFjxSHzLiP+iYT+8
	oX7ZHTF2YHtJ+0Fg4Q0n4A65qhF3Se0RFlRn/3sz1D7IlWFwsZ+L+DERJ/KGbZaVF3V7gVpzsK0
	tNKowKgr0f0aWhvLnvLfoHpxubO/yedvfTl4DdwW0U6OqpfAMYMB3fTorVl32sbtqFUEjiA4o2C
	otdRWPU
X-Received: by 2002:a17:906:4fcb:b0:c46:8733:642b with SMTP id
 a640c23a62f3a-c46bdeba20dmr991156866b.43.1793054551213; Mon, 26 Oct 2026
 15:42:31 -0700 (PDT)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026215226.3713941-9-jthoughton@google.com> <da7bb91d95914febc9b2b981c0b8292022d6f6437ecb68ed2b717f0f4a3a04c2@mail.kernel.org>
In-Reply-To: <da7bb91d95914febc9b2b981c0b8292022d6f6437ecb68ed2b717f0f4a3a04c2@mail.kernel.org>
From: James Houghton <jthoughton@google.com>
Date: Mon, 26 Oct 2026 15:41:52 -0700
X-Gm-Features: AclHuK9NQf_DmtP280VFWB18VLK39ZMzdxZm9Qsh_-4Snm7U1eOCkiznChHcSHY
Message-ID: <CADrL8HXA3KVX9agtcExpPuaBLC-zAEWx6QgsRnQ6+cb4AZZrFQ@mail.gmail.com>
Subject: Re: [RFC PATCH 08/10] uaccess: Refuse and warn on __copy_from_user_inatomic()
 without an mm
To: bot+bpf-ci@kernel.org
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, tglx@kernel.org, 
	peterz@infradead.org, kees@kernel.org, arnd@arndb.de, david@kernel.org, 
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, seanjc@google.com, pbonzini@redhat.com, 
	jmattson@google.com, axboe@kernel.dk, asml.silence@gmail.com, 
	James.Bottomley@hansenpartnership.com, mkp@kernel.org, dsterba@suse.com, 
	mason@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, jpoimboe@kernel.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-btrfs@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, andrii@kernel.org, martin.lau@kernel.org, 
	eddyz87@gmail.com, yonghong.song@linux.dev, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 3:30=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > uaccess: Refuse and warn on __copy_from_user_inatomic() without an mm
>
> TL;DR: Commit message only: it names kvm_read_guest_atomic(), which no lo=
nger
> exists in this tree; the review suggests kvm_vcpu_read_guest_atomic() ins=
tead.
>
> >     uaccess: Refuse and warn on __copy_from_user_inatomic() without an =
mm
> >
> >     __copy_from_user_inatomic() never called should_fail_usercopy(), so=
 the
> >     NULL current->mm check added to uaccess_should_fail() does not cove=
r it.
> >     It is used e.g. by KVM's kvm_read_guest_atomic(), by several
> >     architectures' perf callchain and stack trace code, and by the gene=
ric
> >     copy_from_user_inatomic_nontemporal().
> >
> >     Split the NULL mm check out of uaccess_should_fail() into
> >     uaccess_without_mm(), and use it in __copy_from_user_inatomic() to =
warn
> >     and refuse the copy.
> >
> >     Don't use uaccess_should_fail() there, as that would also start inj=
ecting
> >     failures into __copy_from_user_inatomic(), which some callers don't
> >     expect to fail in practice, e.g. __wp_page_copy_user() warns if the=
 copy
> >     fails twice.
> >
> >     copy_from_user_nofault() already fails quietly when current->mm is =
NULL,
> >     and the generic user stack unwinding entry points (perf_callchain()=
,
> >     get_perf_callchain() and stack_trace_save_user()) only unwind the u=
ser
> >     stack of a user task with an mm, so neither is affected.
> >
> >     Signed-off-by: James Houghton <jthoughton@google.com>
>
> The changelog names kvm_read_guest_atomic() as a user of
> __copy_from_user_inatomic(), but that function no longer exists in this t=
ree.
> It was removed by commit ef82eddc0e31 ("KVM: Remove kvm_read_guest_atomic=
()").
>
> The KVM user is now kvm_vcpu_read_guest_atomic() in virt/kvm/kvm_main.c,
> which calls the static __kvm_read_guest_atomic():
>
>     static int __kvm_read_guest_atomic(struct kvm_memory_slot *slot, gfn_=
t gfn,
>                                        void *data, int offset, unsigned l=
ong len)
>     {
>         ...
>         pagefault_disable();
>         r =3D __copy_from_user_inatomic(data, (void __user *)addr + offse=
t, len);
>         pagefault_enable();
>
> A grep for kvm_read_guest_atomic only finds __kvm_read_guest_atomic() and
> kvm_vcpu_read_guest_atomic().
>
> Could the changelog say kvm_vcpu_read_guest_atomic() instead?

Yes, that is correct. I've applied this fix in v2.
