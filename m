Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793362473;
	b=HSEjCQtlIC8KDWBTOfRhEdQtnLKucKSWn71rY/1qDsNsfrsfLQT0PMTZFlERnseDB8g8
	 uJeQnX1x3lsBhA2drU8lIw8gjgt0CdzRiFggLohsF8I14tSnLtRb7MfG+9Q1jMckqeSTU
	 lF67Fw/BDt/jIRsjvuFbV03p5evxQdKQ+FFytfWR08UMetlR49OF5/QQ9p2iNitZHouXi
	 Qp5vlJetGylwkDj5E2KksATg3T1iaW1py9bax7Y9q31cKAEiKVPH9yLdY4k1H/7LblA6v
	 B1ipY1f2tnviDEt9Em4nUXo3KGpakkxarB7CcMjWjED/S6EExpA50JZrqHSLfqQ8cAQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793362473;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=w4dT7+zzouIRSasfVh4mCzZhhWACxjzEVFuCstv7SCs=;
	b=xMS/7c69ric78+eyf4N+4B1s4EeMlcjWSObU7ANJ9CzQfuqioIw2nyUAGVcxl2GZ70Ur
	 +6VLLfCNrJFu6ThXIEMPjpDwOLVa5X4hOkjXQK2bxYQzDew5EJ7YDNK02UP2gG4jvsVX2
	 fIzh/YI0Ro28CJDJR6XY2lUPWxb6Q1M49e99quZS621n4a8idiaLaQXbWn5S9y8JLOMR/
	 GORn+Dv/nV7Gzns2yjwZn+0AqkHpZ/iihOWILo+NsZ2fBrWC3RjOrsQj3fes1b5OZGFC8
	 Y4+JrDpEkX1ikY1vg1gxXrRru5hNKnTetNbP80zE4wglxbid21nltwa0kK5NhthLDWw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O0ll2lyF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.46
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B15606A31A
	for <linux-trace-kernel@vger.kernel.org>; Fri, 30 Oct 2026 12:14:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76B15606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O0ll2lyF
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-7c3b6e8225dso430234137.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 30 Oct 2026 05:14:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793362472; cv=none;
        d=google.com; s=arc-20260327;
        b=ewKzICUVrTN4ZBR0Mbw40MX3yV+A+r0XEtL6hYP37f0O0MuK9ypGB5OUcGYbWvy6lU
         GT/NDlV1iQs+ixAjrUZPlw2wVLMyKqnjDuvDMZtJKZSBieSPH8wYFMEj8dtJQkJwUY/J
         xVeqB3TEknmraTFoUnRKUL0cMUxHq7GAXC+x5Ur5PqBtQFs6OLSxqllyrmVWMS8SZTQH
         98d8v23D1+Ng8sCddHz7xlzfyMhRVeVlbXWoCVh8VP9CuO9W06l495mlSMA8sPCUGRkL
         x8iNXAgpR98sAo0XX9DsHii4IdhrB2l9ercswQuAIa/9eLeaWDPnCtbMIxZkEne4BwZj
         q+Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w4dT7+zzouIRSasfVh4mCzZhhWACxjzEVFuCstv7SCs=;
        fh=gvZC0r2zMXAYrJXupDmjdn+qW6oV8jeY/xhOCOqDS5Q=;
        b=nO8RSg+9XYEpqLqCJKlUB8cOtY/4fyKDCPK9FJlMAQXiONQay3EMYdhSXB/UdpLtZE
         vBTRIHWDUZtsD2M2Y4DXzoYb/tg3gElqiFYwP/12ctoOGDErZBBDPyijnneQTZsPZMGs
         aVrFA8A7/jdfSYyLHc4iTPsDftlcMH8mOBcRrwK3I+H/SGz+KRUDkQmrf4a1nOcV/sow
         xRAKwSDn5vQKrsAmtXt+v7LQtVp5gm1BgThy5VkLErlRAvmWzgJrdvEnJ2DCvCv6BiS8
         DMGLfJQKbEWR/NDofXuzvI9YOih0wfEIAE7oqKgLGTjuqnNl8CS2V7xygfEq6NcMGHVr
         IYig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793362472; x=1793967272; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w4dT7+zzouIRSasfVh4mCzZhhWACxjzEVFuCstv7SCs=;
        b=O0ll2lyFg8yedCrW4diHl812+qZaA/T6lvBbBSloOtP+mbxSvKtL7ptL1s04aIaVXy
         M+EO38xWsDb8S1TxUVk/I46L+j3VSEMj47O+VP5xEbRPUL1E/L/EsX+fCNpvFnfHB2ek
         svhbUYeVGb0V84eWe4lGBLudh4HsiR/BoNmt1lUANvFCqc7QOgmRGEmV7LDqlIXEgmQ3
         mA07X9fB0z6JYbD0GbkJpZUnc7sKOZ+N3kidh+Q9s+abYgbBBn9pVgPkpF5DO6PmrMyR
         DQbLPirtNV2aK7prE3I1ssISnf1geVQK+5Fe+NKCdOI3owHOvYuJMMvBI8baMQj7B7MF
         EJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793362472; x=1793967272;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w4dT7+zzouIRSasfVh4mCzZhhWACxjzEVFuCstv7SCs=;
        b=AvvnVwgtBbcCQa1VZ6eMiXTKF585QumkfOSKmcpRdWx9uXlPjN15mmdEVMT5N/JX1H
         3zx1dWIcTdf/FKw627MopUQm+2PaVoHQjQtXQGSGIbRlwvIX6b6yAv3DY6XvyfRZjfBS
         y0nASdMYyPW8A/cWaKQChrIKYFJ8teWf5xyEiUygRiozL+lWvwK6MfW2Ij7G4LJiZpfD
         xvU4TXQQoI0VicfJKoD8OWf2l8Uf+4P7Q6dT7BXn3FKpVdjYN9WfeIh/EakMF7D7k8ev
         zECLcrXEn/isKPNXEAmaIvWxT4SXDR/DCtqklEsLM1pbgfojSGABiV9xMm/wCeUdmqJc
         PL6g==
