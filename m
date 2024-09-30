Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E115B14386D;
	Mon, 30 Sep 2024 07:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727680635; cv=none; b=ZMpCQandCoDAxdhjqLqkqUF4p+rHcmMYcs1KSUpjSLFfuEaRu0Gy299DFQwl8Qh0E7FG1bJlw+esvcv0WRa3tKPL8yNtxufb04MBn0Q5KxytbbjqwXKnLWfZHCFdFbLAxCpVYEvBEK3NJNY5hdV4vt+agVaAeb4ZjxsYm7LCFSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727680635; c=relaxed/simple;
	bh=Ilbs7GeFlEkL8CUsH8ocnHgHsUBtWQFL2zDS/ykAZ2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sG/FNjVUQ1gOsr5ayx5GM4/nMHG7AwGRVW8qfpi02bgHUJCFuRtgm50KBVOJKh0iz8zl//5n4kCPadV4LJR9tapK7Up8QOTD2pavJ0IG19QWIgpyJpbcqzbaqkXBqRpYVw6unPukAI/f7fhG7Gy4TtSQzHfcdquG/N/13dj16to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XHC7X4d1gz1ymhl;
	Mon, 30 Sep 2024 15:17:12 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 0867D1400CB;
	Mon, 30 Sep 2024 15:17:10 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 30 Sep 2024 15:17:09 +0800
Message-ID: <c566bff1-b209-9660-2837-9d3b8fca3fb6@huawei.com>
Date: Mon, 30 Sep 2024 15:16:59 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] function_graph: Simplify the initialization of fgraph LRU
 data
To: Steven Rostedt <rostedt@goodmis.org>
CC: <mhiramat@kernel.org>, <mark.rutland@arm.com>,
	<mathieu.desnoyers@efficios.com>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>
References: <20240912111550.1752115-1-liaochang1@huawei.com>
 <20240927201755.6402ed04@rorschach.local.home>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <20240927201755.6402ed04@rorschach.local.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd200013.china.huawei.com (7.221.188.133)



在 2024/9/28 8:17, Steven Rostedt 写道:
> On Thu, 12 Sep 2024 11:15:50 +0000
> Liao Chang <liaochang1@huawei.com> wrote:
> 
>> This patch uses [first ... last] = value to initialize fgraph_array[].
>> And it declares all the callbacks in fgraph_stub as static, as they are
>> not called from external code.
> 
> This patch doesn't look like a simplification, and it is incorrect
> about the "not called from external code" as the kernel test robot
> pointed out!

Yes, I overlooked the external call, the static keyword is removed
in the next revision. The patch just makes code neat, it isn't a real
simplification.

> 
> -- Steve
> 

-- 
BR
Liao, Chang
