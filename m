Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6093B2DF132
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Mar 2026 17:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767917; cv=none; b=iggUHvanHA1BaozSHD54Q7VVeaLeDWSuJMtNw8JT00Y+jmRyKemMOsakjeETPFsUEQwoLh12H24f7p+gGoHCySXjNcCVd7SmwLvZ+4RtldbWonxzO4bNn4lKnq1IZWdAJgvDGbYHEENxy//z8wWJ93poo7Cnbh7MwfwIukirAyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767917; c=relaxed/simple;
	bh=JxFonNn25E7MJwXH2RFIoMLNotu2AvqxFyJi6Ff2fgI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eeAe/yXv7HDM0pISSceJIhp8VKB+vRs3HZFKl3O+KpiyfFJ24JQwlD4pplai2yJU5vwmpQuO3aDNGO5reiD4+cukcQNgerTGpUqa+TdJKe3Z5dELPg0LKFwbXGbgp50smorNy8K4aHU7DYYHh4CSA+AHiEyBKmBxPcH8thRtHMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtVXtJU0; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtVXtJU0"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8cb3bae8d3eso604449485a.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Mar 2026 10:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773767915; x=1774372715; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zbEuxmyWYaI0lRAPrAH38Js2gsSq0wb5jUj0cHJDWRM=;
        b=GtVXtJU06eDqriix1TXQBUzsP1Cr27ZomOZ5nMwQ4qfpLiDxWmkAQ3NnADKEFiDqkC
         Ahb0dx4lsCtw33CRVjfLHpkR23h4O+o9CBfhJh5d9JWJQuuqoWOH0yVfgoT8y9yE6/6G
         /tgsaZgSsP1rXjMU3yLEg/XVIwjsLj507d9mIQ4AYpoc2xNSHVTRzJIOwJCvWAsN9We8
         +/Hs0wBm4BvFqE/xLkuh78C5gbZjBVGQzTeUmWD7PCYOvd2DH3OHA9tCh4e5Sw3c0+de
         cbyNAYeQrjRmMunNd4grmsIUHvlF3mZuRy1fM0KsHzjEK2uDnMk3EiLYqXjBvyaa2nsD
         VTqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773767915; x=1774372715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zbEuxmyWYaI0lRAPrAH38Js2gsSq0wb5jUj0cHJDWRM=;
        b=ApWSe0KRmzujU0masMO4/DHFkxtet7McXY5wfOQP05O6WwXN2bfnvPANnI6mK7XLri
         v1QZbjZDsC/hml7TrYzf1AGs5aNHbomexq7VYwvCJNoe9AOM2m6lff8iwzExXRoAE1ym
         hsZmHcTZt5/mA0gHibhYzgkzMf4+83gVdcM9yz/gV33kV5aswMNNRuBIuKa+JFNh49Eg
         adO4lJbRrdE05C1Vb9ShPrMtAbALtncZHx+kUvxNLuMgllaLFb8v6Ui70GY/qKOE0+jM
         vbk/vF7vSxJz6jRRuEK4LuOEImtiQW9O5da7aVbQNqjXfX7Q5rVxXgeIAEMhufmKt7H+
         Euzw==
X-Forwarded-Encrypted: i=1; AJvYcCWTru2enpcAAcWL+kWJ5L4Kbjyp2vtMlte3+tDYUbIl7n03gLYBC+IRB5zB/XVEUNYGWk7sUv7Hy3dM9wnstczRGHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLCu460Eyw6xdGjqe/NNc76zyCG3BQuOtVl7FYJytroOSQ/7KU
	wAelP/d9Hhck8928w8i+IewE1Fz3CkeK8F0f3JOQ24Zquw20bUZ/vb8D
X-Gm-Gg: ATEYQzzSVz+I/4V5v9enQRAKAtXG+7ZRwAp5xC9dusLnz9fAgHTHq/B7GMWMdS7bmVJ
	iXQelQiQJtx3GrPxrp0iAlm4V2B7+k+sVWQBRxHihB2AvHxAy1NVbp8sMKubDUrc/DAFJVYdmQ0
	zMl1Ba1Fkdq0sCuS8svQ5ro2kkJl7/fQPFUQnGcEqxae5fOUpBiDcx1i5TOjdaruLv+9jd77bsi
	rtGuFvShAlC0IsiaJMo0AiHQcOdnmm9eqltXCcmBvwoc3ROdr18EFedwx6HcB9X2ma0Djl1Qvbj
	WRPgK/FlpvoHwh5RV4kozkO/b+6wCENpWkK9Hs43Chgqm1+o0yXrvzjHfn/JLQB7pYbDKYNG+0D
	9JtNeOa77LWbP4zUhfPX8gDN9+823p401/uCzGKtIWMvotWe8Qw+RKCNI/mDr1D6B9FYKkfvt2M
	QINNdKuPqC9r4v58zMovDA3Q==
X-Received: by 2002:a05:622a:146:b0:509:2222:4202 with SMTP id d75a77b69052e-50b149046demr408331cf.71.1773767914098;
        Tue, 17 Mar 2026 10:18:34 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b13489f93sm4913381cf.4.2026.03.17.10.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 10:18:33 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 17 Mar 2026 18:18:29 +0100
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: Re: [PATCHv3 bpf-next 17/24] selftests/bpf: Add tracing multi
 skel/pattern/ids attach tests
Message-ID: <abmM5csLgQiQz3Xa@krava>
References: <20260316075138.465430-1-jolsa@kernel.org>
 <20260316075138.465430-18-jolsa@kernel.org>
 <39113fe0-2e9f-4f11-afe9-efb676a48149@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39113fe0-2e9f-4f11-afe9-efb676a48149@linux.dev>

On Tue, Mar 17, 2026 at 11:04:57AM +0800, Leon Hwang wrote:

SNIP

> > +static __u32 *get_ids(const char * const funcs[], int funcs_cnt, const char *mod)
> > +{
> > +	struct btf *btf, *vmlinux_btf;
> > +	__u32 nr, type_id, cnt = 0;
> > +	void *root = NULL;
> > +	__u32 *ids = NULL;
> > +	int i, err = 0;
> > +
> > +	btf = btf__load_vmlinux_btf();
> > +	if (!ASSERT_OK_PTR(btf, "btf__load_vmlinux_btf"))
> > +		return NULL;
> > +
> > +	if (mod) {
> > +		vmlinux_btf = btf;
> > +		btf = btf__load_module_btf(mod, vmlinux_btf);
> > +		if (!ASSERT_OK_PTR(btf, "btf__load_module_btf"))
> > +			return NULL;
>                         ^ vmlinux_btf does not get released.

right, needs to be 'goto out'

> 
> > +	}
> > +
> > +	ids = calloc(funcs_cnt, sizeof(ids[0]));
> > +	if (!ids)
> > +		goto out;
> > +
> > +	/*
> > +	 * We sort function names by name and search them
> > +	 * below for each function.
> > +	 */
> > +	for (i = 0; i < funcs_cnt; i++)
> > +		tsearch(&funcs[i], &root, compare);
>                 ^ tdestroy() is missing to free tree nodes?

right, will add, thanks

jirka
