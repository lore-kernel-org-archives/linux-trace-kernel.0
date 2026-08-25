Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C901D9663
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Aug 2026 01:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787621049; cv=pass; b=HN0aVNVBsPgbSo93QIFwt4C080j1RqxoFsO7O9F1HVVfdvxrMc8em57CO7XUYlWmpf976jZ+IkfbT10DaCjy+9DxwX9qUje3iHFWcQGdXyhLXYEag9DgkxLHO6UXGacmdynRbAvT0N+HFh3vxfo7D6aMAw+16rbFCF+R5N7MY+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787621049; c=relaxed/simple;
	bh=zlW0sPnaL/HxicXK1THHcKSXYN0Q4UNXoUetwVVrSHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QkaiKgFqmR1lqno7vXtiBmyF81AfGOo+R37jGisz9SVxLTm6Fiwj0RrWrXxidv6ovEc1o+kCQKeFOJ+R0TR91Hx5ofh+83oF7c6PxVWEBkR0eXml290X1HzpXqxgLIAGo9mlj0ldXTfqxR6QRm6L8p0cHSkwQyvv5/5WFX3S0Q8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=giEt2rYh; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giEt2rYh"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-841f1dfc30fso4364717b3.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Aug 2026 18:24:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787621047; cv=none;
        d=google.com; s=arc-20260327;
        b=VcqYRJrdYRILpl72R7PVHSICB+7h6t+3FHp/3c5GOz3WsyHnaKovufq4ncbQoKYatv
         /VZwaBf5Soyh5K+FqsYzL16r+aGPI/9fKQzYfLg8B6BEcERT1mfeLnMpbpZ0UYsE9KID
         YXKkxeKrbHzUCEQ/zCFsDRX3QxYa4vwn4ZQDEsQWd0DFPapx5nzVvGInfBynHdk3bkUj
         DaYU8s/CTfSsaxS4CHdN3s2k87Bfd6lAbkzRft3eLjpTSHqZ+E6lZj0LgDEKB1kLqBbc
         K8Hn+kTpRoZkYZnmpH945G/mNY/+FYCgp4AjRvEWibrU1ENqRXrBWTXggJJ+eTDZj9H3
         knVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zlW0sPnaL/HxicXK1THHcKSXYN0Q4UNXoUetwVVrSHk=;
        fh=Ti+ixFm2BWPSf2kXVzEp53jK57aTZZSMhCGmyiKZn5k=;
        b=am9fmvwMl+S60HgsjpzYSsnOIV00HKEedPuuAQQXKl1jv2IEaPnlFhe+VDoi4G7Dfo
         ELxZ1vm0ryLTgmRIxaRXV5iO6pEoZNjgO+Z1dzMtX9UvCy2PHiH/tH/N6YVzI3a1Ql/c
         XYO3rME9+NlDfcMmBwPGpZ1bjVuoXrIptDhAG37JIQFbSunc/xzYgIxGLVQT/dc3ihdX
         fPZLDRz2ZQgpmhF0gkT/W1CaKKvQELkL49aIYJUOVPWyoj1TrE9yxcFFA+TXNrdFNZ3j
         4NBfadl5sv3CAbniE9+mbhtR29nZObkvYEt/URlWSeqIzthtRhY0bnRf14eHoagKq76O
         2mKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787621047; x=1788225847; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zlW0sPnaL/HxicXK1THHcKSXYN0Q4UNXoUetwVVrSHk=;
        b=giEt2rYhDGiR82Yf326eOmyy9AD6wr8IOvZ5KfFlSCZkMEy7rdTHiNFcnZf3KpEYmv
         TDWPkLiOTWt+tS62qN42Qta+xlBMdEm8Rg4nzHMsscGNcRusSsHJw0y8D1hhD7v0dOdc
         mczqFjeCeBZHk1MjRRbcpQ8MotUgWcXh/+oZLoQSVhAWOjJSxAeoEVAhkQCvQmf+NTVO
         jBIECIiILLE5FICEewH/+6fvTX+BCzmrT1blw2R/nuAiiVBi7MAAj9p39v6aaDh70QKP
         6LDHtE+LLnlo6djSXq3xmDj4SNWmK7IOtuv1hEQfj225YQ6t4U3bfkczFlZSrvcSxAcE
         frMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787621047; x=1788225847;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zlW0sPnaL/HxicXK1THHcKSXYN0Q4UNXoUetwVVrSHk=;
        b=lx7WerGeiXnx/Pv8fqRmq1HT3u1FcLq3ANTOvj/6kp7AbLxZascowMtdDvNO4hlS0S
         E0o0skxbAgjIByWHEAvlD6nr7zjlvgZZ2xOTBuxzc4AmdRDBcS+j+lh25t8TTD36dkAO
         BX2w4FayRkoAU6EL+At3AmZd58gfFSPnCfUCqErILHedUzjWFnKQ8SdPkm1my0YDSvuu
         bPKYQh4Hw6JREkUrEoXAk4Gj4seyANYkjSRVM1SHy/Z3bqWZXFLuuWDDbAZWjPWDKxJN
         2xDsAOlL2nroH6DdpBXiJs2Fa41JywStT3AHW7CHDwpiPxDDv7twC2JCuz4PsYqWtRDl
         dl7g==
