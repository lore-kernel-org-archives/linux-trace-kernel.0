Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A3C3B636A
	for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Apr 2026 12:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775566773; cv=none; b=ZBMJy5IGEiWSYILwe3km9+v79B54tQ3VRUonlZgGYBUYlAYUIP9QqJ6BKRspcZ3KhcZIeJWweqUyrzSMW29o6hEY+wgrWkoXSbiOfhpdGuIj+7rmOfezk2rPtnqNJM3l0dShxiv97SlP7eeEtXREuO78lmPs/vGNRyN2vKcIocc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775566773; c=relaxed/simple;
	bh=Xgt0yKnI3R51jfRlpHewLRsZbOBbN1ll4V1KpUJWSZI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AHjvqpSG4KwnU5CTtrmB6xCnoTK9FZO452WZartHH1Cb9XBjKHM2lWzkvpblzkCabWqQigFIgBnOQ4uAFQyj1UOarene+YkySz74PHqJJRSIRtcS/BXko/WnwUn8xLZUmJs7KX+QryiR/GOhTzoY2Z9hy7JGHyZcxY7ECeGl9Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSmTs+G3; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSmTs+G3"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43cff5dafc3so4394580f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 07 Apr 2026 05:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775566770; x=1776171570; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RF2eQ/e3Z+XWoNNXFRS5Nhax4dGCTs+V8hdOEp9z2VY=;
        b=FSmTs+G39Er3O63YqgSNXUAQ6zOrrylO0kBEbasKqcQFjI3KWxqeiEHVAfLawUanL2
         bQVTgu6xVDqlB21+m4oVtqS7T/hpXtu/gjna4yhjYMJGHGxXyBn5Y+RDj+QZRr+vsPFB
         aWhizCjRC7LEyFXl94ZKyJMHj8yFUL2UeOzW6fCX5pHRT3i8xyISYmDh+6kuEGsf/XVA
         NIegkCxBlzhfppERcR1dWt0xoe50qvrMB70pQKf65aKBz2F7xzY0xSKpPRYAZlDtEmic
         eKK/HzPQLDm5AErB+FSBuPxKN1frJAfcijYmG0KKeqrpw5mb3DmUimfbPiNNXTOEoP21
         19yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775566770; x=1776171570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RF2eQ/e3Z+XWoNNXFRS5Nhax4dGCTs+V8hdOEp9z2VY=;
        b=MneGSEt9dTQd7wmQDPwUTjs//RMLg5Xx8PjPkS8lu/tFOJ7mHYwap2diWxzlXG6nHy
         LnXDMCkf7Gr78U4t3lu3S6/Eb0eqJxhuGqmR7H1gxI2CTeSZ6v+bbmUdDhcalWaiBJS9
         mFC0FIIx6Fvqxgs0nV2+xow5Pq3iHhyI72I461MsMeFFb364H4ukBiDth7NKXN5jp9HG
         tmf6Xldy2kist65URn1CTMIiI0xzLhckdv3r8gtowmp0eNrIcpUDdmkJsisOE+FZjy3+
         gc+VwMGuxDBDlenznqcxAgjQLJDNbLpoNVs2qp5u3mRtFHCNEgyQIOQOkaPhKc3UjbCc
         gCWA==
X-Forwarded-Encrypted: i=1; AJvYcCXlCP10vPRuHv2DPwl2JYajxOkyuX5XY7vIpCWZ3Dk/2FZuvDGq6iknqOX+GgUh2xdws3KGBcyrNRHDuMJjeYJf1F0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZYtkuAnXTcVJ1l7S7uPMiWsLD67RVvOmkaf6JHvjWKW4xTjT+
	ETYMdm+yHvUI3Q3RoiCyCkPlQXeu3ipt8H6Vjbn2ttwXifUfZDuhsLgG
X-Gm-Gg: AeBDietbmddQkXHmC3rdgGjDUBB+HD8cth1q3kXs3kgR+8GWzIPd2n0dwRjpiPIKzBQ
	n0z/FYo3wN5ODh8Tepf7qKXc05SHz2swNTYQG9enSN8g7Ix+qbJcQ5CY1dF0jV7gR4d1QSfZNqv
	7PknWRbcfAYufnEIh7zWZNAsqn2VG+i+B3quXbyCsFqEEG7HynobQQ4aBeZ1b7O3fP18XRzSERF
	bxVp6TmOIEfS7mKhLQ7EPHtNiLcfMgwzOsWCcTv5F2Qcdxt8NHFSOBNchxGBJwLfMslQXHPe0WC
	FFfgXCkqFyOACWNUJaatW2YQPrwfZ5c5WvS6JUi/vnVU4eKjJQG3el2ZnQ2xdBvpq/WEWQPlzlO
	ZoFmvXru1sfN/Ix57ZuQ+sTKNdqCMYNRfeODlZ5/nFypowXsEvuNcar04VCoBEtA3Q4V7HKZImC
	fvnzgKuasQ2y0XeszKlJrlCQ==
X-Received: by 2002:a05:6000:1a8d:b0:43d:3ce:ecc1 with SMTP id ffacd0b85a97d-43d292e2501mr22709595f8f.43.1775566770076;
        Tue, 07 Apr 2026 05:59:30 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4f52easm51273781f8f.36.2026.04.07.05.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 05:59:29 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 7 Apr 2026 14:59:28 +0200
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, ihor.solodrai@linux.dev, emil@etsalapatis.com,
	linux-open-source@crowdstrike.com
Subject: Re: [RFC PATCH bpf-next v5 1/2] tracing: Prefer vmlinux symbols over
 module symbols for unqualified kprobes
Message-ID: <adT_sBF_i_6oedFe@krava>
References: <20260406193158.754498-1-andrey.grodzovsky@crowdstrike.com>
 <20260406193158.754498-2-andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406193158.754498-2-andrey.grodzovsky@crowdstrike.com>

On Mon, Apr 06, 2026 at 03:31:57PM -0400, Andrey Grodzovsky wrote:
> When an unqualified kprobe target exists in both vmlinux and a loaded
> module, number_of_same_symbols() returns a count greater than 1,
> causing kprobe attachment to fail with -EADDRNOTAVAIL even though the
> vmlinux symbol is unambiguous.
> 
> When no module qualifier is given and the symbol is found in vmlinux,
> return the vmlinux-only count without scanning loaded modules. This
> preserves the existing behavior for all other cases:
> - Symbol only in a module: vmlinux count is 0, falls through to module
>   scan as before.
> - Symbol qualified with MOD:SYM: mod != NULL, unchanged path.
> - Symbol ambiguous within vmlinux itself: count > 1 is returned as-is.
> 
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> Suggested-by: Ihor Solodrai <ihor.solodrai@linux.dev>

lgtm, kprobe_multi seems to behave like that already, maybe you could add test for that as well

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka


> ---
>  kernel/trace/trace_kprobe.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index a5dbb72528e0..99c41ea8b6d7 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -765,6 +765,13 @@ static unsigned int number_of_same_symbols(const char *mod, const char *func_nam
>  	if (!mod)
>  		kallsyms_on_each_match_symbol(count_symbols, func_name, &ctx.count);
>  
> +	/* If the symbol is found in vmlinux, use vmlinux resolution only.
> +	 * This prevents module symbols from shadowing vmlinux symbols
> +	 * and causing -EADDRNOTAVAIL for unqualified kprobe targets.
> +	 */
> +	if (!mod && ctx.count > 0)
> +		return ctx.count;
> +
>  	module_kallsyms_on_each_symbol(mod, count_mod_symbols, &ctx);
>  
>  	return ctx.count;
> -- 
> 2.34.1
> 
