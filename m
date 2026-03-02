Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037E636C584
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Mar 2026 12:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772455683; cv=none; b=JPwqvXGqn6rTl9iLqe3XLhTarsuut4HfgU0ExgjwtImRegGdDoI27dPOKB3lmMPIFcxICCuU51sbs3Lc11pm6ki2Lhy8eFjtkvQ/X1hdmUqDBfYHRWNU1OeM+G8vWgREfTy4+QXhePBnlXIPtqbjCtHI0oT95sQOkTgShsAA2c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772455683; c=relaxed/simple;
	bh=JL4hQqeLTFjzlqk852iwfOZherhFARRk8CEpPAk/9WQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PaJ/34EZjoccBhl/GZVYPR7PwIcXfsCdiclsdd/b6uhcPFYytrXHb/8N9x0b3KczNRaO/f/gQj+5Wddy3PquTJ8ZcPUe9ZAEdE0kSEudTlvROi09FkX2lYIIPI2tWYTEo77m5Yi1ezTYq3uAyHVN5S9jdbBs4kJ5nFBw6aLc3Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=VWfr3gcg; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="VWfr3gcg"
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-65c187dfc82so6941053a12.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Mar 2026 04:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1772455680; x=1773060480; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JL4hQqeLTFjzlqk852iwfOZherhFARRk8CEpPAk/9WQ=;
        b=VWfr3gcg1h2P+grbhyickrNSxqWvlN2tcdp0qwI+150ew7nDPjkjOnxI+gbEv2omrJ
         Oy55ayIezSYorbOiCPBCINQaRhiELC0SPZDAUidducKamVoehNdCXjM/gezD1I9vxq5b
         xlfixf7iNrF9WQzFK4qrPM+sVbi8Bq56/VVcyjS77hBTHazSLIVQZVfZszyNGu1f8lzQ
         pakL3/f2cYwejI3W+qVYr7g/TM/nJ611w0AmWXb7cjj1PlstJSBgGmYoJeHeBFqplxHL
         eApAzzz1QIfrOL//pdeCKV9j8PQ7QCsgUUsyNLiPa8XRc283kmRtTDbWxuGLnSvhipZI
         RM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772455680; x=1773060480;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JL4hQqeLTFjzlqk852iwfOZherhFARRk8CEpPAk/9WQ=;
        b=myDOZirg6sIF4SsVqaROGXBdjlghbIS9rf+7DphUkH30lJmsJvSA7tDZlVukSoJUMS
         6gZnG6rWyVQGFg5jiJ5BKYr0PvTFBzD1OYgvMNT0ob+IMJol1NPJnj02/8FUFtjaEP+y
         EVn6ZvAezvjUPvpPaWMAaF9ir528Zo9Qy8vmdcpR+5wg3hatNEQ0NdGk++lBVMoCNOmy
         RxyuRngDTdTq7LQhxGySXi2cGGem/0hgDrXfDCq8Q3lNE+TXuhEFqnwxVrC+ezyn+kfp
         cm+G3j6Ux7KridKnOzCwNukGboNHJBggIDjeMyuZpU8s++NUehyd8fWTMjALP8MHYTT3
         dE/A==
X-Forwarded-Encrypted: i=1; AJvYcCUji5hD6vEDV2V4qhClBYyr+s8YrAl5fEcIsTJy04yrtxJYMif8B6elS5a6EvOYojxcdIaBA5dxAqrE4W5vIos2Sdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlXnL6L0TepMeRx4PUdJNYt0i7JLXgGA6+mcT25lDndWHvkVw5
	2Rv5VA/c2qPpwMIfOCHzgVpjujyJrr3U97j8NUHlKaTZech+ZYYYZ3V53Iqbx98D41E=
X-Gm-Gg: ATEYQzzoRIu/FMgKMBobd4XP4RwBXujHMNNxceaiwavju3/SQUyzmeMBXJWNnT3M3RJ
	ujHAnRpmMwK/lAlGjCHK6c7Zd+ZZIA61+OofNiMq1wQ93APVSjd8cFDTR4vbJoBZtgT7xvS8LZ1
	7iydwEOf6SKuGv+OgMf1ttO9GSkIJL+/G+jvGyhsFZIfVSRYLjcNb9l2uWOR2/pbuPhilOFM9Hu
	hNfdEEwAewv3cSkGoUnMyG/M1fX3S0ZHtKFLekxBFZt8R0jDpU8E+FTMd+r7NL2G6fxNGBxpeNx
	QYwR1vk6osLcaiFA7yocB2i7SP0hrypLPqci48ff8vwLzQrMzsXe62xumi7L0+lSy++/85U+pwm
	sv9KZi5umQISCjJ5lZAagINeFqtlRYwmtlBy07hZs0VCCAUAlHV95dR6m1yqGXoSIsvUdoxUNV7
	ceBK3qNiCvmhptg1HUx840aj0/kDQ6cGsov3gKHA==
X-Received: by 2002:a05:6402:3508:b0:658:cb40:6701 with SMTP id 4fb4d7f45d1cf-65fdd6bdb3amr6897694a12.7.1772455680311;
        Mon, 02 Mar 2026 04:48:00 -0800 (PST)
Received: from cloudflare.com ([104.28.193.185])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65fac06e48asm3422175a12.29.2026.03.02.04.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 04:47:59 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: <bpf@vger.kernel.org>,  <linux-open-source@crowdstrike.com>,
  <ast@kernel.org>,  <daniel@iogearbox.net>,  <andrii@kernel.org>,
  <jolsa@kernel.org>,  <rostedt@goodmis.org>,
  <linux-trace-kernel@vger.kernel.org>, <kernel-team@cloudflare.com>
Subject: Re: [RFC PATCH bpf-next v3 0/3] Optimize kprobe.session attachment
 for exact function names
In-Reply-To: <20260227204052.725813-1-andrey.grodzovsky@crowdstrike.com>
	(Andrey Grodzovsky's message of "Fri, 27 Feb 2026 15:40:49 -0500")
References: <20260227204052.725813-1-andrey.grodzovsky@crowdstrike.com>
Date: Mon, 02 Mar 2026 13:47:58 +0100
Message-ID: <87o6l6e6td.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Feb 27, 2026 at 03:40 PM -05, Andrey Grodzovsky wrote:
> - Patch 1: libbpf detects exact function names (no wildcards) in
> bpf_program__attach_kprobe_multi_opts() and bypasses kallsyms parsing,
> passing the symbol directly to the kernel via syms[] array.
> ESRCH is normalized to ENOENT for API consistency.

FWIW, Ivan was also trying to make it faster from the kernel side:

https://lore.kernel.org/bpf/20260129-ivan-bpf-ksym-cache-v1-1-ca503070dcc0@cloudflare.com/

But, IIUC, with this change we're not hitting get_ksymbol_bpf at all.
