Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC113A8FE1
	for <linux-trace-kernel@vger.kernel.org>; Thu,  6 Aug 2026 21:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.148.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786052717; cv=pass; b=gCrQTWiH6PurF1Ew7YgT+jikkFMzHkYcBfoR4v2xrwqDCr7lQCgZwlb4c554JjCjWISQZiCoeKe009hFObAhDb2pCpiJ3ZU4N0L6R+0qhpqmhjOTctl7R/vdvSim+wrB9i7K4JHc+gn29VrzCx/vh6rV0+FiH1zYHk/VjvfP81Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786052717; c=relaxed/simple;
	bh=PK328fsXxrnSfxwWxbhaOTBsxDsbWAQZmZRHgDGiP+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eLSB+4B+BVrxbeOnLf+9/WWnlEE8KcN3i02D+lc67rUV4Nj1g69lNKFyVGdvNtC4u8INf3XZ8mZd+xj/ToKO0Hn8FH7PQe3PwoUhnolUhepLwStTIOnb28dKBTURkpRyt/ym4k3sT1abcjVN8mo/d6sGjk0QEdpV68AG8WN2e08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=OUEVn1af; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=alxYbj9m; arc=pass smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="OUEVn1af";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="alxYbj9m"
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676L3aeU791548
	for <linux-trace-kernel@vger.kernel.org>; Thu, 6 Aug 2026 21:45:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=P1kfv7quz9mKk+6GOaC33tWyYDCJTvIO1hmWivTvWbE=; b=OUEV
	n1afqfcYalp/dvkYGJtHNlajXOIIRfYZLt5YedM1CA6PJ1yxajN8vAxR9p9++GqR
	QOkueM3WMr6/5NUJuk7BCpttIkMW3qrzMWFgvQQygnBixEshBrGxw35kUN/ZUXaY
	Suieuioj7Rv4mZrQUn0Zg5+EB456OxQtxrAr/lGzxg77qpo3IG9TpLIa+/xZKH98
	ZnDbA/eLx2bHZ3TBVAkYiOEQtiWMvGHuFiHUhErdbIeLszHPYuefaQc+U7Jos09i
	0EBxPD+xQk9GZwpI75tnme4N4WVD4X1ed3Fr8kjqEXEF8VrQvnqXJBqaH9lwyxJw
	0a3TvZ0w+8IGNShi7w==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com [74.125.224.72])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4fv69t8pqf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Thu, 06 Aug 2026 21:45:14 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-66937c2e6d7so6497595d50.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 06 Aug 2026 14:45:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786052713; cv=none;
        d=google.com; s=arc-20260327;
        b=f385YFZfaLfFjOUM5/w45JNi4sIdw9/wAzFdknCzpfGE5+xuGTrtv6ln10Gc0S0bEG
         FUA8cFM1HEDXWaV5LZ6hVteBQknkPYVgi8ItvV4EvI8cOn14xL9zY/HxiAy5N4ALBKiZ
         /cYt4pmJK1kEVC9HU0gS9lLhf4y4lrtiLpdIfS+dzDNefq/NVZDpt2uOdGQDWcWeObpe
         wNKxMJ9u8nn9/XiOirIxy+K37laphj+GV60dn4s2lGA9EvVmCOSwDryV3nVDwK8bNoIb
         u12p4a89dwHsfHaSCQVmLHNDV7/AVa2r+e+SHX/6GWBZ9URS76MUQHl7AhMPawGxV86J
         wKHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P1kfv7quz9mKk+6GOaC33tWyYDCJTvIO1hmWivTvWbE=;
        fh=t3xFi0dNKnLhy9YPjOhQHzYqbJ4x/3qddAqmVfgWP2c=;
        b=obK48JuMY/e4FRiJtNGCSmF7y7M0h8jl4LuUMGPQSjIB7emoxQFq5SEOWhC+cI94lf
         PaBl0w2yhgliRySz4nxIWTgM5UgqN2+VkEu0Lu/q48ieB+E9VVWCdWjLDm37nYYHYR4q
         ySKMCY5j2gbSxQieqfDTgukRw48jIwWfZ1hODtLUX4FXTrxKT0oU2Squf31q+bOBfm83
         jGuBfm3Nipe+TFpTlhYWPcJ61Avn2tB54i+ekOVn+Dg41XyKbEQZkOEGkK9AysuaaWMg
         iGKiyVnAM/tZ1EqqfZaPB4qUrk/PSB91E3VKKxRZzinR/O8e2NrpsboI3wEh/RtEI6BH
         9E8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1786052713; x=1786657513; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P1kfv7quz9mKk+6GOaC33tWyYDCJTvIO1hmWivTvWbE=;
        b=alxYbj9mK+s/YyRrr/7GTyGfvDNkPGzAGKItaVc6sel7LSOdSEUmUSaYICAdDKm0YP
         PF1AI1Fn9vzJSgkwzzdEyTNvrFQ7SrYvsIZR2d4utplAeKKUy4Qc8Kwwwvn/HJU2MeqJ
         L1bR+b93ikkaYCQj/JaYEWmZaJWxC05Xe9tu/InspoVwGlectf4z3QEnxvynmAGblwQ/
         Qvti2AeY/6Q5F7IEA70XNrNMfKxFXE/GG7ClrMy9pkGx+IpVpxgOC9/yxucj9b1iyp+e
         267L5PGPlNuz0gLy7xr9/k+x+uEvGveKDZWjRhbHaym1ITdzFl0+58KhW5BDKP7zpxtP
         uDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786052713; x=1786657513;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P1kfv7quz9mKk+6GOaC33tWyYDCJTvIO1hmWivTvWbE=;
        b=C1bQEL20uqU0tL9xQ9N7RMLzKOZSCNzzfJfXFyGObAwHflTuzcipKZMkk2OLhPFYwF
         zoFfXoT19n2ZqUQTIqhQWfsEEp9WSLDBqk3Y2Nqwp8dsxuRwHW4qQs1pKY83katb38oh
         JFdGH0wp2SrYMcVD3nqXhiEunW15JWhqjlEoQ7eeme9PCuvbGva7M3D83VNDsm85XK1l
         AomUfExgwEmNDHsU4wTnDQWzL4fiBajaAOPWooHOABBhbaD1cN6Fu1AM83v+vuTo2Yd3
         x46LMOLmpMadmpCwA4PvGpmqJQy5V+Yb8SyEhgi0RWtrhUsV9Et1n6g+1GKZ0Ige5nwS
         tzbw==
