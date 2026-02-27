Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC433559C0
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Feb 2026 22:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.152.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772231301; cv=pass; b=SlG7OFrEhVmbhvvW1qbndgUdQ1nFfQnNNS89pICnVcREqMSYJ02I4M9whJWN0SP/yT1A2BJBx+vNrL0NMXUyvX0JIw96MKA3nuGYgaZyNWJfTkl4ket2xWJIS6qjkL+AWiLSa7iKeABGZbG16GvPxztoyj2KrwaKEqLwq/fzPoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772231301; c=relaxed/simple;
	bh=RrAgxBkR/lFQ+itdDU9V1LQ1M5mKPBoFb43/f4yg7ws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JDA7Nf2usr84zW6kXks7Xac+neMJAl9uhjuMMFPTezDKdLgC61DpmMJ6R9Z/Vs5WeciAwAajmwiU5anmOYNPjiLm3X3PUEoYxbN4Bj7bkXx6FYdqRFuRkm+8Erxd6pRIgn7uES6uXNr9wnWWLCvfgCiPMGp7FS3HtyNHMzPtyYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=rcIiH85l; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=k79x5lBN; arc=pass smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="rcIiH85l";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="k79x5lBN"
Received: from pps.filterd (m0354655.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RK0GsW1162449
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Feb 2026 22:28:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=BU5BHpRLVtirnnsOgnXnkqYMBnqqkNZ87HIXt3g68oc=; b=rcIi
	H85lwEjHEa+jVsubmCLh/twR8zxBwWwbPc/5IXvOsyrQbHvLb1u4Q/xkPxdR/YsT
	BXITZ41cWeWDuuDdhf8fq9R0f/ukITV03/660Ycq/zyoJuNT4vF+nRlno2YtlPty
	4P389IsH89F8fqxhLEA0l36deeGq09sLhtw2sccPOJCTmIC0KTvQTADBw2O4OCVP
	V5Dac7sJsL1nSoBnKDfjgO5x1Bu3mUsbtP0FmfpBjuoRlAvPARNcDJvFZOwHJgwh
	wINvzOey8FFGft7COWKbiUEjJ96L9uwtxVFl9ludJZu6t44Un+KwfysEyaWWMzbs
	fK5YW7ztxReYcPY6hQ==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4cjvr14vr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Feb 2026 22:28:18 +0000 (GMT)
Received: from 04WPEXCH009.crowdstrike.sys (10.100.11.79) by
 04WPEXCH011.crowdstrike.sys (10.100.11.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 27 Feb 2026 22:28:17 +0000
Received: from mail-yx1-f71.google.com (10.100.11.78) by
 04WPEXCH009.crowdstrike.sys (10.100.11.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 27 Feb 2026 22:28:17 +0000
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-64ca5bae25aso4706498d50.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Feb 2026 14:28:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772231296; cv=none;
        d=google.com; s=arc-20240605;
        b=TkyukDW4MNmgy/xZzYilxRhcL+99OEbVADQAeziZ948iUqok8H7XElH1GmG33OY3Bd
         nmKoMm/qznfzSuJHjm5MSbGNaNa5OHx3EQyZodeGLQCfSgkebYgcnFzYdKFW/5YcQvWz
         SyJaGkBaC5au6clojVVZCUZsQnQMKYJ4DRYscSFWLBEE+KSJMqglpNkYXU4HDsV7v5uG
         cFOXIMl5h+W30g32zNPhVcxmoyssljNERaCngdxt2L2HoXVUSO7vz7xejS1eAg3LdnGs
         fZKgbs0WaFKDsU5bzIJXx13f2FhEgLe6pvnPeVEX8/flzai4K8hOX/cdifFl6djzLqIs
         PhJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BU5BHpRLVtirnnsOgnXnkqYMBnqqkNZ87HIXt3g68oc=;
        fh=8H8nS47rwddYMCTTOxlv3WDIn6uEC2oXyN/eft6wC0U=;
        b=JcwIlQJBP0lCTMY/L51XvfZKFNWVnkhkjSImatLhEWzxfktdZAQyVNCs5E5LwKCzkg
         qUvhIMg8ZKPVrIAYTmdru0UA3BDDEkYuAiWfYgNj8DOACP90P5nOqLYrbc6nHykgW/jo
         2/TLIxe4uQAWLoik/A2Gvxcer/Cz8Wrdq9E0snGqevnq1yui2BTRGUJByYi0Eor6ajUX
         k3hv5ZrDZSGnZaL3y5lG025ttvSik8bX7aa4PePVTIjjnrR1HYlHuQvGLHzdjp9MZ8DX
         tgmb83af56QU5hLiSpkLEmlfOTkWQCwRS8Rs+0ssNz4by180UMJt5qzerrGZ30cfQYZe
         0bzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1772231296; x=1772836096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BU5BHpRLVtirnnsOgnXnkqYMBnqqkNZ87HIXt3g68oc=;
        b=k79x5lBNN/Qc8OgVfR3D56aBIUGnDPrgj7esPgyIuMTeCMFfEe+3n5dZeK5bvc15TK
         rBMJTAtkkSH+0uoW7eyieqIqjVk7fnQKLivcyPz5Z62EFClBIyuL0eBj0IBvndQp7wrE
         5k4odjXeumWtlzdHU/ubWclKYQKI7TBZCXch5JkyxubzVvBnnxMSzz1BMdDXkT48OnS0
         KXUTvmcGY0XneqFjEFsb/J+bLGPlFHaFcksxNtQxkISZ5TVnCaHdFntBQQEkjAsk/Ss0
         8GEYUp3NODJSaVD8yYru71QvXjhCGdSeQlhyJrePYouZ2JFAAtXcFHHeu4/0SNv57iml
         AMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772231296; x=1772836096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BU5BHpRLVtirnnsOgnXnkqYMBnqqkNZ87HIXt3g68oc=;
        b=OTeuWHURsdy1FcONd1U639ICoT51giJDeh5bZGGvwYaS7xIxazbB3vAJ19KhFbyeam
         zl0ayQSLob0d12yZnIqvfK5zAHIi3BgYbH3vJ+W3jEfmvTWSGuGJniKX21pebr9zF/8E
         W1b7+DiutAv0hnp8re5Q8hS36z5wZhuyOR54HORBg7EGwBzqnQkwHy1HXdH/LOPQrHoj
         Fnu05PTbdE1TcwLit3WubTQ1Wk8BJTcJv23lz0U9I1Ic1a7HPYDxq/Fo43TGP3oT3Wn7
         ZTA48t3vwfsHiOfG8k5EiG/Pp59O3nfLabVAjsv1wARV3yO7bKLS4ap9SvtE6snPupL4
         +kpQ==
X-Forwarded-Encrypted: i=1; AJvYcCURUNxGuxsqZ7KKI5Dkwu4XnKFkP8w6ZQM0w/memQ6ZlUof0+FEuRUxgt/ucbBnmQ9HP23rQn6EUH/RqpL/5WrapWY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqx6iIMVEKQW65cGeZl+lyJFsehMcO4pRDBcbJvWbny5hudZUZ
	j4znqR+KX05ZVeqwqj22lF+Uluf43zqA+87cF65/mSBrhiH3ljlpUhk/pV4LpzhqHUy4aiHOWyg
	e5kFQ97YuHndO5xJocG44RC4A4N0beC1BilXDIQAt9wJwRUX1NjmWqjzAFWzVcVqsnarg6ZuYdG
	uYTib81+ahuKrzxPaWMTSgomisAuoc7h7o6OC7dg/vdKkZsnHzjr8GgoEYrzL/O/g=
X-Gm-Gg: ATEYQzy+6TmBqEjcHUwfQUtXnTW14I5e/kEWV5mejcKSEJNCtRQTB3/++NxXzbSUmKe
	b6YlywxnequuU8GnvrYFmd/8bSPVmvsEEzYHpFs/mdDBSItE9bvfltON6dj3zK/7OeX/DstwW17
	O5A0x0ropBn0Oa3CbJfpU1MRCmVGTNRox2EKeA6zzwx0Y+OmQ1h9gQn8z+f8EvfUketu4TuBnmm
	74p
X-Received: by 2002:a05:690e:5:b0:644:4b86:e7d1 with SMTP id 956f58d0204a3-64cc202cd9bmr2889246d50.10.1772231296602;
        Fri, 27 Feb 2026 14:28:16 -0800 (PST)
X-Received: by 2002:a05:690e:5:b0:644:4b86:e7d1 with SMTP id
 956f58d0204a3-64cc202cd9bmr2889235d50.10.1772231296100; Fri, 27 Feb 2026
 14:28:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227204052.725813-2-andrey.grodzovsky@crowdstrike.com> <2d0e9de12b7bf49a0b5117da6d305b0e918785818b63798dfd85de1635b68e8b@mail.kernel.org>
In-Reply-To: <2d0e9de12b7bf49a0b5117da6d305b0e918785818b63798dfd85de1635b68e8b@mail.kernel.org>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Fri, 27 Feb 2026 17:28:05 -0500
X-Gm-Features: AaiRm50ZrstSXF_bNnA7UbOOTkJ2XmjQIkoaG7OYxmYN5Xhi0tg3Y1H31Kr_lXg
Message-ID: <CAOu3gNgRpMd9poZYibhGg+UfQXiHpB3ucnhvghoT0TF1rFfmPQ@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH bpf-next v3 1/3] libbpf: Optimize
 kprobe.session attachment for exact function names
To: bot+bpf-ci@kernel.org, yonghong.song@linux.dev
Cc: bpf@vger.kernel.org, linux-open-source@crowdstrike.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, jolsa@kernel.org,
        rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org,
        martin.lau@kernel.org, eddyz87@gmail.com, clm@meta.com,
        ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Disclaimer: USA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE5OSBTYWx0ZWRfXygcMrnv/b34L
 ofid3Hj5Vtkghq+YGEsMRN7fHxcGqA6wUiW/KWcz8aFWGY879pwCnKkObQXDr3HQGZ1p6rpgZ9C
 w3murKNGitqcGHqCMzD7vd/c9qg/rZPtJ2yCnI6vwc2xI+xDo8UVXeuxju3SLwFzeO+cxkpMuyv
 EFsZ5BD8f0/WP/pypSGHUzpKa0jD/aI8+jN0PvZL/wDV05C40U8XqsOJq3nV80DtXOr/PfQeL2x
 T9RuPXFNL38mJigg2ARoFt/ADLL1VVoVRfRlCdhXK4o7haUzM/kSKXIw+cgjNbcPELsEOVdhtLL
 1pEcM3cUfo9GiJEzup7KVeqD4oizk0uwxbQ7bYeMRPmA3l/W1bcWyPqvjrepyCGLyA26lux3Gk9
 5c7S8vp5DnHWR742cUc1GyDeHvVvk4uqI/cSQ1WMXv9omHaTDtJ6vKEloBZe/yAbRRhkmrREGqf
 OCpD9el4O3g4hWxiTYw==
X-Authority-Analysis: v=2.4 cv=dMerWeZb c=1 sm=1 tr=0 ts=69a21a82 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=KZhmPCYDdY0A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22 a=vDKVRhTs-M86Ea50iKLw:22
 a=VwQbUJbxAAAA:8 a=iFABrAoMAAAA:20 a=NEAV23lmAAAA:8 a=Pf4_4UIYwLVlXi1egjwA:9
 a=QEXdDO2ut3YA:10 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: cvdzj6gicQ9Z2iZfWQS-3F_Hp9rneCed
X-Proofpoint-GUID: cvdzj6gicQ9Z2iZfWQS-3F_Hp9rneCed
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11714
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270199

On Fri, Feb 27, 2026 at 4:18=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -12041,7 +12041,15 @@ struct kprobe_multi_resolve res =3D {
> >       if (addrs && syms)
> >               return libbpf_err_ptr(-EINVAL);
> >
> > -     if (pattern) {
> > +     /*
> > +      * Exact function name (no wildcards): bypass kallsyms parsing
> > +      * and pass the symbol directly to the kernel via syms[] array.
> > +      * The kernel's ftrace_lookup_symbols() resolves it efficiently.
> > +      */
> > +     if (pattern && !strpbrk(pattern, "*?")) {
> > +             syms =3D &pattern;
> > +             cnt =3D 1;
> > +     } else if (pattern) {
>
> When the fast path is taken here, unique_match is never checked.
> The unique_match validation is inside the "else if (pattern)"
> branch:
>
>     if (unique_match && res.cnt !=3D 1) {
>         pr_warn("prog '%s': failed to find a unique match ...");
>         err =3D -EINVAL;
>         goto error;
>     }
>
> Before this change, a caller passing an exact function name with
> unique_match =3D true would go through kallsyms parsing, which could
> find multiple addresses for same-named static functions across
> different translation units, and the unique_match check would
> correctly return an error.
>
> With the fast path, the name goes directly to the kernel's
> ftrace_lookup_symbols(), which resolves only the first match via
> kallsyms_callback() skipping duplicates:
>
>     if (args->addrs[idx])
>         return 0;
>
> Should the fast path condition also check unique_match, for
> example:
>
>     if (pattern && !strpbrk(pattern, "*?") && !unique_match) {
>
> This would preserve the optimization for the common case while
> falling back to the slow path when unique_match is explicitly
> requested.
>

I am not sure this makes sense, according to the original patchset [1]
this flag was specifically tailored for patterns with wildcards where
this indeed
makes sense. in our case, cnt =3D=3D 1 from the get go since no wildcards s=
o this
check can't ever fail.

Andrii, Yonghong - any suggestions ?

[1] - https://lore.kernel.org/bpf/20241218225246.3170300-1-yonghong.song@li=
nux.dev/

Andrey


> > [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://urldefense.com/v3/__https://github.com/kernel-patches/vmtest=
/blob/master/ci/claude/README.md__;!!BmdzS3_lV9HdKG8!z-aIXCz8YRZcraMmGI2bmb=
4YrDgW0brRTcX_BaJCWYwj7xfmkZL6qka6aqqIwzDPUjR1TxUU-Mc50s9AAYQf-vQMuPuGlVKW$
>
> CI run summary: https://urldefense.com/v3/__https://github.com/kernel-pat=
ches/bpf/actions/runs/22503275616__;!!BmdzS3_lV9HdKG8!z-aIXCz8YRZcraMmGI2bm=
b4YrDgW0brRTcX_BaJCWYwj7xfmkZL6qka6aqqIwzDPUjR1TxUU-Mc50s9AAYQf-vQMuGeekJPd=
$
>
> AI-authorship-score: medium
> AI-authorship-explanation: Comments are unusually verbose for a simple op=
timization, and the commit message is well-structured with distinct section=
s, but the iterative v1-v3 refinement following reviewer feedback is typica=
l of human development.
> issues-found: 1
> issue-severity-score: low
> issue-severity-explanation: The fast path bypasses the unique_match check=
, which could silently attach to the wrong function among same-named static=
s, but requires the uncommon combination of unique_match=3Dtrue with an exa=
ct name matching multiple kernel functions.
