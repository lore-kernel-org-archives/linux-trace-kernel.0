Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795471461;
	b=JcEVrksEzlpIswRRwMdsGVdk8+rr1cX1KCeZyWgKVf0ZBbl+X/weURzb5q2Vd7Y3iXUh
	 rl/dBjnfim50w1a8Gu2Ox3/twNiH/ivPHj6vp1tfvIFIplK4FvLoClK+UMTHB6RP/ehEj
	 yKzSpiwzDUOwOivPqBB+qvZhKCNnTigPA31p8rnJypgEGW909H2c/5iQoLzetLieDH0Z8
	 CHnXKqwFhGxlkJOqbPaqpRLnyNRHhpijLIkJEOwHM3c5RezJHHCGgR6hIKiyR+o77E4g9
	 sePstjxO88tnbMqTj9eTib2vIy+mw0uy5RclhdWBp2C/nrQplpDji5rnvfFSL5NcRAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795471461;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2f3F7pReyCVh5ohj9DIUA9RqsDOv9jV9G6uqHApB7O0=;
	b=Jd5/qCQoA97M8yMawFZ/zIQVqO/SkGaspnEjcyHGGH5fXSxW8YQ1Zxa4foeBD5pCF+zu
	 139BFhW+nT23wc75tklPCvVGc4XkAsYkvKxAbQdZDZl/5dsAq+D/5fivjMDE0QiKIOMsj
	 mTWZMAkLLlHWOjLOqtDJLfMxjPloqToY/ssSXwN0aVVleXPlIPsxFxs1IsklT4Y8xZZiy
	 mOgYKh3tXBPcC4FXlX07XkyYDNAexBp0+5D5sKw2rg/IeoMnBsrhXCkF0vrvTFjBqu8Ct
	 YkCcX12mMvtk3FW3XQMesK1AcZdwXFXKvrLanr72gm1166GK+kb3VRqwmJrsghLsdyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wtVnmpzv;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3483606A327
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Nov 2026 22:04:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3483606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wtVnmpzv
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a14so40486915e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Nov 2026 14:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795471459; x=1796076259; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2f3F7pReyCVh5ohj9DIUA9RqsDOv9jV9G6uqHApB7O0=;
        b=wtVnmpzvYZCD0GaLZu5xfru9ELcjZM/X3gc10J+KIN5n8p5arnhGlxvdZtuiEyO+SF
         mXICRZeaJ2Yi+kfmmdhQdJJsugjTetjy6sSEz9ogL2VfZiBVbHasEkV22gWyrwSX/9iG
         gXP5KWXVdP09JEupsR0PUyqFKWnmmNcnY1K6WK4XNiptsVNjkbR83Oe++P10kA8oCycU
         syRoavExVO4TMq6Rf94nzquu91XYDe0jrE3mOWRkel5ldFIFYGjyxM9BnJB5iIqlQKty
         ZwnmN8MZDypLgKC1fNGIYoSh2uoC1c1DYQyWGPsAypQxJiD5h5LhoNSwIqSiXUZTNEJA
         rwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795471459; x=1796076259;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2f3F7pReyCVh5ohj9DIUA9RqsDOv9jV9G6uqHApB7O0=;
        b=BEj823t3VGQ3JWfIo066zzwN3bIGeB+2ecFNibAbyj18Vaw5r4oUaS0bHoaHaolajG
         mH6PEc5hq60+meUauq10TTZdVZLJ4tbdiQvWT3ddVvM2mmhYUWP4pO1TfjJuctE7CjIz
         WYm9o58BNvERvP9WQnK3Dy5rGp4bs5MFKu1HwnuFdc0hvLUjGpmWzrdxZxbiPCVQXqEB
         TvDz9/JI4cIPyz7uy0vV2tAq/Cxc3HejL2vIz4Kjw6ztY6/v5cxv5E2J/AWtXk3ld1pa
         CsWyQvMJY1H2Mdyj8d4FcTBRUg0RZ8okjynH8JnLoTMvoOevAfYdGrA5dYviQo8g3dC8
         z5fQ==
X-Forwarded-Encrypted: i=1; AL+hErH2XfalTtCtQ1KOF2LB1Cx/bs9OrXgZ/CwGWboco7hS/CQNHARh6uXfhZGiqynL6rPt4a/E9zT06yHwqGYEyeMEh+c=@vger.kernel.org
X-Gm-Message-State: APuU4Z9+hhiDcGNU+plxfQ6te09PP7rWulXh/1d+uOI8w1yqbnN/gShr
	FBAtHB5anzRpOe8YkhjoojSLBSyE3RERrleRyhdV6Elyse6ckqYc28WT
