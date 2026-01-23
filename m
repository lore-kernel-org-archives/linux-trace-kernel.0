Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BCB2E339B
	for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Jan 2026 12:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769170873; cv=none; b=lQUgCqtN0/wZqTIx6fNb7Fe7TT27VaRVsq2T4zG7j7K3Pp/f1Xb2UWcBpbgBQUqUgQdzAzsqLmORASE3FhN8U298bUjO/yCZyUcQKh2B/mj8FmJb9RakrG85o9P1POelZUaB5Db0EpkfZRxsSo9lRehh6kDJmjkMfyab6fHz2gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769170873; c=relaxed/simple;
	bh=qrrNz70FFr4gK34AJyCd9eOVfmuimB0x+lUYBwlFvF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzyugFRTy9HzTOtbLQVb5wymA4KkDm+HFlis7OEUxYfOMpkkhcVAJV2SetAr57e++Bt9bPdWLxJ9jV2GxEyqLWOKSXOzD0YV+kGEdcACgRaMt1GlmdK6UXCvtlIfnoTIq/LPaTDP1eqy0zgXYma9Q3TrdZvFB+Hn89w2jq5pDn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PL/vJg5C; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PL/vJg5C"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47ee3a63300so24633115e9.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Jan 2026 04:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769170869; x=1769775669; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u8vx9GwQUjLh0uv6iY/ZSwwZRSPo2xMq3kygdhRNHoE=;
        b=PL/vJg5ChsfoXED/SD0DchsJnUHky5owm+ZoaanvI4LwEz8ooY3Hg0coPRh75ECIVp
         Z/1Dvtrc1Y7i5BBBr0ys9/+6bjnbFGTA+uWjAaxcbjx/dkjul4XhPD8ku2hpz6lqWxNp
         se+2Xa3tV2q52gwmuyiXxI/9GSx4ZzIzrypfTmyzchuJP07O37ZAD5dbBlahvBAf6Ya4
         9QWKrC8I39r3r5g76Nd/zijg4VFuwh15A9U4qIohW7LJzs1kmzfYTWQW/tgcrNzGaSfv
         TyDsianWP4oE9ddRbQpbmkr5aHbnJfPjcOLK9JTPcSfPZGDGvgCx315Zkz2qEo8FIv/x
         XT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769170869; x=1769775669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u8vx9GwQUjLh0uv6iY/ZSwwZRSPo2xMq3kygdhRNHoE=;
        b=OEpc9yFW7a0c46zzL7HrqtyfM0o7StJrjekAVUBxQOX44yOyG40mgOS7d9cXYAem5W
         BN0YpRt0JOaMb1FMfMTbzc3kfi+c+gO0HNehRoXohsgZAgJMAUe7ff9wB1JaMsMNQEl0
         GciQZJngagGQkoLL9dfJO8pHB+AdWm5QfhlIW7sHjhULEjeJK91e2cXIaSEGP2/q+xV4
         15sPQvE2KT0lIwajdSu1Aykhajuhv1uXNjVSr2vVkX81SAMXbjPTWkNr5ej8VPFTVhCt
         BO5ziLsCCAGlyduZ1zqE9ziSQIBY5HY/xNzFmz11biGh8XTFRu//XGQCNSqGZ4Un4cih
         vYvw==
X-Forwarded-Encrypted: i=1; AJvYcCXn5RXaFFqRI248LlODJyjO1FtcimkeUjqfE6hG/5EqCC69OyB/YwfrkWhRZvxsgFYSa+X0wC6gWrNV4iicIdaNQwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzVWHvuuyugmHSOZT32Mfx9QDcntOejzK5F9sMJZ7eZu8gLjVR
	Inyg8TqZkC5mBUITTMjAYRBThZdSMFa5Et58YE+yQ2YJE1k1w8hdIWDj2IwJmgvlxA==
X-Gm-Gg: AZuq6aJj7wdAwe9RRiOQ377QAfq66S5MaVsSlD4ECcN6HlGR4QB0E3xcVSqFNidbQT3
	fUzSTWrpQWN/m1os5YhBSCZDrVeInQvN5V2jwNe1vxHHQ9JkPSsEcibKmcv4wq0x0KvMi0j5Zz0
	51OFPAXojOdkdKCLZuSIulctAoLuA6T7D70Y8YpIDvIyTDg51CRJ6C5XWA7+08mRYia3vRU7gPG
	BaRhfOc1J9V2eCw8WlOX6tUCv+hItPvA54BDwN8dRajUnVmUtrSpMNRY+4zc2YV2n9iNyX4k9KT
	T9zSKPr8LyV+8He5q11zhljJnDOfeymdh7eOhFnMAfYNyc0xiioFThbAjgfXbGkv3QznzJ+w+/6
	cke+eC/PEm9iZhCqk5cvjlrGl020NZnjr2MJipwtMe9MRclhnj6xwEZtcBoPHcVeAE3U4XAXI1g
	Y/udPvRif6T+x7RhPwHXsHzsCtoNjZZQCT0zD+/t7ZQcKrWKVfJwnqqkfbXk0y
