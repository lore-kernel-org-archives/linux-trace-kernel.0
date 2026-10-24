Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792826550;
	b=BalbhQDUwTzKbHzRj04iFARY9cAPM/zB0jZ/3Px1IF9qcdhJxw25tZv8QhPbUM7mNQH3
	 6jziWGv+dnDs40abt5GKmDbCMC6toAdccSkcGm4Gl+Q+U77tQEXmuO0uNlLwfgr+gLjfp
	 H4lWnNX/oorcdm5OgEc5ZYlTdB8wcXel4oMOeVzq70i8GR9cR7aAtRUhVfl6P32O+VHBU
	 22TpXbAfQCLIdMD2B91SwCIfnGD8B/guOfx0fKIZzQc+BuHCyn0NXL1l4f9jX3SzOQcPT
	 +/sBTvmcrgmzI3w0WyA77nSfNZp4Qxurdqq/wOpXdFHuhpyzqofuBLYaC27r7JxgIzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792826550;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=TkGvhbo8uCfcmT5BQSwIkA1ZNaWITnDyLwroqOawhFA=;
	b=jZeT52X0hg4Oz1z7XVGyWsex8rr+zX+Pc3VqXewWe0IEyY7prn3hMszcJwDROBf2UIXK
	 1TcZgEy5FTH7Z+qHCPnN3sBbscw20g3i2dhrmCV2Lw1NHUkI4LnhSUOAHn9tIzqOoFiK3
	 kYHYI5a83otUCelc5Lhw14376v5jdvcGGMPqZfZBdphC1RHckReNu1TH/U5fRwS507DXq
	 kxCmR/gCfL1WbRsM6EbVdO8nLH3zGdZEEdUe/yzYWIi7adqmbGqV2GZTLFzV/cUbKZdMY
	 Y7APG+XyOjRr3YOpPfgIBG8EUKQ66ZSvYEt37Qlvs+Rhil/ztbVHyVg8Z4r4eLwxh3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C66Wz9GK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3B0606A31B
	for <linux-trace-kernel@vger.kernel.org>; Sat, 24 Oct 2026 07:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C66Wz9GK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3561F031E6
	for <linux-trace-kernel@vger.kernel.org>; Sat, 24 Oct 2026 07:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792826549;
	bh=TkGvhbo8uCfcmT5BQSwIkA1ZNaWITnDyLwroqOawhFA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=C66Wz9GKMH9eWP3KjPne9n1gdC4LfnIDpgTBj18latoVkXOi5f8/BiwnoQ+pw7Jym
	 9Ugyp50w53PhzBHJjiWK5gPvLwW3lcjB7mZ+FMvTtWxwkUpX/8WRGr2LCXCwRhvrrH
	 hki5q9lJcrQt0yNY8OSjhrztMPEqhUFkY0aW4JZ0oV9VAmRfBNU0v/o7HSNBxbql64
	 7qYTzvgL8jFqSuiSrnxfgM7CDFATdqkG6601ofKjJk+qESWsqs01zXqPh8ksRUEutG
	 gnm2pNyCoGLuIqwU7AkaV9uweRXZfdeHEZTBtMrOENMVC0zaaIBcJ/tEWOFGYmuVY4
	 7uJlMNZ6dw8EQ==
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93f3c89594cso103929385a.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 24 Oct 2026 00:22:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzj1iClRrkNLx4BWPT60EbIuCpzdTnaO8J22tAD+qVllcbD0ZbiUwFhZmwQi73UcwRdxFcMB7a/1FwV8xOWApoYQjg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKfFB6Lxe5Tl0ffvZf6X5kFOkt1/RAeqw2MSaqYvXzhZh8yEED9
	DhddnUjDA1B/7GqxUBgKk/czgosy6SQlA4rxRShyu2r3biSe1FtTp20nf8pybX7LmmToc9hAQQB
	Xaba2QWZTNP0WxlhUGpgA7gwkrsEHn4k=
X-Received: by 2002:a05:620a:4385:b0:93f:953:9a1d with SMTP id
 af79cd13be357-940ef9bc448mr169348385a.67.1792826548495; Sat, 24 Oct 2026
 00:22:28 -0700 (PDT)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019034426.2354049-1-ridong.chen@linux.dev> <20261019035252.2357900-2-ridong.chen@linux.dev>
In-Reply-To: <20261019035252.2357900-2-ridong.chen@linux.dev>
From: Barry Song <baohua@kernel.org>
Date: Sat, 24 Oct 2026 15:22:17 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4yQrp3kKJfkXPyLN35Zk_O_gBvnPnUmbwxCU2GVzrE-Zw@mail.gmail.com>
X-Gm-Features: AclHuK89s87eEZ3BnSPuNzTPl5Fwn-4GMSCXcuFKmZMlVEBMhQsRB9l0-sHv3zY
Message-ID: <CAGsJ_4yQrp3kKJfkXPyLN35Zk_O_gBvnPnUmbwxCU2GVzrE-Zw@mail.gmail.com>
Subject: Re: [PATCH v4 2/9] mm/vmscan: move vmscan tracepoints to a local header
To: Ridong Chen <ridong.chen@linux.dev>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Dave Chinner <david@fromorbit.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Muchun Song <muchun.song@linux.dev>, 
	Qi Zheng <qi.zheng@linux.dev>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, bpf@vger.kernel.org, 
	Ridong Chen <chenridong@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 11:53=E2=80=AFAM Ridong Chen <ridong.chen@linux.dev=
> wrote:
>
> From: Ridong Chen <chenridong@xiaomi.com>
>
> Move include/trace/events/vmscan.h to mm/trace_vmscan.h so that the
> tracepoints can be extended to reference vmscan-internal structures such
> as struct scan_control, which is not visible outside mm/.  This mirrors
> what several other subsystems already do with their trace headers (e.g.
> fs/fuse/fuse_trace.h, fs/gfs2/trace_gfs2.h, fs/lockd/trace.h).  As they
> do, set TRACE_INCLUDE_PATH to "." and add mm/ to the include path of
> vmscan.o, the only user that defines CREATE_TRACE_POINTS.
>
> No functional change.
>
> Assisted-by: LLM
> Signed-off-by: Ridong Chen <chenridong@xiaomi.com>
> ---

Reviewed-by: Barry Song <baohua@kernel.org>
