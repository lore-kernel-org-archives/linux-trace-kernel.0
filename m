Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B215D3E63AE
	for <linux-trace-kernel@vger.kernel.org>; Wed, 27 May 2026 09:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779875868; cv=none; b=Yn8ZkiO9W/cmUQ21zKK/nQbWnxHR+6XviaNnDJEhIsMa1BZzNOSDkmSoPC7jGZRmmUb48sY4LBfHkCeH564VpJd1lUd+6GZcm3iaxMyD62+2q9H0lJy2iiIL5jC00RQCREgTToNAI9kj1DbLAU31q0MrDEg1+m/Z9vg0TwrNaL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779875868; c=relaxed/simple;
	bh=rhr6p3Lg7XJ0vMqzbFcdeO2CJajTB0zXczci4HQ/HsE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ev92GbSpcqe1G5i75Q3aRBtiO5lbaexw9uN41dYNRqTrW5lC0SFEfpMRzIVpazpaZVceZjr6EnpOcC9wyFzvso3riwmGDYKPvWt/1w9VUHMA3ECxeE1djixZjbW6N2Eb73MvJADeq42Y6v753Y77WW2GSR+bD6m2S9/rgdJXujU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/L/Lf3u; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/L/Lf3u"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso50095835e9.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 27 May 2026 02:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779875865; x=1780480665; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HK5/dim6I8THjlnPnIlV2fUiqEghMFcOuVhn1AO2dDg=;
        b=k/L/Lf3u4zd84kdccNmUARhogwRWSOf+kCuW1jYcojLrYxH87hUxCm7ksOLJvxpZP9
         YMumFySwGUCIBEZbFwlfw6ZNZ1KDv8Stpo1f0DwfunoKKWO44EBKB8Qb6m9/yGxyPLl9
         bkkV1BW0pqyvc0fURAzDRkc+RKgN0sct/d4DqlQpsRruz2MRyMr/hA2ff4fMCG7ZvIYY
         N7CAlsvMHoES6kMpmf4uYfrpxLiqBgH6zqS4SjqN6l4mY4R3hgyLjC1Jra10HBf0MS1m
         dHdrnv/Z4Jew7wg1jUFWdF8FS047Y5DMWZ1AHIQsraBOqKjHsoNPPdLYW3jnGlRC8Rif
         oDkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779875865; x=1780480665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HK5/dim6I8THjlnPnIlV2fUiqEghMFcOuVhn1AO2dDg=;
        b=C5kcOBxRq9JRixFZgMvcoHRbernefEvtxgzxni59qRr/ZfUDg4PoWSOC/hw24uV9Ng
         zZcNnqValsFJkAfVgICYEpDb1tWsPA7v7HVhF981wLCTJoQlZ70bke0YuWmXb8kUdV5I
         Zc9ZwJK/fpxebvm5HIpf8aCm189KpvLvKZD5ekRjNDDkQHYxWJWSmC6Q+rpicnIqg3Fr
         7PGUBtvS/4++UHFzKebN9kQrRH5hgxenM6N4U5BT7lgX1nEmPGR8jTFIVFh0KfKk8ZKF
         MYBunJic90ZZrmc/8beXtkLax+wssssdfVcPFLw8DPMRDVdqxdNeNvzTi1yd5qztzU/Y
         zM4w==
X-Forwarded-Encrypted: i=1; AFNElJ/mMst6defFrnCJExDe1nGiBx3DqGuduVW6NaRsKGbuGPwUTFqxS0olnkJeKlSuM4uqnu+JsKrmWdlGDpjiyIpY17Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFd1pI5Vrm40seaqHmswsHcIamMofH+PVZo15rLqhNtF+nNflQ
	0Azp/OvfP4AGdVsT89Ah94hWUHzIQRUx3T0v6pTBTfN9Tir8/LzCGLoC
X-Gm-Gg: Acq92OG9mMXlt9fPLj7TOUnfXO2X51W/nNXV8310uvhC8DijPXkzhOOZG1Zi8192CCp
	p177bHeG/grJ8JAVWx7BimyDtE2COFEgwiWvwmGHvAMI6HPGryTo6/gQhtdr6QFfF9pWcVEd4D2
	a6mzl+lYV05OzZWMsqHhnooD1/Fk9ExpKosvnjowd2WvEPy/vsJF8Q4htZcHjgB/hSJGS9km5DR
	gcsfI5aw563HV2ZT/39FMN6q6w4OIHPKwIAMbcXbc9vaxnMylZpB/wMw5eSKSm650XNEtzFjqw6
	1JfkG5Zb2nX3KY0PfWZcWB2xbCDcbrl29I7K11IKkfVIzWFeodX7DpsEWmS/kbM1rUkQKTY52Lq
	vS0IBWlBpbC/AE3eql4lmaaItNdsUFedhCA7q9O7MRNCDCHTpzoWAY9XZmt8Gw2T+nIFFS8lhdE
	kO/HatM1DxvoITshYX84j8HOWs/A==
