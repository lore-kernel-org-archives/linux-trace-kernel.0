Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD46337B9A
	for <linux-trace-kernel@vger.kernel.org>; Fri,  5 Dec 2025 12:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764939098; cv=none; b=DOTgjjj/vdmCFRO8vGg4VbjLXYJqAfIWF5hTiI2K6N2PgJEuskyrkjySuHYgYUBoHpT6N7nu51NytyiK0Am+xw6zIV2QV/dqvhvpBVoYsgShu2sMMoOvsVd9GpEpP0zEGxXw0BpltxJyKmcTMZNrYo9czvAupEw7FL53E1wjr/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764939098; c=relaxed/simple;
	bh=O2r5wrCl4s3mj2Q0Ka25Nr6a0JvqNX3Ja1kWgpZm1qk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Q3vRvjRlIZz2OjZwGDtNVm5CXKL0yiWu7euSTUNzBinlbG+Ct/2BDpdQ16vvsiX5uMOVQ02U0+hztbntbRANUj4YVBNvsIiru8ioFwqVgxPsZBuJMGIAKvyGrXvDTQjEMdPNO+BL9GlY/+RSr5yzLJFgkKQO5DCxi7c9u8RcDRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MqVl05lK; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MqVl05lK"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42e2e3c3a83so998815f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 05 Dec 2025 04:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764939093; x=1765543893; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9MzpLnNl9vvJw+1q+qMx3EcEk0gQb02lA2SLfXsZdJo=;
        b=MqVl05lKXg36NAU4jea8HgQRuyQYObwZ3lE8c7FUiPyhDdrrTVt4a1jfG791cclolM
         QRgkt7k6V4Dyahe//DJTMiPu2trZqgZdaoeAMgUHCZLxGJD7I51wwUZUX8aMonU+H+YT
         pP/Uvsf/u9E3ZdL6EyxiJB7IuyLUERBf3Q2x0erfYZg2/gQAUywXZDRGYZI8nsuppmvF
         MtGWUZLXLrcn4jldcACWn7sWlqqazJKoNRmSiVCCgt8lB/ouaNyZgWm6s4NEFZNc7Jwn
         DBV856OQ99O33ZYZdntSJvEOJ5zjA9kfN9DLEvKugVEaufqLpyMW/Fp7B0gHXtmaKGAN
         6sDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764939093; x=1765543893;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9MzpLnNl9vvJw+1q+qMx3EcEk0gQb02lA2SLfXsZdJo=;
        b=KAaivLFos0bIzGL8x/Mh+Dv0BrgGF+JdcelCArM+PM8bJKJziESgjFPDVJV0hmUp0Q
         5P6ZcjLNrAP8pBTIYA7J/er+LN7RBq/9kpiZ+JN9iVHqK2kOrJWwXlh0yrYCQUGNZpf+
         kCudnA6sIGRmt0JCCDxc+KhVGGD8YLqD0NNLeJEHC2aK8BAmPFchgG/DM5GQV6ie2vZM
         gkFQISAN1kvq9OAJnkvUobCu9KxpUHdIRd/TiB6jIt+tVLH0j9N9snIT+6MTXsL6HnQH
         7ds9kC6W4MUA9I2pQ3QbN3Ujd79cdDiPrkYA7Iq98SFCxu1pYWBYti3RYAahTq4N8gf/
         em5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWXUcDPhB2RicUDH31IWyNxG48A/22mMNOA9rWp0m6sd1fUaRqOMgspL0rQUKcQBSqpgRUu0yIPcvaJEnReztqijLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTpVZC/fhFt8vJcYs7BvK373LBvwEAM0G2cV4xlLQIxBhcDHfj
	J0VVgNXIPP5lk5yOqLfzVK8RkmmZY+Gt2cwaqncNNavpkxkRvBcwClWxqfyVcqLFu+0=
X-Gm-Gg: ASbGncveTAv1H8IBagWPO0LFquPz0bUkJJRXTQi4yCjkkLyj4rhls//u199DFRJj3c1
	haboYN8uxCXZuNUySmB3fsGs3+j3oqeteYfC4aekt4avrr55M69OioV3/h4jUXYnW0qF4QseR6d
	X8tR3PDEUi3HbYwEOMmDIGmkmR+CXGYLnaarEWyXFSsuMZ9FSMM0toYgVMUS8K5ZA3Bd2b3Vai6
	dFW0alB7xiI1Z95mL8bWR/ZYWKdXcEI0RwYxhPHdfTtdBJQVyPXLtuvvdNp1yw6RgkLhMudu4+E
	mLMGqOnVGzR614XKsvM4mzMIYKoNaxKzuJY9+rylYwy4FlHxmVFm+pMvp6kwZ1b7TFJoDCsAg4N
	P1EzIbUXlMJ2U5f4yJn4Rfb/mbqXWRXLXPn4rX0ZAuGIu6iDYPdPhfvYotZe4W9zANh0AmvyqhX
	xvtiVA64L7HRelgVnH9kOzudlpbBwzVA==
X-Google-Smtp-Source: AGHT+IFF2YOP1yOKobPpwIABM0ALpDzm5Ux8rx9pH99/QlqE0Zty3TPaCCS2gXj6vJWnXG2wdtohyQ==
X-Received: by 2002:a05:6000:18a3:b0:42b:3272:c4a7 with SMTP id ffacd0b85a97d-42f731a2e9amr10500166f8f.29.1764939092550;
        Fri, 05 Dec 2025 04:51:32 -0800 (PST)
Received: from [10.0.1.22] (109-81-1-107.rct.o2.cz. [109.81.1.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d331af5sm8375239f8f.31.2025.12.05.04.51.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Dec 2025 04:51:32 -0800 (PST)
Message-ID: <14cffb34-1c56-4119-af76-e8ead8099a9d@suse.com>
Date: Fri, 5 Dec 2025 13:51:29 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] moduleparam: include required headers explicitly
To: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
References: <20251203162329.280182-1-yury.norov@gmail.com>
 <20251203162329.280182-3-yury.norov@gmail.com>
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
In-Reply-To: <20251203162329.280182-3-yury.norov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/3/25 5:23 PM, Yury Norov (NVIDIA) wrote:
> The following patch drops moduleparam.h dependency on kernel.h. In
> preparation to it, list all the required headers explicitly.
> 
> Suggested-by: Petr Pavlu <petr.pavlu@suse.com>
> CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr
