Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794558686;
	b=eq6MIpV92ZUMOvPbKiKtrwlA4UlA7A7dgapkOBzbTsfyo2YORLTzgXh/SZnu+jhPqNiz
	 /l5D1qpAT0S7CkK/RM87VWmrlUFgQUHXN1ud7hI8gzbD7bG3rY0aKhs9NS9AmbFJiCYJ5
	 6VM6CfWCx1PhvAgaYCaB4EYTyvcBScGzGRKunmOiIrG7LO70QMo62iUerARrmNRDrpiO0
	 knN5lCgBKfusevCS72pRer7W8I6L/CwV93t77zjphmQ+AQcQvcDb6iLdeHENLIlX35/CY
	 G9UQLbIMd0hVRooH67/VRPjaNnbcIi7HBCm5/3wbx5xWyCFNSGUaW4oO/y5qvn+yMPg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794558686;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=qh9VAxc0yOf7sHhKeEjPhh6+juHQS4PhRPr6V8+HsDM=;
	b=aKe3sjhmQ6yYEOtq6yLCFVpTG+nfc8CITvHJKxKVXUKb9MMYIl3fjJ83RMB8W7NTTdb1
	 LGXsy4luJr6M4FJiFGNU0rN9IBqEV4kI03G+nDmtFygzOaezeg+pIF9Jf7/KZggoJRHZR
	 fhURhx3zWQI3J3fRb4Y60h1KiTDawMOItzIH/FSiEXA/IsVBnLRMwUWedfylaMp+fXbhu
	 iZS0tlhgnQGQRh18U/aDxxnBBHL6Jpp/Kmb1PRuhBZow0rjqj2EpsQBv0BcVtyZeKyDD/
	 x3Q+w4uDD0P8bnAkoAudZI1BzXkjYUXdkd5FprhoF4OZhwM2YIonrRTRYCfwMmjOIng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vwvHdXcj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.181
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A9C606A32A
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 08:31:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72A9C606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vwvHdXcj
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5eafb65e169so1046180e0c.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 00:31:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794558685; cv=none;
        d=google.com; s=arc-20260327;
        b=a44/Z76DLlVHVjNgMMfDkCfAOmuF131xFUkZL4MGnW9XEIKHyCT2hTcbRlqTHy72NO
         ZSUMDaSdcHnmhQcNAwaAZ7KFm40J2LWUaqOhCVXIoEKqiLy2jETAN7tbPF2/6lvOIkeG
         TaD7l//Kk0cdyx815kt+uiGdIu/Xr+g6EErUVFoh8tR8PksbBIgG3UffUsb/arQ0Idy5
         W2kynOq8kIEXflDXj+WnRsCNtPnokYf8tefGU9J8+QVzYZd3FXSyoAeOyp39B71R9Zvf
         SvQGjhvRq1cRSWi3Vyn4gE8A194ctr5qts9HxMAo0FsZdbZZNHj4VZOJNexxMx+fM1Z1
         HK+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qh9VAxc0yOf7sHhKeEjPhh6+juHQS4PhRPr6V8+HsDM=;
        fh=MwLf2CZeDIEsGV3+HzMVd6ouOdXRgCGb6B3Mp8jK5HI=;
        b=EUN2bBlhbHOtN2+jj0QogcWu7NFOhugPXrP4qQwDUGv4gU4PnF/217hVJdirjfDdR4
         x5NFizkJmLGDjN6MXAovvXt45bQjXeN7/gkQT5ISa1dlvUaQShtmlftuEYn766+n5fap
         GTFYlF8+SeLQ+Rr/5j8cfdSq30HO/WwPoRw6xBgiMnEBMuys/LiFeMZBWKAvugoqxdJu
         rkW6waHY7z6qR5LrKn1/7Qdbb7GVUB+nyk5HhZfl8il6xYKAglhAT7vZvCerjgOnKPDn
         opgSF5NgTYke6PibEVJJAZ7hzve/CV8aiNF7AO7ODw1zHko3gFzItH42bs1MwM+IMuzf
         cA3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794558685; x=1795163485; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qh9VAxc0yOf7sHhKeEjPhh6+juHQS4PhRPr6V8+HsDM=;
        b=vwvHdXcjDbzxcP1qAc4+OmygMV6ohjmaT4r5PuomOh6Bhv42hnUThdRbYnHJbsS7Mg
         gtdCKhK345EGZAIzwvUI6uwiE4PzhzH6vGYAB1QbjXWdtONxBesrGEIVhLWb++vhtCw/
         RPtIT5hAlZQfR9hjHicxQ4ql9bdGqpMDU9eBkxZttf48rDInvMMs6Z0mNbsh1sqoHMGt
         0aKpMjflHl3Pw3Vd+58l2SzwKr2dSoQigJBrZPIiLxVYJzwnMBHMBvEFhilnE+mIhwPi
         N0YR/9DTKvEH5FynQY3K13xwscohZ25m+WB+QCKDXqigoeV6hSlFoA2O1m+2xEDvGIfs
         wHeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794558685; x=1795163485;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qh9VAxc0yOf7sHhKeEjPhh6+juHQS4PhRPr6V8+HsDM=;
        b=FdnHDOS6z5h58snGcYU++JJbdCYfBZ5pbVbXL8ap92ji8ADX1anHUIEkE4DKGsZZyE
         Ff1X6IytqeMotNdcXb6STZtYTF2+dlxnBtZuGdqk5ckAyWZQlcj8qu5eN5osIg+yb6N+
         BAuroEayXHLJUE3YSeHS89TjeDtT7D+3uKs0xI3lJ07HzEp8HjmqJsrWQ/IUX4EEv8Bw
         JYsw4Uc3+ww0XjMxt396LH2nYH3JrU01+W/jZGbfd1m1UxtpOInSCak8QW3kya7B7UlD
         ni81K0CYfDcyPMeruYaNekYVLwTGnAHohtm4MHEDS47wHMOLb1T4m9IsMsl7/eDIdDTX
         qg0g==
