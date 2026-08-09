Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7382E2FD69D
	for <linux-trace-kernel@vger.kernel.org>; Sun,  9 Aug 2026 18:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.148.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786300357; cv=pass; b=m1dKOLGKZ8OhBBRrrbPdCXrLQLm1FlXb9RdaOCk8YE81oylsOiaYRP3o61z+KYPLhKjFRF/+qur8+6md4dsiII7aF6UkBUVQOpj+B8meI3fwJtW0gKIZXizH3gHImw3/BXZhDXOK1ZPmyDDD+xpbZHtiAxala16M/shid/RFfFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786300357; c=relaxed/simple;
	bh=ZRvxCPN/Pn6xKN4kzylsdN8URZcXpD40RKKAE4yvtcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qEPd83kJeMsTXSB81dyiUDJ8J9tntcr/Li7q6LE0mFBQ2lGGZtZiYFTtFAJVlAwlqKY6MAMvrq6UB2q81eCWNIohkeeqmDUeKyZg3NMHIwTHBcSH5A9reob4ivwdmlNCHCz+obwXGfnyh2Z9/J4m4t/mTBvZkeeYcuLbx7TAwO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=FfTink7w; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=gFUI2ecx; arc=pass smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="FfTink7w";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="gFUI2ecx"
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 679Fm4O21434057
	for <linux-trace-kernel@vger.kernel.org>; Sun, 9 Aug 2026 18:32:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=Henl/L+kFOLuAzV5yx+ibTkMLFGMN5q9FPJK6MTPsC8=; b=FfTi
	nk7wAnz35vkjyqgaz5kxh8xN/mxzF5PiLfKFsxowFPJ9BLT4e4XeNrIcqhwaVXWE
	dGBuWprH5ZuhY0JxYqZkg7ERi1/Uw3uQDeZL5p+GAl04552mj2ToUocoVEuEfxa0
	jGf+GkVtd58SX5y0mu7mJ/JIAFmr21JTqSg6ish8OBzj6wGxO2Br5377wCjldAXd
	aKt69xzBWYA6ZnkoPLT9g4ZrFweGpVG8siwTezwba1nMzPleA5qh9ilPbtL81hok
	WQcJMzGLPZuXrL9ha2pTuEPlC1AHsbYrCXXU+1HjKsbLzd6VCqKhKFOUC5N4Oo8d
	LUMWSqijyLQ2I86EAg==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4fxgxasay2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Sun, 09 Aug 2026 18:32:29 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-821167f53cfso39641537b3.3
        for <linux-trace-kernel@vger.kernel.org>; Sun, 09 Aug 2026 11:32:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786300349; cv=none;
        d=google.com; s=arc-20260327;
        b=Ewte87rdhStXVZnIcn3kJykg5R7DAjdhOnQy4d3+QXxjrmzPzfghMf8xS7MvDPlPju
         uAv6sLkOJnTXXftKbTqryHbQocLtSEb6gTm+UV6ZUU08BTd25mw3YWpeJi6bOJhJl+Ej
         PqkZNauwbFYhcFkI+Hq5oQPP/DtQkP628Vd5YGUwSg6Bvpka+gr93f2BoikGjX/JKDGU
         ErytaFkIhJkzmiaZ3DKPWMibOxEg3DXZMc4gOmjQcCECH5+3vlyfpEZMap+9krbLGny/
         BWlEc2uWiHBilzKSiKhddVr3v+aixxuUXd+BTnXDDtHy5B8rAXeirKD7hHdVG9jitBij
         vAMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Henl/L+kFOLuAzV5yx+ibTkMLFGMN5q9FPJK6MTPsC8=;
        fh=1PKmbPtT4D8U5IGuJ9twFOIU3Jo0IWAGflp4D8P+4bo=;
        b=jHUICR7gKosLufAyTykrTj98eaQabYofa2Tq0xTr8CtsAbyajLgRITNXqE8+3eo9H9
         U2X9J6JbJUnkB9NpS0pRMMeUbw0hA2GYgBt6aIk9BPfu+eDlmPRJa32ZfZjf/G3Dq8Bo
         ME2gbTnXnfmNKvxTH8OhrUseDvX8uP7HP0R515MF1YVXui5nIpJaw/9eEtFwhgi7su9n
         rqr9Gdv2zwe2HnGyO265iG/V318GqTiWZMnM1B6E7Tu3LNuwAdNWn7z0OlEICdvBofGA
         5Rhmen+RpefuNUfkZ/cvaw+izBu3RnvW7uuCt1Y5V1W2CaHtl75rjA26eHltScEQI8wt
         f6Dg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1786300349; x=1786905149; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Henl/L+kFOLuAzV5yx+ibTkMLFGMN5q9FPJK6MTPsC8=;
        b=gFUI2ecxASqj86RV116VD5mzrU5KAA/rbb1xhqriAdMmI9cPJveswvJ71H3YGcfjok
         kJFDFvQBuproli1/q6go3sHtL3OGBP6WxYsJgMpeb2mfmRDZDlZBWKV0qLNYH01FomLa
         SzsO909KdkM7dwdTgO0szrEiZtKk7TSLADHNYkcybF/SG6S+sMQ5b4tp3z1JVb4Qlrmb
         OPlknHMUlotlus548ElwNxz4ZiwUN4ds1ZiTBJv7TcCb4p24FfzKM8ObatNScjjmaia3
         bayhQrZ/dA25V0vzx9R+tj2mTmHKtpri7FPpaBPnzX9BlnwpOMmcj1/dSxUfKKlUCQxi
         jMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786300349; x=1786905149;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Henl/L+kFOLuAzV5yx+ibTkMLFGMN5q9FPJK6MTPsC8=;
        b=ipE+tPtwMNFwyclt5XRjCpCrCR2DukiIgfzKSudNyZZ1FvHrc85r2CMj6CQhXg23Kn
         Mb5ji45xpBMrA0X4PI//0zNxJcwnW3J/SkupxRamFe5HS0+OxBX9Agn6/Dhr0itQPTuE
         QVZZj5QfFv+A5HCg2MJbrB9IZJxgK5B3h6cpnfoHxUxrEx2PMkzETqYY4rV/98/RpFsw
         9QdQSEltV/NUPm9xP9FexS0j52YYz/pqCrxIT9lhb7R9/oSLpurTHH2E0dHwvmZfXk2d
         zge4M+ccHEoXIJBU7KEbZ0xBrpI8usB4H3Pw6+egvowTp3ASIgJjzY96FIMxCzATCn0+
         fdKw==
