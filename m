Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3B534CFCA
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Mar 2026 21:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774475363; cv=none; b=lojxYttRNCDLP0/i5aRyuzwGitvtfHxLhKH08o6Zat014kAbpeMRyDxqAm9dRJxPYF+nsdalupm16XtCOPM1eWE32JMTw/NQDHmtD/MmJhRjv0QrinO+mLr4ytvAAdlTyg4kou9NiGIl10zI6oqN1+KUCABZKoDoGs/NNaDbgv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774475363; c=relaxed/simple;
	bh=eteJZNJv0+GJkkbZzbMz5Pu35XKTbXLZuDbrYjHuTXo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqGqjQSogPAK3OdqyaGJVGMsd9B1DQ6hPO7rAuoQ74JF1EYxjCsMrJerknMq2AoQmfduv11pJTJpwOWps+bsnM02uGkc1sAfw4WwwQAHNbIzQL71BkgDzVkSSH3CjOGMB9nlLqxfl9mHeB9UojdTTKV1Rw959bpk+mfoi7ffzAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ssUcAqkb; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ssUcAqkb"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-486fc4725f0so2192875e9.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Mar 2026 14:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774475361; x=1775080161; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rqEmYTe1Fa2oQT5t+NcEaUAzVRoRsWKvubdY/vPfJbo=;
        b=ssUcAqkb/BnOw+UkZmORxcbo0RpaueHmzqpCrxWhAVZKzkcoWwqXJl3W5hubbjVDUy
         xYZxBqh5MHftV3deewkYy2ozdlT6DHhPX+dKTPj2dDUnY4iBP9aULdo2E7UUXgr8PGMt
         yZd1iBufmm2p5cbz8NbqQF9GgzKehh5yA0Tl8MbrFxE48i8Ov8lNZj3TJg0pakk58lmJ
         qe3hCF/iZh+MvITeVVzoJFYvmB05tamb+ifmU436MfCSex1JKU8i2yo/s/kIOqR+JlLK
         flRaJbm6f3vRVWSgYAQVBqQT/BbrqT95Y9GRN3s2y1ookCP8lAsiTsGtx+O7d/+VpWDZ
         TMnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774475361; x=1775080161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqEmYTe1Fa2oQT5t+NcEaUAzVRoRsWKvubdY/vPfJbo=;
        b=FECLZmvAhSZw2IWG4RSX6xbl2tWcPDiHsnWdt4s/qDsR9W1dP9sOfAdDERdcbeTFNm
         fXGxuzPgdWwrp2UahUXl5AlL0kmfaUaDPEclV8tI2kJppxUu7a1C+ySnF7qj1VP/lscL
         iTaHJYzTrABI+A4S2sUh+QBgqbYLyzvIULdqB6w87VH3jfl3pLYk7wJTgguIRwrarXqe
         Sznzzf2SyD99Y+7bt8+MUOCGS9QTyVCdMAdOdVieg8jjB2nh0kAfRBcv5tW+tx7QJvT9
         EtmLXj0L7hiTmj9ZD/UQTOcsi0kRcjomkagdQLA34HIWiJ0d4Zzp1KywWMmOzFqMP3Qg
         MCiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCjd5OvilxT9oDQqnnNsMNRmtwQT05LulMFAa3yu2v88D32tYauAz4nBPmLjEOgeeq2qBcVowTxpaeaYiWuBG+wxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDGgBzMJ4vvAyeNF/UgaJDecQ+nUxJXb7EesLpLlPftI5ruk/V
	4brQhDHnnlUS7MHvHpvdhobywmuNipKP66zUIVDhKug62sJaFTpw/Yqe
X-Gm-Gg: ATEYQzz6EcmNh6CkLqR5bHMZhgJpryd0RRUdu3w8dcojqLjsTLSnv6FDSGRsah7UOEF
	rsh05ZMDUOdtRfKfsKei4uKG72pvr4ENxBxP9fRN0+hciqI9OtIpNEWpd6EGetPAZHUwQNKoo2j
	Vp5LaiMNiIfLdZcGWtoh3eU1uq1YjGRExMsBXRwiVJkVEOLK/RPgNuW9KKhu1ddnFLJqfoHZu6Q
	Ik6+jSlLocbq+zjHRnY9O8VAMbHftG/zvqiH9vlQ+nmsyAgRuLv2yr2ax3avtR353NoTPr8QIf7
	OcHumRZ4Cd2GjPa5PxqSIVgYR2mmSF+Kql/jdzEHSKQrSx2LZjc11x2pZmc8sXZCyalPkGoGFTf
	H4En9ZYxgPiZHABzqR50E8HuNbP4dRlKBAVstdfFDmZ3o5AsfAMKAczJoPAhRJsAf8VNhHaphwx
	eU9aiMuu6pJAtDdPgxah+s5NgL/D8Sb2bLb4uxoea/jQ==
X-Received: by 2002:a05:600c:37c3:b0:485:3cef:d6ea with SMTP id 5b1f17b1804b1-4871608eb70mr73543525e9.13.1774475360383;
        Wed, 25 Mar 2026 14:49:20 -0700 (PDT)
Received: from krava (h082218179122.host.wavenet.at. [82.218.179.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48711764509sm160251685e9.13.2026.03.25.14.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 14:49:19 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 25 Mar 2026 22:49:17 +0100
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: Re: [PATCHv4 bpf-next 13/25] bpf: Add support for tracing_multi link
 fdinfo
Message-ID: <acRYXe4a_eHnougG@krava>
References: <20260324081846.2334094-1-jolsa@kernel.org>
 <20260324081846.2334094-14-jolsa@kernel.org>
 <03163163-fae9-4980-8526-a1353cdabcfc@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03163163-fae9-4980-8526-a1353cdabcfc@linux.dev>

On Wed, Mar 25, 2026 at 02:43:19PM +0800, Leon Hwang wrote:
> On 24/3/26 16:18, Jiri Olsa wrote:
> > Adding tracing_multi link fdinfo support with following output:
> > 
> > pos:    0
> > flags:  02000000
> > mnt_id: 19
> > ino:    3091
> > link_type:      tracing_multi
> > link_id:        382
> 
> Would better to add attach_type?
> 
> attach_type:	[fentry,fexit,fsession]_multi

that's seems ok, will add

thanks,
jirka
