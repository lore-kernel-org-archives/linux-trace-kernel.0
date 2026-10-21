Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792604521;
	b=FJooLVjNvInI97YZaHAeKs7zv4JEa5WENn1w/SW+Pc0o98b3dzsNZLuYNyrVzm44Y/7r
	 v0m/p78b4AglZp6UVSkFIaVhExrz4tuWxPWkG9i67iwPhVRSPEUBlg5igdHT1M1y03hM+
	 4M7aC/c1yDAjfE+mYJzEsZHtEY9PZ+15KEe0A8U8H4Vs9BlSQ+FDjyj8x3G9aZgawe0LP
	 hpdttIJ3pZFpWHeUeYUWMV2QlACr7xq8ziuGvKnl0UaM4yWYnwFaM+tmh0DTL7uYlebiL
	 uJHHCWOUxIE1DKYBxft8fY1h7RGa6lDHUoim8v7CfzMx1akWxwZ5C4rEqT/PcsD8dnw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792604521;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=WbPfC3xf415pZLIbAAwGQiH8uDkz76+8nE49QrFCe/Q=;
	b=khDLACJyMY85n8oSEU1ZrykDGBWwTNcAH9JAaPiFfgPtmY0keAIVHhM2ApG1Q5q88RD7
	 sAS/j4KU3IQRu3txaEMyxVpMTv04DXdVijl4tRhDeHFHlYgYLaESO87lywwNj0GhtA2Mr
	 huPV9X08OpvClk93rOp9ra7DbegT4YX78FcuHOTvWh2FTbKr4teNGwur4xMpfFSoHcshV
	 gAYTQQU7lNclgzUbmIULpotzaJ7JrD1vn3ZbvtAaUyN37Gz+mtHLTehfewgJTwS93Fggw
	 1uERSK+QvKpIkvbc2NgtFxb7w17MKrHKEf6de6mXcZRlHegGZaEJNci8+ZMyr5Q9FsA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GvAbxW8U;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D63606A31D
	for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 17:42:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69D63606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GvAbxW8U
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3a4cdc9025bso629345a91.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 10:42:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792604520; cv=none;
        d=google.com; s=arc-20260327;
        b=J/vJKyyV/ic2HHSxB3uytVncMB5DKheEqeLHLC65aAwn+80te/JX8w1TfyNroa1a94
         JCF15JtXCjarf4I306p+qbgE3F7ICgwkTu7FqeDyq2LQalKLamyWxzH6GcpDgOXLa6AL
         58R4iAUw8YcBvBTHoDeyJb/9EG/5gSNOdi+LOjUUOk9PGHk9wX8gmOVgD1voHznx+7FG
         5xdVunav5D2jSDCumI5AHTTehvnriogtqRClEjmI5cA23/GM6cTHcfCd8WX09t1BBRGr
         QnVa0zsQ9iZwNc8u9cdPAbej22880BOyxTJJvJl6rQ1X8yQotDTrkBaUJcCvqNPbjeNN
         zsvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WbPfC3xf415pZLIbAAwGQiH8uDkz76+8nE49QrFCe/Q=;
        fh=a6vXjbnBuKizPkrHu+gk+2kpRf9iC9HryS4tuKJOue8=;
        b=UlvJDeeOjm2QTgeVHKxrp/WFaATM+n/cYqaDtNLY7EdQy07mpyNe63Fhrai7Rjb//S
         JIHfnpUFNhEYduJrznxxGVhmodaU1Da0WQvB0yRxSteuNiJ+CRU2N1Qn3x1j8yOVRpB5
         0x1xHJQ51WXcBr6lfIQxyMjfy0kbyWHMDZXv7BhObTEw8cCeyHu+YGxLMTqRKkjq6vZQ
         va9jQ0lby8na9F0EEMGz6mwyEYcbHAgVr01QKTqBwFIe4KmKSdNcElWpn/zoU7TjFtwP
         GiliYaS6PY6hOKIkkOKiT/W9zc+CIXPnDqUP9uI45j6c36Ndni2N2m583Ofxu8D6N60z
         fr0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792604520; x=1793209320; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WbPfC3xf415pZLIbAAwGQiH8uDkz76+8nE49QrFCe/Q=;
        b=GvAbxW8UXtF+sRo9OMu4rbiOvh/ZUVz/YIvz0PscUkArcnkkSoHXjx90jpuxuMfVj+
         gvaXcIpvK/50UG3alQJ1Dp+2g0gdqjTAy5dm37l86wOcXJrukh709bQOUA+kBnTyfJi8
         qZtNnpMZsfDYyI6WIxZvhBlQZbClbbWY0qrp2jd4DE/n1oA/K0IeB0+YkDIMXH+Xuj5T
         HPw+nY/bs4Z0G4Xi/rxh0plLMUug5NI98mr/u7qmV3y0SN6sva4+Duq9Bz9yHmm7Kk1d
         jtodxu+rnwuW5xb6SJB7Sri91KGj7ab04wNmbK0F7wLB2SDE9nwKdnQabNsQv+yJvzy9
         J5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792604520; x=1793209320;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WbPfC3xf415pZLIbAAwGQiH8uDkz76+8nE49QrFCe/Q=;
        b=UdedA8IOZpzZ37LYmzzHJwEKabQDKqAiMPhw6CquFvC3wYFAVn5BTPDc20DFcigLGB
         rdfwH0Q2hEnUfhEqG5+K1N6maloDOVkHkUDVH1AwNzA1JsTeibAscS73kySWJ8fRYyjS
         bGq66wCAXGjnqM9ZC1vBAHpIAmADUo+eLDrybTdAc5keSQLfyWlUzSCWiSJDKU47wQnz
         KqtSZBU19UnBU56apnCuspBjOhwzu4eL1TvatFmjZoWFi0dhz3OUm2A5Dhg57C2Dlblz
         AKD8Ucic6J6klVQYlSIvVw6G1WFK1oYoZ/3wO3ofWpnYstY60jpQhPa2p5q2LtbIvVX2
         82xw==
