Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6565413959D;
	Thu, 29 Jan 2026 18:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769711525; cv=none; b=mWiXkMUBtFlH+pAVwT2qCwrsK7kMJCeGE3+SH1eAi+5xBFKm5A3U1l0yJZT5A80vnJZllokQ9DmSidoX3noFQ3asCiGSxSmF+e7meyG4bIZFXZDl9zIYDysxhKgVLP6cRwZ7WtMZtyDufQmJe+cIV+zLCzWkITGCV+32rRtsT9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769711525; c=relaxed/simple;
	bh=PsOP6lOw0ECkEmj9SjH/3zv3jpVAeo5fO5gxkZapEi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=olQZCZBb6w3P6AQTHrpcJWUhXzIxvWkSUmJiKH1orw658/GNAYaRtlvyWdpXHgfcEMoTbmmxW8a9Hd4Nbp0CnkAoeaoNwtxhGpX6P+fxXWzNfTrCV1dq/xsU3u2aEoD2rNDX5GtTfCxacLPA7Rao5yuVzSaT0V274wWCUp7ZU8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OdaVR5gJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OdaVR5gJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=YGRHN0NuHwElPQUY8BXhrl0wGLg1RNdWY25QjXUQOmc=; b=OdaVR5gJx6pc0tyvMig3CXe2Uv
	c4Wgc4spSdcGCFHRJKbtfmqGLXmP+ip99uAk1kyqzprlh9CYlGkVeUdngcFQvteofNTH0DYF/FqPH
	D+ZFVyJ17aYY4sLASwxwIJiyJ7ttACh9Ekr20H3tlz7yv8xXwacW0AVGu9v+bIhUr09fiJk2lcuW9
	V4k8qISvnAOH0C460FKJY1kKKto5AaOI6qZF/iZSG8AVkqHNF2R5PY9xcf06KSAfRxDgyCOEQkKjO
	18hrPAQ88z65+wegtKGdKo2mNetw5SkDhDTaR04P7zI0iKoQbO619uIrYSX6YDYAyXMprnKX5KEEX
	izI1Gvig==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlWo1-00000000WJV-0iC8;
	Thu, 29 Jan 2026 18:31:49 +0000
Message-ID: <0ed08d07-5736-4874-9a0f-0f848e8419b6@infradead.org>
Date: Thu, 29 Jan 2026 10:31:47 -0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] stm: class: Add MIPI OST protocol support
To: Yingchao Deng <yingchao.deng@oss.qualcomm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, quic_yingdeng@quicinc.com,
 Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
 Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>,
 Jinlong Mao <jinlong.mao@oss.qualcomm.com>
References: <20260129-p_ost-v5-1-2b14fff39428@oss.qualcomm.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260129-p_ost-v5-1-2b14fff39428@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/29/26 6:25 AM, Yingchao Deng wrote:
> diff --git a/drivers/hwtracing/stm/Kconfig b/drivers/hwtracing/stm/Kconfig
> index eda6b11d40a1..daa4aa09f64d 100644
> --- a/drivers/hwtracing/stm/Kconfig
> +++ b/drivers/hwtracing/stm/Kconfig
> @@ -40,6 +40,20 @@ config STM_PROTO_SYS_T
>  
>  	  If you don't know what this is, say N.
>  
> +config STM_PROTO_OST
> +	tristate "MIPI OST STM framing protocol driver"
> +	default CONFIG_STM

	default STM

Other places where you may have seen this (and copied it) already have
patches.

> +	help
> +	  This is an implementation of MIPI OST protocol to be used
> +	  over the STP transport. In addition to the data payload, it
> +	  also carries additional metadata for entity, better
> +	  means of trace source identification, etc.
> +
> +	  The receiving side must be able to decode this protocol in
> +	  addition to the MIPI STP, in order to extract the data.
> +
> +	  If you don't know what this is, say N.
> +

-- 
~Randy

