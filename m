Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C43F2C11DE
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 20:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768854315; cv=none; b=SipiU3dDK+JCs9F+T8jkaTG/dSj0PaU2f44llrma80anT/LYWGUGqPKQx7V9cSckdkZ6+aG8a7WbQuWViLAy87tJUtXSkhBJTh6ZOTCYgvZP7beL+bOsB7iM1SSnQvTde4CyF7XeBnh8+y0bcMdaMulxkuti2h9vYj0M2mszzE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768854315; c=relaxed/simple;
	bh=qVlx/AweOaEi5+Z6aS/giYLu5HeFuCMEDO6+VmV3i/w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MwH3g30v27pO2+xZ9BEBbqcjWRC/xROtS2q/J2SDD39Pzgdk3lMG+eYEDAmU10yctuItqoW6l7qP1TFG3kMAWSa9cs0KzeiUpBJtRsCMuXEnCPQyj7eaW/ay5vglQD0EQmy0KDEG9gB+2RnSnE/ysyUYfu/x/IxZu2ofE5vVkxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8u+qOr3; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8u+qOr3"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2b4520f6b32so6268020eec.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 12:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768854314; x=1769459114; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QG6Vcjfp6R7A27lQkwL0j3R742MpCwEPC/xPli+XDhw=;
        b=J8u+qOr3c33nkTrO/FNrTlYABgsy2wG5cciZYv7758lRHgkr5rztJ2R80bYaA0xidR
         w2N+PKX3e6zSuEMaTcRgdAARU1zr0H6VH7wTd6wTnAHmL42H6rAZ3s5TOMkAotC7Gc5E
         OkkZigebUaBrIVqNt6qgQwgzHVrwKTJq68hS1jDBo/wpKrIx0zzpwZnAQiKqiN9LDhCx
         783CrteznpqDND75SauR193UlKfM+tbEti8IrDfZlsJ4Ta3fzeEExuoPK9tUMn7Kho3e
         QBLUwnsFA2W3E3Hnc9ngGyDwfJ3ZpszR7wd8l5se2QckRsU8Io+OL1IdqtNsPP0ZzWjT
         sRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768854314; x=1769459114;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QG6Vcjfp6R7A27lQkwL0j3R742MpCwEPC/xPli+XDhw=;
        b=Ls3TPO2moGM5z6Z2yFOp+8WK1VfflciW2hdrLAGXA7NMuR22QyyTyD/FWpBcgloWsd
         u01JKEcZNoAe1JydoXhXS904k4vwjXAKem9qdmD+At2vDp7gJhHDxEhmV++pFlziJciv
         yL2slL/Fqjy4KlIDuUhAJukHYK9L7mCsAwgB57JqPSK9JcmIUZy8A3m4dBQCMtKRtf5r
         wnN9qd4jzeLamCPhs7G1o4Mlw5Z1ImrNe7Y6z9CTtp0Utt8foE6jLGCea1CjQmIl5Dsu
         BQViFOeTB98EmrD95Jkhd5u8OpIx6Fyw3j02nolDDlcbLL2U6z3my9uXitllkk/NfXFs
         wHRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvcPv+Vtw8FVn4tYSsK+GGA/4+FEB1XeHYiUyV0c4eiw2vChKsa3S3qCR2Rk5kttx+Sq3qPpyJD+It1f33CgxakXY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6rrfkrtt1Pg6d2H3lV2gYsiYalexRXVL2k+bRwKW4KwZhmj4x
	HKFu0IYMmjZRo7npHkYOqKoxGbTQVTZa3hPtD8nJSrbooZQZjM+galuW
X-Gm-Gg: AZuq6aIcEstKmyVAWUUze/JfAf3/za/9GnoPDW/IMn6rPpZZf7KOjlts55hXzCpI9fq
	hR8CI6L/DGHRIIUTCJlrvoHiBBtrFDFH9DZKObO+7P0quQtt/I9/Y6kWZlyyZ+Np3pBv2O3AS45
	UWA+JEUbQiHmZ77+80gWGtShNqNxKiAuOIK01SziBWT6bfRxaSqk0WIC6VJH7whPPieKsCV6gjd
	LWquW9GW+PMGEMgDdINhWV11NwR5+SlWiM11EFAyfqUOrYH0Tz4AdUUBJ8fhg4PxtKzJJAI44P/
	Js9wLuR+qXtDRHM+kIFWZVtYXuZ3lK9N/M3JVF2qIgYGM7xpfzRplbjCsPLH8XRn3y2SHAaDE17
	UZQhOqcLuBiLivJWK7dmj4OJXVt8VqW313BA84rMLX+CKrPiW6k7kuNcs1bzhvJGBWjw15vY3fb
	lpcx24q7vkegDCjcwWfpA726YxJDWxNBZnQ6ndDT0tCqW+9W1kN+jJ4+Olq0FZx01PEQ==
X-Received: by 2002:a05:7301:4184:b0:2a4:3593:466c with SMTP id 5a478bee46e88-2b6b3ec9ddfmr6785656eec.8.1768854312077;
        Mon, 19 Jan 2026 12:25:12 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:4cd6:17bf:3333:255f? ([2620:10d:c090:500::aa81])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3503ce3sm14350271eec.12.2026.01.19.12.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 12:25:11 -0800 (PST)
Message-ID: <600177c05c552f470cc5e25c7dba6990d96790e9.camel@gmail.com>
Subject: Re: [PATCH bpf RESEND v2 2/2] bpf: Require ARG_PTR_TO_MEM with
 memory flag
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
Date: Mon, 19 Jan 2026 12:25:08 -0800
In-Reply-To: <20260118-helper_proto-v2-2-ab3a1337e755@gmail.com>
References: <20260118-helper_proto-v2-0-ab3a1337e755@gmail.com>
	 <20260118-helper_proto-v2-2-ab3a1337e755@gmail.com>
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
> Add check to ensure that ARG_PTR_TO_MEM is used with either MEM_WRITE or
> MEM_RDONLY.
>=20
> Using ARG_PTR_TO_MEM alone without tags does not make sense because:
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

Note: this patch no longer applies properly because of the change in
      the check_func_proto() signature.

[...]
