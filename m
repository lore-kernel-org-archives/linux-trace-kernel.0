Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792436493;
	b=wahJNjZ0NoBDzt+s6GO5YAvnBFzIX/NEFOWx3W57o1EVPt6cLKZAzLPuAHlc0UwGw9Cf
	 w4amKDFssvTuIfO+Kg1LT9NP+qfLcDxYdH3ZRzTEqidtlXjnG59Ma0eqsScjdyiH3roSg
	 6MDuPcQdPHCH+5BqliXRDUVgRPYnnSI/QUNlynTTm9zelqDAcqzGo/D5CxzzH6zzGb15b
	 lQa9t0vQ3WOvabr2yKbXWG4JoGrcouJsc63DPuZQFuxZ7C6C2GPZNPuLbokqAdLKpDZgR
	 Jjqi3Iuj6wQLggShF8KhjqspPAkXkRdNm2L8shog5RrA9YyMJlPZ9aH+wFvV945TjyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792436493;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=ssNnql6T4QoOjXfpwZ5XX0q7jJl54eqkrFJ3D8Kx+tc=;
	b=eGeeJ/wv4AhvoSS9aY3zJAKyyR/flVepC2iT1u4eTO6lDTU5P89oali4+vkO1aXFgucc
	 dNx2SY6ig+J7wjQ5Xo0YZyHUjrkEAU+6pfLunPfq7wg5w8ZESIbtbSobWx+uaX/MpgSB0
	 VwI7lYsqOkK2r+VY5ACcTpbrFaT4LldZ81l8P2C9rFM6nhblAtm/kb6M5FSflWAN1ZGqa
	 EMyfysikMrJ23MlBI1+RYf4emuNvG7LRo0sXzPm7+LJoAzCZmfBv6dxpHeDaUnilNmb8L
	 kQf3kKR5q6OSkmmVBieDHrIgoH3A+SYEp8jHnUzjzu5wTOW0Teng4ykDPZ/SF9xFALw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=eybOXS98;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473C1606A336
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 19:01:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 473C1606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=eybOXS98
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e9995ce866so18322995ad.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 12:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792436493; x=1793041293; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ssNnql6T4QoOjXfpwZ5XX0q7jJl54eqkrFJ3D8Kx+tc=;
        b=eybOXS98+qwDrucTS3VRYXEuHDywB0CAYVw0Q/6te+J9rDZStVPiIlIQT5bHPzytWA
         vyWajAelnK0mCM7+NlT0Yj4P9IHzF7xrwEdt8lK3p7Ca1YHJDVas2vGrgOfLBj5xfC1z
         17145+T2siAZQjxORxEkAaFiTwpPwrK5Tx+TQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792436493; x=1793041293;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ssNnql6T4QoOjXfpwZ5XX0q7jJl54eqkrFJ3D8Kx+tc=;
        b=15UShPG3H+BHZEOBi25xBoUoXGpJaC55iNh9w4qM1qA0aQeOUU/elZlpbaaDtVE8IY
         syayqViIx6yqPvODRMV5O7YRTj59Ct1OqbKM38Hq41RQCfDT3L2QXBCkJkRBvw8cF+jm
         jVgLqjuRfY/atW/nhIUAaJoklSNh8d09lp9hIFtgzYv2XpoRrdublMlzoLp8KXqa9qsC
         b+sHnPGN/MIFEedLi0LFXH/TfyyhzEQcXDfkNUNU6yIvm9p/qUxr7Smy61u9AsaxZMLK
         S74I6+RYbCHvZeJUTH5V8jp/zD2ZqDWetzThauonFwJs0Kmt0X6+YuhTFYPksSolFs5q
         Yj3w==
X-Forwarded-Encrypted: i=1; AKwUvBz6dWK1IEmQhSz+M5pKSnuxzXDUcJ/wGN9WzzPPNSDzI0bnhAUSrnAtGGaPTIb8Lg5+zlk826vlMgjjPV2drRnCnkk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIEDBpn6ss0n5pMukj3jEl2lVjloVdh8UZT2FbBP9udqW/F/I/A
	bp8sLEEcL52GJ/RoVmneJi1EHVg34z7zqQI3bXNVtNUF8OR7PSrRMaBkOn1S3qPChw==
