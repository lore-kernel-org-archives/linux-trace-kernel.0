Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65EB21018A
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Feb 2026 20:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772225029; cv=pass; b=YyutfnpwMaV0Vx7WWlH2qXc8UlrH4JtqfQ3+e2oa25KXE4TL7FAMeMhYgZ7Y/Oj0cqlT0sUIjBGtZNsMKi/RXdSZgElf0OpKdsbhaeA8zPKzHdymAteKPzdFsX/lflv7DIW3L9DinRkYiPsUKPH0GP/2KRC1CPnjiBK360rR75g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772225029; c=relaxed/simple;
	bh=gHKJrTNbYTOrGPVaPZydlPx1NIyWc342x1du+TckWdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j4o6UGA8Dr4LegHkz5piSEYMhY/v2s5T/CEwmdNWZ8aIZu47M5WWo1i1ecyBwpsUy+O0eO6rYdPqk+CdP/exhDagcWJrgVfVJJ1chTjL5CRv5pfRgwe89XXe6XX0hUgA/E8L1saPWiQDyJyyMqQJSgRxVgZu6XasMCTWTr6peOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OpfqDS+Z; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpfqDS+Z"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4398dd671daso2692169f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Feb 2026 12:43:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772225026; cv=none;
        d=google.com; s=arc-20240605;
        b=Evy2FnDl1c7XgngqiyK7wKHJnPl6GC7Bf2+DxGO0TfaE5wF1XJzdEHdxUklvQXuC/J
         RHD5uEBkIsGKxEOXqjWBJ6+3MWrwFoD6sfZfj8PxRz43w/BKB8cj4QTDXUTRoiuQhl1E
         1YE+k981XlLrbexv0wg/GMoVct9wRR50dfdxXM22JZ2kssqCzWiy5Mpr8q1XL7opqT1N
         Ch8ZbcKvDY0APGjHtt9bajm4cV7bF3F3OfmDPhbrxSY7ll6iUzA5ix6y49DdJRSm4k/5
         vh2uyO1kfjWj1SyPDdBLaPSf4N95XuEpqyXWvkoNj51Fvrz5iryjK72YdiBnNjywJgiG
         kUgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gHKJrTNbYTOrGPVaPZydlPx1NIyWc342x1du+TckWdc=;
        fh=vlHiq5fgkGz3LSC0H93sQIqEbKCjWP1tyCGNAg/OZX0=;
        b=DG0jJ8OU713O2iH0teDBDeYYAuH4mbSP2I8v3dNr1kmcz2h/7UPPwpEL/CT01FHtiz
         ov0GvmRAq3PYBKU6RPq+H87jvs1qKEpK/D87c1ucW/DmWUBRmdDzcZrr2+s2c6ASD6c2
         WXhop7HLejY/VIMBous+Khm59NMxpbckAzsWmqJvOSYQS0OHOOm5ZRbHgEif+ATXbn45
         lyGaJEkxNSL2oF6EnDMR+jQRqVJ+Ag5PXs+JFICn38qFCoOXzrjMrRGZWE9gUIansJ1P
         XDLQUhPpMZCyd4a8GHrJWsdIpzmfXuVyNe9eKojP1XDfO3o9gs1JjwLcqjn5EpStW0jg
         Tn7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772225026; x=1772829826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHKJrTNbYTOrGPVaPZydlPx1NIyWc342x1du+TckWdc=;
        b=OpfqDS+Z+LOKbhP1i6kzX1mAauPKLAhx7OEBne/UPFErvtOIcnI6GOMykfyee2w2GI
         JifRRMdc1kMNGPVzXN11mgNljSeDOKxG+LbFDT72QMBgZX+hYUn/no4KeSSlMnmgE1Ua
         G7jF+dicgqefIRzOUbFiPtBV7O/fN5/l9aNB7RLNEReUpJfwlZQheG3y2YK9mxsgC+9/
         PefKocH91SIm7l/l1RLj5A6FLFu61zjGdzadBoA214CmhaakECmywgNkFuLiCUI/sHxh
         Xg3MJ9r+rwu2B3H8qBfwNX21tgDGF9oUsswLUYanUxLAXytohwAF+icUiwBglb8SDYmT
         k1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772225026; x=1772829826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gHKJrTNbYTOrGPVaPZydlPx1NIyWc342x1du+TckWdc=;
        b=lyU4BjAgQNt/QZuoZzloWOtZzzwq0a1x73ujkDY5CLRK52573ljL8Cq3KC8C1sizt8
         hmZTg+O0gmngeF68MSNOD6d13mGZc33Y3+DH2ceNS1MRhDdkK9lpkl/9Kmg2eV/Lprbs
         Wgbk07Xzw5UEnwkgZ3RCPmNqGd0TVOu0x3Cq31Erneq1DIysl+BtB8VFt5inNm0W17bF
         RRSmzP2hSA4W3XXDtWxowyiwkfEl5K1bkiNhAXeWaxgGW3G4MNDW0DGERawUGSUZwg54
         O/NZKUruuEXfzrQ5tgjg1Lrhtch6ck8t2VuoOsCPhEfsnK52syjBwYSSk2wA0dOmVsuq
         YCyA==
