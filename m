Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01982ECEBC
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 20:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768854258; cv=none; b=oB9DITMpIvoGPJl9QMk8mAkery8yQpxUOdNWR7EyoVL3iw5Gn6Qv3t4k4rq2YO+wX62yq7dNMXAu6yb/+LYxPvOAJp1iwMTFNJUPdquJhyy6LH595deTC3K7Fiy0I599rDumiV7Br2gqJBB50SzW6hIzJAek//pw+NQF64as6dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768854258; c=relaxed/simple;
	bh=H2bq/OAD2o59J4yItaZmIuW7yJ0igTT8/wThWqgVO0I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sc3m6FVa3IqEx2wDjZDWc36EhDgcY4v9fgFyD+Rxou9YH5ykcO8G4QwjNDsBF2X+ICUSkf4R8n5ktLgnKNjZvjcikNfIpgoG5uLGEkAhBJsR3TOpOSHJlNpLwI60uJLo9tGcIcnXZ3psEQIGnQ/K2s/jmkrrjL8fpligqq1H6kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9VJpI0I; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9VJpI0I"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2b6bb644e8eso6986094eec.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 12:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768854256; x=1769459056; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AbY+jX2Rjs0OZqwqKdZgEOaZOTOcp8GauBAWp66xGL0=;
        b=J9VJpI0IU0f5V9OfudFRrZrd+7j91wUI/bCCg4jCP1R/Ll0yoErbe/ApMYASUj06v+
         zxLdFHqtr3UK3v0muw73wNpd+6oQPeCTIDfQ7daKC261uIigg+TQ6WYMalmF4lwykaVz
         sO8K+/ISXhWQJvV0m3Q844TIpp53CxH+HL46sUUjS37OAiHXFZF34U2PVMBzk80gaM2d
         Ip3qkQsDi8I6x8PnsznxNEsFtidF5ikaOBAoI5sfhcbnRULWRgj0d6Gz8AGJLyJDW/Gv
         WCaNv5IVug7ZLoDFj0zDz5NvrItsV/jtmBPGyoys9mBSbX/DSWKHmF1oxfih7OkeoyKd
         1SzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768854256; x=1769459056;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AbY+jX2Rjs0OZqwqKdZgEOaZOTOcp8GauBAWp66xGL0=;
        b=wrIxnNHGx27Tw4lYszu545D9MPMvuTcAIcIsnarO0F+BjT+uZR0Go8wwczLEflDexI
         q32HaUvIgh3D2ifN7zCZenzodXaev/o3+zj3Ai4XYQA5bmEADIdJ69j78ueQjueSp1yK
         LQsIW/lfUnQBLegI3/IHDTPfDE+AL6qTJWvzrk5VkkUEroNZ76B8TfEaEKOZX4VlrNT8
         /y+Uk3A9YHWwJ+gcff/r4Ch9pnl+YFOdvQx3cDz1lSUz2HP5so8UNMOGZGWbXMPigu0d
         BtStdRCB0aopnuzznJURFpy0K5uGgHcOrca2ubiNkJ2a/4Pg+LhEApqsJ5CCEY4rhs5g
         etkw==
X-Forwarded-Encrypted: i=1; AJvYcCXKIn5Cwgngg3gcrEL5+K3qP22XHRjsfOc8ukr93DvBi+Q8y/c7p2XufpBjTEDjqUqnSDj5xivgUoGCkaIikU6sLiI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt8cn0b1Lfi/tAISn6UniuYoFJrAwtL5XQohRDeKUqNuuxlDEq
	v+Y4PnQFuNcNfkC2B8QsX3AuH0stDZVzaRKREHYjUtLcpwnbaQ7TlPzi
X-Gm-Gg: AZuq6aJv/Annb+1IIATvb0TA/yDeyRzUt9t39TRFJkuBHwC1ykxhbsoxZ+l/BWu9rql
	ansLD1FyZv+t5QmErMWw7O6VgUsOYuBtdhF22hEBYeNDjr0B+8/wNWziQve4IK3Kl5+YmipXPx9
	3JK5Hf7zJCpJ5VjdDzSzr+gsScupyKZ6HAF8PyeG26AsvQJPzbN441DPQFEgY/aSz8mtfe534TJ
	UqMlNlhh6IKfu/kAEt+Xaao92M7S7tAPMQltEGYJJ5fl3GLrv5l5zb/Gm7XOOJdULsoGB7KIkrK
	cenWAiVnUA9PDoa8t2HZLxppkl1ARWbuHa+4QxNdT4fEACAr//f83CQPpImKjui34jx/eZc9Eug
	6loOXr2mctQeZw6Gjxn58XYKyTcTHSUKvCwD60lp+43YcLHLrBrJ0LrUKrsGyBMyDW0klz2U9EJ
	DdevBAdwxQqMCwxObXx99gwf/YiILKkzS7AAFirNZBy/ESSAE6WJEYpUbZ+Ihv7bO1tg==
