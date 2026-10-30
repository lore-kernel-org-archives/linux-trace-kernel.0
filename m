Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793386012;
	b=sBJyPsdK9WIffK3eldFzHQcoR8cqa/ZudVhZWinHVZQMM3gM77KJW3zw/VJwkenStVVg
	 5lSgmgvT5Zw3bpcScEkB0x7gvDE2Ul2pRdPcawFWBSAiOi8omsQexS2/I/C1LdcoZRgKZ
	 jOknFa7Y5F9GOohFtpN6CSYg6fl8ir1bzHseAMBojKAU3NEv96QEdHaVujdtKwAntWltl
	 VxSxZ4YPgiBikLgtoqK43m2X6vBlETEaAimGJzam/JpnUPnBMLiBujB+BxrjnlmtUZFTC
	 Jfa3QpJMUn5+A7W0XhKhwDX+Ka2AnFJ0NkswT6TNohWZQlF4XNa4w3QLBHKTk2GzHTA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793386012;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Yft5IyV/xpJOt9PtsEc3/1GOTRmgmfnSHPrRuIdkolU=;
	b=QKQeaBCJ7P+jankgko7EjdxS8DmmX1S3uHbrADCrEtyxeadkTaEHApVJ6SUT1UeAlvjQ
	 69om4hq1TkZpjig+NzN11Qsk3kW2g9t9B2BprDUw8h1/F2cjbom5+JouEunBfM1j/v1bI
	 ECrUUFoB1jxQbXcqpO0M1ro+tyIEesfRgZc+L7EKwav+K5QZUJO4yrkt27okvmXaMIe3c
	 R8gxTshkvFdCXxOdEoSyXl/aUn3u4CaN3/E9V7dDXYzrYY7SeXEZMH2wxMsSwewmeI/WX
	 XyLl9xHj4wkzq9L577xOszsBqXSaamhBcxbwLwQWwWhvzhXK9zSWq0u9SPsEst6wGVg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RpG9nWi+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB96606A31C
	for <linux-trace-kernel@vger.kernel.org>; Fri, 30 Oct 2026 18:46:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EB96606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RpG9nWi+
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3adac5b29ebso692589a91.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 30 Oct 2026 11:46:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793386011; cv=none;
        d=google.com; s=arc-20260327;
        b=glkvuc5a7872vKO3K418qupKw2ftp3OkJ7H2j1jl5hsLzUoTvYFIHtTC0bcgP8mhCL
         MsvGS+xrv1AJgSHLLi2OOXb+pG6KGCBuCCZQmTvTfglM7rEYSFZkeDcLGyJISw6jumpY
         kxLQNaurZyOmw6RCiuwsuTMbiAsQJ6k98ezvN8xVSqJyTHlfg0b4y6s3D4AwhXcvsi76
         Fs2AKgWqEPR7ma8XRxJDiaVuJrRroNZRm2SHXe7xiUXUF0dF3cys9l/n05m0c5T0vaTI
         2LchPHsvB+rQh49H1J5TgXOaj/t65kcCpz2Q5btfXS9XNFTDUmJA8aDav5TOhTkxmzGE
         UCcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Yft5IyV/xpJOt9PtsEc3/1GOTRmgmfnSHPrRuIdkolU=;
        fh=uEafMxPyhK3uZgrMURGuIhoTgTKAZUcy0gYLpnMQsDo=;
        b=WwMeJeJ3dkzrZgLhnluEW8KCfNQck3musT19wRhNzTMMzdgkGtKE+Ca02vas3qmIdY
         7/Rx/bR7IfIY4THPRWZthkE/qMaQYqlq9C0ijoCeOJYd3e3Ab57aAQfkpjKZMtFC0nCS
         bnE32ZbTimHspxUpQcOp1a1+KVDGd2Wxd9ESKilTxfnu7bZIIYQR05Vb+HeJdC3f6DLa
         gx+DsQMYSk9w6NyQHgsXZCug6g73Hc7CtY/wdS6D/VQxsen9LntEFiwgjPuIY+8/of8x
         J4YhgvqOZYT0LndXo9O9IvOxI6h60Y01WYzSY1l5d9miFD56bbT/RjTxhUzE+9ri3nXy
         Y1qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793386011; x=1793990811; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Yft5IyV/xpJOt9PtsEc3/1GOTRmgmfnSHPrRuIdkolU=;
        b=RpG9nWi+ZKZZWc/DkNMA83Z9UtRpSslN4KqWD6J5EXh+HiXKD2gHraxT5ud7euPIBF
         cZe/CRChoqxgWOsLvo1/dZceKUHRRMfv1PNbN5fCPEonX8k+7y4Fo6QQKdoesI69izGD
         R7wcqjNUTF40M+owIN41gjfFh2MaOUIikO2wxjlDsv1n9TwXBPcEDRcdrKiWXhKU/yAE
         gasrhk1UJOT32b34GxEzm1jygwYHNf8R/0ZC6KwwHz6i8zBf0NWrX9VSoyo8Dzx2Nz3Q
         an6SUyaW9AasJAe7rIckyBn/crcOLhcLkVx6htT8C/dHctAMsYKTLBzZiYOnM1NLIyWZ
         XlZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793386011; x=1793990811;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yft5IyV/xpJOt9PtsEc3/1GOTRmgmfnSHPrRuIdkolU=;
        b=oGuS8mHRi0LkDB7uHLD2g24yuPts1XdhKGR8CD4Y8o9rH7iYcS4WgVuysHnyrwjIE4
         iLK75llyOYBa5yBSotYRGHqXkdFLoSQ8i1E2gvPDp4EKfN3pQiEGlT3jbUvM3rlL7efA
         a7ZwRp9nI2IGdn/GijyuCwkwYS0JiH7+3Mbx6Ro2/MrWcQyKOGoHwnLHaILGrlIOi5dd
         EfriwYfWIiYnSy1KEjHCtJe9rU6xLaAUCCoVoEJuqYRhbUvLZGSsaA4e1HmQh5bfBSs1
         /MGp/CnTac6/7pPtmF8KpBA9krI+HiT/VemmASHED3Wt8JATq45+IXOPA8Yzerhl9GcF
         ouNA==
