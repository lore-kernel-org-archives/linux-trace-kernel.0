Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792551887;
	b=YeR6/SLNOHd9IUIwxASH1jd+WgLweiNXkrLSLzIj3RAJ0MBBumTsbULBKp/AcG2FsF9U
	 ekfIBaBEZytB3iSarYpW8ZItDihZF3O/PgDvrvc1M14JwJBkI7tslpIU98xYwAqxP/0+o
	 arsHfyvieQfzf5Q74vIVaz5D5pD08luJMGHIHXZocgbs5/cp+tRlYhiuPRqvhz6VL/FaP
	 YLCtRqMqWxjwhXMdkmvOVqJkjjfI7YFTMh3RrkQCFyHxqAGjKyeHrb2pdlHBhtEQ9DLzq
	 6i33fAFPX1YeIjD243TkAn/5ubOBdAsm5NktCcSqTQ7ypSVQOgMsKyNnOacaQ782gFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792551887;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Subject:From:To:Cc:X-Mailer:References:In-Reply-To;
	bh=rc5wrhUHr1AVoBfBDZ+r5qvZgVrRLeIPWk5f/ArMKLg=;
	b=m5YJEfxFRvXNwNxXr6x6Lg2CMxMcpTzZ4UQPj7CQlR98NZZXczh3UgbUSRXdV5Hu1ayi
	 qqvoTP6lmEAuAdZrtV7wNITYOZ83QVU0tMDFLedxtIHqo0ozBnipDTpgwTSJWdvK1TlPH
	 pjPDkA5sR6z9A/AsSdpaXCjWTrE3xOqAX/829p2BRYdRbCz0E1W5XOwp0IwLBbxxbTex+
	 y6WCYrXG67UnJX1LaoByW2+aLhtQLqhzpAhHagE26IFrKfeF1re+l/PAu9tQ02J9j+pcx
	 Mm+bB4BwyVDZIspnJXIBhca3BvRREBdQv0Yo9DZxbgu6dDxkKXr8wsrRGhbEes6AxuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PuGDi+yC;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59154606A31E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 03:04:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59154606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PuGDi+yC
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc4aa0246b7so62390a12.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Oct 2026 20:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792551887; x=1793156687; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rc5wrhUHr1AVoBfBDZ+r5qvZgVrRLeIPWk5f/ArMKLg=;
        b=PuGDi+yC/qP1bGcg/TSJFrSAOJewAE8/w32VXn0pviJ9BU1AXHc+a3rPhPUuvSfVDm
         JR7tpDlII85BMuy9n3vyR4guPVqaMo0FxWhPE9NcoUQbhXT+7mMAI4QRfLXUIcqo5/Xs
         q6j4Gd+4w4vZcM5fGQi/8qw9VONKn+ZhsJ6qLm4IGL2EXDxGcJlYXGqZxwREBl5JaE7P
         l6vYVejnVU+p2Lwy4bfhWLOkJSbW+EYU4kJGgtyAWl+a57JCZRRlZ6MXcsMGDQJtdKfX
         UIsVQLX4CpWTz8Ys24LC4PJxBQF3aDGHBsiFJYu9VBoyLLX+g3l+ljvbGnceydfkRGMe
         hbQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792551887; x=1793156687;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rc5wrhUHr1AVoBfBDZ+r5qvZgVrRLeIPWk5f/ArMKLg=;
        b=iEjmHQ22TJJMLA3N9sfeZmI32KEscAq/yr1zhZNiDNkxDnqblp0bEyMWMx9PG1uqmr
         EjFlueV4GK6WD62sj2ZZO38NNf9BG2nfp3BqNoJn/q76IjMEUcweKOeeMjmWLiLvU+d/
         w9ITCIr4r9J3E6mD1FWIbOJp6jf46wR7yjPEj/L0m0P6+lcdIf64TU4tu8Ad2SjXV65u
         UmJzKnmm/s4TIG2iNxPSbxhhOmmZdwtOZkkCVjH67u9LTk6PgRT9LIFZQP7VfkBgPEKm
         MyKxy2IgX3F5cx/NlfMyQtvElggnQREIn7vtr5JWlmedpMdkmHQkLc9WrtA94LzkmpYb
         2kYA==
X-Forwarded-Encrypted: i=1; AKwUvByMhFlSms623uFJCpCliLvObxN5ywDxF7DWHKLrfQvSmcxUW5YyVrOP5GT59V/lTEImuJOf/Nj4gofOXIU/t09aNww=@vger.kernel.org
X-Gm-Message-State: AFq9FYLGWhk1HkwuTO2ACRik5ogQhWoL569CFjQ0xroOLsdj7qKlp2Il
	XD3ncM/kcEKiRW6iiqr0uFVuekdZaheU/xRPc0chcKeBQ+ZpJ9Y2iQQC
