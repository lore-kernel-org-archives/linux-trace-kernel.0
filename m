Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9299A1DF25C
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Apr 2026 00:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775608257; cv=none; b=BAOiR3a53wt6O84hq1bTXh06Akuv6P1qb4wQ3sdCdMx7hVwoE3DXKeiu4Z12ZkAzRmEGRs2+9Vj/HkuqcY5XOK8TRIJj0tC4Tvu18ztCVXnBAPMP4Xlc2gRuzwasM5OFK4JvDoye1Sr3jN7vkzjZyJp6K+yRDLJnvl0fnW+DbQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775608257; c=relaxed/simple;
	bh=G4jHI2eapDTczs0oy4UnD8MZCHy7EzO8BQVLhWUdebk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u1X1seZDTCPCflkJnTstFbxw79bH3KblXhswcSU8aRiEWm0g+Q6DyYRAo5A7kx8G55c7m3AnY9IlyKuxIC6hLkY1KB0EOggZc1syI7F2wn+5KfNVAvH+5nq77G8LwP7TY6DR6eoH3MihmPYMWkdzqIADIqgN+wMRaiJz/eIMOnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M+9UEBLT; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M+9UEBLT"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82cdf02bce5so3460321b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 07 Apr 2026 17:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775608256; x=1776213056; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yxNq84u8TlwsmIxTYoSXMB/rB8U2PkuGcR9W+hscQl8=;
        b=M+9UEBLTFlYEUKoqvJaLys8+SPGVPSVk57e221VjdN9CiA2//cxnI+jg9hTr4at1Ok
         mEUNRTBZZWjnVuPBE67h1M0ac5Mopzmfr/j7Q0Oyvx4FmmnXlaNVXu+LzyveqgAq+6YP
         leFErRzaJXezg9RxSMb1qH7+yelHVoJeCCYDNckPm3STyJ1+gYPLEv7PlD7wbdap9N54
         HqZnbusC1wc9KgHTk5635Lgqyb0cPNX5+XWnkO4gxLjGV0/nzWr4Cf7NWK+HyvvMg8Pk
         pPQ48AkvOGDFdyHJqbL7dA6rk8sL2zerzbd+kYd40/k3JLAw5kNDFD+JeQMLMW1Wmdpe
         TF8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775608256; x=1776213056;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yxNq84u8TlwsmIxTYoSXMB/rB8U2PkuGcR9W+hscQl8=;
        b=WjPt9hIY+rCIOHMHk55ssCw3YXrrnsuuWFFUj+Dcxae6GvwIaNroX5F6cxf8G+wn+i
         tQ/oVOQ52yX46V10puLEAd9NUMmItYU3oWshVLs+nOgO1HXhXBkDseRipY9zps86L0ij
         EzOWWJ/MhPwJU3D6lRLWruFcXOoJMn35/vWgW8PUQKmUANEGEIfmZGHJgITrv5KEjfcb
         Ek4GhUYMhYKFaTAj5hpHaJvOz0dhmEqkOSKFKMMzWdc5fRc91M58fPz31JIkOCC/Y8Be
         T9G1A5xbgeW++bnT4eDbBXDiv4ziCScoyRRedzRcPqYvM4Iq7wd2kLh+H1ytoaR4TtRC
         Ji0g==
X-Forwarded-Encrypted: i=1; AJvYcCV6ncM5ETxl41+Toy31uQZV+CXpmCSKPH0QgfXS2jbfzBKOpxqGM4Na0ttD02IrhLUZ2FG1BKF63VESHLqU6IhhUww=@vger.kernel.org
X-Gm-Message-State: AOJu0YwURv8OD6LkbW0yutvvDwssq6RIUHSwy2LAWFjfz5nRNMaokH5b
	QQNcS+F4K9sRvTtjeKsqPNkB8HBFznJqpF9aHqZBCfZJHPy7eQSyrKzKTdXRJhRipDEcVPWmksE
	f4Ym11w==
X-Received: from pfff14.prod.google.com ([2002:a05:6a00:bd0e:b0:829:7f86:623])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:348e:b0:827:28ba:ff00
 with SMTP id d2e1a72fcca58-82d0da68e4amr19209230b3a.18.1775608255720; Tue, 07
 Apr 2026 17:30:55 -0700 (PDT)
Date: Tue, 7 Apr 2026 17:30:54 -0700
In-Reply-To: <CAEvNRgEtigp7+PVDkyu_DH947CUqDt312d+P+hWjjd2fHONiag@mail.gmail.com>
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
 <CAEvNRgGm9icDK8sK5ZfqHEOEqSbvjwtihE4p9d3vpBq-NfVjmw@mail.gmail.com> <CAEvNRgEtigp7+PVDkyu_DH947CUqDt312d+P+hWjjd2fHONiag@mail.gmail.com>
Message-ID: <adWhvts20eePFo1p@google.com>
Subject: Re: [PATCH RFC v4 10/44] KVM: guest_memfd: Add support for KVM_SET_MEMORY_ATTRIBUTES2
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Michael Roth <michael.roth@amd.com>, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	david@kernel.org, ira.weiny@intel.com, jmattson@google.com, 
	jthoughton@google.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
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

On Fri, Apr 03, 2026, Ackerley Tng wrote:
> Currently, in TDX's populate flow, KVM doesn't do any copying, it only
> instructs TDX to do the copying.

I disagree with this statement.  For all intents and purposes, the TDX-Module is
firmware.  If Intel had elected to implement TDX via XuCode, and presented it to
software as ISA (see SGX), then under the hood "firmware" would still be doing the
actual copy, but KVM would be execute some form of "copy" instruction.

Saying "KVM doesn't do any copying" is (very loosely) analogous to saying that
KVM doesn't copy anything when it does REP MOVSQ.  It wasn't me your honor, Intel's
string engine did it!

I don't think it changes anything in practice, but I don't want to treat TDX
SEAMCALLs (or SNP PSP commands) as something completely different than what we
usually think of as "hardware".
