Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DCB304976
	for <linux-trace-kernel@vger.kernel.org>; Thu, 14 May 2026 16:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778777682; cv=none; b=LuEPPLtmP1euFb9cZ/lqCHKzDcV6DMynk9zuo7zgPTYowwVU8RT7tklOR9nnDb/djohOBjAkH7+Pi0w+K+5HaOM/pS3H/Kr2RGwyQaQ6UxiuYHi2MDHxxXL0ARPI/udfUDM0tpiwM3Q5qp3k+mK7+k8V58JoDkU5+vN+mW2mGKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778777682; c=relaxed/simple;
	bh=+DGvjpHcOhJ6DtNpj1VpvJZDlmLIzdu0VoLwXaN1U0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLceebJE4UwAMA/35IH9aHDkIdpQuweRnSOwX+NQGRnkbJn7XSvb9bvk+zoHoCYV/v7zWdYLA+XkE0erL+BMu7bnWh0ToPifCX2LWxNpKipWQETEcMEijhmMA3mLwvJY1ZE5NE3I/SS18D9T6gL77Y2HrXGE8dtS1HsqMYmU/rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=fEXqg5rW; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="fEXqg5rW"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bb91b426e40so1359873166b.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 14 May 2026 09:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1778777680; x=1779382480; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KWfDrGLGgO48ixEbmT2Dvcse7TpTneR2J3aHwB59qng=;
        b=fEXqg5rWZ8ZaGQ79TWVcScNHaRIketgLed/isST7C4AOZG8rAsqmJ0tbnVX15QZJI+
         x7uSd6imTuo+PgxCyISSM5IZG2VfQqFL0qP4fehdBhhsYV67m1KntUDyOfCFONn3YGiI
         +InmNrnbzdb7HAHQ6WmV4mNC08jtWI1HEr3+LftHpvi1Wq6O5f58rwxhsm0ViuJ27Ddu
         x47JWNscY7lOdADqnQRgvAONaMP7zlgWgogtVCNmiZoMgMaWxWAWUEO642QmB2/jxjCH
         QYFwhzGNVaNVcqerohu+zW4PE2cHOgGwORktO5NwIT9/XBuwLN8FV4Akyv5dgcB0GK9m
         T11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778777680; x=1779382480;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KWfDrGLGgO48ixEbmT2Dvcse7TpTneR2J3aHwB59qng=;
        b=JA6/IGeC6XgO0SYiJLCi3biYFFM4xWF2pfNxLSmsq4JslIYeYy11/0r50fHituh0LY
         vvZbEukfOhwIX9QgG7Nq5LmzYXzhJVRwXkfsG5uBQQ5FRxW3GJwEdrLmyyXWifN1qv4Q
         PwTZE7GRtuvk/OvjfrOPBboT7KsYK0+maJRkWiUxsAgALIAGvP367hRw+T50NofUfd3c
         nVTnU1XRIUU/8Tx52Be10NR77IxPsOz3mjmwm6Kkj96TkzM1i5s3coHUDSHoEGADpdvz
         ABkaXsTBoIlsKrvG4Xnc+uGp4Yuh7rJNa4MqQX9xZssi1ljyDKdbVpImcrsPkF/N4eiV
         BPRg==
X-Forwarded-Encrypted: i=1; AFNElJ86W5fZDFgNqM9qY1Tn/p3UcjmXbefpz7/bqSDcTZyIKvknvX+otgP2VEQBCI+feOsvIrQrN+GhcAnwO64oaJacJXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcUV3d0AHdNE5m8DkYN/S8B/VUXOa/9KUjSXPzFlM9uxDEzFbm
	tV3mRkEYaAaYB2GZp70M60fX8kAjCO+knxUD3Yx0LkqAY0/Ka55npg8jHf9r4XbdU9k=
X-Gm-Gg: Acq92OGffacVPuMqk7CLStpxv1rEyW/xQHMp6qZi1Rghn3UTUKxlpYm1v2y2CaV3A6/
	SnGG6HT20LRxBvIUDZGLfbg74UwHd5UJU0Sh0eNk7tee26GN/tg/nGM05P98sjk8Y+sIvO2gOjQ
	1xCDPMvlK80/j5IqXHAqLsfpZXDpC9grv1QpLABWckqt1d4DFhjZirEuWQhdIz8hqslL2UFvX98
	0umeATiWoeIKd6rNjoNS9LZjeJj8Sxzx2s53HiNQkqjcbVEiY6wti7FgBnYV4sExyMOTirDJ6OD
	0WHqVEOR31Os17juWxXPb2gUiiIz+Pw/x/BrN4tL3YiSvleFSDsXMcIQWl+WEjStfHDcl7AOxIv
	R2Q1Esju5uoYi084Ctw4bXMQt1ZJhBAAelbEONLqwzp10XsWBfzmrgNUXeLBXrJHNraxhQUbdnR
	T5a9Q9sYpylK4mJTCv