X-Forwarded-Encrypted: i=1; AHgh+Rq9idYvIvE/X1DQkX/b7NkkQGEBE4Rulcp5EPO7Eb4pe4qJ0YgTxlAC0e6dZ+tclfJUqQjPcx76MLMF6WFiZkMrTuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUhkmjdprkmIaOPQFcAvKMDpDaYl00oOyvTZuWeCk8Z74FguGQ
	Oh4fNISnfV1FswrFZOTv9RPTtRMGKmWdhIHEmyFz2sUWI1sZeX4khvarYLgxRUmdfWNBdjBGoWe
	ODGqsrAUQ8vo7Ulnj10BjLuHOaDa9nGAWj9N5sK7VKHOktuO/E5v0DoF3eX7KqDg9eR+tw8ekB9
	TaR/KV8tkmTBgkePhRzXJk0R94w51IyCQl5ACFrdgJSTMV2Pqzkwl3SsM2
X-Gm-Gg: AR+sD13E6A7SrDIgqjffDcrpRwx0clUY3gV10AYC2WBnj2zuvU0PVsp5zZD+rSb7WhU
	knyqaKPlLDCR3oiPaxib6VxuAid6AX7WjAQgJ2ULv3BEuMm4R8mYg6mOAZEOfnMZWUVCTkd4o50
	rLhrhV7WRbMpTOwBCncjQzy05lgDJEXLVER6rCT0ZWlGVaKSKqY3WLxvucyA==
X-Received: by 2002:a05:690c:a90:b0:81d:4174:6818 with SMTP id 00721157ae682-8257357f604mr89550387b3.13.1786300348800;
        Sun, 09 Aug 2026 11:32:28 -0700 (PDT)
X-Received: by 2002:a05:690c:a90:b0:81d:4174:6818 with SMTP id
 00721157ae682-8257357f604mr89550147b3.13.1786300348210; Sun, 09 Aug 2026
 11:32:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806153000.4184871-1-andrey.grodzovsky@crowdstrike.com>
 <20260806153000.4184871-2-andrey.grodzovsky@crowdstrike.com>
 <CAPhsuW53yRgFMkNuAPCrCm9fhNNb4EpN7vbcSEGkNCZXHjk7AA@mail.gmail.com> <CAOu3gNhjDNFgzg0nf458FdMMMPx4WJi=n01musucvk=hbY0HMg@mail.gmail.com>
In-Reply-To: <CAOu3gNhjDNFgzg0nf458FdMMMPx4WJi=n01musucvk=hbY0HMg@mail.gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Sun, 9 Aug 2026 14:32:16 -0400
X-Gm-Features: AUfX_mxB61PImxk7Ub1YrOZ365ALM_DPyxKzut-8yKDjXWIjCGfwpeEyQKycU1U
Message-ID: <CAOu3gNhgRTh8uZdfNf+XBpYuJWAFu5i+UNjQC2jce4DdRc-bGg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v3 1/2] ftrace: deprecate disabling via
 ftrace_enabled sysctl
