Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82BA19DF6A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Mar 2026 05:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773205860; cv=none; b=rgfdPfQzz6teMr+lrRlHj9BOmqEI5UwbRsq08nrARDlUO256YistiNB3UVFbEuKzJyn3umy5iixo5trMIVVgjA6qupmk7EevwkzSt8KzJ2YznIhA5uH7CN4Zu4KuVed2BTe2erKDL1diQM6B+SRld8MnUepx/APpdKzMnTWHavE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773205860; c=relaxed/simple;
	bh=OM4qA659h1ZDbIWPqTMqRO8/S3PkK0dlLyNE7bPqJZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PrMlZzIAFikC0bXUOtmzd7D4TwfQiRrBaxyLE6x7nFjMYYtPL9NwEUCjc8/U3vzdQGgx69op3ZkAheFTZA/TTYGMt1tm8ihMAY3679jBjO3TjWY2Kqnh413DE1YBZL7Vax5ioUD5B8iYeMzPhIxQUAzMS0IcycxZS/AXPAqLYik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKUKrTYE; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKUKrTYE"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2be1d9c356cso9165020eec.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Mar 2026 22:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773205857; x=1773810657; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E3laUE6i6y3qJpg501FXVY7DCFbmQnP9JAUpAN9WyI0=;
        b=GKUKrTYEqjQdIPgmyYvWEYRBWj3tU/hpD3Nk0rEAO3N+gW3OagHoKuVdrN4JkqepOk
         DBhQdAV02T0TXRjG35ZwjYV/4ptxybnGDZbWFG9THQb2Q8SuRl7Z3tEsJ3AykRKi4hxJ
         q57vQZ+CQf8912pEkeoXrdb8MHSi74LXT28sshqaVshthB2wEdK3+4KIsUmHfp08PVWJ
         cavsoA5UySyUvJNiqPcFkaNgfwaBU/u4gq+oT1+cl5Ro/RQsicVoKXgu/dlj2KeuQJ/F
         oebkBMAza259swq00IPQ7gSld4YoWHguiF9YFyeZNHMbVBfCDBTIDHwJhA9FH13ew7Rh
         P2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773205857; x=1773810657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3laUE6i6y3qJpg501FXVY7DCFbmQnP9JAUpAN9WyI0=;
        b=WQrCQZfyD3y4A0x1vQybJLpFPNr2Wn4zzR7G3zPqzbFltPKz3q4JqZPvlA5mOwNElZ
         kiNYqmHBI9OtLYPgonOi0fPxtG1mf5bxTdWM2cuSqJAPYimTkKUcIl09QjE6uQcVVAul
         VB+PjVCEoBtLWVw3VJ9VOz2RYlD7Cc3OV3bYln+kuHNowi1mNcbAQYt0gv2TXqrAoK1e
         TdGCm9MHQAd36J9c8Ko/Q/h2xzwhMti9c49z9OfnZFzfwQ+pf3ov87p6Ue7sYynQq6EO
         x3mXvuSdx7RgSmt9vE6L9hACwjM22G9Xwj6GRhx51JOPOXMNY1H4edGFl1K3Co5KHGzD
         IxUw==
X-Forwarded-Encrypted: i=1; AJvYcCVOao3USkpRqSySyJg6hHmhIqL99nNac/HRKv2+fpPvrJU8FTRIfpybky6Ni5ncycDvlW5dVIaJdPiwxYe34yzQx78=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBvXmLYs4LgzHpNKU1eLYrTVUHtI/zpgPI4VE0Ha8PcRSq8BSY
	licM4aXG34r7hABXDTp/kytKZeOlcDR3V9VLPmZE1exS5lvcyGcqMQsJ
X-Gm-Gg: ATEYQzz1pCthpzL1Mex+ttTL+v2MrXllyz74LHrNrpursfJ4l6xluRqkxxx9Dr46aOJ
	+tCtbl7mXm6j+brvIfMHuV+4t8je/K88mDcCZpkAvmlirEznfh+ZIgv9NODXB5PWb4aFQoLJDVw
	HYphj4t2JwW6QWbGzP2ENJeF8Lcy9VJ9PTftob1lY8qB3A4crKr0crOly8qVZjfivrM6l5LmGRP
	9B2AMZE4L9oG7+xmH6qgGUPQiJaXnRDx1q7KU/gPUwb02ZKDBppENYqBksfsX3F6b9DCZz1ffwX
	NXtukXbCL/OiZjp1752ZKtCjzvatPVrkmk0ZvVr1GUlkC5DxHWx5xmIF4sqmef4qNhqzUQaNc/I
	Errifp5kfnBW1z46gQAXxOOH7wY+w1zA6ArZnhojnGIc2Bik1UVTpWG6BxYjsJUm8xR+4ApTbvd
	eE+5ADjwpLpDLhNDQrmumlvjOE46DAGWCwVBDwtW347Zq12jCRlPQQLhllDhLcOmM3
X-Received: by 2002:a05:7301:2b05:b0:2ba:7b71:4f4 with SMTP id 5a478bee46e88-2be8a586373mr512287eec.32.1773205856884;
        Tue, 10 Mar 2026 22:10:56 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:6e17:9d84:ffa0:986b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be8a8550d5sm1192398eec.12.2026.03.10.22.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 22:10:56 -0700 (PDT)
Date: Tue, 10 Mar 2026 22:10:53 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jingyuan Liang <jingyliang@chromium.org>
Cc: Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Mark Brown <broonie@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, hbarnor@chromium.org, Jarrett Schultz <jaschultz@microsoft.com>, 
	Dmitry Antipov <dmanti@microsoft.com>
Subject: Re: [PATCH 01/12] Documentation: Correction in HID output_report
 callback description.
Message-ID: <abD5HV7TeNHtq8hi@google.com>
References: <20260303-send-upstream-v1-0-1515ba218f3d@chromium.org>
 <20260303-send-upstream-v1-1-1515ba218f3d@chromium.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303-send-upstream-v1-1-1515ba218f3d@chromium.org>

On Tue, Mar 03, 2026 at 06:12:53AM +0000, Jingyuan Liang wrote:
> From: Jarrett Schultz <jaschultz@microsoft.com>
> 
> Originally output_report callback was described as must-be asynchronous,
> but that is not the case in some implementations, namely i2c-hid.
> Correct the documentation to say that it may be asynchronous.
> 
> Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
> Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
> ---
>  Documentation/hid/hid-transport.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/hid/hid-transport.rst b/Documentation/hid/hid-transport.rst
> index 6f1692da296c..2008cf432af1 100644
> --- a/Documentation/hid/hid-transport.rst
> +++ b/Documentation/hid/hid-transport.rst
> @@ -327,8 +327,8 @@ The available HID callbacks are:
>  
>     Send raw output report via intr channel. Used by some HID device drivers
>     which require high throughput for outgoing requests on the intr channel. This
> -   must not cause SET_REPORT calls! This must be implemented as asynchronous
> -   output report on the intr channel!
> +   must not cause SET_REPORT calls! This call might be asynchronous, so the
> +   caller should not expect an immediate response!

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
