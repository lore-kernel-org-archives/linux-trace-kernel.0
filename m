Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAED3E0C67;
	Tue, 28 Jul 2026 08:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785229046; cv=none; b=lM6GdikBtQ4/pf+TmOJYRlgvj3uf0UXk78r2GGzzGR/XSKGQ4WgHMp/mmNPUONY6jA1nbFm+Fllcb6d27d7fl6qBC7Dw899WBhes1WOz8VS1tLf0Cn6SEURA9Ig5vrARLT8l4NpfRr2rxKUexJcaFZZN7K5kWYj1SmP3WnlpIuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785229046; c=relaxed/simple;
	bh=uK9Rg8fepHenBJNqcbxS3Ny7BRXXm2BtgSEzKmEfR4o=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=R8Qe27tdS+kILzkVDutImtGqoohit+08a+nMtpYTC8uEwMtHn3tDZw4YbMTcs5Otas7+9AvD/4lHQ+2PvHO/Qal2YzYAx8Xz3LnSAqhBdIR2B3ruTHneuXCbJ6KvoGEY1UCXFTwS08tdCn5skXFtE8nYT9QqyF03/gjsY3mcFJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=6h9ohDYR; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="6h9ohDYR"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=2E0wmH0tw98SLcgF2VrOb2d3npZ2qjaYNZ4aVITL8K0=;
	b=6h9ohDYRMrUc1iZIqmFylHx8eQ2pzOoLgSdu5w0Q+mz9toUgzOXOB8R3e81a/J2oHXHzRmgIA
	uEO1JwEBJzergX7yD0qLx6sqjHn+HcQfWC+gOTna8W1nsQBWpL5rzwq5mvJjAc61S1Wl4Lq2uGp
	ZCVYWBGG5e03jA2iqyIapM8=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4h8Tcf43tzz1T4Fq;
	Tue, 28 Jul 2026 16:47:46 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 9E189202E6;
	Tue, 28 Jul 2026 16:57:15 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 28 Jul 2026 16:57:15 +0800
Received: from [10.173.124.160] (10.173.124.160) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 28 Jul 2026 16:57:14 +0800
Subject: Re: [PATCH v10 6/6] selftests/mm: add hwpoison-panic destructive test
To: Andrew Morton <akpm@linux-foundation.org>, Breno Leitao
	<leitao@debian.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <kernel-team@meta.com>, "David
 Hildenbrand" <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, "Vlastimil
 Babka" <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, "Suren
 Baghdasaryan" <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Shuah Khan
	<shuah@kernel.org>, Naoya Horiguchi <nao.horiguchi@gmail.com>, "Jonathan
 Corbet" <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, "Liam R.
 Howlett" <liam@infradead.org>, <lance.yang@linux.dev>, Steven Rostedt
	<rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>
References: <20260630-ecc_panic-v10-0-c6ed5b62eea2@debian.org>
 <20260630-ecc_panic-v10-6-c6ed5b62eea2@debian.org>
 <ee4982bf-ff45-8f0b-3b76-7ca19228f12b@huawei.com>
 <20260727212402.09baa9381ca426273fad4719@linux-foundation.org>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <de29c5cc-3637-cd18-354d-55ceb3d60afd@huawei.com>
Date: Tue, 28 Jul 2026 16:57:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260727212402.09baa9381ca426273fad4719@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2026/7/28 12:24, Andrew Morton wrote:
> On Thu, 9 Jul 2026 11:34:05 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
>>> The script is intentionally NOT wired into run_vmtests.sh: every
>>> successful run panics the kernel, which is incompatible with the
>>> sequential "run each category in the same VM" model that
>>> run_vmtests.sh assumes.  It is also not registered as a TEST_PROGS /
>>> ksft_* wrapper so a default kselftest run does not opt itself into
>>> a panic.  The script is meant to be executed manually inside a
>>> disposable VM (e.g. virtme-ng), one variant per VM boot, and
>>> requires RUN_DESTRUCTIVE=1 in the environment as a safety net.
>>>
>>> Signed-off-by: Breno Leitao <leitao@debian.org>
>>
>> With Mike's comment addressed:
>>
>> Acked-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> As I understand it, Breno would prefer not to rewrite the selftest in C
> at this time.  IOW, we stick with the bash version for now and add
> "convert this to C" to the todo list, OK?

Sure. Should I make this change or should we wait until Breno has time to do it?

Thanks.
.
