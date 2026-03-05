Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4958E1A6819
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Mar 2026 14:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772719282; cv=none; b=rRBE7/71vP89pniULSwBGTum8kXZYjFUrO6FMh09ZNHWd0brbfwboZRH5OwARY9q/TBvYnD4m89ddwz0cZNDtGvliCNlN3JXqq8bMpvKpOfXV45GlYikYOKd57OKAWM7l+wDsKn8+zihnoz8Iah1gLZaOkSC6zvAl/VHPn/CR0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772719282; c=relaxed/simple;
	bh=r0AUboPD7siAciA8qX0Q5aEf8EMQYzUhHAaXERGo4cw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rP591xLQDKJk3iRmbDfbRv8KbK/CoPCwCPHkOv1DRvRxh5PvIzGvZdIi9gLizjytFt++VDpCCmBtnTScaxhby+RUBLl4AOX/80swwfF9fkSwzPcmzToY+C9/pid/0Q+5FAIapC7a18oG+cztxOsy5n2tk6pRWmzQ9RHbS8+oIi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8Q4TVlM; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8Q4TVlM"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439b94a19fdso4276416f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Mar 2026 06:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772719280; x=1773324080; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QLvBiBWzeZrCuHWYQT1BfKFZEwcwKUCQ7j4Ug6sOub0=;
        b=Y8Q4TVlMvZCGTImKP8HZO1iOLxrwdsPg2iGssjV8Ih6l93bsfui/5ijg6F5kFLWpNK
         Iyd5oyybclnY2l1WxLf5tPGkDXQ/qsyIDcpbqP6iBOta3N+QlRiU5GlzqgeYwY0YVfyp
         HwwdiGE5ignaCekHv+hwsDbTV0U0bQzg4tvPAGJ0RYDtrbi7QZEWd8WYP2j3b8cYhmrx
         cFYRuVsjPD/YDW6eoS2RXrOHH4OebMz3FPb4gg3/mcm1b5ZnopHEKf64cgEA620gDUkG
         jXhgGhvaM0ml0DbFEIlL3O1jKX2/JTVOyWbea+qZxXnn7Vprw5n0vGs1ZC7lrxcugDYu
         L97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772719280; x=1773324080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLvBiBWzeZrCuHWYQT1BfKFZEwcwKUCQ7j4Ug6sOub0=;
        b=PBDsQalNWOYxGRaHd2X4JnnEmh3Auk4EIEYznXfbV+UwHGo3f1yk45kDUsEJcT+RHe
         MjFEEgMKoC5X/Wn3BxvTLONKplIkF4xtyGjCtk8+1yu5YDsX87ORuAiIIVc71tHqgrrm
         Dy8fkkzMnqoEcu9nmSdy9jPBfq1CrT6jimBOiJuV0Fgj+8lgngIbsXVYc2+I1j5cKnH/
         LQ7FELmtkdsB5E7FrjD5sYEk5B8Wm5drFHtf41DEUOyyQ69zPdBp6v7H9ec9AwgcHzDa
         USoDFcBeMZ3C6Mee2HXuWozAOQRInf2hWfqNFqI+BWOZQzWsdKeozflbgNghUp0cr1+u
         VMyw==
X-Forwarded-Encrypted: i=1; AJvYcCX2yERJ3H1tzH4FSO0Wf19+8hCqZQcj2Qq8HlD62hmK1aISIGjfKGuaNkpUL7g4yD23S4W9LkE/4BYv/EfgPUzt3jQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi32ue6aQJg6/Jxjp0Tk9ut+jPPv22k2esiWNuH7jf440GEw11
	QOMT8TagfgXyPH9S9CfJutpnCHrpEyImAzt5g8tAzGsw1sQMy6L/eQAy
X-Gm-Gg: ATEYQzy0Emzp9iEPZ/rPG5gxY2nNHh10b91x7Qed1H6PvObRjG9lmGdeDIavwDXJiFS
	8VuneQFd88MfyVCz0CmTZJSoKtpcVnIU1YfolT6ddOWESsEgje6FzjMm1NSRvQJVjX3QJdZ5/ku
	Ha2aRGGKnAOJvRNRxOfWkQKMkOpdLID4gUYkAuWqxv5BnyKHT3lk148vXGht7UV9ft6mhFTRnz8
	PC6Rmv+CohS+6nSnKHqHE1IKhnqG/9oZRTzFTvB2vH+Eh89UgS9oa/JyJIjwmjqONP71nU63VEa
	6pvP+IblgP5x0MHItwgGJb9lQAEQZeJFRYH8ZZOkXn3SgFPJD0h+pVXiVmD7p9+D1x0F1T2Ksp3
	hWzF5zG2UmOLayxVbNUXHVvOWKhi5Y2oiCk8F/W4Ws6MmSZcbArLpTXZ3xKNtdY5akO3K5OZr
