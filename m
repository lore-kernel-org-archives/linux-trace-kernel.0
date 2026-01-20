Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F8F44A717
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 18:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768932376; cv=none; b=g1LXbnOy0bBDdAQKG6f/9baPQ/1sq6DmS+WcAVgR0hRH36hbQF+1v8fVNVS8xVO4ICx0kfmoUTSrufeHatysYDpUDkJVDUKZm5dev5FnGOdNkatEvdvDixI9Z5HIj0PG0fluGbbAUvvptyeFDv/pOTqeAnAAN4gBGPUw/gqDP1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768932376; c=relaxed/simple;
	bh=+/G9xnytSRdZiIOFd28QuZ//L1BeR3Jjgm+HN2Txu7E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LRHiKlKKVvbxtWcDQa2a/go7RMGAVeqxRvSZQKUlTH8rmv4ZvTJvr4ZuyikaQjXPC6LOTeCy6WTHFYilCLIhaDowRkLAYN2tpaB4ITd4A+bbbHlbGE7rM68uko5DA3ckh6yZBh8E4NR8YaUQ6EiunsSahF8cJC14JbLWY0txxnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6v14FbM; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6v14FbM"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2b6f5a9cecaso2003340eec.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 10:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768932373; x=1769537173; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eyerjoEVUHP/2q8LWOmqlYZ45AxY0BTKpTeutlV7DCY=;
        b=X6v14FbMISveJc9MaMemnxJdDrd5a3dcH4k0SJjN0DpmanHG5wJ2qrkBB0rj8au1jh
         CA3uqMlOuMv434IC1VgLuVf8TdohvCS0BdEKOKFEq5Xxdgcm+VlQvs06u/bzmy5e7+I4
         Clwez2UPNB+nNCakIZxG/ISeURsfMoqDc82FazHMurVXXrxoDy3bcrT3M0xkcOBmShZC
         OZwDOsv5KpDw6gcBb2+22awH2cdkt0aRcq1/i83LOngI+5bqRrKKEu+xFAPmgsoxsvX8
         zqD4DT5+7Q50m2Cul6gMQY6GlWNS8G8asRYHZXACxdpE6Z/R4ct3nV7oLHQBEgIkZ9Gf
         4wRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768932373; x=1769537173;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eyerjoEVUHP/2q8LWOmqlYZ45AxY0BTKpTeutlV7DCY=;
        b=IkJ6iHuBFpwpsa6GXyMOUI6OcpdAPYRdhR6U2dOogT/FICcAG/LMBtgMocXXrQyKi4
         tNv5yK/RpCtACPXx7AXes8qVfLOX40ax7siDR5xvroRQ8pXsGZD/17Y+jyjKpVjk8/8p
         Itl4evpz5zrOdLLkyy5qOUNn4F1TVUNDywQ/wSXhtke0eB+UqrUL5K+Tt0I8uJME9S7F
         Ws2kzWkHDz/6ajphbCstruYW2Nkb8vfhoCnioLu2cd5eqiwAwOeu9wNK3MG4XK2ch/5T
         fYAb2DVXfpUBGA7+2X4G7caGUDxEKbkqo/QzMtMKXjApge7N/jMws8grHIE+68EJSGpv
         mh8w==
X-Forwarded-Encrypted: i=1; AJvYcCXUjNTWW5oWZI4ZQe0L+uIP+Na6l9aiMuAewPJCPUchRvcBo85bYBD/lUFbTGh2xIs4NDYYKyUKVV+Njod7NF3uUIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFTUvIW6CWm6XWL6TflhWWvhjQyk7pMtGRwg4DLhVaFX3qIDCT
	8eF/29fEIKwwSR+3iMaZme2XD9G90ZmbY0hy00cpkiGVKwxvYFATM5Qd
X-Gm-Gg: AZuq6aJ0qySTXG4EwbHrODzNQb9YRfGXU2/ziizdNHkRiD+fB/mTIvPFvJyi51IuslW
	LrcuZWNECf6n72yrUoKhN2wx4dfW5hV0cygtiC4sClwJJHkTWU7O4WGzoMnQN3ZhZlYVg6HbifX
	eNxgJWtl9c47szYYdUVpTDLI43YYK2tT7QUH6obzInU8LYwItRHBl5z0ATdDshLGDAXSMhPXiQK
	1DQL81K64puINyE0pFDMuBhbERfKRqbuk4oI2BRxhquCWWw6hAow77PMt7+KqZO2z4/Vh91rOg+
	y8GWQVurSNeRCGEqgHzl1nWtqRclC50Mf40/iwfJtUltGtH8YJSGWk3nSOSOcnIyOWl29uqwNpG
	dsLjJXMW+FKCCsqV9Gi6zyONXx47m21exeZS68Og/+WbE8y4Ik1FK3GoX/JXZfOZLpTVdMXnOWT
	q+UNs7Bi6YA6Oa57pLxdvYyit8vGWFcEIjfhCy5OIWlgUjjCaU3+y3rVb9K4dbWzQ9O6w3hsBJD
	8Q9cyc=
X-Received: by 2002:a05:7300:fb94:b0:2ae:614a:3307 with SMTP id 5a478bee46e88-2b6fd7eee95mr1965930eec.42.1768932371383;
        Tue, 20 Jan 2026 10:06:11 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:b08c:bb3d:92b9:704d? ([2620:10d:c090:500::3:93b1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b367cbc9sm20058248eec.32.2026.01.20.10.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 10:06:11 -0800 (PST)
Message-ID: <34ff0901e3c96cbfab8b7325012e44d6d290a9be.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] bpf: Require ARG_PTR_TO_MEM with memory
 flag
From: Eduard Zingerman <eddyz87@gmail.com>
To: Zesen Liu <ftyghome@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend	
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev	 <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Matt Bobrowski <mattbobrowski@google.com>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu	 <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,  "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, Shuran Liu
	 <electronlsr@gmail.com>, Peili Gao <gplhust955@gmail.com>, Haoran Ni
	 <haoran.ni.cs@gmail.com>
Date: Tue, 20 Jan 2026 10:06:07 -0800
In-Reply-To: <20260120-helper_proto-v3-2-27b0180b4e77@gmail.com>
References: <20260120-helper_proto-v3-0-27b0180b4e77@gmail.com>
	 <20260120-helper_proto-v3-2-27b0180b4e77@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-01-20 at 16:28 +0800, Zesen Liu wrote:
> Add check to ensure that ARG_PTR_TO_MEM is used with either MEM_WRITE or
> MEM_RDONLY.
>=20
> Using ARG_PTR_TO_MEM alone without flags does not make sense because:
>=20
> - If the helper does not change the argument, missing MEM_RDONLY causes t=
he
> verifier to incorrectly reject a read-only buffer.
> - If the helper does change the argument, missing MEM_WRITE causes the
> verifier to incorrectly assume the memory is unchanged, leading to errors
> in code optimization.
>=20
> Co-developed-by: Shuran Liu <electronlsr@gmail.com>
> Signed-off-by: Shuran Liu <electronlsr@gmail.com>
> Co-developed-by: Peili Gao <gplhust955@gmail.com>
> Signed-off-by: Peili Gao <gplhust955@gmail.com>
> Co-developed-by: Haoran Ni <haoran.ni.cs@gmail.com>
> Signed-off-by: Haoran Ni <haoran.ni.cs@gmail.com>
> Signed-off-by: Zesen Liu <ftyghome@gmail.com>
> ---

At the moment, for helper arguments processing I see that MEM_RDONLY
influences verifier only when argument type is ARG_PTR_TO_DYNPTR or
ARG_PTR_TO_BTF_ID. Hence, I think this change is safe to apply,
effects are limited to the check_mem_arg_rw_flag_ok() below.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

>  kernel/bpf/verifier.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9de0ec0c3ed9..a89f5bc7eff7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10351,10 +10351,27 @@ static bool check_btf_id_ok(const struct bpf_fu=
nc_proto *fn)
>  	return true;
>  }
> =20
> +static bool check_mem_arg_rw_flag_ok(const struct bpf_func_proto *fn)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(fn->arg_type); i++) {
> +		enum bpf_arg_type arg_type =3D fn->arg_type[i];
> +
> +		if (base_type(arg_type) !=3D ARG_PTR_TO_MEM)
> +			continue;
> +		if (!(arg_type & (MEM_WRITE | MEM_RDONLY)))
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
>  static int check_func_proto(const struct bpf_func_proto *fn)
>  {
>  	return check_raw_mode_ok(fn) &&
>  	       check_arg_pair_ok(fn) &&
> +	       check_mem_arg_rw_flag_ok(fn) &&
>  	       check_btf_id_ok(fn) ? 0 : -EINVAL;
>  }
> =20
