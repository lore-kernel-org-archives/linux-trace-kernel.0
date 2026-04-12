Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE20271443
	for <linux-trace-kernel@vger.kernel.org>; Sun, 12 Apr 2026 13:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775999324; cv=pass; b=iE0n/ELJBbxuZeVRqaC+b/BSGUFSn/VmziM27H6bufpiJimKFVFea7TqIiw9qfPnoOhGq5TJetg6ojL89SIcJMYCXHJTxHfuqZjby5vnpc6xAuQJRVBGpa6sh2ls0voWMgOBTPuKs6FZ+e/AlyoLFOkngsjvlf9+zgGRA2xV5zQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775999324; c=relaxed/simple;
	bh=MhNSVDq+Mp4atqhKE+k2G9tvL4hBYd8ILox5fx+oqq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GNpk/6iuc03vXpdXaC0bV6s5ELGN+FijecyzWUfsXjnk5EiqxZa35VP+Y93ghrhxMklNrIcWs3C4/aMDBz735Rq6C/XNb0LBLzjNo7BGIfxpvlYZPlCSz+NfLcqXJdOHIATG0n2LTEutWhU14892i4g36eT1KTBgRioG9qbMYR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kuLJlfN2; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuLJlfN2"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-79a60975dc5so37516957b3.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 12 Apr 2026 06:08:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775999323; cv=none;
        d=google.com; s=arc-20240605;
        b=gVeagEWYhTKl9eEDZWZb5AoQmndPUDMJmyE+otYgV8CHhWicPPCEyMWu+pCM+lcXjg
         oBXE5dfr0IIrIkOaTsUfhQT86HfvZcuKJIhbptillfnurT8xWwas+NFVtOswue0xUdsh
         sp8QCQoWxxdlb3CsjJPguPd8s8aSfVsL/L/nG50B15Tu63/hHEt0Dr+glFuVeWRZ1VkK
         YMJ4HRE0ZvdwoHMH9zFRkAOX4/LtEdtVoDgUz2KihhFQRKpsTnSQUrGpGA/i91RJbc2E
         W1FbIZtLPMj/flhjYd8T1ta+WAr4mc+9+Cv75drrSFXbrxyPaKP0osDYUIJsvvwmjyIe
         cI1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MhNSVDq+Mp4atqhKE+k2G9tvL4hBYd8ILox5fx+oqq8=;
        fh=4nTu4j6Mso4hgknsEmom3NMb27hNZLRTp5ub5h1aXjc=;
        b=HbkmWBC2CgHLZMZExMD5oEpwgdngRwvAYCBAlGnB/WOqUYreRpJ+D2frs0j6XjJdt8
         cOrF3rafLGBCcA+lfUfETu2qmVwBHyc/FpB09/WbFDwlZfs+iPRp2Vv5ud3JLxVesQCS
         Za9EcxkeyKwS/xtCgl/5cvvYocRmbTdNwxvbdxtxxpcOa+v2IO06WDNOQnuuel8tzUXV
         Bn19FmrMphwfOgCFdIdDxVRv6F9jWRKjsYR8puNs5EBhQHR0TQoZN7DO9kROOXOlFmH9
         RCm+hJniYd/W9BaOmm4TDzOhGNBEI06F/ND5yFPo1qF0X+NEgo2etvs3aVJ29Z9dMBMr
         X7Pw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775999323; x=1776604123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MhNSVDq+Mp4atqhKE+k2G9tvL4hBYd8ILox5fx+oqq8=;
        b=kuLJlfN2DofUdwT+syoUrQnMLqlZ2KfG0EBZ1q/hifobtYSVUf8KPZ+5/xpeS65+2C
         qyw3K6M4M9KjNrd5JZuGUGe3phaSxvCaCJzvrr7jmZbajOrDNQH310++fEFEenwmy6lB
         Vh9FDFQ/c85PE/z5N72aABXIV1fup6Qaqybice0OBLoS5r2LtVbLd3fkDHyX6a8LMhnj
         +E1+2MLUzdYmAh9HtLus2vxfQUL2HsxFmxvykoosuzJ2IM39eZU44BzhIQk6SSMpi76B
         TTNjs444BUPjEe9kbqlQ6JzCBO87y3LZ0lg9CPvAyTrfY/q4ZCccUdaHwMOX/JPzZIQO
         Yl1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775999323; x=1776604123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MhNSVDq+Mp4atqhKE+k2G9tvL4hBYd8ILox5fx+oqq8=;
        b=SVbBR9hvSMqvfsgtZFXi82dozbjtx32tiqUE5neuKe7ik0A8mRtT89+LwYz6bJdrPq
         hPExtXset1LOdv/8Nmkc5tCBLqtMjTquMxV01650zZWIiuetImUneDYOtkndw2jovwrF
         qQs9ZRv8oRLxQw0pdNlni+VfuEy3hIR/YN1LhhCtMb4AEkJMzTKckLKU9pzXnhmSHt0A
         8h+MsGFeDPyvJJ3nPnmw1eja5HHZRN7JVdSZhNh3JSxCN0lHpfEMZMJ2oc3oEX86SCX1
         M8BzhWmB6QGoHpDVP2bQ3xlixwTUB23l1g7TdDfDwQeoPv38MJg7cFV/EjrY/Ws820AF
         bW0w==
