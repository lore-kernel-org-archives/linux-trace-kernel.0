Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258A62F2A;
	Wed, 18 Dec 2024 01:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734485027; cv=none; b=BncNiOpZhneVfA+PaygPpcgESXGbIXyGbBkCB8XK4l/0f0fvA30m09Rq26V53jnp5cE2oaXTRcUi9WDoJK5ej2HsKEkj5Y7L6UBAINpFWJEoCoehAXxWnahQ96Dcn91J/NFAcpUdme9wq22UbtCFd4HbKIV7qYMyuWnUoWRhAD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734485027; c=relaxed/simple;
	bh=7laKOPZj0IQHqYOeccnBJKyND9MK6DQ6bc9rXvWrC14=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=Td7+Iwb06XPOhnBaGvXUfxBRrfykx9M9sAcgY3LzUt0SHIWrs8AZSEJBDGDVbojw9uaTBvWbkTL/0Mtj5bkL4lRwRVIyliwrJu5+MeR+88oY+MFXDJskNVj8LAl5gVPwFccphmvyH6xrM5AWkwFRkdwecfB4UsE/m1dJEAkhe7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOLHrPu7; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOLHrPu7"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-725abf74334so5212442b3a.3;
        Tue, 17 Dec 2024 17:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734485025; x=1735089825; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k48iIXY2iSS1mUc4KsRrRVhc/2Tp+/ee/9u64+YqyQw=;
        b=HOLHrPu7R3rbu0aeC6H3ttZY5aRBAq+/Q/7MONfBXWicy9y2jwnXGsrF4xv7kUmylK
         hSEk+VdulvHktgzzmSB2wKhwHuHl4ZhyhNwfTKBP+YdGaQeM4nTrz3BzQHij03DbR9Vv
         /3QN9UzQK89tXinIoW5v47uCDazRQW4lQJCWOdr3jIl6fKN2Xr39MKQX6BbmzxIGbj3p
         e9BkxN9vH5+6y5Zv4M5Hn2XO4BRp1kj639G4IqQqs/xcX18jK/NJBuq1gwOSWfCS5P3Z
         fbGeQyw7qHiR1PJ9hVgGgO6v539F5At0nTK0pt609Gep/9jS/9L0ZGSTOxMWFYfV3mxm
         6+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734485025; x=1735089825;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k48iIXY2iSS1mUc4KsRrRVhc/2Tp+/ee/9u64+YqyQw=;
        b=Fr7jfbDqgWP1NMnTH5ekdD+9weH8oVRlyApJugbCZyrmMKhaeau9IfDcRHrzeSxCcM
         qd8SpNeKeSf6eIc+Ex29AZ5zuz1ruKQNS1UxKF1YScLIfxr7j94nkYI+dFjTAlNL6u2y
         Zs3JGVJROJzvV51noSfQkWOopN2Cv4b2wmhFYoKZcEBkH7q8KvEBo1/+S0pRoNY0MQCv
         osyEZVdOciP5cSsTOrZh5GHZ0uvduQzDXfarjemCJ/jogao9eBS7AoCLpt5eAMiZbkfd
         yxbTsNs/qpkouqcL+MVGR2k0gAWdUTP14M3HdkYyWOd3FX2/HJ8fooHMl531AU+tL/BX
         ZRYg==
X-Forwarded-Encrypted: i=1; AJvYcCUoNl55WmtBAcE4GwpIw544JJ3tw33CMrG67DIoaWD2bHuuQIYg2e1NTbGGaMZ/BCg2MvW0azKPwY87OQ4=@vger.kernel.org, AJvYcCVPBLwtbPAIUNKxr1LeFM/NL1WoglrWg4QoQ7KgCPTGtIDWZlLB1jyG7tGSyNFe5Q56PyOekUX3YLWguyVO9TWqRsW/@vger.kernel.org
X-Gm-Message-State: AOJu0YwDMi52ZKXGHciZmGydsKJK9jM6n86avWnKhHfOhTJ4h6c75O2r
	aTttf3fXRjJfIM9KCy6dXLtFlNf42aP6Anu4Hv02Qq5cEE3y7zhPz+gZo2HD
