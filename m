Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89782FB0B9;
	Thu, 29 Jan 2026 18:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769711937; cv=none; b=ibXfoXmv2Kv+nz2t0sW5ZV2dBa06h8PEhokSypLxZXxydKCIC3HT7ManV2dtMASFXsTn63CzDp+m9pYUQv7s4wJcTmMN9ypMVXTZcteJg7+x2wJ1bwf3Pd5FCoup3zGxltHWWWEpn8yCc3I0G7alHRnpwUHC2d2UfPglC9umD2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769711937; c=relaxed/simple;
	bh=ny9Gvuf/Gb/jBlAs2bPrNRuoaNCb/eTRmOUJABQlRN8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GYysBt0itOruHIAMXJfTYG1KbpCsvb4Hcbm0BfxqsDPKpkkTQNSgKQpMjG3tYVkrVR+VIESOOeTUe9IH3TtIVKy3kA+tYXSbQPVHTo+3hNITxCLbfTpR77Q9TJPGnrfAhB+g52z62ou1Tm/VX+wSAKyIhqm1Lf9ig5pOZTlLUsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yW2gX0WG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yW2gX0WG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=yZm7KO5pw9/R6i1YoD9nUCzfryvpA/gVSTAcmV7o7jY=; b=yW2gX0WGPYwXSQBveO5NIwlLMW
	nN2w7zkgq+zWEn6MgNKPDk6yMrZlyZtyKt04z3eWnHTXVu9/V+rp0dYxgxu/n+1o+2Vs39s1oxn+A
	npA/2DOS0bnqsilWSRwD0cQdf1h65e8VAKw+oVmLAyO/I28zp0ogSe+l7cBbo4AqHZYAtG7QrCZSc
	EFfOQ9G/RZNN/cUuD0uIeGTg+BIJ+khBmsLROnZPKurM1eNpKRsHfmoEbWtMBI8XRnAySo7WYznZw
	8pTd4EW8M2HEuQwDgD/qM+yVBx3hXMqr3pMdtvl+2cK6mCzMWasAcqHBZnsP+r2cgfXsy2qumlOv+
	7yXzfiMg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlWup-00000000WYl-1efr;
	Thu, 29 Jan 2026 18:38:51 +0000
Message-ID: <9ed4124e-a6f4-4994-a80e-860a1123c8ba@infradead.org>
Date: Thu, 29 Jan 2026 10:38:50 -0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] stm: class: Add MIPI OST protocol support
From: Randy Dunlap <rdunlap@infradead.org>
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
 <0ed08d07-5736-4874-9a0f-0f848e8419b6@infradead.org>
Content-Language: en-US
In-Reply-To: <0ed08d07-5736-4874-9a0f-0f848e8419b6@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/29/26 10:31 AM, Randy Dunlap wrote:
> diff --git a/Documentation/trace/p_ost.rst b/Documentation/trace/p_ost.rst
> new file mode 100644
> index 000000000000..df93b889eb4c
> --- /dev/null
> +++ b/Documentation/trace/p_ost.rst
> @@ -0,0 +1,36 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===================
> +MIPI OST over STP
> +===================
> +
> +The OST(Open System Trace) driver is used with STM class devices to

   The OST (Open System Trace) driver

> +generate standardized trace stream. Trace sources can be identified
> +by different entity ids.
> +
> +CONFIG_STM_PROTO_OST is for p_ost driver enablement. Once this config
> +is enabled, you can select the p_ost protocol by command below:
> +
> +# mkdir /sys/kernel/config/stp-policy/stm0:p_ost.policy
> +
> +The policy name format is extended like this:
> +    <device_name>:<protocol_name>.<policy_name>
> +
> +With coresight-stm device, it will be look like "stm0:p_ost.policy".

   With {a | the} coresight-stm device,

> +
> +With MIPI OST protocol driver, the attributes for each protocol node is:

   With the MIPI OST protocol driver,                                   are:

> +# mkdir /sys/kernel/config/stp-policy/stm0:p_ost.policy/default
> +# ls /sys/kernel/config/stp-policy/stm0:p_ost.policy/default
> +channels  entity    masters
> +
> +The entity here is the set the entity that p_ost supports. Currently

                   is the set of {entities | features} that p_ost supports. Currently

> +p_ost supports ftrace, console and diag entity.

                                           entities.

> +
> +Set entity:
> +# echo 'ftrace' > /sys/kernel/config/stp-policy/stm0:p_ost.policy/default/entity
> +
> +Get available and currently selected (shown in square brackets) entity that p_ost supports:
> +# cat /sys/kernel/config/stp-policy/stm0:p_ost.policy/default/entity
> +[ftrace] console diag
> +
> +See Documentation/ABI/testing/configfs-stp-policy-p_ost for more details.


-- 
~Randy

