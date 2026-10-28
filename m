Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793216221;
	b=vCiBI17Dx9KpgN0V1CZ1rBZdzAQs42/F0ArljuY99ed2SeF6cGKURnrzehV3VJb/JEay
	 3gJX95Tc/YvRaYz7WiFhmCBoECJSqtqrUZREGqiAsaabV82YD5QXdbQticXzk+A+fb8+T
	 ALvuysKy1DKC1oXkAHdKQZ0Y1n0z1gTqGmZz3OjTEJxnjITvDifF7WM2XA7k95qWslfOq
	 NT0pKdCJ7EGT8xlEkdwbRUpk3Rh0Xl4ejjh45FCL2s6OnV73h3AAE5Jx1sWzdLC8xGf1g
	 7oRHB9ZGaprW/LGQaYM5a5wojsXQ88JjiQ6P6K7hvCvbsZmEUvsQKi81Sh27kvcRY3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793216221;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qFb6n4TRYRQMHItVUvZoh8iS3ZAnG4e4uqRFxHODcmA=;
	b=AVScUo7vP/ry4Mfz5e6Gqpb4HYusvPCTz8o9RVzAWIUPHJjYuMReZbcLimrSUg35VjeT
	 mtQW8PXpl0LkeRDm966QcOGzOlylUaNmuuO/UM20SvBIVVjFurbH4BntFPMWW/JviHUMB
	 97eTIx6rLfzMkoE806FEXU08vxgzeKBR7e+Z19PGGuR7AsKdhtebNXGS2wRjOmVZ6KeOx
	 4o3HWVWpko+0/GjmqWVIvJgqmFHFAevH04BJjU8LbPG7Nm0CCUoTTpNgOXWd2VJg+vI6A
	 qHcHmGyDmro2eVEGJcHVX25jbI3MWCy0J0Hn6BfmXPAxr8C30WOu2WEPft32SBsQe0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q+rIeEt6;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9DD606A31D
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 19:37:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC9DD606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q+rIeEt6
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48e0d1da913so14221f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 12:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793216219; x=1793821019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qFb6n4TRYRQMHItVUvZoh8iS3ZAnG4e4uqRFxHODcmA=;
        b=Q+rIeEt6CpPE7F9GmV6ZVG6bNBW9xBSxS4jPWJRmIRxRh8hxy6RSMVzncRB5HbHWGt
         OP6zIuqBhz/Sq5ZV9EVwnWbn2d94slghb9HfFMX9RvmlGXz/3LjTEfg32REhOmg1YiYv
         4g7rk+NNrhO1koPKzqK9PO+iKwxEYPDHwo1BAL1iNrPXvXIypiTv7Qs16gwEOclfjk0A
         zLbuEdVpomtSbKJgsIfvhot83IOSbB6u+UbsBUoBSa/fWUo9uk8wBaulUrqfMc5e7mGa
         AOIHO5HdbwqFB54Ll/7CjcTZ1o7xDEP50ODsf6uW3qrJGXqtZrvFQXjeDuz5oG12yIK9
         7DJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793216219; x=1793821019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qFb6n4TRYRQMHItVUvZoh8iS3ZAnG4e4uqRFxHODcmA=;
        b=evlH/Q/rB9sy+aUqcyTejnK7yIm29W2IlSpwPS0I2R7ksVgCGHOy/Mo1qiDOiMlfH3
         UPV//GIOZ7vCBiIJTCr1LBwV+k8ebu0un2ElpcGDBNFXFXMEZN9AEs6C6NWR26Q+hl1V
         0+L95vE8XYJgqHSwG4uH5AE7PQJmLWce4EsE2vTTi0N2cKhChKekFMXztZBgatUWumLP
         8NKH/8LrH04KnZ9jwzs+jcfJpHBtTzQzfYNZuEuE7wzsK2X559XWAbGssW4DivuxyMOJ
         hVGIme6wikwf0la1GIL0BnpWDAJ9TTPCRRLLrAVW3Rx/37QDk2b5qL6dcckSpVg4WGtE
         jxzQ==
