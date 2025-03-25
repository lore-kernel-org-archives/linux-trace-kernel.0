Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5698A266591
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Mar 2025 20:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742935312; cv=none; b=g+3x5DrTuCJyzWOwOdcAqiL2hwGt1vwlNujkIbCYdfYFrPBQbxLAO5Gr89LOlHO0o6ezLDbt6kY+fclp+73D+rjJX1LUN8fgBp8BD0YZgh2diOAURO/WcEtfllHKA98odOt2Zr8gbg4Do7CXegu6C/nUFv8bcFLpKGa714cwOAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742935312; c=relaxed/simple;
	bh=GCAhGVtueceq1ubCUXU7aIifbCxnCpAKEuI8oUAtt/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o2vezoab98SC8cXmtSqRyL/H2gemQXw5uSRTU1u4/riqtedPBPiIOPUSbZ6HTarq/MlOy9Efsd50olq3tBtaX9Ks4rFYRwIn7C/oDvsmf2q/RLg6jR3cUqqOVAP4y3TE8bKB3tb4gS2yCqpWvmY3PTDWyFXL5iyv6TWmxzNyrlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KdHO2J00; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KdHO2J00"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac2bfcd2a70so853129566b.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Mar 2025 13:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1742935309; x=1743540109; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K52xAWNW5IEkY2W6yv56tbrXz/O78EY3OFwe6Kmcp1A=;
        b=KdHO2J00TAe4cgySGHdLO47Aqso/bC/fKKMo8P2q/ImYFczI0grhq/U4sPkIJUmEDy
         wjtClJSVXHJ1pOD8LMyYg2X7mAznVxjHKeIPF32qWD8ufaiPjjOCh68DkC/zxqiOwzLy
         ZF3akULDuXPyv9SoRnB6XsiGX4HBqH9K1Kblw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742935309; x=1743540109;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K52xAWNW5IEkY2W6yv56tbrXz/O78EY3OFwe6Kmcp1A=;
        b=mqS/+x5xPsH5sC2ltUq88GkUNeeQj73k1HSjo+Lhi1QcAVnUmDTENvK0ufSh5+AL6J
         oSqTmRx2QdT204SIhE2yK7lkQtXVHTKxyxc2E/5vDAivfFvE2pGRUpYr+Lxg2yw2Wffb
         /73KGz9DiIvYtmNmqYEr5csBo6OpHpJIBIoMnbayQju5ZgUrtf4X+7vdjlzysR4kdPfZ
         sEqCkZGhbPJG9rSlVhgjOWAo2+W1SODM1rFmKytHHdY3/LXuf4zI0AMkoQlUy4moCe+A
         S1TWDB8aBsapFusuv7euiQlgzeglOOAlo7a8Mk1Yta/A14bNLYRTcXsr4wvmrxmM649f
         rlBw==
X-Forwarded-Encrypted: i=1; AJvYcCVhx9w6r915Dail+ogt6Xm2EabahTxuiDA9TvQkElZGB/mcwWcnynOn+BKENoDeU85Jc5lM5mAe8yJfcv5uNmrmvz0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj8C+DIo5WccsyZgkYSpIwk96T71egqZoCp/sxmC41JMaiqSsg
	ZJ7a5F6D32xp++VyKfAaRGy1DmI3xMGb3qeTdu8eNVBJV/4mWvZdp+GKWB7O1v2DwTUNjRBQsOo
	gAZk=
X-Gm-Gg: ASbGncu6sTVYppVNpf9xA9ao9yeMNmJZRfvJOY7mdV++uJJe2oV07Nxu4LUBBR8Nyf/
	AcfCt/5+Dt2vEzEDKUhD599MR/auceoo7kMxuc8O59WItz37F8pcbYjlDJ5Mti6/Jf5dGeHYiOe
	H9KXC4tv/4ZgDaom1kKW2AZQOK9wDD5UZGshMFa9911VrKEchMfj7PWlGWTNqVrlhmM5ZCFqi/K
	DnGdV7xyD1OC4PakndAf1f+HH21HpxrL4L/QgO+LVEnA8J/MzK6T6GWmIbj+NgzmLaq1PK9EZsL
	dioDBaomwLCJ+AxaPxTD6eSuDnkUZ6H5n4sMmmrogIjI+wAZhlshcMWgzE4B+IB0Wq8yKN79L8u
	1i9jENeB94xk5gnbfEfU=