X-Forwarded-Encrypted: i=1; AFNElJ8AtiludtXC7rz6J8dqauDZuXAeiV/9RiqY1lqWidVOOZpjscqRpZRLnicxxreI60RAMF03M/l9Uzs6Nnd9IxufQss=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywoy9gTAX6aPVa3as3nNhEWeQfw0INq1TUf6KIDaXXUx5W1262m
	YF+RVj+RfTEuDAifeBR4X6gF/MDoCaHsGB5+t1Qv5hf9cIaBGqAZA2B5i2TQ4Hk3rYzOnWq8TWq
	W2kpBOWImgHtnldq0iHnwaeUVn4vv2gU=
X-Gm-Gg: AeBDiesFzs01fPB895UQcnjdyPPBKfrh+5TLvhP/yvHngv90A4uoEBUdV+wJG+qH57r
	KOJx8IFX9OaC4QZmGwJLX8As8Bf/PSWKF/m1woa1ZanWsKiOq65/poe+558Fu2vr3qAWtcA2+JY
	U1V7mnQu/viFHq8rDc9pWJtIdkIe19eGzZ/JCxs8D6AEo+eunWxmjYBe/Yo+eIUJ600WDds8D53
	m96kiJq8fh/ZOo9vzVLBpNWPUsAIiJzOKVaFkug8wKORHAIh6UR48vapDl0YFWJPKTAjIZZir3r
	nTbxk7/FXYtoJttH21md0NHrfFGgrHAace00JmcS
X-Received: by 2002:a05:690c:e645:20b0:7a6:1df5:c99e with SMTP id
 00721157ae682-7af71578411mr84093067b3.30.1775999322635; Sun, 12 Apr 2026
 06:08:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402092607.96430-1-laoar.shao@gmail.com> <20260402092607.96430-3-laoar.shao@gmail.com>
 <alpine.LSU.2.21.2604091145340.31526@pobox.suse.cz>
In-Reply-To: <alpine.LSU.2.21.2604091145340.31526@pobox.suse.cz>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 12 Apr 2026 21:08:05 +0800
X-Gm-Features: AQROBzAclerg8yyA2S4z9obC58pWuFg4E2KRrI1OP_QkCniXP5TtVECzkOzNGHw
Message-ID: <CALOAHbB5yyj4wJBOZnspVUPfoyumrxHcq2e27hzY881G+Jc_tw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] trace: Allow kprobes to override livepatched functions
To: Miroslav Benes <mbenes@suse.cz>
Cc: jpoimboe@kernel.org, jikos@kernel.org, pmladek@suse.com, 
	joe.lawrence@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, kpsingh@kernel.org, mattbobrowski@google.com, 
	song@kernel.org, jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, 
	yonghong.song@linux.dev, live-patching@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2026 at 5:47=E2=80=AFPM Miroslav Benes <mbenes@suse.cz> wrot=
e:
>
> Hi,
>
> On Thu, 2 Apr 2026, Yafang Shao wrote:
>
> > Introduce the ability for kprobes to override the return values of
> > functions that have been livepatched. This functionality is guarded by =
the
> > CONFIG_KPROBE_OVERRIDE_KLP_FUNC configuration option.
>
> this is imprecise if I read the code correctly. You want to override live
> patch functions, not the original ones which are live patched.

Correct. The BPF program will override the livepatched functions
rather than the original ones.

>
> I also think that if nothing else, it needs to be more specific then just
> checking mod->klp. It should check if a function itself in klp module is
> overridable to keep it as limited as possible.

That is exactly what I am currently implementing in
trace_kprobe_klp_func_overridable().

> Even with that, the
> concerns expressed by the others still apply.

--=20
Regards
Yafang