X-Received: by 2002:a05:7300:3214:b0:2b4:6b84:b7d7 with SMTP id 5a478bee46e88-2b6b3f14121mr7909753eec.8.1768854255620;
        Mon, 19 Jan 2026 12:24:15 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:4cd6:17bf:3333:255f? ([2620:10d:c090:500::aa81])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6c56a23ecsm12145563eec.11.2026.01.19.12.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 12:24:15 -0800 (PST)
Message-ID: <55f01664fc714615206cc8d100cabf4f310f2302.camel@gmail.com>
Subject: Re: [PATCH bpf RESEND v2 1/2] bpf: Fix memory access flags in
 helper prototypes
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
Date: Mon, 19 Jan 2026 12:24:11 -0800
In-Reply-To: <20260118-helper_proto-v2-1-ab3a1337e755@gmail.com>
References: <20260118-helper_proto-v2-0-ab3a1337e755@gmail.com>
	 <20260118-helper_proto-v2-1-ab3a1337e755@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-01-18 at 16:16 +0800, Zesen Liu wrote:
> After commit 37cce22dbd51 ("bpf: verifier: Refactor helper access type tr=
acking"),
> the verifier started relying on the access type flags in helper
> function prototypes to perform memory access optimizations.
>
> Currently, several helper functions utilizing ARG_PTR_TO_MEM lack the
> corresponding MEM_RDONLY or MEM_WRITE flags. This omission causes the
> verifier to incorrectly assume that the buffer contents are unchanged
> across the helper call. Consequently, the verifier may optimize away
> subsequent reads based on this wrong assumption, leading to correctness
> issues.
>
> For bpf_get_stack_proto_raw_tp, the original MEM_RDONLY was incorrect
> since the helper writes to the buffer. Change it to ARG_PTR_TO_UNINIT_MEM
> which correctly indicates write access to potentially uninitialized memor=
y.
>
> Similar issues were recently addressed for specific helpers in commit
> ac44dcc788b9 ("bpf: Fix verifier assumptions of bpf_d_path's output buffe=
r")
> and commit 2eb7648558a7 ("bpf: Specify access type of bpf_sysctl_get_name=
 args").
>
> Fix these prototypes by adding the correct memory access flags.
>
> Fixes: 37cce22dbd51 ("bpf: verifier: Refactor helper access type tracking=
")
> Co-developed-by: Shuran Liu <electronlsr@gmail.com>
> Signed-off-by: Shuran Liu <electronlsr@gmail.com>
> Co-developed-by: Peili Gao <gplhust955@gmail.com>
> Signed-off-by: Peili Gao <gplhust955@gmail.com>
> Co-developed-by: Haoran Ni <haoran.ni.cs@gmail.com>
> Signed-off-by: Haoran Ni <haoran.ni.cs@gmail.com>
> Signed-off-by: Zesen Liu <ftyghome@gmail.com>
> ---

I looked trough the helpers annotated with MEM_WRITE in this patch,
indeed the write annotation is missing from these helpers.

In conjunction with the following logic in verifier.c:check_func_arg:

        case ARG_PTR_TO_MEM:
                /* The access to this pointer is only checked when we hit t=
he
                 * next is_mem_size argument below.
                 */
                meta->raw_mode =3D arg_type & MEM_UNINIT;
                if (arg_type & MEM_FIXED_SIZE) {
                        err =3D check_helper_mem_access(env, regno, fn->arg=
_size[arg],
                                                      arg_type & MEM_WRITE =
? BPF_WRITE : BPF_READ,
						      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
						      // arguments considered read-only by default
                                                      false, meta);
                        if (err)
                                return err;
                        if (arg_type & MEM_ALIGNED)
                                err =3D check_ptr_alignment(env, reg, 0, fn=
->arg_size[arg], true);
                }
                break;

This patch fixes a real problem.

[...]

> index fe28d86f7c35..59c2394981c7 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c

[...]

> @@ -1526,7 +1526,7 @@ static const struct bpf_func_proto bpf_read_branch_=
records_proto =3D {
>  	.gpl_only       =3D true,
>  	.ret_type       =3D RET_INTEGER,
>  	.arg1_type      =3D ARG_PTR_TO_CTX,
> -	.arg2_type      =3D ARG_PTR_TO_MEM_OR_NULL,
> +	.arg2_type      =3D ARG_PTR_TO_MEM_OR_NULL | MEM_WRITE,
>  	.arg3_type      =3D ARG_CONST_SIZE_OR_ZERO,
>  	.arg4_type      =3D ARG_ANYTHING,
>  };
> @@ -1661,7 +1661,7 @@ static const struct bpf_func_proto bpf_get_stack_pr=
oto_raw_tp =3D {
>  	.gpl_only	=3D true,
>  	.ret_type	=3D RET_INTEGER,
>  	.arg1_type	=3D ARG_PTR_TO_CTX,
> -	.arg2_type	=3D ARG_PTR_TO_MEM | MEM_RDONLY,
> +	.arg2_type	=3D ARG_PTR_TO_UNINIT_MEM,

Q: why ARG_PTR_TO_UNINIT_MEM here, but not for a previous function and
   not for snprintf variants?

>  	.arg3_type	=3D ARG_CONST_SIZE_OR_ZERO,
>  	.arg4_type	=3D ARG_ANYTHING,
>  };

[...]