X-Google-Smtp-Source: AGHT+IFEJr/0oIyJ2MZ+/aP+8HKDUIw/nFETEIurPdkVcir7yYnhRFl4QxhNWLDZV5z+xjikxDZrbw==
X-Received: by 2002:a17:907:f50a:b0:ac3:45c0:6d08 with SMTP id a640c23a62f3a-ac3f1e4a8f4mr1830783966b.0.1742935308782;
        Tue, 25 Mar 2025 13:41:48 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef86a13bsm911916666b.23.2025.03.25.13.41.48
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 13:41:48 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac2963dc379so1025701566b.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Mar 2025 13:41:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWUiyeeAShi92EApiiYX2qh8L45K0SjnffQfKQEIN9ndij1UlJgD/MlnDoyHJ5/8wZVoJpaixMHCOOfIEmx5NdkYGY=@vger.kernel.org
X-Received: by 2002:a17:907:95a4:b0:ac3:48e4:f8bc with SMTP id
 a640c23a62f3a-ac3f27fd3b3mr1859596466b.48.1742935307883; Tue, 25 Mar 2025
 13:41:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325121624.523258-1-guoren@kernel.org> <20250325121624.523258-2-guoren@kernel.org>
In-Reply-To: <20250325121624.523258-2-guoren@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 25 Mar 2025 13:41:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiVgTJpSxrQbEi28pUOmuWXrox45vV9kPhe9q5CcRxEbw@mail.gmail.com>
X-Gm-Features: AQ5f1JpwFc7ifwGuAhyrs4E5qPgHx1McCR38KFycRhkLFRMKTveHrmoaWi4zba4
Message-ID: <CAHk-=wiVgTJpSxrQbEi28pUOmuWXrox45vV9kPhe9q5CcRxEbw@mail.gmail.com>
Subject: Re: [RFC PATCH V3 01/43] rv64ilp32_abi: uapi: Reuse lp64 ABI interface
To: guoren@kernel.org
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, anup@brainfault.org, atishp@atishpatra.org, 
	oleg@redhat.com, kees@kernel.org, tglx@linutronix.de, will@kernel.org, 
	mark.rutland@arm.com, brauner@kernel.org, akpm@linux-foundation.org, 
	rostedt@goodmis.org, edumazet@google.com, unicorn_wang@outlook.com, 
	inochiama@outlook.com, gaohan@iscas.ac.cn, shihua@iscas.ac.cn, 
	jiawei@iscas.ac.cn, wuwei2016@iscas.ac.cn, drew@pdp7.com, 
	prabhakar.mahadev-lad.rj@bp.renesas.com, ctsai390@andestech.com, 
	wefu@redhat.com, kuba@kernel.org, pabeni@redhat.com, josef@toxicpanda.com, 
	dsterba@suse.com, mingo@redhat.com, peterz@infradead.org, 
	boqun.feng@gmail.com, xiao.w.wang@intel.com, qingfang.deng@siflower.com.cn, 
	leobras@redhat.com, jszhang@kernel.org, conor.dooley@microchip.com, 
	samuel.holland@sifive.com, yongxuan.wang@sifive.com, 
	luxu.kernel@bytedance.com, david@redhat.com, ruanjinjie@huawei.com, 
	cuiyunhui@bytedance.com, wangkefeng.wang@huawei.com, qiaozhe@iscas.ac.cn, 
	ardb@kernel.org, ast@kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-mm@kvack.org, 
	linux-crypto@vger.kernel.org, bpf@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-atm-general@lists.sourceforge.net, linux-btrfs@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	linux-nfs@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Mar 2025 at 05:17, <guoren@kernel.org> wrote:
>
> The rv64ilp32 abi kernel accommodates the lp64 abi userspace and
> leverages the lp64 abi Linux interface. Hence, unify the
> BITS_PER_LONG = 32 memory layout to match BITS_PER_LONG = 64.

No.

This isn't happening.

You can't do crazy things in the RISC-V code and then expect the rest
of the kernel to just go "ok, we'll do crazy things".

We're not doing crazy __riscv_xlen hackery with random structures
containing 64-bit values that the kernel then only looks at the low 32
bits. That's wrong on *so* many levels.

I'm willing to say "big-endian is dead", but I'm not willing to accept
this kind of crazy hackery.

Not today, not ever.

If you want to run a ilp32 kernel on 64-bit hardware (and support
64-bit ABI just in a 32-bit virtual memory size), I would suggest you

 (a) treat the kernel as natively 32-bit (obviously you can then tell
the compiler to use the rv64 instructions, which I presume you're
already doing - I didn't look)

 (b) look at making the compat stuff do the conversion the "wrong way".

And btw, that (b) implies *not* just ignoring the high bits. If
user-space gives 64-bit pointer, you don't just treat it as a 32-bit
one by dropping the high bits. You add some logic to convert it to an
invalid pointer so that user space gets -EFAULT.

            Linus
