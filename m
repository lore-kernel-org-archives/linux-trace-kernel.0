Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96212DF132
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Mar 2026 17:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767957; cv=none; b=mrA8m4XHcnTIsT4B4td8rn6wG3xtvU2apwjn3p2XAjD2Jz1m/ri4ZgrMsdinXqwB0VOCID/sxo3P5KFBGe+kS7kYByhoqwSEehL2DwwVYhGbMbC4xhmR9FHPG+hbVrBiMz0dE5Z4scrPbUjq4DAxRmjxtEh3IFNU8AjNmRNtVzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767957; c=relaxed/simple;
	bh=2hjbNahnuGBtCGAjVVmPWGi9vjAppdFkWpEZ/Vxf4bs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHnc9j1qljPjit+tQKEM9xUDA7fdX/HOXiCDxNmRfycRAN/aDUgK8w3JmqvqmpRbR83UxDz5UOn32Xcdm/S+YuSWxxoL3VG4kNgb7H8tdSgUuZ4ZofGo1PIq64w1zzp3HW8fgBlnHv05lWkqZcDVhuqEmr5YHat95EZatUmuKNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYaNiti4; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYaNiti4"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48374014a77so66080555e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Mar 2026 10:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773767950; x=1774372750; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KeIlA9ZrszPT24xZdT0RmPKncmN7mk/8Vz4jMnUZCWw=;
        b=NYaNiti4JugbUg0W/O5i0o3HSkG5c+4rTzblAKi3XLgxOYi2hzRlQ7Jn4Sw3L1Fvd/
         Ly9X6JNrD03NTm/2Xzg+3Uy0A6KeWivDXVVpWGR8/44QHkX+EXeqmnj2UGBGQ4TUkzQP
         7NTNuC14AVFAok2HTGKnXoOYvGb9JAnKXncRvaX5ROwae5/Mj8Q70/fS39fu3sVEBds0
         BT1WkKWS3qaDQWZ3+1dFDrOd5s6QS8k5rQuo0a5BwqK0vZgc0Rrj1eomM8yJgKrOB/oM
         mHE9eZnkMUVDAjfrYYFT0qotZPEzi44ezcX+W69NQ9U3B1ueWGtpc5751dhDuw09mG/x
         ZIGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773767950; x=1774372750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KeIlA9ZrszPT24xZdT0RmPKncmN7mk/8Vz4jMnUZCWw=;
        b=PE+sIAnI2wjsIiP0DYhuklxBNm4iY8lv8zbJ27M7sTsT1Pf40Zplyaibi8NR+i2h0B
         gqDp4tgDqXpUOCaqPZkfNDLtQBPVIo1dBdoBDRJKw7mfLBoMby65xQRolLWlG8V2WT3T
         LlasV20amSObe56Nwc16meveKkMM0qtZvmffJoPWXGppx2szuthL4NKBRz9MvuEAAUPi
         HLEBHxxCKzeXssrZr8R1pf1rp1fh2wcFTS8540Xlr/eOrX0bzZUefH2MiEk38yA+8H2D
         GlbhS368ITiB8deeHGrjitWAFzDVqQkuHMs8CnRGOl+v4jMGiyMHehVgj1zc5r+Ii4GD
         jm/w==
X-Forwarded-Encrypted: i=1; AJvYcCW/6amry9HsS6dEJpAtNetQVKmKfnnAorD4yq10NZWSyDFQjX7FX0dmXX8GtQ3wb+f8L/9fCaG6StNs3VoVqd6M/cQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgioVRU50oXxZySKFkGH0Pzlb4G+kaS2wd9BJ8L06daGsBatr8
	Fm3rYPzpdN/z7V+WNXT0SPuGaEHcN9QEpJAYAzOpgJmvPxtCrfARMykw6D9RaEvr
