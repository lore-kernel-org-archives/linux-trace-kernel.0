Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216DE3D330C
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Feb 2026 16:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770136456; cv=pass; b=B3Np1+skG6a9L9X+XJw1IqucA9dRjyI0wFUt6/JH1ZiQc7TwoHVVFcHBqmjhfoLEA4105olPbjFFLWhCl/Wincmo/2XOyb0RGSbDRvNouIfKGiwzs+op/mZNEjoJbvxICtq2UA23u7TFO4Ba/qHJeehS/WcrnbZFrk5e5kmTW8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770136456; c=relaxed/simple;
	bh=bmwS02O7Xi0i3LCtAbnGeK3EdgJru2Z2vrI/HUuqlh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rJMCUiwIMX2+rZjCU54EYh8KLQC68iIfySm4othksUnicpmthTwAxq4FjajL/msnV4sVdtvNACu5Nxa/dEuUcPIwBHlWWoShrbKmFhjpPXESx5HYDqkyt/E/oSYh0nw2zkppkxQAgdeDkD5F2uBS+DAZQkDeb71NEiTvF2MjOw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROKiYh3y; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROKiYh3y"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42fb4eeb482so4048558f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 03 Feb 2026 08:34:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770136453; cv=none;
        d=google.com; s=arc-20240605;
        b=HzEcZuL8GbMgtky6tVGS5VVCmvxWs7VoDDNn03ZDMCjdUNghP3Jme9tiNxqFxvw6Jl
         FNAhll9hWBLmJhOrZhjkri9jF3Z405x0IIZkPf3oQXlJuuJ3m9VCErO6Kqns5O+cAeNl
         P/zG1Mz+QI70JofCfLg7M39u4r4iJ0JyAKfx7zIEGyUANiEy8IMyjcSjPQy+ivYIo21s
         1Vw+FsqpCX29h2ccQjGzwUpogVa0RTqTfIVRVunjerxw6MXo4cbGyjQCOLKsZPWwlOpy
         MOe75ORA0CXeCHMpuoxFfVlXWafUP5dKJT+G6BINll0T7BfmpjXt8f7VqUVBKanryThM
         TssA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Nf1oryXgAVHjZvk/1Ujit1GezDamlVePl/4411gfaKk=;
        fh=jFizryEhoknceBGOTsEuoKAKtJ7Ax/uc2USxgz1aPQ0=;
        b=b9RYDoKNXImpYpneuJJPfiKK5PbiaR2wMLZ23KB+3tbBLzNTKgyiCbIaWpGNMLbc67
         WTZ5IwZp3Lvxvey37HzxUxeTxyvNkw9VkYA/BzgHPtuWwvJUHlcIdVG9Af3QLZZVrkQI
         yFMkDO3gkqZ3MBP604MJD/OQrm0mjL9VZ1+h3PciTIzz1G6umcPXbsfJcQRyCDWnZ210
         IzRjiBLn7/3WMK+qQPUKudo5z0wWK+s2yA5XIfzlD4pV0k0eSAirk3YkpxkRbD+TpBxP
         vqAIcjLp0wHsuD98+KFx4lpnXRqgBBO4YuVAHuwgcSpz8Ws6xHBhmMTdkcNb6s2kE4Po
         8rBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770136453; x=1770741253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nf1oryXgAVHjZvk/1Ujit1GezDamlVePl/4411gfaKk=;
        b=ROKiYh3y2/wez35sE3CtMZsUKlRfWEg3t15YY1aBUgmt+LbSguUMsRFV/kzdfi903D
         oGleb9H92ZHdDmm+ID3MluINwkVZReEfdDgulbme3JKKyCKjUBkIlP/096rhCI1jpP9O
         AZ5bbIxydTsglt+acNCaSW+xO8hzAq5HXfbi6WPJ3isORrxe4H9hs6tLYn3IQTwrzio5
         hgf25je7OE+NGjIzXKUsK12CrOtWNKp8mcs29EOIP0/8gfndW1nc3w1cPBVyiArh+feJ
         +zwdmAVTgt9VsVP8n1FDCLDbDJNwkiGrPZB3lJUtw3n4heOf8IHTk86PfdQfbkJm3k7d
         9rIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770136453; x=1770741253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nf1oryXgAVHjZvk/1Ujit1GezDamlVePl/4411gfaKk=;
        b=oVnrSIWg1nA8RGUZu5qiwkhs5vFSg/9RlnS6c3mRmcKyMAYYgiZdNtT7bymeeBZoYs
         o72ECn4fPM4hLAxaX6NY/tvqXbLUAlextJyIdSDwF+Gw+9OG6pNWdXfAkLfQ1QpsMWMr
         3BNTDIQ6TPWhYX59GuPg959VivFAPgYVbyvm2YNTwIpLHDPnME7YkhbhT8I7pfVPKFYO
         VGWamcqoe1QtVLRpYGRyquTrWKXp/Z6C7d3gosTpuoLSNFGlKtJfSYaosQe9jZytYdJv
         NaH6zXie0akk4J+dpnNWsNbuNhj2MX0IqCebaQ0mI8wyyoVSl1D8kDvf3q9oc336tWM9
         6xZA==
