Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792880658;
	b=ef3Q8llQJ4wWk5W/pxIl11SNI6mTVFyykd1bpbNpflasTpwhmcxSgk49gKf92MsnGBny
	 I+tlPiT0ZSL/4cpPPFRA0Ni0bN/XNEQsyIR07Vcb4eZq+z7hAeXgC8KMUQ0o5Q7bQbXDF
	 QmWqG3fJgBVnRzee/uM/9xpjoM2kua1uLZiReiLvaoS3rf6Dk6kinAj/RFYGz4dE84etg
	 ahLyqX3u0scOVLTqc7zhuopYRkXPh2Sj9pfIBe2o6iRcMxBzgUWoGhzTkNn8T4WE81rRo
	 c1TP3s33NmsSasnPNBY90ySNCmRSaMcW58PU/HYFyhbxSGVlhJRHD4eMP/ek0e7iCzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792880658;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ZO95lvl9Nqr2fnKfjhNvY3odHppkPAvE0sy9YV0MAyE=;
	b=Gxkb1YUFr34L2Ae4bG0dLtrwh73JXQBvySjrjCRA9Ea0g9mse1pdL/2xxUQ3jwuh1O/L
	 FXOxx2C0mTsplKN5s7+KWQqxpqzIkU7Td8A/LiC3nHz+jij7DG+bjuurMmqJFEEX0XsnM
	 kV7G1zd/fpJmu3XARDZDiG71tEZg+bcDRzEp0umNs2bQKB8nvWlyaTPKHbTQee1FRIN9F
	 MehNFhI+8ExKFvh5LJDLmV8nJf4z/Onvkd/xzeWLwq3wlfJvvkrUGYO6RozVqvYxY6yap
	 ZXSBI6ogPp5jOkxx1DPBL8lNDxIkpwQcUJ9UrmZh77D6k126F4/rZOdgHVWNGt9ju4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DcwlgpnI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2815606A31E
	for <linux-trace-kernel@vger.kernel.org>; Sat, 24 Oct 2026 22:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DcwlgpnI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CB71F031E0
	for <linux-trace-kernel@vger.kernel.org>; Sat, 24 Oct 2026 22:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792880657;
	bh=ZO95lvl9Nqr2fnKfjhNvY3odHppkPAvE0sy9YV0MAyE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=DcwlgpnI8DL+2mapwB28c0Uuo/uZkOQbIkpHc/v1SllyC8AnQiHsey8hJ4aUWdbT4
	 prMadH1kOhGswoIzNgX1P+u7U3KoTwqUBcWHh2XYWZ5bxDbPXCFaxmk+P2urzWr1Rm
	 tN/5ED+hsmoVE+0QG0XA0UDNI4BCf1ZefiXFb5Qd5/jU4/xxPiEDB4jLllmx0hbm3K
	 EN3bqey/NcRl3d0IV+S3TGGgleI5BqCIn+v74y01Z2wbeUWXGv7IvSemJyMiXrTytO
	 jmFrvEKOiSx/o2gKOwmTm2S066vyIZyZSIob0mQDj8qkp6Et+Vy3xhiiFLqwSXFeD6
	 V70By5SJLar2w==
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93e6eb77f0bso164732285a.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 24 Oct 2026 15:24:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBz4qnFc0RHtZgc2LNCrBzJxYMMuJYR7umo7m4jefVtP5CHIQB3dSRskCb5YcYCUYrEx8h1CQTM5GtDAXOQxayIlxyE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIi/xT6w7aaRaV15mUcnGfncXMTZiUY34o27q29WWRGipYlOv2S
	/WyDvuGLvyP/lgPbGe419XMJGrGE1fgZWjc1qDnf6DsjasdFB0VW1DYMtpeyyhC0AOlCIvF8Ntz
	e3BDRUemIsvu3j13pKlZhKgo6iqFqaco=
X-Received: by 2002:a05:620a:2616:b0:93e:c06a:7313 with SMTP id
 af79cd13be357-940ef914186mr385330485a.13.1792880657009; Sat, 24 Oct 2026
 15:24:17 -0700 (PDT)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019034426.2354049-1-ridong.chen@linux.dev> <20261019042308.2372396-2-ridong.chen@linux.dev>
In-Reply-To: <20261019042308.2372396-2-ridong.chen@linux.dev>
From: Barry Song <baohua@kernel.org>
Date: Sun, 25 Oct 2026 06:24:06 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4z7u_PtSkjm+kH7JX_ZZDLSnGr1teHq6By0ovgB23O8_w@mail.gmail.com>
X-Gm-Features: AclHuK9i0KBXAHQuNAppLi1kJlXPAo77Un_nGJoXjbM4tmAAAAcT3v5pEG65SEY
Message-ID: <CAGsJ_4z7u_PtSkjm+kH7JX_ZZDLSnGr1teHq6By0ovgB23O8_w@mail.gmail.com>
Subject: Re: [PATCH v4 7/9] mm/vmscan: pass scan_control to mm_vmscan_balance_pgdat_end
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

On Mon, Oct 19, 2026 at 12:24=E2=80=AFPM Ridong Chen <ridong.chen@linux.dev=
> wrote:
>
> From: Ridong Chen <chenridong@xiaomi.com>
>
> balance_pgdat() passes sc.order and sc.nr_reclaimed to
> mm_vmscan_balance_pgdat_end as bare arguments. Pass the enclosing
> struct scan_control instead and read the fields out in TP_fast_assign,
> consistent with the other reclaim tracepoints. highest_zoneidx stays a
> separate argument: it is a balance_pgdat() parameter, and
> sc.reclaim_idx may differ from it by the time the end event fires.
>
> No functional change. The tracefs event format (TP_STRUCT__entry and
> TP_printk) is unchanged, so tracefs-based consumers are unaffected.
> BPF programs attached via raw_tp/tp_btf see the new TP_PROTO and need
> to be adjusted; tracepoints are not a stable ABI (see
> Documentation/bpf/bpf_design_QA.rst).
>
> Assisted-by: LLM
> Signed-off-by: Ridong Chen <chenridong@xiaomi.com>

Could we combine patches 4=E2=80=937 into a single patch? The changes
seem a bit too scattered across separate patches.

Best Regards
Barry
