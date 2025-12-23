Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA1C1586C2
	for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Dec 2025 03:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766459777; cv=none; b=YMCZrwrLiJa6x8+tltdd5Ai5EV9l20+DfOBXzyVuh24v1yEq04pWEBLf7qg3r48VwhH3Ob7gBo3Lc0LDJEwQvrU3tBaJxoxQFkDBNB6SvM8nK3Ib1vdOmIZMvSUWtu69O5xU5K+ieJzPIO0bLzHoP+jFCrRKCCCPJKlqLZzuXl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766459777; c=relaxed/simple;
	bh=Mx/UmQpiIIEj3g1XtLjsQrkIbpEb1sO7h8QPcpp78vQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=MdnznC5dlEPHTjIzLHvQ4ioNj7CKFY8yzxCDrmYv2fwTmf9esqvdOrOyIsxyZpQPShWlyMguX4iTTvDgJWW+B8j8i72WPoTpyQ5i7a5MU91uF2x1tihl5zJvp4o5vWQn88889qBzrUVA8v+s/5YMpsUfD6myDUun9AeLxHy/TEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ag6QkYLR; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ag6QkYLR"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2a0f3f74587so63891475ad.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Dec 2025 19:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766459775; x=1767064575; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlWmvPevLxcZ1ApfaQlGkISYTXnx0tCKi7KeQn9/wc8=;
        b=ag6QkYLRk36oKpnYOVqgLPh9o9181RmjXFoyiLT63EuKe78sZah1GlVwTUSrq6Zuuk
         s+UWzZ2HudOohOlaeebWVMqG/sI5FR25EOZqh+guqxKv7LVYbG6XG/dRPgoDtsat7y8w
         irXdEIYEa+LBW6DlhPIwOCeu9HAr8ZFS5/4NMVcuFkiXlVjPmwyg+LVcx3WpQJEgIqFt
         2osYRs1Ed5vkH13O40DkU9Wo67J/qLwHJa2WiKrmI1uj9kgjG3gZ4aBZliDbcLSTUF0O
         U8jgwRIUXUd3Ga+o+LMK9WzBtbpVbeT2Ip1BwVHercOIEJNjiYxolNwHfUsFKF5lOcsJ
         042w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766459775; x=1767064575;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BlWmvPevLxcZ1ApfaQlGkISYTXnx0tCKi7KeQn9/wc8=;
        b=ekb0NYbGQ2Gy0Op5ix6c4Qdmiat8Z9v1HCggF9l3yo1vER42M9XTD5dWqI2IE3B/LP
         WRsF+/cF/adA+EI/qqzUatfuuYbWfVzn5KFPQNSGsL8nCBUgBe+Mds+qMkjkbcs0tqon
         3AhSOHWeG5xkkleJu5GdV5RyKtzbs0/58+dySoVbAh78CYWL0Zor7LU7nBzoyPfJK8ED
         YqKlnwSO1aMxF8HIanZw/A45knesIAOZZDcfhKI8u9G3Swh+xmo0WM8WBN2gZKCVVAp/
         kj6xxXAXhGuY2IdczKx9p/s0cEUttMPc6OWNF7H14FqSIt6uPaz5VRHkIvCFMGnSgMr+
         jDbA==
X-Forwarded-Encrypted: i=1; AJvYcCXtHhrAoJDPevMvV18lHl+GOS/gBJhWDWRqFMKivwfcgf4+dLTeq9aRl4v+XQsAUKCi5GeOOAOx914Isc1P0a9TjC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL56xnUBey1BTnd4f76mvOASaeeR17y0y9sGOkvdkdUZ5R+p/o
	P9p538Hub9MDRcdJHvBrpWur3B2j63PPWnXVMcEhysALHivFhT9S5Y/Q
