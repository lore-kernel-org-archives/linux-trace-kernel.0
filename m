Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2056D4718D3
	for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Oct 2026 04:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791866484; cv=none; b=rZvYKL140XnWJt0O15CllXd2gCwItgYeGkldxyEend4aKGPNH5o11T9ym3ymfvi7dC5ohCY6/ktnYGQD4G1lDajDxgZHRpYbk4bVZ2HxFPKc64sIih3U4t37EPR00lizpIDycqfIRP0dy1v2YhBlLgyaInqjTMqg3v7hJ09YVgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791866484; c=relaxed/simple;
	bh=1FGBCYpqoaQP7nZiD8Xk1Vj+UllHiO8jYhYyecW+KwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aT43/BMe/5S8ZSAH82MQbxZc457BO9wk4ZQlnYTLV4dDcoTFQknu4kyGdeWTPLnqPGVf+2NSJR8IFUvN4f9uMtByBTLot58x/XxQHD6o+JK+lB84imwpUFb7gcM9bEfktVFzuMvzhuex5/mwSu9eaDSjRJKYVFRHu1HJtS9Om0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tBYMcNuO; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tBYMcNuO"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3514b90bb89so4788336eec.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Oct 2026 21:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791866482; x=1792471282; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ANl3PjyWBokYmlAx9rJhimSysaOK4KYpgUnncCZm4Lg=;
        b=tBYMcNuOsl6DwXh8T8YdAzzSQ4QzijrLaUpFZha+KvP3jIkn4JXKU4+WNR43gOFzn4
         8ZUHzPbrrHO5PiMt27N5Tvb3SvesP+NJE6AOUBjybjLl9rQkd/jQTP52ZpgU0EU0L1HN
         Bbp0mtyOFjq3EbcDeYL9WzO/r8edVasNdvOYeQSjVoHxIelt8DNt5IumOZtai73SPXEh
         lzIKmZ3VfKJTSypBe0WlGS6OaT1GSpJwyc4j7YvP6gz2c1niQtV4hZ4DjmI97/2Tbiwo
         fhm9HsCLl85fA+t0ZTSm6trhRJkfngypo5P+IVT+cC+vDTVYgkhupyOTAszWDpjV+7e8
         /Lpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791866482; x=1792471282;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ANl3PjyWBokYmlAx9rJhimSysaOK4KYpgUnncCZm4Lg=;
        b=GCGE+ZW5hC+uskZZK7MPKjVNO85MhaSCjiUDS9KPpV+T98OMMD/2w9z1bxpX/Jr6xR
         o65PhwMI4HVp2YwOGsmi7I29xzNR0FIe0fmX1+b6PIixacOQjTBXrO3SCEzY4SSGCWW4
         hKIxoJYaIwFyuZTmaATdJNrWYNmvMcMMOkyIOCfVt6zZAAmJsq1lcxKZj7KoeYwZEtVz
         PpXKLtBH19I1/5RhkHxqdYzqtcxLsNrk7ZnJuxYEqFgFryJFzJHoJ95KPem4E3W7oL9D
         GszfGIE0mpiEIbRnAmXYaKbZBvDVwRtvklXRyNQ5R10fCpgBzh5MTEe5WpDHRzRNtPts
         EApw==
X-Forwarded-Encrypted: i=1; AKwUvBwYDJBgxrCigH7qPaxPxWrutEKXSwk7ep2KaxQqCai/4ceum5TxoHKOVcPN5nJEasgHASC2mMZyfHoIYOaLlf8SMaI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIIZVe4NlQTegoxGC+sdLMXVGTBvCNx8ZZieseo7GkE5rJWhI/S
	lylxQ46bRZd1p3rXq2oYH01000tNHp6Z3vHQnWQSVtFQ3LMAykBytVHG
X-Gm-Gg: AYBFou3XENMWfLnMyqVFaHvMJ0p+IlwWZ4N7NNzczh2uvWxBncfDzR3MF3Ub7PYAEVz
	TX1/MDUsgDT9avBkyV50Vu2b6wedSpTEfX2iVIrGQuowH3J+XwoKCYqdIQ5awsKwb8ETGv1CWoY
	zXdq1T0Hjdv23s+ZkBbm0q+IEEn2rcEnNQpFr0UdH9IyfFnr3mc081sBe7u59WkGGzytpk+EbFw
	WGiENEkPG1U+L8gRWuxU1TGT2tjrLbQeYFQdN6qdLkIn590v3JO1PCyvE3sy4BR8cIL2uGi+i/3
	if7ZrRS167yfuO4D9WpuD/tv+KbhOtTVmnh/d+ld0tViTUItVDrdMS9VPTvHBIwxBLwtKB5OqN+
	ldaxQC5NZIdcinkHsm7BTb+FdWfF3AWXwCazcTA/aTgRw/9QGnuHFZTp+WXMqzFKOhau4rn9fgM
	NwMWp1J+ga2T0Yue1/l1Fks0lgqBsvydw0gHq5RpZjqIyxxl3bgn9zaM425I9uOSqtrGbd9uK7F
	NHYUh1sRtn5AQ9nFLkj5fe4OvdEjStW/oZr
X-Received: by 2002:a05:701b:230c:b0:14f:5cd:f286 with SMTP id a92af1059eb24-16a6203dc73mr17576796c88.34.1791866482064;
        Mon, 12 Oct 2026 21:41:22 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c43:7890:582d:8daf:d401:c87? ([2401:4900:1c43:7890:582d:8daf:d401:c87])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a442956asm43133349c88.16.2026.10.12.21.41.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 21:41:21 -0700 (PDT)
Message-ID: <8ceef81d-bd17-4910-af11-699318691c23@gmail.com>
Date: Tue, 13 Oct 2026 10:11:15 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] openrisc: Add support for KProbes
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
 naveen@kernel.org, davem@davemloft.net, tytso@mit.edu,
 wangruikang@iscas.ac.cn, namcao@linutronix.de, pjw@kernel.org,
 kees@kernel.org, linux-openrisc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20261013042255.7DF701F000FF@smtp.kernel.org>
Content-Language: en-US
From: Sahil <sahilcdq0@gmail.com>
In-Reply-To: <20261013042255.7DF701F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Masami,

On 10/13/26 9:52 AM, Masami Hiramatsu (Google) wrote:
> Hi Sahil,
> 
> Thanks for updating! Could you check Sashiko's comments on the series?
> 
> https://sashiko.dev/#/patchset/20260930203129.51048-1-sahilcdq0%40gmail.com

Thank you for your reply, and apologies for being slow in sending an update.

I have seen Sachiko's review comments. I am still working on getting v3 ready.

> I need OpenRISC maintainer's review for this series too.

Got it, that makes sense.

> Thank you,
> 
> [...]
>

Regards,
Sahil

