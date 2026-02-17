Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB653128AF
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Feb 2026 22:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771365995; cv=none; b=IaPdNojHg+I6rTWRlXZjoRpstDjRDHvMWzb4JzMpVCWSCZQ9tcenWWohPD/F51rjGUo9nyaGuI1hLiLidGjUBE4opAaRaE7uXbHnhOhPME3ze2t4Ut5TGB8ROjpzV8E17AgGGQj99vSZrHMMN3SCoTfeDc3eO9SCWd0k5oFAO/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771365995; c=relaxed/simple;
	bh=iLTKDJplIA/N///jP/I/KZCo2ro0S5DjKedkK5Fobbk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ng9cAG6R0dVrBRywdjz1UEvh7fi/u6dRwXKe6I5ReOqsPw0+53n/CFmV4MYmvEfgRhhp/mVaGyefeVHsNZ/NilV8YDmkv6pfi1ZR2ba8bhr7RIlq1XNFCng7LzoQ/UefRYkPSJixOWsvR0pikAZLV7FrBt/Cu7ROecCXSfHv6H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejk7m19d; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejk7m19d"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43638a3330dso3658142f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Feb 2026 14:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771365993; x=1771970793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LmhVVGtEtHd9klvOzSTi13AxHzcIE8WkfeurKmZjv0E=;
        b=ejk7m19d8rCt/IU17CSJ4CyLn9auidMN0jHphlhyHKLY9A6o4m82Y3yi0eVT6mbjqm
         8zvlMwZXjlFqCdoZYJ/vFYqndPxAAPiXDgz69jvsyccCjpgMXbvC4R3WvJSesgL5Y6Ei
         zkhXWDZhOC44d9KGk1Fs0YPKHYc2WvhWGN1yhPMPIiQ98NqXuHWlBq7OnInAwpR/5X7H
         m/poo0R6I437dGryn8Pg1qrbNPpBeA83H20VCME9rau2No2jqP7OOXTAmHc4OH74zJts
         emmSPLpis7DNkJ0vWUeHz6ByosSCpNM6hgi2fH68HjB6cnscMAKopUxNFGyQiXqO+Cxp
         hBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771365993; x=1771970793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LmhVVGtEtHd9klvOzSTi13AxHzcIE8WkfeurKmZjv0E=;
        b=s2mD3LFFWXob3Q4M0JEuCX496gk+PYteZECjNzxAVFwRcl8wPzyzLu3XKsYMUixCNc
         Ha0r/sYKz6Q+AGAKmPsN4iJZu5LmkYJCnkzQIkj/KA0RTBY0atCnjr30HwjWyPO6zj91
         Fjxkh3TUNy0SRVZGYHs08BAx9BKFVxytE4FzoQrTHc7SC6lzj1kHRRBvtLyFlNyr2QPv
         K7Pm0B7O1+EceU1Qykpt8N46DY8xgqzPQ3uB2sqsB2pOLwxgq7Q/gkjwue30zMAcz26f
         qJIb/GAMkw71KV/YPmR5wglTdsn8zi6zX1RUyuiBT3mvBjC9bynQBDcu9OoDjwrut3Gu
         3Q5A==
X-Forwarded-Encrypted: i=1; AJvYcCWPZg7hZ7qgNjigDmUkPmkY+iX6cE8OVikehN1wRUT2sG9H7tyJ6hwMDNXEM8wcyCqt2ccp0QUhYVCYEHjAth0am0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSVNSovEEM8SG6B9D1yForyiiSBNj5tPSNXgX+5NczFWleFK32
	uhbTnEeU8OLZTjvau7v2DfYXkhbooiFifgXJ9dZPYiy3UymNoEppqMMc
X-Gm-Gg: AZuq6aJXYw53VNXcmLzdv5fPQf1FEaKROSHwCYCzrcrFbtdSz1s5wUgBIfMuPLxdHQG
	Wn3c//FfF7SAWbpqyuTktAq7FyypU+A3Q8UOtzS4Snndf0xD2gvUbvkRj173VMjN07qf9tT4owk
	dCNaaXeqZUZBWECY41ok/va6z6eF47rK1gf2aZu9eirL96bR0vZvH/9gMazrnCUzETcEZZoORxb
	W/jezujE0DC4U9GjyGal8QAf75zbeOLo+XQ1g/0XRVfYeg3SNmz2wI4vO5gbDm0MD2fCr0P+km/
	f+ulC8vZ7AjIaBgbEBRnPVpUWav0/Iepw+BbQIWc3Rsst9jc9mzyC1X2wWe7EMSabOsgmugXDR1
	wJt8ufUcgus9wcCnMqldjra5XxxvAbc4dFLL9IYfeHiGaaVuS/rhlPiafpyOVcdz5YHpxtO1pGW
	0vN0MYlEfaswTZwkSAZ7ulOTGbeGJvfZWV
X-Received: by 2002:a05:6000:2508:b0:435:8e14:9877 with SMTP id ffacd0b85a97d-4379dbae484mr19903942f8f.60.1771365992585;
        Tue, 17 Feb 2026 14:06:32 -0800 (PST)
Received: from krava (37-188-249-12.red.o2.cz. [37.188.249.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a6b563sm36433461f8f.12.2026.02.17.14.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 14:06:31 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 17 Feb 2026 23:06:25 +0100
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
	menglong8.dong@gmail.com, rostedt@kernel.org, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [RFC bpf-next 10/12] selftests/bpf: Add fentry tracing multi
 func test
Message-ID: <aZTmYeL8wGpLP78g@krava>
References: <20260203093819.2105105-11-jolsa@kernel.org>
 <cd5126aaea4095fde41096caf553d7ab7c42efc42ee2bf8a5897be48a0e66a41@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd5126aaea4095fde41096caf553d7ab7c42efc42ee2bf8a5897be48a0e66a41@mail.kernel.org>

On Tue, Feb 03, 2026 at 10:13:55AM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_check.c b/tools/testing/selftests/bpf/progs/tracing_multi_check.c
> > new file mode 100644
> > index 000000000..e5efa9884
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/tracing_multi_check.c
> 
> [ ... ]
> 
> > +	} else if (ip == &bpf_fentry_test3) {
> > +		char a, b;
>                       ^
> 
> The commit message states "We need to cast to real arguments types in
> multi_arg_check, because the checked value can be shorter than u64."
> 
> Should variable b be declared as int instead of char?
> 
> The kernel function signature is:
> 
>     noinline int bpf_fentry_test3(char a, int b, u64 c)
> 
> The second parameter is int, not char. While the test passes with the
> current test value of 5, this appears inconsistent with the stated goal
> of matching argument types.

yep, will fix


> 
> > +		__u64 c;
> 
> [ ... ]
> 
> > +	} else if (ip == &bpf_fentry_test6) {
> 
> [ ... ]
> 
> > +		e = (void*) value;;
> > +		if (bpf_get_func_arg(ctx, 5, &value))
> > +			return;
> > +		f = value;;
>                       ^^
> 
> This isn't a bug, but there are extra semicolons on these two lines.

ok, thnx

jirka
