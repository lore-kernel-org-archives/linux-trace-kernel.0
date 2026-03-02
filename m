Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90571E5B88
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Mar 2026 15:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772464292; cv=none; b=lD27YdDm7BxfyhWzqguBASTCe8Xt2NU7T9I0yOn7LMng5DccJsPf7Btt3CCK2hDXzm/YpUrfWgovebjZXabuq++g+CjkqK9q8wYKK5b5DxINzcH+8kgmaVPU9ZE26gQijmgdJAPGEXvvJ41ydjNp8z90rsseN7F5zrGjJt8rw+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772464292; c=relaxed/simple;
	bh=4hs5Cq4XX8VTuRDeJwyB/kAHYeKtChbZhOqVcXJD2s0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jrv1SWa4oh2bSdmxreweWiHqg1ecnMmRi7adxAaJxGDGBsT94Fk6cM8vV3h3x+9T+iA3V3odp6Cu8YGmoVt8rzEVVIuXE0j24lKYjXplFraaR1NT0/VQtMg1mZXuceu4VGosZihUOxMdFjrpIhETcwV2tZGCeplqQuwFt/xQeAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=JTQy3lS/; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="JTQy3lS/"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-899e87b04d8so32409796d6.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Mar 2026 07:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1772464289; x=1773069089; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e3BqwdRnHxc2GRaZzZyZvv1rY2lAxZpGHqgSHrtLwQ0=;
        b=JTQy3lS/tyumEDiAeJk3KNW4EspLWYd5t/glEsJvak5/kIkE10VgoVhJlw1tejMGev
         XOM0CQ0izCqoFTok+WA0ZP/kYTNLHkdiMCPdJhnQGaOd2vnSmPZt7uqTTwGaJQhNSI7l
         W0+h6VUw5sYt2yy7KV2034bdoNNP5wSWn0vEI2AKaJs599BxH0JkFpliU4rWso4nPLwx
         /GfK9+UI4iJE3gEe9FyzlW7LtkVAkfFm0laQ9KtXv6Q4aajmFjf4KOAN7+5Kk5O21/EE
         V7NUKPgEgzrlyUi7C0fbxwDjTQ0InZPwkzcPpWnjW03Ep356UNvGPaVD6zMITzJTrQSC
         pldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772464289; x=1773069089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3BqwdRnHxc2GRaZzZyZvv1rY2lAxZpGHqgSHrtLwQ0=;
        b=ZFEj5q22EWEzNNLHjRIbsL7CjtJGPEo5rG1hoRBFlTiqrJuaU52segYHfJgEdaTNBp
         ULuSt810SkmWocfpNg0ZVk6Vb3uesXE7KJph7vjlFWtM8QrawblEpjLFToq40lJPWqoq
         1BIZVCgCBeMz721m5GpPGNMP5UM6A4weojtAGepjAEvPcRFhP6S9Delnl37HzJSQ4UlI
         hfh4r9ENbMQPPReft5UuYdU873pu2cEgKZbrgrkd2V3+O4b5R9hfFIaegT2KGkfyj1bo
         7ZTBOd3DKyZovxYq1qkmz9zJYQhNZMqRZbx+yKNc/NuM2mBCCX01mcpFVpACcw0JE8ZB
         BrYg==
X-Forwarded-Encrypted: i=1; AJvYcCV+hvVUhY+7iBm/Yeb0eGlHxGR85Fxt3Ew7DJFDdwndxBjAqoU7Ki83u1u70y0/LX5OE0LRwk01tM/u/vrLYJ7FAc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHRnWr9miSHmk/Z17asOT5esOW5qzhdP7eoP7Z36oUBzxUh4LW
	w+LSRL1iSD7Rs/jQZb78+v/rxvyV8IexHKsfm17REwTB58zI5DoN/A8kt4l6BBjDKJU=
X-Gm-Gg: ATEYQzzXSCCaSFuysvVHAvWvfbJbyhXAhrz5UsF6BNRhKxp96n823tXD+0uzrdq7/0l
	0tnqMRkLteo91hIvlz373mp+7WPKf7SP4QcH/o1YO8jHA2O0L5973Y0UyZAve7PdVm5mO542uuU
	ecJr4HPKqsj0zqNUERvBbluYFokhQAkNwBC8aqNXGWWMM+CDmLMObfcDhjbCV5TKaJ+QTq9JKlh
	h8eKA8ZpjsCiyHZWAL8rNxdXI+vAM0qGNX1ggbL/8uwdRqFjdYyxf7zd75xgpy+XN8ri4NkyDHX
	BJVqfwUeoxWssKSSP74CvRH2mlw1ZjpiIrYgmOf0tykz5J/1b31GGLUCo4sC0l6xvwhb5VYVbcA
	iq4mCAVS+ySKKOLBeoYDYKZCXMm+InhuT6KqQmkO2X58gBbVq+NvO2vfeQ0a07GfNoCvQHfOBg7
	zpmYtlOyFLotOpTjOZ0aJ0Hp2tzIvZkMfb
X-Received: by 2002:ac8:58d6:0:b0:4ee:1b0e:861a with SMTP id d75a77b69052e-5075273917fmr173965691cf.13.1772464289546;
        Mon, 02 Mar 2026 07:11:29 -0800 (PST)
Received: from localhost ([2603:7000:c00:3a00:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-507449add38sm109824871cf.13.2026.03.02.07.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 07:11:28 -0800 (PST)
Date: Mon, 2 Mar 2026 10:11:24 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andre Ramos <acastroramos1987@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	david@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH] mm: add Adaptive Memory Pressure Signaling (AMPRESS)
Message-ID: <aaWonCzCLayQDXOT@cmpxchg.org>
References: <CALXtAv3u1hgLkBEbEgR3=r_iz3=KrnHB8B-=tg8Q3CEOWAPFiA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALXtAv3u1hgLkBEbEgR3=r_iz3=KrnHB8B-=tg8Q3CEOWAPFiA@mail.gmail.com>

On Mon, Mar 02, 2026 at 12:45:33AM -0300, Andre Ramos wrote:
> Introduce /dev/ampress, a bidirectional fd-based interface for
> cooperative memory reclaim between the kernel and userspace.
> 
> Userspace processes open /dev/ampress and block on read() to receive
> struct ampress_event notifications carrying a graduated urgency level
> (LOW/MEDIUM/HIGH/FATAL), the NUMA node of the pressure source, and a
> suggested reclaim target in KiB. After freeing memory the process
> issues AMPRESS_IOC_ACK to close the feedback loop.
> 
> The feature hooks into balance_pgdat() in mm/vmscan.c, mapping the
> kswapd scan priority to urgency bands:
>   priority 10-12 -> LOW
>   priority  7-9  -> MEDIUM
>   priority  4-6  -> HIGH
>   priority  1-3  -> FATAL

The scan priority is not a good proxy for pressure. We actually export
reclaim efficiency-based pressure levels like this in memory cgroups
v1, but they're being deprecated[1] in favor of PSI [2].

What are you trying to accomplish?

[1] 340afb8027fa ("memcg: initiate deprecation of pressure_level")
[2] Documentation/accounting/psi.rst
