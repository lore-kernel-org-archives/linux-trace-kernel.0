Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CE02309AA
	for <linux-trace-kernel@vger.kernel.org>; Sun,  5 Jul 2026 02:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783217499; cv=pass; b=FcRypd3HMuAm29rnUweOfXE35xh6LmnWvvvxcfKrFWspIvW/pZw7TtjPJ8olqbe932G2XcUx3xvPFt8BwgahN/NVr9g+nnm5WWwl8Knfo7+ZkF0EgdE7nmIQmdleo8W4s8c32/erQtaWJXZH9iL7yVG28byYAPIFWBFtvt05MSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783217499; c=relaxed/simple;
	bh=kxNPTAlLfcSyUWT9fknGJyrPuBuy2cw+GfowXjZrhaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RqVK70xLLb2wWO6DHVMFqw1TqrchNtwdzB0l2Vxx0vn5xept34/MvXVr0XUQoNcmg8eVuOwJLeQaC3zhLQfVdcQPfcQ59TPlg955BOG4TMg2iBjV9vf56zfa/7k5Ur/x95cpnlyhMe4VRbpZKOYXuVt9yn7NNjJ4GJ1Es374moc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmKdtRte; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmKdtRte"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-476a130c138so1860719f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 04 Jul 2026 19:11:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783217496; cv=none;
        d=google.com; s=arc-20260327;
        b=sPTnWqhbAHPmDE0dLKgRURRGIfFNK8cXLC0C+1N4V91B6xRyNkI3+zI+Zbs7zhyjan
         e78Mkpprh4frOP+UtpxbjKUhfmU/CWTDJ94eKGIxK8mLLNhnQc0z4w8/uLpWyqZSV9Jm
         DnNB9yEKN5OfDXIGYFiKRqJb18YtjX+KuWyCsTX1ZgNAdpKw75/DfFDP+gzquMCXc77n
         Opuy5LcJCMY+FGiz0wF80m3E8Z2W3MUzu1VunSKFAFZ2O+ZNUKcPeGzMFZad+14JFbhd
         JJvOw1iQW5bz+oeHFXWMLNzf47VFsATFvRK6pr2pmx9zgf2ItX1nfoQkLQ99ZXJPzM9l
         HdQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kxNPTAlLfcSyUWT9fknGJyrPuBuy2cw+GfowXjZrhaY=;
        fh=EIJ32paOtzX1sVXaDTcNYWexmLhI/z8S8uzyvMMW7v8=;
        b=l5q9zqX98zlIc3hX2LzhmG0LF/qfYaeRgCm3bvCnsxZaEW8VylGFli8ODfLgAVOCeN
         m6a8W1SZMotlLwjKDpc5Y76GWO8jbSJ9HrPBR0/U83OkqwZb3Ykrz5s+FODlFwJnLivQ
         gQorRyP+dy0O54cNT6D4+0lFXjt8zKty8p7hL6cFRgCNLFO37R5ZX7MeggBizC/E9P5f
         IndSJz2mnmf5HPUHRajR/xXCEb1CCiwzpEHT/k/UYQB62fxXtfvpdqhWhOaYLs89EjIP
         m0B89odvZVwWUq/KAxXYbjB/dVrXJWZfm6FjZn7Ao+hJVa7k/8JMHQQC/xgfs0DL/jan
         WS/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783217496; x=1783822296; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kxNPTAlLfcSyUWT9fknGJyrPuBuy2cw+GfowXjZrhaY=;
        b=HmKdtRtetM2NDeuyflLPyvdy/grl0W+ptN772MGAij7+nrHbbXhc2qymfD0Kb5PqMP
         ryLcrY6xh6NQjLQ2MJ9Fv5gSwpke/rB44sixz803C+m96rP8/YKQ/itznIpy8MUvMJil
         UUSjNEETrVFsP0dbmZGF0Tn3b4qcSpoYCEUkoZ8qq9Jn2sZHkelYODCB7QV6sqrdr/jC
         zrh3QMZ5ZSv+ytznAc9ha3cqn89lWqrCNun/9GbiRjj3OU2SMuSKLpEaytOpa/pF6YW7
         m8fTrMmEk4j/DFLdZuB5BdphHJLIgP/XoFSBOmiYaqx3yiClyxJBcS/hLRavFPyCBeaM
         ONHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783217496; x=1783822296;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kxNPTAlLfcSyUWT9fknGJyrPuBuy2cw+GfowXjZrhaY=;
        b=K/0jsx7gqmc8S3iZIe/VKTUnMZGitJYWSwT9ZIZiUQ91R3y4M39McLeiZAkSHb/mtu
         EfMXbrEcwIyWn7haAaa8aCZMTdiK9msFKGKbcxEB1HQ/A7D6qdmsU6gasV1qZiZ+b3ZH
         AJlhroY5Yn3RoFlnsm0EcA0mHtj2loF9ajFlGoTlfBNRGYmxX5QOAm4IZ1lkab0YlwR2
         MOBjdkWdZ9Tac2CDI95o1pXmWPsyWUBVfN+LsOvtJv4YrXIkwQU17foZaeUgjZaxOvV0
         yGL/5noPngmLSLOLGXXkdzQ+nwfHcpyegEiR1pr2eFl9Ckv+NrWy/sRnhUAaLttnDnYR
         wnLQ==