X-Gm-Gg: AY/fxX6v4urmVMNwKBR3rUl+Mndv2VWDhhOshKfd0aiTY1eB43VVd503xrTB6ULP5DB
	n37LwbWUUqEUSIBeBwwUvAPpYMj8/jOebfsm5wOJ19D25juhvm6pYjZe1PNyOsqQfcBBCMgo6PJ
	nu+TJRwBQYrmbAfdH9n88fClpOc1bJWJSpisqxkPUrbb6tZpgUyfcb+RnukerIf/dFSoBmKYpLi
	ri9/Jvssh495CWC+d6N0igeqVS7H+Zkpa4DWkomOH8zwc4QwG45gxsW31o2yVM6bBjMaba74dUG
	V41t/jnyd+tFnlVnDRk/IPeFwqz/JaVvvkactGDfIPIIgDh1kziTytkuDPAOnhlbl3z4odAVtw5
	/05ztuRIXZL2oZaPsT7Na6YkZv5yTNnvBXacjT00D6gEYTL/MP2mxjzN7yYb+aRAwDv1zXyyDL3
	qKrNecr0NPoDhLSBUnSw==
X-Google-Smtp-Source: AGHT+IHsJHcvBEd1oY/Js4mF4dqnLZlZO6zVgt/BH5AZODSD/0YmbnGfhPQbR6X+bCQGU0pLbsm+xg==
X-Received: by 2002:a17:903:2a8b:b0:298:1422:510d with SMTP id d9443c01a7336-2a2f293daefmr125439995ad.48.1766459775168;
        Mon, 22 Dec 2025 19:16:15 -0800 (PST)
Received: from smtpclient.apple ([188.253.121.152])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c65d66sm109554945ad.20.2025.12.22.19.15.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Dec 2025 19:16:14 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [RFC bpf PATCH 0/2] bpf: Fix memory access tags in helper
 prototypes
From: Zesen Liu <ftyghome@gmail.com>
In-Reply-To: <CAMB2axPpB7Km=_7J_QTcQV8SvuFMKqg-_fCyRHEZKNfr7WL2Gg@mail.gmail.com>
Date: Tue, 23 Dec 2025 11:15:46 +0800
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>,
 Matt Bobrowski <mattbobrowski@google.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Daniel Xu <dxu@dxuuu.xyz>,
 Shuah Khan <shuah@kernel.org>,
 bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org,
 Shuran Liu <electronlsr@gmail.com>,
 Peili Gao <gplhust955@gmail.com>,
 Haoran Ni <haoran.ni.cs@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <991C3D59-65D5-4B31-B667-EDAF348F9F7F@gmail.com>
References: <20251220-helper_proto-v1-0-2206e0d9422d@gmail.com>
 <CAMB2axPpB7Km=_7J_QTcQV8SvuFMKqg-_fCyRHEZKNfr7WL2Gg@mail.gmail.com>
To: Amery Hung <ameryhung@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)

Apologies for the resend due to an incorrect configuration in my mail =
client.

Thanks for your comment!

> On Dec 23, 2025, at 03:29, Amery Hung <ameryhung@gmail.com> wrote:
>=20
> Perhaps you are conflating one of your proposals here? This is fine
> currently. ARG_PTR_TO_MEM without any annotation is viewed as BPF_READ
> so passing a read-only buffer should work.


Actually, that is not the case. I tested this again, and ARG_PTR_TO_MEM
without MEM_RDONLY does reject read-only buffers. You can reproduce this
behavior with test_d_path_check_rdonly_mem in selftests by removing its
arg2=E2=80=99s MEM_WRITE tag.

> I think it is better to make the MEM_WRITE, MEM_RDONLY annotation
> explicit and check it in the verifier.
>=20
> Flipping the default MEM_RDONLY semantic to MEM_WRITE does not prevent
> a similar bug in the future when we have helpers/optimizations/checks
> rely on an implicit semantic.

The current default semantic is in an inconsistent state: it implies
neither MEM_RDONLY nor MEM_WRITE. A naked ARG_PTR_TO_MEM rejects
read-only buffers, yet tells the verifier that the helper does not =
modify the memory.

I see two ways to resolve this ambiguity:
1) Enforce explicit memory access tags (disallow naked ARG_PTR_TO_MEM) =
as I
proposed eariler; or
2) Change ARG_PTR_TO_MEM semantics to behave exactly like
   ARG_PTR_TO_MEM | MEM_RDONLY.

I would appreciate your thoughts on this. :)


Thanks,
Zesen Liu=
