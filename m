Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881452;
	b=tDSoRH5WJEEuTKuEDkmYSu0yI722bQRy+cVHopqYmjwthZp6LjeeSHjbJ/yB/LqiQgdt
	 JDrdnm7dSV1EOLBnydb2m7wpd5GOLPhBl3QGZ+u5ZpCN61EUVoiiDs+9GJojXDcqrPePu
	 I4q0ptXSkqIUchDTPl8qiuMLlEFqp7dB4yVeDeREBmOXgRSlfA5nvSZwc+w7H1znnQlfP
	 k7kY0xgyuZoz2XhQwz+iu345Hmat+dJFSh3/oqt5pRjYsUyljPNuv0i36GYcTQlq+NYe7
	 JEn45tNVf25xM3lEDYG1swZLG57kG8ptlhbMxUNwdAR9UEgLQH8tnV877xBsGuttsFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881452;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Q8beI0u60Egzj7ijn/9kD45H6hqY9wYVgWCRUWY3M6k=;
	b=wb8RwPZH1FB9vviaJ1HS546/qiPWUk7oT1yiUmzGV3uNffKRlHEVeAOPfv5E4Vo/pp2n
	 Q+F7TSFu3Z4aZk9vCJxCnPsGIzfl8db2gXG4fyDOpxZ0w9q65hgDA6Za2dchfRoT4lb2s
	 fecjUqa0+qYChWC1LGXtMOdx03jHTj7pBsoBEqnQyj/gRI7pjKQO6K7sIt5StyS/k9xF4
	 7UAMPBmeTpDXQ0dxArHbD1jasnlJRqKnjeeqU1UCjPHc8H9ZZqZwvhq3TN7Zze60ZiShq
	 5E7Q+wJHt801/BK45gVFcuskybJHH0rkmMkLAJQHgOJgYGOZpppnCV9SQthV7D2Ph1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UFzp783A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C266606A31B;
	Thu,  5 Nov 2026 12:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UFzp783A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E7D1F000C1;
	Thu,  5 Nov 2026 12:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793881451;
	bh=Q8beI0u60Egzj7ijn/9kD45H6hqY9wYVgWCRUWY3M6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UFzp783AeTJX5IhpDz7J/Nf4Td+VOJKGuxCc9LJG3fxuzkGPeHGOWnUA6M+9sI459
	 XzJjgMtYMWR8xwcOHME433BF7WWegqPtwC+ItYLS8k1T3OORG/oBfHaMMSvPN3L4ox
	 NKSIvkcAK7SmDwMiWpoV3i5b24XNve5tXVA9moXgtrJdq9dhEx7uj6eInH8yrx4B47
	 9UdOCgTRBCOllToulK7xV180elIeUBMSKe4/2snRjPGDRBuey9PrVkumBcgzKD8fU+
	 WSYixATf7rTW8IatJtguSdwKkJw94hZC87bry7U4ggOUsw3VjRRqFMZIwXi27i2YIi
	 aRTMMj0z41/mA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Zhiqi Zhang <zhiqizhangg@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] tools/bootconfig: Test listing keys at the maximum depth
Date: Thu, 05 Nov 2026 21:24:09 +0900
Message-ID: <undine-1793881449199211465-434027ce0a1cd644@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261104073742.21202-3-zhiqizhangg@gmail.com>
References: <20261104073742.21202-1-zhiqizhangg@gmail.com> <20261104073742.21202-3-zhiqizhangg@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Wed,  4 Nov 2026 15:37:42 +0800, Zhiqi Zhang <zhiqizhangg@gmail.com> wrote:
> Check that a key with 16 components can be attached to an initrd and
> listed in full, and that a key with 17 components is still rejected.
> Compare the complete list output instead of relying on the tool's
> exit status: a failed key composition currently stops listing without
> changing that status.
>
> The existing good sample checks exercise the compact tree renderer,
> which does not use xbc_node_compose_key_after() and therefore misses
> its depth boundary error.
>
> I wrote and ran these regression tests after reviewing the fix.
>
> Signed-off-by: Zhiqi Zhang <zhiqizhangg@gmail.com>

Thanks, this also looks good to me.

> ---
>  tools/bootconfig/test-bootconfig.sh | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-bootconfig.sh
> index 530ce7e28d63..d19747e47890 100755
> --- a/tools/bootconfig/test-bootconfig.sh
> +++ b/tools/bootconfig/test-bootconfig.sh
> @@ -100,6 +100,16 @@ xpass $BOOTCONF -a $TEMPCONF $INITRD
>  printf "badnode\n" >> $TEMPCONF
>  xfail $BOOTCONF -a $TEMPCONF $INITRD
>  
> +echo "Max key depth check"
> +
> +printf 'a.b.c.d.e.f.g.h.i.j.k.l.m.n.o.p = "value"\n' > $TEMPCONF
> +xpass $BOOTCONF -a $TEMPCONF $INITRD
> +$BOOTCONF -l $INITRD > $OUTFILE
> +xpass cmp $TEMPCONF $OUTFILE
> +
> +printf 'a.b.c.d.e.f.g.h.i.j.k.l.m.n.o.p.q = "value"\n' > $TEMPCONF
> +xfail $BOOTCONF -a $TEMPCONF $INITRD
> +
>  echo "Max filesize check"
>  
>  # Max size is 32767 (including terminal byte)
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

