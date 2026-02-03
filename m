Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39D1396D22
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Feb 2026 13:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770126663; cv=pass; b=GG8+spzFQQBA8PndaKm2tSVn3miG7A4wj7Db0r4v0qPwUX5ZPJtQNLFm9BaCHCgcVuzKa0PwbMm8FSbpps795bc/i/hAnZAo984p6Xgg9I8zHoz9Xy1na9HxN+zA7JMJbx1tBPZ/gn57M7YxZxfMQDnkWQvO5JcwzjNmWGuJoVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770126663; c=relaxed/simple;
	bh=92XrpT2p9XU0e0xMy8WL1woti1sBDTSSs/ON0SJ4NhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qm7vNcNlPz6gezJAkgH65+K8dhwYdxc9viGO1uh8mhIPMCRCFB9DauxtbYA+cYasqlKpvDOhunRVn4AN1GHWKC1p0eK7FMD6jrnMmVituZERVo2PmJT4JNWkkg/IzGG3eVVdfiUmr5UUVH1+nQf6Ugbedj18pwK1wmSFnyFK0wI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKkL3Mc0; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKkL3Mc0"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-658ad86082dso9799888a12.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 03 Feb 2026 05:51:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770126660; cv=none;
        d=google.com; s=arc-20240605;
        b=l3PA24yK4jXZJ8MphgpUTBKnmF37UQ0TlZFqLndALj8pnWX2LFnnf5tHJLMz7O6iS7
         R/XYxaYHkxlIsOz9qENExbYxEJCwmuJknqPBOp3MfbuBXrpkga+IMFUoG9nZPXarnjqO
         0Uh0LAzUosLuJ1tyrsIk0RyfG0ZcPt8/0nkha29QTyBtT3A93IlnQ8Zkl9L6xFstSdTN
         hN0pPaEvJXtvg33Q6piOixfGH/LeLdJKEVuq89S488eYzfGcKH0V7dTntozycI5oQwnC
         2R5oJrhxpMcpIs0ugijlpmuQyrpa4WEIMU1R3yhlqd7zJnBKddj+pZXadlWkp0+v6qZZ
         3R7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Sc02BHMOvbhrAroJoMV6zgGl4CaFz7SM0OHSMbWN3/s=;
        fh=WTEgK3aLS7QN0qjRGjVNS/x+/sGZ+61H0BZuvvv0+eE=;
        b=VHBP8YK/YrLJEYsgVv694ir51LRAayCDjP6koCF7NeyHXQlQU2x/VD2UyznnAMQSde
         ZURd81ND5wT5/ot/f8Qy/6IJk+xtgBFO3nrcdpCZONz7m3wlKjTBrNXxoZV+7m7I2zQq
         6/HjCuhmjbTA3FIe7XBm5af2Ii7Cf0KLmnPd+KoxrUWMNUaolyxQqtfYB+5fv2CueDJ1
         B7zKfVWH2aSUY37Xhgh8F1NmyXbSyX1hxFbJKXJZ7BnsqE4rS0nO3O97BhyTPX+k3oDU
         LQTVEbslBBNs3W2jBLqu1insYYeJxmd8SVb4CHg3dM0/ainqF0TUuN2PySnDavWfuGmX
         DY3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770126660; x=1770731460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sc02BHMOvbhrAroJoMV6zgGl4CaFz7SM0OHSMbWN3/s=;
        b=fKkL3Mc0lWc/KXdzYlqMW9UNBZZx08EF7skXXHkwIBtGj1yzprbQy06sSi/S22k+LA
         gGcPQdA855UTX3QB+ZIGzjoOz/+UPb7cn6/B8f3UZFnlPMg1KDC8tkhzoqJv3Zk4NTUU
         Yp8jQtcYZ+q435sfKyuzYpNxlm+UHhHpJOUTjwxszyLPqjMAfTbECjl+JGf8EF6cuItE
         dg0nL6aWvjFxy8IkBT6Yy5sKIpX5w0HfKwNj0rpKIp2cxxcw+wvM/AVqd7onRdoGc6eo
         hPrKAQiagPzny3by1CqbnPkG3gmKzY2hg3/ApWyP0pdYi6FbrKopCDQZckjeyf1Mzw4U
         5oXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770126660; x=1770731460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sc02BHMOvbhrAroJoMV6zgGl4CaFz7SM0OHSMbWN3/s=;
        b=sUigiYDhAufbWj5iLsg0jxWOygEXqq9hpCUkYNPWoXPSRYv6uRmorvrLaZ76enr6t8
         SjXvbHixrhU4tz3uxDRCyhIK1itdvfjbGLCTHgfqt/+jmkyeZn+BfsIlXkOwFJ7MNRYT
         c9qkVjMIxXClApG8APJoUb0nQz3xRz0byUvjyRE4OQGK3mw799uU0IVRvJL7H+djJpqu
         hEmojv45rLjo35tA3mpf+DiPHu03zCPMwB1N59R6kG8/v0GxWNpHCPWIf6kip814i34z
         EOil+QJakPzlXto++eM6t5r5wmNa+VvVqRdHc1bl9sewPPhVxaMeidyyNn4L6fFjdMBo
         z8Pw==
