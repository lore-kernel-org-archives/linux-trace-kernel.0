Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792880868;
	b=VHePHH+VL6ylgYyC28WsG8PVWgsHp23/HbhWVSkFDg1i01byPRDffxZoubdUOl6ePEVm
	 6aksoey22ZBAwO+bZEjvh/UnivVsRhp4KLs4Md+VPsbcockkoWMa9l/KlTiwzQ+oqUlyG
	 bT6v283jJ0kd4iFh3zE9ShU1VxvLenxfw0p66ZWBzQpc7VMXbY67PUZD93KOu/35v5Kbi
	 wPjjnVXjxMCfuESsgUlgGdgt5hqmLHdpKQFmTRIysdfo07xw/F4lwCUF50fSTDdO+/XYy
	 go3sOykzQmFrotZdX9nf+NjfBAVc+WvBs+n5vxjor3iNyQSI2uX2DDyDJVtXKSAFKuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792880868;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=vZIKDKKS2FdRJ5bhHVdKxJNVCBF7h98gzdI0qBLThok=;
	b=e7UnUp0M7O1bQOodQN8Ka9T8PPLveM+f7pKED7x5qzanl2+Qz6RfiFqog8kyQyRmIqWh
	 rKU7eGQRnFOM3nUWp4/t15eZCOzxrprJ/PGa+V5z70B0AEbhV3iy4TTQQE04toXsZ+EUE
	 St7gvqunK8Y5bMAIS2fMv060sNxEXgP9TuH3pYELpIXq5yFIH+fzDi3Jxd8jYKtyhiLqb
	 zJananTjbRRIiFWGwSj4Sakuc2HFZPFhF9kmBGNkd7HYFowkMB0sjDTfiFt54ra448GfE
	 QN6kzExoHPe5MnyQxcye3PesWB2Hz24wdvAS+nZflJv8UnBPJAswbvYsgTtc1sj55Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fSsZEjmF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6DF606A332
	for <linux-trace-kernel@vger.kernel.org>; Sat, 24 Oct 2026 22:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fSsZEjmF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7A71F01828
	for <linux-trace-kernel@vger.kernel.org>; Sat, 24 Oct 2026 22:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792880867;
	bh=vZIKDKKS2FdRJ5bhHVdKxJNVCBF7h98gzdI0qBLThok=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fSsZEjmFpPx7gWLUDKT75qvXylgPoUNbQkOLf+Oyt8mLrKmFtp/pm60U21UnyGh75
	 WzjMSWgFxIV+yWtziTLWDffjK7YhV1XUbIFFjO8XC1WL2sPRkwOCFcKSx8XAyHcgga
	 G3sYpF0HbFKOAHNF3nud48Ggy90jwVzbO7GrmvOrfY437cSqqSuDPith1EwwSbFFKp
	 oqLpiX1q/nbOBAaLJ8EOFpB8klsCYVZgl9CXGLTV7QKO2QaOHHfMGJk4oWdhz6yeYE
	 vgRC3E/qPSlyX21qeNFVV4o8z4dPn1EPpzpl5BB4pAjI0zHZbYUBKG5pd0c9l1UYZs
	 sSx2LzUZO4r9A==
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93e7ad9f78dso234385985a.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 24 Oct 2026 15:27:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxxhcwFutv2Qt5mGNavkVBtQIaAB+m1pKgY2vk2+0B65hBmizvKQN3NZi5we5qZbsMtFTEOHOpORD2hAodwsGwBXiM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKs596zeUnxBQmlnvJx+eC44KflSBc/lWVS/Vzkf8yUfpnyfxZu
	8W21eFYiQ5d5bTb9O74shwjLyPVuRBI5Rfhu2hmUa96yuiBFpPZ6IvTyCwz+eATRzed0LIVfkQ8
	lLUQ4dWweQW56kciZ+7OXPNbPZSKVtbY=
X-Received: by 2002:a05:620a:6ccd:b0:93f:43a4:a47e with SMTP id
 af79cd13be357-940ef8db9ffmr456761185a.43.1792880867226; Sat, 24 Oct 2026
 15:27:47 -0700 (PDT)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019034426.2354049-1-ridong.chen@linux.dev> <20261019035252.2357900-3-ridong.chen@linux.dev>
In-Reply-To: <20261019035252.2357900-3-ridong.chen@linux.dev>
From: Barry Song <baohua@kernel.org>
Date: Sun, 25 Oct 2026 06:27:36 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zuFsooOk+PEaSxCGJXm__uS0d_sGbGKsniB+vkdMqAGw@mail.gmail.com>
X-Gm-Features: AclHuK-TQu5lTS1fOR976skmXR1N0B8TphWnkqZazAAO_9122YtVC3DM7Ag6eek
Message-ID: <CAGsJ_4zuFsooOk+PEaSxCGJXm__uS0d_sGbGKsniB+vkdMqAGw@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] mm/vmscan: move struct scan_control to a dedicated header
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
> The definition of struct scan_control has lived inline at the top of
> mm/vmscan.c. Move it out to a new mm/vmscan.h so the reclaim-internal
> state can be referenced from other reclaim translation units without
> duplicating the definition.
>
> The header uses an ordinary include guard and pulls in only what the
> struct needs (nodemask_t, gfp_t and struct reclaim_state).
>
> mm/trace_vmscan.h includes the new header directly so that any
> translation unit pulling in the trace events (mm/vmscan.c, mm/shrinker.c)
> sees the full definition of struct scan_control regardless of include
> order.
>
> No functional change.
>
> Assisted-by: LLM
> Signed-off-by: Ridong Chen <chenridong@xiaomi.com>
> ---

Well, vmscan.c is way too long, so moving some common
code out of it seems like a good idea, beyond just serving
the needs of tracepoints. We may move more code out of it
in the future.

Best Regards
Barry
