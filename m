Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EC526D4F7
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Feb 2026 15:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.148.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772033122; cv=pass; b=WdYF9JToh811KHTtfmbVOjD89WvLP1ehzvHHkX30ht0ugF577ne9z+02Hqz0ncC6nvn410lXrwR+E7qrwm7YLBNFCVO1apFIElt9S6QADSmYlvyNfyJkagiH4EuZ6ALe6jNZ7porwhA6RKPTHQizPEHQDC5Ef/s92WH1ywzOv2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772033122; c=relaxed/simple;
	bh=KabiiyntjUoT20JBJnNSk9yycEy5eMorYUuoAN1FWkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lYJ1dhYzU6AV6LEuTKD/djcYmY3mPUW546RqmVEuwBtqgaWKI2CYdUTl8kuygxao3fTJTw93qpNgc6rhtJxm2JlbJWPIHYeDXV/ZeWWbG6xlqaCvQJeZ3mwfRgfAOXv0bj5ry8c4OYX0hLLaXYkkF9XGZvJHccMmc9PLOlfSnXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=dODVwNHC; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=oUxoCPhs; arc=pass smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="dODVwNHC";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="oUxoCPhs"
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PBoafj434527
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Feb 2026 15:25:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=r3rOnWcO3npnZzPx+0wbsHgL9j2g+F6nXf6M5nZ9J0E=; b=dODV
	wNHCcKhnKRC/QHsNuECXld9aB+8a5LY7R9H8wT+YigIdxVa+b8qIl8sqnhubDukR
	YGA4JsUbHC/DDZIqh7IRTNK8ZNW3B8ZTj8hvJKeV3QCj4/q43zKOeZ6ngUShe1zU
	w1e9JCwHak3AuCa/4fwhjs10EHka8gRimrMFMsCrEPcxEMXIjN2MuVBvDTVj6G7H
	HNbFA8RO/D5qBV+NAjenzwEaiyD1aPkiATimpl5qrPqWqsHrHSgcWnMhF7FErzKY
	xadSQ/NQsVsxaGxzDJxPO+kgz25965xvNpdZNsRT8b7Isw72SMbT/lMgM2ictoZN
	YJ5FxrAJoL26F/TYVg==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4chkgquh7c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Feb 2026 15:25:18 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-7987281c3cdso858057b3.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Feb 2026 07:25:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772033116; cv=none;
        d=google.com; s=arc-20240605;
        b=Ugz2pXETlO/4aoehIKKJ+61p9sZECqjj6OXUEHQz7tffYAPlrgQn9PL8Oedqo3QnwX
         78qMp6ezN9HSM4DamPWq6xQz385QqdB2dyxs558j0RvPWdhOKSQQlH8yzZ5y6HJ5KsKA
         rBfSIe8ObKleV+kGSU5Styij6JFQKX8igmIQb7Z+LZLj19pE9HyRfvK9GegPbdFU0QvL
         CBLUu9cD0mgtKu1NDQMSxuW7lxcTrrVYW/s4AYFtpONGZTiBAOrIPjBmSb8OK7cRc0p1
         O+mU4HuNz5O2yT1SB8SEg06DlUp11D73cqIx9PG2I/5jawM47i9xyuFEOhIDYl2KSfQm
         iLOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r3rOnWcO3npnZzPx+0wbsHgL9j2g+F6nXf6M5nZ9J0E=;
        fh=T699tEf9A7WopWSxkI8VfBixUeW6nMthrhkE5EHteCw=;
        b=NGPGE+JW4sS+TPj3dhQsz7Pl2avfsCfU360lnxTBD+aogtJbvWI9DR1nsX88i7GWOK
         jyw7VMyeCESHfrROl3+iSW9ZRr8rRCmYuEOToBu2/pUqf2QWJX80/eBFi5LgV9qey0vo
         PA5JJ8nmJedRKlfo7MOripHJ4qJXloXDRvvbh1smL7AE8Z1As0Vwj3RFFccRYAQ0aIeL
         gRgfuPn7HAQBdzgAvoHxQDHFKfm8IGIO86Dmf/ss7xLhMcbUic8Z1KN1cqb19ndCm2//
         MD8/DiOMNib2cvAiZHSWAmzy7lB0ujuGHR6yav8QRSHWkKL79BpEoRBiomp1had8sgx/
         6RrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1772033116; x=1772637916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3rOnWcO3npnZzPx+0wbsHgL9j2g+F6nXf6M5nZ9J0E=;
        b=oUxoCPhsedkfBc3TrylVAZN8rPbuZacZV9y+o6Ef/IeYf4snu4gEBJGVf0Cu/7e2Fc
         wPYcH0mNknQ6grJratxely8UC0JM7k9YuWrTT0hVIsCuYooHjAh4B/UD1SpSZG5vJmdu
         s7pws/O8tYKn1B2pYVGTXy+E3e/0JgWCiPjebzgwJEnWt/uEZzJkBnw+YEHFDGet3jUs
         u/K/+Udp18We8XxzfJygV13/iIJ7BsTvTBWnVJcRrOpFoJ30zgP3W7VLEyH3J9u5ZM9v
         y5hruscK+nCPVXPow2XlHhOowHFzBLgej5boMV0uiDbspFr43Zp12tr2E6fDQACEljf9
         IXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772033116; x=1772637916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r3rOnWcO3npnZzPx+0wbsHgL9j2g+F6nXf6M5nZ9J0E=;
        b=OMGHqGCapT43vPWWHlHOza2BFKHa4PG+iVo5XT3cRXn0egga5fEqn5vDkVxuh5szgH
         RO0XbE+y1bCrMk2UFqxTif8mAHlHeYzj25E9sKCY7c1xJoK30SgCgkmhcX+t28pvZYCX
         GQJO9h2yzFuoCXhei5bm8XASrqoepjtWMoRAZIN4sOM3yFMPKTLakSC/R3TQVV3YOiMR
         +yiiLrR9etC0HCgpLjNck19UhKRTro4Nx5BGDguOdcsapykQadjE7tAp6Ppwvm7W8hEg
         KIyy+5XPvEVH6P6IfEFOOdBfzW9syavDNsVsRKbexoPg1Ii6r1JJ3mzr0bMdyIc3datg
         +BFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrsd8/2v154Ua0zPYBM0U+HCrj1horE6FAbKM+LMPvfNK41BHI5Eec5Dfiuz15MLS3iZZZv05NL1Fk+xbHzKwrLaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVfGXPzc07dKq6RmRrtBs33K6g6JizduvSI31aU2FXGTR15R8h
	0ouUK9E5bdxL2k3URy3js4UMhgMNLNPJReJsXep4XRkLCtxzEE3VNDX8zlklyJbgwKkcy2pX40Z
	ggsOlMI1w6htvpdV20QLhOCjG9yIv+8ni+YlijyZ1j2LUlbmN/AoypH/DphHtS2kv48PF5oahU3
	nq27lRlnCQ+xTepC1WgnMvbfFeD0jsvZW2HPRfaJBBe6u37gPI
