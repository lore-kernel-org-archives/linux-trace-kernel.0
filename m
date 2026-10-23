Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792792041;
	b=DEkJLtFLo1kE54LokeS80ObWJtlh3zEdSlGEfuVOnp/T9przFX5Zsbji583esc2dEtXh
	 h+yC2sQi0pAdQ1THgFGEHvz4A6arjq+3u77+jFKZQWqNpWqGAWCrkSk3c7tGAaHalXDGh
	 ZK9vhJV25Q72JyHuQMzxHrbfLYTGOqY7NtCM53fitPBhOpQthPapOowvBzMjVEyEupBYU
	 MgCVT4POrMTZ883qN5MVdPgu149xMpRGM7ajQ3iXWJosvy9IMgPYOWaRRqi5hkcfgHS/E
	 8v6P4LKuLn97IL+wE1F48Nx05wJo5PZH2BETB90HQ+t0/waYdmsasFxgjYJrqUmWGXQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792792041;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=xPSo9ItcVa4fj2ri5oc6bVUN+cUX/ExSvpmY9Grzytk=;
	b=iozKx4URYp4gQkg/55AoT5GkpX8v5WzEa1E9lV8pJaFdKKb5oSMWb0P3HRwcYF98Tnvq
	 8L9hJPXR78caEZFV8lyO3yjNFnJkOrwhUf1QPksyRffo42/dU1O+fsIKALxNoQUiGvTpI
	 x1JQiitoNGDVm+eHQTzECszmQzEgZr+5P3Io4ef72DFB913yM6U4Z6GCDi5Sc+Y2L7lr6
	 7yilWfrf1vfyitWXEIT3OhP3Tl0TFX8o7POImrc4FjG1i/19fq/DuIc6+Lp+8dRUwTRex
	 T1qp5YKwHL7mPo7wEO2OEwMC11IBHaXlgvhHSB0/iGVpT1RtpUbV9Reqw/cZ0v+3H4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hLDmu77i;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CA3606A31D
	for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Oct 2026 21:47:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6CA3606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hLDmu77i
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3acc96a256dso814197a91.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Oct 2026 14:47:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792792040; cv=none;
        d=google.com; s=arc-20260327;
        b=Z7AR6PrWgnISRvKUI0QdgaqE53GNJtJD5l5WrOarwsjVUDM/i+Dlc+v4R3mSyOGxqw
         kI16EqndLUd2GJJHFqYZB0Sr8Ha6ttDxxQoYFcm+eE0eB4dWjbjlgPV9wpF2AeMqNnc/
         QNKQTHEDkkZsOV1NTF0yA3g6IQZosP3UbPFaG+WobaORarzXoNyElyfAx+Sa2XkgTLk5
         4rkwEUSBlqeLgD9ZNlN1QOA55EtAYMwvn6+C2yD7tjB1P4T2zT/oyE4WHOpWdfhfhq8k
         G+VfhOU/9su5PgxhVmr0JaxK0QcL8PVbuEarRUOvNDf7amh524vRDyLGhC70NNZkpSXC
         mJeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xPSo9ItcVa4fj2ri5oc6bVUN+cUX/ExSvpmY9Grzytk=;
        fh=ltewQLNRaa9sl1liTZLBPohVUmJi7NRAI0iiiWXmd8M=;
        b=NEDRy/KRhT8LZYVXhwZ2jYNLRlhNOaqh+WLvBXsWLxYojSydmCyU7279vsCGqTWWr3
         Ce02FwyVJnaMCqYSAfXWuq/sVbg3fZ9YvSaakm/ULyoiaCQE6d/7ZM9cRNjZ7vXfN+uW
         ft9p6eSmx50c9jPJGszr2OLgjrzJfE+OaYQL33TsbGzVJy8OqMRmLpcUoRSKAl7m2z8j
         wfm8dN5ybLzoOCc+4y20ZNKg6SUY117fdzAoNffVoB9jPNdPyvXHU/EzdO3XuC/JPCgQ
         sxilEeOS5cR7agBt6qDhW/ACGCIB09n6PjcxdDQQ8pkzNVbEeBdl97teCWXBJ58aR6mF
         l7HA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792792040; x=1793396840; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xPSo9ItcVa4fj2ri5oc6bVUN+cUX/ExSvpmY9Grzytk=;
        b=hLDmu77ierYiamVgBV5vcAPXLaG8aupRNyDiDX7DkFNKpzAxzPIc63o3dmGM4zJaa9
         4NGe3YwDiymWhnQ/OCBGllsswfzcFZye7tQgoEq0wKR8ICoXlpOSA+BkFePJ+1A4Qtfs
         5B9uWQyifczwR83ZzMfzQhkVojser9lK+7Vg1COy1KYe+paFJC2NeFMJ0Pwj/pPj/iD2
         gXyhQWok5F1Qlv02XKngGqq1rGnm/5QhU+mrMgvZNpLlK+CJNtiedln6Mz0k16xq27uZ
         SIpi3iMCyeGt/gxH2+Gr5wKnY0+0nxLC7O7+qOh1rB8DPqu6rw1b+PmW+IOO7JtIQdHd
         VdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792792040; x=1793396840;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xPSo9ItcVa4fj2ri5oc6bVUN+cUX/ExSvpmY9Grzytk=;
        b=VPQv05P7Qn+hdWia6qdkAUtOlH2+uCp3itsKOp/yoobofUA/vvXQGIEQdg3scwnWKK
         cXJOImpLIq3QhH8cHpwamrqlQLvujTzL5ACUiKLSPwvF7EITPCufcthYJ3wkFj/hVaE+
         Cc4L2rYIOIrZE7IBoowBFqFunQFRJr0FasukgvlKwEWDjFNCgrm90GOhW4QIIL64Okf4
         1fqWZNA2UYyMIu0Ec5G+tnjGMi054edMaW25KeRr4PtZ0UNaqAAUF3L2KQ/YBe8WaoDK
         OSvXEx2GZr8Ro3ktPuH0qZld07m3hSMx2T3CLC04DwYBka4fOfcCLppk1U3/IA0altKY
         qKYw==
X-Forwarded-Encrypted: i=1; AKwUvBzBeFFu/+/r5Ag+Pu8noowEUOB7JsJa4VDJBXDp5hUGJaVQm/JzwzLzquNOHHi3MktZogSjitETveB5LK90Vw+egHc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKM+2hdATGpk5/3STfyjmUaofzwQX1xs4vcbKOM8AN86RJXZ3+c
	zMlClVwQEaoI2Meq/c/Vosi9udWzWFwRHIypALn4Ov7muUbdXpkK3NfMez4QXx6FjOehUDfUXJQ
	jyGjdokFGJ8PFC/BjPmA83qgvJZf5QQc=
X-Gm-Gg: AYBFou2ptdII3zXPLgJFpDIAWWHret5P9cLaX7iL361XZHOIhICcECK9YcN9v9qgC7h
	whzLtm+FV3bphUtfCG+demwmfP1WZ5X1+Vyke9FGbF4XHKGD2Jq10r+FalKnfrZKGxn9tMR/ln3
	cOwNSh3Od3jcjpqvfmnefYVPGZib1B7+sVzZbQOw7BPjdua0KNR2Mek4lN/cOOh3oVVplhnwL80
	TIGs7jg0v9+rDSCNvIBgR6TEtVB5GSw+WC4IuMrhAxP9aolLrNkMdpn3CP/5APeVjMGXBK1Xjgz
	Ofs39qEJHJznm1e138r48s0Jdog6IIxXezFrG9Dw0vW3djU1ZwLnrF31E2Kos2ggjqIF6UzmuWq
	MOVPbzgGRxCOJFzBCXPjlmVg85lq7P6vjS3ewNPVXgHwR4v7yz0mLXLf+2pZIfEkw81R+SkXas1
	AMfHEWCaRTqJz9W6Fwf//bizbSeu37BXpdoW8f4ww=
X-Received: by 2002:a17:90b:17c1:b0:3ac:8af9:4a77 with SMTP id
 98e67ed59e1d1-3adea8952f8mr420926a91.10.1792792040157; Fri, 23 Oct 2026
 14:47:20 -0700 (PDT)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261001072449.1377267-1-adi.sharma@zohomail.in> <1a168cbe0aa.30b7e048183449.4003649852775097641@zohomail.in>
In-Reply-To: <1a168cbe0aa.30b7e048183449.4003649852775097641@zohomail.in>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 23 Oct 2026 14:47:05 -0700
X-Gm-Features: AclHuK9klZKtZiNDzc9m6HVwMpKUt6CjANLrIawUWNF0dNjLjk5PlT3PLx4p-yQ
Message-ID: <CAEf4BzYveiSZg0qg5h=EPiMQacnSXwp=8O+x74FM=89qrHV4=g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Fix bpf_send_signal_task() from
 kernel thread context
To: Aditya Sharma <adi.sharma@zohomail.in>
Cc: bpf <bpf@vger.kernel.org>, andrii <andrii@kernel.org>, ast <ast@kernel.org>, 
	daniel <daniel@iogearbox.net>, eddyz87 <eddyz87@gmail.com>, memxor <memxor@gmail.com>, 
	"martin.lau" <martin.lau@linux.dev>, song <song@kernel.org>, 
	"yonghong.song" <yonghong.song@linux.dev>, jolsa <jolsa@kernel.org>, emil <emil@etsalapatis.com>, 
	"ihor.solodrai" <ihor.solodrai@linux.dev>, kpsingh <kpsingh@kernel.org>, matt <matt@bobrowski.net>, 
	rostedt <rostedt@goodmis.org>, mhiramat <mhiramat@kernel.org>, 
	"mathieu.desnoyers" <mathieu.desnoyers@efficios.com>, shuah <shuah@kernel.org>, 
	puranjay <puranjay@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	linux-kselftest <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 5:46=E2=80=AFAM Aditya Sharma <adi.sharma@zohomail.=
in> wrote:
>
> Hi,
>
>
> Gentle ping on this series.
>
> Andrii - patch 1 now removes the nmi_uaccess_okay() check entirely, as
> suggested on v1. Is this what you had in mind, or should I change
> something?
>

Hi, yes, it looks good to me, sorry it fell off the radar. bpf-next is
closed right now so I can't apply this just yet, but I'll apply one we
can do that

> Thanks,
> Aditya
