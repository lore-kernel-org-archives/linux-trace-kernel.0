Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0E53B7B65
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Apr 2026 21:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775077731; cv=none; b=FelT76tWMv1sSFle0SiRslGmWdwk6jUScA+wRav77HcrDTI22+987FHyiDpq7xoUznokO8kfjhSxmIzWtBv8u2O+r3kMHuQ7PP1qlNc1D3bojmI3cv4UNJ3kMw5VZ+ie0L0Sz70fcBAAOvbZQ0jXS9MaApBp1/r9f/xzEp7Fjlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775077731; c=relaxed/simple;
	bh=fFZ5oJN3U/GRwKQIjCw0R7tvz9vv711GIXcprwT8jvU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D6si+Tyg58vjEtfMU0RAU+9wNlGY0VSvie6TdwiXNuo0RNgkENVv4+R1THyqFKfcLUjhtUfJ60LnWsIeKrl4Xj1Ea8Lj/ZN0Om5F3RAiQHYnfu2YpOF4P+et8DaB4oZPXf0XPPCCSh+dE0ZUbBazj5qNfXlsCVSdiq0pysu4iOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L9y/tadT; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L9y/tadT"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b24a00d12cso1362075ad.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 01 Apr 2026 14:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775077728; x=1775682528; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pu8VN/18EKGWu9s98ZXH5MFFrHb1clMJomnWtLClx2s=;
        b=L9y/tadT2BeyBnSJgoriD89TDwQ/AHVYRdnl1v3MVcR+X6hMqSAn7bN+yUXuP/pL+Z
         9F1RimtwT6PK8osSYXqorfShGpDcMd6xRle5XheGspDphtrKvRQ1Q9+jMx3OMDdGaWr+
         6LKD7kem2L00e/jlZ2t8mQ1T6Fe/dl206VjUoomT9JuLvs2nMb+8d4R/gHNY4XBS2btS
         Ydb39RwbXnMyJ1upmgv7+uwqaZG7xYuszyojvCAPzW7n+Dj7RBQHUqeQdI8PrN3ODIx1
         HVccAIUaRTEdSs4y4cQ0zqDSM1jH0JIS49wlysqFDx6z3XwBEJdPitfC3oauDCG+m03o
         xmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775077728; x=1775682528;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pu8VN/18EKGWu9s98ZXH5MFFrHb1clMJomnWtLClx2s=;
        b=ivSH/5ddouPckIiueEx9tS6wFnKAabvUwvnlWU3UPA55cUxuIq/q9DS/2I+auD8T8G
         gp3gGPoNks0FJGONaUdho0MBynZOd90BdBT6LPEgBEmSQpem0BQI+sqdSFdPNmCO6gNT
         1Vd3pmKBC7w7eUEe4b3fF0sfejpuqRr8Vbol5sjCWOZ2iFE9b6G4VmnU2Gy5qikZ/C3x
         FWtoa6kUmU8morLOXPGWm7qaPsswtPNv1ISaq1/HHhO61RepU7Hz0fDAb/NvbGe3y8SU
         NE5ePS5vKpbKE4nLNqq2HRWSorO33sUBcgvr23t74DGF3m2wqtjMKCsGLyqAdTCBzbup
         Le8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWieUG7iYxfy4Vm6OLJ6q3sJyoiflC6cNi9aIqZGci1uZqcFfgWvI46b4P6PTUNRDRaDOpbsoPJkkMeh0nGwSRENMA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcj1xTHzBZVMALHCygRfKKFMD42gx5dxIq5obGNMJeDr3bPOzG
	vU5QADiwrXz2MDmogZ5ZgT1SbgZecD0NsiPgOGsQYwswnRfjcZub4Dkrz1IznhaZce6w3SUyGaR
	WSeBYTw==
X-Received: from plbka15.prod.google.com ([2002:a17:903:334f:b0:2b0:46bd:4fe5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:248:b0:2b2:52fb:bf28
 with SMTP id d9443c01a7336-2b269d08defmr45254965ad.46.1775077728024; Wed, 01
 Apr 2026 14:08:48 -0700 (PDT)
Date: Wed, 1 Apr 2026 14:08:46 -0700
In-Reply-To: <CAEvNRgE6Tn81Yddgbjqs-gs491NzpppjbDHKzpmdPCxgSPeUPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
 <20260326-gmem-inplace-conversion-v4-25-e202fe950ffd@google.com> <CAEvNRgE6Tn81Yddgbjqs-gs491NzpppjbDHKzpmdPCxgSPeUPQ@mail.gmail.com>
Message-ID: <ac2JXrdcv8vb7x9y@google.com>
Subject: Re: [PATCH RFC v4 25/44] KVM: selftests: Test basic single-page
 conversion flow
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jroedel@suse.de, 
	jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org, 
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
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Mar 31, 2026, Ackerley Tng wrote:
> Ackerley Tng <ackerleytng@google.com> writes:

Please trim your replies (even more, since you did trim a little).

> > +static void run_guest_do_rmw(struct kvm_vcpu *vcpu, loff_t pgoff,
> > +			     char expected_val, char write_val)
> > +{
> > +	struct ucall uc;
> > +	int r;
> > +
> > +	guest_data.mem = (void *)GUEST_MEMFD_SHARING_TEST_GVA + pgoff * page_size;
> > +	guest_data.expected_val = expected_val;
> > +	guest_data.write_val = write_val;
> > +	sync_global_to_guest(vcpu->vm, guest_data);
> > +
> > +	do {
> > +		r = __vcpu_run(vcpu);
> > +	} while (r == -1 && errno == EINTR);
> > +
> > +	TEST_ASSERT_EQ(r, 0);
> 
> TEST_ASSERT_EQ() ends up calling exit() on failures, which skips
> FIXTURE_TEARDOWN().
> 
> Other than the explicit assertions not working with the
> kselftest_harness, kvm selftest library functions like vm_mem_add() also
> call TEST_ASSERT, which doesn't play nice with kselftest_harness.
> 
> Any suggestions for this? Should we use the kselftest framework with
> these tests?
> 
> (I ran into this issue while trying to test something else, where I
> needed FIXTURE_TEARDOWN() to clean up system state.)
> 
> Or is it "okay" in this case since FIXTURE_TEARDOWN() only cleans up
> stuff that would happen if the program exits anyway?

Can you see if any of the ideas in https://lore.kernel.org/all/ZjUwqEXPA5QVItyX@google.com
would help?  Converting more tests to TAP+FIXTURE is still on my wish list, I've
just never been able to carve out cycles to see it through.
