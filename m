Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792803113;
	b=veAyZnUwJt79DRndMviZZ+/3Oi8z1cze9jNN4GjjDwk8NQhIXHZQo/3tOPryJvjwoyXJ
	 4kXAwRp+MydonjyX4ckseKj4dXIvZdkEmzlBOedgozNFeyxqUdqHuLVV2rmfVgvL1ETV+
	 E3LpiMDzYNkR2aESLzDeCKtMVE7RYd1UEaDocVLuiB9pmpsrnIy90jI966PfaLZ98n7wA
	 wjEq3Ymb4nAbMrDATIESf+06mGjkuoRCuMofvhNtQNfTIvuYPnJoGcuzB1Z2VnU9yBuDW
	 mPWqo4F2U+2voB7EjRZ/zUQV5NpMEvi8xs625H3gpxQOfbiOkwAS7nWz7SQ9ioLIYyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792803113;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=+y0vpLA6rDnZkZJGvTpFSS8QdG6zDUiFg4vlqbK0zls=;
	b=k+7/iqhBMFPbB0GyKCxUXl9ed4uwpIjqfVq8BO2mnjSZgDo9cKFtjbZyLzGRYGxdBTvk
	 gQ7q8zjHI1ngoO2NsNSCxCzxQgLNwLOgrGHRfg+1trS+q2Eg7K2o4fpUTwXhQ/xHCuRlz
	 GuzlssLlTHzZwyNXWqUrYLh2vqXVxmz2ALoLO044MSYFfXpwkrfJIGXUFJBu1RZ5vY9ol
	 NqUvarE/CSEhBao88EC5mGVOlqjJM+sRqrM9Ps1WTjNQGMC2RJBI1DJe+sXoEb3ju2r+7
	 sXsAGR5vj5NSUiGGBvmHlDiKiWZPTZ+UWd0zEjhnmFJAFXPHdvVhjF8uLXlCOS0MvCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Y1cZa65q;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C23D606A326
	for <linux-trace-kernel@vger.kernel.org>; Sat, 24 Oct 2026 00:51:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C23D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Y1cZa65q
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ea0efd636dso10462735ad.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Oct 2026 17:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792803112; x=1793407912; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+y0vpLA6rDnZkZJGvTpFSS8QdG6zDUiFg4vlqbK0zls=;
        b=Y1cZa65qKf3rNeVmoPQnEIKAF6xrQhj1+SuXNOEflQZczWW776jP9jQfcFQR6OfJV3
         yqF6PfKNfijIBpSnQqCst/hTuWflEY7lqwUKFO8OO5VZ5DjzBE+b3dFU9PwoJxIoU5yx
         wkHl06/LmYFBuagl6SSUwI0oJW4wcEXUQyUOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792803112; x=1793407912;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+y0vpLA6rDnZkZJGvTpFSS8QdG6zDUiFg4vlqbK0zls=;
        b=J31zOZfw0YklEk21qUp633092n4TyzUSfRX09ebYYo4c1ZhgiuqTCT4bL7lPehPwzb
         t7sU9LcNAUkhx9DQf+kNwKi51LVJEERWOX+4CUb8iFyf+YveYWuUcjJ6tKM+kG34DiLS
         nFqNQd5YSapIfGMvPGP/9w9csX3fepKtmEVHGGTskmQ5gd2Ll7Ies+jPKDeFLbEIrQk1
         HUIxQR+WIC90wOafRtbVwa3ZyP00s/G9MTk1kNQJlGfy9sai3SIhYco9b3XZgQnge4+r
         S/wUmFweSan5oayEPdSjUN7BbvQkYXUOzcDQy545Yu3Lb3GJmAqgl6LhntpAQzb4fhyW
         iWcw==
X-Forwarded-Encrypted: i=1; AKwUvBwSzuVejF/DZE/Yemo3bww/kU7lrBgjZ4GJlKjXZcFD+rj5KrH2ezT+aI4wI7foqRPrdZDJQTdkUEYsNYcRorzSJ2Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYKK9Px0LySbETsHhD2xG2tE5omuCuc63lAwSOoe6p9YZ8V5W5SW
	gcOZrhsB2gKWw9fAZLKNto9FOcMknk7fMpc4XQykWgycklKgFzeDRi+vojcjWgTvTA==
X-Gm-Gg: AYBFou2h5RrLeUfjBt9kKhIeS3tTfggvDvNiRVfHZb/6d43IzOyk5VPP05jGAPWbktK
	JlHhnpIFezw8nCJJvZ5ILRtJvshFzgmcjtQiFJEUSodqtPXEi48KA8/u8BseLcW/sMLMxCaF6Vv
	QgZRBapQPVft7j0MknyDXvMC6fO1dXQDENdI5JgKPl/QIBEVCcQ89nka6lmXOuiIOf8v7GF9VUw
	8YThthOh7fYMELIWUyiXJ4VK122ZfuIViTcey23um2jbNuITY4JwsUiBpMDNDLnUyfIjRBsjBrp
	9Nl8buK++qyml7fjyPYf2TZRnrojjQSUXSDm4DwB+j+lwLRP6EA43efJ1cITKL4huxv1NwS1vQO
	qnfYJSOx7X2uY6a+z+TwAUDLnJ3H1wZwv7+c0LuOB4MWuhww91Ab0fqjlv9htGc1gUzG+yZHR5r
	y7d0PYq0y97GE3VcaYZjZYqWpp9Tx+p914msPGgq4XGmtlVkcdB8AZnrEo2lYTOuh93GfbwJfTm
	GpyZVmn5Xo43SXCyu4cIu0m8Fober+74bTiV5hy1cGB7p9WUWx8KRXN0X+WKmq7Naw3SwnWQ4g+
	a4TtvZDFonKnTlXR1fvS6lUiDGZ8qN8BfqNs3BOPrvRJ0KnXzJ9QC34xbp1kuGw=
X-Received: by 2002:a17:90b:33c7:b0:3ac:7c52:fae5 with SMTP id 98e67ed59e1d1-3adeae78223mr710221a91.50.1792803112460;
        Fri, 23 Oct 2026 17:51:52 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (218.117.230.35.bc.googleusercontent.com. [35.230.117.218])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebadfeb1sm843763a91.9.2026.10.23.17.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 17:51:52 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Sat, 24 Oct 2026 00:51:35 +0000
Subject: [PATCH v7 01/11] Documentation: Correction in HID output_report
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
Message-Id: <20261024-send-upstream-v7-1-abad13174b43@chromium.org>
References: <20261024-send-upstream-v7-0-abad13174b43@chromium.org>
In-Reply-To: <20261024-send-upstream-v7-0-abad13174b43@chromium.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792803111; l=1212;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=IwRF58jgSTKP3fdajEFSeRD6vCiZwxLFM3sXfjl8RPQ=;
 b=sqNkuLc95RysONWlhkLkd5q3xh/LjwcP5ptF4HGTo5fIv2IBDuCMHn321hsAylqkyHBNqNSSl
 je7LcVE/CrEDf3mcpNveHsUUJQfwXAnE0sFD4Emc7TLquH4W7kkL6F0
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
2.56.0.257.gf7497c7d27-goog