X-Forwarded-Encrypted: i=1; AJvYcCVCvHkoOgLLmt3P8BHBpn7/TbF53NJYzpzk3xNpJ9PFekLo9Dikfc08rDX1H/4o5DaBHfyiAdfiFBSXFFN6wW+eAvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGffUAPeiKhnSodROd8MciE4X9uBNoXDiPOo2y4FJjI/m6u+lc
	AmOCsRh1bIeH2zFtFPftKV4IZ6vIhrOGOdsxpF5QZnTOzumePHHzlhHP7iwsWnVunuzdqz3PiE/
	KbDYTWbGXgxrKWnuqIQlL+1j4j5SZFxo=
X-Gm-Gg: AZuq6aJgHpCIxAlgpmjTMRjDXWTLgazcJWjs17LJlDlXgnT8ehVillwfcA/DVFChB3W
	8J0BuqBp8xhxnz8V3ydcQvLS38j+WbrDimKz9Xt59+dSxPBfR4gg7sbpnvRFOl2hJCILCKizPkj
	lWSO7OMYn5wROM801o0GBYUnYzi1o8R7ZsjIMe/sPQx00niDyE21SUQbzTdOuqTfqE7zBVqoo1h
	x1ed8zzpACHsYbAIOLKCFRgxNb4B1P2bfnSebEzCKKxh9t1GKedjhk/eKjeWB/frg5S3XKq
X-Received: by 2002:a17:907:97c6:b0:b88:5385:59d7 with SMTP id
 a640c23a62f3a-b8dff5e9051mr970303466b.4.1770126659761; Tue, 03 Feb 2026
 05:50:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202111548.3555306-1-dolinux.peng@gmail.com>
 <20260202111548.3555306-3-dolinux.peng@gmail.com> <20260202111249.649ac338@gandalf.local.home>
 <CAErzpmuFQqT3+7cSjq4HrYj0Bp_qjagJSh313_ePJxs+0QjVFA@mail.gmail.com>
In-Reply-To: <CAErzpmuFQqT3+7cSjq4HrYj0Bp_qjagJSh313_ePJxs+0QjVFA@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Tue, 3 Feb 2026 21:50:47 +0800
X-Gm-Features: AZwV_QhxlPy3i7L--W6IIHW5vk0g3VwD2o54QXIh3r6V9MmcHYUHUhrXDGupVA4
Message-ID: <CAErzpmvgR7QgUTkcEfYstci9wNfGZBksczbkMv5w0ijoUcsBwg@mail.gmail.com>
Subject: Re: [PATCH 2/2] tracing: resolve enum names for function arguments
 via BTF
To: Steven Rostedt <rostedt@goodmis.org>, andrii.nakryiko@gmail.com
Cc: ast@kernel.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	Donglin Peng <pengdonglin@xiaomi.com>, linux-trace-kernel@vger.kernel.org, 
	bpf <bpf@vger.kernel.org>, Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 10:17=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.co=
m> wrote:
>
> On Tue, Feb 3, 2026 at 12:12=E2=80=AFAM Steven Rostedt <rostedt@goodmis.o=
rg> wrote:
> >
> > On Mon,  2 Feb 2026 19:15:48 +0800
> > Donglin Peng <dolinux.peng@gmail.com> wrote:
> >
> > > @@ -754,6 +755,14 @@ void print_function_args(struct trace_seq *s, un=
signed long *args,
> > >                       break;
> > >               case BTF_KIND_ENUM:
> > >                       trace_seq_printf(s, "%ld", arg);
> > > +                     for_each_enum(i, t, enump) {
> > > +                             if (arg =3D=3D enump->val) {
> > > +                                     trace_seq_printf(s, " [%s]",
> > > +                                                      btf_name_by_of=
fset(btf,
> > > +                                                      enump->name_of=
f));
> > > +                                     break;
> > > +                             }
> > > +                     }
> > >                       break;
> >
> > I have to ask; how big is that enum list?
>
> Based on local vmlinux analysis (6.18 kernel):
> - 78% enums have vlen =E2=89=A4 10
> - 95% enums have vlen =E2=89=A4 50
> - Max observed vlen: 349 (extremely rare case)
>
> $ bpftool btf dump file x86_64/vmlinux | grep "^\[" | grep ENUM | grep
> -v "(anon)" | awk -F '[ =3D]' '{
>     for(i=3D1; i<=3DNF; i++) {
>         if ($i =3D=3D "vlen") {
>             count[$(i+1)]++
>         }
>     }
> }
> END {
>     for (vlen in count) {
>         print "vlen=3D" vlen ": " count[vlen] " times"
>     }
> }' | sort -k 2 -n
> vlen=3D104: 1 times
> vlen=3D114: 1 times
> vlen=3D116: 1 times
> vlen=3D129: 1 times
> vlen=3D146: 1 times
> vlen=3D167: 1 times
> vlen=3D181: 1 times
> vlen=3D183: 1 times
> vlen=3D201: 1 times
> vlen=3D213: 1 times
> vlen=3D33: 1 times
> vlen=3D349: 1 times
> vlen=3D42: 1 times
> vlen=3D45: 1 times
> vlen=3D48: 1 times
> vlen=3D50: 1 times
> vlen=3D54: 1 times
> vlen=3D55: 1 times
> vlen=3D56: 1 times
> vlen=3D59: 1 times
> vlen=3D60: 1 times
> vlen=3D61: 1 times
> vlen=3D64: 1 times
> vlen=3D68: 1 times
> vlen=3D71: 1 times
> vlen=3D74: 1 times
> vlen=3D83: 1 times
> vlen=3D85: 1 times
> vlen=3D87: 1 times
> vlen=3D122: 2 times
> vlen=3D38: 2 times
> vlen=3D39: 2 times
> vlen=3D43: 2 times
> vlen=3D44: 2 times
> vlen=3D49: 2 times
> vlen=3D52: 2 times
> vlen=3D58: 2 times
> vlen=3D73: 2 times
> vlen=3D79: 2 times
> vlen=3D35: 3 times
> vlen=3D41: 3 times
> vlen=3D46: 3 times
> vlen=3D25: 4 times
> vlen=3D27: 4 times
> vlen=3D28: 4 times
> vlen=3D29: 4 times
> vlen=3D34: 4 times
> vlen=3D37: 4 times
> vlen=3D40: 4 times
> vlen=3D19: 5 times
> vlen=3D30: 5 times
> vlen=3D20: 6 times
> vlen=3D22: 6 times
> vlen=3D24: 6 times
> vlen=3D16: 8 times
> vlen=3D23: 8 times
> vlen=3D26: 8 times
> vlen=3D31: 8 times
> vlen=3D32: 8 times
> vlen=3D17: 11 times
> vlen=3D18: 12 times
> vlen=3D21: 12 times
> vlen=3D15: 13 times
> vlen=3D14: 21 times
> vlen=3D12: 25 times
> vlen=3D13: 25 times
> vlen=3D10: 34 times
> vlen=3D11: 35 times
> vlen=3D1: 58 times
> vlen=3D8: 70 times
> vlen=3D9: 74 times
> vlen=3D7: 102 times
> vlen=3D6: 108 times
> vlen=3D5: 170 times
> vlen=3D2: 193 times
> vlen=3D4: 250 times
> vlen=3D3: 333 times
>
> >
> > Do we really want to do a linear search for every enum we come across?
>
> I think linear search is efficient for typical enum value lists (vlen < 1=
0), I
> also support using binary search where feasible.
>
> >
> > What we could do is for the first time we hit an enum, create an array =
of
> > enums, sort them, and do a binary search from then on. This could be sa=
ved
> > in the tracing code itself (in kernel/trace/trace_btf.c), if BPF doesn'=
t
> > care about it.
>
> I think this approach adds unnecessary complexity. Instead, we could
> leverage btf2btf during the resolve_btfids phase to proactively sort the
> btf_enum entries of enum-type btf_type by their value, enabling efficient
> binary search lookups.

Testing revealed that sorting within resolve_btfids introduces issues with
btf__dedup. Therefore, I plan to move the sorting logic directly into
btf__add_enum_value and btf__add_enum64_value in libbpf, which are
invoked by pahole. However, it means that we need a newer pahole
version.

>
> >
> > -- Steve
