Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795579340;
	b=UhzkBThqaXdYosFNlld0lr/6VJz5rdnnQtEn3JGP8DWsgXFEI/M0FeUUKlakUppFl7s1
	 irw/m4+Bl7uqE6LbBONt3owK3rrj6vVP+AZM7+DTiUHpJDg8bRhkDSrwdXosGGyMl33Z0
	 fZ7np7ZSrVyjfTer3ZJoS3sRhSCOTH8a26CSID+aKtFKJv9tiT+fkvjHkxE99XAMUOrsA
	 LTsiUr9DcnmDeE5dXWN/N0cu3KTJgsziB49dwHbSHg9XDRk1Nrwzao8NWrdikeq7K+nsT
	 kbNFEWps7bvBXvCoCqEpkbR56L/pm42XvxXZff0XlmnjlojRGhvGZop0iu8NOH3SvtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795579340;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=b5t7kT/F/kUHuHqqdf7OGhwe+jg/XQAt4FVRvgQFTFM=;
	b=Y6r6UqBBW91LC7xhtILdh+wB4m9tHKwC9SIujSmkPjL3GVbdnUbSCy1UJ5+qCser3Hlz
	 08gA044sowwNYMFpioYNZz875JMbSMdbqqedjXMYnkAMJ6A+PWI1dPiybqNEC9vyKz9PI
	 1u78BRO3MaTThvp1cjPNqqrGPDVD6Xzln0WiBVPfBulP9U5gM8H9aPv04ycfeyNleQWOB
	 EMZ6zAN0Fj58A+v1+hdd/NjpSmgc1xlafUAMlUvjs2atsZei7ga739zqFp6sUsJe8mCrv
	 PScZ8i8V4gJyDLy9T3/30cItLQCyWcfHomu8uq2k5U1xcE4G1T3l6B6rdZYd88NfQjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qmUGcFTr;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F91606A321
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 04:02:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59F91606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qmUGcFTr
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3b405d8f1cfso2652333a91.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 20:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795579340; x=1796184140; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b5t7kT/F/kUHuHqqdf7OGhwe+jg/XQAt4FVRvgQFTFM=;
        b=qmUGcFTrSFIX5w53DMBY9t5NDLbT2ffVFUIqR9e8b+NYuBntScGuFsq6u03S0Cj9yL
         zAoke3NBJsIg0FUTzu/6hCvixZqaN3uZarKeAPeG1hnMVEDQ2jQQ8pq9oI4AkjLBd2Xs
         vwVj1E2c7rh89Qic3KEQk/m7YiDLYLk4tA6BGapSLVa9KhQ85oZVCQoxq9BCyHPHCS/q
         oUYtbqGO4nT1PtgxTiec2U/CaZRTLhp9HAN7lYtDu7gm+YNqou7O+IICYK2Qu0jRbgLP
         xCQtkWU8trttJFbcLUPjsWoelPhSR6imrKeqEYwDPLLFa9eiPnoPMBuDSA+wXdvnHi8T
         lTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795579340; x=1796184140;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b5t7kT/F/kUHuHqqdf7OGhwe+jg/XQAt4FVRvgQFTFM=;
        b=QEPP6d0rqtOvKf93yC82FX9j/Ey8mL+WJfMFnoYuqe5JUcNMgTcvDXmJMcHOO55nBT
         1uPVlRCwjFytashjI4KjJnuBUkRPz0p6CzufHYrwakz7wJyRFYcxpOqzh9JHpMZQ9TEO
         POaV5ZiJFTy7QSgryoC4mgP56clvI/Tl+CtzyJMdmx1b8QS5OD3ffrPiBun8Nwbw54P1
         QFF+txGFQdneJvG7nlMEiUDR6HbqYGqI7IR7bmiXMHfoUoCxcqPAqzBGgCoqH/bbS0jG
         kTw7lsZx9F62d/76M/UP5+e3vLpbDr9LwebyFD+YKCNaQ5/3rIHqDB2v3zyeF7rgBPVx
         7bxQ==