X-Forwarded-Encrypted: i=1; AL+hErGgA55Q4B9PJlvCFrpnAolMZKC2m/qYAh2NMGnod5KoSlOX4BRHSB3sZlWeLEznFcszuD2SNAk4AwxWBTUtgUStmbw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ZPXoNNC3ZiV2RgtFF1hJeRjkFllr3QrOhrw8aXp80mT+1ePrT
	GbXGxvDG5rBMQqKG8CNaN288JK2VT0GwzacMuT3idbc/76tnJm3hWF0dfFRKiEHDXevjFUVM1cY
	SFLvpFTr3ZSI7/HUaSbVhtgw7RlzFjRQ=
X-Gm-Gg: AYBFou1gubXLxk9E567JsX0MjQhBNwpseCmzWmzFv7+NBqW9v826Gry4s+PHd5qzQ7u
	mLmR3YyBL4kU4dYxYK5DkQLSnAYrsGKISQnOfdkQNOvkDvmVh32t5GqXQ97O5EBWf+stur4hVi9
	7kr+MT7PSkrU5/qJ4MCalC7eMA0Olyi2o83sX33rILmCPnaJ5PXdIgliv2fqa03AK4hqRkjdB8q
	WRrAO1M73bSXLRRpNmdkAwtM3j++d5azobqI4htTbh/b9GMkbXjIfkjVRTygclqY+YRlBx1gaS1
	RejyuPH7U+yygJjIF8aBWhJTqRze43N4OnlFy8Vw9z8hbRVrbwRpOd4Sp5WoMOxceEm8+JyWEY+
	6VNvQTDig3huLKjF2diPMfS7mlIMdvGitgnpZehheg8unmAl0ebDq6lxexNbaNnGe7WU4CEfugr
	bH2bE7XNZ5J3ffQB0JRiJd7bVTa5nsNXsvnDPKncuNJqNhaCFZ4Zc3esDSdHOd40KumR67U+B67
	U5uKlsBP5hTj4B+G4xGjJYdkYEXFfBOBWUamC4B/cOD1ioXfSXw5snkLCQRzHA0oM30f/C+
X-Received: by 2002:a05:6122:512:b0:5cd:590:c22e with SMTP id
 71dfb90a1353d-5ee34b160edmr531605e0c.21.1794558684447; Fri, 13 Nov 2026
 00:31:24 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1794333957.git.edumucelli@gmail.com> <cover.1794337724.git.edumucelli@gmail.com>
 <6ad95c1a6eb524143a38ef9a0d4fd87b92ef1daa.1794337724.git.edumucelli@gmail.com>
 <undine-1794547280843201319-34d0935dcdc44d3a@undined.local>
In-Reply-To: <undine-1794547280843201319-34d0935dcdc44d3a@undined.local>
From: Eduardo Mucelli <edumucelli@gmail.com>
Date: Fri, 13 Nov 2026 09:30:48 +0100
X-Gm-Features: AclHuK8SskzkyE6lr5Bi-ArH1tX0oRKTmCUc2F5NgsXgtlf8OJuRKNQ5Xe9Uu6A
Message-ID: <CAK0NWSO7ieSgooH94PY4g771CRHNXVas08cTrMnw_vt+Y3h+-Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] tools/bootconfig: Preserve values containing both
 types of quotes
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: akpm@linux-foundation.org, rostedt@goodmis.org, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Masami,

Thanks for the review.

The parser currently accepts the value, but the tool prints an output
that cannot be parsed again.
I agree that rejecting it would be preferable than supporting it
through the formatter.

I will drop this change. Would you prefer a patch that rejects mixed
quote values with a clear parsing error?

Thanks,

On Fri, Nov 13, 2026 at 6:21=E2=80=AFAM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> On Tue, 10 Nov 2026 20:08:47 +0100, Eduardo Mucelli Rezende Oliveira <edu=
mucelli@gmail.com> wrote:
> > An unquoted bootconfig value can contain both single and double quote
> > characters, for example:
> >
> >   message =3D He said "it's fine"
>
> Nack, I would not like to support this unclear value in bootconfig file.
> It is OK to *detect* this kind of mixing value as a wrong value, but to
> support this, we should support escaped quotes and force user to quote th=
e
> string.
>
> message =3D 'He said "it\'s fine"'
>
> But is there any actual usage for supporting this syntax? I would like to
> keep the bootconfig as simple as possible.
>
> >
> > xbc_show_value() surrounds any value containing a double quote with
> > single quotes. If the value also contains a single quote, both compact
> > [...]
>
> Thanks,
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>



--=20
Eduardo Mucelli R. Oliveira -- http://eduar.do
