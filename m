Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71BE3FEB16
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Mar 2026 14:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774450763; cv=none; b=i0SRsN1FcaH1URMcVoh6sd4fUXn0aXmEt1A1Sfacg1Q7Uonps5I7mFU/SOgjsNayw8AcfxX9Go6YOSgpcN+VxPbYnoClznENDzFmoTSYeLNnNmjKzfro5U2XaJOCgjG6YgtZZ/96KpQUQR5iGisnSTm3i59Ye34dAcdGUoejSOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774450763; c=relaxed/simple;
	bh=p1DLT+wcVdLj/4Kmiohl8ABr1NxTDIzvs4lo/8S/GFs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Z4YP5qyfnuDj0oUAd1cUdliT0rN6INcrAFqUcHX7pRi867BLE6PDprlJbqJDSxIFLc77AiNblC8q4egyK+9T8k9DO109vpb6N6K3Z6tJxV3bhNB9dd6RHoJ+bcLBuZjIdvS4Wce3MvgaJvBQzuzz3SiFQEV+f9h+G3igxlRZQ1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MPkD4A8p; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MPkD4A8p"
Message-ID: <faa5325e-d494-40e5-9dd4-0f6a3fd35432@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774450759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mkRNSjbt5Dyyi/TeRAXrELDQ+rMi5AQhi99mKqQMC9c=;
	b=MPkD4A8pSL6UKpO19vbDlsUgVeIppyxfuQN69ychRKlnVOa4RiT6TLZzvpczeMC9uTlhLs
	4DbGQu6W3bjN0df+lURLv5PR0Y+FMNY9JvSogRfcK9J+ITqG49RH99rHz0sC0pgt7ZtnNa
	7345VeakWtKVc+41nS0s2jxiwjSdKiI=
Date: Wed, 25 Mar 2026 22:58:46 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCHv4 bpf-next 00/25] bpf: tracing_multi link
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Hengqi Chen <hengqi.chen@gmail.com>, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <songliubraving@fb.com>,
 Yonghong Song <yhs@fb.com>, Menglong Dong <menglong8.dong@gmail.com>,
 Steven Rostedt <rostedt@kernel.org>
References: <20260324081846.2334094-1-jolsa@kernel.org>
 <7fc7e5ad-ac42-4c7d-8314-bd252f8887a3@linux.dev>
Content-Language: en-US
In-Reply-To: <7fc7e5ad-ac42-4c7d-8314-bd252f8887a3@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2026/3/25 14:42, Leon Hwang wrote:
> Hi Jiri,
> 
> Nice version for tracing_multi link.
> 
> I hope I have time to add tracing_multi link support to bpfsnoop, and
> test this new tracing feature.
> 
> I left comments on patches #13, #24, and #25.
> 
Hmm, sashiko's reviews [1] cover my comments on patches #24 and #25. I
should check them first.

[1]
https://sashiko.dev/#/patchset/20260324081846.2334094-1-jolsa%40kernel.org

Thanks,
Leon

[...]

