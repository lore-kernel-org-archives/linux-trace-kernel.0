Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794337739;
	b=0Q+m+cFtJRtDk7I4m4+KDcjgGAh6co6nyXK8JVaoxDadSVNQ5GXkph9Nt09VqLtNcNXg
	 AkHMUHHWbCiDmYDZyjm17N6B9tmYEr5++hHPncL3qZtRP8A+AMzSUIsKo7y+G7jzCSnkH
	 tzAzKoERmx0s7PFpKCs+cZDhOjBj4VNjuKCwESDMUTlAAznGarMrTlFtOC34mGlEy+uxG
	 dwUls8k+NLEFbh0k8dghKir/alw9Tdzj+S19v8vsCLKCIzCL/mzir1IfxM7B7D4JpVasd
	 vYy6hmsoTJsCiEYQB9tH398/OIg5sgH3nVxkGqR6hpBGgPqihKGLevNnBgzptTSQX7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337739;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Ckx+N4bSL1Sy4Kr4O5DY4ekZlwIQydqD+jQM72GHs9M=;
	b=jNYp9spUTsp347NOl+wqqZgBmrOrkNrgVtmDE3Bia8tEQb8CQFD6ZONR2d7YAzGz5LO+
	 7aR1GnY0lFjBarvuTnS9F+zCINfAYARTWlAXRhLRdyKyKpL0AYBB6m40F70KRZfFJtw5b
	 kU2sgGPewMTGM3MO0wppnOaFbTm54FjzPhs2pzJpjM9ApFpLt8fjsFPYnM5pRwQc2TKRB
	 +DMTT5L0Nhcqg9Oam4bU0nsRkDBBm2FU1OBOJMmN7W588RGUPdeD2QsHC3wqNxpbihOFo
	 IyzxsZYaXih0/7yyAdHOrW2TudiM/2eHzi/EMzW6IHL3c/ff58px9eKfYTj0Z59JYkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="u2pzc9j/";
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3119B606A320
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Nov 2026 19:08:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3119B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u2pzc9j/
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a215e64962so27735525e9.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Nov 2026 11:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794337737; x=1794942537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ckx+N4bSL1Sy4Kr4O5DY4ekZlwIQydqD+jQM72GHs9M=;
        b=u2pzc9j/rBBTAtJ8ZYrNlirFENZmp4mnp9FL19qUnrJAjT7JsmPchU5zOoOWPvPofG
         zkVPS4pGj6vqoCcEpcnFkb69tmgAK0OwwzS8mg9jrKRGPlnK8h4sCh62lIDp0S3vSVVa
         itAYwqoFb77LK1RtrCuFk/wxiBhpaQYKjz4/3aEZXQ2+mKl4QlsdwbPXDR/KWQttayRO
         X1+CAos7N9j7JuFSPf2F25kwcAfJTq58BMJuAO8WmM+vdBzp1RF56Sk9TBtwD5zMOz4F
         6pHS29fh2wbCINYFCej7ID52itYwIpYjdpR7DNTswVyITtm4eke8A5UvuO5M/mlr6aW6
         wIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794337737; x=1794942537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ckx+N4bSL1Sy4Kr4O5DY4ekZlwIQydqD+jQM72GHs9M=;
        b=PmJJPjRTAEIDNv4r0HejW3iZhvGxYpl3y52w2lYZ0iH1b6nc7O++/dEZoU1i1eKPsS
         uTvasn1G9U7ISZikmJq4xqqSiyd5j0D8TMyfP8NHSME8xwrC6E4Msgmod9dbfaIxpM9U
         JpPkdFQJd3Ew1+DA8LrZNi6YVRWu8MWi6QZg/XOPdq5eo4kW3fWmXFFhC7tMC1GR7iwu
         WvqY6CiljhEiwxYBcX93On1LPWsVOe7caP4YDRoso87yF6x2JOlhH/VTBM7QTKHAEiGk
         C15NQpek3XW10rhVlYmmRxsItuXEwX0RshFld3/fjIH11VypAyUVJRo9M1Fu923ADtTg
         Z3Tg==
X-Forwarded-Encrypted: i=1; AL+hErEzuqcVymO+taOW+u98/1J8RvQGu3Ae9HTDWapkis6EBljKUDFXeh1D2bxm5BwaRBWA+mSRZgBghTe0wGR1QyqkYpk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/RFzM5EhLmZGF/foCcbKsmy/WBp0xQ+0A92w2MUU5iqk5YgCeQ
	iqFnE5jonqP9Gtsw+nM0LWxDTFPslYRn6P374kDhRqb11KDX72jTrc5hekQlALZjCgNOKg==