X-Forwarded-Encrypted: i=1; AKwUvBzL4ALA8RyaXKro3uin5vBrKH5Hp5EGMhBbvbtetFkiMj+oj9LYPmw3kZRapE0HFalcu93CfY47IGDu2NxB3eoxpBs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLhXfnNbreVuTdszHGf/tH1aAfOY2uMUX8OZqgK8HcojE4t00Yt
	e6FnIM4clmH4YCfPT2FPG3DgMMoUFfUtTaAPpmHZ/I9F8YgADLSXB/bXeE5sGRZ0GQsKqSOsCdR
	Eu9tF8MCbYyBEt2xiEoSQ0j4g+ek58Fw=
X-Gm-Gg: AYBFou1R4Il3IvEYlzQyjPYrScOkYp37ztT7QbM0VusH/6SWWGRVl742KEeZx6TN9TX
	jDRTarN0guYNcuGv0SjKf7JooGAAz6Y7YIwpJp/AMmkKquM4Wp9SebkL9edwSMdoPIzcAspAxYe
	HLMpwAxKjXMLdQ1k2x5/gUt5Rrweab+inWs1yM4Uv0nVOgpzmEC4FQ0tXd1ZfaKTL5dpBr1+0FH
	a40QA3qV2m/nkohrV2ySvxuclPNlgDTPM/QUVIEpFj+Ib8sGxq1j2jXWUq/ywJ8NgWQyj0iSGjk
	4xR8RipwNsG9VG3Os5zMxenEDSFsOoDH24tYFH+mBU30dBIvTiDFyHuUs6eD8zrUql3/a4IHiU6
	Gqm1VUiRouzv92oblT9xX3hWGMRG0KkgUmcMpbmi5Tm/k9BKG4Jri5qDGwkZDFkw356dVHGc8ep
	3ritJ3i36j5J0rnv3KCqFTEddRb/9c0mWMew==
X-Received: by 2002:a17:90b:2803:b0:3a4:bd4e:6d15 with SMTP id
 98e67ed59e1d1-3ae89763070mr2620334a91.34.1793386011367; Fri, 30 Oct 2026
 11:46:51 -0700 (PDT)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028125148.1348-1-yangsongsen@insta360.com> <20261029073344.729148-1-yangfeng59949@163.com>
In-Reply-To: <20261029073344.729148-1-yangfeng59949@163.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 30 Oct 2026 11:46:37 -0700
X-Gm-Features: AclHuK9JgZQ0yY9pjUZS0J7oNwln-ZzXOo3HkJmw0fssJ8tLcUosj90ClGtkpxo
Message-ID: <CAEf4BzbRh4sof8aD4kj1y27kE3-VfAR3SOr8QMcH5n8rkUB-bA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Fix suspicious RCU usage for sleepable bpf_get_stack()
To: Feng Yang <yangfeng59949@163.com>
Cc: yangsongsen@insta360.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	emil@etsalapatis.com, ihor.solodrai@linux.dev, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-trace-kernel@vger.kernel.org, martin.lau@linux.dev, 
	mathieu.desnoyers@efficios.com, matt@bobrowski.net, memxor@gmail.com, 
	mhiramat@kernel.org, rostedt@goodmis.org, song@kernel.org, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 12:34=E2=80=AFAM Feng Yang <yangfeng59949@163.com> =
wrote:
>
> On Wed, 28 Oct 2026 20:51:47 +0800, Songsen Yang wrote:
> > Hi Feng,
> >
> > I hit the same root cause independently via syzbot and sent a fix a
> > few hours after yours, without having seen this patch -- sorry for the
> > overlap:
> >
> >  https://lore.kernel.org/bpf/20261028121859.994-1-yangsongsen@insta360.=
com/
>
> Hi Songsen,
>
> Please don't worry about the overlap.
>
> I hadn't noticed the issue Sashiko raised when I prepared my fix;
> It looks like a pt_regs on the stack can fix this.:
>
>         BPF_CALL_4(bpf_get_stack_raw_tp_sleepable, struct bpf_raw_tracepo=
int_args *, args,
>                    void *, buf, u32, size, u64, flags)
>         {
>                 struct pt_regs regs;
>
>                 perf_fetch_caller_regs(&regs);
>                 return bpf_get_stack_sleepable((unsigned long) &regs, (un=
signed long) buf,
>                                                (unsigned long) size, flag=
s, 0);

using sleepable variant of bpf_get_stacks is a better approach,
because stack traces might request build id, and in sleepable mode
that works reliably instead of bailing early if memory is not paged
in, so I think having specialized sleepable version is better.


>         }
>
> That said, I think your approach is the simpler one and the better fit
> for the fix itself.  So if the maintainers prefer your version, feel
> free to ignore my patch.
>
> Thanks,
> Feng
>
