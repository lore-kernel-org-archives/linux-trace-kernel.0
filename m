Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792739599;
	b=fcuLTFotjgo6V/AGiKSNUhggEW0LfmsyTae+zaOoZMvjwlW+eOsQgF9Jkmu4tjPJFSX6
	 P4Lx9iOkkou6LSmXJqkGWJzOYxEhuJRQJ/XKuj6RUCRjRUDlA3RZnDkEbdV5YoF5ezjPj
	 HpjaPv6ThTm1FKrTM98MoOQQpwMBLdXbhq5ZJjzBitnX+8l5jVRkYtzMMUyPqD4l3+/dv
	 7TOcJlk2XeV2tYPYwTr7bKk0I0+BHpPD9Tc9XqQouVuUXk/YVLeUB5xjKwxkVXZlJRG0B
	 ggMYaXzyimt7Nf3WUdGyRFn+ySFCiX4DZ+H8L7GNDRm5fmTZ0vyP1A8XXAdJukMmt8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792739599;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=XNgOedYkG+DZgIJoTAqem0cgXoeI7a/tKZ3psjHCVOM=;
	b=BDw2zGk8GdE+NVbsB1p3rXak7VFX1iAm0xGUwwfVrnHRHOL57pkWaPMENh+zW5PbEU3k
	 MQ5pSfQE0ysp7sQIwMvfRu+4Lt4Ox/Q2i3DXhR6hiXSIHr9nwYfJ0aPrxpuaK2PEvgA2z
	 Sri169W8SfYqUrKvxbN572gxpn5BMbx6jMmcZaMOwPboBz/LzBHlASAAfWHLaNYA57+82
	 ooQN77wwdJsr3vDE4F0dNXRufKRcFn1+WosdyJPv1WGBxk4Usrmw8VqLrJ7RVGiw8lqNz
	 gV1eHYoV7T59lex5YQ/13aRFTvwnw3p8TBPzlyAeBbo356kHRah6UxY3UAVjDCF/avA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PgIl7hnN;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4B9606A31D
	for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Oct 2026 07:13:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC4B9606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PgIl7hnN
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so1167475e9.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Oct 2026 00:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792739597; x=1793344397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XNgOedYkG+DZgIJoTAqem0cgXoeI7a/tKZ3psjHCVOM=;
        b=PgIl7hnNL2QdgYF8XRVPQYVuzZqRwz4qq5TwpsYKDRimBKA3LUYzBwLW/MzRYyLL+S
         s9859MsRRxRDpqxkJC6USW1Pl0y0uyUpOsi1iyEBgSNnVPt/AvNMDUSSjbM8ccW3psqY
         vfwV881aWZeC/xCoVJKiqXN+gzppdvWMuuutgf2al4Z4YGw0MQY8q0YaaZmiXIicPU05
         OEQ4yuF7oQSrxoT2uIkU9lUdY7FIHqHFUskdwzGcT4be7Zy13eH/kG2e0fRu36LIb/Tv
         TGERRy8ygGjhkALaEgJseD1JgBs8QoK4paB5TE1iNALXnxC7pPKEMEn4GHHqowJuKO2n
         kx+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792739597; x=1793344397;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XNgOedYkG+DZgIJoTAqem0cgXoeI7a/tKZ3psjHCVOM=;
        b=XUFEaxHjocSBGt8xJCm2EMPmFa5/6KVcA3MvJZ9Li/NS9sARJr1SaIkHNQvbZ3an3b
         A5D0EDtZacclQNe5EUKYRR6ACptJ0HvBQvqvxq2MiDdfvd4MDt0+6STScgAXPMcPiYly
         ICyhP9CiKtYxtMU3zZgjqnCB7flFxU/n2FeaSdRUrocUN760WoK32cRnD24t6QIZp3In
         T9tjP1bZJIZgsHcvqvr15X8jQhtedomvGatW70t4o5Q4sGxzTejhkERHDF4lW0sRq72+
         Xo/wPbenvFTDDg649lSaLgNgL15Sm1xHBjGFawnjhvUmq4W9BdxQkYhaND3+BqkDWaFd
         0+Vw==
X-Forwarded-Encrypted: i=1; AKwUvBy9dkGiWTVnF+TO1yXefMmboVU4gFGFPjHXOSISW3IBIiLKTP1SK9UEAwy7A2rPS/Pb6sfveSPk/MIoLWZ7VGBSkdk=@vger.kernel.org
X-Gm-Message-State: AFq9FYL4EsUhhTCNSA3To1772WjfMeAJ76bcaSfrlOzTHqLzHoqKUaxS
	Wbm1SInxqjPd6CFHia94tBKyI9KZD6NK+kYRSKoKd0wfEaqmiGVLW0cn
