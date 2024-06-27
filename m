Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8865B4C9A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 27 Jun 2024 17:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719510468; cv=none; b=u6SZFa0gHEchxwNqem0cwESLSH+G/86tY/2m0g03SemH9FhUGXCvnlB8DesTqPzWKxb1tEtewGRtsFJJLmXoCd34MTTtsdB1V+NTWWx8IiUKEZKImThmqiAeVF+seujJ7IdZ6kisqF76NR/OTaWeiXmXntxTDzT7d9dkZ1QWG0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719510468; c=relaxed/simple;
	bh=MTZ3hUQ+3T1i7gL9eB4g9KxQm4uPN/OOpaTqlyxxs5c=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=uPRfR/Xwikt8nMLfjX7d5O6fVvMAg886i3glWKruHy4U1EINq43Eaxc6eoOOii94SqjjrIkWfFWE2uoLBJRAsae4dY2nEEJz4i588dw1gZexgySTCFRCvK5LqdEuVjE8wladLsUy9xipruJs3Jh0JtjdksRKXcTLiWCJf3IQG8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=Iz7KIqYJ; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="Iz7KIqYJ"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2c7c61f7ee3so6374794a91.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 27 Jun 2024 10:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1719510466; x=1720115266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pP/AqxoKCyoqEpFvmzCtu+OJjkK1mMvRQlVqjG6zlp0=;
        b=Iz7KIqYJxXPgtQS0KIYfhe88jwUXziTMTtGFzuB1xsjzFHaPI3aBmlCth6w/bLnc2U
         NhnPgRCjyQX4t+lwOsAfQE5Aye0Py/PtGdp1vRz/7qcl5bqNkamy+lNraauXoRoJ/Nyr
         LZCzlzX0o+Uizo3BKzhhNOCfxzqeh3YBfIB9zAe0L7ro7fNPaJh6prVg1o7D2qZiwLef
         Xxb0PZmCNkSXugG/CGwX9Hl6fD7HorUIY3T8VeAVf1vyK1eTfLzQR7f70kWGTlSoKLMp
         0bi4N9kxhvBkdlf+bAY+l2J9CEqfSMlJJW8H/x2IJI3HqB4VzK8W66PUSg6jJs2eZfJP
         Qavg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719510466; x=1720115266;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pP/AqxoKCyoqEpFvmzCtu+OJjkK1mMvRQlVqjG6zlp0=;
        b=Rw3XqzWMUTWH/enCmXe+4H3qJt3pYn76v4NykyqilYx58NVLlaK1XQ1xy1/I4YJec/
         9bO4oZDYTeHVrQav1zD1I0CisFIk/gLSR12glA+iG4vQvLdyg1alwRxXTiLVn7cD51op
         SbSSTvyWLoYuc5OujwZ8e8kT6Mym4Tj8sM0pXfAQRMLOdw5JcAkTfQQz/WyQT2L7+ee4
         zLExhk4aqCo3l89zbhqZPyfqnvVVQ7bgJjgEDNUI8l0IcXhbj1b/IMIjQklT/5EXcBND
         HAHztgUn3CV9ZVpwCnr20wQ/JrcGWvO5EIO6IrdHkPPAOdBbPxZaHsdf1uVJGvgS+tfH
         dWjw==
X-Forwarded-Encrypted: i=1; AJvYcCVnTLmf2mNcCcdrwO+1lhYl1o/+KgU4Z3mYZ/OtLH7hLzxW+8bcoUTnzyG2CxTDkgjWrGqTO1aFklMmBsAnJgxyyD7/cH56jTzJtnDxUEaK80eQ
X-Gm-Message-State: AOJu0YxTKqBUS8lpClvUy+qCKu/7COr6nK6iEfk5X3sF1TVNkcrZRECZ
	4yd2tlhDOZ5jHvGadG5C0dFvNzfyZ3a7ZGgLvq+cukUiyM1NE9CrA6T35tlFID0=
X-Google-Smtp-Source: AGHT+IGVJIolUw1wnEP6rXONdYGodPDrBpa15ZN0Oskw9/8CenqbKYTIAQinxff1hF7IO+HHWnbJgg==
X-Received: by 2002:a17:90a:780f:b0:2c2:f704:5278 with SMTP id 98e67ed59e1d1-2c8ab7379d4mr8580920a91.42.1719510465605;
        Thu, 27 Jun 2024 10:47:45 -0700 (PDT)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce466f8sm61119a91.21.2024.06.27.10.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 10:47:43 -0700 (PDT)
Date: Thu, 27 Jun 2024 10:47:43 -0700 (PDT)
X-Google-Original-Date: Thu, 27 Jun 2024 10:47:41 PDT (-0700)
Subject:     Re: [PATCH -fixes] riscv: patch: Flush the icache right after patching to avoid illegal insns
In-Reply-To: <20240624082141.153871-1-alexghiti@rivosinc.com>
CC: rostedt@goodmis.org, mhiramat@kernel.org, Mark Rutland <mark.rutland@arm.com>,
  Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, Bjorn Topel <bjorn@rivosinc.com>,
  alexghiti@rivosinc.com, andy.chiu@sifive.com, puranjay12@gmail.com, linux-kernel@vger.kernel.org,
  linux-trace-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Conor Dooley <conor.dooley@microchip.com>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: alexghiti@rivosinc.com