X-Forwarded-Encrypted: i=1; AJvYcCXUwKZ+Leq7TjfDoUIRWawYZeZuIICSKmmhN87fO3jwd6JfLNcjIwx2y/AQsJtcf06YN8+aputTGJunAxnnbdP5gs8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvx2IZdmXu9SDzhxUxGshrrGdI7REjD//wukQj6XsJ3n+HFXEl
	E8j5jcx1MPifXPEuQ4VYdUDEwDspyQEmKINSHKgbHeP3KrHHJEZAq6JkQTbd5OCwKUPq5BIN0fl
	jWjkKxWJi2xJiwXGEhRUTWoEqRU8VWsQ=
X-Gm-Gg: AZuq6aLJ/VCaVZ4GIb6W8ZP97dJdNHc7f0SK7k3n2oPnhJKLmRi2nj4BjTeArBG+5eY
	RWx54Rdnkg4o6sJ1+VmgVfwJm2SqFKIickuPDsG/DXOlu5+G4uCU5DVWTQYm/swjhpRlCoV46Ru
	NsJxVvjkvji/KvApRZNLi8+Wx1ghzMhe8pfm7nyMi0K1XaT4ZAYmLCba+viFFU9vtCUQmbB1Hwi
	xDSRE3WE6dqssIukGXix7bFPl5RJqHjpxLR3hCnogdy+SaCcwN7PAKORW+2Q5UGB0KfGdYmZbLb
	oFELn8IKe1VIWjCva1KON+jVkYdr2n7KvLOnSg6+qDc23M7CRgcj16RBKpMfAgP9aWvByg==
X-Received: by 2002:a05:6000:1861:b0:430:fd60:940f with SMTP id
 ffacd0b85a97d-435f3a86042mr23293086f8f.14.1770136453481; Tue, 03 Feb 2026
 08:34:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203162746.2337002-1-arnd@kernel.org>
In-Reply-To: <20260203162746.2337002-1-arnd@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 3 Feb 2026 08:34:02 -0800
X-Gm-Features: AZwV_QjtdNAcExIQQf3VFUMrTl7vDDynoLe0KaCwRMNFYo9feUcHlzrdWMcOD4A
Message-ID: <CAADnVQ+14yum8okMmjuqF5m5DafWo1fY1EuPj-QU_ykYbQ01uw@mail.gmail.com>
Subject: Re: [PATCH] bpf: add missing __printf attributes
To: Arnd Bergmann <arnd@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mykyta Yatsenko <yatsenko@meta.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 8:27=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wrot=
e:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Some internal functions in bpf produce a warning when -Wsuggest-attribute=
=3Dformat
> is passed to the compiler, e.g. in 'make W=3D1':
>
> kernel/trace/bpf_trace.c: In function '____bpf_trace_printk':
> kernel/trace/bpf_trace.c:377:9: error: function '____bpf_trace_printk' mi=
ght be a candidate for 'gnu_printf' format attribute [-Werror=3Dsuggest-att=
ribute=3Dformat]
>   377 |         ret =3D bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt, data.=
bin_args);
>       |         ^~~
>
> The attribute here is useless since there are no callers from C code,
> but it helps to shut up the output anyway so we can eventually turn
> the warning option on by default.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

This was discussed and it's incorrect.
Commit 7bf819aa992f ("vsnprintf: Mark binary printing functions with
__printf() attribute")
should be reverted instead.

pw-bot: cr
