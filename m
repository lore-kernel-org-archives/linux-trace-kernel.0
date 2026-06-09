Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5356F37267C
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Jun 2026 04:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780980087; cv=none; b=Sq+UtoXQ/sJauHzIrlBbB4Z1auqZRBPFlt6Azce/hNKBVLXLTyytP+tRImanMVkPQR81vlRa9/stgb2lINfRouirMRCSHDTnlr1WQ4/6AOriZFAwGzLHvw1d7oh3VKTmSf9q6I4OtTgunaCR1NdzYfp6X21Km7cCAjwviruwRHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780980087; c=relaxed/simple;
	bh=JA2M7AiLUuSc6veCi/kbJrYplg8DlHt3oDIafgdkMi8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jz4JgOh4LD+qvd+1u4H0PkFBAhv27ZCt30jZQ62E3H7ejZjXa3mqzQQ/TOP4pJeGk8Esjv8x7X6Go1JJW7i5C+mxQgm3T6cGfRGD/65EZL8riCrRC6bryNV+s9kSut2yCpx082N6rW35Rv8DNsqGS6YQN3fnpFYyL7mLFxt0Nek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FtNIrr5b; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FtNIrr5b"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c0c2c7d45eso45716345ad.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 08 Jun 2026 21:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1780980086; x=1781584886; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eA0puiI12gkUUrChccEFoedZkqg321TG7vWV3+7W2Ns=;
        b=FtNIrr5bpJw5cCz9yjGqXFQxfbfSh3Ro21BPtakPw+eYYgW1GCRW2n+jFCcGA9ohoR
         7mjyGbCQrtBVq8BhEqKd9fqKyN5DBV7ka7zdhHI+gQ6j/3y+ZCrW85jrmjax2BCqvTXN
         vmWpQll0TOTG36Wgs1criDWj9c8+lDH/r17S4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780980086; x=1781584886;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eA0puiI12gkUUrChccEFoedZkqg321TG7vWV3+7W2Ns=;
        b=Fcx2EjfF9qTf2f5Dd7Zfnp1j1I0ablHsGYeAUJ98zGf7PmhHjjbk2dfVFTtcgL4TsZ
         o4xnm07tKzyL3yJloS8a825clHCE1GeR1xw6tmn0m9jSsowiz5QoPhYHvWMNk8T4guUa
         +Vq/GNWSTi/JII2eL6RaOiWr3GBEx8ZipEGAuUnNk7/1I0CyvBRXywTUeaLgh4o4tESz
         wCJmEne7cT47PN022zwjNoerqznc+cTvyQMMjAJmEjS/Unxn2mPOxfRGEOb2xyIZuHEq
         BFRWEjK5m8o0mqHFM9K1dIUFU3AgsPTYnTpjAo3jK2/8rCDdEWqTAxYWDwNR7FyA1/+N
         oFZA==
X-Forwarded-Encrypted: i=1; AFNElJ98s7W0H6QPAeUR6kdp3eKLul4GLoLS72pQFXdTLEiKGdnkvU5XUJBbk6g5Ik5OnCe+uMobJHOlr2zCzXTbnebbus8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx7XDDhM7qM81lShBDFh6doJZiDHtZi7tG0whFMriXGtJSP+KZ
	rtBqbYl0x01zR36PJGB+cKAhkML8CXiH1Hdc9tQAXtareLqP8XaxqK5uDmblbE4hMg==
X-Gm-Gg: Acq92OHbCC8/5NlF2yo8ryMPtzu1TS7OTuLehBXSOSCgmJd2mbr1iY6BlGW7yikfj3R
	hW2zrng4c7B4oTce85/9Oh1A9EE77rmHRe5RhVkHUP9ghkBp1gsRChi2x3YV0N3L0i8Krwn/h62
	wcJucI8t0RUxU/6pm3Xtben2oHiRt8IG7ULTw0DKNZbfjPZ6XB5poBBFnhSpZXquVwDh3KUT5Rj
	Whje5fnCV5GcGQNKwBTKHxxaGoU6o6oaILm0BgcXp7BwkROm21jH59qpFA3VI5wFHTBpwWoCQ5I
	kUfUZeTdIhZ40y9ePzpHygEQiYqrM5vm40DeqCuPnzteJqTNrOM/yw/NAoiyPZiWrajCFZGIkxV
	LI7tM7uEz8uLTqq/CT6Cn5Nq+oFhpOVmrBuUxeCppmF+moZ92URx/MczZAhxxJxUXdrbIzoN4L7
	B1sE4v6S8VV/Ac1dOb2W1q8bbzV+23/8QnccKyCeMsYwK06KXbYBynL9zVk2f3fhYj3dCFciNVS
	iMPvB1uuJAfmCk4EvzlqPu0kYQdncbUE+SY/AipElFj
X-Received: by 2002:a17:903:41d1:b0:2c0:af09:f3c7 with SMTP id d9443c01a7336-2c1e85c0cbamr219282855ad.30.1780980085929;
        Mon, 08 Jun 2026 21:41:25 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (111.169.168.34.bc.googleusercontent.com. [34.168.169.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1664a67b0sm200736065ad.80.2026.06.08.21.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 21:41:25 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Tue, 09 Jun 2026 04:40:52 +0000
Subject: [PATCH v4 01/11] Documentation: Correction in HID output_report
 callback description.
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-send-upstream-v4-1-b843d5e6ced3@chromium.org>
References: <20260609-send-upstream-v4-0-b843d5e6ced3@chromium.org>
In-Reply-To: <20260609-send-upstream-v4-0-b843d5e6ced3@chromium.org>
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
 hbarnor@chromium.org, tfiga@chromium.org, 
 Jingyuan Liang <jingyliang@chromium.org>, 
 Jarrett Schultz <jaschultz@microsoft.com>, 
 Dmitry Antipov <dmanti@microsoft.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780980084; l=1213;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=WgXF5HKmPVI1MEtrLNcqmUizKiLvnC1/DeVVEsJVV4k=;
 b=MRn8ThmipL8aQeFe4El0wwHcRed1esJP/XYC9aYnkuywJVUaIVxu3P8Moai80Jt3iW7OzC0El
 WxYiULYHaqZCIsSH0OhJG6kcJ1FO8J7LYW+q6zH+Xa0pPw0DZ8OiK0e
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
2.54.0.1064.gd145956f57-goog

