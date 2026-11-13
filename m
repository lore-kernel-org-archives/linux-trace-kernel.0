Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794559758;
	b=nh61534v0J8W0pRAVMVKrhIPfe/raf+tMMknp8zHM0Ut2tdua8ageUm1m/F6DzurykHD
	 ewGZO017U4zaxHvBs5a/blLv3cvDmdj2V4uRHVUmFR6I2rVcnL83+2UE10oNFWnqNiux6
	 dXzCTx1gEq59R4z+poXXhJ7QHKBHEgxBgZYnfxpw539cqHnyj9sQ2iOjdK/sJ7DED4+rF
	 Mw3wfAGaT5QNquUa4JXavD9mQNZmCUBrzHXcl15afST3PxRKRXjUnsX8brkKMW0xQ7H0i
	 ByTV+lT3qEx5azKYx1YVGRfq6w7Zvq6zeIM2f3+78Itp+QNUDBBJlGGQ14DgEIW6aKA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559758;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+m7C9jEiQGREhPmCD5/tizzUJjWSPHO/ikKHrKex/Q0=;
	b=zNUjmB0E6C/ntQwCfOUL2k/U77+KHcakQmIgzym5HEIGGdKJIY6NRIjtNmd3VX9DSxjT
	 t5NxKGLLDz8mMif8S03itZvuEuCnpsmkcCsaFo7Y+umRyUm+ha/UrpyiSiIACm1At62VZ
	 lzkoEMxyoBAZTqeGW9WnCICcDTscgG84609fNgLwQ52RTuhmskHVShki6EJArS79mGE1f
	 7BH+FZbMS6zs8bM49nEdNK3BEUKhvL+CPJ/X4Myf6kqGy27MplVDRI2MpyqVBEtOvxMmm
	 x8pVZqs7+oi2Ay9XDatCppopPdFO/L2NdutJIa746VUt1nq1PMJRbhHx8kV2XSBv8Ig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GC7L9fWg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.176
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00107606B37F
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 08:49:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00107606B37F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GC7L9fWg
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5ee029fd76aso1141825e0c.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 00:49:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794559757; cv=none;
        d=google.com; s=arc-20260327;
        b=VekCa6DsUIqBEafqfcnfscE/jXLZj0S6e4/MO36EBPShi1eTwzMlPxb8d9lXP2VvR3
         ZfdcjQ8FisUkbaJ2Htphi0HWqhHtHB9heRBcc3GnIANxig03Vfdnh9tr4UFQMurrPm9l
         FvLmU/oW48f+jeoZIRLRWnW15iEfnSVE91KPkR66G/ZaTGrlxk9Jqt/PIITBWtWOzLOM
         IQDa9kO4McB18R3GFghHxp8X1K9ITw6SF68bzzcEEHYROoGbIJ5neHeZCnNhPWQLgN4s
         w0p2OHxuEM7ubRtBPtdGm7dRCKz6pY6F4ipIXGyAgUzUaw//OCvQbRsmvNt7qQVw/r37
         B+WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+m7C9jEiQGREhPmCD5/tizzUJjWSPHO/ikKHrKex/Q0=;
        fh=/R4RLmbulYMTjO5oGvjmEcUS6nlYF+yUU+0JBhgn8Go=;
        b=E1cBRJOpZfAZ7lTuMhlsRw4mhKJ5JqkSigCFJp6PmapclEMBmx8OQNNTHsM5w9Jlgw
         BT//HrqaYScWeahoXEH5LIjc9+O2UHlFYzaG36Uc0MUIHorlkhILOHp0p/qcr4Q8B2J7
         2THyEZuZSv7aruMbDjSzclC88vitC3HcP5ZtUiSRoxd9aQk2Z7cSGtCar/YKfmkMg8aV
         KLOBemde22ZsaRbA++MzcFeLheCC0auoY+Ev1dEepx/fl6ZsYO3/OQl/Qsqy1gH0Nwd2
         i9URQ/MPvy+b+WkpwD5PF/rCuDNoBtMsZN7IHVBo/JZPpe1PyfC0PG6CzkkuP96zQAX7
         tXfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794559757; x=1795164557; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+m7C9jEiQGREhPmCD5/tizzUJjWSPHO/ikKHrKex/Q0=;
        b=GC7L9fWgX+sUkx69xdxKW9ujedjOcpBclpIKhg3eMM/AOUR5kOaOs4fpxevHGhvocy
         MD3IT0lvR9dCP531LBR5tnsX6G0dnDjnkCcGSGcmbCb1oY823FnAqMJxSfsDEsqe5LWn
         QsG73qHyL2qsnwMf5KFxX1pPbGw+yuO9kK96TDan6zYB2MNdkmbWucE7lQW9punRe14X
         baKcIq+oRTMyUqXU9k8fxcqWXk65wM9CVLexhPUOPKFTh2lWrfQeZ7cF8I2R+8gjUrLa
         t1XCLn/+kUXJGTYpSEIIdaghyk4dqv43uCUf9jZw0wybERtIna7rovy7ulZ0lMCYVgyv
         DAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794559757; x=1795164557;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+m7C9jEiQGREhPmCD5/tizzUJjWSPHO/ikKHrKex/Q0=;
        b=YBWKXCRWnowfIqDwIe2bYZvQ3X6OgI1Q7U9SkUjCmJfuJIhLqTxl3ME2hrOaU1AF8k
         JbNBhNuX70EBfep9T/MXirHoWsLwBkS+OFFdG2CBiO6Pqhra19d8EnBzCRnvl42z1rjg
         X4AmNicS7vnKr0YmmPBTb4qmzor0sS1/MN4kFw3hClOGrh7GPTgnWZr1XPrkrLW9pGl9
         e5CTV5DeuqxrkG71tRpzUqUlcNVSwiuOu3F3fSqdL4wEdErTYNIfKktehxmvp+beGJPE
         VejEAKfkuaXpv7fOy7oNsv2Te29OfprY/Iv3yRQSSYBGk19f+scq6Wrv5PVIPaeneJpe
         b3FQ==