X-Received: by 2002:a17:907:c91f:b0:bc5:1329:a1c8 with SMTP id a640c23a62f3a-bd5178fa47bmr1803766b.31.1778777679702;
        Thu, 14 May 2026 09:54:39 -0700 (PDT)
Received: from 2NNP224 ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6831187ecf7sm886863a12.30.2026.05.14.09.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 09:54:39 -0700 (PDT)
Date: Thu, 14 May 2026 18:54:37 +0200
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] uprobes/x86: Move optimized uprobe from nop5 to nop10
Message-ID: <2qkbqj7c2bi7li4crheoarasvokrtxbb7ikofdv5zvsvgww5lx@bjd73tm2prfj>
References: <20260514135342.22130-1-jolsa@kernel.org>
 <20260514135342.22130-2-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260514135342.22130-2-jolsa@kernel.org>

On Thu, May 14, 2026 at 03:53:36PM +0200, Jiri Olsa wrote:
> Andrii reported an issue with optimized uprobes [1] that can clobber
> redzone area with call instruction storing return address on stack
> where user code may keep temporary data without adjusting rsp.
> 
> Fixing this by moving the optimized uprobes on top of 10-bytes nop
> instruction, so we can squeeze another instruction to escape the
> redzone area before doing the call, like:
> 
>   lea -0x80(%rsp), %rsp
>   call tramp
> 
> Note the lea instruction is used to adjust the rsp register without
> changing the flags.
> 
> The optimized uprobe performance stays the same:
> 
>         uprobe-nop     :    3.129 ± 0.013M/s
>         uprobe-push    :    3.045 ± 0.006M/s
>         uprobe-ret     :    1.095 ± 0.004M/s
>   -->   uprobe-nop10   :    7.170 ± 0.020M/s
>         uretprobe-nop  :    2.143 ± 0.021M/s
>         uretprobe-push :    2.090 ± 0.000M/s
>         uretprobe-ret  :    0.942 ± 0.000M/s
>   -->   uretprobe-nop10:    3.381 ± 0.003M/s
>         usdt-nop       :    3.245 ± 0.004M/s
>   -->   usdt-nop10     :    7.256 ± 0.023M/s
> 
> [1] https://lore.kernel.org/bpf/20260509003146.976844-1-andrii@kernel.org/
> Reported-by: Andrii Nakryiko <andrii@kernel.org>
> Closes: https://lore.kernel.org/bpf/20260509003146.976844-1-andrii@kernel.org/
> Fixes: ba2bfc97b462 ("uprobes/x86: Add support to optimize uprobes")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/kernel/uprobes.c | 121 +++++++++++++++++++++++++++-----------
>  1 file changed, 86 insertions(+), 35 deletions(-)
> 
> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index ebb1baf1eb1d..f7c4101a4039 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -636,9 +636,21 @@ struct uprobe_trampoline {
>  	unsigned long		vaddr;
>  };
>  
> +#define LEA_INSN_SIZE		5
> +#define OPT_INSN_SIZE		(LEA_INSN_SIZE + CALL_INSN_SIZE)
> +#define OPT_JMP8_OFFSET		(OPT_INSN_SIZE - JMP8_INSN_SIZE)
> +#define REDZONE_SIZE		0x80
> +
> +static const u8 lea_rsp[] = { 0x48, 0x8d, 0x64, 0x24, 0x80 };
> +
> +static bool is_lea_insn(const uprobe_opcode_t *insn)
> +{
> +	return !memcmp(insn, lea_rsp, LEA_INSN_SIZE);
> +}
> +

Just a thought. See if below maybe reads better when plugged in.
is_call_insn can then be removed, I think.

static bool is_call_past_redzone_insns(const uprobe_opcode_t *insn)
{
	static const u8 lea_rsp_call[] = {
		0x48, 0x8d, 0x64, 0x24, REDZONE_SIZE, /* lea -0x80(%rsp), %rsp */
		CALL_INSN_OPCODE
	};

	return !memcmp(insn, lea_rsp_call, ARRAY_SIZE(lea_rsp_call));
}

[...]
