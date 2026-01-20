Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093333314DE
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 03:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768880397; cv=none; b=Yis9Zs4A/rzgcZhtl74EWBK/zAWjb5bEsIjjyZgMejy+HhW45EgTljAAylufm3l7gPAYvneJqB3074ChH+G0+AYmQXvwoXaLg1MzK+za2NTOdwhksxtvn/RxJMnOCTrB3naIDGySQad3kv4jhsX7vvX0vA03Rc/vz5EhWQQaJQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768880397; c=relaxed/simple;
	bh=PkQnT9HrASsJc7IurqBQq+Uzv9yailjV38eVPJVHhAg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=EytkeGOc3mhAANKAQNKLpuzvFhzPt69QxXtUCwHS7HSiX4TPTMFB6QYkEtSZBn0gGHpt0bFloxFwZ3acPnTZPIKhT5hwoPONMTgHSuKnQWsOzZWU63HYnhvZbfJrooHiHZ3GSb0pEU1Q8PEvB2alW2H1KbKnRhrTnEtPrZZa+oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gw/BMzIS; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gw/BMzIS"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64471fcdef0so3932124d50.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 19:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768880395; x=1769485195; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+f2e7dJ5whTj9SkU/TlgqUpo4cL0LQRd5uYBnJ44hS4=;
        b=Gw/BMzISSY9TwPlVTqjdrPv5xoy9IucnPOywTAMIcOG2d12GuE3BvIM86jkEIbbzWG
         jpQfag4w2e4OcO7fVhb82Tjtz+ElJSnDDkyjXAu43uJK5vVfwcnHiJJUyKUf8z8+5IR+
         ErBQ5n6LqGlXzEtzS2F3wWMRj2F7UTcD6E6/XRnDugIhEVvynaqHWLQZtrQ8po/oN3KV
         y5kbkfdOZZSZRtz0wHQVRcklTCp1KWbX5UXdKBG9bHhL7aEcdaqiokMuDW7n04SUGRXw
         BkO9TQs5GWdB/TKji+PeaIXS+mlcUhQdE/GFtMW8BktTG+Y2Lu3w/rzkaUe91V3llMjG
         6v1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768880395; x=1769485195;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+f2e7dJ5whTj9SkU/TlgqUpo4cL0LQRd5uYBnJ44hS4=;
        b=mrztZjkZ69U9aBCJ4he5n8fgu13harPoQyDxbev344GP9oB/vkVFaZ1SsSX8MmzeQc
         T5djvepeJBdBFk9K6W0QZJ+JkB8/0QNiKSlW1rXCL4bx5PRTro4UUB5VFcMu+SbIrP+R
         S4ED3D2aI4npmqH8ab2Z+ySJmxTmOjZYQQaLznjzcu4Ma2KyUF8nx2wuHlfZps5KirIz
         xyWF2r4/sFG/LAXqdH6h5s8Sfn7pIrRT0MUhnLwZ28R1F4MPWS/9e9z0Yir5mXcbLrVq
         SUSJsx6RBIwapQPuuCZBucK8VsZCp4a1JqC3wRYU3Tpy9k5bb3amYFNMSDyKk+yESgWv
         cr6A==
X-Forwarded-Encrypted: i=1; AJvYcCVYV3Kh6ZhnjmFBz5MlqHef9G9DBRHn+Qt8yqiAg+RpvSZWB1ixsA2znOxASu9of8Y6WHlsO6QM0lJLV/VfnECCBaM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8nZWRvwZgNKFvYGV41+AwtmAnAc9x/MQasHaZEVQdczsbCMM8
	O9QPjfwz1OIczW4PhySsWWFsrMad2REw4DD2PdMS17tIAnIAcNJQ4Wbc
X-Gm-Gg: AZuq6aIXMiexcXKzY9E4aepxGgEbtO3+4/757ylSmuQi79ixDaT8V9wCAramV0dqBj1
	dCdsyzgazSqg4t7fgHyhYRA3Ho32bvm6aNaZvUJCQhmJQkNFyPEtj15pFKs2ADA2eH2a7O/cNnF
	CyzKyFp651cijq8U4CA7eIFGL2VK26XLYz6bocviz7iK0Xy+te4ZnFR4qQ72rW+/eNLl/6Gjntj
	/rdSTx29ymi6qM+z9zJYeR6ueeClF2x4Ljs9iSeWBwzFOIMQXa5lnkQ/yEKPh6Jbscq0RgvRwPe
	Cs/hjK3CmblDbIkzne9v7yCw0oHJbPNCMQ5CdubnT0BFlScR+zQ5JrzTGQ2MJ2GETXVn/xDZpxw
	wINmRJnCo3TtZoxZE1blnf9XX30oJhHks1+5gkv8xlncPdu45tZcGQxSVQKc/TAbhAhffEaGqs6
	X9XdP0X3LOtVV8/zx9k3FJcLTloGBJLKi0VU8a8d+K7uCHBiykvSF7MFlVONuH3qbV2TU=
X-Received: by 2002:a05:690c:dd3:b0:794:35b:af5e with SMTP id 00721157ae682-7940a0e6771mr11618687b3.5.1768880394417;
        Mon, 19 Jan 2026 19:39:54 -0800 (PST)
Received: from smtpclient.apple (2607-8700-5500-8678-0000-0000-0000-0002.16clouds.com. [2607:8700:5500:8678::2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c68d305dsm47643947b3.55.2026.01.19.19.39.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jan 2026 19:39:53 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH bpf RESEND v2 1/2] bpf: Fix memory access flags in helper
 prototypes
From: Zesen Liu <ftyghome@gmail.com>
In-Reply-To: <55f01664fc714615206cc8d100cabf4f310f2302.camel@gmail.com>
Date: Tue, 20 Jan 2026 11:39:31 +0800
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
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
 bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 netdev@vger.kernel.org,
 Shuran Liu <electronlsr@gmail.com>,
 Peili Gao <gplhust955@gmail.com>,
 Haoran Ni <haoran.ni.cs@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B91D5A7E-4967-416D-A2AC-CD3428F3C702@gmail.com>
References: <20260118-helper_proto-v2-0-ab3a1337e755@gmail.com>
 <20260118-helper_proto-v2-1-ab3a1337e755@gmail.com>
 <55f01664fc714615206cc8d100cabf4f310f2302.camel@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)

[...]

> On Jan 20, 2026, at 04:24, Eduard Zingerman <eddyz87@gmail.com> wrote:
>=20
> Q: why ARG_PTR_TO_UNINIT_MEM here, but not for a previous function and
>   not for snprintf variants?

For bpf_get_stack_proto_raw_tp, I chose ARG_PTR_TO_UNINIT_MEM to be =
consistent with its siblings:

=E2=80=A2 bpf_get_stack_proto_tp (bpf_trace.c:1425)
=E2=80=A2 bpf_get_stack_proto (stackmap.c:525)
=E2=80=A2 bpf_get_stack_sleepable_proto (stackmap.c:541)

All of these are wrappers around the same core function bpf_get_stack() =
/ __bpf_get_stack(), passing the buffer with identical semantics, and =
all use ARG_PTR_TO_UNINIT_MEM.=
