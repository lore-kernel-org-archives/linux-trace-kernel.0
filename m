Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2079D1A3BAD
	for <linux-trace-kernel@vger.kernel.org>; Thu, 31 Oct 2024 16:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730393376; cv=none; b=jBuXVeP2vr94g3geuDTjoes3wf/NlokT1GY30OG5vPPekt7XVad9sHyyCjdoUecSo26v9uszIooZ7/TYn9+S8kNkSsiAiUMbJxMHATkpWc8HlMBAuH/Z06lr64Emr+Cxu6+G2XYjX5JKTPWW8THtS9Qs3Cys1JjePT7yiAnO5AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730393376; c=relaxed/simple;
	bh=OSxiy8GRUoekUaEMakOMkmdOVD+6rbE34rWZ/k4TEXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ujrwBAfBgQ7hkf9a0Bf2PFh0CxNN4LkRhKK9t30Z5s7rjn7QKAvp3X5nGD/aUOxPIjozQGOPEGPjPt2fMYivXhJXAs6MNX1X8hDkEEF+9i5XRa3zU4X4ivoN/Hk/sC9GmSQ+SzYu17W/zjBDXpdvSACRwmunRtJHKUX8Ofsnh20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QCHPpQIy; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QCHPpQIy"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-28862804c9dso567034fac.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 31 Oct 2024 09:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730393372; x=1730998172; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jbNCcry4Jdp8tstQ1PAiP/N0eIT0cFTfzUZLaR5kyBs=;
        b=QCHPpQIyC8tEAKpSXXHWe0wsjPeuDgcQapL2xIwMgMghdSiViE7RNa7/KWplzJLJa4
         T+eAud0sxVUDXOcrkoM+L2XDbUj8hvX8yfQ+GSShvGYwZvw1kWLUG15m8jsHh2k4BvTc
         p46vPnVZtMe0hO3s4SP8RFsQ8nRPsqFBwsytsuTfpVXmgESKLI8IsJOGml7N1SeQc3JX
         nJA6NLnmNMXugz+MY8U+Dcwg3N5EjZTaLqfP+wsrXZ60RZrY+QgJEJrQaRNJohcnGSQi
         9c5rPYXnZaNYnWea5E7AkNkA55lXIjYTJPgYRaEpKH/nwWmaC1a6rkHaq7FwI+QnNCYy
         5OvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730393372; x=1730998172;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jbNCcry4Jdp8tstQ1PAiP/N0eIT0cFTfzUZLaR5kyBs=;
        b=g3lL6GfnMOwd9CSt8NCg/+zWBgBmPCu53h1Tkuoe8s+JH5YTliiExAcq1p9DzKkCVt
         LWCA1d011uVLhrABvjMPlLMT+cc1VO1skKSil2R52E5lskHpWEmN6R/KGtcJTOTD7y1Y
         228CQ5HQnNA/IuLY9UXYnru0fDKqgvkVFBqCN8ykflG5wlRFImOPdRixjQJx7E2Q9eED
         6FA62WVr4HuBhqf3wCBKUKVekZUFYSxKRVV3axYbQRA3AecurMCUxlLfjuk7GAwAuHJL
         qcoraY3iLVMZIpsZIRrsuFlcv/eru7JmWEX7HB262cM5jYHfOl7mzEOhxlGUor2Ox7fo
         Llrw==
X-Forwarded-Encrypted: i=1; AJvYcCX2iHjPcCKsljxuVXh6n0Ya8lYwMebYZFawY74LyWWP/xwGvIeckosu6PAPy2XXv0VXMQaub+O7ou5Pq8tzsWcQZXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YznBXvJuLhgJE37EpynYfeTQP70qpPp/2IIjaCYUaaXqQnTgLsf
	ETu7dyK+mgHOyl4x+K6BF5gInrQilxDsb1dmAfe9WXq/WEgnqQmnw0vlb2mzfRo=
X-Google-Smtp-Source: AGHT+IHbMtP+GNTrAp9Uf6Tmc5WK/ipNQKCVa0uX5AlX1qngcY2aNNmgvqKRDiyduTxjJWRwHOLcwg==
X-Received: by 2002:a05:6870:30a:b0:288:db96:5a23 with SMTP id 586e51a60fabf-2949d1ebeabmr456408fac.20.1730393372260;
        Thu, 31 Oct 2024 09:49:32 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29487772015sm600040fac.51.2024.10.31.09.49.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 09:49:31 -0700 (PDT)
Message-ID: <00b6f820-5a87-4e05-b079-281074be669c@baylibre.com>
Date: Thu, 31 Oct 2024 11:49:29 -0500
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: axi-spi-engine: Emit trace events for spi transfers
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Mark Brown <broonie@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-spi@vger.kernel.org
References: <20241031111646.747692-2-u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241031111646.747692-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/31/24 6:16 AM, Uwe Kleine-König wrote:
> As this spi host controller driver implements the
> .transfer_one_message() callback, it has to care about these traces
> it-self. With the transfers being compiled it's difficult to determine
> where handling of one transfer ends and the next begins, so just
> generate the start events in batch before the hardware fifo is fed and
> the end events when their completion triggered.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>