X-Gm-Gg: ATEYQzzI5qN62p3VC53PGpgqjhu0Ujhmi3hgJa98UgXS0I84eJErQ7GOG7jpGkhHY2n
	VamdZbWmRgr39L2Ke9mcM0o9N+iJeA7a7nBYJW1kKy0cwAz44iYM40MEV1irMr8naM7K5n1JcMv
	P2QAK89v/TS5Wrykg6vbiNXuzIXP5fgYF5rJGCLINt7XBfbowSvRcbOZEVXJEow0UllJm3taCgy
	RA0OjF32Er4ygBPh3IhhL6csnDYxCA/DAClPnJLxzESWCfsvQnKIhTL28YSKZ5rk0D8Y4nf3kfO
	Mpqt7F3rVi2PhvVypOyc2mJ5T05Px4vK1OjkGAR/7irnKUuTcv4QH7ygoio7IGcyFYZa2q71MmQ
	Qkiwz6J85Gt56KtbLdwJteaSX/0xscl8i1zUeQtEahRtK4kuFVPOw9pwuvmTEI/3wGXRmXmgS02
	8XClQLKcRMe9x5bNqRrJQmjQ==
X-Received: by 2002:a05:600c:c8d:b0:485:4006:960c with SMTP id 5b1f17b1804b1-486f446b02bmr5174455e9.16.1773767949913;
        Tue, 17 Mar 2026 10:19:09 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856eae3396sm77364765e9.9.2026.03.17.10.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 10:19:09 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 17 Mar 2026 18:19:07 +0100
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: Re: [PATCHv3 bpf-next 22/24] selftests/bpf: Add tracing multi attach
 fails test
Message-ID: <abmNCxhibVFIZMpQ@krava>
References: <20260316075138.465430-1-jolsa@kernel.org>
 <20260316075138.465430-23-jolsa@kernel.org>
 <58218abd-dc9e-4197-93eb-5bd0d6c99863@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58218abd-dc9e-4197-93eb-5bd0d6c99863@linux.dev>

On Tue, Mar 17, 2026 at 11:06:58AM +0800, Leon Hwang wrote:

SNIP

> > +	/* fail#3 pattern and cookies */
> > +	opts.ids = NULL;
> > +	opts.cnt = 2;
> > +	opts.cookies = cookies;
> > +
> > +	skel->links.test_fentry = bpf_program__attach_tracing_multi(skel->progs.test_fentry,
> > +						"bpf_fentry_test*", &opts);
> > +	if (!ASSERT_ERR_PTR(skel->links.test_fentry, "bpf_program__attach_tracing_multi"))
> > +		goto cleanup;
> > +
> > +	/* fail#4 bogus pattern */
> > +	skel->links.test_fentry = bpf_program__attach_tracing_multi(skel->progs.test_fentry,
> > +						"bpf_not_really_a_function*", NULL);
> > +	if (!ASSERT_ERR_PTR(skel->links.test_fentry, "bpf_program__attach_tracing_multi"))
> > +		goto cleanup;
> > +
> > +	/* fail#5 abnormal cnt */
> > +	opts.ids = ids;
> > +	opts.cnt = INT_MAX;
> > +
> > +	skel->links.test_fentry = bpf_program__attach_tracing_multi(skel->progs.test_fentry,
> > +						NULL, &opts);
> > +	if (!ASSERT_ERR_PTR(skel->links.test_fentry, "bpf_program__attach_tracing_multi"))
> > +		goto cleanup;
> > +
> > +	/* fail#6 attach sleepable program to not-allowed function */
> > +	ids2 = get_ids(func, 1, NULL);
> > +	if (!ASSERT_OK_PTR(ids, "get_ids"))
>                            ^ ids2 ?

yes

> 
> > +		goto cleanup;
> > +
> > +	opts.ids = ids2;
> > +	opts.cnt = 1;
> > +
> > +	skel->links.test_fentry_s = bpf_program__attach_tracing_multi(skel->progs.test_fentry_s,
> > +						NULL, &opts);
> > +	ASSERT_ERR_PTR(skel->links.test_fentry, "bpf_program__attach_tracing_multi");
>                                    ^ test_fentry_s ?

yes, will fix, thnx

jirka
