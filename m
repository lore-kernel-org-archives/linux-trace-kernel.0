Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D8A2877DE
	for <linux-trace-kernel@vger.kernel.org>; Wed,  9 Sep 2026 01:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788917293; cv=pass; b=HSuch6tTSnlKYv7lwWHuIblKyVOE+LB9EEtSjGZWrMigWpTJeKKmr64d8Rb9kdArTJ50Kzj9Gq2T1r3orrnbwGwPUWNjZHpzRZeF/ZnSEuwt+7nC6KVKkU+Wf/JJSj5gMWfJAp47xJTHxGiwqBjrGasNd3EzY+R+Wg+sf0CnIeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788917293; c=relaxed/simple;
	bh=rg09NumjJVb6JGXaO1c3ZQFhkdw+QlXYZhVa8vQZJiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dR9qNMOXWWOM1ClZyS5f1CWjWuFuf2yIhrlBQpkLAlGFNTVAetVW1X0wVgXrvAf6cDZPAZnGNQ72PgocUh81Zk2MRvIzYehkqrV6e6q9qJPh4zAGO1LllEIQdS6PGa6dCM01lk0VPNC1shGziUZPWUEDiPGhdUDGlWiKJuHdjvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QvegMzZB; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvegMzZB"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-87ffa98d4a9so1523437b3.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 08 Sep 2026 18:28:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788917290; cv=none;
        d=google.com; s=arc-20260327;
        b=IPRB5CDgkbq65fEfTQxUaviiu1cvNL8orTbGeE9CAZotlhu9zblOZ0719mOodFkPlb
         oegjdKlyhDVuZVVMwzE8eTFzrzRT1iJ1fvMlu1gNpfUyI7mtT8yNDUwIntorg0FxXL1d
         GtxiNFSCrWuUcVjQiNgPfrkcTqabu3MC3kS41Kl9kakxaIiGpnOTUD58BA9gxRkv0ZOV
         PAYCpKLF2bud5nBVBBtGJ0hR9NyQrY1GxYHL10Aru2X//qQhxtTyMyLmZ2nbIH14Q7zK
         o1jhmbww6QfFZXtKKHmO9Rdij2xTJnKKk3Qjkm57U0m4zGvhc6treaIQN3KinUC3APU3
         cq6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0NgzDuMC6qQnqEWdLlOg5dxhc1fTYoeWB4Qtn/gBX70=;
        fh=geddXwn4DiuUlqLuHhaKm1K3LcsIE/gXvDUISAzQWb0=;
        b=HeIKZMa2yhRWLMRw0bN47YNnMzZK3cShj6/zSQBxHOJL5pN97LlMymLgb1VU+kzXB+
         Z6O72TUL2FtO571Si89AEfyqjfNlavWFBs4XEWGhzY+aVG4KYVmLoMjNoIN9sAsbT6CE
         Zh7pVZSmJVKwvgISKDaFG9bswmteqAN84/kzFSvmWw6LkdBMRD7OJ2gvFBZD65qg2K04
         rETUaGaIbcdgM7AaPffvLlOwoly8xFIpu5mPPGifAIaGkdcdccJ2vNHYHlUWk52ajelj
         I7ZQfq+G9Q7TCL2qEnuv3tsL8lTjswVOOe3yt3OYN04BiFhicGd+Y6aE7GbWPkClaohR
         5wnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788917290; x=1789522090; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0NgzDuMC6qQnqEWdLlOg5dxhc1fTYoeWB4Qtn/gBX70=;
        b=QvegMzZBT/Ms6Jjmz0HuDT5Rg/Wd6I/nJviU16lxnc3TUwsHBDsdCbiTnLjFeXhvKw
         7S+NkFa1A4ld/cMTOlQ29B5BAu2b9z5WPG02JADdec7ScN9ibg7Sv5GNnm74Mqv+SOr/
         b0SepHZWWZMHAaykg9bfySjL/5SwL42FqFhYrcHjrtTYjK4QaVDgJAELmeXrhpbSc81k
         ii2nFBc90/tZg/E3KVZlOO4pWWzYuC//k7Ts20222RBFS6P7qoCLMdWN970QBJvRDoSn
         y5K+DAf/Vl7HFS6o7uVKvO1HUhp8By7fDASD4XWljr31CmIIOfNZGufP0SHzpyPHMzbD
         UfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788917290; x=1789522090;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0NgzDuMC6qQnqEWdLlOg5dxhc1fTYoeWB4Qtn/gBX70=;
        b=nVMmk2lDXwyPQgXTqjwKZeuFjjpN7W8XQ6kViedSAvsBae0L3V9wh9XD7/s7ICC/gq
         F90c7/Q10qde7/Ukz4k1V8lE7cYyY+DFPtXlOsi/dNYIZHPmmvNtyieriUtMZ0B2H7hz
         4LPZpxF3ySm3N0zRf5VI6PNpoEhSHnchlZWTkwwyn9omNDz7zxtigQFVux+rFaYhb3kP
         zUi4re32YKBMZbVHQdkpYZtI+M8Kj+y7Dbd0gBV+MWEYa2snjgZGMxtVCSTUCCUFi2X1
         T9AC+njEUB/jigpU/Rc0U8ft9nMRLjpPiRvJyBD7Wy2vfmTtb4wFNPWmigX3gnelonR7
         nk/Q==