X-Gm-Gg: AZFdTZfTfdKWfyykJb0kTOkGH+lB4XEZzanqLPEbn6OJ/+OqP+/CfsKV91QE6fC68oa
	rx34bTTZMPc8z3/pWSIKPqYxaEBeLHNoGuoMntUJPNxRyxRGojvGriyMrPcLIcqBS6L/sGDclok
	fH/CgkUGDBA9o8W8imROBZVXOWF5GqsVbpYwGURHPBYs3cQL+C076yuJQArDyo/vMfoBU7pdyoj
	xTBSDjWpGINc1MPttVqQ/zt/wJXbqwkPVKQaVk4FuoG5yiJnNjm342fvEqNDf07zcHWJoEzzc83
	hcNs7VOQ9U/CLD7Rl6Qn+nglc9BEGU7YzKjOSnKmw5eOuAVow1mB3dt1u+of640361LlRD7sImu
	uEcg7vMZKi3dT37fwgSH98cSxQkRpDBwXUnMCL7TW1SmSpgjxTSOx8lzjluzCa5zd4lxTMxqaVv
	GcqN8FRGkBnJOlHhSwrq4GNprKv2p8mDK/NzOD2zRzCkcRRke386jndL2SJNHPLK+L5yrUL3DYo
	UCVP/l31/He0RVRXHe7LtS6XnFQZMDjVzNaWf4F7762CLzh/tIA3SGdWlB1i2dYZxqRLNiRSoC9
	iq21U1azt8QUzAZb
X-Received: by 2002:a05:600c:1c0e:b0:4a1:ddaa:571e with SMTP id 5b1f17b1804b1-4bb88824f38mr302199135e9.15.1795471458927;
        Mon, 23 Nov 2026 14:04:18 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a1e8bsm324214035e9.9.2026.11.23.14.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 14:04:18 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 23 Nov 2026 23:04:16 +0100
To: bot+bpf-ci@kernel.org
Cc: leon.hwang@linux.dev, bpf@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
	song@kernel.org, yonghong.song@linux.dev, emil@etsalapatis.com,
	ihor.solodrai@linux.dev, rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, kpsingh@kernel.org,
	matt@bobrowski.net, shuah@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org, martin.lau@kernel.org, mason@kernel.org
Subject: Re: [PATCH bpf-next v3 7/9] selftests/bpf: Test tracing_multi
 link_create logs
Message-ID: <awS4YG9LyfxIbE-m@krava>
References: <20261123152743.19629-8-leon.hwang@linux.dev>
 <d3920bd7ae0cc6a941895e00534e8f8818402a673351894d0bf98639272f7d7e@mail.kernel.org>
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
In-Reply-To: <d3920bd7ae0cc6a941895e00534e8f8818402a673351894d0bf98639272f7d7e@mail.kernel.org>

On Mon, Nov 23, 2026 at 04:04:41PM +0000, bot+bpf-ci@kernel.org wrote:
> > selftests/bpf: Test tracing_multi link_create logs
> 
> TL;DR: Test issue: the migrate_disable denylist subtest's skip may not trigger
> on !CONFIG_SMP kernels, since the function still exists in BTF, so it could
> fail instead of skipping.
> 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_link.c b/tools/testing/selftests/bpf/prog_tests/tracing_link.c
> > --- a/tools/testing/selftests/bpf/prog_tests/tracing_link.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/tracing_link.c
> [ ... ]
> > +static void test_multi_log_denylist(void)
> > +{
> > +	const char *msg = "Cannot attach to denylist btf id %u.\n";
> > +	const char *target = "migrate_disable";
> > +	struct btf *btf;
> > +
> > +	btf = btf__load_vmlinux_btf();
> > +	if (!ASSERT_OK_PTR(btf, "btf__load_vmlinux_btf"))
> > +		return;
> > +
> > +	/* migrate_disable is only in the denylist on SMP kernels. */
> > +	if (btf__find_by_name_kind(btf, target, BTF_KIND_FUNC) == -ENOENT)
> > +		test__skip();
> > +	else
> > +		test_multi_log_target(btf, "fentry", target, -EINVAL, msg);
> 
> Is this skip reachable on a !CONFIG_SMP kernel?
> 
> kernel/sched/core.c always builds an out-of-line, exported
> migrate_disable() with no CONFIG_SMP guard:
> 
>     void migrate_disable(void)
>     {
>             __migrate_disable();
>     }
>     EXPORT_SYMBOL_GPL(migrate_disable);
> 
> while the denylist in kernel/bpf/verifier.c adds it only under
> CONFIG_SMP:
> 
>     BTF_SET_START(btf_id_deny)
>     BTF_ID_UNUSED
>     #ifdef CONFIG_SMP
>     BTF_ID(func, ___migrate_enable)
>     BTF_ID(func, migrate_disable)
>     BTF_ID(func, migrate_enable)
>     #endif
> 
> So btf__find_by_name_kind() should find migrate_disable even when
> CONFIG_SMP=n, and test__skip() would never run.
> 
> On such an x86_64 kernel, bpf_check_attach_btf_id_multi() would not deny
> the id, the link would be created, and the subtest would fail at
> ASSERT_LT(fd, 0, "bpf_link_create") instead of skipping.
> 
> Should the skip check the kernel's SMP configuration directly, for
> example through a __kconfig extern, or should the comment and skip be
> dropped?

I don't think we care, but if we do perhaps we could use __rcu_read_lock instead

jirka