X-Forwarded-Encrypted: i=1; AKwUvBwudY8n4SAo0qIDsrHfkFF6xZjxlFpgdw2SfXeCpGkG+McvfDXBCExmmnvOacNAqyik5reyztJUvqycyUOQezs2vTA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLsE5n/Ao8oAehEyiy3iDj21BsKKw9qo80CYYETQDcfNrnsn8wJ
	UKoQ43SLtRHoXmQmUy/11qYroXDvKGEboDdzYzHow+KylnAlkiTU4+tQ
X-Gm-Gg: AYBFou121Q0+M4jIVSlAB6zpxfIX38kB5RXsQuv0AEJPKSITdPXskVfyXFq0vdAtChZ
	4WC0YHYPbkCTFCp4uq4lH6lhwmJipcPGCYscjSpgCG0Ntd196Q09qy6iOgKndjfKBA1/Ej7xRVE
	R8gtZabM18j9gab3vVzMgeEccD+1PUKZFzudEUHbb/esJl7V9Bs4vkSLtoeKQB3nipe2nDEbimR
	x6WybAJ9IgbvuDkaK6/LAiaCJaSR9yQxGdfMxGsBrEptv7VsPiRSfd4ACxBFNp2PIu3kYn83Y+d
	ghAaGkgbHQI74MGZO/d/+CR+Sm2Szg8B9fWrQj5C2X4e4knMtfCzoUsepQFO+MrTy+/N75sUiAD
	HJ78XeYLv9kbbY/Nvd+oDLxDUz2APapC1uOd23Ue9RaS+0zalTYyJ9G140hcAECqX7thaB05MCK
	YRgI+X12S9XjR8Hlw6sPZwblLZIpfSsL9RioKUNlCYuiIPlu4TGAqMvVKaJUbYCTR5kLUiYGr+Q
	aMwAyMDW7FtlkT0TfnyonF5i94KuC/EgFarFYSkIR4U3J9hd5bEl5SjSVUmpNp2bsa3G7eJ/ukh
	K7UY+Q/VbZl8AGQq1nrPs1AFCrkkNczlG8elJMTw/g2Nvo8D6IYvQhyDVw8cbd4eg5vg63LRftj
	jSGlYYTkTZRnQEoczrjCfiDeGEGWCysd4toNA9ctXPXIXiGrOmhgwsq5INT2v8Vx4lV4OTpNdAU
	tWQEnEfPhxiGE3KNLy2dUW/4esC9ciADJbbuLZZEp1yUbXvfxYURoZdQRWpg==
X-Received: by 2002:a05:6000:4a16:b0:48e:5d06:8b66 with SMTP id ffacd0b85a97d-48e649b0958mr1497723f8f.19.1793216219054;
        Wed, 28 Oct 2026 12:36:59 -0700 (PDT)
Received: from longitude (2a02-8434-fda5-4201-3fca-2040-fad6-74df.rev.sfr.net. [2a02:8434:fda5:4201:3fca:2040:fad6:74df])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd3418sm27004611f8f.41.2026.10.28.12.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 12:36:58 -0700 (PDT)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] tools/bootconfig: Preserve filters when resetting and applying tracing
Date: Wed, 28 Oct 2026 20:36:22 +0100
Message-ID: <cover.1793216183.git.edumucelli@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Here are two more fixes for the bootconfig tracing scripts. They address
resetting existing histograms and applying saved filter strings. The
patches can be applied independently.

The first patch fixes histogram removal when a filter contains brackets
or repeated spaces. A failed removal can leave a variable provider
installed after reset, including a case where the helper returns success.
It uses separate sed expressions for [active] and [paused], following
your portability feedback.

The second patch keeps quoted strings intact when applying a bootconfig.
Currently, repeated spaces can be collapsed and literal wildcard
characters can expand to filenames, changing the filter being installed.

Both were tested in temporary tracefs instances on my Ubuntu machine,
running kernel 7.0.0-38-generic, with recording disabled. The individual
patch emails include the reproduction details.

Feedback is welcome.

Thanks,
Eduardo

Eduardo Mucelli Rezende Oliveira (2):
  tools/bootconfig: Preserve filters when resetting histogram triggers
  tools/bootconfig: Quote command strings when applying ftrace settings

 tools/bootconfig/scripts/bconf2ftrace.sh | 2 +-
 tools/bootconfig/scripts/ftrace.sh       | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)


base-commit: e28458ef30ad66ce7cd2299ec5ee8a8a016d67ff
-- 
2.53.0