X-Forwarded-Encrypted: i=1; AL+hErGNHscugPUEgYANJp6DsJRDLqjtQmHf/jK12uX/OQ1luz0xFQSJvG11PpBq0y5OzQWbjTZ3aLaD+yWHulD7XkaLP7o=@vger.kernel.org
X-Gm-Message-State: APuU4Z+9BuZM/bRDeNm5iFU7n1RZPO8INpJckKG2ynWoFlVI79haDh58
	AOakk+dIA3h7XjWENhE3KrogmVye1EGBCbqV0mKN2rISGavWZGjnpbig
X-Gm-Gg: AZFdTZeYxHkmJ+0J0Y6M79z7pvUarWkOtWrgTpAr9hnnYl2P3FfehBg59ecPgMuLIs7
	C3W5MFhLXiR5mAFQ5wItHVmESKfTXx+4vc8u+C5UBTW0mwn6usbZVht7dN7a+PR+iG3QPGt+B63
	bCeaOD8XqPX7Nwc7jXfdrWCmSD5DLy8DV//6rO40+fMONHbAobZAF9UhHKY88+BIXKlU2Z6AhSX
	LdAxag/MfZ1WRV64DY6qHWnPiTm5h10G712BgzRFQnjOFMOA5Pv0DRu0flhl2TcfjO/sK4dKqjA
	9oKPtjM/TvUiDIAP+BG3olifmyxNFJepCmeU2fMvUk/ouNybVgYEYlHSHfRMBjlexfUe5lgngy3
	6UDa9JBOxEtBimbbDw94cax+ebezwb/QBzvA6MWl1IXt1+64/7ubiTOTTwnn0NzUwXKJKthZ3LY
	SkIhoKaYSuPrZ1Qob1Fs+YCnPWYstKUF8PyVNOcQ25CRltWjaAaeVjNyivlUVTtK9eB+uuDrEcW
	tvinFGZBLaNI5zFsVc57Fdu0BAgC2gipWhC7gggekgQgnoeCq417YXoUCirVpwlUcJFIfO1Gy5L
	YkwOpDKnpNK4BS/u6fGDX54nYFsgpO9uJLVyIKYF4S8d0g6dMUNT7FcQX0RjDZZeDhRbgV5A1Vq
	xLoPSLVl2XEOHfFOgJ2mWtI7qbAPn4tt7BcY=
X-Received: by 2002:a17:90b:288e:b0:3aa:f875:3385 with SMTP id 98e67ed59e1d1-3b41c907e21mr15006021a91.26.1795579339396;
        Tue, 24 Nov 2026 20:02:19 -0800 (PST)
Received: from localhost ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40578dca0sm28765330a91.2.2026.11.24.20.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 20:02:19 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Nov 2026 04:02:18 +0000
Message-Id: <DN3ZR4IBQUKK.2KZHQUDH3ZRAC@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "JP Kobryn (CrowdStrike)" <jp.kobryn@linux.dev>,
 <mikeba@sentinelone.com>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song
 Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri
 Olsa" <jolsa@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Steven Rostedt" <rostedt@goodmis.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, "Martin Kelly"
 <martin.kelly@crowdstrike.com>, "Andrey Grodzovsky"
 <andrey.grodzovsky@crowdstrike.com>, <tyler.wilson@crowdstrike.com>
Subject: Re: [PATCH bpf-next v3 0/4] bpf: Check recursion per task for
 preemptible programs
In-Reply-To: <44034fa7-91ab-4777-ba72-0037a6932b56@linux.dev>
References: <20261117-bpf-preempt-v2-r2-v3-0-586376ec3672@sentinelone.com> <44034fa7-91ab-4777-ba72-0037a6932b56@linux.dev>
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Nov 24, 2026 at 06:06 PM JP Kobryn (CrowdStrike) <jp.kobryn@linux.dev> wrote:
> The patch below is a proof of concept scoped only to x86_64 trampolines.
> It was validated with the bpftrace prog that precedes the patch, along
> with jited assembly dump to inspect the new private frame API calls.
> Overhead measured was roughly 60ns, but this was just a first take and I
> believe it can be optimized especially in the JIT area. If it makes
> sense, this could be integrated into the series or sent as a follow-up.

If you want to redesign private stack please take inspiration
from insert_arena_stack_get(). Much lower overhead and no artificial limits.