X-Received: by 2002:a05:600c:3f0f:b0:479:1348:c614 with SMTP id 5b1f17b1804b1-4804c9c09efmr42530825e9.26.1769170868562;
        Fri, 23 Jan 2026 04:21:08 -0800 (PST)
Received: from google.com (44.145.34.34.bc.googleusercontent.com. [34.34.145.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d61f1f8sm22563715e9.5.2026.01.23.04.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 04:21:08 -0800 (PST)
Date: Fri, 23 Jan 2026 12:21:04 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, jstultz@google.com,
	qperret@google.com, will@kernel.org, aneesh.kumar@kernel.org,
	kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 29/30] KVM: arm64: Add selftest event support to
 nVHE/pKVM hyp
Message-ID: <aXNnsJqqsskXyJu7@google.com>
References: <20251202093623.2337860-1-vdonnefort@google.com>
 <20251202093623.2337860-30-vdonnefort@google.com>
 <868qe9mnx5.wl-maz@kernel.org>
 <aXNmKpHqVw93BegX@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXNmKpHqVw93BegX@google.com>

On Fri, Jan 23, 2026 at 12:14:34PM +0000, Vincent Donnefort wrote:
> On Wed, Jan 07, 2026 at 03:40:22PM +0000, Marc Zyngier wrote:
> > On Tue, 02 Dec 2025 09:36:22 +0000,
> > Vincent Donnefort <vdonnefort@google.com> wrote:
> > > 
> > > Add a selftest event that can be triggered from a `write_event` tracefs
> > > file. This intends to be used by trace remote selftests.
> > > 
> > > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> > > 
> > > diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> > > index 37c015b54ff6..e2de7ad64938 100644
> > > --- a/arch/arm64/include/asm/kvm_asm.h
> > > +++ b/arch/arm64/include/asm/kvm_asm.h
> > > @@ -96,6 +96,7 @@ enum __kvm_host_smccc_func {
> > >  	__KVM_HOST_SMCCC_FUNC___tracing_update_clock,
> > >  	__KVM_HOST_SMCCC_FUNC___tracing_reset,
> > >  	__KVM_HOST_SMCCC_FUNC___tracing_enable_event,
> > > +	__KVM_HOST_SMCCC_FUNC___tracing_write_event,
> > >  };
> > >  
> > >  #define DECLARE_KVM_VHE_SYM(sym)	extern char sym[]
> > > diff --git a/arch/arm64/include/asm/kvm_hypevents.h b/arch/arm64/include/asm/kvm_hypevents.h
> > > index 268b3cd7a1b2..c276fd28e0bf 100644
> > > --- a/arch/arm64/include/asm/kvm_hypevents.h
> > > +++ b/arch/arm64/include/asm/kvm_hypevents.h
> > > @@ -42,4 +42,15 @@ HYP_EVENT(hyp_exit,
> > >  	),
> > >  	HE_PRINTK("reason=%s", __hyp_enter_exit_reason_str(__entry->reason))
> > >  );
> > > +
> > > +HYP_EVENT(selftest,
> > > +	HE_PROTO(u64 id),
> > > +	HE_STRUCT(
> > > +		he_field(u64, id)
> > > +	),
> > > +	HE_ASSIGN(
> > > +		__entry->id = id;
> > > +	),
> > > +	RE_PRINTK("id=%llu", __entry->id)
> > 
> > Not strictly related to this patch, but I find that the trace itself
> > lacks context. For example:
> > 
> > [001]	  323.847422: hyp_enter reason=hvc
> > [001]	  323.847423: hyp_exit reason=eret_host
> > [001]	  323.847688: hyp_enter reason=hvc
> > [001]	  323.847688: hyp_exit reason=eret_host
> > [001]	  323.847706: hyp_enter reason=hvc
> > [001]	  323.847707: hyp_exit reason=eret_host
> > [001]	  323.847722: hyp_enter reason=hvc
> > [001]	  323.847723: hyp_exit reason=eret_host
> > 
> > That's all fine as long as I'm dealing with a single guest, or even
> > with a single vcpu. Trying to trace multiple guests, or even multiple
> > vcpus makes the whole thing completely unusable, because I have no
> > idea what I'm looking at.
> > 
> > To make this useful, having some context provided by the host really
> > is required.
> 
> I could add to the event header the VM pid related to the currently loaded vCPU
> (if any). I can access it easily with host_kvm->userspace_pid. WDYS?

Or actually directly kvm_vcpu->pid?

> 
> > 
> > Thanks,
> > 
> > 	M.
> > 
> > -- 
> > Without deviation from the norm, progress is not possible.