X-Forwarded-Encrypted: i=1; AKwUvBx9BvzuINkq5nhwumIA036HxL1iAzpVBxW22JoQdXQfilThpUHC0xUVBh/LGpNMjOMFDAw2qnpsMEkBDa033MuJxmA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKnlwSXojWKgblA+68u1LWud+Y6Xe22UKfzR1ccwpQQM5pjbpaX
	Oenu0M+A4JswTTEjuBvTw9L+dt2PGEcSF2d+oZSi5hqBgJ7jVc0dqeSdREhIUwi96t/hISsFWpB
	OvJ+xgycT5FHWUZ2k6wwQE1UHjwBKLwYyBncO0sccjA==
X-Gm-Gg: AYBFou0rLR6jp65F/reIx8XorxrP62wv9ULgplFObSxup1FbzcVeUyKZFgSoRWBqYsc
	hfKC0eU/0Aik/HpN+QxzJgupi0WboGH9D/Z8y/ZR3ykT+6CtJtzdp92K8bV28GvLpbM4C0GGX+W
	87uJctzpwiV0M+pee8pkczhKp4rbXigq7wk2uvuYi0tsBsWLeXXICEO6Pj+AYKiMF5bzJceTTHs
	A523T+RgCtd4+uGSgh4mBKKl+5qf4kGSCa9+QvoCLa9V4FUOZL+CxY3oh7EamnVTiy7fR7mibur
	Flts3uQ7AfKdDpFjPhxc6qZ2qr2Yq4jxRu5IZwPYo3X0jwBywtjeIQQrIHiC/bviOPmvPP1/+7r
	u7K/SUBnmju3yEyZ2AckK2RoHqs55Kj6YeNh0+PxON175Z+CXyr1lILUW/WrBBO0S/rbT+68+XN
	JTMI0JLxy6ODeSogIxammpCSRvcGYNjqw69D1qCef4R39J3aWOL/1yrumqbanU0fO9miB0B0nW5
	4n+/83m751MNJFHdhnKHq0y1FqNJgJfmvmd1FVQ
X-Received: by 2002:a05:6102:1481:b0:7cc:33c9:b3cb with SMTP id
 ada2fe7eead31-7d072731e9amr1107407137.29.1793362472486; Fri, 30 Oct 2026
 05:14:32 -0700 (PDT)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <undine-1792936915899334889-d965251e73c20670@undined.local>
 <cover.1792949723.git.edumucelli@gmail.com> <undine-1793319942513765724-cc2757c235ae029a@undined.local>
In-Reply-To: <undine-1793319942513765724-cc2757c235ae029a@undined.local>
From: Eduardo Mucelli <edumucelli@gmail.com>
Date: Fri, 30 Oct 2026 13:13:55 +0100
X-Gm-Features: AclHuK8g4qDo8Jre1l7QNAtNn_dnIUq8Ecn97-_j2MMIyL44eN0BKMtSNrY1Tr8
Message-ID: <CAK0NWSNp75-8m7+nxO0ot4yPSFRTM2+eOKZUwGm-JLmRMEL7-A@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] tools/bootconfig: Fix histogram filters and
 variable names
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Masami!

On Fri, Oct 30, 2026 at 1:25=E2=80=AFAM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> On Sun, 25 Oct 2026 18:35:22 +0100, Eduardo Mucelli Rezende Oliveira <edu=
mucelli@gmail.com> wrote:
> > Hi Masami,
> >
> > Thanks for the review. I've combined the two fixes into a series and
> > used the two sed expressions you suggested.
> >
> > The first patch keeps filters when exporting event triggers. The second
> > handles underscores in histogram variable names, so the exporter keeps
> > histograms that depend on them.
> >
> > Changes in v2:
> > - Send the two previously separate patches as one series.
> > - Use separate sed -e expressions for [active] and [paused], avoiding
> >   GNU sed's alternation extension in patch 1.
> > - No code changes to patch 2.
> >
> > The original submissions are here:
> > https://lore.kernel.org/all/20261023084947.3264289-1-edumucelli@gmail.c=
om/
> > https://lore.kernel.org/all/20261024110837.696216-1-edumucelli@gmail.co=
m/
> >
> > Feedback is welcome.
>
> These looks good to me. Let me pick it.
>
> Thanks!
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>



--=20
Eduardo Mucelli R. Oliveira -- http://eduar.do