Message-ID: <mhng-d9e4078a-6e3f-4890-b507-93005c5a91df@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Mon, 24 Jun 2024 01:21:41 PDT (-0700), alexghiti@rivosinc.com wrote:
> We cannot delay the icache flush after patching some functions as we may
> have patched a function that will get called before the icache flush.
>
> The only way to completely avoid such scenario is by flushing the icache
> as soon as we patch a function. This will probably be costly as we don't
> batch the icache maintenance anymore.

Ya, it's going to be pretty miserable for performance.  We'd talked 
about using objtool for the static rewriting a few weeks ago in the 
patchwork meeting, but with the dynamic rewriting suffering from similar 
issues it seems best to just pick this one up.   We can always sort out 
the performance isuses later, at least this is correct.

> Fixes: 6ca445d8af0e ("riscv: Fix early ftrace nop patching")
> Reported-by: Conor Dooley <conor.dooley@microchip.com>
> Closes: https://lore.kernel.org/linux-riscv/20240613-lubricant-breath-061192a9489a@wendy/
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/kernel/ftrace.c |  7 ++-----
>  arch/riscv/kernel/patch.c  | 26 ++++++++++++++++++--------
>  2 files changed, 20 insertions(+), 13 deletions(-)
>
> diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
> index 87cbd86576b2..4b95c574fd04 100644
> --- a/arch/riscv/kernel/ftrace.c
> +++ b/arch/riscv/kernel/ftrace.c
> @@ -120,9 +120,6 @@ int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
>  	out = ftrace_make_nop(mod, rec, MCOUNT_ADDR);
>  	mutex_unlock(&text_mutex);
>
> -	if (!mod)
> -		local_flush_icache_range(rec->ip, rec->ip + MCOUNT_INSN_SIZE);
> -
>  	return out;
>  }
>
> @@ -156,9 +153,9 @@ static int __ftrace_modify_code(void *data)
>  	} else {
>  		while (atomic_read(&param->cpu_count) <= num_online_cpus())
>  			cpu_relax();
> -	}
>
> -	local_flush_icache_all();
> +		local_flush_icache_all();
> +	}
>
>  	return 0;
>  }
> diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> index 4007563fb607..ab03732d06c4 100644
> --- a/arch/riscv/kernel/patch.c
> +++ b/arch/riscv/kernel/patch.c
> @@ -89,6 +89,14 @@ static int __patch_insn_set(void *addr, u8 c, size_t len)
>
>  	memset(waddr, c, len);
>
> +	/*
> +	 * We could have just patched a function that is about to be
> +	 * called so make sure we don't execute partially patched
> +	 * instructions by flushing the icache as soon as possible.
> +	 */
> +	local_flush_icache_range((unsigned long)waddr,
> +				 (unsigned long)waddr + len);
> +
>  	patch_unmap(FIX_TEXT_POKE0);
>
>  	if (across_pages)
> @@ -135,6 +143,14 @@ static int __patch_insn_write(void *addr, const void *insn, size_t len)
>
>  	ret = copy_to_kernel_nofault(waddr, insn, len);
>
> +	/*
> +	 * We could have just patched a function that is about to be
> +	 * called so make sure we don't execute partially patched
> +	 * instructions by flushing the icache as soon as possible.
> +	 */
> +	local_flush_icache_range((unsigned long)waddr,
> +				 (unsigned long)waddr + len);
> +
>  	patch_unmap(FIX_TEXT_POKE0);
>
>  	if (across_pages)
> @@ -189,9 +205,6 @@ int patch_text_set_nosync(void *addr, u8 c, size_t len)
>
>  	ret = patch_insn_set(tp, c, len);
>
> -	if (!ret)
> -		flush_icache_range((uintptr_t)tp, (uintptr_t)tp + len);
> -
>  	return ret;
>  }
>  NOKPROBE_SYMBOL(patch_text_set_nosync);
> @@ -224,9 +237,6 @@ int patch_text_nosync(void *addr, const void *insns, size_t len)
>
>  	ret = patch_insn_write(tp, insns, len);
>
> -	if (!ret)
> -		flush_icache_range((uintptr_t) tp, (uintptr_t) tp + len);
> -
>  	return ret;
>  }
>  NOKPROBE_SYMBOL(patch_text_nosync);
> @@ -253,9 +263,9 @@ static int patch_text_cb(void *data)
>  	} else {
>  		while (atomic_read(&patch->cpu_count) <= num_online_cpus())
>  			cpu_relax();
> -	}
>
> -	local_flush_icache_all();
> +		local_flush_icache_all();
> +	}
>
>  	return ret;
>  }
