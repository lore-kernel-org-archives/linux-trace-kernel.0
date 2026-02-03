Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DF61509AB
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Feb 2026 02:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770085067; cv=pass; b=LpUVmLOJF2yAP4LXl7gwTfdDec9wzNtXE5foqtcBqLtzj+M8OXzqBvXqrzcNlDZPOCxSLHk6JMdHX13Ayo+6Uf6gHzbhOXw0Deqg1sldJTYWl8l/I22O9n5xY9ei5lRJIavgtVGhAdRGdh+tZrf1ei913Cfo+M5PFZ/NvwpRSwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770085067; c=relaxed/simple;
	bh=0aHZWfo0g8Og4zuEPpiBCEr+AtqIm/VJHbD6dySichM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dxQCH9wsvyOWBziyur3PBHz3sjj0+T7pgrxf4XmvMsC/QNPTJBVCmNyOf1H4d5Z/LP6VwIeeNB5KV1JyfBN16hOIIQHNy0qus2APrMWrdRzEHq1Qyaa4XJa6fp4yVzUcRKXO/icTBnVz8kLsbKRXUQ3zLQ45oFj3XOLhhaYAtAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TaLxvLoj; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TaLxvLoj"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-64c893f3a94so551755a12.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Feb 2026 18:17:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770085063; cv=none;
        d=google.com; s=arc-20240605;
        b=kOU0bTRGdUpYGeenAcT5h/GFWx/hwwjMZ/z1wuA3NEa4SW+X0n03s73aOLzNFywB2O
         huaoM5eeP88m9dRr0ug8udp4mDtbi4Kvd/ceBPxNBYic4MIq8iFPnmY1hhEi0qeHJ4R7
         uS1U3RmI1TjHXKl3J4WpilAW9itCPaiMqazjZ8cJej4A3RanUdvUySdASCqyvBBTYHVe
         GNq0A7t5Quaipp7qF7aS0wehmZ3BrFuoQov9mSZ6rpB0b21FEgYbKPF1oSIEqgBuSuOT
         ghBzIeUwKqFUhy71z8NGYz5HvjuOCLbmt4S3wgorwWeqqzNwg5+IVE7V0mygvQnTAuEe
         6R9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6uaT/Dnt90LJerfn/1tIbPNraFr6X+CwcSu7kkviOhw=;
        fh=7/JdqyP70hotVj1/0u6rypaRSayuRrZqnijhkbS1yq4=;
        b=UbPeuxDo2kzxuSne68SPTXXdIQoKWvUZHo1YaJmRCVBxNI146StTEEPxiMZZqrPaPh
         k6U1+edm9tLgQzm6DYyRTL/a801shQGST49D6oRfBFG+ozVBsVHy3Z205cAg7lCQVtz9
         kaf8pQJG4W8V21I1BaU5+1heVkBY5SSTfZGHCXA60UyosltpyT1YrP4RMkcBBXN41Uiz
         vk8b4ydIeRbm+/6nIaqTz1yKNQfJGeh1KOy7mAfgyGDb9TSpXRgRY8ItgdeIzwOITIeL
         Ufy5Ws2ovDmtT3+rWKcWhl33wBEav/uTeMxM5r52ICvqlevu9hKAoqobHoiuNuObWPM5
         zbmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770085063; x=1770689863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6uaT/Dnt90LJerfn/1tIbPNraFr6X+CwcSu7kkviOhw=;
        b=TaLxvLojrNUPUSjeByHjP3mM0MKVHjwkKNup6Gvcv+1sVd8I21231SVfYW1inU2pxr
         9g+4wBNPQJ9U4cFaibQWUIzwuBzPdCegFH/Ed1wCfBWde+EBRXwBQ2+cAvatxW3CZFUZ
         fcie4Dl6TFlK0KGqunz25imSQkyHbUb2O48+Jz+hMi9UCD6jc949upAzJyfnKpc5fHcH
         2nRsv6PTipmxZPAb4nzuVMHXNIcl9fFzyQ3tbFYRmHZ5iZvIgfPrYiLSp6XI5Ly6AcSn
         6zShFw8YfmIagdbEl2Ui6AKZxhGl0vnEDBREHKQifr1eq1bltqg4nmeTj7Hu6mH0i6nY
         eUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770085063; x=1770689863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6uaT/Dnt90LJerfn/1tIbPNraFr6X+CwcSu7kkviOhw=;
        b=qbtqHebLmG6J/9UyuMWgy9nYZAEwu3tXaABMoIxcUQmL2q//bF+0oTC3VPrGMZhA6M
         o3/3RNrBaJet+F5bqUdUfjPsQJV1PMwvZrxNlLpxvbIISv29L7cIYw4F3JEwIHKsaP4U
         WiDJzpHruZTWdATSbC+EUDl0lRYYucr6O736//rVVCQswJZ+t1rUkmnl5VzItg5k8wVX
         e1Y1Dzta1moKousFasg/pCz95jE5KLasIj6cmVsOaIiMZnwysUF0O2yiALemys51EE7e
         sWFb6YBC9UBp5ZLQkDcq0nhDSu0u2j+Ul9bKEus5k9uGp1b1i7s31FVXS5FUNCHrcx38
         65ew==