X-Gm-Gg: AYBFou120Ae4f0m9ERpC/jF856X/OI8jaosijnR1bQ+aPS57sgZM+C0v4EiW1KnZd97
	P7qCJIjSxVhUTSskuuEGQfTHgDGR4n581V54i2572+VKnHFrbQye1cjz60ghFe/hGJwvmlA7MeW
	9txua+dxZaeSPSGILuc2JleHYamZpYHXLJVJe+y3s3M88WbN5Vw0T35mfOBNaEGTneGb6KDfAAa
	imiantBkBS6mJj32jRE/42v46L31m/IwJhGxMmPWVFpV4u5Ky1RSkOxYcYS0o64t9zFi5TmIfuX
	Dr/nD/F2bwJw3dIydL2Eqtxe23J2SJDU5QHxG9QHvo0M2VCMERrn1Um/0Zxniqzmf5SEpYI1tn4
	+TZ589FU2kanawDANcaiyb88bvna+DTIRFzmbcJdPDj5zwHIfswwHzs8nTIeGg4ey6dqfx/ZrPl
	nC6MjuxfefJN34uMw/Vppt3vtJDjndnDEQ8uBrfhgEJkEZPJWt4BmoWtv4iUcJw0kd7XPgULqY5
	9LMT3kJXjg8EtnpwWQQN2gXkBEC90IW2BqIVkXbQ4Oll7nJOLXxPOAydHetYslkiXS3M4ZDHwZ4
	xmrq3g==
X-Received: by 2002:a17:903:22c6:b0:2e4:b37a:d583 with SMTP id d9443c01a7336-2e9a6d367b9mr71528345ad.61.1792436491064;
        Mon, 19 Oct 2026 12:01:31 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (218.117.230.35.bc.googleusercontent.com. [35.230.117.218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea151e1b7esm4473105ad.75.2026.10.19.12.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 12:01:30 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Mon, 19 Oct 2026 19:01:13 +0000
Subject: [PATCH v6 01/11] Documentation: Correction in HID output_report
 callback description.
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-send-upstream-v6-1-cb9ba4b3d6fa@chromium.org>
References: <20261019-send-upstream-v6-0-cb9ba4b3d6fa@chromium.org>
In-Reply-To: <20261019-send-upstream-v6-0-cb9ba4b3d6fa@chromium.org>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 hbarnor@chromium.org, tfiga@chromium.org, fqwqf@fqwqf.xyz, daleyo@gmail.com, 
 Jingyuan Liang <jingyliang@chromium.org>, 
 Jarrett Schultz <jaschultz@microsoft.com>, 
 Dmitry Antipov <dmanti@microsoft.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792436487; l=1212;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=3F0PUGRvwtvEKibOIad7sMQuPUN5v644d10H48NGstE=;
 b=oNrr9I9JcmB+rovcLexc52aW/JcbxtVxrpwrTYSTNrVT9zSgQ72OmH3qacvYoupyivVC/2ZPi
 FOYyp9GlaJNCdYZ/PxNSjL5MCAqvSVv1uPmyoBi0jqFRO7HCzmMYTCH
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

From: Jarrett Schultz <jaschultz@microsoft.com>

Originally output_report callback was described as must-be asynchronous,
but that is not the case in some implementations, namely i2c-hid.
Correct the documentation to say that it may be asynchronous.

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 Documentation/hid/hid-transport.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/hid/hid-transport.rst b/Documentation/hid/hid-transport.rst
index 6f1692da296c..2008cf432af1 100644
--- a/Documentation/hid/hid-transport.rst
+++ b/Documentation/hid/hid-transport.rst
@@ -327,8 +327,8 @@ The available HID callbacks are:
 
    Send raw output report via intr channel. Used by some HID device drivers
    which require high throughput for outgoing requests on the intr channel. This
-   must not cause SET_REPORT calls! This must be implemented as asynchronous
-   output report on the intr channel!
+   must not cause SET_REPORT calls! This call might be asynchronous, so the
+   caller should not expect an immediate response!
 
    ::
 

-- 
2.56.0.212.g129ede20d9-goog

