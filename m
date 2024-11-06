Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69491DBB13;
	Wed,  6 Nov 2024 09:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730886923; cv=none; b=KbCdJGsKBaHfLXgdkGPX5s3+K6dATeiLLwtwk1dTzy2gRGob7sC/9JZejXUhvjmGSan47M2QwxKyDgYEbI7mvlsqNMw+1SwBPsZhL52w0oGGgekty5DJa4zYj2KC/498urKQmpMIwm2Zq3ymzI3fQ7g77WOlUY6gFSSXv5Nbwfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730886923; c=relaxed/simple;
	bh=7Opzae6eJxnPKWoay/5QnazLgTYEphKcrHcvH2svUe4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=F8TV+AxLM7bqJmuR/daVfNEfxlOalHZ7/RkAgXLrrGfU3AT7uBT8M5+mUJI8Ma0fw57O2RPgJ/IM3KdtJFDGCduv2FpvAOIc/e+YdOz1qOjVWybLWXdJpPeAaRr7sQxKEojUgARc7ZIk9/aYmWdgK8dBxkhVSJWmxdehDwNlB4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Xk0rx1sg5z1jxjs;
	Wed,  6 Nov 2024 17:53:37 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 198391A0188;
	Wed,  6 Nov 2024 17:55:18 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 6 Nov 2024 17:55:17 +0800
Message-ID: <3d166642-4062-42ed-9e24-1771cd819110@huawei.com>
Date: Wed, 6 Nov 2024 17:55:16 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: uprobes: Optimize cache flushes for xol slot
From: "Liao, Chang" <liaochang1@huawei.com>
To: <mhiramat@kernel.org>, <oleg@redhat.com>, <peterz@infradead.org>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
References: <20240919121719.2148361-1-liaochang1@huawei.com>
In-Reply-To: <20240919121719.2148361-1-liaochang1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd200013.china.huawei.com (7.221.188.133)

Hi, Will and Catalin

在 2024/9/19 20:17, Liao Chang 写道:
> On 09/23, Will Deacon wrote:
>> However, we should use __GFP_ZERO anyway
>> because I don't think it's a good idea to map an uninitialised page into
>> userspace.
> Agreed, and imo this even needs a separate "fix info leak" patch.
> 
> Oleg.

Given that Oleg's fix info leak patch has been merged [1], the risk of leakage
is gone. So I am looking forward to your options about this patch. As many
functions start with same instructions like 'stp fp, lr, [sp, #imm]' or
'paciasp'. So I think this patch could avoid unnecessary D/I cache synchronization.

[1] https://lore.kernel.org/all/20240929162047.GA12611@redhat.com/

-- 
BR
Liao, Chang