X-Forwarded-Encrypted: i=1; AHgh+Rr0P7wotz27/4GfM5qo9XrdeowWanOb4zSCpbUnb7WI28jYfW1qzAnvO47t346VODERqiY526TZbMFN2K8q9H7p9k8=@vger.kernel.org
X-Gm-Message-State: AFuF++nYx1Te1b2MYjVPhjjG1JQYv3m7a3l5xHpE7rCgj07Bi+U2tSZE
	6mzq6VrQABBC4HJa5LgTYCNhspnnzSWVCsbHw9OgZU4giO75PBDVFvgatQ0zTWp1ihejgC6Z4NK
	1HURkmne9HcuVGENnSFpJLe+1tHdAWwxWSA==
X-Gm-Gg: AR+sD10psfbTDQtSfcAws4H1tk9+iwbyQUlTxRRJLpPnsc8uJMd8FdzGb66nKexfYpV
	xzh9U61JkoBi8vUiHeVljctTiDBCcw+K4odFIrgfkHpV0ihhBttvXQSfuQBIqui+Q+Z4RRdFgst
	0rqJ0bOTZRKYiroQCNF7wEXnxarmSzKU1vah8MXki5TfWqRmlNY24d7zMpfIewf653x/uvbIJrI
	LsdrfaR9Y4fbn22kG/K6aLWaxmJ0WqBDakzp/kLpf1F0480wQZjIk4eMJPm0jd7jtVqWn90EkMy
	eErSOm16tR04tBeVVze9q3Hk8lshlNa184ows0z+L2IPMeCKtI1gNAOBwcqmi1l0RJEqrZjGBQF
	AncKTbFJw0AuBkNRSaClVuqpnN2FKuX0o
X-Received: by 2002:a05:690e:4554:10b0:66b:28a9:5729 with SMTP id
 956f58d0204a3-66d1466d89bmr917985d50.8.1787621046887; Mon, 24 Aug 2026
 18:24:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824144653.54044-1-kartikey406@gmail.com> <20260824110345.22c1cfa1@fedora>
In-Reply-To: <20260824110345.22c1cfa1@fedora>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Tue, 25 Aug 2026 06:53:55 +0530
X-Gm-Features: AcwNN1UszChId5oB_w55eG86VnC8BYYkfLa8ASZ8by93pDACWQio_jfBYcn6AlM
Message-ID: <CADhLXY70RXpWsSNToYGsFniSht__2nd8xma4bkFPeR1kyWcL5A@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Initialize ei->children and ei->list in init_ei()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	syzbot+3ef80b4ed02226d04a06@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 8:33=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Mon, 24 Aug 2026 20:16:53 +0530
> Deepanshu Kartikey <kartikey406@gmail.com> wrote:
>
> Yeah, I saw the syzbot report and came up immediately with this fix as
> well. But the change log is way too verbose for such a simple fix. Did
> you use AI for this patch? If so, you must divulge that information,
> usually with a tag.
>

Yes , I have used AI to create a commit log . I will add the tag in v2
and the commit
log you have suggested.

Thanks

Deepanshu