X-Gm-Gg: AYBFou08eCVzNR1p2j3hHe/W2rFwd42Z0zLIXVQz4W7CPpv1fjvqrSOj3CjWdPr5ryn
	+ISx0ej47ldDE2TbO4oCXmSUAlHH2jjzkfYJXdSfdfly8U7Z03ntjL6faRX3Jgyyn6Wsf7AFFoh
	CKyLN17UZiFHLPLrVo6qiW07zbqMlk0Wmy+Y1HE9wtSpsizpg8helqnu18dm3HYOhY8c+wFD7XA
	f0mcnOZ56LvOwfF16HPVAaA0I9uI9sKi7HILGG3jSn5J4Z3BeAiH4u6xb34jsRjFGQ4l0uGfD1R
	4ZNkg2UrM8QI0nD3aVTkQqQSzQo+W/ILpwTH/Sm9ygD6FOHh08+kzO9RZwmFsnr7KZEeKpd5A7Q
	CmayqsVFIy2YVXErGi9ORoYma+WmPSBS/fEbjzc1zpeB2ulUubH3rEF+3h+MHBMw/dBOWtJx67B
	IrbYWxPOEXm8dvH2+fdaZlx/q5KTmXdHsBr92/aFiP8tJ19Ch1BC7gpaR0O8NQHS+0UVJ0gD/gf
	8+bIPHHXCCv67XgA50N3uHaNqty38dHMk4SV6xzmZjOS/XrPasdQm6RlxXq58+GM+IXQtImazUY
	3JMrla5bVSgJTnbnahSdGg56uuTBk+wTt/lgbzqlfKf2BO3MZtGiBWOrUp86y5J4fVjGWWVvhfi
	7Vdfntl1IB+TL2/NkcIIOpusEFIcyEV0HDYAD4Uyz+M4+1x7IA0SRAmli7OWmfmABiMI4p32zQR
	U6xDQdZWVgjgugskPeoEP7yCEALdj3G/cwHElcVZ9Iy7cWOuXZDh+X3N8Pn3nWMcx/pEAHsrexy
	s/UrTJyFkXaJsu6lw==
X-Received: by 2002:a05:600c:34d5:b0:4a1:e672:5721 with SMTP id 5b1f17b1804b1-4ba0936ee3bmr1168935e9.13.1794337737420;
        Tue, 10 Nov 2026 11:08:57 -0800 (PST)
Received: from longitude (2a02-8434-fda5-4201-64a2-5e9b-f89e-f448.rev.sfr.net. [2a02:8434:fda5:4201:64a2:5e9b:f89e:f448])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba08e35e44sm4309775e9.1.2026.11.10.11.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 11:08:56 -0800 (PST)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: mhiramat@kernel.org
Cc: akpm@linux-foundation.org,
	rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] bootconfig: Preserve values and key paths during parsing and output
Date: Tue, 10 Nov 2026 20:08:44 +0100
Message-ID: <cover.1794337724.git.edumucelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794333957.git.edumucelli@gmail.com>
References: <cover.1794333957.git.edumucelli@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Masami,

Thanks again for reviewing the earlier fixes. This v2 addresses the
issue Sashiko reported in the first patch.

The parent array in v1 assumed that the parser always enforced
XBC_DEPTH_MAX. I reproduced the reported overflow with AddressSanitizer
using a 20-component chain where each parent also has a value. The
existing verifier skips the subkeys in that case, so the parser accepts
a deeper tree than the formatter's array can hold.

Patch 1 now checks the key children to determine whether a node opened
braces, using the same conditions as the forward walk. It no longer
keeps a depth-indexed array. The existing verifier gap is a separate
issue; this revision removes the formatter's dependency on that check.

Changes in v2:
- Patch 1: derive brace ownership from the key children.
- Patches 2 and 3: unchanged.

I tested this on my Ubuntu machine. All 137 focused checks pass for the
combined series, and the full bootconfig suite passes after each patch
(86 passed, zero failed for the complete series). I also checked the
revised first patch and the combined series with AddressSanitizer and
UBSan using value-bearing chains up to 95 components.

Review: https://lore.kernel.org/all/sashiko-outbox-207566@kernel.org/
V1: https://lore.kernel.org/all/cover.1794333957.git.edumucelli@gmail.com/

Feedback is welcome.

Thanks,
Eduardo

Eduardo Mucelli Rezende Oliveira (3):
  tools/bootconfig: Close only opened braces in compact output
  bootconfig: Trim unquoted values at end of file
  tools/bootconfig: Preserve values containing both types of quotes

 lib/bootconfig.c                              |  5 ++-
 tools/bootconfig/main.c                       | 43 +++++++++++++------
 .../samples/exp-good-mixed-kv1.bconf          |  5 +++
 tools/bootconfig/samples/good-mixed-kv1.bconf |  5 +++
 tools/bootconfig/test-bootconfig.sh           | 29 +++++++++++++
 5 files changed, 72 insertions(+), 15 deletions(-)


base-commit: 677f83795fdfc25ddc51b665a9111f5ff199f7ca
-- 
2.53.0