X-Forwarded-Encrypted: i=1; AL+hErF6NICVyTHvIgQmHpSm/wXZBmZ5SBmztwl4J4ihx1AFKYx5IpyNjea+LOkXWkK30asOFjOuY3F0IACQVyLBVsGfnek=@vger.kernel.org
X-Gm-Message-State: APuU4Z8LgIiQjpjxdp/zFm8nS95TQ3ybMopvSSHfp8h2iOC/oDIazylf
	wdreLGpWR1f3ae+YrSxsDRLP2VIz02NJlkL1HJm5jtiE3M+2DpxtOMkn0huacuBLLHbJaurXOUj
	+zUGZDHlcmB03hnKjgtom2BrRu1j691Y=
X-Gm-Gg: AYBFou2FvPK4ivHS+DPdDMQbjL174Vg8F024DausPVd+pYKmIFAZMVYgKi4xTVCz1jz
	YTll6+hw0sdKWGThao53UdPyJ0rj8sriaeoFnu2Y5eajEf6NNvQq+PSoNxEaa3LdjnILGR8MPsw
	qWBWoHRJLU2/yBXk0tSJ+8zUsjMcJ0gg3Wf/k010PtYSLM6uhZgrU4HLbum+Fyz0r7oBZOQr9AW
	IErIvGc8qCPQU9Ega/ZRg/UuEYGlpf9TMtMAsOBQIy2WAb4QAyl39NOAKqW5iiDBYzNM6fZkiIM
	5mL8aUbZ12w5N4NVSPlpTe+tIHJuAvrPH/GkXrxI0fI+9FY1ckQJiOZWYLlMGDg4pylj3fE1ag7
	mBSpnTRIn2vyTSwtbbjyKoX6hF5XDl/NSARrfl95UUZjZ/3sZRGpTehC5yJnACDSmlZ5Uyod3fd
	iTqqkoS86/2JUZuGIl4M6+ZKCKru1yGThxaCfE3j0bpxUJh3fiEAjZ6K7J9/t77A3iUP4jaVAtv
	YCfYW5ZalBzogzyciycmTpEancntBxq4Cf1+tb5SSSEmkQuHehjran6x8vi8F5GT+tGQxBU
X-Received: by 2002:a05:6122:e246:b0:5c9:a60b:e5a6 with SMTP id
 71dfb90a1353d-5ee34a9e41dmr605344e0c.17.1794559757009; Fri, 13 Nov 2026
 00:49:17 -0800 (PST)
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
 <6ad67e4cda05238cd173c99e820a85de2c13f5fc.1794337724.git.edumucelli@gmail.com>
 <undine-1794538694073445946-7fde07ae541bfa5c@undined.local>
In-Reply-To: <undine-1794538694073445946-7fde07ae541bfa5c@undined.local>
From: Eduardo Mucelli <edumucelli@gmail.com>
Date: Fri, 13 Nov 2026 09:48:40 +0100
X-Gm-Features: AclHuK-vmNLEJaOSJsF5pZDaIAWiwZXOMTmkhYq1hDvBdCnM7IM3TDGCOE3tIH0
Message-ID: <CAK0NWSOBvfF1KA_BjwDpnj=TVYtWwifu=2qBwjPnmoxusXowbQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] tools/bootconfig: Close only opened braces in
 compact output
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: akpm@linux-foundation.org, rostedt@goodmis.org, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Masami,

Thanks for the review.

Using the existing helper as you pointed out it is indeed better.
Given you have already picked it up. Would you prefer a small follow-up cle=
anup?

Thanks,

On Fri, Nov 13, 2026 at 3:58=E2=80=AFAM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> On Tue, 10 Nov 2026 20:08:45 +0100, Eduardo Mucelli Rezende Oliveira <edu=
mucelli@gmail.com> wrote:
> > [...]
> > Extend the mixed-value/subkey sample to cover the lost sibling.
> >
> > Fixes: e5efaeb8a8f5 ("bootconfig: Support mixing a value and subkeys un=
der a key")
> > Signed-off-by: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
>
> This basically looks good to me.
>
> Just have a comment below.
>
> > ---
> > Changes in v2:
> > - Determine whether braces were opened from the key children instead of
> > [...]
>
> > diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
> > --- a/tools/bootconfig/main.c
> > +++ b/tools/bootconfig/main.c
> > @@ -68,6 +68,23 @@ static int xbc_show_value(struct xbc_node *node, boo=
l semicolon)
> > +/* Match the conditions under which the compact formatter opens braces=
. */
> > +static bool xbc_node_needs_braces(struct xbc_node *node)
> > +{
> > +     struct xbc_node *child =3D xbc_node_get_child(node);
>
> Nit: You can use `xbc_node_get_subkey(node)` here instead of manually
> fetching the first child and skipping the value node:
>
> ```
>         struct xbc_node *child =3D xbc_node_get_subkey(node);
> ```
>
> Thanks,
>
> > +
> > +     if (child && xbc_node_is_value(child))
> > +             child =3D xbc_node_get_next(child);
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>



--=20
Eduardo Mucelli R. Oliveira -- http://eduar.do