X-Gm-Gg: AYBFou29/lvXo0YlbbXthh7p5YwU1pcG37m6s8CNEHYGP0Gb5qJhXjnPMHC0xbg7naS
	yFllrOYUoPuLOHsL9vX9XN7kSM5QmOCkQzb1gg9Ge/q1flP7+P6sOZCltGH1heXxs1CLeKeaxdO
	eOUOxg9b8lJYzrIOdN2/olzknxBZNGlEZnLG871GfyArjIfZCjZIc8LCxDXYWFZB3cRkTD3Q7CZ
	wLVze5xjL5wJrho70Cp5FRn9ZAhFXdiMR7w1e1UjshxPRkXtrQLR3LpKg75J99DT5oZCOwot/fD
	ohoQw5EFTsnixfz2xCb6zl/0d6GiqCxqvM7MXcAIP1CpB/bsTv8AcSpGS5JhRO+QllbM1/3F2JT
	uduCxgCRB6J5txZWrCkihfkgu96/4oPg/wYq0BKhD5tm5C1+lMCKYmbXfEfucxg1wrKEzhPaez0
	fUL9467gRBDLahpEVH8HM4Vj8uoSyR8PRJ2D2rhnYSYyxVlV/+WZHrafz7mhMW2aIYh8g31yRlR
	Jvw/xvI4u8zob8QK7EBWINLkG/6
X-Received: by 2002:a05:600c:1c05:b0:4a1:6c79:fd31 with SMTP id 5b1f17b1804b1-4a211c9e009mr24676825e9.12.1792739596914;
        Fri, 23 Oct 2026 00:13:16 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::25dc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a2103622f0sm54943425e9.6.2026.10.23.00.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 00:13:16 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 23 Oct 2026 09:13:13 +0200
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com, oleg@redhat.com,
	peterz@infradead.org, mhiramat@kernel.org,
	akpm@linux-foundation.org, liam@infradead.org, ljs@kernel.org,
	surenb@google.com, david@kernel.org, vbabka@kernel.org,
	jannh@google.com, hughd@google.com, kees@kernel.org,
	mingo@redhat.com, tglx@kernel.org, x86@kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 3/9] uprobes/x86: Finish an unoptimization which
 failed half-way
Message-ID: <atsJCamloi-SWUGh@krava>
References: <20261022015712.1297331-1-alexei.starovoitov@gmail.com>
 <20261022015712.1297331-4-alexei.starovoitov@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022015712.1297331-4-alexei.starovoitov@gmail.com>

On Thu, Oct 22, 2026 at 01:57:06AM +0000, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> int3_update_unoptimize() restores optimized nop10 in three writes:
> 
>   48 8d 64 24 80 e8 d0 d1 d2 d3    lea -0x80(%rsp),%rsp; call tramp
>   cc 8d 64 24 80 e8 d0 d1 d2 d3    1. trap new entries
>   cc 2e 0f 1f 84 e8 d0 d1 d2 d3    2. restore bytes 1..4
>   66 2e 0f 1f 84 e8 d0 d1 d2 d3    3. restore byte 0
> 
> uprobe_write() can fail with -ENOMEM, or with -EINTR when the task is being
> killed. When the 2nd write fails the result of the 1st one stays. Byte 0 is
> a breakpoint and it works. But the next set_orig_insn() doesn't find lea in
> byte 0, takes it for a plain breakpoint and restores one byte:
> 
>   66 8d 64 24 80 e8 d0 d1 d2 d3    lea -0x80(%rsp),%sp; call tramp
> 
> Nothing recognizes these bytes anymore. The process keeps the call into
> uprobe trampoline, which can be unmapped already.
> 
> Teach is_optimized() to recognize the half-way state, and let the 1st write
> of int3_update_unoptimize() skip what is already done.
> 
> The failure wasn't reproduced, but the state can be made by hand. Attach to
> nop10, call it to get it optimized, write 0xcc over byte 0, detach.
> 
> "uprobes: Don't sleep on mmap_lock under dup_mmap_sem" needs this. There
> fork() removes the breakpoint from its mm. When fork() is killed in
> the middle register_for_each_vma() removes it for the second time.
> 
> Fixes: 554ba38456da ("uprobes/x86: Move optimized uprobe from nop5 to nop10")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

nice, great there's simple fix for that

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka


> ---
>  arch/x86/kernel/uprobes.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 65a2de82ecd2..62bbe41c6466 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -896,6 +896,9 @@ static int verify_insn(struct page *page, unsigned long vaddr, uprobe_opcode_t *
>  	case EXPECT_OPTIMIZED:
>  		if (is_opt_insns(&old_opcode[0]))
>  			return 1;
> +		/* An earlier attempt got this far and failed, nothing to write. */
> +		if (is_swbp_opt_insns(&old_opcode[0]))
> +			return 0;
>  		break;
>  	case EXPECT_SWBP_OPTIMIZED:
>  		if (is_swbp_opt_insns(&old_opcode[0]))
> @@ -1109,6 +1112,17 @@ static bool __is_optimized(struct mm_struct *mm, uprobe_opcode_t *insn, unsigned
>  		s32 raddr;
>  	} *call = (struct __arch_relative_insn *)(insn + LEA_INSN_SIZE);
>  
> +	/*
> +	 * INT3 followed by the rest of the optimized instructions is what is
> +	 * left if int3_update_optimize() or int3_update_unoptimize() failed
> +	 * half-way. It works as a breakpoint, but to restore the original
> +	 * instruction it has to be unoptimized like a completely optimized one.
> +	 * The same has to be done if a debugger has put its INT3 on top of an
> +	 * optimized uprobe. The trampoline can be gone already, so do not look
> +	 * at the target of the call.
> +	 */
> +	if (is_swbp_opt_insns(insn))
> +		return true;
>  	if (!is_opt_insns(insn))
>  		return false;
>  	return __in_uprobe_trampoline(mm, vaddr + OPT_INSN_SIZE + call->raddr);
> -- 
> 2.55.0
> 