X-Gm-Gg: ATEYQzyzI/89WV9XoOXHnVTicSHKbdfP2W6UDQUXbjNvf3WCNfVGRuPSgbVPN95qlRh
	WTgnScw4C0bsaImwbMabkdQ1wWLSav9nKBzn5G/lzpO6Awd0h+lN1sWwfOi1kAxGHUI3uhCd80Z
	oI/NVEYHkNuDK22UgUSXfsoC78O79Lq8vEz/TJNcFUxUFcQO3gaJK4DMRn485/ynhp87yrKQI2w
	AtH
X-Received: by 2002:a05:690c:39a:b0:794:22cf:6d27 with SMTP id 00721157ae682-79828df8318mr152955287b3.10.1772033115659;
        Wed, 25 Feb 2026 07:25:15 -0800 (PST)
X-Received: by 2002:a05:690c:39a:b0:794:22cf:6d27 with SMTP id
 00721157ae682-79828df8318mr152955047b3.10.1772033115108; Wed, 25 Feb 2026
 07:25:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223215113.924599-1-andrey.grodzovsky@crowdstrike.com>
 <20260223215113.924599-3-andrey.grodzovsky@crowdstrike.com> <20260225064723.53bcce3e@fedora>
In-Reply-To: <20260225064723.53bcce3e@fedora>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Wed, 25 Feb 2026 10:25:04 -0500
X-Gm-Features: AaiRm51eNVjvePLenPXzkfp8kpIw1ud6qC00MFX-7ts1dpXjTZbA6sNKq6qrlhE
Message-ID: <CAOu3gNjdE_GaEEC__L=4v44iMJZt_eBN2Se_FotCDjX0BXwi1w@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH bpf-next 2/3] ftrace: Use kallsyms
 binary search for single-symbol lookup
To: Steven Rostedt <rostedt@goodmis.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, jolsa@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 9RB00SwTzig3xBFw7MKYy6YkI7VBsD07
X-Proofpoint-ORIG-GUID: 9RB00SwTzig3xBFw7MKYy6YkI7VBsD07
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE0OCBTYWx0ZWRfXxI2elPdasl4i
 fc5OXswna2c1lXppClZ0xNNrnxYMgJSCA6YL45NgarP9J/F1fkKoe13+AOqBgkRhM/QX2nNAzqz
 2KT3xNWLDQuEB0G9W/9a5rJl+TkukZG8KOB+dcxVUYeRrV9ZQoqOoYKYmwm2F2r0bXN+4m6ZQs1
 7WARsXG+53T+7bYgb1DQ+t0EeNMCOtGopyPgnFGdI9dHAJPKJsfI0HbjiAclw/ap71p8R+axlyX
 ewmwH0VOlHxUERItyCTsui3V7Wbbu22FUKtPB4kfTqwxZjJgwCGiwmPockpPGv+WLTVsZn/5gr4
 RyseEmHt5DOkXtODGR1QYKG+bVh9V+bFw8x4Upm3Dd4MrVUqETMrFaLNlCfUx11wQN0odCnP2vs
 p4ewVSxmQTT8RQVqeKNIoeDCDLjdT+itP7OT5ecSs840lmhtsKXF/dGHleM2nvhvhHpxmfJV7sO
 zkkyjycX3zp00n0ia2A==