X-Gm-Gg: ASbGncs26vFhyKtMFFW6lA1nGfebi69O6FB8Krp0T+JU1Hhd7lYwpOHMAAazT8EXMJZ
	mJ/0zLPZtX7M7e4fFDbos27HWTH8AVxNjdwIpRcXU8sdbgJhg4sXXuu3C93m7Q63bfRRsmlHGVc
	hSSOjrJUvG3KWwjc+/Xw9UkfhnSQ3R7LJAcAjwq8y3wVDGcLFSoPdvw16bYmstCaH0mPspBgwvh
	jiCG01bpt9B33KqYZeyXrTKZ8FYKKWpNPB8Pykd/BAC5t+ibx8gDcIQD4FoPdUHbVUtAKzw7rZO
	Xa/9ZDM=
X-Google-Smtp-Source: AGHT+IGuXmyLUE4JkexSSyZbDf6APGVME8IiVLJnL//3EUHfgrUDECdb5crOG+AmrGCfn4ya/Ou5nQ==
X-Received: by 2002:a05:6a00:4087:b0:72a:8461:d179 with SMTP id d2e1a72fcca58-72a8d12803emr1747421b3a.1.1734485025016;
        Tue, 17 Dec 2024 17:23:45 -0800 (PST)
Received: from smtpclient.apple ([2001:e60:a815:8bfd:c052:e525:edea:f77d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ac84f3sm7617011b3a.24.2024.12.17.17.23.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 17:23:44 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Jeongjun Park <aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] ring-buffer: Fix a oob in __rb_map_vma
Date: Wed, 18 Dec 2024 10:23:32 +0900
Message-Id: <3D642609-2738-41BB-AB0D-A14F58469A78@gmail.com>
References: <20241217194015.7a4f0dc8@gandalf.local.home>
Cc: Edward Adam Davis <eadavis@qq.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 mhiramat@kernel.org, syzbot+345e4443a21200874b18@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, Vincent Donnefort <vdonnefort@google.com>,
 david@redhat.com
In-Reply-To: <20241217194015.7a4f0dc8@gandalf.local.home>
To: Steven Rostedt <rostedt@goodmis.org>
X-Mailer: iPhone Mail (22B91)



> Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> =EF=BB=BFOn Wed, 18 Dec 2024 07:43:46 +0800
> Edward Adam Davis <eadavis@qq.com> wrote:
>=20
>>>=20
>>> A proper fix is being discussed here: =20
>> First, my fix is the first one.
>=20
> Yes I saw that.
>=20
>> Second, the root cause of the problem is an overflow when calculating nr_=
pages.
>>>=20
>>> https://lore.kernel.org/linux-trace-kernel/20241216164931.57323-1-aha310=
510@gmail.com/
>>>=20
>>> Thank you,
>>>=20
>>> -- Steve
>>>=20

Oh, I did not propose a patch that fixes the root cause of this oob. My patc=
h=20
is a separate patch that fixes the wrong order, such as reading the array=20=

before checking the variable s with the WARN function in the loop. So I thin=
k=20
both of these patches should be applied.

Regards,

Jeongjun Park

>> The calculation of nr_pages below overflows because the pgoff value is 8,=

>> the nr_subbufs value is 3, and the subbuf_order value is 0.
>=20
> So basically you are saying that passing in the the mmap with the pgoff is=

> what's causing it.
>=20
>>>>    nr_pages =3D ((nr_subbufs + 1) << subbuf_order) - pgoff; /* + meta-p=
age */
>>>>=20
>>>>    nr_vma_pages =3D vma_pages(vma); =20
>=20
>=20
> Thanks, I believe I now have a reproducer. And yes, I'll take your patch.
> (If Vincent is OK with it).
>=20
> Here's the reproducer:
>=20
> ------------------------8<-------------------------
> #include <fcntl.h>
> #include <stdlib.h>
> #include <unistd.h>
> #include <asm/types.h>
> #include <sys/mman.h>
>=20
> int main(int argc, char **argv)
> {
>    int page_size =3D getpagesize();
>    int fd;
>    void *meta;
>=20
>    system("echo 1 > /sys/kernel/tracing/buffer_size_kb");
>    fd =3D open("/sys/kernel/tracing/per_cpu/cpu0/trace_pipe_raw", O_RDONLY=
);
>=20
>    meta =3D mmap(NULL, page_size, PROT_READ, MAP_SHARED, fd, page_size * 5=
);
> }
> ------------------------>8-------------------------
>=20
> Thanks,
>=20
>=20
> -- Steve