X-Forwarded-Encrypted: i=1; AHgh+RoV4GHbRaGJA+0yk85Wx3nfdErO5uZ6rM74qMfo81dyEXgNvvfKDDzoRpRVEJ6Pb4cVlP0Sb+gg1g1xfGCAnybDRyU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc3gzpizRKq7Tc+p2g+sGPSVn/9QX83Hipy35l8wB+7zpRccXE
	RGSl4FONEL+FNefDK+FItX77YfRvTT0GAe5bz4uBwpdaJiRi9KgYUNPe+MPTVhSco2t4lXeFQR8
	ymSWGSNtdL1ysc70SfK9RxDQ/iFTolvYdMwvu1ZgQeUgYmooVZu0F8DHNm1U1rh/gxoUiKOpkpn
	SxscwojTLTuMbx0FMiTtr9BytP0TKLd3NFKW828u0gIArapglJ
X-Gm-Gg: AR+sD1000H2rmyy2cuL/0Fo00BXm6Gx7EB8Ua2VqjtW77u/KomYA68gI2+jLJc5Ge11
	9HbkBY+KZY9LQZYLPXg+kuqmpDMwh2mw0t3cJ3cMj5a84fWHpdaXG1KpJhiEMJ371QsRAlw9cFr
	pV+YfdGHIPP7TFKvTwts6Vj7jCQJaOEfShYsSNCIeM1apaZCXasIEsah1c7g==
X-Received: by 2002:a05:690e:b87:b0:66a:c376:6f86 with SMTP id 956f58d0204a3-66ac37673bfmr2597586d50.8.1786052713176;
        Thu, 06 Aug 2026 14:45:13 -0700 (PDT)
