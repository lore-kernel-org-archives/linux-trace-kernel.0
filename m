Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0AB40FDB9
	for <linux-trace-kernel@vger.kernel.org>; Mon,  3 Aug 2026 15:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785769424; cv=none; b=KFQeBNRnAGhwBngqmV9Y3y8Nz6l/+eYEULvHhnWmWTTpk5UcMUonb0Tjaio6pEmqbjCbeQhfcy40lfwk4CqHPIZutxQHutJZj4C+GBHYYMZXSpDQD/R5Wl0vnXkzKTEg3upEpE141pxsEu4PGrI3v2mVh+/3t1++6DCHfs4UMcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785769424; c=relaxed/simple;
	bh=xpuun2FpwKl9xPy2b0ojl3YaE6k3z96AypSR1+LJ1mM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e5w3PursMrkp31KTM/Nks0VCX0VRG7ir7kklUDaAt9EtFGfpdqNoDixmtN0brbpAtUcOwOOdMk/tfWsQwiFKMhnSGeoyM4JRMihjVKq9uNHxDTlVtJDmTKyWMoFwXBc//QmuYAGDhepbaF9H6SSROOvdTgsQnHVCFhfPOp0tV6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NwgDxCAO; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NwgDxCAO"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84857446424so6671396b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 03 Aug 2026 08:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785769422; x=1786374222; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kpmlhPaZ29dFNT38yqO3kihwGUlr59oo46zK4tKVuxM=;
        b=NwgDxCAOP/Xtj8kYIjHtm6DbddQCtB92rxY3XZFV546upM9mp6NbsBf/OhR0+ElIny
         F+2Zt9cfHVO5hVNYxXdXfA53A3ZkIr+BBjkSbBSt1dfLuLhXm9JsOiOpGGhbypYcS1nU
         gxf6DtDemW0fLSSRPCtYHtFRbViRbT/DJ/tWusGe1eeILGOqWrmbe3aGO4Ri+pnd7O/N
         TiNu3TUQZP78ygRPv3CkdOYfJ4URivnbfsPBpsUHbYoquTwi6AyQV13iBlUcFnCqykcN
         6m5IfnXtHqnJgo9UZnFH3MFMAavHS+RUUeCzSCjV7fY/qurLk3V/Vo+L4UE2gOTGBfqu
         5FHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785769422; x=1786374222;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kpmlhPaZ29dFNT38yqO3kihwGUlr59oo46zK4tKVuxM=;
        b=HGp/VMA/266Nt8IMs8I/7ST0gWj67nyRqPFSEWkH5Lm3vTjturAH9ES1hnDRKcRfuI
         fuTO8SUK8sV0gBboMA2LL0flJ2COXPs0Y5vXKpLO3pIyjjM2daeS2z5ggMGznANgCCBP
         +zkAVm1DZ0XOzO9DCClYxqOeRqAwf/6UQk2UQ2V+D+2QDXjY0YFBLkrQNakJVngvQvcR
         PCh3lA5OgrQxEHXPWXDx7EVXNtGWpAaEXgYcGtnGHwGFXls1alynFum0EQjeCK3gt+Ue
         ekiO8HIYDtBkCKaevCajaLIpChoxpKvjj+5qNnL4EcZtpvcc9/blh1qRj3foB8kV+Wi2
         dOhg==
X-Forwarded-Encrypted: i=1; AHgh+RoCK3RLMMfi9KgLBw+GPvBSjuAkELmGx954iT+dWBH++1JH+xNb4/QlLA+I7bXBZbyPFSNdFVz1wDs+jyv3tXyuKmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeVPld+f+pCEYQSuyNjCdpHEU9CJ9Ig5XsPL0xvdcZoR+zDebu
	UfWyN2MoQlXR92Xi3Anz2KlFI7VGPhUS636h/ZWTfY1SDv9mdZdofViixi/9KSfM9DssGAQjLzI
	r4HEfpw==
X-Received: from pfbki10.prod.google.com ([2002:a05:6a00:948a:b0:847:7765:a4c3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1f08:b0:84e:d51d:86c9
 with SMTP id d2e1a72fcca58-84ee490ac84mr9200662b3a.44.1785769421725; Mon, 03
 Aug 2026 08:03:41 -0700 (PDT)
Date: Mon, 3 Aug 2026 08:03:41 -0700
In-Reply-To: <be77c2cb-6e41-4382-9d2f-cd299f634196@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728-gmem-inplace-conversion-v9-0-35f9aec2aed2@google.com>
 <20260728-gmem-inplace-conversion-v9-14-35f9aec2aed2@google.com>
 <4460e252-b6de-4df3-bea8-0368a9d0f4ff@kernel.org> <CAEvNRgEUQSju2tW_1zMk2=QmveZNtmkjjCZdqVBgBD2JPh0k4Q@mail.gmail.com>
 <a823e3d2-8acf-49d9-a812-ac1bb2136d7f@kernel.org> <edc3566b-370c-41a0-a71d-2e4a0e1a94f7@kernel.org>
 <CAEvNRgEas_9BEV-cNxXu4_wQx8sR2M4_OaW6DEd4=fszALMV0w@mail.gmail.com>
 <60552bee-3326-4917-b00f-5fb7ba3b8adb@kernel.org> <be77c2cb-6e41-4382-9d2f-cd299f634196@kernel.org>
Message-ID: <anCtzQrUkFSSq8De@google.com>
Subject: Re: [PATCH v9 14/41] mm: swap: Introduce lru_add_drain_progressive()
From: Sean Christopherson <seanjc@google.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Ackerley Tng <ackerleytng@google.com>, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
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
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Vlastimil Babka <vbabka@kernel.org>, "hughd@google.com" <hughd@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Fri, Jul 31, 2026, David Hildenbrand (Arm) wrote:
> I sent a fix for the GUP code that always makes us drain right now:
> 
> https://lore.kernel.org/r/20260731-check_and_migrate_movable_folios-v1-1-e0002d7b791e@kernel.org
> 
> Would the following (agains mm-unstable + fix) work for you?
> 
> 
> I assume that you'd have to call it as
> 
> 	lru_cache_drain_for_folio(folio, 0, NULL);
> 
> But maybe there are indeed extra references that are not reflected in
> folio_expected_ref_count() that you would have to consider? I doubt it, but please check if
> there would be a problem.
> 
> There is a small problem for merging:
> 
> (1) The patch depends on the fix.
> 
> (2) mm/swap.c was moved to mm/folio.c in the mm tree.
> 
> We could write what I have below against Linus' tree and have the conflict be
> resolved when merging. Topic branches are unfortunately not yet a thing in MM
> land.

Are you expecting the aforementioned fix to land in 7.2, 7.3, or 7.4?  If it's
7.2 or 7.3, then I would strongly prefer to base v10 on linux-next (where the fix
will presumably land soonish), and target 7.4 for in-place conversion.  Then v10
can be applied against an early 7.3-rcN and we don't need to juggle branches
(assuming Andrew is ok taking the proposed patch through the KVM tree).

Irrespective of this small mm issue, it's getting a bit too late in the 7.3 cycle
to land the in-place series, and we need to address Xiaoyao's comments, i.e. v10
is going to be necessary no matter what.