X-Forwarded-Encrypted: i=1; AKwUvBwcIObshBcqxIV1WLH9+tX1I3MZ+jf44vUTeoQtuwa3P04KNslgDc6usestJcCdXGo3cyO/QN73Z7qrKdhPbufU8t0=@vger.kernel.org
X-Gm-Message-State: AFq9FYK5Xrzw8AefSteq/uYnjlrTu/Nlhn5cVo0AU67Gg5oUGMX4aB+M
	AuY0JmDwfCpcWhAWtG2eUzvFjWiCU9SQwcjiFMELdbiqrnCPXypxwM5dxsQ3gNA44EWxdcFcgX/
	YngE0mRWr/V+CgdXEh37MAIFGRYBXqzA=
X-Gm-Gg: AYBFou0EXOyfCOUjkrBOJqieNC0jJMKSSY/nmg5SgTbgP5wVH0LNsWCkzYUUjrCiuk/
	6oZI4pAhh35MRt+H5EbdnG6TLLk3dVEKUSo8YK4YrBGYDbyHYUZm3hDEw+fEInPnIAZzk9l7yb5
	m+9BbEPl6IlUkRBwz+gn0BVDWvMzo6zF8eONyGhnxauzPwyZPZHo41geQVBDxAlO98vVCBCPVud
	hr/U/QSRWmVYD+SPkvBhbPnWRNJo2v1/fTFqb5J60u+NC4hBgLesOTk861TSDe8vs4X2n94xqi8
	5jfYaLs8ROCQpNOuTUV1Rz3LJpOBfbhjlhZPpyApXo0jR+qfbHse3AQbwVA/DOyQgXC8tfh0l3S
	afs9xwf82537KgMVhSXWkT5tgOSOdF0CdIDKvNhtHGsMW1IFuY4+VxuN7eYyYC19Rzpf8Qb4kZa
	8M3wNeZieSVzWCs1yVKg==
X-Received: by 2002:a17:90b:258c:b0:3ab:2ad1:f10a with SMTP id
 98e67ed59e1d1-3ad86ca45acmr2134722a91.0.1792604519654; Wed, 21 Oct 2026
 10:41:59 -0700 (PDT)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019153628.15912-1-leon.hwang@linux.dev> <20261019153628.15912-6-leon.hwang@linux.dev>
 <CAEf4Bzbr46UkiE1sbb+Zwcs0S1ejpKmtTGjNCAkWD-J6FRcPGQ@mail.gmail.com> <d4fc4fcd-3691-4122-8b3e-a75447956255@linux.dev>
