Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5D53ACF15
	for <linux-trace-kernel@vger.kernel.org>; Fri,  5 Jun 2026 18:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780684081; cv=none; b=BlV2PMVBG+Qp72ACWM7GxV0NUNq+szB3jQ3VIOu1JLkegdW4ypbsNYvWtO06Oq4AOS06lHj9d9JAMm4guBF2V4VbF7GTV4hv+XVPpL31ijFZZMruI3wu9bQ1W9rSGLeKfFG2lzMQo8UylnQH7ahapJjcGiF4TfJnF8jarQ9/cqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780684081; c=relaxed/simple;
	bh=5jiFPb4shRixueM3EXqj7rLUUpc6Mvk/umob9LPRscI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EMZaDsFihAL9ZJiyPW8mIjxIk7vP0n9VN4eZYD3a9yqZFWwqV0hPfbOZfp3Iec8gBu4mtrnMzI2/COHkhCAqIXkzKvsBanflAyxptjQjTPkU6YAksAjNNAJjvsvbIwJrtLBjM9buRxwiX7vdkZvZZoPe3aXII2EruIWOdI66+OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e9yEA4mQ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e9yEA4mQ"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36d979441eeso2088167a91.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 05 Jun 2026 11:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780684079; x=1781288879; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Al0zDa4bN146O1R+FtGZtDttdy90kv7zGQH5evIcYPw=;
        b=e9yEA4mQM2lut0pEuCRQy3Ps8v9Hyu0Fb1uWNJ62pgvmh5CYZnF9CaZYEwUMxEUlm/
         8Azxab4UduI99UbxJyBd7805CWQsOCFsv4JaKlvMH59Y7Cs+QkZlEjZQII2EuW/mBvl+
         E654i/X+2Q8W3amEZWXtyAubBNvVx1uFvWkQCXYiXnieAzgoTRL/MbVcCjEjU8sqx0P5
         dvgaDa9D8TJAz2YY5WhxLFnWOBWMsxpQKRR5Mfaz95Yk+/6Nl9qtY4/rb4EjxDdkIe8X
         OJUyzKpW/ERHauokVrwmOBbq1m25UU927PjuKGYU2fRqejCMwr3Y+8WzcAOOPP1bdT2x
         5WqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780684079; x=1781288879;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Al0zDa4bN146O1R+FtGZtDttdy90kv7zGQH5evIcYPw=;
        b=nymy4ti2aSE3fHls8VebuerWOmp3E33mTouStvKX6mOwPzB7azYrWNsWVDj2FOqutL
         Ae/9IphwOpERkW5JGVpSSWjbUv+0fwBDMPHNhqbZMEa+lSj2kxfYM45LDQ5g2vkDVFsP
         IHz/364emTeyXKb2MWZrr2TUce98WMFgBc6lnnM0hCgTetxz83ZYED1gTs1hemruIp3F
         lDG1ieUzXEe3A1biCoHTcNU3soYy1BaDOroUI+i7z4WiG7GExnTioDp/jrhGJsc1bsrH
         SFJrV6cEh7Yw7KmK8/ziPlpNF2FicrZb9XlH/gCJxYZmnpjlhWeGLYh71JaPGnOap4Pk
         8cCA==
X-Forwarded-Encrypted: i=1; AFNElJ+/hNuQf4im+rijgySzBtyovYM3t52qfNVq/DhGlrVgzzAjbz6qWS3asjJwAO0hENovq7QQeePBIrGOULilWcAM9nY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo+tqsGQcgTQdcTAcIk4RBkJePVd1kgwY+WVLtHcARDBmzOYls
	gXZpQCIwG8Nh2zekifNsMbTD2sbCCrhHugCUP+OzA554CboNbzz7kXPA5L1R/fMNYuGy55jmaOr
	LAazqIA==
X-Received: from pfwp41.prod.google.com ([2002:a05:6a00:26e9:b0:842:5fa6:3103])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5210:b0:36a:1ed8:6fe6
 with SMTP id 98e67ed59e1d1-370f0b58cefmr4684526a91.24.1780684078907; Fri, 05
 Jun 2026 11:27:58 -0700 (PDT)
Date: Fri, 5 Jun 2026 11:27:58 -0700
In-Reply-To: <CAEvNRgHz5GDjq0GqRmpQdHc-X45gCNr39VYWZH-T7XhPEtN5CQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522-gmem-inplace-conversion-v7-0-2f0fae496530@google.com>
 <CAEvNRgGpaggjd3=ooyzv7iEbmA-x1mWJHgjLSjPi8=5CPrk-yQ@mail.gmail.com>
 <aiHeDZEPkAcWcSkn@google.com> <CAEvNRgHz5GDjq0GqRmpQdHc-X45gCNr39VYWZH-T7XhPEtN5CQ@mail.gmail.com>
Message-ID: <aiMVLtblIKu1DQWJ@google.com>
Subject: Re: [PATCH v7 00/42] guest_memfd: In-place conversion support
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>, aik@amd.com, 
	andrew.jones@linux.dev, binbin.wu@linux.intel.com, brauner@kernel.org, 
	chao.p.peng@linux.intel.com, david@kernel.org, ira.weiny@intel.com, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 04, 2026, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> >> + KVM: selftests: Test conversion with elevated page refcount
> >>     + Askar pointed out that soon vmsplice may not pin pages. Should I
> >>       pin pages through CONFIG_GUP_TEST like in [2]? I prefer not to
> >>       take a dependency on CONFIG_GUP_TEST.
> >
> > I'm not exactly excited about taking a dependency on CONFIG_GUP_TEST either, but
> > it probably is the least awful choice.  E.g. KVM also pins pages is certain flows,
> > but we're _also_ actively working to remove the need to pin.
> >
> > Hmm, maybe IORING_REGISTER_PBUF_RING?  AFAICT, it's almost literally a "pin user
> > memory" syscall.
> >
> 
> Hmm that takes a dependency on io_uring, which isn't always compiled
> in. Between CONFIG_IO_URING and CONFIG_GUP_TEST, I'd rather
> CONFIG_GUP_TEST.

Or try both?  If it's not a ridiculous amount of work.