X-Forwarded-Encrypted: i=1; AHgh+RoiL2b2HSC+IlAUBtodQuFBwkwD2XQgNDcRyv6+d9iZ68WSRmtL45BlmYpgVwtrjzgL/ef+r5Q7uVLouFNSAJkglr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvcE6ddnk3o63RjjOJE59zOU/3PG+OBD99TMmPDVvw8AHPClDP
	sJGcPJzERwRGuWMCVFgwt4/hPvHbw/DACw3K/dDNYSsMlq77siVSzie0hgP+TZw69vj6iHmBg7a
	EMrvVnMwIcxXLnEC6P8ExKQUj8JsCE4w=
X-Gm-Gg: AfdE7ckNwAiL07ANEcIQ6LhkQeQ9PUU7ZFDp2GuyOtMQRFrz+gHlAuA9iULkIp4hiZl
	a9B8mi++pTIFrz2a/ytFDBAIfKWVh/OHy8qI9D05Uelhq9ME2Urd3PoCwpaC6OH01n2ysgQ+osN
	/2zmykhSdCXulpnic09c785TS1SqUAs0hQJJSsZyJvs0xzmkh86TJ9HfIBLI2z/zL8yhsHRrQCw
	yQH6wqfjYkNc0ldKFo5kd3k506K8X2rcWaNVWJzis0Ww3fDLE7bLHlp0c4LGRFGbKctMA==
X-Received: by 2002:a05:6000:310a:b0:474:fd7a:93f2 with SMTP id
 ffacd0b85a97d-47aab961efbmr5621255f8f.15.1783217496219; Sat, 04 Jul 2026
 19:11:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFk-A4mE9Jweo2hfX7y_85xbPyt0FqpMT1EvqX1OcYZ=LTLgRA@mail.gmail.com>
 <29129c40-4010-4862-9b4b-3bafad874568@linux.dev> <CAFk-A4n9U0r07tn6XHHqmOZ++-bmM4bSd-SwdpEU-88gjKts7Q@mail.gmail.com>
 <216969a9-3584-4dc8-9e23-50fc18b31725@linux.dev>
In-Reply-To: <216969a9-3584-4dc8-9e23-50fc18b31725@linux.dev>
From: Masashi Honma <masashi.honma@gmail.com>
Date: Sun, 5 Jul 2026 11:11:25 +0900
X-Gm-Features: AVVi8Cex59Et_09q6rUsvepTcxo82qiJkYVp8jk9ZmjruPc9k_ncvXD6H4LmGwo
Message-ID: <CAFk-A4mUijKffHg3QhOxC7Ne2rk_GVbYY2UJ-Ek497avdubzgw@mail.gmail.com>
Subject: Re: [RFC] xdp: add device context to bpf_xdp_link_attach_failed tracepoint
To: Leon Hwang <leon.hwang@linux.dev>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	kuba@kernel.org, hawk@kernel.org, andrii@kernel.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, edumazet@google.com, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=E5=B9=B47=E6=9C=884=E6=97=A5(=E5=9C=9F) 22:28 Leon Hwang <leon.hwang@l=
inux.dev>:
> Probably, you can get the 'extack->_msg' by tracing dev_xdp_attach using
> kprobe+kretprobe or kprobe.session, if the extack is not NULL.

Thanks, that's a nice pointer -- dev_xdp_attach() has both the net_device
(so the ifindex, which lets us correlate a failure to a specific attach)
and the extack, and it avoids depending on the tracepoint you want to
retire.

The tradeoff is that dev_xdp_attach() is a static internal function, so a
probe on it can break across kernels (inlining/signature changes). For a
best-effort error message that's tolerable with a graceful fallback, but
it's a maintenance cost on our side.

Since this is ultimately just an error-message improvement, and your
in-band BPF_LINK_CREATE work would solve it cleanly for all link types, I
think we'd lean toward waiting for that rather than adding an internal
kprobe to Cilium. Do you have a rough timeline for the BPF_LINK_CREATE
series? That would help us decide whether a stopgap is worth it.

Regards,
Masashi Honma.