X-Forwarded-Encrypted: i=1; AJvYcCVdn3mE9jK/RR7V/sVw+rwoJpvfqGrv5UgGh4SbMkkhjddd0qV+82Ug0kk9YyPE7wag833WeRRdjo1vgf/MDwWWnts=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPxi1WNT8vnvrISjBZ+1UwpcS5SICdGn9Pdcuh2nKklwj05S0C
	14i+l99ltbqiXuGDVOziTZUi34Kk1FfJFn3bF39mNPNuXRdpJjpZBbfzCY43tSPiaSJjC9o0+dH
	11wlDSVYK4FEmD3NlXH12aF27fKjEz8Y=
X-Gm-Gg: ATEYQzyTD7aDQz4ovWobSAxtSYuHpRVRsWWaIzVssm3gVrFiCHtg9xMz9VWz2XoqwWw
	xjLw4lVjSV1aMIi9KDVi/wVfRyd0+INACBIT8jaa2acuMvq0hLa+BX3lDkf7TEf0/Kqq9QFXtvU
	okZVfQYYbFo61MQEHh+5jzWdG0NntipT410YAmhlyNWFaORx83g3HFiUrbvj0hHdsDgQ2BuFZVe
	JWrFQzSdJNLtC44zkV22AHUqqFKapmY3pqpdk4O8mt0R4O5EXrxwEymPn9X4yW+0hKeBJs/jgCF
	/wUc5edomIrkCQOAY8/vF+jpvbNI72PkmikHVZOKGqahBvkY403lx004eEbMcW7N1EgAttErAZH
	Kt7phEIe5q8gy8ZJsMkyXcf2oRA==
X-Received: by 2002:a05:6000:18a8:b0:439:8bff:3639 with SMTP id
 ffacd0b85a97d-4399de3e54bmr7056308f8f.29.1772225025953; Fri, 27 Feb 2026
 12:43:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227204052.725813-1-andrey.grodzovsky@crowdstrike.com>
In-Reply-To: <20260227204052.725813-1-andrey.grodzovsky@crowdstrike.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 27 Feb 2026 12:43:33 -0800
X-Gm-Features: AaiRm51HtdBeaDeEwCSOw6inKTNkGNksTd8tcKmSDenNN5Aj-L_HdGa65_WcJG0
Message-ID: <CAADnVQLrhkCkpE6UZbkPaNTFMYRoa_ZtyknhVM7FMmsH7Lvj5A@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v3 0/3] Optimize kprobe.session attachment
 for exact function names
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf <bpf@vger.kernel.org>, 
	DL Linux Open Source Team <linux-open-source@crowdstrike.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 12:41=E2=80=AFPM Andrey Grodzovsky
<andrey.grodzovsky@crowdstrike.com> wrote:
>
>
> Changes since v2 [2]:
> - Use if/else-if instead of goto (Jiri Olsa)
> - Use syms =3D &pattern directly (Jiri Olsa)
> - Drop unneeded pattern =3D NULL (Jiri Olsa)
> - Revert cosmetic rename in attach_kprobe_session (Jiri Olsa)
> - Remove "module symbols" from ftrace comment (CI bot)

RFC series are ignored by CI.
If you want things to land, drop RFC.