X-Forwarded-Encrypted: i=1; AJvYcCVVTM9Z8aN0adGTKl2VLqhb5qJdwpmUATh/87fHjW6HrYqvEfPYW9VfyUHfUUSZbi+u9jsHybrASWJL8R0FXD2VTys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy5g0uxyiuyBcP884YD1c6TPM5TMU5gvUU/K1YkfC42HR8FYLf
	wjwoR12G3DNVXOGpd4BSs4DvNHTlmdPrjNEAVotrwQmNAe0tHe4JG5gBVfRXjG2X6i2CC9xOI1M
	nqclG33B+0jty9uzUPHN6IBZeXnP/lri4+8UEnCoOhw==
X-Gm-Gg: AZuq6aLUdsqBNlPVz2A5JBEiZA+O7BCfCK5lKH/3AeY9vtSly54ON6bpYP7A0Xcz7SV
	0neV/TD1JzlF2e77CgXg2WcNlyd+0+576b++avO59ifSpiTLiKzbYRpIV+EKUFZNDP7oe0e1f93
	kaqWHBL22EYQy0lZgjT9mFRDCbOtslLYmgxCyyPQuekJJ6b+LYI+eGIzyM2AA2BhPSpI10OcUHQ
	7DoouhgeM7ZLcqFYaPqjsoypQqbZWlIbizwg14HFe9QoMu8L7cQQGhRS9jp4t5vyDeIeGzY
X-Received: by 2002:a17:907:6d2a:b0:b87:8c1:1ea8 with SMTP id
 a640c23a62f3a-b8e83785d38mr84520666b.7.1770085063088; Mon, 02 Feb 2026
 18:17:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202111548.3555306-1-dolinux.peng@gmail.com>
 <20260202111548.3555306-3-dolinux.peng@gmail.com> <20260202111249.649ac338@gandalf.local.home>
In-Reply-To: <20260202111249.649ac338@gandalf.local.home>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Tue, 3 Feb 2026 10:17:32 +0800
X-Gm-Features: AZwV_QjVhxAkDUeoi87fgoO8dzlsZayJQ2dkC8DKgwmrKxzVinvN3jKgGEYGEZI
Message-ID: <CAErzpmuFQqT3+7cSjq4HrYj0Bp_qjagJSh313_ePJxs+0QjVFA@mail.gmail.com>
Subject: Re: [PATCH 2/2] tracing: resolve enum names for function arguments
 via BTF