X-Received: by 2002:a05:690e:b87:b0:66a:c376:6f86 with SMTP id
 956f58d0204a3-66ac37673bfmr2597553d50.8.1786052712556; Thu, 06 Aug 2026
 14:45:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806153000.4184871-1-andrey.grodzovsky@crowdstrike.com>
 <20260806153000.4184871-3-andrey.grodzovsky@crowdstrike.com> <CAPhsuW7gOs2Opo5DRm+YKxBxwU+ncBmEAKHYO5jPjzxM9S8i5w@mail.gmail.com>
In-Reply-To: <CAPhsuW7gOs2Opo5DRm+YKxBxwU+ncBmEAKHYO5jPjzxM9S8i5w@mail.gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Thu, 6 Aug 2026 17:45:00 -0400
X-Gm-Features: AUfX_mycxuhE9bBXZ11D4K5vINcCDSJcPpDp_7gksuopKRHXb_3yuGXJfDBYFSA
Message-ID: <CAOu3gNi8i9m7nEuKF28G8cYqJULvE4W6CuDeYVFk58z1xSbBoQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v3 2/2] selftests/livepatch: update
 test-ftrace.sh for deprecated ftrace_enabled
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, rostedt@goodmis.org, mbenes@suse.cz,
        jolsa@kernel.org, mhiramat@kernel.org, jpoimboe@kernel.org,
        joe.lawrence@redhat.com, mark.rutland@arm.com, corbet@lwn.net,
        stable@vger.kernel.org, linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=QYJWeMbv c=1 sm=1 tr=0 ts=6a75006a cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=2KvRFfd_T_-xjmS8C1aD:22 a=ngmC-yC5AAAA:8 a=e25ExAebAAAA:8 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=meVymXHHAAAA:8 a=20KFwNOVAAAA:8 a=dDW-ktzWsA5qhXuJ1JwA:9
 a=QEXdDO2ut3YA:10 a=uujmmnXaIg8lM0-o0HFK:22 a=P5XVh-r7Nk77isVNjX_M:22
 a=Fx-rEtueDibNKiZPBj-h:22 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-GUID: e3ZH_YueS4C2w1xTJvtn9pxFOW4GGkBt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE3MCBTYWx0ZWRfX7uUi2Yvdl87y
 0k2IkXbKqSfdr+TL1zGg5F6yWxTYHiEumbs1c/F91zGKOs1O2F7vOKBK9nRlvvtTbfGKW6uvSPz
 qyiG+3LGHnJEV4q/y0MzO2Gv5uBZpuIZqypArW4DM5TnJIGosSmjhYS0RwVDRnGXfwcD85Oca4U
 CKwuXnpF6VNj87xIkIo5VJRbZRKiZaLVuidXI5x1eb2x9MbYlZnFvIKbUaWnSyRsoM4nVBHgg3r
 2ZDh0vSVLXFj+rKHr3m0pyVYtQG+AMvhsp0vK+Fv5EhNf6nflH9XV682banQFHx542uwnIlI8X+
 M7DyLsCxrsBPMh1x4TXFJBy4CY+H3UcHh763HKlX1g04qteDnVZieFvz9EWSxu4VvOGYHDIwQ5Q
 ql0KKk1ZhvdJLFKPnaTb3ENRAfpPZ9BPGJpvTuNb2JNgDRivpPcepekfMwDxgNyHWKHBnDWPgOs
 gw1EeAFiTlX5CpRq8zQ==
X-Proofpoint-ORIG-GUID: e3ZH_YueS4C2w1xTJvtn9pxFOW4GGkBt
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE3MCBTYWx0ZWRfX6x9c+bOJwIUe
 PyfNVxkqXk9iB6bofYTlpAaeYXYPozrGMBAZyEI13XZTlnMOOhwsjYOWEwNVFXzWg9K0ddPC8RJ
 dANan7sofsLhGZWU2vh9tspv/VkLKPAglTG9EyFqIpbsgm1u5rpc
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11867
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060170