X-Received: by 2002:a05:600c:674a:b0:490:5057:f5f7 with SMTP id 5b1f17b1804b1-49050580a91mr306966745e9.11.1779875864661;
        Wed, 27 May 2026 02:57:44 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49045284855sm390114725e9.0.2026.05.27.02.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 02:57:44 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 27 May 2026 11:57:42 +0200
To: bot+bpf-ci@kernel.org
Cc: oleg@redhat.com, peterz@infradead.org, mingo@kernel.org,
	mhiramat@kernel.org, andrii@kernel.org, jakub@cloudflare.com,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
	eddyz87@gmail.com, yonghong.song@linux.dev, clm@meta.com,
	ihor.solodrai@linux.dev
Subject: Re: [PATCHv4 06/13] libbpf: Change has_nop_combo to work on top of
 nop10
Message-ID: <ahbAFrjEvM5m_3l1@krava>
References: <20260526205840.173790-7-jolsa@kernel.org>
 <4ea9f26531f9e53da6c8e5c8a638ef7aeaffd6b3fb6ed20e742069783e660e05@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ea9f26531f9e53da6c8e5c8a638ef7aeaffd6b3fb6ed20e742069783e660e05@mail.kernel.org>

On Tue, May 26, 2026 at 09:46:37PM +0000, bot+bpf-ci@kernel.org wrote:
> > commit 5ad96df841a0877eeca7d2cbe4b3f726b7fd0b72
> > Author: Jiri Olsa <jolsa@kernel.org>
> > Date:   Tue May 26 22:58:33 2026 +0200
> >
> >     libbpf: Change has_nop_combo to work on top of nop10
> >
> >     We now expect nop combo with 10 bytes nop instead of 5 bytes nop,
> >     fixing has_nop_combo to reflect that.
> >
> >     Fixes: 41a5c7df4466 ("libbpf: Add support to detect nop,nop5 instructions combo for usdt probe")
> >     Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
> >     Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >     Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> The Fixes: tag references commit 41a5c7df4466 which originally added
> has_nop_combo() with correct nop5 support. However, the actual bug was
> introduced by commit af734a7ddb4e which changed the kernel's uprobe
> implementation from nop5 to nop10. Should the tag be:
> 
>   Fixes: af734a7ddb4e ("uprobes/x86: Move optimized uprobe from nop5 to nop10")

af734a7ddb4e hash is not available, the patch:
  uprobes/x86: Move optimized uprobe from nop5 to nop10

is part of this patchset

> 
> > diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> > index e3710933fd52..484a4354e82b 100644
> > --- a/tools/lib/bpf/usdt.c
> > +++ b/tools/lib/bpf/usdt.c
> > @@ -305,7 +305,7 @@ struct usdt_manager *usdt_manager_new(struct bpf_object *obj)
> >
> >  	/*
> >  	 * Detect kernel support for uprobe() syscall, it's presence means we can
> > -	 * take advantage of faster nop5 uprobe handling.
> > +	 * take advantage of faster nop10 uprobe handling.
> >  	 * Added in: 56101b69c919 ("uprobes/x86: Add uprobe syscall to speed up uprobe")
> >  	 */
> 
> The comment at the end of this block references commit 56101b69c919 which
> added the uprobe syscall. Andrii Nakryiko noted in v3 review that it would
> be good to also reference the commit that switches nop5 to nop10, though he
> acknowledged the hash isn't stable until it lands. Now that af734a7ddb4e is
> available, could this be updated to reference both commits?

I proposed to change the comment after this gets merged

> 
> > @@ -596,14 +596,14 @@ static int parse_usdt_spec(struct usdt_spec *spec, const struct usdt_note *note,
> >  #if defined(__x86_64__)
> >  static bool has_nop_combo(int fd, long off)
> >  {
> > -	unsigned char nop_combo[6] = {
> > -		0x90, 0x0f, 0x1f, 0x44, 0x00, 0x00 /* nop,nop5 */
> > +	unsigned char nop_combo[11] = {
> > +		0x90, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00,
> >  	};
> > -	unsigned char buf[6];
> > +	unsigned char buf[11];
> >
> > -	if (pread(fd, buf, 6, off) != 6)
> > +	if (pread(fd, buf, 11, off) != 11)
> >  		return false;
> > -	return memcmp(buf, nop_combo, 6) == 0;
> > +	return memcmp(buf, nop_combo, 11) == 0;
> >  }
> 
> This isn't a bug, but Jakub Sitnicki suggested in v1 review using
> ARRAY_SIZE(buf) instead of repeating the scalar value 11. The author
> preferred keeping the literal number for simplicity, though the value
> now appears in 5 locations (array declarations, pread size, pread check,
> memcmp size).

and I replied to that then

jirka