X-Authority-Analysis: v=2.4 cv=J5OnLQnS c=1 sm=1 tr=0 ts=699f145e cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=b3B37AjAgz0HnGB3MuNd:22 a=meVymXHHAAAA:8 a=pl6vuDidAAAA:8
 a=lUMtyIEoyaf5RNnLcBoA:9 a=QEXdDO2ut3YA:10 a=kLokIza1BN8a-hAJ3hfR:22
 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11712
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602250148

On Wed, Feb 25, 2026 at 6:47=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Mon, 23 Feb 2026 16:51:12 -0500
> Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com> wrote:
>
> > When ftrace_lookup_symbols() is called with a single symbol (cnt =3D=3D=
 1),
> > use kallsyms_lookup_name() for O(log N) binary search instead of the
> > full linear scan via kallsyms_on_each_symbol().
>
> So this patch looks like it should go through the tracing tree, not bpf.

Hey Steve, are there any extra steps required on my side to make this go
through your tree?

Andrey

>
> >
> > ftrace_lookup_symbols() was designed for batch resolution of many
> > symbols in a single pass.  For large cnt this is efficient: a single
> > O(N) walk over all symbols with O(log cnt) binary search into the
> > sorted input array.  But for cnt =3D=3D 1 it still decompresses all ~20=
0K
> > kernel symbols only to match one.
> >
> > kallsyms_lookup_name() uses the sorted kallsyms index and needs only
> > ~17 decompressions for a single lookup.
> >
> > This is the common path for kprobe.session with exact function names,
> > where libbpf sends one symbol per BPF_LINK_CREATE syscall.
> >
> > If binary lookup fails (duplicate symbol names where the first match
> > is not ftrace-instrumented, or module symbols), the function falls
> > through to the existing linear scan path.
> >
> > Before (cnt=3D1, 50 kprobe.session programs):
> >   Attach: 858 ms  (kallsyms_expand_symbol 25% of CPU)
> >
> > After:
> >   Attach:  52 ms  (16x faster)
> >
> > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> > ---
> >  kernel/trace/ftrace.c | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index 827fb9a0bf0d..bfd7670669c2 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -9263,6 +9263,19 @@ static int kallsyms_callback(void *data, const c=
har *name, unsigned long addr)
> >   * @addrs array, which needs to be big enough to store at least @cnt
> >   * addresses.
> >   *
> > + * For a single symbol (cnt =3D=3D 1), uses kallsyms_lookup_name() whi=
ch
> > + * performs an O(log N) binary search via the sorted kallsyms index.
> > + * This avoids the full O(N) linear scan over all kernel symbols that
> > + * the multi-symbol path requires.
> > + *
> > + * For multiple symbols, uses a single-pass linear scan via
> > + * kallsyms_on_each_symbol() with binary search into the sorted input
> > + * array.
>
> The above is fine.
>
> >  While individual lookups are O(log N), doing K lookups
> > + * totals O(K * log N) which loses to a single sequential O(N) pass
> > + * at scale due to cache-friendly memory access patterns of the linear
> > + * walk.  Empirical testing shows the linear scan is faster for batch
> > + * lookups even well below 10K symbols.
>
> The above is unneeded for a comment in the code and just belongs in the
> change log.
>
> -- Steve
>
> > + *
> >   * Returns: 0 if all provided symbols are found, -ESRCH otherwise.
> >   */
> >  int ftrace_lookup_symbols(const char **sorted_syms, size_t cnt, unsign=
ed long *addrs)
> > @@ -9270,6 +9283,21 @@ int ftrace_lookup_symbols(const char **sorted_sy=
ms, size_t cnt, unsigned long *a
> >       struct kallsyms_data args;
> >       int found_all;
> >
> > +     /* Fast path: single symbol uses O(log N) binary search */
> > +     if (cnt =3D=3D 1) {
> > +             addrs[0] =3D kallsyms_lookup_name(sorted_syms[0]);
> > +             if (addrs[0])
> > +                     addrs[0] =3D ftrace_location(addrs[0]);
> > +             if (addrs[0])
> > +                     return 0;
> > +             /*
> > +              * Binary lookup can fail for duplicate symbol names
> > +              * where the first match is not ftrace-instrumented,
> > +              * or for module symbols.  Retry with linear scan.
> > +              */
> > +     }
> > +
> > +     /* Batch path: single-pass O(N) linear scan */
> >       memset(addrs, 0, sizeof(*addrs) * cnt);
> >       args.addrs =3D addrs;
> >       args.syms =3D sorted_syms;
>
