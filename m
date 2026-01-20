Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8603B4418F2
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 17:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768931705; cv=none; b=Y66CWQhRMv05vdydYlSkCSqFsUip/mv7AsF0IzHKCWpMM/IaSX8YZDgTYDSQ6nRCxj1akv0kC8J/WmY4WWUwV5eok9ShVAvnZA4MplGVDp+H6jybMB5OPSGtHLY/cAo3YiOKrf9OMifAA6bgjbABibwOkr+vFrvDsdQkbbKAqkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768931705; c=relaxed/simple;
	bh=KS8mCNBYfPwO900RIuZ97F5SmyGc3OhWN2Izos81IfA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JTuZ7vVE5xe5VpMZH6KmckuHHaKyKuJHWqFyoS3BdJ0LMtZKF8hmhFj1B+e5DMdK8eSUXD+O0F97AX/sgY6Ga89uPkPVrgDDPLWKazj/mEUrYIRB018tjUK1/uGgViYr1QuV0w9OzVRVX981O6kusdt+LGWoFqu18ydg40zCxsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdsDEYyp; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdsDEYyp"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2b6a93d15ddso5545297eec.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 09:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768931704; x=1769536504; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1Zkk8Rbl5UtyAFvKLFxnlSYhtBzOt3i2r/yOWe3G6LM=;
        b=QdsDEYyp1nQu9i0VDh0MQvtMzZTlMZFk2coVgfRqGYRlBEY4B8dnMGIuA5hXrTxEC1
         JMcsTejg5t97f1JRitW3HI720QK129l4Z8qQ7Mwn7GPgBHyR0DjOzxBMlMqZLae2bgke
         HXRdYqR80d0rnZgaReH64BB24/LXONjR1AbbctU9XE9jWp7Xy8z2MTjCykKT8kOxN5wA
         jMdpdUaTRbeG1gsVjhb83WwWhWz+o1mymhF5fR6U28pIlBMT5nbMsdM0qwMwlJw1L4Gh
         tgrIknfldBiqB04DraAusko5duhzhR3ZP1504Yjl8kaT0iSIR0o1mCyFQE0RPjxBlawb
         yU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768931704; x=1769536504;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Zkk8Rbl5UtyAFvKLFxnlSYhtBzOt3i2r/yOWe3G6LM=;
        b=Pc5nKJi0EPlqLsVGA6bXgO0JXPPgmc0Gdy04QwBzfEKxj+FA/QZ7w37uLMsZ4Wces5
         xViMd53Ieh5t55PI94rX3v/7wMms96u3nWucJLWSpX/+jutivIDs9qvrbkY9F+bFtNSW
         Dc1V8IOD6AXigEzpA0wWLpaq3TBqLpYpR3H2G8MamnI6P646RUkaMmdrz980PHwCKp9t
         0tcuz6xStAWlPJB0V3LhW+m/cEAxmEFAjoIvPeUZB5PjfcUcqHNjSotFAQCoiODaD2i7
         kHhlOLJZEuHRc0WxYBMffzGPKpMZLo+U5j545W8EWbm9y/jNWVPEB+Co6Gh8MbIvo76y
         XRzg==
X-Forwarded-Encrypted: i=1; AJvYcCXgwjqcTlJ7LhYmRjjEV71M7fBXBfPXkVhJgyyc4LzlJMy4GGXNo5ezhWUxs44aW0F+OC0AYzB0rR1zQp23lt8nxd4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbi5xCEqczOtVQgkm9c2tX+TE0nqzVK7qU7bCvgp4m7+Vzr3BO
	v46NgSLw1RJA6ukqrjI0ceZgD0c381xUa8i2+mC9KTQedFkya9rQL575
X-Gm-Gg: AZuq6aLmo4537eSWkVNcUrjaRQ6hPnddBh9q68p5vCAXxgEwc15j0UOQdi+kOO4kWf9
	AfZ16g7W5KDhapDImb3vtivAyP8qlCTxwblx6w0slRJAalhpg+Vne4VBBKpCIajskLlsldKtpMh
	YCflCYQ7xKvTSRcfDW67OvJtH1WToL9DoIwVxA/22VG4s4+wXiHrQR0SBBMIoJFPCIKlmfWhSHu
	fezusB3Tfg9FqfMNfly5bvcdsAmmMikV3iX8wL6C8nJfIy2YAuYyTTPPQaQ0S7Lsn+uDMzlQhv1
	eLn/og0bYBcs5O+FBGYszai+XKQJD/MSRPKLtYLBEa7Clbh522OLEY/eG7WML/HUzty+Auz2Ioo
	JpUIr+oumHA7CwEFIGH8JmJrplxbVeGz0dHJ8Tr+2sFNCPsPQGJSl/MgnylFm8phOs+Fh9qRn/Z
	jag8rzKhnZpJ/XR/e9BXcX/oI2bOjlIn+lfSEmUPpPQC1hBd52k7SrsNJhVXDF6LblCcu+
X-Received: by 2002:a05:7300:6ca1:b0:2b0:5a77:5753 with SMTP id 5a478bee46e88-2b6fd78df36mr1990065eec.21.1768931703406;
        Tue, 20 Jan 2026 09:55:03 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:b08c:bb3d:92b9:704d? ([2620:10d:c090:500::3:93b1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b34c0f7fsm17960598eec.3.2026.01.20.09.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 09:55:03 -0800 (PST)
Message-ID: <5ca8756f0387e5b2be47e9522b1f4b5fc149768d.camel@gmail.com>
Subject: Re: [PATCH bpf RESEND v2 1/2] bpf: Fix memory access flags in
 helper prototypes
From: Eduard Zingerman <eddyz87@gmail.com>
To: Zesen Liu <ftyghome@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh	 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo	
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski	
 <mattbobrowski@google.com>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Daniel Xu
 <dxu@dxuuu.xyz>, 	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, Shuran Liu	
 <electronlsr@gmail.com>, Peili Gao <gplhust955@gmail.com>, Haoran Ni	
 <haoran.ni.cs@gmail.com>
Date: Tue, 20 Jan 2026 09:54:59 -0800
In-Reply-To: <B91D5A7E-4967-416D-A2AC-CD3428F3C702@gmail.com>
References: <20260118-helper_proto-v2-0-ab3a1337e755@gmail.com>
	 <20260118-helper_proto-v2-1-ab3a1337e755@gmail.com>
	 <55f01664fc714615206cc8d100cabf4f310f2302.camel@gmail.com>
	 <B91D5A7E-4967-416D-A2AC-CD3428F3C702@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-01-20 at 11:39 +0800, Zesen Liu wrote:
> [...]
>=20
> > On Jan 20, 2026, at 04:24, Eduard Zingerman <eddyz87@gmail.com> wrote:
> >=20
> > Q: why ARG_PTR_TO_UNINIT_MEM here, but not for a previous function and
> >   not for snprintf variants?
>=20
> For bpf_get_stack_proto_raw_tp, I chose ARG_PTR_TO_UNINIT_MEM to be consi=
stent with its siblings:
>=20
> =E2=80=A2 bpf_get_stack_proto_tp (bpf_trace.c:1425)
> =E2=80=A2 bpf_get_stack_proto (stackmap.c:525)
> =E2=80=A2 bpf_get_stack_sleepable_proto (stackmap.c:541)
>=20
> All of these are wrappers around the same core function bpf_get_stack() /=
 __bpf_get_stack(), passing the buffer with identical semantics, and all us=
e ARG_PTR_TO_UNINIT_MEM.

Ack, makes sense, thank you for explaining.