X-Gm-Gg: AYBFou0zmeksRdjjGnuZ4zfJQO/ecKh3UOddF1hUVyxjgRMpUPz0e/AIHOYxVHoHJmz
	1K5l2sEDxIeHvO6x913rrS5gvr0oO2x8YNT8VSMTzr6Pb2kCNr/vS9vdIXyvQcopGsh1sedvRoo
	I6UFltDy+FD3667UReBfFpdVT/FjPE8toSj8SnTFC1QVnfCP8Ks5qRaRaFnZm4ie782Ay0596Tp
	PeVN8zj9k9Eq8FBxnmgekVpJ+A/2bcQby+V+E0X5pKssrbG1+qfbhwMnXINzIrCnWkt/PYI2UON
	XO0+wduevbSnhqhVBJjTnP7WDd64St89FTnUJ++yMYRxHAQPqBaRVGARmAMsYHBwEfO5TSfX0ZK
	oYO/ytXpji+OJ168zsWWC/o6G32i8eo4J/PK1gBcqV2BxJzS7wFkVFGVo7abhKfSe0xF/heakgO
	GGqUuPH4jTf+Wp1KnNrMqiv3eYZcz72tNOHUmv6YHHrOdnyWm9Jk4OUdWnS+mfaQMnyO+2NEbk0
	3i540+EVpSgrS27Jw3AuGvgtktuket7wIl8s32OBMmeRKjn2BfmYVxYQyrD3xLVyD+BOcM+JGb8
	LjDL7SkQq8phF8V+x1qIacODFpwBCtTx38mD1HkYRyQhWX9VN+RcpwzNXS3tc2o0c9tUwelOL63
	tusBmgQ==
X-Received: by 2002:a17:90b:288e:b0:3ac:2788:cab1 with SMTP id 98e67ed59e1d1-3ad86ed22f9mr629222a91.30.1792551886548;
        Tue, 20 Oct 2026 20:04:46 -0700 (PDT)
Received: from localhost ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad8035883bsm1999788a91.15.2026.10.20.20.04.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 20:04:45 -0700 (PDT)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 03:04:44 +0000
Message-Id: <DMA6LZFMAQ3X.2YOXSMADL3LQ5@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/6] bpf: Add syscall common attrs support
 for xdp link_create
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jakub Kicinski" <kuba@kernel.org>, "Leon Hwang" <leon.hwang@linux.dev>
Cc: <bpf@vger.kernel.org>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Jesper Dangaard Brouer" <hawk@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>, "Stanislav Fomichev"
 <sdf@fomichev.me>, "Steven Rostedt" <rostedt@goodmis.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Shuah Khan" <shuah@kernel.org>,
 "Kuniyuki Iwashima" <kuniyu@google.com>, "Hangbin Liu"
 <liuhangbin@gmail.com>, "Martin Karsten" <mkarsten@uwaterloo.ca>, "Masashi
 Honma" <masashi.honma@gmail.com>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20261020152804.39863-1-leon.hwang@linux.dev>
 <20261020152804.39863-3-leon.hwang@linux.dev>
 <20261020182553.534c8d6e@kernel.org>
In-Reply-To: <20261020182553.534c8d6e@kernel.org>

On Wed Oct 21, 2026 at 1:25 AM UTC, Jakub Kicinski wrote:
> On Tue, 20 Oct 2026 23:28:00 +0800 Leon Hwang wrote:
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -97,6 +97,7 @@
>>  #include <linux/kthread.h>
>>  #include <linux/bpf.h>
>>  #include <linux/bpf_trace.h>
>> +#include <linux/bpf_verifier.h>
>>  #include <net/net_namespace.h>
>>  #include <net/sock.h>
>>  #include <net/busy_poll.h>
>> @@ -10771,7 +10772,8 @@ static const struct bpf_link_ops bpf_xdp_link_lo=
ps =3D {
>>  	.update_prog =3D bpf_xdp_link_update,
>>  };
>> =20
>> -int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *pr=
og)
>> +int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *pr=
og,
>> +			struct bpf_verifier_log *log)
>>  {
>>  	struct net *net =3D current->nsproxy->net_ns;
>>  	struct bpf_link_primer link_primer;
>> @@ -10784,6 +10786,7 @@ int bpf_xdp_link_attach(const union bpf_attr *at=
tr, struct bpf_prog *prog)
>>  	dev =3D dev_get_by_index(net, attr->link_create.target_ifindex);
>>  	if (!dev) {
>>  		rtnl_unlock();
>> +		bpf_log(log, "Invalid target_ifindex.\n");
>>  		return -EINVAL;
>>  	}
>> =20
>> @@ -10812,6 +10815,8 @@ int bpf_xdp_link_attach(const union bpf_attr *at=
tr, struct bpf_prog *prog)
>>  	if (err) {
>>  		link->dev =3D NULL;
>>  		bpf_link_cleanup(&link_primer);
>> +		if (extack._msg)
>> +			bpf_log(log, "%s\n", extack._msg);
>>  		trace_bpf_xdp_link_attach_failed(extack._msg);
>>  		goto out_put_dev;
>>  	}
>
> No, this is silly. We shouldn't be spreading bpf_verifier.h includes
> around, and making core networking code use bpf_log().
>
> Add an extack to this API and for the extack -> bpf_log() conversion
> in the caller or some "boundary crossing" helper.

Tnis will be a trivial refactor in the follow up.