X-Forwarded-Encrypted: i=1; AKwUvBwaiWQ9fpdsCZocAH3XERhrXQ2D/ona1fmofKlJat43pJNCHoqnBjrNOLkZsipOXVAtAID+jHrBgH2uFEbU+io3b98=@vger.kernel.org
X-Gm-Message-State: AFuF++kdy2zP7PE2iLSyB2HR6kUrNi03VgACIeM9E7gujynR1qrVs7aH
	0gb+s1+eggfmaq9u8BQAGEyqtcRQRrBXDWM73wcLKIopn0CEegy2rVPZv8YbDo2IIobo8gJlKcv
	9mt3DuhKdlrEMlI1r5ZfmjrvPOXbWWijLaNGh81I=
X-Gm-Gg: AYBFou3bvzofig6nn1lbVMazq3c+WPgs66OJsdzVmq/PTXNcC2M1ktvbsOL+lbpBXgU
	mlmLEaAyy3p+okGoSZTJu5v5Bz1gMM5BMvaotElOqurXLOS4XWXx9yYA3lZD/Oa3gadb0P4ssBl
	A7odZWNZ8sIhKSuTplq5nsUhFWVEGZaCRe7YCxtd8wSubvxUSsaeRkN6o9K/D5kad4jVcNS1FLr
	kR6AvG+LAzqQhxG4TEQQMA9+EFOLT0FjCJy/Okuw7oklj0FgbpB0R0iBHUDjRixL/sL2/qujLZ0
	MMkPFBmf7Pr6tKnZqp5D0UO+5gt7pCIcCRcOWa5bcMwvCP0z+9DZ
X-Received: by 2002:a05:690e:4419:b0:66f:c1be:a64b with SMTP id
 956f58d0204a3-66fc1bef5acmr5609196d50.61.1788917290484; Tue, 08 Sep 2026
 18:28:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905141637.1547429-1-ekffu200098@gmail.com>
 <20260908104629.e7a85a90e376b843dbc51dc7@kernel.org> <CABFDxMEot48G141HrLT-4_H1xKez58UhK8yFMNkWpqT_MOXu7Q@mail.gmail.com>
 <20260909082459.77701fe379794a39242ebff4@kernel.org>
In-Reply-To: <20260909082459.77701fe379794a39242ebff4@kernel.org>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Wed, 9 Sep 2026 10:27:58 +0900
X-Gm-Features: AcwNN1WJNPYAYEo1b4MQYmQ4q0QD4KX_fon2xC_2quLuxHMjfNtwLt9MAQHa8nM
Message-ID: <CABFDxME2bpyDOHpoesSNZBd8QsrDfPb-knz0Mzq0AhnwSs-unw@mail.gmail.com>
Subject: Re: [PATCH] bootconfig: remove unreachable index checks in xbc_verify_tree()
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 8:25=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
>
> On Wed, 9 Sep 2026 00:34:35 +0900
> Sang-Heon Jeon <ekffu200098@gmail.com> wrote:
>
> > Hi,
> >
> > On Tue, Sep 8, 2026 at 10:46=E2=80=AFAM Masami Hiramatsu <mhiramat@kern=
el.org> wrote:
> > >
> > > On Sat,  5 Sep 2026 23:16:36 +0900
> > > Sang-Heon Jeon <ekffu200098@gmail.com> wrote:
> > >
> > > > xbc_verify_tree() checks that every node's next and child are below
> > > > xbc_node_num. Both fields store the index of an existing node, whic=
h
> > > > is below xbc_node_num.
> > >
> > > This is a kind of foolpoof/defensive checking. (so I call it verify.)
> > >
> > > >
> > > > So remove the checks.
> > > >
> > > > No functional change.
> > >
> > > Hmm, OK, I think we should decouple the logic/implementation
> > > verification from runtime verification (e.g. wrong format)
> > > and move the former to tools/bootconfig.
> > >
> > > Thank you,
> >
> > Thanks for the review, Masami.
> >
> > To make sure I understand, you mean moving the foolproof check after
> > xbc_init() in tools/bootconfig?
>
> Instead of just removing this, move this verification into tools/bootconf=
ig.
> (we still need verification of user given broken bootconfig.)
> Let me handle it.

Thank you for clarifying. I'm looking forward to it!

> Thank you,
>
> >
> > > >
> > > > Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> > > > ---
> > > >  lib/bootconfig.c | 13 +------------
> > > >  1 file changed, 1 insertion(+), 12 deletions(-)
> > > >
> > > > diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> > > > index 89c88e359179..d383430637ee 100644
> > > > --- a/lib/bootconfig.c
> > > > +++ b/lib/bootconfig.c
> > > > @@ -1005,7 +1005,7 @@ static int __init xbc_close_brace(char **k, c=
har *n)
> > > >
> > > >  static int __init xbc_verify_tree(void)
> > > >  {
> > > > -     int i, depth;
> > > > +     int depth;
> > > >       size_t len, wlen;
> > > >       struct xbc_node *n, *m;
> > > >
> > > > @@ -1022,17 +1022,6 @@ static int __init xbc_verify_tree(void)
> > > >               return -ENOENT;
> > > >       }
> > > >
> > > > -     for (i =3D 0; i < xbc_node_num; i++) {
> > > > -             if (xbc_nodes[i].next >=3D xbc_node_num) {
> > > > -                     return xbc_parse_error("No closing brace",
> > > > -                             xbc_node_get_data(xbc_nodes + i));
> > > > -             }
> > > > -             if (xbc_nodes[i].child >=3D xbc_node_num) {
> > > > -                     return xbc_parse_error("Broken child node",
> > > > -                             xbc_node_get_data(xbc_nodes + i));
> > > > -             }
> > > > -     }
> > > > -
> > > >       /* Key tree limitation check */
> > > >       n =3D &xbc_nodes[0];
> > > >       depth =3D 1;
> > > > --
> > > > 2.43.0
> > > >
> > >
> > >
> > > --
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >
> > Best regards,
> > Sang-Heon Jeon
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

Best regards,
Sang-Heon Jeon
