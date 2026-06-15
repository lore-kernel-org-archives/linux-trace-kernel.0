Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7F13C5542
	for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Jun 2026 08:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781512101; cv=none; b=Gy0DqubJVtu7DO+CuCsZcn6zeiaRUHk04n5JrTfAjP2GV2/yPKo9x7DhCXhzIUzUVH9peXd9j7lmvlBdvvyFkFPh5KULyllUInJ4rK7jwVGmvk3hqAM+IylIWa6ydoxl/3jz+kj55AgvtjRi2R9JzAz47AjPVBfls29L3vOeJOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781512101; c=relaxed/simple;
	bh=pUPLBCg8NrCsW7Svk0ZQ40eOxjlfopfppmuFtnwA1h8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZF/IOQQgbXO+3aK1C1CP5la+61RBaw1USWCw3J7Dy6NRybCGQRTsfgw4Ke7veSVbnC7K/SGJ1WSXR3ffsZk/ukM4OGiV+CK0VxpDrHq78myWBxGyig7Vyalg55ciZW+B5wBxxRj079udl4ycJVpbrxIdgBnwIARr5NTVwCcLIHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KfPhAHdw; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfPhAHdw"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2c40397e746so16914955ad.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Jun 2026 01:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781512098; x=1782116898; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OIK6+R0N6S5FbjNUFVY3i/UoNEgCH6Sdv2/saOFAeXs=;
        b=KfPhAHdwMLlRR2OqFIvHcL18/J+p7d3o5Lg/so1ywbZLYPh7ydBwZ2KejWpVKe4ij+
         rg42Mg5c3urFBjZzpTjMxAwB46x9hX/Fg6nFPx60sxYdHwqJyMcwBccwCOHsDCzG+5i5
         70JV/h9yISwNaI7IlVpIqRMxl3cze5ZYHQSawirGKygNsy8/44o0oFZ4fHIRk8dPwL5s
         jfXtm9tT6+ndzmp0U65+ci6TkujWoL7dMHtanPtvbBzPUY6m2xFeCDmYxoTPccX4tSMR
         MiE4PpePYPPLAvFR7mRb1iqbT5C8borbTES6G+0+YE5wNVD1ajfm8dt5i2Qvie3mW+Lb
         xRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781512098; x=1782116898;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OIK6+R0N6S5FbjNUFVY3i/UoNEgCH6Sdv2/saOFAeXs=;
        b=B8UwhQWsUExmrSH1Zy51T+0g/RWJO/jmrehxxluMdhiGm+XR0kJc480aYH2omlhKHz
         sbvMkoK8+84pDZzRN4hJA7RJkLxgYIoe4IDJMqJGQIG2fwScqvykeEXjLQftgPqcsDuH
         DF9F6apy6lVJC8WS1Z68GHqUazWVSGc8AvLpu+Mn7V4rIpnfrZjIciiguYXxAVb5O9EE
         vXcbarlzxDObmMUp9RzZnbgXD5B4WQuV5Y/UW1WFHzHPVQNC82gazHdDlG/+eYIhlO2S
         tccHU0nTHbIVkXO7grnCi0lTnc6JwPEu+ekAMljy24yvrZJ3Cyg32qlZ8qLQVd4VX1hj
         cRwA==
X-Forwarded-Encrypted: i=1; AFNElJ9UHCj4Sq2WSukw1qiAPQ9KvS2R4L+j5VLAYAX0T0J56J/OPxl5ICdSVitiYCcv7VN1RhEDHw3YVWd5xc4r6dgFX8I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk/ncGW3PlUQ9HDkKsWOOqy4uiPa4FoSjCoH4XferY5MZa62YJ
	YNk5VHT2+KeFMWAuocBzzxPyPcVEsQRJMcKHSanHF4OCi/4tLmoqwFj7
X-Gm-Gg: Acq92OEyy/1kDPIKKB6l3CK1XmJi4nTgCYAXhgYpxO34/A/4v2C2F+k7CxEMSiiJV8F
	HV75PzucPcv4VcV4q7Ki54Hj6zaOS9oSeAkoNzgiTiU8YECvA8FfE6SE0VXv55aQjsyS3RUhtSh
	wJhMl0kfJfTo91orm41IQvwOAbg5BSkmvz66/uTOEXgasTv9isOW3ghfrbAZ00W+v7KBIXpxRWZ
	POUCu0X6MD94u5EKUTPpdTWT9Zy7p0VhSwHDCM1GvCY5gFHk2l+EoLz+uP6BxqfJkNA4pYxjfO1
	aatsW9lfQ2Vwy7qqImwZR+e475d3T8sHd3hFgU42tfVP5K3zXSM/5ke5yViJ+60h83cQ499jiYa
	kqknPhrpJLGTUs0S1OeQZSHJA3fHrPTYTpCsIkCATIVWVSRh9OSIxbeIgG7hWc76crE5BTkEaoD
	8BQWaNbvmrvMudkXL/BAjETWFp8HbUCTE=
X-Received: by 2002:a17:903:2408:b0:2bf:1cda:29ce with SMTP id d9443c01a7336-2c4104117eamr138814175ad.6.1781512097656;
        Mon, 15 Jun 2026 01:28:17 -0700 (PDT)
Received: from [10.125.112.20] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f2e52b5sm94136475ad.7.2026.06.15.01.28.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 01:28:16 -0700 (PDT)
Message-ID: <5d3d16f6-0654-483b-9625-94ab93d3d836@gmail.com>
Date: Mon, 15 Jun 2026 16:28:07 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] mm/compaction: honour compact_unevictable_allowed
 in mlock race and alloc_contig path
From: Wandun <chenwandun1@gmail.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 vbabka@kernel.org, bigeasy@linutronix.de, rostedt@goodmis.org,
 hughd@google.com
Cc: akpm@linux-foundation.org, surenb@google.com, mhocko@suse.com,
 jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, david@kernel.org,
 ljs@kernel.org, liam@infradead.org, rppt@kernel.org, clrkwllms@kernel.org,
 Alexander.Krabler@kuka.com
References: <20260604023812.3700316-1-chenwandun1@gmail.com>
Content-Language: en-US
In-Reply-To: <20260604023812.3700316-1-chenwandun1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/4/26 10:38, Wandun Chen wrote:
> From: Wandun Chen <chenwandun@lixiang.com>
> 
> vm.compact_unevictable_allowed=0 is meant to keep compaction from
> touching unevictable folios. In practice there are still two paths
> where it does not take effect. This series fixes them and adds a
> tracepoint to make such issues easier to diagnose in the future.

Gentle ping, any feedback on this series?

Sashiko found a potential compilation error in patch2, I'll address
that along with any review comments in v2.

Best regards,
Wandun

> 
> Wandun Chen (3):
>   mm/compaction: skip isolate mlocked folios when
>     compact_unevictable_allowed=0
>   mm/compaction: add per-folio isolation tracepoint
>   mm/compaction: respect compact_unevictable_allowed in alloc_contig
>     path
> 
>  include/linux/compaction.h        |  6 ++++++
>  include/trace/events/compaction.h | 26 ++++++++++++++++++++++++++
>  mm/compaction.c                   | 14 +++++++++++---
>  mm/internal.h                     |  1 +
>  mm/page_alloc.c                   |  2 ++
>  5 files changed, 46 insertions(+), 3 deletions(-)
> 

