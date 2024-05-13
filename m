Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302291C6AF;
	Mon, 13 May 2024 03:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715570772; cv=none; b=kFCFT3ecS/n/iptPFpHC+JytFGMwnUpwfiMSy1+3CCeIci/eYzLpAZM3X8CfM5a2Ze8O1d+pKtAe6ey0pP559cFqZY754uoTflXsU1dp1fJsRJJL0Fx22LQN248jN0UbXBkDlTsD7x2eU4GYEw3ZlJB7QYac+nZBCbey888HfYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715570772; c=relaxed/simple;
	bh=WJOoQomm8SXfTN6sfPBVf9l1CpvTu8SVl1505d7YD1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sp89FVXFxqcCvTQMBrsBacYHbzMGE8g5MtQI2KDA/97fs+mtgJyo8ZXOpUsD7FWfyQYq2a1CejU/O3qu65eVHeWtlePrm3luK8HhMM7ny0B4K286yosNN8urSP7OPAcex3tNaESAj6/a9bFxcJl65JHF1jqddcI6K9DeOTP4BQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZkBxs0GF; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZkBxs0GF"
Message-ID: <b574c8d6-c000-8673-74de-a7cc092057ad@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715570766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R5SPCLBdMmPm9x+0WvDC9Xwe8BqG9DYDcZU8TqCuQFw=;
	b=ZkBxs0GF88gg721lGUEhujUhTssE2xljMxlpWlVTdoeRomLgnIgifTBddf4mc6DuyqcUDB
	LOhi94bqMxOnb2OA5/PtUVjM/iztYySR78IR7C3rFABwA6sd+POCa+u0xajGu/A4M76c/8
	eu91iM4uS1OcVYb0mm0pei+nbr0ZgN8=
Date: Mon, 13 May 2024 11:25:38 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] eventfs: Directly return NULL to avoid null point
 dereferenced
To: Markus Elfring <Markus.Elfring@web.de>, Hao Ge <gehao@kylinos.cn>,
 linux-trace-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240511024255.34767-1-hao.ge@linux.dev>
 <34c7ffeb-1fe9-4e89-a7b6-c6a8be17df90@web.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <34c7ffeb-1fe9-4e89-a7b6-c6a8be17df90@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Markus


Thanks for your review.


在 5/13/24 01:12, Markus Elfring 写道:
>> When the condition ei->is_free holds,we return NULL directly to
>> avoid update_events_attr to use NULL point about ei.
> * Please avoid typos in the summary phrase and the commit message.
>
> * Would you like to use an imperative wording for an improved change description?
>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.9-rc7#n94
>
>
> …
OK, I'll study it,
>> +++ b/fs/tracefs/event_inode.c
>> @@ -346,8 +346,7 @@ static struct eventfs_inode *eventfs_find_events(struct dentry *dentry)
>>   		 * doesn't matter.
>>   		 */
>>   		if (ei->is_freed) {
>> -			ei = NULL;
>> -			break;
>> +			return NULL;
>>   		}
> …
>
> How do you think about to omit curly brackets here?
You are right, I will make changes to it in future versions
>
> Regards,
> Markus

Best Regards

Hao