In-Reply-To: <d4fc4fcd-3691-4122-8b3e-a75447956255@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 21 Oct 2026 10:41:43 -0700
X-Gm-Features: AclHuK8euPDDrPLcZ78w73yg4ZplR7FA7dJCpvboj2MZKSFYtjKIdYl4Mw0-_4w
Message-ID: <CAEf4BzY13x1skc6XSnXGyoLwaFoOtENGokUX7XHiakEyw+eQEw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 5/6] libbpf: Add bpf_link_create_log API
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Shuah Khan <shuah@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Hangbin Liu <liuhangbin@gmail.com>, 
	Martin Karsten <mkarsten@uwaterloo.ca>, Masashi Honma <masashi.honma@gmail.com>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 8:27=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> On 2026/10/21 07:25, Andrii Nakryiko wrote:
> > On Mon, Oct 19, 2026 at 8:37=E2=80=AFAM Leon Hwang <leon.hwang@linux.de=
v> wrote:
>
> [...]
>
> >> --- a/tools/lib/bpf/bpf.h
> >> +++ b/tools/lib/bpf/bpf.h
> >> @@ -484,6 +484,11 @@ LIBBPF_API int bpf_link_create(int prog_fd, int t=
arget_fd,
> >>                                enum bpf_attach_type attach_type,
> >>                                const struct bpf_link_create_opts *opts=
);
> >>
> >> +LIBBPF_API int bpf_link_create_log(int prog_fd, int target_fd,
> >> +                                  enum bpf_attach_type attach_type,
> >> +                                  const struct bpf_link_create_opts *=
opts,
> >> +                                  struct bpf_log_opts *log_opts);
> >
> > Leon,
> >
> > how about instead of adding this new API, we try to repurpose
> > bpf_link_create_opts' iter_info to be used as log opts? we have this
> > right now:
> >
> > union bpf_iter_link_info; /* defined in up-to-date linux/bpf.h */
> > struct bpf_link_create_opts {
> >         size_t sz; /* size of this struct for forward/backward compatib=
ility */
> >         __u32 flags;
> >         union bpf_iter_link_info *iter_info;
> >         __u32 iter_info_len;
> >         __u32 target_btf_id;
> >         union {
> >
> >
> > that iter_info/iter_info_len is a bit of a legacy before we had
> > per-attach type union, what if we add iter section into the union,
> > wrap iter_info with union and put log_opts there, mark iter_info
> > deprecated or something.
> >
> > I'm not sure anyone is actually using iter_info (I didn't find any
> > uses in Meta code base, for instance), but we can detect its use by
> > checking iter_info_len: if it's non-zero, then iter_info must be a
> > real bpf_iter_link_info. so we should be able to detect this just
> > fine, the only downside is that you can't use log_opts and iter_info
> > simultaneously, but I think that's fine: you can update your code to
> > use new iter.info fields instead, if you need log_opts + iter_info.
> >
> > WDYT?
> >
>
> IIUC, the struct bpf_link_create_opts will be changed to
>
> struct bpf_link_create_opts {
>         size_t sz; /* size of this struct for forward/backward compatibil=
ity */
>         __u32 flags;
>         union {
>                 union bpf_iter_link_info *iter_info;
>                 struct bpf_log_opts *log_opts;
>         };
>         __u32 iter_info_len;
>         __u32 target_btf_id;
>         union {
>                 /* ... */
>                 struct {
>                         union bpf_iter_link_info *info;
>                         __u32 len;
>                 } iter;
>         };
> };
>
> Thereafter, iter.info is preferred against iter_info. And to keep
> backward compatibility, iter_info is used only when iter_info_len is
> set. But iter_info_len and iter.len are not allowed to be set at the
> same time.
>
> With this change, the bpf_link_create_log API can be dropped.
>
> I'd like to drop the bpf_link_create_log API first, then add iter.info
> in the series of log support for iter link_create in the future.

up to you, but I don't see the problem of dropping bpf_link_create_log
API and moving iter.info in the same series

>
> Thanks,
> Leon
>
