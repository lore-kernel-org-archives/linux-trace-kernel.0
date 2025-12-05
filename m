Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AD32E2DDD
	for <linux-trace-kernel@vger.kernel.org>; Fri,  5 Dec 2025 12:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764939535; cv=none; b=pU3nmlLNut3182vabC/aqNpMcw8rCy7sp0baRBonYSnn6gptEc5asdvO9RNTpid3Ycz/SKVmXw+5U3f1acW2LgDaqg/8NNRf0x+QIOgWssOAYqiK6YgMJ79e2br57HdEEMGCRuvcb2ZPbk7mRYs8u74zcfJpVSxEeDOaYhsYHcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764939535; c=relaxed/simple;
	bh=OSxQSgaO74Ist6Qy2I2ydiBk+D6zbq2c9HBhxCAzHag=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=U1X6LjSHJ7QUmtyOe9pHbdYZnxvWoCGjd9acP4muz5UhG9bURokNPuG9fr4C4ne0qxfMLTuoTy3H81PEBlQMKLo2FaLEFuPOpWRTpomQTdg6JruHB57IQIbpBSZzDMCL/aJf8CVt893sG9ZnIrCXpsUhHt5rq//qjU28I131d6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=fail smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AoOXZ1fu; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AoOXZ1fu"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so19432125e9.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 05 Dec 2025 04:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764939529; x=1765544329; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vvDpFJFk+V6cvoTCKOK8q907ac/jTowZtFGXPpMCI6k=;
        b=AoOXZ1fuUEV0Z8Kn3kJ2upGgoEOBNCuykATYYJ7zIqAyA5R9LKCvn0eQPMxCj5qM+g
         6dLy/1Our9oMgg/FNgAD5Ewl1RjjzUaZNxnRqERM2C2SBH4mcBNjigkkVHq2b0l57J5t
         jcrlTJhW8+RGdIAFRM/AyndnI8fISiz7+FQbIFfXd81zk1qC77raEzE1mkxVonBSpyPb
         MbD+hQy+4KVAk+3WRVvcZyeKCVqcn4SlN2FdmtM8csbROH/EGozPXHT5f3JNKg49idLN
         J2hihH4viwXfr0y6dJ5KnOC5wpF1lTkVcG5m4FxUO/xXpgrnlF07ISPp6kzqOnAOkzgA
         tITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764939529; x=1765544329;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vvDpFJFk+V6cvoTCKOK8q907ac/jTowZtFGXPpMCI6k=;
        b=Oguk5ptuPBzvl5DJImeEASgoMIVOTOGMpiVzPKqPOsgTQ6NSHISiNFSlIJ2id66xzb
         S/gd1sRqEp7R6mhiazhtHSVv9fAH+RTUcwXa3hM0xEKeLelYWP35ipVsbLwzkQtWyEf3
         q9djlZl2fVl3TzeTk7gaMJXbl/BrMc3JQgkETDbSMkFSeB5J27ujuoo7CNojUIEe87Jj
         u3O77v5O/SQbtymOUdjn0dW1jvkBVMEe2/waAik+ez2GbrUXZjCAYi25Bq0VSklvkGCr
         2r/JR59feMMtKqrLugUr1Bde5FZsJnbGDKvYR2tV6rlOdk5K54rCYO5CHeG9N9Dw4W7Q
         mchw==
X-Forwarded-Encrypted: i=1; AJvYcCV9Gp9Uhs/ZktCx8dxOYC3PM3Sxf0p7e5kQ4/qW2GTeZwlJ1wIdTIV+JUNAvmUNUEC4TgixV6Bvcqad24jrG35oMC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRwSGmPNiLxK1MQrkbD/kWRFZlkDkima5RLWEKJhyz3pQsGRvU
	1qatQ92AAF+vDgQHiSyu1XmtPT7OfzbyLNeOTKezmqocW5PScM2kZwZ37cba1hKNae8=
X-Gm-Gg: ASbGncuaJJwxe8BwAtvS+F4vLxBKrkAa1AGZPrzANNquDfugWVQ9wT9ZRrvAtXj3Hbq
	SHZljSQSfL99xD8NLS8a+qG6xt697SXcy+vrgtFCn6q8Ta+6gmCurCPk2HrQstdCDyUNLzIEZtL
	aiuC85N5MMZikpRc1PhGPTopBBuoUktnz4MRJWXLyMRvhcRuBnWK+nPqNyhzOMwtVSOI91xXnw6
	Pdzy7xnC/wPdqkf64nQI5EsK2WVBrYszeIIUDGeAmkmran3/eBhbyO4YeBNEVNQoLTNZcCCJHHP
	jpwJ4a9nT56DHLwo3IDd5ZxZFCUupqjmufqkR+2jkX53PNYV5R5uvK60I27pjxvXhE7Wtb3+ZsJ
	lU8pWS4HvlphPUgrAe3zOad/hplfb040lMumINCiXaTB0Gq3fWo4uOqhDcxUWwhHqfA+9hxLsvp
	HkB0FaU9SCB3DgUfOvG79QLMvMOyaMuw==
X-Google-Smtp-Source: AGHT+IGleborKQCrbq8DmtASF59YZO0WpvBhiHKdLlUD/UBGnoL4NMp+YZWh4r36RAtoCvyopgKovg==
X-Received: by 2002:a05:600c:45d5:b0:45d:e28c:875a with SMTP id 5b1f17b1804b1-4792f39cc82mr78538125e9.31.1764939529325;
        Fri, 05 Dec 2025 04:58:49 -0800 (PST)
Received: from [10.0.1.22] (109-81-1-107.rct.o2.cz. [109.81.1.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4792b02e806sm59378815e9.3.2025.12.05.04.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Dec 2025 04:58:49 -0800 (PST)
Message-ID: <31cdf723-a776-498b-8664-4735cd76669a@suse.com>
Date: Fri, 5 Dec 2025 13:58:46 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] kernel.h: move VERIFY_OCTAL_PERMISSIONS() to
 sysfs.h
To: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
References: <20251203162329.280182-1-yury.norov@gmail.com>
 <20251203162329.280182-4-yury.norov@gmail.com>
Content-Language: en-US
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Christophe Leroy <chleroy@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 David Laight <david.laight@runbox.com>, Andi Shyti <andi.shyti@kernel.org>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, Daniel Gomez <da.gomez@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20251203162329.280182-4-yury.norov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/3/25 5:23 PM, Yury Norov (NVIDIA) wrote:
> The macro is related to sysfs, but is defined in kernel.h. Move it to
> the proper header, and unload the generic kernel.h.
> 
> Now that the macro is removed from kernel.h, linux/moduleparam.h is
> decoupled, and kernel.h inclusion can be removed.
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr
