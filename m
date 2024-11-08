Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E761E104F
	for <linux-trace-kernel@vger.kernel.org>; Fri,  8 Nov 2024 08:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731055119; cv=none; b=InFqqLJFKZsbGXA9qpTyON5SLi00lu/Q2w87fREsCpRiLSgGUeug053Fgfb+eosZiFCrQTdlxKhn/YOcZ/UFviFDg9Rx/upflErYzxMrZBuzKK1sg5mQeeL8CNOHXUoQgjY9rokP3H/3YAioi4dXYG6jmQEwxVJQu/wPsDgNEKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731055119; c=relaxed/simple;
	bh=3snwBfOluaLLaBqMW2z9kpc27Gve1ktkYY+R204mCq4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=na+hc+rOmksp4CtJ/6qIotbyIN7W2xn56P99cmCtVRTVwXQd5q/e+YuHQdzAHKhxJ6byIpEnvp6BRBQbOWntnGsdBiDBf+u9tYkJgXrnvEOG2iWYCS3+7RVQx/7GUL7xN47Vv7t/8RWYYX/4cR9NrR7G2ISFQnRUVBBCVgVSKeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UM4Dypdy; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UM4Dypdy"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4314c452180so16946875e9.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 08 Nov 2024 00:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731055116; x=1731659916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTOcfwig0PKFL8PVkUy0lEQsorDf8mUsKxkvyFmWiY4=;
        b=UM4DypdyBgOQYjOrIOPfFNzamvTmhwTA/4T/mNTEPVuiUep4Wde9nDi96/ceSMXjB6
         CboQV/hx25WrI1lEn8cFuP4qb4RWVmcEtfSD87MSodrC08AHnKD0zNw/km4d5Cd5yppX
         8QPfGV4QtoFIWVYnh6XA14TavLjvU4pOUwX0vyHWwy29ZWe2rQ4F4AL4mt0b0ZfJDi+3
         HrJluZu6qwxdApcCwVJaQS8WXoW2wlme3bYdmGm3NdcQ6m2WE1uNgWMNgxpZstTNH59P
         OB+RxLYG7Qku9fu4N4Y9T8WUL6OKFNZppyQbRi/pvVPk8SE5zpEdWGxL9vBR+2fA9ROc
         6ysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731055116; x=1731659916;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xTOcfwig0PKFL8PVkUy0lEQsorDf8mUsKxkvyFmWiY4=;
        b=oLWIoMXC4uLtqeNVWuUcSA2ZLvez7rVpUDjs68udUkVI572QsMbPhMqE2FKqnMyDvT
         615yqdTkJ8Aqg7Z9dAA6OIDDeP8DtZ6RNflp6Sws1sBj9JPaMieNEuPJ5WyNc+dHgwaG
         1n6omFfZq5kETqCMNsTiYH/gU5C9+K1KIR1YufHGewtzW+tzyOaBsK7r6QDSDsGoHZBm
         isYyXByiM6n+UMlRDHNVd2brSzoJQMU7po0JjWrAi/I3sYaJjlHN1nMV9dc2V3Ps1hcy
         5NmSgoKPQjzMGjpBRi4YkwymqWF9C6sFc6fuuPC0RXKjB02CUQUKVinWj3o5J8m3J94z
         Yu1A==
X-Forwarded-Encrypted: i=1; AJvYcCUiiDVoKhgYYFxNgIry6+GcD9p1WpiHP6z0aA7S++11wbwD+2i5qHddrAtqc31ksZ1tVmHOp8c8Vk79UwzmniFN7Gk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk/7ZVqSLxr4RnVF/0fK3f/Pqm5AWhkRf0VjhzTRdTiVBQEmN5
	IUuwFQR7X1b2nSYF9/WAQ5ak0UylJaVWvfaLMVUezD19cfapOB5h8IWbH3b2eaE=
X-Google-Smtp-Source: AGHT+IGjJsYkKtS++GK0c6xcy/PKYqPkLYH/DrLydQt+yXOAMvFiy8YV5KZWq/ekW1oi9PjQAEWzfg==
X-Received: by 2002:a5d:6f1b:0:b0:381:eba9:71fc with SMTP id ffacd0b85a97d-381f1c83b8cmr1500678f8f.19.1731055116277;
        Fri, 08 Nov 2024 00:38:36 -0800 (PST)
Received: from aspen.lan ([89.101.241.141])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381eda05f89sm3889986f8f.98.2024.11.08.00.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 00:38:35 -0800 (PST)
From: Daniel Thompson <daniel.thompson@linaro.org>
To: kgdb-bugreport@lists.sourceforge.net, 
 linux-trace-kernel@vger.kernel.org, Nir Lichtman <nir@lichtman.org>
Cc: yuran.pereira@hotmail.com, jason.wessel@windriver.com, 
 dianders@chromium.org, rostedt@goodmis.org, mhiramat@kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-kernel-mentees@lists.linuxfoundation.org
In-Reply-To: <20241028191700.GA918263@lichtman.org>
References: <20241028191700.GA918263@lichtman.org>
Subject: Re: [PATCH v4 0/3] Replace the use of simple_strtol/ul functions
 with kstrto
Message-Id: <173105511502.10030.8958584403113767756.b4-ty@linaro.org>
Date: Fri, 08 Nov 2024 08:38:35 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 28 Oct 2024 19:17:00 +0000, Nir Lichtman wrote:
> The simple_str* family of functions perform no error checking in
> scenarios where the input value overflows the intended output variable.
> This results in these function successfully returning even when the
> output does not match the input string.
> 
> Or as it was mentioned [1], "...simple_strtol(), simple_strtoll(),
> simple_strtoul(), and simple_strtoull() functions explicitly ignore
> overflows, which may lead to unexpected results in callers."
> Hence, the use of those functions is discouraged.
> 
> [...]

Applied, thanks!

[1/3] kdb: Replace the use of simple_strto with safer kstrto in kdb_main
      commit: fe0c87871fc0b97f6d374b670c81f7c4087eebc5
[2/3] trace: kdb: Replace simple_strtoul with kstrtoul in kdb_ftdump
      commit: c56642c737fc0bd9bcc3a22a2bf8ed6f5900a660
[3/3] kdb: Remove fallback interpretation of arbitrary numbers as hex
      commit: 5f4ca702e36893a276fccb0aa55ab36e19dfbb50

Best regards,
-- 
Daniel Thompson <daniel.thompson@linaro.org>

