Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F0330FC26
	for <linux-trace-kernel@vger.kernel.org>; Mon,  8 Dec 2025 08:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765184381; cv=none; b=T3YvZZhKXnyIz3ql2MdTYzA7/LID4vNEjaZSkvEWI+iE45VaT+G03+JUDS7fTKH02ruHsHuM4F5VFFJPjB9Lp7e9p9BCMqf2s3tNejWk2jJgikOTN35uBGEzcm7KI1rootnQxqJkEFs/M+vJtT3heNqO6paXkMJSqrqRJZFqGH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765184381; c=relaxed/simple;
	bh=AbAfQOKVKOhalJr0SBhMWkxZEAPXtQJWY8iPpwPxZ6I=;
	h=From:Content-Type:Mime-Version:Subject:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=sU97n/u31ncKjms4tqwnNI7TlfUeG+qpDZ2vN5IYmi51QLy00kjNJ3FjEXjqw6CX4fL0uvAxfASKGTL/aCFSN6+y5hKgXOMwbIv1GWnDuN77+t9iH9hNT9P7tBxGPSFmIv/t4nYGwPTBvRKE5DSg/Wi2FvOXkzcWSgWg1cIe22A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ic6L/uL7; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ic6L/uL7"
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-3410c86070dso3268836a91.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 08 Dec 2025 00:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765184379; x=1765789179; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:subject:mime-version:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLUMcfa3m0yMke//cJjqI8fSMt2SaDS5xVKgbYRpXg8=;
        b=ic6L/uL7CuwC17cyOgu+xygY9xaDm9LvJkSinW3tMGHlKxgruqjAOIOxXwLeu95G6F
         tUo2YMd0hn7cMVHAKTEbYNHQmWZFeHfxMG1DHLYhIIGU+e1iRnYF6WftDWah3zfDLjaK
         NR9/2g4wCTrHuCNtn4CZQ44mmkJU3Bt0F7p2OVHyza1266OMFWuHRcls9wWDqaWgK8hn
         wKOMjW4TzAZnFK40jtXs6B1w+sGt4p2Pp9crFW8a2fSJhFK6wzDMJKPMT8KLIf9NAHDW
         8rIKL9VTS937kT7bhDt7IiCrXShcVUr3zvyUxvA3E8SVKiQWFzgnhMuDW1gwTHcVp80j
         DqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765184379; x=1765789179;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:subject:mime-version:from:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rLUMcfa3m0yMke//cJjqI8fSMt2SaDS5xVKgbYRpXg8=;
        b=NEpr6t+V9dw4FaRfOg+wbxfUb1Cp/ox2pN3on4g5TLrkXniz3GCx3kE02iMSbwT792
         s5z25gPQRBnLTS5y+S5I6V2AXhXUe+qOah+cUTxburrwch9XzsX2bsyZxOhDsWP7F7RI
         /x+LrhsZjpf3bUwF9gsBYMHryJhGdysh5LTMeOy7ED5wtrQm+Mw9Oso2yEjWxqHlm+1q
         /so/Vf3M+ata7bWobK81W7CNJneZd8mp5G5r6+VMBzQhG9BzekCIrPzDE8CmaJwOaySp
         PN1EhtV8ujlQkcxM2kDPmlzaXXYyBiNy3Cm7nsxhdkqMPak/3wjRvTl9I7hTW5ueP20j
         o3qQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB1rhPzIal64zp4SONvckrzkbSVuSlUaK2T5YLGf04aOxUkArQ1CRzVX4lGpix87VYehIesIqZzUvry2FQKCUhx7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbNnfdnWClZdBqccx+WzaWLuhzHRvHb+0oI0s+ISwSQMdc0oKU
	Btv6MgsBAKPxQFNCr/kKSHLy3u6zLMLuVu5C2dUi5VAD0THfPk0x1JZ1
X-Gm-Gg: ASbGncsurL7PCrBEqD98gLxsOAJ2+UTVd92yvDQCG38o7x/xoZnhYkZLLxf/N4InwCM
	5qtOGJr9ULyOG0VeCwv0za3WDkHWHCc3pTX0fkwExlO0G+cvgXDJajLhJb0sRLvm2es3edL8bNi
	KBDzUyZOC3g5HKuWAy3QMVxhOiN8QU1GU2w4k0XVN2O6HeW3TnSR4efZfu3ZoYdOZy3VHx758NH
	33vmMGo6gJTF2gdhaufnUEhgWKfbnh+bUCOQTdGlCC7WVXg0vnlNY1du8Axk19FdMl0iYzB//ZT
	DcTjTzPG5SAKlVY2C7H8L/dnTzNGNi5NUBVjSEWM6NPJllO2bXh4MBU6gJhtuwiS43FgEvlAo0c
	yrRg/pUZpKyarkJe/8XJRyuxY7CB2xZo+oJYsZPuqmBIe6T7OfV4ofldyqQ8T/zJpCL7l/e1IL+
	GoGjg9IWiq4QT0O3dxZgK90ij/hEULcJU580t7ORxN
X-Google-Smtp-Source: AGHT+IHd6m49WuustZxX2QvF4HeyJhawxnwaeWkIUEHZ/bDwjuu6tITB49bqrqPoy2orZO1ly0YmFA==
X-Received: by 2002:a17:90b:4c89:b0:343:6611:f21 with SMTP id 98e67ed59e1d1-349a24e3b08mr5325961a91.1.1765184379238;
        Mon, 08 Dec 2025 00:59:39 -0800 (PST)
Received: from smtpclient.apple ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3494ea63c1asm11417337a91.9.2025.12.08.00.59.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Dec 2025 00:59:38 -0800 (PST)
From: qingwei hu <huqingwei.kernel@gmail.com>
X-Google-Original-From: qingwei hu <qingwei.hu@bytedance.com>
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.200.81.1.6\))
Subject: Re: [PATCH] kprobes: Call check_ftrace_location() on
 CONFIG_KPROBES_ON_FTRACE
In-Reply-To: <20251208161955.54e2fef0fc793092a93ce88e@kernel.org>
Date: Mon, 8 Dec 2025 16:59:24 +0800
Cc: davem@davemloft.net,
 linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 naveen@kernel.org,
 qingwei.hu@bytedance.com,
 rostedt@goodmis.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2DC4EBDA-F668-4DB8-9F0C-F31FAFCF0721@bytedance.com>
References: <20251205092933.3889547-1-qingwei.hu@bytedance.com>
 <20251205100823.28aa8ffd@gandalf.local.home>
 <2E248E7C-773B-4998-B059-A576163B36B0@bytedance.com>
 <20251208161955.54e2fef0fc793092a93ce88e@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
X-Mailer: Apple Mail (2.3864.200.81.1.6)


> On Dec 8, 2025, at 15:19, Masami Hiramatsu (Google) =
<mhiramat@kernel.org> wrote:
>=20
> On Mon, 8 Dec 2025 14:54:33 +0800
> qingwei hu <huqingwei.kernel@gmail.com> wrote:
>=20
>>=20
>>=20
>>> 2025=E5=B9=B412=E6=9C=885=E6=97=A5 23:08=EF=BC=8CSteven Rostedt =
<rostedt@goodmis.org> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>> On Fri,  5 Dec 2025 17:29:33 +0800
>>> "qingwei.hu" <qingwei.hu@bytedance.com> wrote:
>>>=20
>>>> From: Qingwei Hu <qingwei.hu@bytedance.com>
>>>>=20
>>>> There is a possible configuration dependency:
>>>>=20
>>>> KPROBES_ON_FTRACE [=3Dn]
>>>>      ^----- KPROBES [=3Dy]
>>>>        |--- HAVE_KPROBES_ON_FTRACE [=3Dn]
>>>>        |--- DYNAMIC_FTRACE_WITH_REGS [=3Dn]
>>>>               ^----- FTRACE [=3Dy]
>>>>                 |--- DYNAMIC_FTRACE [=3Dy]
>>>>                 |--- HAVE_DYNAMIC_FTRACE_WITH_REGS [=3Dn]
>>>>=20
>>>> With DYNAMIC_FTRACE=3Dy, ftrace_location() is meaningful and may
>>>> return the same address as the probe target.
>>>>=20
>>>> However, when KPROBES_ON_FTRACE=3Dn, the current implementation
>>>> returns -EINVAL after calling check_ftrace_location(), causing
>>>> the validation to fail.
>>>=20
>>> This is a feature not a bug.
>>>=20
>>> The reason is if you put a kprobe on a ftrace location, it can cause =
ftrace
>>> to trigger a bug, as kprobes will modify the location and ftrace =
will see
>>> something it doesn't expect and think the system is corrupted. We =
don't want
>>> that either.
>>>=20
>>> If you say "KPROBES_ON_FTRACE=3Dn" and place a kprobe on a location =
that is
>>> controlled by ftrace, it had better fail!
>>>=20
>>> NAK
>>>=20
>>> -- Steve
>>=20
>> Thanks for your clear explanation. I will look into other approaches
>> that work with this configuration.
>>=20
>=20
> Can you check the code under arch/<your machine>/ implements the
> kprobe_ftrace_handler() correctly? if so, it should be enabled =
automatically.
>=20
> Thank you,
>=20
>=20
> --=20
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

I am working on the risc-v that have removed support for =
KPROBE_ON_FTRACE and
probe_ftrace_hander() since 7caa9765465f60 and 3308172276db5d.

As 7caa9765465f60 commit say KPROBES_ON_FTRACE will be supplanted by =
FPROBES,
I have tested and verified this feature's usability. In this situation, =
may
be we should use fprobe instead of kprobe.

But in the latest version, risc-v adjusts ftrace location to an offset 4 =
byte
from the function symbol. So it will kprobe successfully in the =
beginning of
the symbol while not support KPROBE_ON_FTRACE. I am not sure whether =
this
arrangement is consistent with Steve=E2=80=99s explanation. If the =
adjustment is valid,
I can temporarily backport the adjust function in order to support =
kprobe.