To: Steven Rostedt <rostedt@goodmis.org>, andrii.nakryiko@gmail.com
Cc: ast@kernel.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	Donglin Peng <pengdonglin@xiaomi.com>, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 12:12=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Mon,  2 Feb 2026 19:15:48 +0800
> Donglin Peng <dolinux.peng@gmail.com> wrote:
>
> > @@ -754,6 +755,14 @@ void print_function_args(struct trace_seq *s, unsi=
gned long *args,
> >                       break;
> >               case BTF_KIND_ENUM:
> >                       trace_seq_printf(s, "%ld", arg);
> > +                     for_each_enum(i, t, enump) {
> > +                             if (arg =3D=3D enump->val) {
> > +                                     trace_seq_printf(s, " [%s]",
> > +                                                      btf_name_by_offs=
et(btf,
> > +                                                      enump->name_off)=
);
> > +                                     break;
> > +                             }
> > +                     }
> >                       break;
>
> I have to ask; how big is that enum list?

Based on local vmlinux analysis (6.18 kernel):
- 78% enums have vlen =E2=89=A4 10
- 95% enums have vlen =E2=89=A4 50
- Max observed vlen: 349 (extremely rare case)

$ bpftool btf dump file x86_64/vmlinux | grep "^\[" | grep ENUM | grep
-v "(anon)" | awk -F '[ =3D]' '{
    for(i=3D1; i<=3DNF; i++) {
        if ($i =3D=3D "vlen") {
            count[$(i+1)]++
        }
    }
}
END {
    for (vlen in count) {
        print "vlen=3D" vlen ": " count[vlen] " times"
    }
}' | sort -k 2 -n
vlen=3D104: 1 times
vlen=3D114: 1 times
vlen=3D116: 1 times
vlen=3D129: 1 times
vlen=3D146: 1 times
vlen=3D167: 1 times
vlen=3D181: 1 times
vlen=3D183: 1 times
vlen=3D201: 1 times
vlen=3D213: 1 times
vlen=3D33: 1 times
vlen=3D349: 1 times
vlen=3D42: 1 times
vlen=3D45: 1 times
vlen=3D48: 1 times
vlen=3D50: 1 times
vlen=3D54: 1 times
vlen=3D55: 1 times
vlen=3D56: 1 times
vlen=3D59: 1 times
vlen=3D60: 1 times
vlen=3D61: 1 times
vlen=3D64: 1 times
vlen=3D68: 1 times
vlen=3D71: 1 times
vlen=3D74: 1 times
vlen=3D83: 1 times
vlen=3D85: 1 times
vlen=3D87: 1 times
vlen=3D122: 2 times
vlen=3D38: 2 times
vlen=3D39: 2 times
vlen=3D43: 2 times
vlen=3D44: 2 times
vlen=3D49: 2 times
vlen=3D52: 2 times
vlen=3D58: 2 times
vlen=3D73: 2 times
vlen=3D79: 2 times
vlen=3D35: 3 times
vlen=3D41: 3 times
vlen=3D46: 3 times
vlen=3D25: 4 times
vlen=3D27: 4 times
vlen=3D28: 4 times
vlen=3D29: 4 times
vlen=3D34: 4 times
vlen=3D37: 4 times
vlen=3D40: 4 times
vlen=3D19: 5 times
vlen=3D30: 5 times
vlen=3D20: 6 times
vlen=3D22: 6 times
vlen=3D24: 6 times
vlen=3D16: 8 times
vlen=3D23: 8 times
vlen=3D26: 8 times
vlen=3D31: 8 times
vlen=3D32: 8 times
vlen=3D17: 11 times
vlen=3D18: 12 times
vlen=3D21: 12 times
vlen=3D15: 13 times
vlen=3D14: 21 times
vlen=3D12: 25 times
vlen=3D13: 25 times
vlen=3D10: 34 times
vlen=3D11: 35 times
vlen=3D1: 58 times
vlen=3D8: 70 times
vlen=3D9: 74 times
vlen=3D7: 102 times
vlen=3D6: 108 times
vlen=3D5: 170 times
vlen=3D2: 193 times
vlen=3D4: 250 times
vlen=3D3: 333 times

>
> Do we really want to do a linear search for every enum we come across?

I think linear search is efficient for typical enum value lists (vlen < 10)=
, I
also support using binary search where feasible.

>
> What we could do is for the first time we hit an enum, create an array of
> enums, sort them, and do a binary search from then on. This could be save=
d
> in the tracing code itself (in kernel/trace/trace_btf.c), if BPF doesn't
> care about it.

I think this approach adds unnecessary complexity. Instead, we could
leverage btf2btf during the resolve_btfids phase to proactively sort the
btf_enum entries of enum-type btf_type by their value, enabling efficient
binary search lookups.

>
> -- Steve
