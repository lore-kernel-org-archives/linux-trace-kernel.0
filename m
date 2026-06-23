Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1783537F7
	for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Jun 2026 18:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782239513; cv=none; b=pba/HFwP7tcgQTmEQHH+qBVWcfPdGy25r5jvY50nEqbhCaG3C3w5YG+R6jw0gLNh8QISV2NNNyZu/ugCWwlWjDwkCaNRFyE4X7SDTZloDE/GQIWW9EP5K9cgT+fo5GThtKZljIc3WWWQ2hLoN26Mbbmf9kYq0dxVA6mDP3FJKmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782239513; c=relaxed/simple;
	bh=a6v/lpFeLkHnDu+IGa4zSrsn/mm02YtnvEpTbfS3FQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OzggEVwgoKh6vDoFPo2NQ0JT+ChdalIQ3HIX2KPcYop7M6UCU7Ng7ydi7pPeXhnguw1wafzJgRHEIpDoztwOPgk8V/GGvOPVKh0t+gupwH7A9HMauQ8BODRjndDaMPIu3WuTHobRAnK4VXn7U4QkIpdo3RPABHrrigSZGvVYSdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gASq32cQ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gASq32cQ"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-460662fcb4eso163315f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Jun 2026 11:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782239510; x=1782844310; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=1WzoRhsusRl0gQfys6taa/vq131osq1TZkHvUeTyq2k=;
        b=gASq32cQQnOakdWdGAi4RKCu9gJ4gOgSadpTO6u8yjQhIeI9UkJLK8QVemzr/zH93r
         G9/KCwzJi0U9+L3zXYGQL/tceIXVLwWamlL00Gs4zvoEk8O1fnBfmOOuHynOG1SfxkyO
         SUCsf2A2TWUGeAdKPjfAn/nf+SQfYbLH0JCEqHBuy/fPBqHR/+ato5LVhdTS9r4cOtYv
         zJoQ3LDFNBxpwKjlTciRlPnNeNyOKeRANt8XnIrWTXVNsQvx/BDSV9vgwV9S0T+XY0kF
         0Fo3QnXiPTQM0OuTOs+c71C/EZeQBQnasKVwleqBu1m2XGTIvIpSGbDACuDh1mZR71Nt
         5Grw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782239510; x=1782844310;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WzoRhsusRl0gQfys6taa/vq131osq1TZkHvUeTyq2k=;
        b=b0JqJU/D2gqA9RLYvgF4AfXg2RBdGB5y6Ya4hDaK3QNSH5poQ04Qcwxep6sGk5QrNq
         myP62Cokr5GazXWcIzKaxVp/DiSnb+RaUGBEHgEJM9zErOKIncTy0Ni6KweQqd949x4K
         zGeEMuyxsSpcvWmAFk+P02PDwvmXRGA79oWq/k+TbqpLI1Vdw13Z2r8XK8GmdtFxMsXh
         N6XLkebRYyE0EogAUfdm9tOsZxUAHgKSRG4xpeWgXw7SMKsy+wy5gAzCQhnn3llOVIYI
         Wtd5tXhgkghhs7/zWNGUzZa6aqTNuXLA7huUpN2DaX18TRGTsbt3zYF1+GNdzFbpC+1+
         OkBQ==
X-Forwarded-Encrypted: i=1; AHgh+RoiqcrRAZsznb+lCS19+yjcmlj6bUO48zbyS0oEw4gOQ5i6LQqIxkYRXcRZ5v86SgrBt4DiZnpzegvp8ZN4tdGHDh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKlNsF7xeS2OmYgzawph4M1FJ4ryyy6EPBDo7pz8oht1elKrq1
	WNAV+Y+N3Didxu5BkHihls/YUN/JuWcEZCqqoUaVrYnM3Gq2RyDW9t89
X-Gm-Gg: AfdE7cmq9tWwoIJn3KEel9ZYFlOguSm6X5mcF7o0axuwwDBANM5QFRGJ0yxGZM0par4
	zSZXIJAZ1XrdoTZQBw8SFj6Yfig8L+ZJageOyLVcU13ZtfuHCvAraERTIUFZNDK80HhcWn7wLQ4
	INaT5uIAQW7FxvEKACruGKrPKY9I9910MP7eOVS8itPrvFid5CriwzytyXWFZ6z5j/rEq/0Yi3a
	7xu7yKAmW4hNMhoXi8xdCuzYiqrta99f+N97z7iLX9JkVFrX9A2PgW/Quw0o4Yh+/jWrV1VZOf8
	YdaT3mhYMzdWL7yiO/Xoqe+lUaMsScmCR0jIXT9qX8Ftlipy57cdPllsuImz9h2sbJ7rbrtS2PI
	xHpCxA2kPLKAE1XZCGIEZGQReAkwtdjwcfh5G2qo3Slc9p7Q2+HVNAO8igTFMzR9LPT46Rf7IQa
	/eYDFGnsOz3d+oEwrPbun5dD0L8FFw8a9qvomQBOnNmPKAXlKNx9RUj3enFypJJ80K+GH09kC9t
	X34WKNv
X-Received: by 2002:a05:6000:18af:b0:465:767a:3a15 with SMTP id ffacd0b85a97d-46c0a670fc9mr2639f8f.18.1782239510389;
        Tue, 23 Jun 2026 11:31:50 -0700 (PDT)
Received: from [10.128.11.131] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46666788282sm55782307f8f.17.2026.06.23.11.31.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 11:31:49 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <96b043ed-c527-4e5d-8eb7-631805da53fd@gmail.com>
Date: Tue, 23 Jun 2026 19:31:47 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/10] tracing/probes: Support dumping fetcharg program
 for debugging dynamic events
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <178217904992.643090.15726197350652241270.stgit@devnote2>
 <178217907822.643090.14693478306190628970.stgit@devnote2>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <178217907822.643090.14693478306190628970.stgit@devnote2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Masami,

On 6/23/26 02:44, Masami Hiramatsu (Google) wrote:

> +config PROBE_EVENTS_DUMP_FETCHARG
> +	depends on PROBE_EVENTS
> +	bool "Dump of dynamic probe event fetch-arguments"
> +	default n

Sorry, kconfig nitpick: could you match the style used by the rest of
the config options in this file? E.g. the type and prompt come first in
the list of attributes?

- Julian Braha