To: Song Liu <song@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, mbenes@suse.cz, jolsa@kernel.org,
        mhiramat@kernel.org, jpoimboe@kernel.org, joe.lawrence@redhat.com,
        mark.rutland@arm.com, corbet@lwn.net, stable@vger.kernel.org,
        linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDE2OCBTYWx0ZWRfX2vcDkCUlMV5o
 8ohPnozx2A0gZ0PDlM9fnDvzHIkXQp4DP9i42+8vuXrWC8Cf2My5Z248TIi8AQWi78F5sgIKbFL
 9UHAEjpT7UcJaPhwvW4itB+BxhUOlhz5FQDV4CeXE+eM25BfToj7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDE2OCBTYWx0ZWRfX/c78dHdQxPuB
 XZ0dZsSnZVjnTNecfx4EesHtV+bVID/TG3atrid5RCV2jWg282itFKwWB3YaIFEDE+BXnJEuVVg
 WZT9MIoLVvkTHHBMI1LCkQI9o0fYMlbfDZ3phEkWgxf16ZC3gjLsBJsphF+xkrUFTNV2fDuRuQU
 OzbocWDYTW+n0vPLqnklCtvs9WXPoKc40j0I0Txw4MmWKVeyXY9bjFfiytaij0SSJO1PC2hM7IJ
 SIon9f4Poi1BEW/YQMzygL3ZO3TwiFhE+qFxJpso8wHR+IhQRWEXIyrN1whp88jUYsfHPL8tUix
 XB4qlC73RxqiIhGek7NfnKZYQx6rwaOeUJNgRrEQ/NQss6BnaVdJ9uqOpDznxFtvkg5eKHdOx39
 0ynzrf4FIOEX0fD+37VXGY8GnkfDUryBDqeZw9hwuCTagKeT3hcRT1FTevz6qUd6OSAUrY1QMQ+
 P5ZQcFE4Mx1Sr82qDNA==
X-Proofpoint-GUID: pskg6o-PH4XU59ztxl7tDopZp1b9OQX3
X-Authority-Analysis: v=2.4 cv=QfdWeMbv c=1 sm=1 tr=0 ts=6a78c7bd cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=t04HzT_fAfAF5W-3wVZy:22 a=pl6vuDidAAAA:8 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8
 a=jPl8K6pqbzkCHX85MxAA:9 a=QEXdDO2ut3YA:10 a=kLokIza1BN8a-hAJ3hfR:22
 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-ORIG-GUID: pskg6o-PH4XU59ztxl7tDopZp1b9OQX3
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11870
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608090168

On Thu, Aug 6, 2026 at 5:52=E2=80=AFPM Andrey Grodzovsky
<andrey.grodzovsky@crowdstrike.com> wrote:
>
> On Thu, Aug 6, 2026 at 5:22=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> >
> > On Thu, Aug 6, 2026 at 8:30=E2=80=AFAM Andrey Grodzovsky
> > <andrey.grodzovsky@crowdstrike.com> wrote:
> > >
> > > Writing 0 to kernel.ftrace_enabled has not reliably disabled ftrace
> > > for years (FTRACE_OPS_FL_PERMANENT users already block it, and more
> > > callers rely on ftrace always being on). Refuse the write instead of
> > > leaving it in an inconsistent "disables some, not all" state: return
> > > -EOPNOTSUPP and log a message. Reads and enabling (writing 1) are
> > > unaffected.
> > >
> > > Update the docs to note the deprecation up front.
> > >
> > > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> >
> > Sashiko's comments make sense. Other than those:
> >
>
> The bot has 2 comments.
>
> In my opinion, the test-breaking comment is wrong as he looked
> strictly at this patch w/o reviewing the follow-up live patch testing
> changes which update the tests to avoid breaks.
>
> The cleanup comment is valid but since we aren't sure if we'll need to
> revert this change later if it breaks userspace in some unseen way, I
> wonder how extensive the cleanup should be? Steven, can you advise
> please ?
>
> Andrey

Gentle ping on this question above Steven.

Andrey

>
> > Acked-by: Song Liu <song@kernel.org>
> >
> > > ---
> > >  Documentation/trace/ftrace.rst |  5 ++++
> > >  kernel/trace/ftrace.c          | 43 +++++---------------------------=
--
> > >  2 files changed, 11 insertions(+), 37 deletions(-)
> > >
