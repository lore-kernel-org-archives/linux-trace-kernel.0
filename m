Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C2226ACC
	for <linux-trace-kernel@vger.kernel.org>; Thu,  9 Jul 2026 17:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783617235; cv=none; b=kd1EzH3q+dlLzC9BbTngmSn3e9lj2Q+LErrFvqgx+fGlj8A52H4h1UzQWEQZ6cRT5b2Aa4bNR/1qjIEFbClK9GLiE2718k/yfgR5Dj8aEP22HNYOCGZDABgal3mCsXUW6D5Pd6XTJR5B5GDV4C3okP+DZs56UhcRGw127HZwLh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783617235; c=relaxed/simple;
	bh=wKdInNGKfd6h05h8yzclStbfyGbbr+QXPI4+u78zO1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FP0lUptY41Tdi+OxiG6C05VsikDibTWqmJ5IKIYxRMq0/X/FiwcfcTgEKflSaPNojxvYUCZ/pUP6Eox7XxfvxhLqmjDwN+0s+ARN8dmAlVv1spl02YKbjeYDfklVWw7odooykhb322DmzpGNffArQ8nL38iehE+bmi4i5jCd+w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qrcOs4vI; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qrcOs4vI"
Message-ID: <77f7313d-83e5-489e-8c98-6299ff823db0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783617231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EJX8HOT0YS88Vvdu6r5d4zb+qSJWdm8PlYIke5cWYgE=;
	b=qrcOs4vIojF92VFL/HHluijgYtg8HcR8e+If+9kcboLLF4I8JTCfaUlM7Acr838UXXlzPe
	IjI3Y6ALXkdORF7MDVD94djVz6TW9YPNRRfsiyCpNQfSwDwhzhdE+94mQUZn6+3Yyb0Jte
	cCGoaUVVGefiGI6XIy/N29qjBtafQ/Y=
Date: Fri, 10 Jul 2026 01:13:43 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 06/17] verification/rvgen: Add selftests
To: Gabriele Monaco <gmonaco@redhat.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc: Nam Cao <namcao@linutronix.de>,
 Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
 Tomas Glozar <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>
References: <20260625121440.116317-1-gmonaco@redhat.com>
 <20260625121440.116317-7-gmonaco@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <20260625121440.116317-7-gmonaco@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/25/26 20:14, Gabriele Monaco wrote:
> The rvgen code generator needs validation to ensure it produces correct
> monitor implementations from input specifications.
> 
> Add selftests with golden reference outputs covering all monitor classes
> (DA, HA, LTL) and types (global, per_cpu, per_task, per_obj), including
> optional features like descriptions and parent monitors. Container
> generation and error handling (missing files, invalid specifications,
> missing arguments) are also validated against expected output.
> 
> Acked-by: Nam Cao <namcao@linutronix.de>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Reviewed-by: Wen Yang <wen.yang@linux.dev>

--
Best wishes,
Wen