On Thu, Aug 6, 2026 at 5:18=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Thu, Aug 6, 2026 at 8:30=E2=80=AFAM Andrey Grodzovsky
> <andrey.grodzovsky@crowdstrike.com> wrote:
> >
> > kernel.ftrace_enabled=3D0 is now refused on kernels that deprecate the
> > knob, so the old disable/reload flow no longer applies there. Probe
> > for this with ftrace_disable_supported() and keep the full original
> > scenario (disable, fail to load a livepatch, re-enable, load, confirm
> > disable is refused while loaded) on kernels where it still works;
> > otherwise just confirm the write is refused.
> >
> > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > Suggested-by: Joe Lawrence <joe.lawrence@redhat.com>
> > Assisted-by: Claude:claude-sonnet-5
> > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> > ---
> >  .../testing/selftests/livepatch/https://urldefense.com/v3/__http://fun=
ctions.sh__;!!BmdzS3_lV9HdKG8!0iHqKyQrLfspbt4sQvekjrQjWLuiSTtsCXR9obFozOCSU=
hPg1KCQGTvfgZ9oTwgBkdB3nKZA1RCYtwwYj2qtEXgW$   | 14 ++++++
> >  .../selftests/livepatch/https://urldefense.com/v3/__http://test-ftrace=
.sh__;!!BmdzS3_lV9HdKG8!0iHqKyQrLfspbt4sQvekjrQjWLuiSTtsCXR9obFozOCSUhPg1KC=
QGTvfgZ9oTwgBkdB3nKZA1RCYtwwYj6oTNhr1$         | 45 ++++++++++++-------
> >  2 files changed, 42 insertions(+), 17 deletions(-)
> >
> > diff --git a/tools/testing/selftests/livepatch/https://urldefense.com/v=
3/__http://functions.sh__;!!BmdzS3_lV9HdKG8!0iHqKyQrLfspbt4sQvekjrQjWLuiSTt=
sCXR9obFozOCSUhPg1KCQGTvfgZ9oTwgBkdB3nKZA1RCYtwwYj2qtEXgW$  b/tools/testing=
/selftests/livepatch/https://urldefense.com/v3/__http://functions.sh__;!!Bm=
dzS3_lV9HdKG8!0iHqKyQrLfspbt4sQvekjrQjWLuiSTtsCXR9obFozOCSUhPg1KCQGTvfgZ9oT=
wgBkdB3nKZA1RCYtwwYj2qtEXgW$
> > index 30dc677b2f45..a65b7b1ac8ad 100644
> > --- a/tools/testing/selftests/livepatch/https://urldefense.com/v3/__htt=
p://functions.sh__;!!BmdzS3_lV9HdKG8!0iHqKyQrLfspbt4sQvekjrQjWLuiSTtsCXR9ob=
FozOCSUhPg1KCQGTvfgZ9oTwgBkdB3nKZA1RCYtwwYj2qtEXgW$
> > +++ b/tools/testing/selftests/livepatch/https://urldefense.com/v3/__htt=
p://functions.sh__;!!BmdzS3_lV9HdKG8!0iHqKyQrLfspbt4sQvekjrQjWLuiSTtsCXR9ob=
FozOCSUhPg1KCQGTvfgZ9oTwgBkdB3nKZA1RCYtwwYj2qtEXgW$
> > @@ -126,6 +126,20 @@ function set_ftrace_enabled() {
> >         echo "livepatch: kernel.ftrace_enabled =3D $result" > /dev/kmsg
> >  }
> >
> > +# ftrace_disable_supported() - probe whether kernel.ftrace_enabled=3D0
> > +#      can still disable ftrace on this kernel. Newer kernels deprecat=
e
> > +#      the knob and always refuse the write with -EOPNOTSUPP.
> > +function ftrace_disable_supported() {
> > +       local orig result
> > +
> > +       orig=3D$(sysctl --values kernel.ftrace_enabled)
> > +       sysctl -q kernel.ftrace_enabled=3D0 &> /dev/null
> > +       result=3D$(sysctl --values kernel.ftrace_enabled)
> > +       sysctl -q "kernel.ftrace_enabled=3D$orig" &> /dev/null
> > +
> > +       [[ "$result" =3D=3D "0" ]]
> > +}
>
> Since the selftests are shipped with the kernel code, I think
> we don't need to handle backward compatibility here. Instead,
> we can just assume disabling ftrace is no longer supported.
>
> Thanks,
> Song

I tend to agree but I think here[1] Steve and Miroslav asked for
backward compatability. V1 was actually the way you prefer.

Andrey

[1] - https://lore.kernel.org/bpf/alpine.LSU.2.21.2607311104390.25165@pobox=
.suse.cz/
>
> [...]