X-Received: by 2002:a05:6000:1847:b0:439:b636:1fa7 with SMTP id ffacd0b85a97d-439c7ffd017mr11726354f8f.54.1772719279156;
        Thu, 05 Mar 2026 06:01:19 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b1116698sm37691451f8f.16.2026.03.05.06.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 06:01:18 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 5 Mar 2026 15:01:16 +0100
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: Re: [PATCHv2 bpf-next 22/23] selftests/bpf: Add tracing multi attach
 benchmark test
Message-ID: <aamMrKQOuNdlptyL@krava>
References: <20260304222141.497203-1-jolsa@kernel.org>
 <20260304222141.497203-23-jolsa@kernel.org>
 <30ebc83a-8f17-44fc-89a6-037e826f6c70@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30ebc83a-8f17-44fc-89a6-037e826f6c70@linux.dev>

On Thu, Mar 05, 2026 at 03:30:01PM +0800, Leon Hwang wrote:

SNIP

> > +/*
> > + * Skip several kernel symbols that might not be safe or could cause delays.
> > + */
> > +static bool skip_symbol(char *name)
> > +{
> > +	if (!strcmp(name, "arch_cpu_idle"))
> > +		return true;
> > +	if (!strcmp(name, "default_idle"))
> > +		return true;
> > +	if (!strncmp(name, "rcu_", 4))
> > +		return true;
> > +	if (!strcmp(name, "bpf_dispatcher_xdp_func"))
> > +		return true;
> > +	if (strstr(name, "rcu"))
> > +		return true;
> > +	if (strstr(name, "trace"))
> > +		return true;
> > +	if (strstr(name, "irq"))
> > +		return true;
> > +	if (strstr(name, "bpf_lsm_"))
> > +		return true;
> > +	if (!strcmp(name, "migrate_enable"))
> > +		return true;
> > +	if (!strcmp(name, "migrate_disable"))
> > +		return true;
> > +	if (!strcmp(name, "preempt_count_sub"))
> > +		return true;
> > +	if (!strcmp(name, "preempt_count_add"))
> > +		return true;
> > +	return false;
> > +}
> 
> These names intersect with the list in trace_helpers.c::skip_entry().
> 
> It would be better to move this list to trace_helpers.c.

ah right, will check

> 
> > +
> > +#define MAX_BPF_FUNC_ARGS 12
> > +
> > +static bool btf_type_is_modifier(const struct btf_type *t)
> > +{
> > +	switch (BTF_INFO_KIND(t->info)) {
> > +	case BTF_KIND_TYPEDEF:
> > +	case BTF_KIND_VOLATILE:
> > +	case BTF_KIND_CONST:
> > +	case BTF_KIND_RESTRICT:
> > +	case BTF_KIND_TYPE_TAG:
> > +		return true;
> > +	}
> > +	return false;
> > +}
> > +
> > +static bool is_allowed_func(const struct btf *btf, const struct btf_type *t)
> > +{
> > +	const struct btf_type *proto;
> > +	const struct btf_param *args;
> > +	__u32 i, nargs;
> > +	__s64 ret;
> > +
> > +	proto = btf_type_by_id(btf, t->type);
> > +	if (BTF_INFO_KIND(proto->info) != BTF_KIND_FUNC_PROTO)
> > +		return false;
> > +
> > +	args = (const struct btf_param *)(proto + 1);
> > +	nargs = btf_vlen(proto);
> > +	if (nargs > MAX_BPF_FUNC_ARGS)
> > +		return false;
> > +
> > +	t = btf__type_by_id(btf, proto->type);
> > +	while (t && btf_type_is_modifier(t))
> > +		t = btf__type_by_id(btf, t->type);
> > +
> > +	if (btf_is_struct(t) || btf_is_union(t))
> > +		return false;
> > +
> > +	for (i = 0; i < nargs; i++) {
> > +		/* No support for variable args */
> > +		if (i == nargs - 1 && args[i].type == 0)
> > +			return false;
> > +
> > +		/* No support of struct argument size greater than 16 bytes */
> > +		ret = btf__resolve_size(btf, args[i].type);
> > +		if (ret < 0 || ret > 16)
> > +			return false;
> > +	}
> > +
> > +	return true;
> > +}
> 
> NIT: can we avoid copy/pasting the code snippet from libbpf.c?

maybe we could make it global and use it through libbpf_internal.h,
will check

thanks,
jirka
